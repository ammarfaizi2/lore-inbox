Return-Path: <linux-kernel-owner+w=401wt.eu-S1751984AbXARHMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbXARHMG (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 02:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751990AbXARHMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 02:12:06 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41410 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbXARHME (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 02:12:04 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: vgoyal@in.ibm.com
Cc: Benjamin Romer <benjamin.romer@unisys.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Update disable_IO_APIC to use 8-bit destination field (X86_64)
References: <1169052407.3082.43.camel@ustr-romerbm-2.na.uis.unisys.com>
	<m1tzyp8o8v.fsf@ebiederm.dsl.xmission.com>
	<20070118034153.GA5406@in.ibm.com> <20070118043639.GA12459@in.ibm.com>
Date: Thu, 18 Jan 2007 00:10:55 -0700
In-Reply-To: <20070118043639.GA12459@in.ibm.com> (Vivek Goyal's message of
	"Thu, 18 Jan 2007 10:06:39 +0530")
Message-ID: <m1tzyo7qtc.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:


>> Hi Eric,
>> 
>> In physical destination mode, the destination APIC is determined by
>> APIC ID and in logical destination mode, destination apics are determined
>> by the configurations based on LDR and DFR registers in APIC (Depending
>> on Flat mode or cluster mode).
>> 
>> Looks like previously one supported only 4bit apic ids if system is
>> operating in physical mode and 8bit ids if IOAPIC is put in logical
>> destination mode. That's why, struct IO_APIC_route_entry is containing
>> 4bits for physical apic id.
>> 
>> http://www.intel.com/design/chipsets/datashts/290566.htm
>> 
>> And now newer systems have switched to 8bit apic ids in physical mode.
>> That's why if somebody is crashing on a cpu whose apic id is more than
>> 16, kexec/kdump code will fail as 4bits are not sufficient.
>> 
>> Hence above change makes sense. Given the fact that logical and physical
>> apic id is basically a union, it will work even for older systems where
>> physical apic ids were 4bits only.
>> 
>> OTOH, I think down the line we can get rid of physical dest
>> field all together in struct IO_APIC_route_entry and use logical dest
>> field.
>> 
>
> Or how about making physical_dest field also 8bit like logical_dest field.
> This will work both for 4bit and 8bit physical apic ids at the same time
> code becomes more intutive and it is easier to know whether IOAPIC is being
> put in physical or destination logical mode.

Exactly what I was trying to suggest.

Looking closer at the code I think it makes sense to just kill the union and
stop the discrimination between physical and logical modes and just have a
dest field in the structure.  Roughly as you were suggesting at first.

The reason we aren't bitten by this on a regular basis is the normal code
path uses logical.logical_dest in both logical and physical modes.
Which is a little confusing.

Since there really isn't a distinction to be made we should just stop
trying, which will make maintenance easier :)

Currently there are several non-common case users of physical_dest
that are probably bitten by this problem under the right
circumstances.

So I think we should just make the structure:

struct IO_APIC_route_entry {
	__u32	vector		:  8,
		delivery_mode	:  3,	/* 000: FIXED
					 * 001: lowest prio
					 * 111: ExtINT
					 */
		dest_mode	:  1,	/* 0: physical, 1: logical */
		delivery_status	:  1,
		polarity	:  1,
		irr		:  1,
		trigger		:  1,	/* 0: edge, 1: level */
		mask		:  1,	/* 0: enabled, 1: disabled */
		__reserved_2	: 15;

	__u32	__reserved_3	: 24,
		__dest		:  8;
} __attribute__ ((packed));

And fixup the users.  This should keep us from getting bit by this bug
in the future.  Like when people start introducing support for more
than 256 cores and the low 24bits start getting used.

Or when someone new starts working on the code and thinks the fact
the field name says logical we are actually using the apic in logical
mode.

Eric
