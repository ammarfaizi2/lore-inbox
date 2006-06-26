Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWFZUsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWFZUsR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWFZUsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:48:17 -0400
Received: from hqemgate01.nvidia.com ([216.228.112.170]:35914 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S1751255AbWFZUsQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:48:16 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Linux kernel 2.6.10 sata_nv.c stops working on my hardware
Date: Mon, 26 Jun 2006 13:48:08 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B00E48CF38@hqemmail02.nvidia.com>
In-Reply-To: <20060626192309.GA10711@noir>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux kernel 2.6.10 sata_nv.c stops working on my hardware
Thread-Index: AcaZV4t2QBEKIGZyRq6MILwu2fQ8ogACCXnA
From: "Allen Martin" <AMartin@nvidia.com>
To: "Grzegorz Adam Hankiewicz" <gradha@titanium.sabren.com>,
       "Linux kernel mailing list" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Jun 2006 20:48:10.0367 (UTC) FILETIME=[D5C060F0:01C69961]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you tried the 2.6.9 sata_nv.c on 2.6.10?  All you should have to do
to get
it working is change the host_set->pdev references to use to_pci_dev().

The only functional change in sata_nv that should make any difference is
the 
following:  

 static struct ata_port_info nv_port_info = {
        .sht            = &nv_sht,
        .host_flags     = ATA_FLAG_SATA |
-                         ATA_FLAG_SATA_RESET |
+                         /* ATA_FLAG_SATA_RESET | */
                          ATA_FLAG_SRST |
                          ATA_FLAG_NO_LEGACY,
        .pio_mask       = NV_PIO_MASK,


You can try changing that back to see if it makes a difference.  I would
also
investigate changes in libata too.

-Allen

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Grzegorz Adam Hankiewicz
> Sent: Monday, June 26, 2006 12:23 PM
> To: Linux kernel mailing list
> Subject: Linux kernel 2.6.10 sata_nv.c stops working on my hardware
> 
> Hello.
> 
> On monday, 19 Jun, I sent an email to Andrew Chew at nvidia.com
> regarding an issue I have with the sata_nv.c driver.  Basically,
> it doesn't work for me from 2.6.10 up. I haven't received any kind
> of reply yet. In case he's not available any more, I'm posting this
> here in the hope somebody can suggest me how to solve the problem.
> 
> What follows is my original email sent to Andrew, with small
> changes. Also, as requested on the FAQ, attachments are available
> at http://gradha.sdf-eu.org/sata/ instead of being attached to
> this mail.
> 
> I have subscribed to this mailing list. If you can do so, please
> avoid sending me a copy, answer just to the mailing list. TIA.
> 
> ----
> 
> I've recently had to upgrade my computer and bought an AMD Sempron
> 64bit 3100+ SK754, with motherboard K8 Asrock Upgrade K8NF3. Along
> with this, two Maxtor 300GB hard drives, model 6V300F0.
> 
> I booted with the latest Knoppix 5.0 to set up the partitions
> and found that while I could fdisk /dev/sd?, even changing a few
> parameters would make fdisk hang indefinitely. On the other hand,
> I got a Debian Sarge net installation disk which booted perfectly
> with a 2.6 kernel.  After installing a basic system with it, I
> started to tear the system to pieces to find out what was making
> the hard disks fails.
> 
> After a while I found out that it was the SATA NV driver. The Sarge I
> installed contains a 2.6.8 kernel + Debian patches.  I downloaded all
> kernels from 2.6.8 up to 2.6.17 and created a synthetic configuration
> which was loaded through "make menuconfig" in all of them (attached).
> This configuration just makes SCSI and Nvidia Sata as built in code,
> to make sure the machine can boot from /dev/sda1.
> 
> I started testing the kernels down from 2.6.8 (to weed out any
> additional effects of Debian patches) and soon discovered that
> while I could boot and work with the 2.6.9 kernel, 2.6.10 would
> fail and hang forever during boot up, trying to mount/read the
> main ext3 partition of my hard disk. So basically, 2.6.9 works,
> 2.6.10 doesn't, both with the same configuration loaded.
> 
> The problem: as mentioned above, the Knoppix would be able to see the
> hard disks, but unable to mount them, or format with fdisk. Albeit
> this would happen randomly. Sometimes I would be able to mount
> /dev/sda1, but hang forever on /dev/sdb1. Sometimes the other
> way round. However, everything would work OK if I mounted them
> read-only. So the problem seems to be related to drive write mode.
> 
> Now, starting with my custom kernels the boot sequence stops when
> it wants to mount the main filesystem.  The ext3 fs is detected
> and mounted, but just after a line in the form of "ext3 clean
> blah blah blah", it hangs, and after half a minute or so I get a
> round of these errors (possibly hand transcriptions error follow,
> and only different significant ones were copied:
> 
>  ata1: command 0x35 timeout, stat 0xd0 host stat 0x21
>  ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ACC/ASCQ 0xB/47/00
>  ata1: status=0xd0 { busy }
>  
> or repeated several times
>  
>  ATA: abnormal status 0xD0 on port 0xF87
> 
> To my dismay I have discovered that the motherboard I got basically
> sucks in terms of SATA support, or at least so do angry people on
> forums claim, blaming nvidia for bad drivers and whatnot under
> Windows. I have also found that the hard disks I have *may* have
> a buggy firmware:
> 
>   
> https://maxtor.custhelp.com/cgi-bin/maxtor.cfg/php/enduser/std
> _adp.php?p_faqid=2685&p_created=1136595488&p_sid=sFOM9iai&p_lv
a=&p_sp=cF9zcmNoPTEmcF9zb3J0X2J5PSZwX2dyaWRzb3J0PSZwX3Jvd19jbnQ9MSZwX3By
b2RzPTAmcF9jYXRzPTAmcF9wdj0mcF9jdj0mcF9zZWFyY2hfdHlwZT1hbnN3ZXJzLnNlYXJj
aF9ubCZwX3>
BhZ2U9MSZwX3NlYXJjaF90ZXh0PStuZm9yY2UzICtzYXRh&p_li=&p_topview=1
> 
> Both hard disks I have are marked as:
> 
>   6V300F0 - VA111630 - V60EA5F6
>   6V300F0 - VA111630 - V60EYSY6
> 
> According to the web page mentioned before, these serials mean I'm
> not affected by this report. That doesn't necessarily mean they are
> ok, but I do hope so, and at least they work with kernels <2.6.9
> flawlessly (I've been using them for a week on a raid0 setup while
> I wait for a correct fix).
> 
> So, from the web information I've gathered, there are four possible
> likely problems:
> 
>   1) Bad cables, recommended to buy new ones on some forums.
>   2) Bad motherboard, upgrade firmware.
>   3) Bad hard disks, replace or upgrade firmware.
>   4) Bad OS drivers.
> 
> I think the usage of the Debian 2.6.8-2-386 kernel for two weeks
> discards the first three, leaving the fourth to deal with.
> 
> I want to know if you agree with this reasoning, and if as writer
> of the sata_nv.c file you could help me diagnose the problem and
> modify the last kernel version to make it work on my system. Please
> suggest me change stuff to discard other kernel interferences,
> or send my patches to try to address the problem.
> 
> My intention is to format the raid0 setup with reiser4. Even though
> there are patches for 2.6.9, I would like to try their latest
> version for 2.6.16, since they have fixed some bugs in the meantime.
> 
> I hope to hear from you soon. Apart from the configuration file
> I loaded in the custom kernels, I'm also sending the just-booted
> output of dmesg with both the Debian stock kernel 2.6.8-2 and
> 2.6.9 I compiled myself. You will notice many differences, which is
> expected, since I didn't bother to load Debian's settings. But both
> logs show a successful boot. I wish I could send you the output of
> a superior kernel version failing, but as said, I cannot because
> it hangs indefenitely during ext3 mounting.
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
