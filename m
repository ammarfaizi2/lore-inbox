Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272118AbTHIBt2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 21:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272124AbTHIBt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 21:49:28 -0400
Received: from c211-28-63-178.rivrw3.nsw.optusnet.com.au ([211.28.63.178]:59921
	"EHLO arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S272118AbTHIBsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 21:48:41 -0400
Date: Sat, 9 Aug 2003 11:48:30 +1000
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4: Restore current->files in flush_old_exec
Message-ID: <20030809014830.GA11509@gondor.apana.org.au>
References: <20030808105321.GA5096@gondor.apana.org.au> <20030809010736.GA10487@gondor.apana.org.au> <20030809011116.GB10487@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <20030809011116.GB10487@gondor.apana.org.au>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 09, 2003 at 11:11:16AM +1000, herbert wrote:
> 
> At this point, I believe the unshare_files stuff should be fine from
> a correctness point of view.  However, there is still a performance
> problem as every ELF exec call ends up dupliating the files structure
> as well as walking through all file locks.

Here is the patch that ensures files is only duplicated when necessary.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

--- kernel-source-2.4/fs/binfmt_elf.c.orig	2003-08-09 11:28:18.000000000 +1000
+++ kernel-source-2.4/fs/binfmt_elf.c	2003-08-09 11:32:13.000000000 +1000
@@ -480,6 +480,10 @@
 	files = current->files;		/* Refcounted so ok */
 	if(unshare_files() < 0)
 		goto out_free_ph;
+	if (files == current->files) {
+		put_files_struct(files);
+		files = NULL;
+	}
 
 	/* exec will make our files private anyway, but for the a.out
 	   loader stuff we need to do it earlier */
@@ -602,8 +606,10 @@
 		goto out_free_dentry;
 
 	/* Discard our unneeded old files struct */
-	steal_locks(files, current->files);
-	put_files_struct(files);
+	if (files) {
+		steal_locks(files, current->files);
+		put_files_struct(files);
+	}
 
 	/* OK, This is the point of no return */
 	current->mm->start_data = 0;
@@ -811,9 +817,11 @@
 out_free_file:
 	sys_close(elf_exec_fileno);
 out_free_fh:
-	ftmp = current->files;
-	current->files = files;
-	put_files_struct(ftmp);
+	if (files) {
+		ftmp = current->files;
+		current->files = files;
+		put_files_struct(ftmp);
+	}
 out_free_ph:
 	kfree(elf_phdata);
 	goto out;

--YZ5djTAD1cGYuMQK--
