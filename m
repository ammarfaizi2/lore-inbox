Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264310AbTDPLh6 (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 07:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264313AbTDPLh6 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 07:37:58 -0400
Received: from mx02.cyberus.ca ([216.191.240.26]:41994 "EHLO mx02.cyberus.ca")
	by vger.kernel.org with ESMTP id S264310AbTDPLh5 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 07:37:57 -0400
Date: Wed, 16 Apr 2003 07:49:02 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Catalin BOIE <util@deuroconsult.ro>
cc: Tomas Szepe <szepe@pinerecords.com>, "" <linux-kernel@vger.kernel.org>,
       "" <netdev@oss.sgi.com>, "" <manfred@colorfullife.com>,
       "" <kuznet@ms2.inr.ac.ru>
Subject: Re: [PATCH] qdisc oops fix
In-Reply-To: <Pine.LNX.4.53.0304160838001.25861@hosting.rdsbv.ro>
Message-ID: <20030416072952.E4013@shell.cyberus.ca>
References: <20030415084706.O1131@shell.cyberus.ca>
 <Pine.LNX.4.53.0304160838001.25861@hosting.rdsbv.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This is a different problem from previous one posted.

Theres a small window (exposed given that you are provisioning a lot
of qdiscs  and running traffic at the same time) that an incoming packet
interupt will cause the BUG().

GFP_ATOMIC will fix it, but i wonder if it appropriate.

Alexey or Manfred?

cheers,
jamal

PS:- 15mbits is not a lot of traffic ;->

On Wed, 16 Apr 2003, Catalin BOIE wrote:

> > -       sch = kmalloc(size, GFP_KERNEL);
> > +       sch = kmalloc(size, GFP_ATOMIC);
> >
> > mysteriously fixes the problem? Could the problem be elsewhere?
> > Can you repost what the issue was? I am not on lk and i just saw the
> > posting on a web page.
>
> With many rules (~5000 classes and ~3500 qdiscs and ~50000 filters)
> the kernel oopses in slab.c:1128.
> It happens on high rates (~15mbit).
> On low rates, doesn't.
>
> Seems that an interrupt come and broke the memory allocation.
>
>
> >>EIP; c0127ab4 <kmem_cache_grow+44/1d8>   <=====
>
> >>EAX; ffffffff <END_OF_CODE+3fd31247/????>
> >>EBX; c12c52c0 <END_OF_CODE+ff6508/????>
> >>EDI; c12c52c0 <END_OF_CODE+ff6508/????>
> >>ESP; ceab1c60 <END_OF_CODE+e7e2ea8/????>
>
> Trace; c0127e0f <kmalloc+eb/110>
> Trace; c01d3cac <qdisc_create_dflt+20/bc>
> Trace; d081ecc7 <END_OF_CODE+1054ff0f/????>
> Trace; c01d5265 <tc_ctl_tclass+1cd/214>
> Trace; d0820600 <END_OF_CODE+10551848/????>
> Trace; c01d27e4 <rtnetlink_rcv+298/3bc>
> Trace; c01d0605 <__neigh_event_send+89/1b4>
> Trace; c01d7cd4 <netlink_data_ready+1c/60>
> Trace; c01d7730 <netlink_unicast+230/278>
> Trace; c01d7b73 <netlink_sendmsg+1fb/20c>
> Trace; c01c79d5 <sock_sendmsg+69/88>
> Trace; c01c8b48 <sys_sendmsg+18c/1e8>
> Trace; c0120010 <map_user_kiobuf+8/f8>
>
>
