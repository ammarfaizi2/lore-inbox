Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318086AbSHDPlw>; Sun, 4 Aug 2002 11:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318123AbSHDPlw>; Sun, 4 Aug 2002 11:41:52 -0400
Received: from dclient80-218-19-128.hispeed.ch ([80.218.19.128]:33476 "HELO
	lombi.mine.nu") by vger.kernel.org with SMTP id <S318086AbSHDPls>;
	Sun, 4 Aug 2002 11:41:48 -0400
Mime-Version: 1.0
Message-Id: <p04320405b972f12b6e5c@[192.168.3.11]>
Date: Sun, 4 Aug 2002 17:45:20 +0200
To: Werner Almesberger <werner.almesberger@epfl.ch>,
       Hans Lermen <lermen@fgan.de>, linux-kernel@vger.kernel.org
From: Christian Jaeger <christian.jaeger@sl.ethz.ch>
Subject: Wrong special-caseing with initrd
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Werner and Hans, dear kernel list readers

This problem seems to be known for a long time, but has not been 
solved or mentioned in the documentation bundled with the kernel. In 
short, please either solve the problem in the code or update 
Documentation/initrd.txt. This will save others some time trying to 
figure out why initrd doesn't work as expected.

In detail:

A 2.4.18 kernel built with these config settings:
   CONFIG_BLK_DEV_RAM=y
   CONFIG_BLK_DEV_INITRD=y
   CONFIG_DEVFS_FS=y
   CONFIG_DEVFS_MOUNT=y
and booted with this commandline (through the isolinux bootloader):
   linux root=/dev/rd/0 init=/linuxrc initrd=initrd rw
will call /linuxrc as *pid 8* (in my configuration, it might be 
another pid != 1). If linuxrc quits, the kernel will continue with 
the old-style change_root mechanism and then exec init (again 
/linuxrc) correctly as pid 1. But when doing pivot_root and exec'ing 
init from linuxrc instead of returning, init will still have pid 8.

Running init as a pid != 1 results in some problems (maybe more):
- init will not run at all unless given the --init option
- init will not be protected from signals, i.e. kill -9 8 will give a 
kernel panic
- pid 1 is the kernel thread named "swapper" which according to the 
userspace tools eats all cpu. Rik told me in IRC that this is the 
idle task (which is normally hidden?) so that's probably only an 
aesthetic problem.

There are two workarounds as mentioned in a discussion more than a year ago:

a) http://www.geocrawler.com/mail/msg.php3?msg_id=5898546&list=35
    which means using  root=/dev/ram0  even with devfs enabled.
    It seems that the device string is special cased somewhere and
    only /dev/ram0 [in combination with init=/linuxrc] will trigger
    the correct behaviour of exec'ing linuxrc as pid 1. (It seems that
    by default init/main.c exec's linuxrc in a kernel thread with pid !=1
    to save pid 1 for later executing the real init.)

b) http://www.geocrawler.com/mail/msg.php3?msg_id=5898635&list=35
    This workaround (mostly?) does it's job too, but seems silly:
    prepare_namespace() will still exec the hardcoded "/linuxrc" path
    in a kernel thread, which will fail right away since there's no
    such file. The kernel then continues the old-style change_root
    mechanism, which tries to umount the ramdisk again (which fails
    because of error 16 (Device or resource busy), not sure why), then
    tries to mount the root volume (still the ramdisk) again and goes
    on to exec init (which has been set to "/linux" in the above mail)
    as pid 1.

If nothing else then the section "Boot command-line options" in 
Documentation/initrd.txt should probably be changed to not claim that 
'root=/dev/rd/0   (with devfs)' will work and instead say that one 
should always use /dev/ram0. I realize that initramfs seems to be 
going to replace initrd in the future, but I think that's no excuse 
not to fix the current kernel/docs :)

Thanks,
Christian.

