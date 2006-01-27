Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161003AbWA0UQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161003AbWA0UQo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 15:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161006AbWA0UQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 15:16:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8899 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161003AbWA0UQm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 15:16:42 -0500
Date: Fri, 27 Jan 2006 12:16:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: dada1@cosmosbay.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
       shai@scalex86.org, netdev@vger.kernel.org, pravins@calsoftinc.com
Subject: Re: [patch 3/4] net: Percpufy frequently used variables --
 proto.sockets_allocated
Message-Id: <20060127121602.18bc3f25.akpm@osdl.org>
In-Reply-To: <20060127195227.GA3565@localhost.localdomain>
References: <20060126185649.GB3651@localhost.localdomain>
	<20060126190357.GE3651@localhost.localdomain>
	<43D9DFA1.9070802@cosmosbay.com>
	<20060127195227.GA3565@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>
> On Fri, Jan 27, 2006 at 09:53:53AM +0100, Eric Dumazet wrote:
> > Ravikiran G Thirumalai a écrit :
> > >Change the atomic_t sockets_allocated member of struct proto to a 
> > >per-cpu counter.
> > >
> > >Signed-off-by: Pravin B. Shelar <pravins@calsoftinc.com>
> > >Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
> > >Signed-off-by: Shai Fultheim <shai@scalex86.org>
> > >
> > Hi Ravikiran
> > 
> > If I correctly read this patch, I think there is a scalability problem.
> > 
> > On a big SMP machine, read_sockets_allocated() is going to be a real killer.
> > 
> > Say we have 128 Opterons CPUS in a box.
> 
> read_sockets_allocated is being invoked when when /proc/net/protocols is read,
> which can be assumed as not frequent.  
> At sk_stream_mem_schedule(), read_sockets_allocated() is invoked only 
> certain conditions, under memory pressure -- on a large CPU count machine, 
> you'd have large memory, and I don't think read_sockets_allocated would get 
> called often.  It did not atleast on our 8cpu/16G box.  So this should be OK 
> I think.

That being said, the percpu_counters aren't a terribly successful concept
and probably do need a revisit due to the high inaccuracy at high CPU
counts.  It might be better to do some generic version of vm_acct_memory()
instead.

If the benchmarks say that we need to.  If we cannot observe any problems
in testing of existing code and if we can't demonstrate any benefit from
the patched code then one option is to go off and do something else ;)

