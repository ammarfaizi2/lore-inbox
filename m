Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030345AbWGJOHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbWGJOHn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 10:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030383AbWGJOHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 10:07:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:36810 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030345AbWGJOHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 10:07:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UUH16MYC2sDjnnzoNFgz+spfsezLAtWZV53bGpJbZKC7xF/kZWWgAEaR/VCBHu01KPrLI7jm8LjAT82BlflCFq6JLkTeEHBG4fui5FtqiIuj6rZkLCJKzgtDSE8DHtrSp8T9ReUldl98G73t1YTnWkYqCfOw8Xagb4o92Jr3GOI=
Message-ID: <9e4733910607100707g4810a86boa93a5b6b0b1a8d0a@mail.gmail.com>
Date: Mon, 10 Jul 2006 10:07:41 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Clean up old names in tty code to current names
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Greg KH" <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <1152539034.27368.124.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e4733910607092111i4c41c610u8b9df5b917cca02c@mail.gmail.com>
	 <1152524657.27368.108.camel@localhost.localdomain>
	 <9e4733910607100541i744dd744n16c35c50dae1e98d@mail.gmail.com>
	 <1152537049.27368.119.camel@localhost.localdomain>
	 <9e4733910607100603r5ae1a21ex1a2fa0f045424fd1@mail.gmail.com>
	 <1152539034.27368.124.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Llu, 2006-07-10 am 09:03 -0400, ysgrifennodd Jon Smirl:
> > I agree with this. I made a mistake with the pts vs pty, why not just
> > help me fix the mistake instead of rejecting everything? Some the of
> > the info being reported in /proc/tty/drivers is wrong (vc./0 - from
> > the devfs attempt?). or missing.
>
> What are you trying to achieve and where are you trying to get. If you
> want better info for the tty layer then get the new info working in
> sysfs first. Then when people are generally using sysfs you can worry
> about cleaning up/removing/breaking the old stuff.
>

Before the change /proc/tty/drivers shows this:

[jonsmirl@jonsmirl ~]$ cat /proc/tty/drivers
/dev/tty             /dev/tty        5       0 system:/dev/tty
/dev/console         /dev/console    5       1 system:console
/dev/ptmx            /dev/ptmx       5       2 system
/dev/vc/0            /dev/vc/0       4       0 system:vtmaster
serial               /dev/ttyS       4 64-67 serial
pty_slave            /dev/pts      136 0-1048575 pty:slave
pty_master           /dev/ptm      128 0-1048575 pty:master
unknown              /dev/tty        4 1-63 console

I changed it to this which better reflects my system.

[jonsmirl@jonsmirl ~]$ cat /proc/tty/drivers
/dev/tty             /dev/tty        5       0 system:/dev/tty
/dev/console         /dev/console    5       1 system:console
/dev/ptmx            /dev/ptmx       5       2 system:/dev/ptmx
/dev/tty0            /dev/tty0       4       0 system:vtmaster
serial               /dev/ttyS       4 64-67 serial
pty_slave            /dev/pts      136 0-1048575 pty:slave
pty_master           /dev/ptm      128 0-1048575 pty:master
vtconsole            /dev/tty        4 1-63 vt:console

Nothing in that patch has anything to do with udev support. It is just
trying to make things match my current devices. When we got rid of
devfs /dev/vc/0 became /dev/tty0.

The ttyp change was a mistake. The patch below removes that error. Is
there anything else wrong with it? That's why we have patch reviews,
to catch dumb errors like that.

> > I'm not going to solve this problem but it is something that needs to
> > be discussed. Are we really going to maintain parallel naming schemes,
> > one in-kernel and one out of kernel? I'm not even sure if USB will
> > work without udev anymore.
>
> It works fine, it would not suprise me if udev users were still the
> minority case in fact.

If I use udev to rename my devices, the names aren't going to match
/proc/tty and what ps shows. The idea behind udev is that the kernel
only deals in device numbers and all naming happens in user space.

-- 
Jon Smirl
jonsmirl@gmail.com

diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index bfdb902..4a83e94 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -3245,7 +3245,7 @@ #endif
  #ifdef CONFIG_VT
 	cdev_init(&vc0_cdev, &console_fops);
  	if (cdev_add(&vc0_cdev, MKDEV(TTY_MAJOR, 0), 1) ||
-	    register_chrdev_region(MKDEV(TTY_MAJOR, 0), 1, "/dev/vc/0") < 0)
+	    register_chrdev_region(MKDEV(TTY_MAJOR, 0), 1, "/dev/tty0") < 0)
  		panic("Couldn't register /dev/tty0 driver\n");
  	class_device_create(tty_class, NULL, MKDEV(TTY_MAJOR, 0), NULL, "tty0");

diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index da7e66a..a627e8b 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -2662,6 +2662,7 @@ int __init vty_init(void)
 	if (!console_driver)
 		panic("Couldn't allocate console driver\n");
 	console_driver->owner = THIS_MODULE;
+	console_driver->driver_name = "vtconsole";
  	console_driver->name = "tty";
 	console_driver->name_base = 1;
 	console_driver->major = TTY_MAJOR;
diff --git a/fs/proc/proc_tty.c b/fs/proc/proc_tty.c
index 15c4455..042aefe 100644
--- a/fs/proc/proc_tty.c
+++ b/fs/proc/proc_tty.c
@@ -48,7 +48,7 @@ static void show_tty_range(struct seq_fi
  			seq_printf(m, ":vtmaster");
 		break;
 	case TTY_DRIVER_TYPE_CONSOLE:
-		seq_printf(m, "console");
+		seq_printf(m, "vt:console");
 		break;
 	case TTY_DRIVER_TYPE_SERIAL:
 		seq_printf(m, "serial");
@@ -84,10 +84,10 @@ static int show_tty_driver(struct seq_fi
  #ifdef CONFIG_UNIX98_PTYS
  		seq_printf(m, "%-20s /dev/%-8s ", "/dev/ptmx", "ptmx");
 		seq_printf(m, "%3d %7d ", TTYAUX_MAJOR, 2);
-		seq_printf(m, "system\n");
+		seq_printf(m, "system:/dev/ptmx\n");
  #endif
  #ifdef CONFIG_VT
-		seq_printf(m, "%-20s /dev/%-8s ", "/dev/vc/0", "vc/0");
+		seq_printf(m, "%-20s /dev/%-8s ", "/dev/tty0", "tty0");
 		seq_printf(m, "%3d %7d ", TTY_MAJOR, 0);
  		seq_printf(m, "system:vtmaster\n");
  #endif
