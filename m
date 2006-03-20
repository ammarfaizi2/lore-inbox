Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWCTSeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWCTSeN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 13:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWCTSeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 13:34:13 -0500
Received: from fmr18.intel.com ([134.134.136.17]:62681 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751246AbWCTSeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 13:34:12 -0500
Message-ID: <441EF553.2080803@ichips.intel.com>
Date: Mon, 20 Mar 2006 10:32:51 -0800
From: Sean Hefty <mshefty@ichips.intel.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Frost <artusemrys@sbcglobal.net>
CC: Andrew Morton <akpm@osdl.org>, Sean Hefty <sean.hefty@intel.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org, bunk@stusta.de
Subject: Re: [openib-general] Re: 2.6.16-rc6-mm2: new RDMA CM EXPORT_SYMBOL's
References: <20060319041153.38692.qmail@web81904.mail.mud.yahoo.com>
In-Reply-To: <20060319041153.38692.qmail@web81904.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Frost wrote:
> To the point.  I, insightful betimes, but a non-user of the technology,
> can grep TFM's and find out what the names could mean, but we're left
> guessing at what some of these *do*.  Translating names falls into the
> "any idiot can" category of data mining, but if you code for them, we can
> see context.  If you named them more transparently, we might even use
> them right.  Maybe just comment well?

Documentation in the form of comments are provided in the header files.  I can 
clarify the calls if needed.  To help understand the structure of this patch, 
three modules were submitted:

ib_addr - maps IP addresses to an RDMA device.
rdma_cm - Adds connection management over Infiniband using IP addressing.  This 
exports most of the symbols below.
rdma_ucm - Exports the rdma_cm functionality to userspace.  This uses most of 
the exported symbols (starting at rdma_create_id and below).

> +EXPORT_SYMBOL(rdma_wq); Work Queue (do what to it?)

This is used by ib_addr and rdma_cm modules to invoke user callbacks. 
Additional code not yet ready for merging will also make use of this work queue. 
  The intent is to re-use this work queue, rather than each module creating 
their own.

> +EXPORT_SYMBOL(rdma_translate_ip); Translate IP Address
> +EXPORT_SYMBOL(rdma_resolve_ip); Resolve IP Address
> +EXPORT_SYMBOL(rdma_addr_cancel); Address Cancel (memory?)

These exports are from the ib_addr module.  The routines are called by the 
rdma_cm module.  The first two map an IP address to a local Infiniband device 
address.  Rdma_resolve_ip is an asynchronous call, so rdma_addr_cancel is used 
to cancel its operation.  'rdma_cancel_resolve_ip' might have been a clearer name.

> +EXPORT_SYMBOL(rdma_create_id); Create (?) ID

The rdma_cm_id created by this call is required for the calls below. 
Conceptually, it may help to think of an rdma_cm_id as somewhat like a socket.

> +EXPORT_SYMBOL(rdma_create_qp); Create Queue Pair (WQ,CQ)
> +EXPORT_SYMBOL(rdma_destroy_qp); Destroy Queue Pair (WQ,CQ)

'rdma_create_qp' associates a QP with an rdma_cm_id, so that the rdma_cm can 
perform the QP transitions for the user during connection establishment.

> +EXPORT_SYMBOL(rdma_init_qp_attr); Set Initial Queue Pair Attributes (?)

This initializes the QP attributes for a user that wants to manually perform QP 
transitions.  It is provided mainly for userspace support.

> +EXPORT_SYMBOL(rdma_destroy_id); Destroy (?) ID
> +EXPORT_SYMBOL(rdma_listen); Listen (to ... socket, port, pipe, what?)

Listens across RDMA devices for connection requests.  The listen is on an 
rdma_cm_id.

> +EXPORT_SYMBOL(rdma_resolve_route); Resolve Route (datagram path?)

In Infiniband terms, this obtains a path record from the subnet manager.  The 
path record specifies the route through the subnet that packets between two 
connected queue pairs will take.

> +EXPORT_SYMBOL(rdma_resolve_addr); Resolve Address (memory?)

This converts struct sockaddr to RDMA addresses.  It ends up calling 
rdma_translate_ip and rdma_resolve_ip, but performs some additional work to 
handle device hotplug events.

> +EXPORT_SYMBOL(rdma_bind_addr); Bind Address (memory?)

Associates an rdma_cm_id to a specific struct sockaddr.

> +EXPORT_SYMBOL(rdma_connect); Connect
> +EXPORT_SYMBOL(rdma_accept); Accept
> +EXPORT_SYMBOL(rdma_reject); Reject
> +EXPORT_SYMBOL(rdma_disconnect); Disconnect
> 
> Address vs. IP - I know we're talking about a net/dma kluge here, but the
> twin usage is bugging me.  I'm intuiting the _addr as memory addresses,
> rather than IP addresses, which seem to be _ip, but my poor gray goo
> suffers pointer overload.

Maybe the naming is off here.  I used _ip when referring specifically to an IP 
address, and _addr when using a struct sockaddr.  In some cases, such as 
rdma_bind_addr, the 'address' may be nothing more than a port number.

> +EXPORT_SYMBOL(ib_get_rmpp_segment); Reliable MultiPacket Protocol

This is from a separate patch.  It is exported by the ib_mad module, and used by 
the ib_umad module.  There is at least one out of tree module (not yet ready for 
merging) that will make use of it.

> +EXPORT_SYMBOL(ib_copy_qp_attr_to_user); Push Queue Pair Attribute
> +EXPORT_SYMBOL(ib_copy_path_rec_to_user); Push Path Record
> +EXPORT_SYMBOL(ib_copy_path_rec_from_user); Retrieve Path Record

These are used by ib_uverbs, ib_ucm, and rdma_ucm modules.

> +EXPORT_SYMBOL(ib_modify_qp_is_ok); Yes, Modify Queue Pair, or "QP is
> OK", or "QP was Modified OK"?

This is from a separate patch.  It should be exported by ib_verbs, and used by 
ib_mthca.  The call verifies that the settings to modify a QP from one state to 
the next are valid.  I believe that the check used to be part of the ib_mthca 
driver itself, but additional kernel drivers, such as the ipath driver recently 
submitted for inclusion, now make use of this routine.

> +EXPORT_SYMBOL(ip_dev_find); Find IP device (sub(/ip/, "ib")? find the
> network interface device?)

This is the network call in fib_frontend.c.  It is being re-exported (the export 
was removed a couple of versions ago) for use by ib_addr.

>>Please explain the thinking behind the choice of a non-GPL export. 
>>(Yes, we discussed this when inifiniband was first merged, but it
>>doesn't hurt to reiterate).

The agreement made within the OpenIB community, from where this code originates, 
is that all source code be licensed under a dual license of BSD/GPL.  I am not a 
lawyer, so I don't know the implications of changing the exports to be GPL only, 
given the OpenIB license.  But my understanding is that makes using those 
functions less attractive.

- Sean
