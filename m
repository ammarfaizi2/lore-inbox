Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263330AbTLDSD6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 13:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263345AbTLDSD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 13:03:58 -0500
Received: from columba1.eur.3com.com ([161.71.171.235]:30933 "EHLO
	columba1.eur.3com.com") by vger.kernel.org with ESMTP
	id S263330AbTLDSD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 13:03:57 -0500
Message-ID: <3FCF7704.2070601@jburgess.uklinux.net>
Date: Thu, 04 Dec 2003 18:03:48 +0000
From: Jon Burgess <lkml@jburgess.uklinux.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-gb, en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: Re: Serial ATA (SATA) for Linux status report
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

**Jeff Garzik wrote:
 > Intel ICH5
...
 > drivers/ide driver status: Production, but see issue #1, #2.
...
 > Issue #2: Excessive interrupts are seen in some configurations.

I can reproduce this easily in my current setup. It looks like the 
chipset is generating some unexpected IRQ's when after performing the 
hdparm drive setting ioctl()'s.

More details are below, let me know if you need any more.

Hardware:
Gigabyte 8IG1000Pro (Intel ICH5)
2 x Parallel IDE drives on PATA IDE primary
2 x DVD drives on PATA IDE secondary
1 x Seagate 80GB SATA drive on SATA0

Software:
Linux-2.6.0-test10, using drivers/ide driver

The Root fileystem is currently on one of the parallel IDE drives, and 
the SATA doesn't get used much (yet). The PC boots and vmstat shows 
everything is OK.

Running an hdparm command on the drive causes an IRQ storm, reported by 
vmstat at ~ 100k IRQ/s. I think that "hdaprm -S 128 /dev/hde" will 
trigger it, but I can't remember for certain.
Performing another access to the drive, e.g. umount /dev/hde, clears the 
problem.
It is 100% repeatable, i.e. doing the hdparm makes it happen again, then 
mounting the drive will clear it.

I put some extra debug in the ide_intr routine and found that there was 
a storm of interrupts around when the partition table was being read 
(the "drive_check_ready()" check was failing continuously for a while). 
Afterwards there were times when  lots of IRQs happened when "handler" 
was NULL. It looks like the chipset might be generating some extra IRQ's 
which the existing code isn't expecting. Doing another access on the 
drive looks like it is enough to clear whatever interrupt is pending.

    Jon



