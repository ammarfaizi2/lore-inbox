Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbUCJSOv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 13:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbUCJSEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 13:04:55 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:21701 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262730AbUCJSAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 13:00:54 -0500
Date: Wed, 10 Mar 2004 13:00:51 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Urban Widmark <urban@teststation.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Adam Sampson <azz@us-lot.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: smbfs Oops with Linux 2.6.3
In-Reply-To: <Pine.LNX.4.44.0403101244480.19728-100000@cola.local>
Message-ID: <Pine.LNX.4.58.0403101122320.29087@montezuma.fsmlabs.com>
References: <Pine.LNX.4.44.0403101244480.19728-100000@cola.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2004, Urban Widmark wrote:

> On Tue, 9 Mar 2004, Linus Torvalds wrote:
>
> > As to how something like that could happen, I have absolutely no clue. The
> > "smb_install_null_ops()" would seem to cause that, but that's all I can
> > say.
> >
> > Maybe the "smp_ops_null" thing should be filled in with stuff that always
> > returns EINVAL or something? Rather than actual NULL pointers that will
> > oops if they are ever used?

I originally didn't fill them all in intentionally, doing so may be best.

> smp_ops_null should really make all functions block and wait for the
> connection to be created and given to us from smbmount. That would make it
> behave more like smbfs in 2.4 does.
>
> I am thinking of something like this for each entry in smp_ops_null.
>
> int whatever_it_is_that_I_am(args)
> {
> 	timeleft = wait_event_interruptible_timeout(...)
> 	if (!timeleft || signal_pending(current))
> 		return -EIO;
> 	if (!server->ops->whatever_it_is_that_I_am)
> 		return -EIO;
> 	return server->ops->whatever_it_is_that_I_am(args)
> }

Thanks Urban, i have posted the following on bugzilla
(http://bugzilla.kernel.org/show_bug.cgi?id=1671) for testing. But,
it appears racy wrt getattr and win9x servers.

Index: linux-2.6.4-rc3/fs/smbfs/proc.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.4-rc3/fs/smbfs/proc.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 proc.c
--- linux-2.6.4-rc3/fs/smbfs/proc.c	10 Mar 2004 01:05:32 -0000	1.1.1.1
+++ linux-2.6.4-rc3/fs/smbfs/proc.c	10 Mar 2004 17:16:22 -0000
@@ -56,6 +56,7 @@ static struct smb_ops smb_ops_os2;
 static struct smb_ops smb_ops_win95;
 static struct smb_ops smb_ops_winNT;
 static struct smb_ops smb_ops_unix;
+static struct smb_ops smb_ops_null;

 static void
 smb_init_dirent(struct smb_sb_info *server, struct smb_fattr *fattr);
@@ -2794,10 +2795,46 @@ out:
 }

 static int
+smb_proc_ops_wait(struct smb_sb_info *server)
+{
+	int result;
+	DECLARE_WAIT_QUEUE_HEAD(wq);
+
+	result = wait_event_interruptible_timeout(wq,
+			server->ops != &smb_ops_null, 5*HZ);
+
+	if (!result || signal_pending(current))
+		return -EIO;
+
+	return 0;
+}
+
+static int
 smb_proc_getattr_null(struct smb_sb_info *server, struct dentry *dir,
-		      struct smb_fattr *attr)
+			  struct smb_fattr *fattr)
 {
-	return -EIO;
+	int result;
+
+	if (smb_proc_ops_wait(server) < 0)
+		return -EIO;
+
+	smb_init_dirent(server, fattr);
+	result = server->ops->getattr(server, dir, fattr);
+	smb_finish_dirent(server, fattr);
+
+	return result;
+}
+
+static int
+smb_proc_readdir_null(struct file *filp, void *dirent, filldir_t filldir,
+		      struct smb_cache_control *ctl)
+{
+	struct smb_sb_info *server = server_from_dentry(filp->f_dentry);
+
+	if (smb_proc_ops_wait(server) < 0)
+		return -EIO;
+
+	return server->ops->readdir(filp, dirent, filldir, ctl);
 }

 int
@@ -3431,6 +3467,7 @@ static struct smb_ops smb_ops_unix =
 /* Place holder until real ops are in place */
 static struct smb_ops smb_ops_null =
 {
+	.readdir	= smb_proc_readdir_null,
 	.getattr	= smb_proc_getattr_null,
 };

