Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270831AbTGVN5K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 09:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270829AbTGVN5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 09:57:10 -0400
Received: from p508EB386.dip.t-dialin.net ([80.142.179.134]:45729 "HELO
	neutronstar.dyndns.org") by vger.kernel.org with SMTP
	id S270831AbTGVNzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 09:55:51 -0400
Date: Tue, 22 Jul 2003 16:18:39 +0200
From: textshell@neutronstar.dyndns.org
To: Dominik Brodowski <linux@brodo.de>
Cc: linux-kernel@vger.kernel.org, Henrik Persson <nix@syndicalist.net>
Subject: Re: 2.6.0-test1: CPUFreq not working, can't find sysfs interface
Message-ID: <20030722141839.GD7517@neutronstar.dyndns.org>
References: <20030720150243.GJ2331@neutronstar.dyndns.org> <200307201745.h6KHjcHt095999@sirius.nix.badanka.com> <20030720211246.GK2331@neutronstar.dyndns.org> <20030722120811.GD1160@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030722120811.GD1160@brodo.de>
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 02:08:11PM +0200, Dominik Brodowski wrote:
> 
> What's the output [if any] in "dmesg" starting with either "cpufreq" or
> "powernow"?

I included some more information about my system in my first mail, but anyway.
the IMHO relevant dmesg messages are:
Machine check exception polling timer started.
powernow: AMD K7 CPU detected.
powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
powernow: Found PSB header at c00f17f0
powernow: Table version: 0x12
powernow: Flags: 0x0 (Mobile voltage regulator)
powernow: Settling Time: 100 microseconds.
powernow: Has 14 PST tables. (Only dumping ones relevant to this CPU).
Enabling SEP on CPU 0

I did a little bit of investigation in the kernel source (powernow-k7.c) and
downloaded x86info. The Output of x86info --pm --bios with the following
clueless little patch.
--- AMD/dumppsb.c       16 Jan 2003 19:46:52 -0000      1.4
+++ AMD/dumppsb.c       22 Jul 2003 13:47:59 -0000
@@ -81,8 +81,10 @@
                        for (i = 0 ; i <psb->numpst; i++) {
                                pst = (struct pst_s *) p;
                                numpstates = pst->numpstates;
-
-                               if ((etuple(cpu) == pst->cpuid) && (maxfid==pst->maxfid) && (startvid==pst->startvid))
+                               printf(" --DEBUG: %x ?= %x && %d ?= %d, %d ?= %d\n",
+                               etuple(cpu),pst->cpuid, maxfid,pst->maxfid, startvid, pst->startvid);
+                               //if ((etuple(cpu) == pst->cpuid) && (maxfid==pst->maxfid) && (startvid==pst->startvid))
+                               if (1)
                                {
                                        printf (" PST:%d (@%p)\n", i, pst);
                                        printf ("  cpuid: 0x%x\t", pst->cpuid);


Output:
x86info v1.12.  Dave Jones 2001-2003
Feedback to <davej@suse.de>.

Found 1 CPU
--------------------------------------------------------------------------
Family: 6 Model: 10 Stepping: 0
CPU Model : Mobile Athlon XP (Barton)
PowerNOW! Technology information
Available features:
	Temperature sensing diode present.
	Bus divisor control
	Voltage ID control

MSR: 0xc0010041=0x0000000000130b15 : 00000000 00000000 00000000 00000000
           00000000 00010011 00001011 00010101
MSR: 0xc0010042=0x000b0b0b00150615 : 00000000 00001011 00001011 00001011
           00000000 00010101 00000110 00010101

FID changes will happen
VID changes will happen
Current VID multiplier code: 1.450
Current FSB multiplier code: 13.5
Voltage ID codes: Maximum=1.450V Startup=1.450V Currently=1.450V
Frequency ID codes: Maximum=13.5x Startup=6.0x Currently=13.5x
Decoding BIOS PST tables (maxfid=15, startvid=b)
Found PSB header at 0x4017d7f0
Table version: 0x12
Flags: 0x0 (Mobile voltage regulator)
Settling Time: 100 microseconds.
Has 14 PST tables. (Only dumping ones relevant to this CPU).
 --DEBUG: 7a0 ?= 780 && 21 ?= 12, 11 ?= 11
 PST:0 (@0x4017d800)
  cpuid: 0x780	  fsb: 133	  maxFID: 0xc	  startvid: 0xb
  num of p states in this table: 5
    FID: 0x12 (4.0x [532MHz])	VID: 0x13 (1.200V)
    FID: 0x4 (5.0x [665MHz])	VID: 0x13 (1.200V)
    FID: 0x6 (6.0x [798MHz])	VID: 0x13 (1.200V)
    FID: 0x8 (7.0x [931MHz])	VID: 0xe (1.300V)
    FID: 0xc (9.0x [1197MHz])	VID: 0xb (1.450V)

 --DEBUG: 7a0 ?= 780 && 21 ?= 14, 11 ?= 11
 PST:1 (@0x4017d812)
  cpuid: 0x780	  fsb: 133	  maxFID: 0xe	  startvid: 0xb
  num of p states in this table: 5
    FID: 0x12 (4.0x [532MHz])	VID: 0x13 (1.200V)
    FID: 0x4 (5.0x [665MHz])	VID: 0x13 (1.200V)
    FID: 0x6 (6.0x [798MHz])	VID: 0x13 (1.200V)
    FID: 0x8 (7.0x [931MHz])	VID: 0x11 (1.250V)
    FID: 0xe (10.0x [1330MHz])	VID: 0xb (1.450V)

 --DEBUG: 7a0 ?= 780 && 21 ?= 15, 11 ?= 9
 PST:2 (@0x4017d824)
  cpuid: 0x780	  fsb: 133	  maxFID: 0xf	  startvid: 0x9
  num of p states in this table: 5
    FID: 0x12 (4.0x [532MHz])	VID: 0x13 (1.200V)
    FID: 0x4 (5.0x [665MHz])	VID: 0x13 (1.200V)
    FID: 0x6 (6.0x [798MHz])	VID: 0x13 (1.200V)
    FID: 0xa (8.0x [1064MHz])	VID: 0xc (1.400V)
    FID: 0xf (10.5x [1396MHz])	VID: 0x9 (1.550V)

 --DEBUG: 7a0 ?= 780 && 21 ?= 0, 11 ?= 9
 PST:3 (@0x4017d836)
  cpuid: 0x780	  fsb: 133	  maxFID: 0x0	  startvid: 0x9
  num of p states in this table: 5
    FID: 0x12 (4.0x [532MHz])	VID: 0x13 (1.200V)
    FID: 0x4 (5.0x [665MHz])	VID: 0x13 (1.200V)
    FID: 0x6 (6.0x [798MHz])	VID: 0x13 (1.200V)
    FID: 0xc (9.0x [1197MHz])	VID: 0xc (1.400V)
    FID: 0x0 (11.0x [1463MHz])	VID: 0x9 (1.550V)

 --DEBUG: 7a0 ?= 780 && 21 ?= 1, 11 ?= 9
 PST:4 (@0x4017d848)
  cpuid: 0x780	  fsb: 133	  maxFID: 0x1	  startvid: 0x9
  num of p states in this table: 5
    FID: 0x12 (4.0x [532MHz])	VID: 0x13 (1.200V)
    FID: 0x4 (5.0x [665MHz])	VID: 0x13 (1.200V)
    FID: 0x6 (6.0x [798MHz])	VID: 0x13 (1.200V)
    FID: 0xc (9.0x [1197MHz])	VID: 0xd (1.350V)
    FID: 0x1 (11.5x [1530MHz])	VID: 0x9 (1.550V)

 --DEBUG: 7a0 ?= 780 && 21 ?= 2, 11 ?= 10
 PST:5 (@0x4017d85a)
  cpuid: 0x780	  fsb: 133	  maxFID: 0x2	  startvid: 0xa
  num of p states in this table: 5
    FID: 0x12 (4.0x [532MHz])	VID: 0x13 (1.200V)
    FID: 0x4 (5.0x [665MHz])	VID: 0x13 (1.200V)
    FID: 0x6 (6.0x [798MHz])	VID: 0x13 (1.200V)
    FID: 0xc (9.0x [1197MHz])	VID: 0x11 (1.250V)
    FID: 0x2 (12.0x [1596MHz])	VID: 0xa (1.500V)

 --DEBUG: 7a0 ?= 780 && 21 ?= 3, 11 ?= 10
 PST:6 (@0x4017d86c)
  cpuid: 0x780	  fsb: 133	  maxFID: 0x3	  startvid: 0xa
  num of p states in this table: 6
    FID: 0x12 (4.0x [532MHz])	VID: 0x13 (1.200V)
    FID: 0x4 (5.0x [665MHz])	VID: 0x13 (1.200V)
    FID: 0x6 (6.0x [798MHz])	VID: 0x13 (1.200V)
    FID: 0xa (8.0x [1064MHz])	VID: 0x13 (1.200V)
    FID: 0xe (10.0x [1330MHz])	VID: 0xe (1.300V)
    FID: 0x3 (12.5x [1662MHz])	VID: 0xa (1.500V)

 --DEBUG: 7a0 ?= 781 && 21 ?= 15, 11 ?= 11
 PST:7 (@0x4017d880)
  cpuid: 0x781	  fsb: 133	  maxFID: 0xf	  startvid: 0xb
  num of p states in this table: 5
    FID: 0x12 (4.0x [532MHz])	VID: 0x13 (1.200V)
    FID: 0x4 (5.0x [665MHz])	VID: 0x13 (1.200V)
    FID: 0x6 (6.0x [798MHz])	VID: 0x13 (1.200V)
    FID: 0xa (8.0x [1064MHz])	VID: 0xe (1.300V)
    FID: 0xf (10.5x [1396MHz])	VID: 0xb (1.450V)

 --DEBUG: 7a0 ?= 781 && 21 ?= 0, 11 ?= 11
 PST:8 (@0x4017d892)
  cpuid: 0x781	  fsb: 133	  maxFID: 0x0	  startvid: 0xb
  num of p states in this table: 5
    FID: 0x12 (4.0x [532MHz])	VID: 0x13 (1.200V)
    FID: 0x4 (5.0x [665MHz])	VID: 0x13 (1.200V)
    FID: 0x6 (6.0x [798MHz])	VID: 0x13 (1.200V)
    FID: 0xc (9.0x [1197MHz])	VID: 0xd (1.350V)
    FID: 0x0 (11.0x [1463MHz])	VID: 0xb (1.450V)

 --DEBUG: 7a0 ?= 781 && 21 ?= 1, 11 ?= 11
 PST:9 (@0x4017d8a4)
  cpuid: 0x781	  fsb: 133	  maxFID: 0x1	  startvid: 0xb
  num of p states in this table: 5
    FID: 0x12 (4.0x [532MHz])	VID: 0x13 (1.200V)
    FID: 0x4 (5.0x [665MHz])	VID: 0x13 (1.200V)
    FID: 0x6 (6.0x [798MHz])	VID: 0x13 (1.200V)
    FID: 0xc (9.0x [1197MHz])	VID: 0xd (1.350V)
    FID: 0x1 (11.5x [1530MHz])	VID: 0xb (1.450V)

 --DEBUG: 7a0 ?= 781 && 21 ?= 2, 11 ?= 11
 PST:10 (@0x4017d8b6)
  cpuid: 0x781	  fsb: 133	  maxFID: 0x2	  startvid: 0xb
  num of p states in this table: 5
    FID: 0x12 (4.0x [532MHz])	VID: 0x13 (1.200V)
    FID: 0x4 (5.0x [665MHz])	VID: 0x13 (1.200V)
    FID: 0x6 (6.0x [798MHz])	VID: 0x13 (1.200V)
    FID: 0xc (9.0x [1197MHz])	VID: 0xd (1.350V)
    FID: 0x2 (12.0x [1596MHz])	VID: 0xb (1.450V)

 --DEBUG: 7a0 ?= 781 && 21 ?= 3, 11 ?= 11
 PST:11 (@0x4017d8c8)
  cpuid: 0x781	  fsb: 133	  maxFID: 0x3	  startvid: 0xb
  num of p states in this table: 6
    FID: 0x12 (4.0x [532MHz])	VID: 0x13 (1.200V)
    FID: 0x4 (5.0x [665MHz])	VID: 0x13 (1.200V)
    FID: 0x6 (6.0x [798MHz])	VID: 0x13 (1.200V)
    FID: 0xa (8.0x [1064MHz])	VID: 0x11 (1.250V)
    FID: 0xe (10.0x [1330MHz])	VID: 0xd (1.350V)
    FID: 0x3 (12.5x [1662MHz])	VID: 0xb (1.450V)

 --DEBUG: 7a0 ?= 781 && 21 ?= 21, 11 ?= 11
 PST:12 (@0x4017d8dc)
  cpuid: 0x781	  fsb: 133	  maxFID: 0x15	  startvid: 0xb
  num of p states in this table: 6
    FID: 0x12 (4.0x [532MHz])	VID: 0x13 (1.200V)
    FID: 0x4 (5.0x [665MHz])	VID: 0x13 (1.200V)
    FID: 0x6 (6.0x [798MHz])	VID: 0x13 (1.200V)
    FID: 0x8 (7.0x [931MHz])	VID: 0x13 (1.200V)
    FID: 0xe (10.0x [1330MHz])	VID: 0xe (1.300V)
    FID: 0x15 (13.5x [1796MHz])	VID: 0xb (1.450V)

 --DEBUG: 7a0 ?= 781 && 21 ?= 22, 11 ?= 11
 PST:13 (@0x4017d8f0)
  cpuid: 0x781	  fsb: 133	  maxFID: 0x16	  startvid: 0xb
  num of p states in this table: 5
    FID: 0xb (8.5x [1130MHz])	VID: 0x13 (1.200V)
    FID: 0xf (10.5x [1396MHz])	VID: 0xe (1.300V)
    FID: 0x1 (11.5x [1530MHz])	VID: 0xd (1.350V)
    FID: 0x3 (12.5x [1662MHz])	VID: 0xc (1.400V)
    FID: 0x16 (14.0x [1862MHz])	VID: 0xb (1.450V)

So it seems to me that the BIOS doesn't have the tables for my Athlon
model/stepping. I tried to get a new bios from hp, but it didn't change anything
relevant (they changed something in the PSTs but did not add a new one for my
processor)

> 
> I guess it's yet another BIOS problem... [as seen quite often wrt AMD
> PowerNow, unfortunately]

I think it would be a good thing to display a Message explaining why powernow
isn't working to the user in the case that no relevant PST is found.

Can you suggest any workaround for this problem, or is my only option to
complain to HP do supply an updated BIOS. 

I very much would like to have a way to override (or add to) the bios provided
values. BTW windows XP somehow manages to use powernow on this laptop anyway.

Martin H.
