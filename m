Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbULaWHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbULaWHX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 17:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbULaWHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 17:07:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52374 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262157AbULaWHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 17:07:14 -0500
Date: Fri, 31 Dec 2004 14:07:13 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: "Joseph D. Wagner" <technojoecoolusa@charter.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.10 Can't Open Initial Console on FC3
Message-ID: <20041231140713.562f5f7a@lembas.zaitcev.lan>
In-Reply-To: <mailman.1104479591.3634.linux-kernel2news@redhat.com>
References: <mailman.1104479591.3634.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Dec 2004 00:31:38 -0600, "Joseph D. Wagner" <technojoecoolusa@charter.net> wrote:

> The newly compiled kernel gets through everything OK including mounting
> the root file system as read-only EXT3.  However, it freezes on the very
> last line, which says:
> 
>      Warning: unable to open an initial console

> I feel like an idiot for posting this.  I'm probably missing something obvious.

Man, I know the feeling. It's rather annoying that the message does not
tell what is happening, not even the errno. I was thinking about having
the attached patch submitted, but I don't know if it's worth it.

In case of FC3, the most common problem is that udev somehow fails to start.
I do not know what the precise mechanics of it, because /dev/console
exists in initrd images, but with all the crazy root pivoting it's
no wonder it's ineffective. Anyhow, if udev quits, open in the init/main.c
will fail with ENOENT.

The only solution I know is to do everything over again, and make sure
you copied right configuration from /boot/config-2.6.9-1.678_FC3, and that
your mkinitrd run created a sensible initrd image. Verify that udev runs
and if not, debug that.

-- Pete

diff -urp -X dontdiff linux-2.6.10-rc2-bk8/init/main.c linux-2.6.10-rc2-bk8-usb/init/main.c
--- linux-2.6.10-rc2-bk8/init/main.c	2004-11-16 17:03:37.000000000 -0800
+++ linux-2.6.10-rc2-bk8-usb/init/main.c	2004-11-27 14:04:06.000000000 -0800
@@ -691,6 +691,8 @@ static inline void fixup_cpu_present_map
 
 static int init(void * unused)
 {
+	int rc;
+
 	lock_kernel();
 	/*
 	 * Tell the world that we're going to be the grim
@@ -738,8 +740,8 @@ static int init(void * unused)
 	system_state = SYSTEM_RUNNING;
 	numa_default_policy();
 
-	if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
-		printk("Warning: unable to open an initial console.\n");
+	if ((rc = sys_open((const char __user *) "/dev/console", O_RDWR, 0)) < 0)
+		printk("Warning: unable to open an initial console (%d).\n", rc);
 
 	(void) sys_dup(0);
 	(void) sys_dup(0);
