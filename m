Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965005AbVHOWOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbVHOWOR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 18:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbVHOWOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 18:14:17 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:3559 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965005AbVHOWOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 18:14:16 -0400
Date: Tue, 16 Aug 2005 00:14:05 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, George Anzinger <george@mvista.com>,
       frank@tuxrocks.com, Anton Blanchard <anton@samba.org>,
       benh@kernel.crashing.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
In-Reply-To: <1123726394.32531.33.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0508152115480.3728@scrub.home>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com>
 <1123726394.32531.33.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 10 Aug 2005, john stultz wrote:

> 	Here's the next rev in my rework of the current timekeeping subsystem.
> No major changes, only some cleanups and further splitting the larger
> patches into smaller ones.
> 
> The goal of this patch set is to provide a simplified and streamlined
> common timekeeping infrastructure that architectures can optionally use
> to avoid duplicating code with other architectures.

It's still the same old abstraction. Let's try it in OO terms why it's the 
wrong one. What basically is needed is something like this:

	base clock	-> continuous clock	-> clock implemention
			-> tick clock		-> ....

The base clock class is an abstract class which provides the basic time 
services like get time, set time...
The continuous clock class and tick clock class are also abstract classes,
but provide basic template functions, which can be used by the actual 
implementations do most of the work.

What you do with your patches is to just provide an abstract class for 
continous clocks and tick based clocks have to emulate a continuous clock. 
Please provide the right abstractions, e.g. leave the gettimeofday 
implementation to the timesource and use some helper (template) functions 
to do the actual work. Basically as long as you have a cycle_t in the 
common code something is really wrong, this code belongs in the continous 
clock template.

This also allows better implementations, e.g. gettimeofday can be done in 
a single step instead of two using a single lock instead of two.

bye, Roman
