Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262423AbVCITbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbVCITbJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 14:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbVCIT1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 14:27:25 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:2234 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262189AbVCITWP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 14:22:15 -0500
Subject: Re: [PATCH] rwsem: Make rwsems use interrupt disabling spinlocks
From: Badari Pulavarty <pbadari@us.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, suparna@in.ibm.com,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1110389707.24286.156.camel@dyn318077bld.beaverton.ibm.com>
References: <20050309032832.159e58a4.akpm@osdl.org>
	 <20050308170107.231a145c.akpm@osdl.org>
	 <1110327267.24286.139.camel@dyn318077bld.beaverton.ibm.com>
	 <18744.1110364438@redhat.com> <20050309110404.GA4088@in.ibm.com>
	 <1110366469.6280.84.camel@laptopd505.fenrus.org>
	 <4175.1110370343@redhat.com>
	 <1110389707.24286.156.camel@dyn318077bld.beaverton.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1110395911.24286.211.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Mar 2005 11:18:32 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, aio-stress seems to run better with your patch (no Oops) but
I think we still have a problem in AIO. It looks like aio-stress
is stuck (unable to kill it).

Here is the sysrq-t output:

aio-stress    D ffff8101be224970     0 15430      1               15429
(NOTLB)
ffff8101be21bd58 0000000000000082 ffff8101be21be18 0000000000010000
       ffff8101be2248b0 ffff810100000074 000000000000007a
ffff810198868e90
       ffff8101d6daaf50 ffff8101d6dab160
Call Trace:<ffffffff804013c8>{__down+152}
<ffffffff80132750>{default_wake_function+0}
       <ffffffff80402d39>{__down_failed+53}
<ffffffff80161f13>{.text.lock.filemap+65}
       <ffffffff801a23c0>{aio_pwrite+0}
<ffffffff801a23e1>{aio_pwrite+33}
       <ffffffff801a35d0>{__aio_run_iocbs+384}
<ffffffff801a401e>{io_submit_one+494}
       <ffffffff801a4149>{sys_io_submit+217}
<ffffffff8010e5ce>{system_call+126}


Top shows:

top - 12:22:33 up  2:57,  2 users,  load average: 5.08, 5.08, 5.01
Tasks:  79 total,   1 running,  77 sleeping,   0 stopped,   1 zombie
Cpu(s):  0.0% us, 25.0% sy,  0.0% ni, 75.0% id,  0.0% wa,  0.0% hi, 
0.0% si
Mem:   7148100k total,   176708k used,  6971392k free,    18600k buffers
Swap:  1048784k total,        0k used,  1048784k free,    44708k cached
                                                                                                            
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
15425 root      16   0     0    0    0 Z 99.8  0.0 172:17.98 aio-stress
<defunct>
15803 root      16   0  4048 1116  820 R  0.3  0.0   0:00.51 top



Thanks,
Badari


On Wed, 2005-03-09 at 09:35, Badari Pulavarty wrote:
> Your patch seems to have helped. I don't see the Oops anymore - my
> tests are still running (past 1 hour - it used to panic in 10 min).
> 
> Thanks,
> Badari
> 
> On Wed, 2005-03-09 at 04:12, David Howells wrote:
> > The attached patch makes read/write semaphores use interrupt disabling
> > spinlocks, thus rendering the up functions and trylock functions available for
> > use in interrupt context.
> > 
> > I've assumed that the normal down functions must be called with interrupts
> > enabled (since they might schedule), and used the irq-disabling spinlock
> > variants that don't save the flags.
> > 
> > Signed-Off-By: David Howells <dhowells@redhat.com>
> > ---
> > warthog>diffstat -p1 rwsem-irqspin-2611mm2.diff
> 
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
> 

