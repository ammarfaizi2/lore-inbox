Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271203AbTHHKyF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 06:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271206AbTHHKyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 06:54:05 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:21258 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S271203AbTHHKyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 06:54:00 -0400
Date: Fri, 8 Aug 2003 20:53:21 +1000
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4: Fix steal_locks race
Message-ID: <20030808105321.GA5096@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

The steal_locks() call in binfmt_elf.c is buggy.  It steals locks from
a files entry whose reference was dropped much earlier.  This allows it
to steal other process's locks.

The following patch calls steal_locks() earlier so that this does not
happen.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

--- kernel-source-2.4/fs/binfmt_elf.c.orig	2003-08-08 20:46:56.000000000 +1000
+++ kernel-source-2.4/fs/binfmt_elf.c	2003-08-08 20:47:05.000000000 +1000
@@ -480,6 +480,7 @@
 	files = current->files;		/* Refcounted so ok */
 	if(unshare_files() < 0)
 		goto out_free_ph;
+	steal_locks(files, current->files);
 
 	/* exec will make our files private anyway, but for the a.out
 	   loader stuff we need to do it earlier */
@@ -797,7 +798,6 @@
 	if (current->ptrace & PT_PTRACED)
 		send_sig(SIGTRAP, current, 0);
 	retval = 0;
-	steal_locks(files, current->files);
 out:
 	return retval;
 
@@ -813,6 +813,7 @@
 out_free_fh:
 	ftmp = current->files;
 	current->files = files;
+	steal_locks(ftmp, current->files);
 	put_files_struct(ftmp);
 out_free_ph:
 	kfree(elf_phdata);

--3MwIy2ne0vdjdPXF--
