Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129177AbQKPAbS>; Wed, 15 Nov 2000 19:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129279AbQKPAbJ>; Wed, 15 Nov 2000 19:31:09 -0500
Received: from [213.8.185.152] ([213.8.185.152]:64264 "EHLO callisto.yi.org")
	by vger.kernel.org with ESMTP id <S129177AbQKPAam>;
	Wed, 15 Nov 2000 19:30:42 -0500
Date: Thu, 16 Nov 2000 02:00:00 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: Guus Sliepen <guus@warande3094.warande.uu.nl>
cc: linux-kernel <linux-kernel@vger.kernel.org>, netfilter@us5.samba.org
Subject: Re: (iptables) ip_conntrack bug?
In-Reply-To: <Pine.LNX.4.21.0011160131050.18364-100000@callisto.yi.org>
Message-ID: <Pine.LNX.4.21.0011160152340.18364-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I have also seen this happen on a box which ran test9. Apparently because of
> > > it's long uptime, because the logs should no signs of an attack.
> > > 
> > > I guess conntrack forgets to flush some entries? Or maybe there is no way it can
> > > recover from a full conntrack table? Is it maybe necessary to make the maximum
> > > size a configurable option? Or a userspace conntrack daemon like the arpd?
> > 
> > From reading the sources I got the impression that the use count of
> > the ip_conntrack struct isn't decremented properly. This causes
> > destroy_conntrack() not to free ip_conntrack's - which results allocation
> > until the maximum (ip_conntrack_max), and failing to allocate new ones.
> 
> I think I got something, icmp_error_track() increases the use count
> (calling ip_conntrack_find_get()) when it returns with no error (not NULL). 
> Whoever calls icmp_error_track() and gets a valid pointer to ip_conntrack, 
> must call ip_conntrack_put() - look at ip_conntrack_in(), line 685, the
> pointer is just used in a boolean expression without calling
> ip_conntrack_put(). I'm not sure if other places needed fixing, but anyway
> try this patch:

I'm not sure this works, since the use count also counts for skb's,
icmp_error_track(), makes the skb refer to this conntrack in case of
success, intentually not calling ip_conntrack_put(). 

So now I'm clueless, although I'm almost certain it's a use count
problem. I'd be happy to hear from Rusty or someone on the netfilter
mailing list about this.

-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
