Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267474AbSLEWIM>; Thu, 5 Dec 2002 17:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267510AbSLEWIL>; Thu, 5 Dec 2002 17:08:11 -0500
Received: from packet.digeo.com ([12.110.80.53]:12191 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267474AbSLEWIK>;
	Thu, 5 Dec 2002 17:08:10 -0500
Message-ID: <3DEFD00B.555DE931@digeo.com>
Date: Thu, 05 Dec 2002 14:15:39 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.50 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: dipankar@gamebox.net
CC: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       Ravikiran G Thirumalai <kiran@in.ibm.com>
Subject: Re: [patch] kmalloc_percpu  -- 2 of 2
References: <20021204174209.A17375@in.ibm.com> <20021204174550.B17375@in.ibm.com> <3DEE58CB.737259DB@digeo.com> <20021205091217.A11438@in.ibm.com> <3DEED6FA.B179FAFD@digeo.com> <20021205162329.A12588@in.ibm.com> <3DEFB0EB.9893DB9@digeo.com> <20021206025307.A20657@dikhow>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Dec 2002 22:15:39.0439 (UTC) FILETIME=[D7D7F3F0:01C29CAB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma wrote:
> 
> On Thu, Dec 05, 2002 at 09:10:16PM +0100, Andrew Morton wrote:
> >
> > I'd suggest that you drop the new allocator until a compelling
> > need for it (in real, live 2.5/2.6 code) has been demonstrated.
> 
> Fine with me since atleast one workaround for fragmentation with small
> allocations is known. I can't see anything in 2.5 timeframe
> requiring small per-cpu allocations.
> 
> Would you like me to resubmit a simple kmalloc-only version ?
> 

I think that would be best.

BTW, looking at the snmp application of this work:

+#define ICMP_INC_STATS_USER_FIELD(offt)                                \
+       (*((unsigned long *) ((void *)                                  \
+                            per_cpu_ptr(icmp_statistics[1],            \
+                                        smp_processor_id())) + offt))++;

This guy is racy on preempt.  Just a little bit.  It is effectively:

	ptr = per_cpu_ptr(...);
	(*ptr)++;

On some architectures, `(*ptr)++' is not atomic wrt interrupts.  The
CPU could be preempted midway through the increment.

Surely it's not an issue for SNMP stats, but for some applications
such as struct page_state, such a permanent off-by-a-little-bit would
be a showstopper.

So some big loud comments which describe the worthiness of get_cpu_ptr(),
and the potential inaccuracy of per_cpu_ptr would be useful.

And as this is the first application of the kmalloc_precpu infrastructure,
it may be best to convert it to use get_cpu_ptr/put_cpu_ptr.
