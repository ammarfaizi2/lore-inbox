Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316427AbSETWgV>; Mon, 20 May 2002 18:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316428AbSETWgU>; Mon, 20 May 2002 18:36:20 -0400
Received: from holomorphy.com ([66.224.33.161]:1417 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316427AbSETWgT>;
	Mon, 20 May 2002 18:36:19 -0400
Date: Mon, 20 May 2002 15:36:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Todd R. Eigenschink" <todd@tekinteractive.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: kswapd OOPS under 2.4.19-pre8 (ext3, Reiserfs + (soft)raid0)
Message-ID: <20020520223613.GD2046@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Todd R. Eigenschink" <todd@tekinteractive.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200205160528.g4G5S631019167@sol.mixi.net> <15587.42492.25950.446607@rtfm.ofc.tekinteractive.com> <15592.62193.715212.569689@rtfm.ofc.tekinteractive.com> <20020520170059.GA2046@holomorphy.com> <15593.23568.756199.612888@rtfm.ofc.tekinteractive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2002 at 03:26:56PM -0500, Todd R. Eigenschink wrote:
> Someone else had suggested testing the memory and power supply.
> memtest86 is easy to run, so I'll try that.  It'll have to be tonight,
> now.

Bitflips are usually things where a pointer turns up invalid (or
non-NULL) and the difference between it and a valid pointer (or NULL)
is one bit. I don't see that here and don't like blaming hardware.


On Mon, May 20, 2002 at 03:26:56PM -0500, Todd R. Eigenschink wrote:
> Well, after my posting from earlier today, I recompiled the kernel
> after stripping some more stuff.  I just induced an oops in that one,
> so I can list the call stack for it.

Nice, I presume you've got -g there? Any chance of doing something like
objdump --disassemble --source vmlinux and sending me the annotated
disassembly of __wake_up()? I want to doublecheck something...


On Mon, May 20, 2002 at 03:26:56PM -0500, Todd R. Eigenschink wrote:
> No IDE stuff this time; this looks a lot like most of the other ones
> I've seen.  This morning was the first time I've ever seen IDE stuff
> in the post-oops call stack.

This is pretty strange, yes.


On Mon, May 20, 2002 at 03:26:56PM -0500, Todd R. Eigenschink wrote:
> It seems I can pretty much induce them at will, now.  I started up
> four simultaneous Webtrends sessions, which grow fairly quickly to
> 400-600 MB each, give or take.  (The machine has 2 GB of RAM, so it
> only swaps a little, sometimes.)  Within half an hour, it fell over.
> Here's the oops itself, then the gdb output.

Great stuff! Thanks.


On Mon, May 20, 2002 at 03:26:56PM -0500, Todd R. Eigenschink wrote:
> Oops: 0000
> CPU:    1
> EIP:    0010:[<c0116363>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010087
> eax: c2802db4   ebx: c2002db4   ecx: 00000000   edx: 00000003
> esi: c2802db0   edi: c2802db0   ebp: f7bf3ee8   esp: f7bf3ecc
> ds: 0018   es: 0018   ss: 0018

Okay, %ecx is 0 -- no bitflip, just plain old NULL...


On Mon, May 20, 2002 at 03:26:56PM -0500, Todd R. Eigenschink wrote:
> Code;  c0116363 <__wake_up+3b/c0>
> 00000000 <_EIP>:
> Code;  c0116363 <__wake_up+3b/c0>   <=====
>    0:   8b 01                     mov    (%ecx),%eax   <=====
> Code;  c0116365 <__wake_up+3d/c0>
>    2:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
> Code;  c0116368 <__wake_up+40/c0>
>    5:   74 66                     je     6d <_EIP+0x6d> c01163d0 <__wake_up+a8/c

Okay, the offending instruction is mov (%ecx), %eax -- dereferencing the
NULL %ecx...


On Mon, May 20, 2002 at 03:26:56PM -0500, Todd R. Eigenschink wrote:
> (gdb) list *__wake_up+0x3b
> 0x973 is in __wake_up (sched.c:731).
> 726                     unsigned int state;
> 727                     wait_queue_t *curr = list_entry(tmp, wait_queue_t, task_list);
> 728
> 729                     CHECK_MAGIC(curr->__magic);
> 730                     p = curr->task;
> 731                     state = p->state;
> 732                     if (state & mode) {
> 733                             WQ_NOTE_WAKER(curr);
> 734                             if (try_to_wake_up(p, sync) && (curr->flags&WQ_FLAG_EXCLUSIVE) && !--nr_exclusive)
> 735                                     break;


This makes it pretty clear the offending instruction corresponds to the
first dereference of curr->task. Someone's leaving a NULL pointer in
there when they shouldn't. So this entire call chain has nothing to do
with the offender -- it only trips over the bad pointer the offending
code left behind. This looks like a PITA. The objdump --disassemble
--source stuff is just to have the assembly and source next to each
other for a "more convincing" demonstration, not that this isn't already
pretty good as it stands. Of course, finding the offender will be painful.


Cheers,
Bill
