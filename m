Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268213AbUIWSZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268213AbUIWSZB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 14:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268216AbUIWSZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 14:25:00 -0400
Received: from convulsion.choralone.org ([212.13.208.157]:13828 "EHLO
	convulsion.choralone.org") by vger.kernel.org with ESMTP
	id S268213AbUIWSYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 14:24:53 -0400
Date: Thu, 23 Sep 2004 19:24:50 +0100
From: Dave Jones <davej@redhat.com>
To: Steve Snyder <swsnyder@insightbb.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Sub-optimal MTRR config in kernel 2.6.x
Message-ID: <20040923182449.GA7107@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Steve Snyder <swsnyder@insightbb.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200409230953.36618.swsnyder@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409230953.36618.swsnyder@insightbb.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 09:53:36AM -0500, Steve Snyder wrote:
 > 
 > And this is how the MTRRs are set up after booting the 2.6.8 kernel:
 > 
 > # cat /proc/mtrr
 > reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
 > reg01: base=0x20000000 ( 512MB), size= 256MB: write-back, count=1
 > reg02: base=0x30000000 ( 768MB), size= 128MB: write-back, count=1
 > reg03: base=0x38000000 ( 896MB), size=  64MB: write-back, count=1
 > reg04: base=0x3c000000 ( 960MB), size=  32MB: write-back, count=1
 > reg05: base=0x3df80000 ( 991MB), size= 512KB: uncachable, count=1
 > reg06: base=0x4df80000 (1247MB), size= 512KB: uncachable, count=1
 > reg07: base=0xdc000000 (3520MB), size=   1MB: write-combining, count=1

That last MTRR is created by the vesafb. It doesn't size video memory,
but instead creates an MTRR big enough to cover xresolution * yresolution * depth
and then rounds down to the nearest alignment that is allowed for MTRRs.
(in your case 1MB).

 > With this configuration, Xorg (v6.8.1) logs this complaint at startup: 
 > 
 > (WW) RADEON(0): Failed to set up write-combining range (0xdc000000,0x2000000)

X sized the video memory, and has a better idea of what is going on.
In an ideal world, X could fix up suboptimal MTRR setups like this
by deleting the existing range.

Another way of working around it is to tell the vesafb not to set up an
mtrr at all. There is a boot command line option to tell it to do this iirc.

 > I can satisfy this complaint by manually adjusting the MTRR config 
 > prior to starting Xorg like this:
 > 
 > echo "disable=7" >| /proc/mtrr
 > echo "base=0xdc000000 size=0x2000000 type=write-combining" > /proc/mtrr
 
X should also do the right thing without the second command.
With MTRR 7 disabled, there will be a free MTRR available for X
to use.

		Dave
