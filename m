Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316869AbSGZFpd>; Fri, 26 Jul 2002 01:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316886AbSGZFpd>; Fri, 26 Jul 2002 01:45:33 -0400
Received: from www.sgg.ru ([217.23.135.2]:53262 "EHLO mail.sgg.ru")
	by vger.kernel.org with ESMTP id <S316869AbSGZFpc>;
	Fri, 26 Jul 2002 01:45:32 -0400
Message-ID: <3D40E37C.5971376D@tv-sign.ru>
Date: Fri, 26 Jul 2002 09:51:56 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] irqlock patch 2.5.27-H4
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Oleg Nesterov wrote:
> +       irq_enter();
>         (*func)(info);
> +       irq_exit();

It is better to update call_data->finished before
doing soft irqs in irq_exit().

Against 2.5.28:

--- arch/i386/kernel/smp.c~	Fri Jul 26 07:49:03 2002
+++ arch/i386/kernel/smp.c	Fri Jul 26 09:29:20 2002
@@ -646,10 +646,12 @@
 	/*
 	 * At this point the info structure may be out of scope unless wait==1
 	 */
+	irq_enter();
 	(*func)(info);
 	if (wait) {
 		mb();
 		atomic_inc(&call_data->finished);
 	}
+	irq_exit();
 }
 
--- arch/i386/kernel/entry.S~	Fri Jul 26 07:49:03 2002
+++ arch/i386/kernel/entry.S	Fri Jul 26 07:57:48 2002
@@ -417,7 +417,6 @@
 ENTRY(device_not_available)
 	pushl $-1			# mark this as an int
 	SAVE_ALL
-	GET_THREAD_INFO(%ebx)
 	movl %cr0, %eax
 	testl $0x4, %eax		# EM (math emulation bit)
 	jne device_not_available_emulate


Oleg.
