Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262755AbVCDKw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262755AbVCDKw1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 05:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbVCDKw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 05:52:26 -0500
Received: from mail.daysofwonder.com ([213.186.49.53]:48513 "EHLO
	mail.daysofwonder.com") by vger.kernel.org with ESMTP
	id S262765AbVCDKuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 05:50:00 -0500
Subject: Re: 2.6.10-ac10 oops in journal_commit_transaction
From: Brice Figureau <brice+lklm@daysofwonder.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050303153754.7a5deecd.akpm@osdl.org>
References: <1109857541.29075.25.camel@localhost.localdomain>
	 <20050303153754.7a5deecd.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 04 Mar 2005 11:51:08 +0100
Message-Id: <1109933468.4728.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Thu, 2005-03-03 at 15:37 -0800, Andrew Morton wrote:
> Brice Figureau <brice+lklm@daysofwonder.com> wrote:
[snip]
> > Unable to handle kernel NULL pointer dereference at virtual address 0000000c
> >  printing eip:
> > c01a858d
> > *pde = 00000000
> > Oops: 0002 [#1]
> > PREEMPT SMP 
> > Modules linked in: i2c_i801 i2c_core ip_conntrack_ftp ipt_LOG ipt_limit ipt_REJECT ipt_state iptable_filter ip_conntrack ip_tables
> > CPU:    2
> > EIP:    0060:[journal_commit_transaction+877/5264]    Not tainted VLI
> > EFLAGS: 00010286   (2.6.10-ac10) 
> > EIP is at journal_commit_transaction+0x36d/0x1490
> 
> Please do:
> 
> gdb vmlinux
> (gdb) l *0xc01a858d

Unfortunately this kernel is not compiled with CONFIG_DEBUG_INFO=y, so
the above command does not work.

But:
(gdb) disassemble 0xc01a858d
Dump of assembler code for function journal_commit_transaction:
[snipped]
...
0xc01a8568 <journal_commit_transaction+840>:	test   %eax,%eax
0xc01a856a <journal_commit_transaction+842>:	jne    0xc01a93bf <journal_commit_transaction+4511>
0xc01a8570 <journal_commit_transaction+848>:	mov    0xfffffea8(%ebp),%edx
0xc01a8576 <journal_commit_transaction+854>:	mov    0x18(%edx),%eax
0xc01a8579 <journal_commit_transaction+857>:	test   %eax,%eax
0xc01a857b <journal_commit_transaction+859>:	je     0xc01a8606 <journal_commit_transaction+998>
0xc01a8581 <journal_commit_transaction+865>:	mov    $0xffffe000,%esi
0xc01a8586 <journal_commit_transaction+870>:	and    %esp,%esi
0xc01a8588 <journal_commit_transaction+872>:	mov    0x20(%eax),%edi
0xc01a858b <journal_commit_transaction+875>:	mov    (%edi),%ebx
0xc01a858d <journal_commit_transaction+877>:	lock incl 0xc(%ebx)
0xc01a8591 <journal_commit_transaction+881>:	mov    (%ebx),%eax
0xc01a8593 <journal_commit_transaction+883>:	test   $0x4,%al
0xc01a8595 <journal_commit_transaction+885>:	jne    0xc01a9379 <journal_commit_transaction+4441>
0xc01a859b <journal_commit_transaction+891>:	mov    %ebx,0x4(%esp)
0xc01a859f <journal_commit_transaction+895>:	mov    0x8(%ebp),%ecx
0xc01a85a2 <journal_commit_transaction+898>:	mov    %ecx,(%esp)
0xc01a85a5 <journal_commit_transaction+901>:	call   0xc01a81d0 <inverted_lock>
0xc01a85aa <journal_commit_transaction+906>:	test   %eax,%eax
0xc01a85ac <journal_commit_transaction+908>:	je     0xc01a9373 <journal_commit_transaction+4435>
0xc01a85b2 <journal_commit_transaction+914>:	mov    (%ebx),%eax
0xc01a85b4 <journal_commit_transaction+916>:	test   $0x20,%ah

So I recompiled my kernel with DEBUG_CONFIG_INFO with the hope that the
code won't move too far and I could find the code:

On the kernel with *debug* enabled:
(gdb) l *0xc01a858d
0xc01a858d is in journal_commit_transaction (buffer_head.h:104).
99	 * Emit the buffer bitops functions.   Note that there are also functions
100	 * of the form "mark_buffer_foo()".  These are higher-level functions which
101	 * do something in addition to setting a b_state bit.
102	 */
103	BUFFER_FNS(Uptodate, uptodate)
104	BUFFER_FNS(Dirty, dirty)
105	TAS_BUFFER_FNS(Dirty, dirty)
106	BUFFER_FNS(Lock, locked)
107	TAS_BUFFER_FNS(Lock, locked)
108	BUFFER_FNS(Req, req)

Which does not seem to match the code included in the oops.

(gdb) disassemble 0xc01a858d
[snip]
0xc01a85c8 <journal_commit_transaction+840>:	test   %eax,%eax
0xc01a85ca <journal_commit_transaction+842>:	jne    0xc01a941f <journal_commit_transaction+4511>
0xc01a85d0 <journal_commit_transaction+848>:	mov    0xfffffea8(%ebp),%edx
0xc01a85d6 <journal_commit_transaction+854>:	mov    0x18(%edx),%eax
0xc01a85d9 <journal_commit_transaction+857>:	test   %eax,%eax
0xc01a85db <journal_commit_transaction+859>:	je     0xc01a8666 <journal_commit_transaction+998>
0xc01a85e1 <journal_commit_transaction+865>:	mov    $0xffffe000,%esi
0xc01a85e6 <journal_commit_transaction+870>:	and    %esp,%esi
0xc01a85e8 <journal_commit_transaction+872>:	mov    0x20(%eax),%edi
0xc01a85eb <journal_commit_transaction+875>:	mov    (%edi),%ebx
0xc01a85ed <journal_commit_transaction+877>:	lock incl 0xc(%ebx)
0xc01a85f1 <journal_commit_transaction+881>:	mov    (%ebx),%eax
0xc01a85f3 <journal_commit_transaction+883>:	test   $0x4,%al
0xc01a85f5 <journal_commit_transaction+885>:	jne    0xc01a93d9 <journal_commit_transaction+4441>
0xc01a85fb <journal_commit_transaction+891>:	mov    %ebx,0x4(%esp)
0xc01a85ff <journal_commit_transaction+895>:	mov    0x8(%ebp),%ecx
0xc01a8602 <journal_commit_transaction+898>:	mov    %ecx,(%esp)
0xc01a8605 <journal_commit_transaction+901>:	call   0xc01a8230 <inverted_lock>
0xc01a860a <journal_commit_transaction+906>:	test   %eax,%eax
0xc01a860c <journal_commit_transaction+908>:	je     0xc01a93d3 <journal_commit_transaction+4435>
0xc01a8612 <journal_commit_transaction+914>:	mov    (%ebx),%eax
0xc01a8614 <journal_commit_transaction+916>:	test   $0x20,%ah

So the same code is now at 0xc01a85ed:
(gdb) l *0xc01a85ed
0xc01a85ed is in journal_commit_transaction (atomic.h:103).
98	 * 
99	 * Atomically increments @v by 1.
100	 */ 
101	static __inline__ void atomic_inc(atomic_t *v)
102	{
103		__asm__ __volatile__(
104			LOCK "incl %0"
105			:"=m" (v->counter)
106			:"m" (v->counter));
107	}

It seems to me that get_bh is the culprit because of the following
definition from include/linux/buffer_head.h:
static inline void get_bh(struct buffer_head *bh)
{
        atomic_inc(&bh->b_count);
}

I hope this will help you. Let me know if you need more information.
Thanks for taking care of that problem,
Regards,
-- 
Brice Figureau <brice+lklm@daysofwonder.com>

