Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753104AbWKFNdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753104AbWKFNdt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 08:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753102AbWKFNdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 08:33:49 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:62689 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1753097AbWKFNdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 08:33:47 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: "Zhao Xiaoming" <xiaoming.nj@gmail.com>
Subject: Re: ZONE_NORMAL memory exhausted by 4000 TCP sockets
Date: Mon, 6 Nov 2006 14:33:50 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, "Linux Netdev List" <netdev@vger.kernel.org>
References: <f55850a70611052207j384e1d3flaf40bb9dd74df7c5@mail.gmail.com> <200611061022.57840.dada1@cosmosbay.com> <f55850a70611060146o1b2adcabq8c1313f6711f3f4e@mail.gmail.com>
In-Reply-To: <f55850a70611060146o1b2adcabq8c1313f6711f3f4e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611061433.50912.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 November 2006 10:46, Zhao Xiaoming wrote:
> 2006/11/6, Eric Dumazet <dada1@cosmosbay.com>:
> > On Monday 06 November 2006 09:59, Zhao Xiaoming wrote:
> > > Thank you again for your help. To have more detailed statistic data, I
> > > did another round of test and gathered some data.  I give the overall
> > > description here and detailed /proc/net/sockstat, /proc/meminfo,
> > > /proc/slabinfo and /proc/buddyinfo follows.
> > > =====================================================
> > >                            slab mem cost        tcp mem pages      
> > > lowmem free with traffic:             254668KB                 34693
> > >       38772KB
> > > without traffic:       104080KB                           1
> > >        702652KB
> > > =====================================================
> >
> > Thank you for detailed infos.
> >
> > It appears you have an extensive use of threads (about 10000), since :
> > > task_struct        10095  10095   1360    3    1 : tunables   24   12
> > >   8 : slabdata   3365   3365      0
> >
> > Each thread has a kernel stack, 8KB (ie 2 pages, order-1 allocation),
> > plus a user vma
> >
> > > vm_area_struct     21346  21504     92   42    1 : tunables  120   60
> > >   8 : slabdata    512    512      0
> >
> > Most likely you dont need that much threads. A program with fewer threads
> > will perform better and use less ram.
>
> Thanks for the comments. I known the threads may cost many memory.
> However, I already excluded them from the statistics. The 'after test'
> info was gotten while the 10000 threads running but no traffics
> relayed. You may look at the meminfo of 'after test', there is still
> 104080 kB slab memory which should already included the thread kernel
> memory cost (8K*10000=80MB). I know 10000 threads are not necessary
> and just use the simple logic to do some test.

In fact, your kernel has CONFIG_4KSTACKS, kernel thread stacks use 4K instead 
of 8K.

If you want to increase LOWMEM, (and keep 32bits kernel), you can chose a 
2G/2G user/kernel split, instead of the 3G/1G default split.
(see config : CONFIG_VMSPLIT_2G)

Eric
