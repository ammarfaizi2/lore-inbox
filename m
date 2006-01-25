Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWAYWbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWAYWbX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 17:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWAYWbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 17:31:23 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:47560 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932185AbWAYWbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 17:31:21 -0500
Date: Wed, 25 Jan 2006 14:28:44 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: "Truong, Dan" <dan.truong@hp.com>, Andrew Morton <akpm@osdl.org>,
       "Eranian, Stephane" <stephane.eranian@hp.com>,
       perfmon@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, perfctr-devel@lists.sourceforge.net
Subject: Re: [Perfctr-devel] RE: [perfmon] Re: quick overview of the perfmon2 interface
Message-ID: <20060125222844.GB10451@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <3C87FFF91369A242B9C9147F8BD0908A02C6955C@cacexc04.americas.cpqcorp.net> <1138221212.15295.35.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138221212.15295.35.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan,

On Wed, Jan 25, 2006 at 12:33:32PM -0800, Bryan O'Sullivan wrote:
> On Fri, 2006-01-20 at 10:37 -0800, Truong, Dan wrote:
> > Would you want Stephane to guard the extended
> > functionalities with tunables or something to
> > Disable their regular use and herd enterprise
> > Tools into a standard mold... yet allow R&D to
> > Move on by enabling the extentions?
> 
> I'd prefer to see all of the extended stuff left out entirely for now.

I usually don't add things to the interface just because they are cool
ideas but rather because there is a need expressed by some tool
developer or system person. So it would help if you could
name the extended features you referring to. 

The problem with an incremental approach is to maintained backward compatibility
for existing applications. I have had to deal with this on IA-64. For instance
moving from a single syscall to multiple syscall. Similarly, when passing
data structures, you have to provision some reserved fields for potential
extensions. You don't really want to add more system call if you need to
to add a feature.

> The mainline kernel has no PMU support for any popular architecture,
> even though external patches have existed in stable form for years.

You do not count Oprofile. I think this is a fine tool. And perfmon
does allow it to continue working using almost all of its kernel code.
This is leveraging the custom sampling buffer format support in perfmon.
So you can say this is an extended feature that adds complexity.
But OTOH, this is one elegant way of supporting an existing interface
without breaking all the tools.

Take another example, suppose some tool comes along and say: "I would
like to add in each recorded sample the kernel call stack at the point
of the counter overflow". How would you do this without having to hack
kernel code? With the buffer format, you simply insert of module that
does what you want. There are hundreds of things you can include in your
samples. I don't think that we can come up with a very generic sampling
buffer format.

Sometimes, it is not so much what is recorded but how it is recorded.
Some tool may prefer to have samples aggreagated in the kernel, other
would like to use a double-buffer approach to minimize blind spots.
All are valid requests. Our infrastructure allows this without modification
to the core interface nor core kernel code. I believe this is a very strong
value-add.

Without this infrastructure, it would have been pretty difficult to add
support for the P4 Precise Event Based Sampling (PEBS) which by the way,
nobody was able to offer so far. We were able to proide this support
with a few hundred lines of code without hacking the regular sampling
format. Instead we simply created a dedicated PEBS format as a kernel module.


> Filling that gap ought to be the priority; the interface can be extended
> when actual users of new features show up and ask for them.
> 
Again that is fine as long as you can keep backward complexity and a clean
interface.

> > It would restrict the R&D mindset, and new ideas.
> > The field hasn't grown yet to a stable mature form.
> 
I would agree with you, that people have not yet realized the potential
of those performance counters. But this maybe in part a chicken and egg
problem.  People cannot take full advantage because they don't have
a generic interface on any platform.

Designing a generic perfmon interface is hard because:
	- the hardware is extremely diverse
	- there are so many things you can measure
-- 
-Stephane
