Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315935AbSETM61>; Mon, 20 May 2002 08:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315936AbSETM60>; Mon, 20 May 2002 08:58:26 -0400
Received: from sol.mixi.net ([208.131.233.11]:31368 "EHLO sol.mixi.net")
	by vger.kernel.org with ESMTP id <S315935AbSETM60>;
	Mon, 20 May 2002 08:58:26 -0400
X-Envelope-From: <todd@tekinteractive.com>
X-Mailer: emacs 21.1.95.1 (via feedmail 8 I);
	VM 7.05 under Emacs 21.1.95.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15592.62193.715212.569689@rtfm.ofc.tekinteractive.com>
Date: Mon, 20 May 2002 07:58:25 -0500
From: "Todd R. Eigenschink" <todd@tekinteractive.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Re: kswapd OOPS under 2.4.19-pre8 (ext3, Reiserfs + (soft)raid0)
In-Reply-To: <15587.42492.25950.446607@rtfm.ofc.tekinteractive.com>
Reply-To: todd@tekinteractive.com
X-RAVMilter-Version: 8.3.1(snapshot 20020108) (sol)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Todd R. Eigenschink writes:
>Mike Galbraith writes:
>>Methinks there's an easier way to get to the line in question.  Compile sched.c with -g via make kernel/sched.o EXTRA_CFLAGS=-g.. gbd can then be used to get you the line with list *__wake_up+0xb2.


Since the particular snippet of code at the point of oops in the last
one I posted was P3-specified, I recompiled for 586.  The oops remains
the same, although the call stack happens to be a lot longer this
time.

I'm going to run memtest86 on it for a while after it gets done with
its morning processing, although this failure seems a little too
consistent to be memory related.


Trace; c0129b39 <unlock_page+81/88>
Trace; c0139179 <end_buffer_io_async+8d/a8>
Trace; c01b6f45 <end_that_request_first+65/c8>
Trace; c01c1c3c <ide_end_request+68/a8>
Trace; c01c806a <ide_dma_intr+6a/ac>
Trace; c01c38ad <ide_intr+f9/164>
Trace; c01c8000 <ide_dma_intr+0/ac>
Trace; c010a1e1 <handle_IRQ_event+59/84>
Trace; c010a3d9 <do_IRQ+a9/f4>
Trace; c010c568 <call_do_IRQ+5/d>
Trace; c0154b07 <statm_pgd_range+133/1a8>
Trace; c0154c43 <proc_pid_statm+c7/16c>
Trace; c015279e <proc_info_read+5a/118>
Trace; c0137497 <sys_read+8f/104>
Trace; c0108a43 <system_call+33/40>

Code;  c0116383 <__wake_up+3b/c0>
00000000 <_EIP>:
Code;  c0116383 <__wake_up+3b/c0>   <=====
   0:   8b 01                     mov    (%ecx),%eax   <=====
Code;  c0116385 <__wake_up+3d/c0>
   2:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  c0116388 <__wake_up+40/c0>
   5:   74 66                     je     6d <_EIP+0x6d> c01163f0 <__wake_up+a8/c
0>
Code;  c011638a <__wake_up+42/c0>
   7:   31 d2                     xor    %edx,%edx
Code;  c011638c <__wake_up+44/c0>
   9:   9c                        pushf  
Code;  c011638d <__wake_up+45/c0>
   a:   5e                        pop    %esi
Code;  c011638e <__wake_up+46/c0>
   b:   fa                        cli    
Code;  c011638f <__wake_up+47/c0>
   c:   f0 fe 0d 80 99 30 c0      lock decb 0xc0309980
Code;  c0116396 <__wake_up+4e/c0>
  13:   0f 00 00                  sldtl  (%eax)


(gdb) list *__wake_up+0x3b
0x96f is in __wake_up (kernel/sched.c:732).
727                     wait_queue_t *curr = list_entry(tmp, wait_queue_t, task_list);
728
729                     CHECK_MAGIC(curr->__magic);
730                     p = curr->task;
731                     state = p->state;
732                     if (state & mode) {
733                             WQ_NOTE_WAKER(curr);
734                             if (try_to_wake_up(p, sync) && (curr->flags&WQ_FLAG_EXCLUSIVE) && !--nr_exclusive)
735                                     break;
736                     }

