Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273065AbRI0OTH>; Thu, 27 Sep 2001 10:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273099AbRI0OS5>; Thu, 27 Sep 2001 10:18:57 -0400
Received: from mx0.gmx.net ([213.165.64.100]:47449 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S273065AbRI0OSp>;
	Thu, 27 Sep 2001 10:18:45 -0400
Date: Thu, 27 Sep 2001 16:19:06 +0200 (MEST)
From: Bernd Harries <mlbha@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu
MIME-Version: 1.0
Subject: Re: __get_free_pages(): is the MEM really mine?
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0000450161@gmx.net
X-Authenticated-IP: [141.200.125.99]
Message-ID: <11776.1001600346@www23.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> well - what did you expect to happen? A freed page is going to be reused
> for other purposes. A big 2MB allocation can be reused in part, once
> memory usage grows.

With my knowledge, I expected exactly that.

> So you should not expect the device to be able to DMA
> into a page that got freed, unpunished.

I am not. The DMA ioctl() finishes before the close() -> free happens after
the hexdump and the DMA. The buffer is allocated in open. The fact that I get
the same buffer again next time shows that the free is sucessful and
effective, right?

Sep 27 11:43:28 pcma73 kernel: rsc_open() minor=$1B 
Sep 27 11:43:28 pcma73 kernel:  DMA blk 0 at KV:$CE800000 BUS:$0E800000 
Sep 27 11:43:28 pcma73 kernel:  DMA blk 1 at KV:$CE600000 BUS:$0E600000
contig < 

Sep 27 11:43:28 pcma73 kernel:  Collected DMA Buffer1 at KS:$0000CE600000

Sep 27 11:43:28 pcma73 kernel: rsc_ioctl()
Sep 27 11:43:28 pcma73 kernel:  RSC_IOC_DMA_OUT

Sep 27 11:43:28 pcma73 kernel: rsc_close()

Sep 27 11:43:28 pcma73 kernel:  Free DMA blk 0 at KS:$CE800000 
Sep 27 11:43:28 pcma73 kernel:  Free DMA blk 1 at KS:$CE600000 

> Perhaps i'm misunderstanding the problem.

My problem is, I'm out of ideas. All I can think of is describe as much as
possible the relevant things that I do and the things that occur. Maybe
someone more experienced recognizes a principal flaw in the concept.

> Plus, if you allocate a 2MB
> physically continuous chunk then the likelyhood is high that there were
> fragmented pages skipped during the initial search for a 2MB block - so
> you still have a fair likelyhood to reallocate it after some time, if
> memory usage is light. But this likelyhood nears zero once RAM usage gets
> near 100%.

And I can rely on the fact that all the 2 MB are contig memory without
holes, right? It's completely mine, isn't it?
Or is it perhaps illegal to let the mem usage pump?
Should I better allocate the mem in init_module() instead of rsc_open()?
Probably page tables are more likely to get corrupted than they would be if
I allocate only once. Or do I have to use a spin_lock somewhere in the nopage
method?


>From my tests I'm ready the believe the 1st page really _is_ mine but now
I'm not so sure all the 
(1 << 9) pages really are.

If I don't access the pages, just allocate them and free them after some
time, I never saw any instabilities. But it seems that as soon as I access pages
above the 1st in the buffer, something gets corrupted. So maybe today it's
only legal to allocate 1 page at a time and I have to do that 
(1<<10) times...

Or maybe some of the VM trouble I read about recntly would also cover my
problems?

Thanks,

-- 
Bernd Harries

bha@gmx.de            http://bharries.freeyellow.com
bharries@web.de       Tel. +49 421 809 7343 priv.  | MSB First!
harries@stn-atlas.de       +49 421 457 3966 offi.  | Linux-m68k
bernd@linux-m68k.org       +49 172 139 6054 handy  | Medusa T40

GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net

