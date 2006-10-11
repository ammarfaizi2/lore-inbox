Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161415AbWJKV1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161415AbWJKV1Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422635AbWJKV1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:27:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41933 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161504AbWJKV1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:27:02 -0400
Date: Wed, 11 Oct 2006 14:26:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 Time: Avoid PIT SMP lockups
Message-Id: <20061011142646.eb41fac3.akpm@osdl.org>
In-Reply-To: <1160596462.5973.12.camel@localhost.localdomain>
References: <1160596462.5973.12.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006 12:54:21 -0700
john stultz <johnstul@us.ibm.com> wrote:

> Andrew: I think this is 2.6.19 material, but probably should go through an -mm or two.
> 
> thanks
> -john
> 
> 
> This patch avoids possible PIT livelock issues seen on SMP systems (and
> reported by Andi), by not allowing it as a clocksource on SMP boxes.
> 
> However, since the PIT may no longer be present, we have to properly
> handle the cases where SMP systems have TSC skew and fall back from the
> TSC. Since the PIT isn't there, it would "fall back" to the TSC again.
> So this changes the jiffies rating to 1, and the TSC-bad rating value to
> 0.
> 
> Thus you will get the following behavior priority on i386 systems:
> 
> tsc		[if present & stable]
> hpet		[if present]
> cyclone		[if present]
> acpi_pm		[if present]
> pit		[if UP]
> jiffies
> 
> Rather then the current more complicated:
> tsc		[if present & stable]
> hpet		[if present]
> cyclone		[if present]
> acpi_pm		[if present]
> pit		[if cpus < 4]

Actually <=4, and that matters: there are a lot of 4-ways.

> tsc		[if present & unstable]
> jiffies
> 

So this patch has the potential to screw up people who have 2-way or 4-way,
no hpet/pm-timer and dodgy TSCs.

Wouldn't it be better to fix the livelock?  What's causing it?
