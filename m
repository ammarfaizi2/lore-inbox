Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270822AbTGVORE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 10:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270823AbTGVORE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 10:17:04 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:55773 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S270822AbTGVORA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 10:17:00 -0400
Date: Tue, 22 Jul 2003 16:23:53 +0200
From: Dominik Brodowski <linux@brodo.de>
To: textshell@neutronstar.dyndns.org, davej@suse.de
Cc: linux-kernel@vger.kernel.org, Henrik Persson <nix@syndicalist.net>
Subject: Re: 2.6.0-test1: CPUFreq not working, can't find sysfs interface
Message-ID: <20030722142353.GA1301@brodo.de>
References: <20030720150243.GJ2331@neutronstar.dyndns.org> <200307201745.h6KHjcHt095999@sirius.nix.badanka.com> <20030720211246.GK2331@neutronstar.dyndns.org> <20030722120811.GD1160@brodo.de> <20030722141839.GD7517@neutronstar.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030722141839.GD7517@neutronstar.dyndns.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 04:18:39PM +0200, textshell@neutronstar.dyndns.org wrote:
> So it seems to me that the BIOS doesn't have the tables for my Athlon
> model/stepping. I tried to get a new bios from hp, but it didn't change anything
> relevant (they changed something in the PSTs but did not add a new one for my
> processor)

Indeed, that's the BUG().

> > I guess it's yet another BIOS problem... [as seen quite often wrt AMD
> > PowerNow, unfortunately]
> 
> I think it would be a good thing to display a Message explaining why powernow
> isn't working to the user in the case that no relevant PST is found.

Patch appended at the end.

> Can you suggest any workaround for this problem, or is my only option to
> complain to HP do supply an updated BIOS. 

Well, you could try using the PST which mostly matches your system except
the CPUID [PST #12, see below] -- if the values used are similar to the ones
Windows XP uses. But this might be risky!!!

> I very much would like to have a way to override (or add to) the bios provided
> values.

AFAIK, Dave Jones will add support to override the BIOS-provided tables.

>  --DEBUG: 7a0 ?= 781 && 21 ?= 21, 11 ?= 11
>  PST:12 (@0x4017d8dc)
>   cpuid: 0x781	  fsb: 133	  maxFID: 0x15	  startvid: 0xb
>   num of p states in this table: 6
>     FID: 0x12 (4.0x [532MHz])	VID: 0x13 (1.200V)
>     FID: 0x4 (5.0x [665MHz])	VID: 0x13 (1.200V)
>     FID: 0x6 (6.0x [798MHz])	VID: 0x13 (1.200V)
>     FID: 0x8 (7.0x [931MHz])	VID: 0x13 (1.200V)
>     FID: 0xe (10.0x [1330MHz])	VID: 0xe (1.300V)
>     FID: 0x15 (13.5x [1796MHz])	VID: 0xb (1.450V)

	Dominik

diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/powernow-k7.c linux/arch/i386/kernel/cpu/cpufreq/powernow-k7.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/powernow-k7.c	2003-07-11 14:12:35.000000000 +0200
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k7.c	2003-07-22 16:16:00.000000000 +0200
@@ -345,6 +345,7 @@
 						p+=2;
 				}
 			}
+			dprintk (KERN_INFO PFX "Did not find any PST table for this CPU -- exiting\n");
 			return -EINVAL;
 		}
 		p++;
