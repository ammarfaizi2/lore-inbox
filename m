Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315717AbSHNUZc>; Wed, 14 Aug 2002 16:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315720AbSHNUZc>; Wed, 14 Aug 2002 16:25:32 -0400
Received: from csl2.consultronics.on.ca ([204.138.93.2]:36319 "EHLO
	csl2.consultronics.on.ca") by vger.kernel.org with ESMTP
	id <S315717AbSHNUZb>; Wed, 14 Aug 2002 16:25:31 -0400
Date: Wed, 14 Aug 2002 16:29:24 -0400
From: Greg Louis <glouis@dynamicro.on.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre2-ac1
Message-Id: <20020814162924.6a4203ef.glouis@dynamicro.on.ca>
In-Reply-To: <1029346932.2045.128.camel@spc9.esa.lanl.gov>
References: <200208141634.g7EGYGO29387@devserv.devel.redhat.com>
	<1029346932.2045.128.camel@spc9.esa.lanl.gov>
Organization: Dynamicro Consulting Limited
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i686)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Aug 2002 11:42:11 -0600,
 Steven Cole <elenstev@mesatop.com> wrote:

> On Wed, 2002-08-14 at 10:34, Alan Cox wrote:
> 
> > 
> > Linux 2.4.20-pre2-ac1
> 
> With CONFIG_NFSD=y I got this:
> 
> fs/fs.o: In function `nfsd':
> fs/fs.o(.text+0x43fb1): undefined reference to `exp_readunlock'
> fs/fs.o: In function `sys_nfsservctl':
> fs/fs.o(.text+0x445e8): undefined reference to `exp_readunlock'
> fs/fs.o(.text+0x44692): undefined reference to `exp_readunlock'
> fs/fs.o(.data+0x261c): undefined reference to `exp_readunlock'
> make: *** [vmlinux] Error 1
> 
This looks as though it ought to work (though I'm not at all familiar
with the code), and seems to be working for me on one box where I've
run it:

--- linux-2.4.20pre2/include/linux/nfsd/export.h.orig	2002-08-14 15:44:55.000000000 -0400
+++ linux-2.4.20pre2/include/linux/nfsd/export.h	2002-08-14 15:44:55.000000000 -0400
@@ -91,7 +91,7 @@
 void			nfsd_export_init(void);
 void			nfsd_export_shutdown(void);
 void			exp_readlock(void);
-void			exp_readunlock(void);
+void			exp_unlock(void);
 struct svc_client *	exp_getclient(struct sockaddr_in *sin);
 void			exp_putclient(struct svc_client *clp);
 struct svc_export *	exp_get(struct svc_client *clp, kdev_t dev, ino_t ino);
--- linux-2.4.20pre2/fs/nfsd/lockd.c.orig	2002-08-14 15:45:50.000000000 -0400
+++ linux-2.4.20pre2/fs/nfsd/lockd.c	2002-08-14 15:45:50.000000000 -0400
@@ -62,7 +62,7 @@
 
 struct nlmsvc_binding		nfsd_nlm_ops = {
 	exp_readlock,		/* lock export table for reading */
-	exp_readunlock,		/* unlock export table */
+	exp_unlock,		/* unlock export table */
 	exp_getclient,		/* look up NFS client */
 	nlm_fopen,		/* open file for locking */
 	nlm_fclose,		/* close file */
--- linux-2.4.20pre2/fs/nfsd/nfsctl.c.orig	2002-08-14 15:46:13.000000000 -0400
+++ linux-2.4.20pre2/fs/nfsd/nfsctl.c	2002-08-14 15:46:13.000000000 -0400
@@ -123,7 +123,7 @@
 		err = -EPERM;
 	else
 		err = exp_rootfh(clp, 0, 0, data->gd_path, res, data->gd_maxlen);
-	exp_readunlock();
+	exp_unlock();
 	return err;
 }
 
@@ -146,7 +146,7 @@
 		err = -EPERM;
 	else
 		err = exp_rootfh(clp, 0, 0, data->gd_path, &fh, NFS_FHSIZE);
-	exp_readunlock();
+	exp_unlock();
 
 	if (err == 0) {
 		if (fh.fh_size > NFS_FHSIZE)
@@ -179,7 +179,7 @@
 		err = -EPERM;
 	else
 		err = exp_rootfh(clp, to_kdev_t(data->gf_dev), data->gf_ino, NULL, &fh, NFS_FHSIZE);
-	exp_readunlock();
+	exp_unlock();
 
 	if (err == 0) {
 		if (fh.fh_size > NFS_FHSIZE)
--- linux-2.4.20pre2/fs/nfsd/nfssvc.c.orig	2002-08-14 15:46:35.000000000 -0400
+++ linux-2.4.20pre2/fs/nfsd/nfssvc.c	2002-08-14 15:46:35.000000000 -0400
@@ -218,7 +218,7 @@
 		svc_process(serv, rqstp);
 
 		/* Unlock export hash tables */
-		exp_readunlock();
+		exp_unlock();
 		update_thread_usage(atomic_read(&nfsd_busy));
 		atomic_dec(&nfsd_busy);
 	}


-- 
| G r e g  L o u i s          | gpg public key:      |
|   http://www.bgl.nu/~glouis |   finger greg@bgl.nu |
