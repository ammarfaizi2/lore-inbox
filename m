Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbTHUPzy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 11:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbTHUPzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 11:55:54 -0400
Received: from ns.suse.de ([195.135.220.2]:8634 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262771AbTHUPzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 11:55:52 -0400
Message-ID: <3F44EB85.5000108@suse.de>
Date: Thu, 21 Aug 2003 17:55:49 +0200
From: Hannes Reinecke <Hannes.Reinecke@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Dumb question: BKL on reboot ?
References: <3F434BD1.9050704@suse.de> <20030820112918.0f7ce4fe.akpm@osdl.org> <20030820113520.281fe8bb.davem@redhat.com> <1061411024.9371.33.camel@nighthawk> <3F447D40.5020000@suse.de> <20030821154113.GE29612@dualathlon.random>
In-Reply-To: <20030821154113.GE29612@dualathlon.random>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Thu, Aug 21, 2003 at 10:05:20AM +0200, Hannes Reinecke wrote:
[ .. ]
>>
>>Exactly what happened here. CPU#1 entered sys_reboot, got BKL and 
>>prepared to stop. It will never release BKL, leaving a nice big window 
>>for CPU#0 to deadlock.
> 
> 
> if that was really the case it shouldn't deadlock, because CPU0
> shouldn't depend on a big kernel lock to be able to re-enable the irqs,
> and to receive the IPI. Nor any IPI handler could ever be allowed to
> take the big kernel lock.
> 
> Unless you can demonstrate a dependency on the big kernel lock for CPU0
> to re-enable the irqs eventually, I can't see how the above could
> deadlock.
>

What happened was this:

================================================================
TASK HAS CPU (0): 0x904000 (kupdated):
  LOWCORE INFO:
   -psw      : 0x400100180000000 0x0000000007aa22
   -function : sync_old_buffers+58
   -prefix   : 0x009c8000
   -cpu timer: 0xfffffa77 0x33465f80
   -clock cmp: 0x00b9e503 0x235324f4
   -general registers:
      0000000000000000 0x000000002e1000
      0x0000000007aa22 0x0000000004919e
      0x00000000907f28 0x0000000022b428
      0000000000000000 0000000000000000
      0x00000000224340 0000000000000000
      0x00000000970000 0x00000000233b00
      0x00000000904000 0x000000001deb60
      0x00000000907e78 0x00000000907dd8
[ .. ]
  STACK:
  0 kupdate+424 [0x7af4c]
  1 arch_kernel_thread+70 [0x18d72]
================================================================
TASK HAS CPU (1): 0x3318000 (reboot):
  LOWCORE INFO:
   -psw      : 0x700100180000000 0x0000007ffe0d8e
   -function : not found in System map
   -prefix   : 0x009c2000
   -cpu timer: 0xfff79e2d 0x014244c0
   -clock cmp: 0x00b9e503 0x3a5d9504
   -general registers:
      0x00000000000001 0000000000000000
      0000000000000000 0000000000000000
      0x0000000001f268 0000000000000000
      0x00000000000003 0x000000000002c0
      0x000000000490f0 0x00000003318000
      0x00000000016422 0000000000000000
      0x00000000000001 0x000000001da280
      0x0000000001f268 0x0000000331bae0
[ .. ]
  STACK:
  0 machine_restart_smp+62 [0x1f5f2]
  1 machine_restart+48 [0x19884]
  2 sys_reboot+306 [0x49222]
  3 sysc_noemu+16 [0x16242]

Not sure why CPU#0 wanted to execute kupdate(), but hey ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Deutschherrnstr. 15-19			+49 911 74053 688
90429 Nürnberg				http://www.suse.de

