Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWCDLMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWCDLMk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 06:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWCDLMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 06:12:40 -0500
Received: from smtp17.wanadoo.fr ([193.252.23.111]:23606 "EHLO
	smtp17.wanadoo.fr") by vger.kernel.org with ESMTP id S1751119AbWCDLMj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 06:12:39 -0500
X-ME-UUID: 20060304111233220.055CA700008B@mwinf1703.wanadoo.fr
Date: Sat, 4 Mar 2006 12:12:19 +0100
From: Mathieu Chouquet-Stringer <mchouque@free.fr>
To: linux-kernel@vger.kernel.org
Cc: linux-alpha@vger.kernel.org, ink@jurassic.park.msu.ru,
       Christoph Hellwig <hch@lst.de>, Richard Henderson <rth@twiddle.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Problem on Alpha with "convert to generic irq framework"
Message-ID: <20060304111219.GA10532@localhost>
Mail-Followup-To: Mathieu Chouquet-Stringer <mchouque@free.fr>,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	ink@jurassic.park.msu.ru, Christoph Hellwig <hch@lst.de>,
	Richard Henderson <rth@twiddle.net>, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello Ivan,

Few weeks ago, I stopped using the latest git snapshot on my alpha (an
EV56 on a EB164/LX164 motherboard [1]) because I was experiecing nasty
crashes when doing fairly heavy IOs (like checksumming ISO files) over a
MD Raid 0 device built against 3 scsi disks connected to a pci Adaptec
(2940U2W [2]) SCSI card.

I can trigger the bug almost instantly and I get, more or less randomly,
the following panic messages (without traces):

Aiee, killing interrupt handler!
Attempted to kill the idle task!
Unable to handle kernel paging request at virtual address


Using git, I started bisecting using 2.6.15 as the "good" release
(because the box is rock solid with 2.6.15) and after countless hours
(boy that thing isn't the fastest box around) and countless kernel
compiles, I ended up with this first bad commit:


0595bf3bca9d9932a05b06dd438f40f01d27cd33 is first bad commit
diff-tree 0595bf3bca9d9932a05b06dd438f40f01d27cd33 (from eee45269b0f5979c70bc151c6c2f4e5f4f5ababe)
Author: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Date:   Fri Jan 6 00:12:22 2006 -0800

    [PATCH] Alpha: convert to generic irq framework (alpha part)
    
    Kconfig tweaks and tons of deletions.
    
    Signed-off-by: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
    Cc: Christoph Hellwig <hch@lst.de>
    Cc: Richard Henderson <rth@twiddle.net>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

:040000 040000 ac127f16325bb65941bd38208325ab7821877f52 15d7d4d17a7c8cfb8fe53c29ded31ff9cf287534 M      arch
:040000 040000 287f73cdf371b2b33cc48f1d876005aab29ff3de 29263093ae33ceccd6346b987870367bc8329f0a M      include


I've scanned the patch quickly but I didn't see anything obvious... ;-(

Reverting this commit using:
git revert 0595bf3bca9d9932a05b06dd438f40f01d27cd33

against c499ec24c31edf270e777a868ffd0daddcfe7ebd (the latest HEAD as of
right now) made my system usable again.

As this code will make it into mainline 2.6.16, I wonder if I'm the
online one experiencing this problem (any Alpha owners/testers
around?)...

I'll go over the patch again to learn more about the irq framework and
I'm available to try any patches you can throw at me the goal being to
make 2.6.16 (or latter stable version) usable (at least to me).

Cheers,


[1]
/proc/cpuinfo:
cpu                     : Alpha
cpu model               : EV56
cpu variation           : 0
cpu revision            : 0
cpu serial number       : Linux_is_Great!
system type             : EB164
system variation        : LX164
system revision         : 0
system serial number    : MILO-2.2-18
cycle frequency [Hz]    : 533333333 
timer frequency [Hz]    : 1024.00
page size [bytes]       : 8192
phys. address bits      : 40
max. addr. space #      : 127
BogoMIPS                : 1059.80
kernel unaligned acc    : 0 (pc=0,va=0)
user unaligned acc      : 0 (pc=0,va=0)
platform string         : N/A
cpus detected           : 0
L1 Icache               : 8K, 1-way, 32b line
L1 Dcache               : 8K, 1-way, 32b line
L2 cache                : 96K, 3-way, 64b line
L3 cache                : 1024K, 1-way, 64b line

[2]
01:01.0 SCSI storage controller: Adaptec AHA-2940U2/U2W

-- 
Mathieu Chouquet-Stringer

