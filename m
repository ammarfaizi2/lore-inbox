Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWDQVGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWDQVGm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 17:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWDQVGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 17:06:42 -0400
Received: from ns1.siteground.net ([207.218.208.2]:53162 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751281AbWDQVGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 17:06:41 -0400
Date: Mon, 17 Apr 2006 14:07:46 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Laurent Vivier <Laurent.Vivier@bull.net>
Cc: Andrew Morton <akpm@osdl.org>, Mingming Cao <cmm@us.ibm.com>,
       Takashi Sato <sho@tnes.nec.co.jp>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] Re: [RFC][PATCH 0/2]Extend ext3 filesystem limit from 8TB to 16TB
Message-ID: <20060417210746.GB3945@localhost.localdomain>
References: <20060327131049.2c6a5413.akpm@osdl.org> <20060327225847.GC3756@localhost.localdomain> <1143530126.11560.6.camel@openx2.frec.bull.fr> <1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com> <1143623605.5046.11.camel@openx2.frec.bull.fr> <1143682730.4045.145.camel@dyn9047017067.beaverton.ibm.com> <20060329175446.67149f32.akpm@osdl.org> <1144660270.5816.3.camel@openx2.frec.bull.fr> <20060410012431.716d1000.akpm@osdl.org> <1144941999.2914.1.camel@openx2.frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1144941999.2914.1.camel@openx2.frec.bull.fr>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 05:26:39PM +0200, Laurent Vivier wrote:
> Le lun 10/04/2006 à 10:24, Andrew Morton a écrit :
> > Laurent Vivier <Laurent.Vivier@bull.net> wrote:
> > >
> > > Does the attached patch look like the thing you though about ?
> > 
> > I guess so.  But it'll need a lot of performance testing on big SMP
> > to work out what the impact is.
> 
> I made some tests with dbench:
> 
> IBM x440: 8 CPUs hyperthreaded = 16 CPUs (Xeon at 1.4 Ghz)
> 

I ran the same tests on a 16 core EM64T box very similar to the one you ran
dbench on :). Dbench results on ext3 varies quite a bit.  I couldn't get 
to a statistically significant conclusion  For eg,

With atomic counters, 32 clients, 3 runs
Throughput 187.712 MB/sec 32 procs
Throughput 197.059 MB/sec 32 procs
Throughput 203.522 MB/sec 32 procs

Without atomic counters (per-cpu counters), 32 clients, 3 runs
Throughput 228.805 MB/sec 32 procs
Throughput 155.831 MB/sec 32 procs
Throughput 134.777 MB/sec 32 procs

The oprofile profiles for the atomic counter case looks like this:

CPU: P4 / Xeon with 2 hyper-threads, speed 3002.77 MHz (estimated)
Counted GLOBAL_POWER_EVENTS events (time during which processor is not
stopped) with a unit mask of 0x01 (mandatory) count 100000
samples  %        app name                 symbol name
180505286 57.7844  vmlinux-t                poll_idle
51944524 16.6288  vmlinux-t                ext3_test_allocatable
43648955 13.9731  vmlinux-t                bitmap_search_next_usable_block
2892251   0.9259  vmlinux-t                copy_user_generic
2099969   0.6723  vmlinux-t                do_get_write_access
1459523   0.4672  vmlinux-t                journal_dirty_metadata
1393413   0.4461  vmlinux-t                journal_stop

So the atomic counters in question are not even hotspots on this workload,
so IMHO, dbench cannot be used to come to any conclusion regarding per-cpu
counters vs atomics here.

Thanks,
Kiran

