Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271204AbTG1Xfu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 19:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271199AbTG1Xfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 19:35:50 -0400
Received: from smtp2.att.ne.jp ([165.76.15.138]:18613 "EHLO smtp2.att.ne.jp")
	by vger.kernel.org with ESMTP id S271204AbTG1Xfd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 19:35:33 -0400
Message-ID: <21d001c35560$efd17990$4fee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test1:  incorrect solution to blank screen, no solution to modules
Date: Tue, 29 Jul 2003 08:34:32 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I cannot keep up with the list.  Advice or questions, personal mail please.

1.  On Charles Lepple's suggestion, I tried deleting boot parameter
"vga=788".  The screen no longer goes blank.  Following is part of
/boot/grub/menu.lst.  The original linux was 2.4.19 from SuSE 8.1 with
slight modifications, and it still works.  The second option still blackens
the screen when booting.  The third option now yields usable text consoles
and usable X console.  The first option now has its mouse driver screwed up
because some interaction between 2.6.0-test1 and SuSE changed some files
that also affect 2.4.19 and SuSE.  But anyway, I think that it "should not"
be necessary to delete vga=788.

title linux
   kernel (hd0,5)/vmlinuz acpi=off apm=on root=/dev/hda8 vga=788
   initrd (hd0,5)/initrd
title linux-2.6.0-test1
   kernel (hd0,5)/vmlinuz-2.6.0-test1 acpi=off apm=on root=/dev/hda8 vga=788
title linux-2.6.0-test1 without vga option
   kernel (hd0,5)/vmlinuz-2.6.0-test1 acpi=off apm=on root=/dev/hda8

2.  Modules still have big problems.  Now that the screen can be viewed
during booting, there is an error message from blogd about /dev/console and
/dev/console not differing, therefore boot logging is disabled.  Of course
that message and many others scroll off the screen and don't get logged.
One of the few that does get logged is an assertion that kernel modules are
disabled, which is a false assertion.

Here is what little gets into /var/log/messages:

Jul 29 07:38:39 diamondpana syslogd 1.4.1: restart.
Jul 29 07:38:41 diamondpana /etc/hotplug/usb.rc[472]: FATAL: Module joydev
not found.
Jul 29 07:38:44 diamondpana kernel: klogd 1.4.1, log source = /proc/kmsg
started.
Jul 29 07:38:44 diamondpana kernel: Inspecting /boot/System.map-2.6.0-test1
Jul 29 07:38:45 diamondpana kernel: Loaded 26740 symbols from
/boot/System.map-2.6.0-test1.
Jul 29 07:38:45 diamondpana kernel: Symbols match kernel version 2.6.0.
Jul 29 07:38:45 diamondpana kernel: No module symbols loaded - kernel
modules not enabled.
Jul 29 07:38:48 diamondpana SuSEfirewall2: Firewall rules successfully set
in QUICKMODE for device(s) " ppp+"
Jul 29 07:38:51 diamondpana modprobe: FATAL: Module ipv6 not found.
Jul 29 07:38:51 diamondpana sshd[669]: Server listening on 0.0.0.0 port 22.
Jul 29 07:39:01 diamondpana SuSEfirewall2: Firewall rules successfully set
in QUICKMODE for device(s) " ppp+"
Jul 29 07:39:02 diamondpana smpppd[835]: smpppd version 0.78 started
Jul 29 07:39:14 diamondpana /usr/sbin/cron[1065]: (CRON) STARTUP (fork ok)
Jul 29 07:39:22 diamondpana modprobe: FATAL: Module sr_mod not found.
Jul 29 07:39:31 diamondpana kernel: Linux video capture interface: v1.00
Jul 29 07:39:49 diamondpana kdm[1154]: pam_unix2: session started for user
ndiamond, service xdm
Jul 29 07:40:00 diamondpana /USR/SBIN/CRON[1229]: (root) CMD (
/usr/lib/sa/sa1      )
Jul 29 07:41:38 diamondpana su: (to root) ndiamond on /dev/pts/1
Jul 29 07:41:38 diamondpana su: pam_unix2: session started for user root,
service su

About a week ago, as advised, I downloaded Rusty's new modutils.  Originally
the command "rpm --rebuild" decided to compile them for an i686.  Having
already experienced non-booting kernels that were accidentally built for
i686, I wanted to build the modutils for i586, but could not find a working
rpm option.  Finally I tried building them using "make" as described in
README files but encountered problems as reported about a week ago.

This time, after 2.6.0-test1 was running and moderately usable, I tried
"rpm --rebuild" again.  This time rpm figured out to compile the modutils
for an i586.  Great!  rpm didn't install the new binaries, so I found where
it wrote the newly produced binary rpm, and used rpm -Uvh to install that
one.  It gave an error message about sensors depending on modules, so I did
an rpm -e on sensors and then rpm -Uvh installed the newly produced binary
modutils.  Great!  But...  next reboot, same old problem, the kernel says
that modules are not enabled, as quoted above.

I can run the modprobe and lsmod commands manually, but the kernel refuses
to load any modules automatically.

CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

There is other fallout too.  Even though VFAT and a few other drivers are
built into the kernel (Y) instead of being modules (M), they still don't
execute.

