Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263518AbUJ2Vln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263518AbUJ2Vln (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 17:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263652AbUJ2Viq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 17:38:46 -0400
Received: from soundwarez.org ([217.160.171.123]:2212 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S263600AbUJ2V24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 17:28:56 -0400
Date: Fri, 29 Oct 2004 23:28:56 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: Greg KH <greg@kroah.com>
Cc: Andrew <cmkrnl@speakeasy.net>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] 2.6.10.rc1.bk6 /lib/kobject_uevent.c buffer issues
Message-ID: <20041029212856.GA12582@vrfy.org>
References: <20041027142925.GA17484@imladris.arnor.me> <20041027152134.GA13991@kroah.com> <417FCD78.6020807@speakeasy.net> <20041029201314.GA29171@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029201314.GA29171@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 03:13:15PM -0500, Greg KH wrote:
> On Wed, Oct 27, 2004 at 12:31:52PM -0400, Andrew wrote:
> > 
> > Greg KH wrote:
> > >
> > >
> > >Why not just use the same buffer?  We should be able to do that.
> > >
> > >
> > >I'd prefer we use the same buffer.  Care to respin your patch?
> > >
> > 
> > Sure, I can only see two ways of achieving that however.
> > 1) Change the API of kset_hotplug_ops.hotplug() to return the amount
> >    of consumed buffer (and possibly an updated value for i (num_envp)
> >    and then changing every real function that implements that interface
> >    or
> > 2) Spin through the envp[] starting at i to NUM_ENVP looking for a NULL
> >    pointer dropping back 1 (last_used) then do a
> >    scratch += strlen(envp[last_used]) + 1
> 
> Ick, ok, let's stick with 2 buffers.  How about the patch below?  It's a
> bit smaller than yours.
> 
> But there might still be a problem.  With this change, the sequence
> number is not sent out the kevent message.  Kay, do you think this is an
> issue?  I don't think we can get netlink messages out of order, right?

Right, especially not the events with the same DEVPATH, like "remove"
beating an "add". But I'm not sure if the number isn't useful. Whatever
we may do with the hotplug over netlink in the future, we will only have
/sbin/hotplug for the early boot and it may be nice to know, what events
we have already handled...

> I'll hold off on applying this patch until we figure this out...

How about just reserving 20 bytes for the number (u64 will never be
more than that), save the pointer to that field, and fill the number in
later?

Thanks,
Kay
