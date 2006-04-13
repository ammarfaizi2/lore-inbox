Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbWDMN7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbWDMN7t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 09:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbWDMN7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 09:59:48 -0400
Received: from blaster.systems.pipex.net ([62.241.163.7]:37094 "EHLO
	blaster.systems.pipex.net") by vger.kernel.org with ESMTP
	id S964928AbWDMN7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 09:59:48 -0400
From: Tim Phipps <tim@phipps-hutton.freeserve.co.uk>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: [PATCH 001/001] cpufreq: p4_clockmod errata N60 handling is over zealous
Date: Thu, 13 Apr 2006 14:59:38 +0100
User-Agent: KMail/1.8.3
Cc: "Jesper Juhl" <jesper.juhl@gmail.com>, "Mike Galbraith" <efault@gmx.de>,
       linux-kernel@vger.kernel.org, "Edgar Toernig" <froese@gmx.de>,
       "Dave Jones" <davej@redhat.com>
References: <1142974528.3470.4.camel@localhost> <200604131320.58800.tim@phipps-hutton.freeserve.co.uk> <9a8748490604130542y783e604ew93aea8e4997c3f57@mail.gmail.com>
In-Reply-To: <9a8748490604130542y783e604ew93aea8e4997c3f57@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 3045
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200604131459.41354.tim@phipps-hutton.freeserve.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim Phipps <tim@phipps-hutton.freeserve.co.uk>

> > On Wednesday 05 Apr 2006 14:59, Mike Galbraith wrote:
> > > On Wed, 2006-04-05 at 13:02 +0100, Tim Phipps wrote:
> > > > Here's a patch to 2.6.17-rc1 that disables the 12.5% DC on any CPU
> > > > that has N60. The frequencies in the errata are a bit vague so this
> > > > is the safe bet and it only disables one of the eight frequencies
> > > > rather than the current behaviour which disables all of mine!
> > >
> > > Works for me.  Perhaps you should update...
> > > dprintk("has errata -- disabling frequencies lower than 2ghz\n");
> > > ...,slap a Signed-off-by: on it and see if it flys.

Signed-off-by: Tim Phipps <tim@phipps-hutton.freeserve.co.uk>
---
--- linux-2.6.17-rc1/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c.orig	
2006-04-10 17:12:23.000000000 +0100
+++ linux-2.6.17-rc1/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2006-04-10 
17:23:44.000000000 +0100
@@ -17,6 +17,7 @@
  *	
  *	Date		Errata			Description
  *	20020525	N44, O17	12.5% or 25% DC causes lockup
+ *	20060410	N60             12.5% DC causes lockup
  *
  */
 
@@ -231,7 +232,7 @@ static int cpufreq_p4_cpu_init(struct cp
 
 	case 0x0f29:
 		has_N60_errata[policy->cpu] = 1;
-		dprintk("has errata -- disabling frequencies lower than 2GHz\n");
+		dprintk("has errata -- disabling 12.5%% duty cycle\n");
 		break;
 	}
 	
@@ -244,7 +245,7 @@ static int cpufreq_p4_cpu_init(struct cp
 	for (i=1; (p4clockmod_table[i].frequency != CPUFREQ_TABLE_END); i++) {
 		if ((i<2) && (has_N44_O17_errata[policy->cpu]))
 			p4clockmod_table[i].frequency = CPUFREQ_ENTRY_INVALID;
-		else if (has_N60_errata[policy->cpu] && ((stock_freq * i)/8) < 2000000)
+		else if ((i<2) && has_N60_errata[policy->cpu])
 			p4clockmod_table[i].frequency = CPUFREQ_ENTRY_INVALID;
 		else
 			p4clockmod_table[i].frequency = (stock_freq * i)/8;
