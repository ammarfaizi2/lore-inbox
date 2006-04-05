Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWDEMC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWDEMC1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 08:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWDEMC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 08:02:27 -0400
Received: from ranger.systems.pipex.net ([62.241.162.32]:62668 "EHLO
	ranger.systems.pipex.net") by vger.kernel.org with ESMTP
	id S1751225AbWDEMC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 08:02:26 -0400
From: Tim Phipps <tim@phipps-hutton.freeserve.co.uk>
To: Tim Phipps <tim@computer.systems.pipex.net>, linux-kernel@vger.kernel.org
Subject: Re: p4-clockmod not working in 2.6.16
Date: Wed, 5 Apr 2006 13:02:13 +0100
User-Agent: KMail/1.8.3
Cc: Mike Galbraith <efault@gmx.de>, Edgar Toernig <froese@gmx.de>,
       Dave Jones <davej@redhat.com>
References: <1142974528.3470.4.camel@localhost> <1143008405.13748.4.camel@homer> <1144147663.2588.247.camel@elsdt-scarecrow.arc.com>
In-Reply-To: <1144147663.2588.247.camel@elsdt-scarecrow.arc.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_HH7MEoCk4GiMpZq"
Message-Id: <200604051302.15576.tim@phipps-hutton.freeserve.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_HH7MEoCk4GiMpZq
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 04 Apr 2006 11:47, Tim Phipps wrote:
> On Wed, 2006-03-22 at 06:20, Mike Galbraith wrote:
> > On Wed, 2006-03-22 at 06:57 +0100, Edgar Toernig wrote:
> > > | N60.         Processor May Hang under Certain Frequencies and 12.5%
> > > |              STPCLK# Duty Cycle
> > > |
> > > | Problem:     If a system de-asserts STPCLK# at a 12.5% duty cycle,
> > > | the processor is running below 2 GHz, and the processor thermal
> > > | control circuit (TCC) on-demand clock modulation is active, the
> > > | processor may hang. This erratum does not occur under the automatic
> > > | mode of the TCC.
>
Here's a patch to 2.6.17-rc1 that disables the 12.5% DC on any CPU that has 
N60. The frequencies in the errata are a bit vague so this is the safe bet 
and it only disables one of the eight frequencies rather than the current 
behaviour which disables all of mine!

Cheers,
Tim.

--Boundary-00=_HH7MEoCk4GiMpZq
Content-Type: text/x-diff;
  charset="utf-8";
  name="kpatch-p4clockmod"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="kpatch-p4clockmod"

--- linux-2.6.17-rc1/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c.orig	2006-04-04 14:54:49.000000000 +0100
+++ linux-2.6.17-rc1/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2006-04-04 15:19:02.000000000 +0100
@@ -244,7 +244,7 @@
 	for (i=1; (p4clockmod_table[i].frequency != CPUFREQ_TABLE_END); i++) {
 		if ((i<2) && (has_N44_O17_errata[policy->cpu]))
 			p4clockmod_table[i].frequency = CPUFREQ_ENTRY_INVALID;
-		else if (has_N60_errata[policy->cpu] && ((stock_freq * i)/8) < 2000000)
+		else if ((i<2) && (has_N60_errata[policy->cpu]))
 			p4clockmod_table[i].frequency = CPUFREQ_ENTRY_INVALID;
 		else
 			p4clockmod_table[i].frequency = (stock_freq * i)/8;

--Boundary-00=_HH7MEoCk4GiMpZq--
