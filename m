Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbUKJSws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbUKJSws (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 13:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbUKJSws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 13:52:48 -0500
Received: from mail.aknet.ru ([217.67.122.194]:13575 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S262029AbUKJSwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 13:52:42 -0500
Message-ID: <4192638C.6040007@aknet.ru>
Date: Wed, 10 Nov 2004 21:53:00 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: prasanna@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] kprobes: dont steal interrupts from vm86
References: <20041109130407.6d7faf10.akpm@osdl.org> <20041110104914.GA3825@in.ibm.com>
In-Reply-To: <20041110104914.GA3825@in.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------060304050306020100090409"
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060304050306020100090409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

Prasanna S Panchamukhi wrote:
>> With kprobes enabled, vm86 doesn't feel
>> good. The problem is that kprobes steal
>> the interrupts (mainly int3 I think) from
>> it for no good reason.
> If the int3 is not registered through kprobes,
> kprobes handler does not handle it and it falls through the
> normal int3 handler AFAIK.
I was considering this, but I convinced
myself that checking the VM flag is good
in any case, because, as I presume, you
never need the interrupts from v86. Or do
you?
If there is a bug in kprobes, it would be
good to fix either, but I just think it
will not make my patch completely useless.

> Could you please provide a test case to show that kprobes 
> steals the interrupts.
Sure, attached. But it is not perfect: on
the patched kernel it passes the test, but
on the unpatched one (2.6.9), it just Oopses
the kernel without printing any reasonable
diagnostic. Because of the Oops, I can't
demonstrate the interrupt theft right away,
but I hope the test-case for the Oops in
kprobe_exceptions_notify() may also be
interesting for you.


--------------060304050306020100090409
Content-Type: text/x-csrc;
 name="trap.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="trap.c"

#include <stdio.h>
#include <string.h>
#include <inttypes.h>
#include <unistd.h>
#include <sys/mman.h>

#include <linux/unistd.h>
#include <asm/vm86.h>

_syscall2(int, vm86, int, func, struct vm86plus_struct *, v86)

static inline void set_bit(uint8_t *a, unsigned int bit)
{
    a[bit / 8] |= (1 << (bit % 8));
}

static inline uint8_t *seg_to_linear(unsigned int seg, unsigned int reg)
{
    return (uint8_t *)((seg << 4) + (reg & 0xffff));
}

int main()
{
    uint8_t *vm86_mem;
    int ret, seg, arg, insn;
    struct vm86plus_struct ctx;
    struct vm86_regs *r;

    vm86_mem = mmap((void *)0x00000000, 0x110000, 
                    PROT_WRITE | PROT_READ | PROT_EXEC, 
                    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
    if (vm86_mem == MAP_FAILED) {
        perror("mmap");
        return 1;
    }

    memset(&ctx, 0, sizeof(ctx));
    /* init basic registers */
    r = &ctx.regs;
    r->eip = 0x100;
    r->esp = 0xfffe;
    seg = 256;
    r->cs = seg;
    r->ss = seg;
    r->ds = seg;
    r->es = seg;
    r->fs = seg;
    r->gs = seg;
    r->eflags = VIF_MASK;

    /* put return code */
    set_bit((uint8_t *)&ctx.int_revectored, 3);
    *seg_to_linear(r->cs, r->eip) = 0xcc;	/* int3 */
    *seg_to_linear(r->cs, r->eip + 1) = 0xf4;	/* hlt */

do_vm86:
    ret = vm86(VM86_ENTER, &ctx);
    arg = VM86_ARG(ret);
    insn = *seg_to_linear(r->cs, r->eip);
    switch(VM86_TYPE(ret)) {
        case VM86_INTx:
	    printf("vm86: INT 0x%x\n", VM86_ARG(ret));
            break;
        case VM86_STI:
        case VM86_SIGNAL:
            /* a signal came, we just ignore that */
	    goto do_vm86;
            break;
        case VM86_TRAP:
	    if (arg == 3)
		printf("vm86: Trap 3 - All OK\n");
	    else
		printf("Unknown trap %#x\n", arg);
	    break;
        case VM86_UNKNOWN:
	    if (insn == 0xf4)
		printf("vm86: HLT, test failed\n");
	    else
		printf("vm86: unknown result, insn=%#x\n", insn);
        default:
            fprintf(stderr, "unhandled vm86 return code (0x%x)\n", ret);
    }
    return 0;
}

--------------060304050306020100090409--
