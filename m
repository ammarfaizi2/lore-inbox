Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWFZRRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWFZRRZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 13:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWFZRRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 13:17:25 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:58257 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751132AbWFZRRY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 13:17:24 -0400
Date: Mon, 26 Jun 2006 13:16:59 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Maneesh Soni <maneesh@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Neela.Kolli@engenio.com, linux-scsi@vger.kernel.org, mike.miller@hp.com,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [RFC] [PATCH 2/2] kdump: cciss driver initialization issue fix
Message-ID: <20060626171659.GG8985@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060623235553.2892f21a.akpm@osdl.org> <20060624111954.GA7313@in.ibm.com> <20060624043046.4e4985be.akpm@osdl.org> <20060624120836.GB7313@in.ibm.com> <m1veqqxyrb.fsf@ebiederm.dsl.xmission.com> <20060626021100.GA12824@in.ibm.com> <20060626133504.GA8985@in.ibm.com> <m11wtcvw5k.fsf@ebiederm.dsl.xmission.com> <20060626153239.GD8985@in.ibm.com> <m13bdrvrd4.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m13bdrvrd4.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 10:00:55AM -0600, Eric W. Biederman wrote:

[..]
> >
> > Looks like there are two problems to be solved.
> >
> > - Framework/capability to mark and isolate the drivers, either at compile
> >   time or run time, which are not hardened enough to initialize properly
> >   when the underlying device is in operational or in unknown state.
> >
> > - Actually hardening a driver to be able to initialize in a potentially
> >   unreliable environment.  
> >
> >
> > Solving first problem will help more in terms of people knowing in advance
> > that certain drivers are known to have problems in specific environemnt and
> > a user has got the option of skipping the execution/compilation of those
> > drivers. (This is something close to what CONFIG_EXPERIMENTAL does)
> >
> > Second problem deals more with actually hardening the driver and not
> > skipping its compilation/execution.
> >
> > I think people would like to change a driver's behaviour at run time.
> > For example if they are booting in a unreliable environment they would
> > like to reset the device otherwise they would skip that as BIOS has
> > already done that for them. 
> 
> In the general case the device reset does not hurt.

I think it does hurt.

- I have seen the case of MPT fusion drvier. It takes significantly more
  time to come up if we choose to reset the device during initialization.
  One of the reasons that we wait in a tight loop for the controller to 
  come up after a reset message.

- Long back we fixed ips driver and I remember that the maintainer had
  a similar issue with the reset of device. He did not want to reset the
  device in normal boot because otherwise it took significantly longer
  for the driver to initialize.

- Just now Mike also confirmed that resetting the device definitely
  hurts in terms of time.

>  Yes there
> is the case of the slow scsi probe.  But a lot of that appears
> to be a poor implementation of the scsi probe.  So I can see a kernel
> command line option to play fast and loose but we should be safe
> and thorough by default.
> 
> The more code paths you introduce the harder code is to maintain
> and test.  The earlier discussion suggested you cannot harden
> some drivers.  We can take action against drivers like that simply
> and easily.
> 
> Hacks in the driver initialization are a completely different story.
> 

So it is matter of making a choice in case the device does not have a
software reset capability.

- Either try to make driver work through some hacks based on crashboot
  option.

- Or mark the driver unusable in kdump scenarios.

Even if one decides to go for second option, at least "crashboot" or
similar parameter will be required so that driver can choose whether
to reset the device or not during initialization due to significant
time penalty. 

Thanks
Vivek
