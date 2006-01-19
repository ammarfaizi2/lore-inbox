Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161064AbWASQ3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161064AbWASQ3Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 11:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161277AbWASQ3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 11:29:24 -0500
Received: from mx.pathscale.com ([64.160.42.68]:34010 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1161064AbWASQ3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 11:29:23 -0500
Subject: Re: RFC: ipath ioctls and their replacements
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>,
       openib-general@openib.org, "David S. Miller" <davem@davemloft.net>
In-Reply-To: <m1y81cpqt8.fsf@ebiederm.dsl.xmission.com>
References: <1137631411.4757.218.camel@serpentine.pathscale.com>
	 <m1y81cpqt8.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 19 Jan 2006 08:29:18 -0800
Message-Id: <1137688158.3693.29.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-19 at 01:25 -0700, Eric W. Biederman wrote:

> Do the infiniband verbs not allow dealing with a unreliable datagram
> protocol?

Eric, I think you are misunderstanding what we are actually trying to
do.  We already implement IB verbs and the various IB networking
protocols in our drivers, at a layer that is not at all related to the
one that is currently festooned with ioctls.

The ioctl discussion pertains to lower-level direct user access to the
hardware, for a protocol that bypasses the entire IB stack and just
happens to send UD-compliant datagrams over the wire.

I'm actually pretty satisfied with the feedback I've already gotten from
Greg K-H and davem.

> We need some generic subsystem support to do this.

I am more than happy to put together generic support, provided I see
other drivers that could take advantage of it being considered for
submission.  Right now, I do not - in general - see this happening.

I know that some other drivers need to do user page pinning, and I'm
happy to try to find a generic solution that is common to IB and drivers
unrelated to IB.

> >         RCVCTRL enables/disables receipt of packets.
> 
> Again this is a generic problem, and the generic interfaces are broken
> if you can't do this.

The SIOCSIFFLAGS ioctl, which I assume is the generic interface you
refer to (it's the one used by iproute, at any rate), has poor overlap
with what we need (it supports a pile of stuff that we don't care about,
and we require a pile of stuff it doesn't support), and I don't feel
inclined to try using it in any case.
      
> >         SET_PKEY sets a partition key, essentially telling hardware
> >         which packets are interesting to userspace.
> 
> I'm pretty certain this should be something that should be set
> at open time.

It might be possible to make it fit into whatever replaces USERINIT, or
else we can use a netlink message of its own.

> >         UPDM_TID and FREE_TID are used for RDMA context management.
> >
> >         WAIT waits for incoming packets, and can clearly be replaced by
> >         file_ops->poll.
> >         
> >         GETCOUNTERS, GETUNITCOUNTERS and GETSTATS can all be replaced by
> >         files in sysfs.
> 
> This whole section just cries out for a network/rdma/ib/kernel-by-pass
> layer that is that any interesting network driver can use.

No, it doesn't.  Our chip's approach to remote memory access doesn't
even slightly resemble that of other comparable chips.  In addition, our
counters are entirely device-specific, and I'm already planning to move
them to sysfs.  The sysfs move gets them out of ioctl-land, and there's
no point in trying to do anything beyond that.

> Infiniband stack, it's there use it.

No.  If you're running a full IB stack, we provide the usual IB subnet
management facilities, and you can run OpenSM to manage your subnet.  If
you're *not*, which is the case I'm concerned with here, it makes no
sense to replicate the byzantine IB management interfaces in order to do
a handful of simple things that aren't even tied to the higher-level IB
protocols.

> There are a couple of choices here.

Yes, we'll use the firmware interface, as Greg suggested.

> There is also an interface in /proc or /sys I forget which
> that let's you select the individual bar for a pci device.

Yes, we'll use that.

Thanks for your comments.

	<b

