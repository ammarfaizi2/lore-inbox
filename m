Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWAXXsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWAXXsV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 18:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWAXXsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 18:48:21 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:25019 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750865AbWAXXsU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 18:48:20 -0500
Subject: Re: first bisection results in -mm3 [was: Re: 2.6.15-mm2: reiser3
	oops on suspend and more (bonus oops shot!)]
From: john stultz <johnstul@us.ibm.com>
To: Mattia Dongili <malattia@linux.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060124230453.GA6174@inferi.kami.home>
References: <1137108362.2890.141.camel@cog.beaverton.ibm.com>
	 <20060114120816.GA3554@inferi.kami.home>
	 <1137442582.27699.12.camel@cog.beaverton.ibm.com>
	 <20060116204057.GC3639@inferi.kami.home>
	 <1137458964.27699.65.camel@cog.beaverton.ibm.com>
	 <20060117174953.GA3529@inferi.kami.home>
	 <1137525090.27699.92.camel@cog.beaverton.ibm.com>
	 <20060117224951.GA3320@inferi.kami.home>
	 <16839.83.103.117.254.1137581235.squirrel@picard.linux.it>
	 <1138141635.15682.92.camel@cog.beaverton.ibm.com>
	 <20060124230453.GA6174@inferi.kami.home>
Content-Type: text/plain
Date: Tue, 24 Jan 2006 15:48:17 -0800
Message-Id: <1138146498.15682.99.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-25 at 00:04 +0100, Mattia Dongili wrote:
> On Tue, Jan 24, 2006 at 02:27:14PM -0800, john stultz wrote:
> > difficult spot is that if the cpufreq notification driver is a module,
> > then there will always be a window between the point at which we start
> > using the TSC to the point where we find out that the TSC is changing
> > frequency. Not sure what to do here just yet.
> 
> I was wondering if you could force an do_gettimeofday call quite early
> in order to lower tsc priority as soon as possible, but maybe I'm not
> entirely into that code :)

Well, it isn't do_gettimeofday that needs to be called, but we need a
way to decide if we should call tsc_mark_unstable(). Currently we do
that when we get a cpufreq transition notification if the cpu's TSC is
not constant.  The problem being: on your system, that notification
isn't called until after the cpufreq driver module loads. This is of
course, after we've started to use the TSC.

If the cpufreq driver loaded earlier, or we had some other way of
checking if the TSC was not constant, we could call tsc_mark_unstable()
then.

We'll probably have to do a manual check like what the cpufreq driver
does early on so we can have this info before we install the TSC
clocksource. I'll let you know when I have a patch to try.


> > Although I'm curious: Did the recent changes in 2.6.16-rc1-mm2 had any
> > effect on this issue?
> 
> no, I'm currently running it and the same behaviour still applies.

Drat. Well, thanks for testing.

-john

