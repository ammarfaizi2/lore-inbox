Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbTJLFHo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 01:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263423AbTJLFHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 01:07:44 -0400
Received: from pop.gmx.net ([213.165.64.20]:1435 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263415AbTJLFHj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 01:07:39 -0400
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20031012060658.01e3b840@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sun, 12 Oct 2003 07:11:33 +0200
To: Manfred Spraul <manfred@colorfullife.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.0-test7 DEBUG_PAGEALLOC oops
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <3F883F19.5000603@colorfullife.com>
References: <5.2.1.1.2.20031011172153.01e49948@pop.gmx.net>
 <5.2.1.1.2.20031011120059.01e81718@pop.gmx.net>
 <5.2.1.1.2.20031011120059.01e81718@pop.gmx.net>
 <5.2.1.1.2.20031011172153.01e49948@pop.gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_3973437==_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_3973437==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

At 07:34 PM 10/11/2003 +0200, Manfred Spraul wrote:
>Mike Galbraith wrote:
>
>>
>>Ok, you want do_IRQ assembler, correct?
>
>No - I need the function that was interrupted by common_interrupt.

Aha. (/me sees light [a wee bit late])

>I found only one valid function pointer in the stack dump above 
>common_interrupt:
>
>0xc0112a13, EBP=0xc0349f88
>
>Could you look it up in your System.map?

It's in apm_bios_call_simple()...

>Which power management do you use? apm or acpi?

...and booting with apm=off cures the explosions.  (uhoh... crud bios?)

         -Mike

--=====================_3973437==_
Content-Type: text/plain; charset="us-ascii"

00000134 <apm_bios_call_simple>:
     134:	55                   	push   %ebp
     135:	b8 00 e0 ff ff       	mov    $0xffffe000,%eax
     13a:	89 e5                	mov    %esp,%ebp
     13c:	21 e0                	and    %esp,%eax
     13e:	83 ec 1c             	sub    $0x1c,%esp
     141:	57                   	push   %edi
     142:	56                   	push   %esi
     143:	53                   	push   %ebx
}

/**
 *	apm_bios_call_simple	-	make a simple APM BIOS 32bit call
 *	@func: APM function to invoke
 *	@ebx_in: EBX register value for BIOS call
 *	@ecx_in: ECX register value for BIOS call
 *	@eax: EAX register on return from the BIOS call
 *
 *	Make a BIOS call that does only returns one value, or just status.
 *	If there is an error, then the error code is returned in AH
 *	(bits 8-15 of eax) and this function returns non-zero. This is
 *	used for simpler BIOS operations. This call may hold interrupts
 *	off for a long time on some laptops.
 */

