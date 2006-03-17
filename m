Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWCQLaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWCQLaj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 06:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752570AbWCQLaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 06:30:39 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:64738 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751427AbWCQLai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 06:30:38 -0500
Date: Fri, 17 Mar 2006 11:31:31 +0100
From: Holger Eitzenberger <holger@my-eitzenberger.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: kaber@trash.net
Subject: Strange kernel bug
Message-ID: <20060317103131.GA3903@kruemel.my-eitzenberger.de>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>, kaber@trash.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:8548cd0e00552bb75411ff34ad15700a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I see a kernel bug with kernel 2.6.10.  Hardware is UP Pentium 4 CPU
2.40GHz, output from lspci is attached.

This all happens on customers machines, so I am unable to easily
switch to a newer kernel version, sorry.

Everry few hours the machines deadlocks with the following messages:

 <3>scheduling while atomic: swapper/0x00000100/0
 <4> [<c010333e>] dump_stack+0x1e/0x20
 <4> [<c02de278>] schedule+0x458/0x510
 <4> [<c01006bc>] cpu_idle+0x1c/0x50
 <4> [<c0100406>] rest_init+0x26/0x30
 <4> [<c03ee99a>] start_kernel+0x1ba/0x200
 <4> [<c010019f>] L6+0x0/0x2

It seemed quite clear what happened here, so I started to search for
the missing unlock in some error path, which was a quite daunting
task.  So I modified the kernel in order to find out the code 
which called local_bh_disable() before this all happened.  Patch
is attached.  This is the output:

 <3>scheduling while atomic: swapper/0x00000100/0
 <4>bh_users: c011b499
 <4>bh_users: 00000000
 <4> [<c010333e>] dump_stack+0x1e/0x20
 <4> [<c02de278>] schedule+0x458/0x510
 <4> [<c01006bc>] cpu_idle+0x1c/0x50
 <4> [<c0100406>] rest_init+0x26/0x30
 <4> [<c03ee99a>] start_kernel+0x1ba/0x200
 <4> [<c010019f>] L6+0x0/0x2

c01b499 is an address from __do_softirq.  And this is the point I do not
understand currently.

Note that the kernel is patched with some very intrusive patches like
LKCD, KDB and Xen 2.  So I will disable all but KDB and see what
happens.

/holger

-- 


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci

0000:00:00.0 Host bridge: Intel Corp. 82845G/GL[Brookdale-G]/GE/PE DRAM Controller/Host-Hub Interface (rev 03)
0000:00:02.0 VGA compatible controller: Intel Corp. 82845G/GL[Brookdale-G]/GE Chipset Integrated Graphics Device (rev 03)
0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 02)
0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI Bridge (rev 82)
0000:00:1f.0 ISA bridge: Intel Corp. 82801DB/DBL (ICH4/ICH4-L) LPC Bridge (rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801DB/DBL (ICH4/ICH4-L) UltraATA-100 IDE Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 02)
0000:01:07.0 PCI bridge: Pericom Semiconductor: Unknown device 8152
0000:01:09.0 PCI bridge: Pericom Semiconductor: Unknown device 8150 (rev 01)
0000:01:0a.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)
0000:01:0b.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)
0000:01:0c.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)
0000:01:0d.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)
0000:03:08.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 10)
0000:03:09.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 10)
0000:03:0a.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 10)
0000:03:0b.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 10)

--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="__do_softirq.s"

