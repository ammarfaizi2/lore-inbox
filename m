Return-Path: <linux-kernel-owner+w=401wt.eu-S1752085AbXARSOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbXARSOr (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 13:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbXARSOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 13:14:47 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57104 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085AbXARSOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 13:14:46 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Benjamin Romer <benjamin.romer@unisys.com>
Cc: vgoyal@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Update disable_IO_APIC to use 8-bit destination field  (X86_64)
References: <1169052407.3082.43.camel@ustr-romerbm-2.na.uis.unisys.com>
	<m1tzyp8o8v.fsf@ebiederm.dsl.xmission.com>
	<20070118034153.GA5406@in.ibm.com> <20070118043639.GA12459@in.ibm.com>
	<m1tzyo7qtc.fsf@ebiederm.dsl.xmission.com>
	<20070118080003.GC31860@in.ibm.com>
	<1169141034.6665.6.camel@ustr-romerbm-2.na.uis.unisys.com>
Date: Thu, 18 Jan 2007 11:14:30 -0700
In-Reply-To: <1169141034.6665.6.camel@ustr-romerbm-2.na.uis.unisys.com>
	(Benjamin Romer's message of "Thu, 18 Jan 2007 12:23:54 -0500")
Message-ID: <m14pqo6w3d.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Romer <benjamin.romer@unisys.com> writes:

> On Thu, 2007-01-18 at 13:30 +0530, Vivek Goyal wrote:
>> On Thu, Jan 18, 2007 at 12:10:55AM -0700, Eric W. Biederman wrote:
>> > Vivek Goyal <vgoyal@in.ibm.com> writes:
>> > >
>> > > Or how about making physical_dest field also 8bit like logical_dest field.
>> > > This will work both for 4bit and 8bit physical apic ids at the same time
>> > > code becomes more intutive and it is easier to know whether IOAPIC is
> being
>> > > put in physical or destination logical mode.
>> > 
>> > Exactly what I was trying to suggest.
>> > 
>> > Looking closer at the code I think it makes sense to just kill the union and
>> > stop the discrimination between physical and logical modes and just have a
>> > dest field in the structure.  Roughly as you were suggesting at first.
>> > 
>> > The reason we aren't bitten by this on a regular basis is the normal code
>> > path uses logical.logical_dest in both logical and physical modes.
>> > Which is a little confusing.
>> > 
>> > Since there really isn't a distinction to be made we should just stop
>> > trying, which will make maintenance easier :)
>> > 
>> > Currently there are several non-common case users of physical_dest
>> > that are probably bitten by this problem under the right
>> > circumstances.
>> > 
>> > So I think we should just make the structure:
>> > 
>> > struct IO_APIC_route_entry {
>> > 	__u32	vector		:  8,
>> > 		delivery_mode	:  3,	/* 000: FIXED
>> > 					 * 001: lowest prio
>> > 					 * 111: ExtINT
>> > 					 */
>> > 		dest_mode	:  1,	/* 0: physical, 1: logical */
>> > 		delivery_status	:  1,
>> > 		polarity	:  1,
>> > 		irr		:  1,
>> > 		trigger		:  1,	/* 0: edge, 1: level */
>> > 		mask		:  1,	/* 0: enabled, 1: disabled */
>> > 		__reserved_2	: 15;
>> > 
>> > 	__u32	__reserved_3	: 24,
>> > 		__dest		:  8;
>> > } __attribute__ ((packed));
>> > 
>> > And fixup the users.  This should keep us from getting bit by this bug
>> > in the future.  Like when people start introducing support for more
>> > than 256 cores and the low 24bits start getting used.
>> > 
>> > Or when someone new starts working on the code and thinks the fact
>> > the field name says logical we are actually using the apic in logical
>> > mode.
>> 
>> This makes perfect sense to me. Ben, interested in providing a patch 
>> for this?
>> 
>> Thanks
>> Vivek
>
> OK, here's the updated patch that uses the new definition and fixes up
> the other places that use it. I built and tested this on the ES7000/ONE
> and it works well. :)

Cool.

I hate to pick nits by why the double underscore on dest?

>  struct IO_APIC_route_entry {
> -	__u32	vector		:  8,
> -		delivery_mode	:  3,	/* 000: FIXED
> -					 * 001: lowest prio
> -					 * 111: ExtINT
> -					 */
> -		dest_mode	:  1,	/* 0: physical, 1: logical */
> -		delivery_status	:  1,
> -		polarity	:  1,
> -		irr		:  1,
> -		trigger		:  1,	/* 0: edge, 1: level */
> -		mask		:  1,	/* 0: enabled, 1: disabled */
> -		__reserved_2	: 15;
> -
> -	union {		struct { __u32
> -					__reserved_1	: 24,
> -					physical_dest	:  4,
> -					__reserved_2	:  4;
> -			} physical;
> -
> -			struct { __u32
> -					__reserved_1	: 24,
> -					logical_dest	:  8;
> -			} logical;
> -	} dest;
> +        __u32   vector          :  8,
> +                delivery_mode   :  3,   /* 000: FIXED
> +                                         * 001: lowest prio
> +                                         * 111: ExtINT
> +                                         */
> +                dest_mode       :  1,   /* 0: physical, 1: logical */
> +                delivery_status :  1,
> +                polarity        :  1,
> +                irr             :  1,
> +                trigger         :  1,   /* 0: edge, 1: level */
> +                mask            :  1,   /* 0: enabled, 1: disabled */
> +                __reserved_2    : 15;
>  
> +        __u32   __reserved_3    : 24,
> +                __dest          :  8;
>  } __attribute__ ((packed));
>  
>  /*
