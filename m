Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285073AbSBRT5T>; Mon, 18 Feb 2002 14:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284305AbSBRT5B>; Mon, 18 Feb 2002 14:57:01 -0500
Received: from M571P006.dipool.highway.telekom.at ([62.46.61.70]:17120 "HELO
	justp.at") by vger.kernel.org with SMTP id <S286935AbSBRT4i>;
	Mon, 18 Feb 2002 14:56:38 -0500
Subject: Re: khubd zombie
From: Patrik Weiskircher <me@justp.at>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020218181417.GA19992@kroah.com>
In-Reply-To: <1014039193.523.42.camel@dev1lap> 
	<20020218181417.GA19992@kroah.com>
Content-Type: multipart/mixed; boundary="=-Hcz/yT1OZY/LT5DY3BDX"
X-Mailer: Evolution/1.0.2 
Date: 18 Feb 2002 20:56:22 +0100
Message-Id: <1014062182.608.36.camel@pat>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Hcz/yT1OZY/LT5DY3BDX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2002-02-18 at 19:14, Greg KH wrote:
> On Mon, Feb 18, 2002 at 02:33:13PM +0100, Patrik Weiskircher wrote:
> > killall khubd results to:
> > 10 ?        Z      0:00 [khubd <defunct>]
> > 
> > is this ok?
> > if not, how can i solve this?
> 
> What kernel version is this?
> And why are you trying to kill khubd from userspace?  Unloading the
> usbcore module will do the same thing.
> 
> thanks,
> 
> greg k-h

I tried it with 2.4.5, 2.4.12, 2.4.17.
And I have to kill everything except init.
I need a "clean" system.

Anyway, I don't think that it should behave like that.
Killing something from userspace should not affect the kernel, or did I
miss something?

I fixed it, it works, patch file attached.

Best Regards,
Patrik


--=-Hcz/yT1OZY/LT5DY3BDX
Content-Disposition: attachment; filename=hub.c.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; charset=ANSI_X3.4-1968

diff -Naur linux-2.4.17/drivers/usb/hub.c linux/drivers/usb/hub.c
--- linux-2.4.17/drivers/usb/hub.c	Mon Feb 18 20:43:48 2002
+++ linux/drivers/usb/hub.c	Mon Feb 18 20:38:50 2002
@@ -826,6 +826,8 @@
=20
 static int usb_hub_thread(void *__hub)
 {
+	struct task_struct *tsk =3D current;
+
 	lock_kernel();
=20
 	/*
@@ -835,6 +837,13 @@
=20
 	daemonize();
=20
+	/* avoid getting signals */
+	spin_lock_irq(&tsk->sigmask_lock);
+	flush_signals(tsk);
+	sigfillset(&tsk->blocked);
+	recalc_sigpending(tsk);
+	spin_unlock_irq(&tsk->sigmask_lock);
+
 	/* Setup a nice name */
 	strcpy(current->comm, "khubd");
=20
@@ -879,7 +888,7 @@
 	}
=20
 	pid =3D kernel_thread(usb_hub_thread, NULL,
-		CLONE_FS | CLONE_FILES | CLONE_SIGHAND);
+		CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
 	if (pid >=3D 0) {
 		khubd_pid =3D pid;
=20

--=-Hcz/yT1OZY/LT5DY3BDX--

