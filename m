Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWDSOal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWDSOal (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 10:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWDSOal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 10:30:41 -0400
Received: from dvhart.com ([64.146.134.43]:721 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1750799AbWDSOak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 10:30:40 -0400
Message-ID: <4446498D.1080306@mbligh.org>
Date: Wed, 19 Apr 2006 07:30:37 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Arjan van de Ven <arjan@infradead.org>, "Theodore Ts'o" <tytso@mit.edu>,
       Lee Revell <rlrevell@joe-job.com>,
       "Robert M. Stockmann" <stock@stokkie.net>, linux-kernel@vger.kernel.org,
       Randy Dunlap <rddunlap@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andre Hedrick <andre@linux-ide.org>,
       Manfred Spraul <manfreds@colorfullife.com>, Alan Cox <alan@redhat.com>,
       Kamal Deen <kamal@kdeen.net>
Subject: Re: irqbalance mandatory on SMP kernels?
References: <Pine.LNX.4.44.0604171438490.14894-100000@hubble.stokkie.net> <4443A6D9.6040706@mbligh.org> <1145286094.16138.22.camel@mindpipe> <20060418163539.GB10933@thunk.org> <1145384357.2976.39.camel@laptopd505.fenrus.org> <20060419124210.GB24807@harddisk-recovery.com>
In-Reply-To: <20060419124210.GB24807@harddisk-recovery.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw wrote:
> On Tue, Apr 18, 2006 at 08:19:17PM +0200, Arjan van de Ven wrote:
> 
>>>but spreading IRQ's across all of the CPU's doesn't seem like it's
>>>ever the right answer.
>>
>>well it is in some cases, imagine having 2 cpus and 2 gige nics that are
>>very busy doing webserving. That's an obvious case where 1-nic-per-cpu
>>ends up doing the right thing... the way it ends up is that each nic has
>>a full cpu for itself and it's own apaches... almost fully independent
>>of the other one. Now if you moved both irqs to the same cpu, the
>>apaches would follow, because if they didn't then you'd be bouncing
>>their data *all the time*. And at that point the other cpu will become
>>bored ;)
> 
> 
> So what happens with a dual amd64 system where each CPU has its "own"
> NIC? Something like this:
> 
> 
> MEM0 <--> CPU0 <--- HT ---> CPU1 <--> MEM1
>            ^                 ^
>            |                 |
>            HT                HT
>            |                 |
>            v                 v
>       PCI bridge0      PCI1 bridge
>            ^                 ^
>            |                 |
>           PCI               PCI
>            |                 |
>            v                 v
>        GigE NIC0         GigE NIC1
> 
> The "best" approach would be to run an Apache on each CPU using local
> memory and NIC and having the IRQs handled by the local CPU. Does the
> irq balancer allow such a configuraion, or would it be hamperd by the
> process scheduler deciding to run both Apaches on a single CPU?

The trouble is that we're not smart enough to redirect receiving traffic
back to the correct CPU, I think. You'd need to configure different IP
addrs on the same subnet to each NIC, and have intelligent bonding for
outbound traffic.

Then you'd need NUMA locality of IRQs, by bonding them to their closest
CPUs, which is something that's easily done inside the kernel, but is
harder in userspace. but I'm not getting into that silly pissing contest
again. Either mechanism *could* do it. It's just about creating sensbile
APIs and defaults, both of which we're not good at doing as a community.

M.
