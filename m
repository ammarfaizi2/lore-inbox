Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932936AbWFZTXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932936AbWFZTXP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 15:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932938AbWFZTXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 15:23:15 -0400
Received: from titanium.sabren.com ([67.19.173.4]:64927 "EHLO
	titanium.sabren.com") by vger.kernel.org with ESMTP id S932936AbWFZTXO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 15:23:14 -0400
Date: Mon, 26 Jun 2006 21:23:10 +0200
From: Grzegorz Adam Hankiewicz <gradha@titanium.sabren.com>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Linux kernel 2.6.10 sata_nv.c stops working on my hardware
Message-ID: <20060626192309.GA10711@noir>
Mail-Followup-To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Accept-Language: es,en
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On monday, 19 Jun, I sent an email to Andrew Chew at nvidia.com
regarding an issue I have with the sata_nv.c driver.  Basically,
it doesn't work for me from 2.6.10 up. I haven't received any kind
of reply yet. In case he's not available any more, I'm posting this
here in the hope somebody can suggest me how to solve the problem.

What follows is my original email sent to Andrew, with small
changes. Also, as requested on the FAQ, attachments are available
at http://gradha.sdf-eu.org/sata/ instead of being attached to
this mail.

I have subscribed to this mailing list. If you can do so, please
avoid sending me a copy, answer just to the mailing list. TIA.

----

I've recently had to upgrade my computer and bought an AMD Sempron
64bit 3100+ SK754, with motherboard K8 Asrock Upgrade K8NF3. Along
with this, two Maxtor 300GB hard drives, model 6V300F0.

I booted with the latest Knoppix 5.0 to set up the partitions
and found that while I could fdisk /dev/sd?, even changing a few
parameters would make fdisk hang indefinitely. On the other hand,
I got a Debian Sarge net installation disk which booted perfectly
with a 2.6 kernel.  After installing a basic system with it, I
started to tear the system to pieces to find out what was making
the hard disks fails.

After a while I found out that it was the SATA NV driver. The Sarge I
installed contains a 2.6.8 kernel + Debian patches.  I downloaded all
kernels from 2.6.8 up to 2.6.17 and created a synthetic configuration
which was loaded through "make menuconfig" in all of them (attached).
This configuration just makes SCSI and Nvidia Sata as built in code,
to make sure the machine can boot from /dev/sda1.

I started testing the kernels down from 2.6.8 (to weed out any
additional effects of Debian patches) and soon discovered that
while I could boot and work with the 2.6.9 kernel, 2.6.10 would
fail and hang forever during boot up, trying to mount/read the
main ext3 partition of my hard disk. So basically, 2.6.9 works,
2.6.10 doesn't, both with the same configuration loaded.

The problem: as mentioned above, the Knoppix would be able to see the
hard disks, but unable to mount them, or format with fdisk. Albeit
this would happen randomly. Sometimes I would be able to mount
/dev/sda1, but hang forever on /dev/sdb1. Sometimes the other
way round. However, everything would work OK if I mounted them
read-only. So the problem seems to be related to drive write mode.

Now, starting with my custom kernels the boot sequence stops when
it wants to mount the main filesystem.  The ext3 fs is detected
and mounted, but just after a line in the form of "ext3 clean
blah blah blah", it hangs, and after half a minute or so I get a
round of these errors (possibly hand transcriptions error follow,
and only different significant ones were copied:

 ata1: command 0x35 timeout, stat 0xd0 host stat 0x21
 ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ACC/ASCQ 0xB/47/00
 ata1: status=0xd0 { busy }
 
or repeated several times
 
 ATA: abnormal status 0xD0 on port 0xF87

To my dismay I have discovered that the motherboard I got basically
sucks in terms of SATA support, or at least so do angry people on
forums claim, blaming nvidia for bad drivers and whatnot under
Windows. I have also found that the hard disks I have *may* have
a buggy firmware:

  https://maxtor.custhelp.com/cgi-bin/maxtor.cfg/php/enduser/std_adp.php?p_faqid=2685&p_created=1136595488&p_sid=sFOM9iai&p_lva=&p_sp=cF9zcmNoPTEmcF9zb3J0X2J5PSZwX2dyaWRzb3J0PSZwX3Jvd19jbnQ9MSZwX3Byb2RzPTAmcF9jYXRzPTAmcF9wdj0mcF9jdj0mcF9zZWFyY2hfdHlwZT1hbnN3ZXJzLnNlYXJjaF9ubCZwX3BhZ2U9MSZwX3NlYXJjaF90ZXh0PStuZm9yY2UzICtzYXRh&p_li=&p_topview=1

Both hard disks I have are marked as:

  6V300F0 - VA111630 - V60EA5F6
  6V300F0 - VA111630 - V60EYSY6

According to the web page mentioned before, these serials mean I'm
not affected by this report. That doesn't necessarily mean they are
ok, but I do hope so, and at least they work with kernels <2.6.9
flawlessly (I've been using them for a week on a raid0 setup while
I wait for a correct fix).

So, from the web information I've gathered, there are four possible
likely problems:

  1) Bad cables, recommended to buy new ones on some forums.
  2) Bad motherboard, upgrade firmware.
  3) Bad hard disks, replace or upgrade firmware.
  4) Bad OS drivers.

I think the usage of the Debian 2.6.8-2-386 kernel for two weeks
discards the first three, leaving the fourth to deal with.

I want to know if you agree with this reasoning, and if as writer
of the sata_nv.c file you could help me diagnose the problem and
modify the last kernel version to make it work on my system. Please
suggest me change stuff to discard other kernel interferences,
or send my patches to try to address the problem.

My intention is to format the raid0 setup with reiser4. Even though
there are patches for 2.6.9, I would like to try their latest
version for 2.6.16, since they have fixed some bugs in the meantime.

I hope to hear from you soon. Apart from the configuration file
I loaded in the custom kernels, I'm also sending the just-booted
output of dmesg with both the Debian stock kernel 2.6.8-2 and
2.6.9 I compiled myself. You will notice many differences, which is
expected, since I didn't bother to load Debian's settings. But both
logs show a successful boot. I wish I could send you the output of
a superior kernel version failing, but as said, I cannot because
it hangs indefenitely during ext3 mounting.
