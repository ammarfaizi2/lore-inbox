Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272216AbTHIBME (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 21:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272166AbTHIBJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 21:09:43 -0400
Received: from c211-28-63-178.rivrw3.nsw.optusnet.com.au ([211.28.63.178]:45841
	"EHLO arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S272241AbTHIBH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 21:07:56 -0400
Date: Sat, 9 Aug 2003 11:07:36 +1000
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4: Fix steal_locks race
Message-ID: <20030809010736.GA10487@gondor.apana.org.au>
References: <20030808105321.GA5096@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <20030808105321.GA5096@gondor.apana.org.au>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 08, 2003 at 08:53:21PM +1000, herbert wrote:
> 
> The steal_locks() call in binfmt_elf.c is buggy.  It steals locks from
> a files entry whose reference was dropped much earlier.  This allows it
> to steal other process's locks.
> 
> The following patch calls steal_locks() earlier so that this does not
> happen.

My patch is buggy too.  If a file is closed by another clone between
the two steal_locks calls the lock will again be lost.  Fortunately
this much harder to trigger than the previous bug.

The following patch fixes that.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

--- kernel-source-2.4/fs/binfmt_elf.c.orig	2003-08-09 10:43:56.000000000 +1000
+++ kernel-source-2.4/fs/binfmt_elf.c	2003-08-09 10:57:29.000000000 +1000
@@ -480,7 +480,6 @@
 	files = current->files;		/* Refcounted so ok */
 	if(unshare_files() < 0)
 		goto out_free_ph;
-	steal_locks(files, current->files);
 
 	/* exec will make our files private anyway, but for the a.out
 	   loader stuff we need to do it earlier */
@@ -603,6 +602,7 @@
 		goto out_free_dentry;
 
 	/* Discard our unneeded old files struct */
+	steal_locks(files, current->files);
 	put_files_struct(files);
 
 	/* OK, This is the point of no return */
@@ -813,7 +813,6 @@
 out_free_fh:
 	ftmp = current->files;
 	current->files = files;
-	steal_locks(ftmp, current->files);
 	put_files_struct(ftmp);
 out_free_ph:
 	kfree(elf_phdata);

--ZGiS0Q5IWpPtfppv--
