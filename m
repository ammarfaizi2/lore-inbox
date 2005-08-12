Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbVHLN4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbVHLN4E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 09:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbVHLN4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 09:56:04 -0400
Received: from moutvdom.kundenserver.de ([212.227.126.249]:64758 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751184AbVHLN4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 09:56:03 -0400
Message-ID: <42FCAA7C.4090000@anagramm.de>
Date: Fri, 12 Aug 2005 15:56:12 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML List <linux-kernel@vger.kernel.org>
Subject: Oops on reboot after torture test of char driver module.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

(This might be interesting for hotplug-devel, too.)

Kernel 2.6.13-rc3, ppc, mpc8540

I am currently writing a char device driver module to access some dma
stuff. To verify for memory leaks, I was running a simple module
load/unload torture test like this:

#!/bin/bash
for j in `seq 1 1000`; do
        insmod module.ko
        rmmod module
done

In /proc/meminfo everything looks fine, I had no leaks, so
I guess that everything was fine on the driver's side.

But udev-062 was not able to catch up with the fast loads/unloads
and it took a really long time to recover (1711 seconds)
from the stress.

Finally I wasn't able to get my device /dev/ecam0 created
by udev anymore. So, I decided to reboot to clean up this mess
and just before reboot I ended up in a Oops as shown below.

Maybe some of you might get an idea if there is a weak spot
in the kernel or not...

I'll try to get the error again.

console log:
---------------------------------------------
INIT: Starting killall:  [  OK  ]
Sending all processes the TERM signal...
Sending all processes the KILL signal...
Oops: kernel access of bad area, sig: 11 [#1]
NIP: C000C170 LR: C0069328 SP: C9FF5E50 REGS: c9ff5da0 TRAP: 0300    Not tainted
MSR: 00029000 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 00
DAR: D11B4B78, DSISR: 00000000
TASK = cf9860a0[10874] 'grep' THREAD: c9ff4000
Last syscall: 3
GPR00: 000003EC C9FF5E50 CF9860A0 D11B4B78 D11B4B77 C0212E27 00000088 0000000A
GPR08: 00000003 C020E66C FFFFFFFF 00000004 00000000 1002A708 10020000 10020000
GPR16: 00000000 10010000 10010000 10020000 10020000 10020000 C0210000 00000000
GPR24: C9FF5EBC C0250000 C02D9A50 000000FB C9FA5000 C0210000 000000A0 CBC48CC0
NIP [c000c170] strlen+0x4/0x18
LR [c0069328] get_chrdev_list+0x6c/0x104
Call trace:
 [c009542c] devices_read_proc+0x28/0x68
 [c009205c] proc_file_read+0xb8/0x2c0
 [c005f190] vfs_read+0x140/0x15c
 [c005f48c] sys_read+0x4c/0x90
 [c0002470] ret_from_syscall+0x0/0x48
/etc/rc6.d/S01reboot: line 66: 10874 Segmentation fault      grep -q "\(sparcaud
io\|sound\)" /proc/devices
Syncing hardware clock to system time hwclock: ioctl() (RTC_SET_TIME) to /dev/rt
c to set time failed, errno = Invalid argument (22).

Turning off swap:
Unmounting file systems:
Please stand by while rebooting the system...
Restarting system.

syslog:
------------------------------------
[...]
Aug 12 14:59:30 ecam udevd[339]: udevd.c: seq 22004 exit, 1711 seconds old
Aug 12 14:59:30 ecam udevd[339]: udevd.c: seq 22005 forked, pid 10608, 1711 seconds old
Aug 12 14:59:30 ecam udev[10608]: udev_db.c: unable to read db file '/dev/.udevdb/class@ecam'
Aug 12 14:59:30 ecam udevd[339]: udevd.c: seq 22005 exit, 1711 seconds old
Aug 12 14:59:30 ecam udevd[339]: udevd.c: seq 22028 forked, pid 10609, 1668 seconds old
Aug 12 14:59:33 ecam udevd[339]: udevd.c: seq 22028 exit, 1671 seconds old
Aug 12 14:59:33 ecam udevd[339]: udevd.c: seq 22029 forked, pid 10610, 1627 seconds old
Aug 12 14:59:33 ecam udev[10610]: udev_db.c: unable to read db file '/dev/.udevdb/class@ecam@ec
am0'
Aug 12 14:59:33 ecam udevd[339]: udevd.c: seq 22029 exit, 1627 seconds old
Aug 12 14:59:33 ecam udevd[339]: udevd.c: seq 22030 forked, pid 10611, 1627 seconds old
Aug 12 14:59:33 ecam udev[10611]: udev_db.c: unable to read db file '/dev/.udevdb/class@ecam'
Aug 12 14:59:33 ecam udevd[339]: udevd.c: seq 22030 exit, 1627 seconds old
Aug 12 15:25:15 ecam udevd[339]: udevd.c: seq 22032 queued, devpath '/module/ecam'
Aug 12 15:25:15 ecam udevd[339]: udevd.c: seq 22032 forked, pid 10615, 0 seconds old
Aug 12 15:25:15 ecam udevd[339]: udevd.c: seq 22033 queued, devpath '/class/ecam/ecam0'
Aug 12 15:25:15 ecam udevd[339]: udevd.c: seq 22033 forked, pid 10617, 0 seconds old
Aug 12 15:25:15 ecam kernel: Initialize eCam I/O device driver V1.2
Aug 12 15:25:15 ecam kernel: ecam: ===== init start =====
Aug 12 15:25:15 ecam kernel: ecam_bus: programming UPMA...
Aug 12 15:25:15 ecam kernel: ecam_bus: filling UPM RAM...
Aug 12 15:25:15 ecam kernel: ecam_bus: 64 words written
Aug 12 15:25:15 ecam kernel: ecam_bus: read back UPM RAM and compare...
Aug 12 15:25:15 ecam kernel: ecam_bus: UPM verification successful
Aug 12 15:25:15 ecam kernel: ecam_bus: enabling UPM...
Aug 12 15:25:15 ecam kernel: ecam_dma: Cleaning up DMA channels...
Aug 12 15:25:15 ecam kernel: ecam_dma: Successful request of IRQ #4 for channel 0
Aug 12 15:25:15 ecam kernel: ecam_dma: Successful request of IRQ #5 for channel 1
Aug 12 15:25:15 ecam udevd[339]: udevd.c: seq 22032 exit, 0 seconds old
Aug 12 15:25:16 ecam kernel: ecam_dma: Successful request of IRQ #6 for channel 2
Aug 12 15:25:16 ecam kernel: ecam_dma: Successful request of IRQ #7 for channel 3
Aug 12 15:25:16 ecam kernel: MPC85xx DMA Engine ready (4 channels available)
Aug 12 15:25:16 ecam kernel: ecam: ----- init done -----
Aug 12 15:25:19 ecam udevd[339]: udevd.c: seq 22033 exit, 3 seconds old
Aug 12 15:27:01 ecam udevd[339]: udevd.c: seq 22034 queued, devpath '/class/ecam/ecam0'
Aug 12 15:27:01 ecam udevd[339]: udevd.c: seq 22034 forked, pid 10680, 0 seconds old
Aug 12 15:27:01 ecam kernel: Terminate eCam I/O device driver V1.2
Aug 12 15:27:01 ecam kernel: ecam: ----- exit start -----
Aug 12 15:27:01 ecam udevd[339]: udevd.c: seq 22035 queued, devpath '/class/ecam'
Aug 12 15:27:01 ecam udevd[339]: udevd.c: seq 22036 queued, devpath '/module/ecam'
Aug 12 15:27:01 ecam udevd[339]: udevd.c: seq 22036 forked, pid 10682, 0 seconds old
Aug 12 15:27:01 ecam kernel: MPC85xx DMA engine removed
Aug 12 15:27:01 ecam kernel: ecam: ===== exit done =====
Aug 12 15:27:01 ecam kernel:
Aug 12 15:27:01 ecam udev[10680]: udev_db.c: unable to read db file '/dev/.udevdb/class@ecam@ec
am0'
Aug 12 15:27:01 ecam udevd[339]: udevd.c: seq 22034 exit, 0 seconds old
Aug 12 15:27:01 ecam udevd[339]: udevd.c: seq 22035 forked, pid 10684, 0 seconds old
Aug 12 15:27:01 ecam udev[10684]: udev_db.c: unable to read db file '/dev/.udevdb/class@ecam'
Aug 12 15:27:01 ecam udevd[339]: udevd.c: seq 22036 exit, 0 seconds old
Aug 12 15:27:01 ecam udevd[339]: udevd.c: seq 22035 exit, 0 seconds old
Aug 12 15:32:50 ecam shutdown: shutting down for system reboot
Aug 12 15:32:50 ecam init: Switching to runlevel: 6
Aug 12 15:32:51 ecam killall: Shutting down interface eth0:
Aug 12 15:32:51 ecam ifdown: ./ifdown: line 120: /etc/sysconfig/network-scripts/ifdown-post: Pe
rmission denied
Aug 12 15:32:51 ecam network: Shutting down interface eth0:  succeeded
Aug 12 15:32:51 ecam killall: [
Aug 12 15:32:51 ecam killall:
Aug 12 15:32:51 ecam killall: Shutting down loopback interface:
Aug 12 15:32:51 ecam ifdown: ./ifdown: line 120: /etc/sysconfig/network-scripts/ifdown-post: Pe
rmission denied
Aug 12 15:32:51 ecam network: Shutting down loopback interface:  succeeded
Aug 12 15:32:51 ecam killall: [
Aug 12 15:32:51 ecam killall:
Aug 12 15:32:51 ecam killall: Saving random seed:
Aug 12 15:32:51 ecam dd: 1+0 records in
Aug 12 15:32:51 ecam dd: 1+0 records out
Aug 12 15:32:51 ecam random: Saving random seed:  succeeded
Aug 12 15:32:51 ecam killall: [
Aug 12 15:32:51 ecam killall:
Aug 12 15:32:51 ecam killall: Shutting down kernel logger:
Aug 12 15:32:51 ecam kernel: Kernel logging (proc) stopped.
Aug 12 15:32:51 ecam kernel: Kernel log daemon terminating.
Aug 12 15:32:52 ecam exiting on signal 15

--------------------


Best greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
