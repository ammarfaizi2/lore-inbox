Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423000AbWCUS2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423000AbWCUS2K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 13:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422821AbWCUS2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 13:28:09 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:27614 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1423000AbWCUS2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 13:28:07 -0500
Date: Tue, 21 Mar 2006 19:28:06 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: linux-kernel@vger.kernel.org
Subject: ring buffer indices: way too much modulo (division!) fiddling
Message-ID: <20060321182806.GA2691@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

"Just One" shocking example (2.6.16 arch/i386/kernel/apm.c):

static apm_event_t get_queued_event(struct apm_user *as)
{
        as->event_tail = (as->event_tail + 1) % APM_MAX_EVENTS;
        return as->events[as->event_tail];
}

objdump x86 output:

000007cf <get_queued_event>:
     7cf:       83 ec 08                sub    $0x8,%esp
     7d2:       ba 67 66 66 66          mov    $0x66666667,%edx
     7d7:       89 74 24 04             mov    %esi,0x4(%esp)
     7db:       89 1c 24                mov    %ebx,(%esp)
     7de:       89 c6                   mov    %eax,%esi
     7e0:       8b 58 24                mov    0x24(%eax),%ebx
     7e3:       83 c3 01                add    $0x1,%ebx
     7e6:       89 d8                   mov    %ebx,%eax
     7e8:       89 d9                   mov    %ebx,%ecx
     7ea:       f7 ea                   imul   %edx
     7ec:       c1 f9 1f                sar    $0x1f,%ecx
     7ef:       c1 fa 03                sar    $0x3,%edx
     7f2:       29 ca                   sub    %ecx,%edx
     7f4:       6b d2 14                imul   $0x14,%edx,%edx
     7f7:       29 d3                   sub    %edx,%ebx
     7f9:       0f b7 44 5e 28          movzwl 0x28(%esi,%ebx,2),%eax
     7fe:       89 5e 24                mov    %ebx,0x24(%esi)
     801:       8b 1c 24                mov    (%esp),%ebx
     804:       8b 74 24 04             mov    0x4(%esp),%esi
     808:       83 c4 08                add    $0x8,%esp
     80b:       c3                      ret


Doing it The Probably Proper Way (tm):

static apm_event_t get_queued_event(struct apm_user *as)
{
        if (++as->event_tail >= APM_MAX_EVENTS)
              as->event_tail = 0;
        return as->events[as->event_tail];
}

objdump x86 output:

000007cf <get_queued_event>:
     7cf:       8b 48 24                mov    0x24(%eax),%ecx
     7d2:       31 d2                   xor    %edx,%edx
     7d4:       83 c1 01                add    $0x1,%ecx
     7d7:       83 f9 14                cmp    $0x14,%ecx
     7da:       0f 4c d1                cmovl  %ecx,%edx
     7dd:       89 50 24                mov    %edx,0x24(%eax)
     7e0:       0f b7 44 50 28          movzwl 0x28(%eax,%edx,2),%eax
     7e5:       c3                      ret


Result: no painful division avoidance (0x66666667 factors, imul), *vastly*
shorter function (22 vs. 60 bytes), most likely **WAY** faster
(no multiplication cycle burning, better pipelining, less opcodes).

Any problems with such a change that I'm missing here?

If such a change holds water, then I'd strongly suggest creating a new
(arch-specific?) macro named something like

ringbuf_advance_idx(my_idx_var, MY_BUF_SIZE)


(any more generic name? It's not always about ring buffers...)

to be used all over the place instead of custom-writing stuff (and getting it
imperfect/wrong) in many cases.
This would be a perfect job for kernel-janitors, if you ask me.

Or does there happen to be a macro already for such a rather common operation?


This kind of unnecessary modulo operation happens in lots of places (mostly
network drivers).
Probably the most prominent (read: painful) place is
./mm/hugetlb.c/alloc_fresh_huge_page()
(if I judge that place right; I cannot easily verify it since I don't have and
don't know how to configure a NUMA machine setup/image)
So, additional question:
can anyone confirm that alloc_fresh_huge_page() binary code uses an expensive
division or multiplication on a NUMA machine?

Comments?

Andreas Mohr
