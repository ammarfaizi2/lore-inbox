Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272264AbTHIBQQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 21:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272260AbTHIBM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 21:12:29 -0400
Received: from c211-28-63-178.rivrw3.nsw.optusnet.com.au ([211.28.63.178]:48145
	"EHLO arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S272247AbTHIBLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 21:11:25 -0400
Date: Sat, 9 Aug 2003 11:11:16 +1000
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4: Restore current->files in flush_old_exec
Message-ID: <20030809011116.GB10487@gondor.apana.org.au>
References: <20030808105321.GA5096@gondor.apana.org.au> <20030809010736.GA10487@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
In-Reply-To: <20030809010736.GA10487@gondor.apana.org.au>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

The unshare_files patch to flush_old_exec() did not restore the original
state when exec_mmap fails.  This patch fixes that.

At this point, I believe the unshare_files stuff should be fine from
a correctness point of view.  However, there is still a performance
problem as every ELF exec call ends up dupliating the files structure
as well as walking through all file locks.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=q

Index: kernel-source-2.4/fs/exec.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/fs/exec.c,v
retrieving revision 1.5
diff -u -r1.5 exec.c
--- kernel-source-2.4/fs/exec.c	26 Jul 2003 02:54:45 -0000	1.5
+++ kernel-source-2.4/fs/exec.c	9 Aug 2003 01:00:28 -0000
@@ -557,7 +557,7 @@
 	char * name;
 	int i, ch, retval;
 	struct signal_struct * oldsig;
-	struct files_struct * files;
+	struct files_struct *files, *ftmp;
 
 	/*
 	 * Make sure we have a private signal table
@@ -576,8 +576,6 @@
 	retval = unshare_files();
 	if(retval)
 		goto flush_failed;
-	steal_locks(files, current->files);
-	put_files_struct(files);
 	
 	/* 
 	 * Release all of the old mmap stuff
@@ -586,6 +584,8 @@
 	if (retval) goto mmap_failed;
 
 	/* This is the point of no return */
+	steal_locks(files, current->files);
+	put_files_struct(files);
 	release_old_signals(oldsig);
 
 	current->sas_ss_sp = current->sas_ss_size = 0;
@@ -623,6 +623,9 @@
 	return 0;
 
 mmap_failed:
+	ftmp = current->files;
+	current->files = files;
+	put_files_struct(ftmp);
 flush_failed:
 	spin_lock_irq(&current->sigmask_lock);
 	if (current->sig != oldsig) {

--PmA2V3Z32TCmWXqI--
