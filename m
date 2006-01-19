Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161410AbWASUb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161410AbWASUb0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 15:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161412AbWASUb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 15:31:26 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:4285 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161410AbWASUbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 15:31:25 -0500
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Andrew Morton <akpm@osdl.org>, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>,
       openib-general@openib.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: RFC: ipath ioctls and their replacements
References: <1137631411.4757.218.camel@serpentine.pathscale.com>
	<m1y81cpqt8.fsf@ebiederm.dsl.xmission.com>
	<1137688158.3693.29.camel@serpentine.pathscale.com>
	<m1hd80oz9b.fsf@ebiederm.dsl.xmission.com>
	<1137696611.3693.63.camel@serpentine.pathscale.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 19 Jan 2006 13:29:17 -0700
In-Reply-To: <1137696611.3693.63.camel@serpentine.pathscale.com> (Bryan
 O'Sullivan's message of "Thu, 19 Jan 2006 10:50:11 -0800")
Message-ID: <m1slrkneqq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bryan O'Sullivan" <bos@pathscale.com> writes:

> On Thu, 2006-01-19 at 11:20 -0700, Eric W. Biederman wrote:
>
>> For high performance
>> non-IP targeted networking cards you aren't doing anything terribly
>> exotic.
>
> True.
>
>>   Could you please detail why you can't use the IB/rdma
>> whatever helper layer, is insufficient to do what you need.  
>
> There really isn't an RDMA helper layer.  The fact that the IB headers
> live in include/rdma is, as best as I can tell, an artefact of Roland
> being accommodating to someone's suggestion when he was going through
> the same process with the IB tree as we are now with our driver.

The fact that this didn't go farther is part of my complaint,
and part of what needs to be refactored.

>> Right now it largely seems to be a chicken and the egg problem.
>> There is a large portion of the HPC community that doesn't believe
>> they are interesting to the rest of the world or that the rest of
>> the world is interesting to them so they do they own thing leading
>> to support problems.
>
> I can't solve that problem.  If other vendors don't want to pony up
> their driver source and take the same kinds of slings and arrows I'm
> doing, I'm not going to do the work to provide them with a generic set
> of abstractions to use in their out-of-tree or proprietary drivers.

Agreed. Part of the problem is the IB layer is insufficient, or
at least you perceive it that way.  At that level if you can express
your problems we can get the IB layer fixed.

As for other drivers I know I can get modifiable source, and I know I
can get user pressure to hook it into a standard interface if there
is one.

Most of this should have been sorted out with getting a solid infiniband
layer into the kernel.  Since it didn't I'm at least want to get the
interface right for next time.

>> Which is the RDMA thing.  And looking at the code and I don't see how
>
> Your sentence ends in the middle.

Sorry. I was in the middle of noticing how incomplete the RDMA layer
was.  I guess that just makes my sentence

>> >> Again this is a generic problem, and the generic interfaces are broken
>> >> if you can't do this.
>
>> But SIOCSIFFLAGS is not implemented by a driver.
>
> I can't square these two statements.  Can you indicate what you might
> have been talking about, if not SIOCSIFFLAGS?

I was saying that this functionality sounds like something that should
be part of a generic layer.  The IFF_UP from SIOCSIFFLAGS bit seems to
behave exactly how you want.   But this maps to the network driver
methods open and close.  No driver implements SIOCSIFFFLAGS.

Basically my point was that the helper layers appear insufficient
to your needs.

>> Is it the stack that is byzantine?  Or the interface too it.
>
> Both.

This is my other point.  Your driver puts packets on infiniband.
Your hardware potentially supports more IB protocols than the driver
for mellanox's hardware  The IB stack does not serve you well.

Except not being a member of the IB verbs camp there is nothing
your hardware does that is exotic enough for the IB layer to
fall down.  All of the kernel-bypass is used for other protocols
to IB.

So right now it looks like 2 things going on.
1) The IB stack poorly supports your driver.
   - IB stack problem.  If you could help point out what
     is wrong with the IB stack that would be great.

2) ipath doesn't seem to want to use the IB stack as a helper
   layer for it's fast path protocol.
   My sympathies are with you about the IB stack, it integrates
   rather badly with the networking layer, so likely has
   other issues.
   But you at least have to be willing to budge a little or
   these hard problems can't be fixed.

For those who need the buzz words to understand what is going
on the ipath hardware largely does stateless offload for IB while
the mellanox hardware does whole protocol offload.  Which would
mean if this was a normal network driver ipath good mellanox bad.

So something is broken if the our generic layers don't support the
kind of hardware the linux kernel developers profess to prefer.

Eric
