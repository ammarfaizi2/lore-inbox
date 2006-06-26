Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbWFZPdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbWFZPdH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 11:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbWFZPdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 11:33:07 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:16843 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932484AbWFZPdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 11:33:05 -0400
Date: Mon, 26 Jun 2006 11:32:39 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Maneesh Soni <maneesh@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Neela.Kolli@engenio.com, linux-scsi@vger.kernel.org, mike.miller@hp.com,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [RFC] [PATCH 2/2] kdump: cciss driver initialization issue fix
Message-ID: <20060626153239.GD8985@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060623210121.GA18384@in.ibm.com> <20060623210424.GB18384@in.ibm.com> <20060623235553.2892f21a.akpm@osdl.org> <20060624111954.GA7313@in.ibm.com> <20060624043046.4e4985be.akpm@osdl.org> <20060624120836.GB7313@in.ibm.com> <m1veqqxyrb.fsf@ebiederm.dsl.xmission.com> <20060626021100.GA12824@in.ibm.com> <20060626133504.GA8985@in.ibm.com> <m11wtcvw5k.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m11wtcvw5k.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 08:17:27AM -0600, Eric W. Biederman wrote:
> Vivek Goyal <vgoyal@in.ibm.com> writes:
> 
> > On Mon, Jun 26, 2006 at 07:41:00AM +0530, Maneesh Soni wrote:
> >
> > Maneesh, Keeping this code under a config option becomes a problem when we
> > will have a relocatable kernel. At some point of time we got to have
> > relocatable kernel so that people don't have to build two kernels. In fact
> > this is becoming a pain area for distros. That's the reason I thought
> > of making it a command line parameter.
> 
> Ok. Even if we do this with a command line, we need to have a clean concept.
> If the concept is ignore devices with a brittle init routine that is comprehensible
> and potentially useful for other reasons than crash dumps.
> 

Looks like there are two problems to be solved.

- Framework/capability to mark and isolate the drivers, either at compile
  time or run time, which are not hardened enough to initialize properly
  when the underlying device is in operational or in unknown state.

- Actually hardening a driver to be able to initialize in a potentially
  unreliable environment.  


Solving first problem will help more in terms of people knowing in advance
that certain drivers are known to have problems in specific environemnt and
a user has got the option of skipping the execution/compilation of those
drivers. (This is something close to what CONFIG_EXPERIMENTAL does)

Second problem deals more with actually hardening the driver and not
skipping its compilation/execution.

I think people would like to change a driver's behaviour at run time.
For example if they are booting in a unreliable environment they would
like to reset the device otherwise they would skip that as BIOS has
already done that for them. 

But looks like not all devices have got the capablity to be reset from
software. In those cases probably one need to put some hooks, relax
driver's consistency checks etc in special boot environment.

Here I am trying to solve the second problem so that a driver comes to 
know that it is initializing in a special boot environment and it can
modify its behavior at run time. 

> If the concept is crashdump it is a poorly defined concept and all of Andrews
> objections apply.
> 

I think this parameter is generic enough and not limited to crashdumps.
If a user decides to implement a different scheme than kdump in kexec
on panic and boot a customized kernel, he can very well use this
parameter to make sure that next kernel is able to at least boot and not
panic in between.

Solving first problem will help in doing a plain kexec. We can simply
mark the drivers known to have problems and slowly people can fix those
drivers. Fixing the driver in this case is different because most likely
driver authors will provide a shutdown routine in the driver so that
device can be shutdown and then one can boot into the second kernel.  
Till then a user can happily skip the drivers known to have problems.

In summary, we got two problems to solve. Currently I am focussed on
solving second problem which enables boot a kernel in an unreliable
environment and do some minimal specific operation and then boot back to
regular kernela. So I think just introducing a command line parameter
which drivers can use to determine that they are initializing in an
special environement, solves it and is generic enough.

Options like COFIG_BRITTLE_INIT or sikkping execution of brittle driver
based on a command line option seems to be the solution for the first
problem.

Please correct me if I am wrong. I know little about drivers.


> > I remember few months back, Eric had mentioned that he has got patches for
> > relocatable kernel ready for review for i386 and x86_64. Eric, do you have
> > any plans to post the patches for review?
> 
> I have some code that I keep intending to get to.  It has probably bit rotted
> since I wrote it, but it shouldn't be too bad to clean up.
> Unfortunately the whole crashdump thing is fairly low on my priority list.
> 

I am willing to work on it. Building from scratch always takes more time.
If you are willing, I will more than happy to build on top of your patches.

Thanks
Vivek
