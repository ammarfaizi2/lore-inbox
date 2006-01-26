Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWAZHv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWAZHv3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 02:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWAZHv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 02:51:29 -0500
Received: from palrel11.hp.com ([156.153.255.246]:18597 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S1751016AbWAZHv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 02:51:28 -0500
Date: Wed, 25 Jan 2006 23:48:50 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: perfctr-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, perfmon@napali.hpl.hp.com,
       "Eranian, Stephane" <stephane.eranian@hp.com>,
       Andrew Morton <akpm@osdl.org>, "Truong, Dan" <dan.truong@hp.com>
Subject: Re: [Perfctr-devel] RE: [perfmon] Re: quick overview of the perfmon2 interface
Message-ID: <20060126074850.GA11138@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <3C87FFF91369A242B9C9147F8BD0908A02C6955C@cacexc04.americas.cpqcorp.net> <1138221212.15295.35.camel@serpentine.pathscale.com> <20060125222844.GB10451@frankl.hpl.hp.com> <1138229203.15295.65.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138229203.15295.65.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan,

On Wed, Jan 25, 2006 at 02:46:43PM -0800, Bryan O'Sullivan wrote:
> On Wed, 2006-01-25 at 14:28 -0800, Stephane Eranian wrote:
> 
> > So it would help if you could
> > name the extended features you referring to. 
> 
> I'm dubious about the hands-off buffer format in general.  Does this
> mean that userspace needs to modprobe a specific set of modules in order
> to do normal sampling?  If so, how do you work around the need for users
> to be root in order to use these interfaces?

As I said, there is a builtin default format that is fairly generic. It does
work for HP Caliper, pfmon, q-tools. I suspect it is good enough for VTUNE.

You need to be root to insert the module. But I believe that for many user
environments, this is more practical than having to recompile a custom kernel.
You can imagine the format being shipped with the tool, when the sysadmin
installs the tool it also installs the module.

> 
> > And perfmon
> > does allow it to continue working using almost all of its kernel code.
> > This is leveraging the custom sampling buffer format support in perfmon.
> > So you can say this is an extended feature that adds complexity.
> > But OTOH, this is one elegant way of supporting an existing interface
> > without breaking all the tools.
> 
> So are you saying that part of the existing oprofile code can be deleted
> if perfmon is merged, and that userspace won't notice?
> 
The part of Oprofile that does actual programming of the PMU can be removed.
The part that stays is the one that deals with recording samples, exporting
samples,  and collecting OS events such as exit, mmap, exec. As the user
level, they need to migrated from the Oprofile way of programming counters
to the perfmon way. This has been done many years ago on Itanium and did
not cause any major problems.

> > We were able to proide this support
> > with a few hundred lines of code without hacking the regular sampling
> > format. Instead we simply created a dedicated PEBS format as a kernel module.
> 
> Does this mean I can't sample the PMCs on a P4 if I don't have the
> special PEBS module loaded?  Do I need to be root to do that?

PEBS is a P4 feature that has two advantages:
	- record the exact IP of where a counter overflows (no skid)
	- the CPU directly record the samples into a memory area designated
	  by the kernel. As such, you only get a PMU when that area fills up.

There are some limitations:
	- you cannot sample on any event
	- the format of a sample is fixed, it does not contain extra PMDs, just
	  IP and some general registers. The process id is not recorded
	  so it is not well suited for system-wide monitoring.
	- it appears to broken for HyperThreading setups.

So, it all depends on what you are after. Some people do care about avoiding
the skid of regular sampling and they want they like PEBS just for that. Others
would like to record a set of extra PMDs (PERFCTR) and they are willing to
compromise a bit on the skid of IP, so they can live with the default format.

-- 
-Stephane
