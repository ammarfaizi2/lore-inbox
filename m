Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbWA0XOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWA0XOx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 18:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWA0XOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 18:14:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39556 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932508AbWA0XOv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 18:14:51 -0500
Date: Fri, 27 Jan 2006 15:16:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: kiran@scalex86.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
       shai@scalex86.org, netdev@vger.kernel.org, pravins@calsoftinc.com
Subject: Re: [patch 3/4] net: Percpufy frequently used variables --
 proto.sockets_allocated
Message-Id: <20060127151635.3a149fe2.akpm@osdl.org>
In-Reply-To: <43DAA586.5050609@cosmosbay.com>
References: <20060126185649.GB3651@localhost.localdomain>
	<20060126190357.GE3651@localhost.localdomain>
	<43D9DFA1.9070802@cosmosbay.com>
	<20060127195227.GA3565@localhost.localdomain>
	<20060127121602.18bc3f25.akpm@osdl.org>
	<20060127224433.GB3565@localhost.localdomain>
	<43DAA586.5050609@cosmosbay.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <dada1@cosmosbay.com> wrote:
>
> Ravikiran G Thirumalai a écrit :
> > On Fri, Jan 27, 2006 at 12:16:02PM -0800, Andrew Morton wrote:
> >> Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> >>> which can be assumed as not frequent.  
> >>> At sk_stream_mem_schedule(), read_sockets_allocated() is invoked only 
> >>> certain conditions, under memory pressure -- on a large CPU count machine, 
> >>> you'd have large memory, and I don't think read_sockets_allocated would get 
> >>> called often.  It did not atleast on our 8cpu/16G box.  So this should be OK 
> >>> I think.
> >> That being said, the percpu_counters aren't a terribly successful concept
> >> and probably do need a revisit due to the high inaccuracy at high CPU
> >> counts.  It might be better to do some generic version of vm_acct_memory()
> >> instead.
> > 
> > AFAICS vm_acct_memory is no better.  The deviation on large cpu counts is the 
> > same as percpu_counters -- (NR_CPUS * NR_CPUS * 2) ...
> 
> Ah... yes you are right, I read min(16, NR_CPUS*2)

So did I ;)

> I wonder if it is not a typo... I mean, I understand the more cpus you have, 
> the less updates on central atomic_t is desirable, but a quadratic offset 
> seems too much...

I'm not sure whether it was a mistake or if I intended it and didn't do the
sums on accuracy :(

An advantage of retaining a spinlock in percpu_counter is that if accuracy
is needed at a low rate (say, /proc reading) we can take the lock and then
go spill each CPU's local count into the main one.  It would need to be a
very low rate though.   Or we make the cpu-local counters atomic too.

Certainly it's sensible to delegate the tuning to the creator of the
percpu_counter, but it'll be a difficult thing to get right.
