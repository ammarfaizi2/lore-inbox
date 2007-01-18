Return-Path: <linux-kernel-owner+w=401wt.eu-S1751998AbXARIAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbXARIAU (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 03:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752004AbXARIAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 03:00:20 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:53282 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751999AbXARIAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 03:00:19 -0500
Date: Thu, 18 Jan 2007 13:30:03 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Benjamin Romer <benjamin.romer@unisys.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Update disable_IO_APIC to use 8-bit destination field (X86_64)
Message-ID: <20070118080003.GC31860@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <1169052407.3082.43.camel@ustr-romerbm-2.na.uis.unisys.com> <m1tzyp8o8v.fsf@ebiederm.dsl.xmission.com> <20070118034153.GA5406@in.ibm.com> <20070118043639.GA12459@in.ibm.com> <m1tzyo7qtc.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1tzyo7qtc.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2007 at 12:10:55AM -0700, Eric W. Biederman wrote:
> Vivek Goyal <vgoyal@in.ibm.com> writes:
> >
> > Or how about making physical_dest field also 8bit like logical_dest field.
> > This will work both for 4bit and 8bit physical apic ids at the same time
> > code becomes more intutive and it is easier to know whether IOAPIC is being
> > put in physical or destination logical mode.
> 
> Exactly what I was trying to suggest.
> 
> Looking closer at the code I think it makes sense to just kill the union and
> stop the discrimination between physical and logical modes and just have a
> dest field in the structure.  Roughly as you were suggesting at first.
> 
> The reason we aren't bitten by this on a regular basis is the normal code
> path uses logical.logical_dest in both logical and physical modes.
> Which is a little confusing.
> 
> Since there really isn't a distinction to be made we should just stop
> trying, which will make maintenance easier :)
> 
> Currently there are several non-common case users of physical_dest
> that are probably bitten by this problem under the right
> circumstances.
> 
> So I think we should just make the structure:
> 
> struct IO_APIC_route_entry {
> 	__u32	vector		:  8,
> 		delivery_mode	:  3,	/* 000: FIXED
> 					 * 001: lowest prio
> 					 * 111: ExtINT
> 					 */
> 		dest_mode	:  1,	/* 0: physical, 1: logical */
> 		delivery_status	:  1,
> 		polarity	:  1,
> 		irr		:  1,
> 		trigger		:  1,	/* 0: edge, 1: level */
> 		mask		:  1,	/* 0: enabled, 1: disabled */
> 		__reserved_2	: 15;
> 
> 	__u32	__reserved_3	: 24,
> 		__dest		:  8;
> } __attribute__ ((packed));
> 
> And fixup the users.  This should keep us from getting bit by this bug
> in the future.  Like when people start introducing support for more
> than 256 cores and the low 24bits start getting used.
> 
> Or when someone new starts working on the code and thinks the fact
> the field name says logical we are actually using the apic in logical
> mode.

This makes perfect sense to me. Ben, interested in providing a patch 
for this?

Thanks
Vivek