c011b470 <__do_softirq>:
c011b470:	55                   	push   %ebp
c011b471:	b8 00 e0 ff ff       	mov    $0xffffe000,%eax
c011b476:	89 e5                	mov    %esp,%ebp
c011b478:	57                   	push   %edi
c011b479:	bf 0a 00 00 00       	mov    $0xa,%edi
c011b47e:	56                   	push   %esi
c011b47f:	53                   	push   %ebx
c011b480:	83 ec 04             	sub    $0x4,%esp
c011b483:	8b 1d 00 96 42 c0    	mov    0xc0429600,%ebx
c011b489:	21 e0                	and    %esp,%eax
c011b48b:	81 40 14 00 01 00 00 	addl   $0x100,0x14(%eax)
c011b492:	c7 04 24 99 b4 11 c0 	movl   $0xc011b499,(%esp)
c011b499:	e8 c2 00 00 00       	call   c011b560 <push_bh_user>
c011b49e:	89 f6                	mov    %esi,%esi
c011b4a0:	31 d2                	xor    %edx,%edx
c011b4a2:	89 15 00 96 42 c0    	mov    %edx,0xc0429600
c011b4a8:	fb                   	sti    
c011b4a9:	be a0 96 42 c0       	mov    $0xc04296a0,%esi
c011b4ae:	eb 07                	jmp    c011b4b7 <__do_softirq+0x47>
c011b4b0:	83 c6 08             	add    $0x8,%esi
c011b4b3:	d1 eb                	shr    %ebx
c011b4b5:	74 19                	je     c011b4d0 <__do_softirq+0x60>
c011b4b7:	f6 c3 01             	test   $0x1,%bl
c011b4ba:	74 f4                	je     c011b4b0 <__do_softirq+0x40>
c011b4bc:	89 34 24             	mov    %esi,(%esp)
c011b4bf:	90                   	nop    
c011b4c0:	ff 16                	call   *(%esi)
c011b4c2:	ff 05 24 b3 42 c0    	incl   0xc042b324
c011b4c8:	83 c6 08             	add    $0x8,%esi
c011b4cb:	d1 eb                	shr    %ebx
c011b4cd:	75 e8                	jne    c011b4b7 <__do_softirq+0x47>
c011b4cf:	90                   	nop    
c011b4d0:	fa                   	cli    
c011b4d1:	8b 1d 00 96 42 c0    	mov    0xc0429600,%ebx
c011b4d7:	85 db                	test   %ebx,%ebx
c011b4d9:	74 13                	je     c011b4ee <__do_softirq+0x7e>
c011b4db:	4f                   	dec    %edi
c011b4dc:	75 c2                	jne    c011b4a0 <__do_softirq+0x30>
c011b4de:	8b 15 a0 97 42 c0    	mov    0xc04297a0,%edx
c011b4e4:	85 d2                	test   %edx,%edx
c011b4e6:	74 06                	je     c011b4ee <__do_softirq+0x7e>
c011b4e8:	8b 02                	mov    (%edx),%eax
c011b4ea:	85 c0                	test   %eax,%eax
c011b4ec:	75 19                	jne    c011b507 <__do_softirq+0x97>
c011b4ee:	b8 00 e0 ff ff       	mov    $0xffffe000,%eax
c011b4f3:	21 e0                	and    %esp,%eax
c011b4f5:	81 68 14 00 01 00 00 	subl   $0x100,0x14(%eax)
c011b4fc:	e8 7f 00 00 00       	call   c011b580 <pop_bh_user>
c011b501:	58                   	pop    %eax
c011b502:	5b                   	pop    %ebx
c011b503:	5e                   	pop    %esi
c011b504:	5f                   	pop    %edi
c011b505:	5d                   	pop    %ebp
c011b506:	c3                   	ret    
c011b507:	89 d0                	mov    %edx,%eax
c011b509:	e8 b2 80 ff ff       	call   c01135c0 <wake_up_process>
c011b50e:	89 f6                	mov    %esi,%esi
c011b510:	eb dc                	jmp    c011b4ee <__do_softirq+0x7e>
c011b512:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
c011b519:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bh_user.diff"

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 6ef18a8..3b8a1a5 100644
Index: linux-2.6.10/include/linux/interrupt.h
===================================================================
--- linux-2.6.10.orig/include/linux/interrupt.h	2006-03-16 13:55:17.000000000 +0100
+++ linux-2.6.10/include/linux/interrupt.h	2006-03-16 13:55:42.000000000 +0100
@@ -68,11 +68,17 @@
 # define save_and_cli(x)	local_irq_save(x)
 #endif
 
+void push_bh_user(void *);
+void pop_bh_user(void);
+void print_bh_user(void);
+
 /* SoftIRQ primitives.  */
 #define local_bh_disable() \
-		do { preempt_count() += SOFTIRQ_OFFSET; barrier(); } while (0)
+		do { preempt_count() += SOFTIRQ_OFFSET; barrier(); \
+        push_bh_user(current_text_addr()); } while (0)
 #define __local_bh_enable() \
-		do { barrier(); preempt_count() -= SOFTIRQ_OFFSET; } while (0)
+		do { barrier(); preempt_count() -= SOFTIRQ_OFFSET; \
+        pop_bh_user(); } while (0)
 
 extern void local_bh_enable(void);
 
Index: linux-2.6.10/kernel/sched.c
===================================================================
--- linux-2.6.10.orig/kernel/sched.c	2006-03-16 13:55:39.000000000 +0100
+++ linux-2.6.10/kernel/sched.c	2006-03-16 13:55:42.000000000 +0100
@@ -2545,6 +2545,7 @@
 			printk(KERN_ERR "scheduling while atomic: "
 				"%s/0x%08x/%d\n",
 				current->comm, preempt_count(), current->pid);
+			print_bh_user();
 			dump_stack();
 		}
 	}
Index: linux-2.6.10/kernel/softirq.c
===================================================================
--- linux-2.6.10.orig/kernel/softirq.c	2006-03-16 13:55:17.000000000 +0100
+++ linux-2.6.10/kernel/softirq.c	2006-03-16 14:21:50.993331232 +0100
@@ -135,6 +135,43 @@
 
 #endif
 
+static void *local_bh_user[NR_CPUS][32];
+static atomic_t bh_user_cnt[NR_CPUS];
+
+
+void
+push_bh_user(void *addr)
+{
+	int cpu = smp_processor_id();
+
+	local_bh_user[cpu][atomic_inc_return(&bh_user_cnt[cpu])] = addr;
+}
+
+EXPORT_SYMBOL(push_bh_user);
+
+
+void
+pop_bh_user(void)
+{
+	atomic_dec(&bh_user_cnt[smp_processor_id()]);
+}
+
+EXPORT_SYMBOL(pop_bh_user);
+
+
+void
+print_bh_user(void)
+{
+	int cpu = smp_processor_id();
+	int i = atomic_read(&bh_user_cnt[cpu]);
+
+	while (i >= 0)
+		printk("bh_users: %p\n", local_bh_user[cpu][i--]);
+}
+
+EXPORT_SYMBOL(print_bh_user);
+
+
 void local_bh_enable(void)
 {
 	WARN_ON(irqs_disabled());
@@ -144,6 +181,8 @@
  	 */
 	preempt_count() -= SOFTIRQ_OFFSET - 1;
 
+	pop_bh_user();
+
 	if (unlikely(!in_interrupt() && local_softirq_pending()))
 		do_softirq();
 

--5mCyUwZo2JvN/JJP--
