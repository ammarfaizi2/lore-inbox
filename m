Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWJEPlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWJEPlO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 11:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWJEPlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 11:41:14 -0400
Received: from mx1.suse.de ([195.135.220.2]:24018 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932148AbWJEPlM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 11:41:12 -0400
From: Andi Kleen <ak@suse.de>
To: Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.18-mm2 boot failure on x86-64
Date: Thu, 5 Oct 2006 17:40:58 +0200
User-Agent: KMail/1.9.3
Cc: Badari Pulavarty <pbadari@us.ibm.com>, Martin Bligh <mbligh@mbligh.org>,
       vgoyal@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       kmannth@us.ibm.com, Andy Whitcroft <apw@shadowen.org>
References: <20060928014623.ccc9b885.akpm@osdl.org> <1160061173.9569.43.camel@dyn9047017100.beaverton.ibm.com> <1160062332.29690.10.camel@flooterbu>
In-Reply-To: <1160062332.29690.10.camel@flooterbu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610051740.58511.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2006 17:32, Steve Fox wrote:
> On Thu, 2006-10-05 at 08:12 -0700, Badari Pulavarty wrote:
> 
> > Can you post the latest panic stack again (with CONFIG_DEBUG_KERNEL) ? 
> 
> CONFIG_DEBUG_KERNEL should be on
> 
> > Last time I couldn't match your instruction dump to any code segment
> > in the routine. And also, can you post your .config file. I have
> > an amd64 and em64t machine and both work fine...
> 
> Unable to handle kernel NULL pointer dereference at 0000000000000827 RIP:
>  [<ffffffff804705e6>] xfrm_register_mode+0x36/0x60
> PGD 0
> Oops: 0000 [1] SMP
> CPU 0
> Modules linked in:
> Pid: 1, comm: swapper Not tainted 2.6.18-git22 #1
> RIP: 0010:[<ffffffff804705e6>]  [<ffffffff804705e6>] xfrm_register_mode+0x36/0x60
> RSP: 0000:ffff810bffcbded0  EFLAGS: 00010286
> RAX: 000000000000081f RBX: ffffffff805588a0 RCX: 0000000000000000
> RDX: ffffffffffffffff RSI: 0000000000000002 RDI: ffffffff80559550
> RBP: 00000000ffffffef R08: 000000003f924371 R09: 0000000000000000
> R10: ffff810bffcbdcb0 R11: 0000000000000154 R12: 0000000000000000
> R13: ffff810bffcbdef0 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffffffff805d2000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: 0000000000000827 CR3: 0000000000201000 CR4: 00000000000006e0
> Process swapper (pid: 1, threadinfo ffff810bffcbc000, task ffff810bffcbb4e0)
> Stack:  0000000000000000 ffffffff8061fb48 0000000000000000 ffffffff80207182
>  0000000000000000 0000000000000000 0000000000000000 0000000000000000
>  0000000000000000 0000000000000000 0000000000000000 0000000000090000

Please don't snip the Code: line. It is fairly important.

> 
> The base config file I'm using is at
> http://flooterbu.net/kernel/elm3b239-2.6.17.config

My guess is that something is wrong with the global variable it is accessing.
Can you post the output of grep -5 xfrm_policy_afinfo ? 

I wonder if that variable overlaps something else.

And please add a 
printk("global %p\n",  xfrm_policy_afinfo[family]);
at the beginning of net/xfrm/xfrm_poliy.c:xfrm_policy_lock_afinfo
and post the output.

If not then it's possible
that some nearby variable is overflowing or similar. Adding some padding
around xfrm_policy_afinfo would show that. 

Another way if that global is proven to be corrupted will be to add
checks all over the boot process to track down where it gets corrupted.

-Andi
