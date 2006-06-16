Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751030AbWFPEXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbWFPEXq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 00:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbWFPEXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 00:23:46 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62919 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751030AbWFPEXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 00:23:45 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: dlezcano@fr.ibm.com
Cc: serue@us.ibm.com, haveblue@us.ibm.com, clg@fr.ibm.com, dlezcano@fr.ibm.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC] [patch 0/6] [Network namespace] introduction
References: <20060609210202.215291000@localhost.localdomain>
Date: Thu, 15 Jun 2006 22:23:29 -0600
Message-ID: <m1mzcdpw3i.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My apologies for not looking at this earlier I had an email
hickup so I'm having to recreate the context from email archives,
and you didn't copy me.

Have you seen my previous work in this direction?

I know I had a much much more complete implementation.  The only part
I had not completed was iptables support and that was about a days
more work.

> The following patches create a private "network namespace" for use
> within containers. This is intended for use with system containers
> like vserver, but might also be useful for restricting individual
> applications' access to the network stack.
> 
> These patches isolate traffic inside the network namespace. The
> network ressources, the incoming and the outgoing packets are
> identified to be related to a namespace.
> 
> It hides network resource not contained in the current namespace, but
> still allows administration of the network with normal commands like
> ifconfig.
> 
> It applies to the kernel version 2.6.17-rc6-mm1

A couple of comments.

> ------------
>    - do unshare with the CLONE_NEWNET flag as root
>    - do echo eth0 > /sys/kernel/debug/net_ns/dev
>    - use ifconfig or ip command to set a new ip address
> 
> What is missing ?
> -----------------
> The routes are not yet isolated, that implies:
> 
>    - binding to another container's address is allowed
> 
>    - an outgoing packet which has an unset source address can
>      potentially get another container's address
> 
>    - an incoming packet can be routed to the wrong container if there
>      are several containers listening to the same addr:port

I haven't looked at the patches in enough detail to see how the network
isolation is being done exactly.  But some of these comments and some
of the other pieces I have seen don't give me warm fuzzies.

In particular I did not see a provision for multiple instance of
the loopback device.

As a general rule network sockets and network devices should be attached
to the network namespaces, which basically preserves all of the existing
network stack logic.

Basically this means that the only operations that get more expensive
are reads of global variables, which take a necessary extra indirection.

As a general rule I found that it usually makes sense to add an additional
namespace field to hash tables so they can still use the boot time
memory allocator.  Although if you already have a network device as
part of your hash table key that isn't necessary for the network
stack.

Eric