static u8 apm_bios_call_simple(u32 func, u32 ebx_in, u32 ecx_in, u32 *eax)
{
     144:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     147:	8b 4d 10             	mov    0x10(%ebp),%ecx
	u8			error;
	APM_DECL_SEGS
	unsigned long		flags;
	cpumask_t		cpus;
	int			cpu;
	struct desc_struct	save_desc_40;


	cpus = apm_save_cpus();
	
	cpu = get_cpu();
     14a:	ff 40 14             	incl   0x14(%eax)
	save_desc_40 = cpu_gdt_table[cpu][0x40 / 8];
     14d:	a1 40 00 00 00       	mov    0x40,%eax
     152:	8b 15 44 00 00 00    	mov    0x44,%edx
     158:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
     15b:	89 55 f4             	mov    %edx,0xfffffff4(%ebp)
	cpu_gdt_table[cpu][0x40 / 8] = bad_bios_desc;
     15e:	a1 34 00 00 00       	mov    0x34,%eax
     163:	8b 15 38 00 00 00    	mov    0x38,%edx
     169:	a3 40 00 00 00       	mov    %eax,0x40
     16e:	89 15 44 00 00 00    	mov    %edx,0x44

	local_save_flags(flags);
     174:	9c                   	pushf  
     175:	8f 45 ec             	popl   0xffffffec(%ebp)
	APM_DO_CLI;
     178:	83 3d 20 00 00 00 00 	cmpl   $0x0,0x20
     17f:	74 03                	je     184 <apm_bios_call_simple+0x50>
     181:	fb                   	sti    
     182:	eb 01                	jmp    185 <apm_bios_call_simple+0x51>
     184:	fa                   	cli    
	APM_DO_SAVE_SEGS;
     185:	8c 65 fc             	movl   %fs,0xfffffffc(%ebp)
     188:	8c 6d f8             	movl   %gs,0xfffffff8(%ebp)
	/*
	 * N.B. We do NOT need a cld after the BIOS call
	 * because we always save and restore the flags.
	 */
	__asm__ __volatile__(APM_DO_ZERO_SEGS
     18b:	8b 45 08             	mov    0x8(%ebp),%eax
     18e:	1e                   	push   %ds
     18f:	06                   	push   %es
     190:	31 d2                	xor    %edx,%edx
     192:	8e da                	mov    %edx,%ds
     194:	8e c2                	mov    %edx,%es
     196:	8e e2                	mov    %edx,%fs
     198:	8e ea                	mov    %edx,%gs
     19a:	57                   	push   %edi
     19b:	55                   	push   %ebp
     19c:	2e ff 1d 20 00 00 00 	lcall  *%cs:0x20
     1a3:	0f 92 c3             	setb   %bl <== 0xc0112a13 is HERE
     1a6:	5d                   	pop    %ebp
     1a7:	5f                   	pop    %edi
     1a8:	07                   	pop    %es
     1a9:	1f                   	pop    %ds
     1aa:	89 45 e8             	mov    %eax,0xffffffe8(%ebp)
     1ad:	8b 45 14             	mov    0x14(%ebp),%eax
     1b0:	8b 55 e8             	mov    0xffffffe8(%ebp),%edx
     1b3:	89 10                	mov    %edx,(%eax)
	error = apm_bios_call_simple_asm(func, ebx_in, ecx_in, eax);
	APM_DO_RESTORE_SEGS;
     1b5:	8e 65 fc             	movl   0xfffffffc(%ebp),%fs
     1b8:	8e 6d f8             	movl   0xfffffff8(%ebp),%gs
	local_irq_restore(flags);
     1bb:	ff 75 ec             	pushl  0xffffffec(%ebp)
     1be:	9d                   	popf   
	cpu_gdt_table[smp_processor_id()][0x40 / 8] = save_desc_40;
     1bf:	8b 45 f0             	mov    0xfffffff0(%ebp),%eax
     1c2:	8b 55 f4             	mov    0xfffffff4(%ebp),%edx
     1c5:	a3 40 00 00 00       	mov    %eax,0x40
     1ca:	89 15 44 00 00 00    	mov    %edx,0x44
/* how to get the thread information struct from C */
static inline struct thread_info *current_thread_info(void)
{
	struct thread_info *ti;
	__asm__("andl %%esp,%0; ":"=r" (ti) : "0" (~8191UL));
     1d0:	b8 00 e0 ff ff       	mov    $0xffffe000,%eax
     1d5:	21 e0                	and    %esp,%eax
	put_cpu();
     1d7:	ff 48 14             	decl   0x14(%eax)
#endif

static __inline__ int constant_test_bit(int nr, const volatile unsigned long * addr)
{
	return ((1UL << (nr & 31)) & (((const volatile unsigned int *) addr)[nr >> 5])) != 0;
     1da:	8b 40 08             	mov    0x8(%eax),%eax
     1dd:	a8 08                	test   $0x8,%al
     1df:	74 05                	je     1e6 <apm_bios_call_simple+0xb2>
     1e1:	e8 fc ff ff ff       	call   1e2 <apm_bios_call_simple+0xae>
	apm_restore_cpus(cpus);
	return error;
     1e6:	0f b6 c3             	movzbl %bl,%eax
     1e9:	5b                   	pop    %ebx
     1ea:	5e                   	pop    %esi
     1eb:	5f                   	pop    %edi
     1ec:	89 ec                	mov    %ebp,%esp
     1ee:	5d                   	pop    %ebp
     1ef:	c3                   	ret    

--=====================_3973437==_--

