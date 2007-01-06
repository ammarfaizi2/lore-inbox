Return-Path: <linux-kernel-owner+w=401wt.eu-S932230AbXAFWg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbXAFWg5 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 17:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbXAFWg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 17:36:56 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:16480 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932131AbXAFWgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 17:36:55 -0500
Subject: Re: +
	spin_lock_irq-enable-interrupts-while-spinning-i386-implementation.patch
	added to -mm tree
From: Daniel Walker <dwalker@mvista.com>
To: linux-kernel@vger.kernel.org
Cc: mm-commits@vger.kernel.org, kiran@scalex86.org, ak@suse.de, md@google.com,
       mingo@elte.hu, pravin.shelar@calsoftinc.com, shai@scalex86.org
In-Reply-To: <200701032112.l03LCnVb031386@shell0.pdx.osdl.net>
References: <200701032112.l03LCnVb031386@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Sat, 06 Jan 2007 14:35:53 -0800
Message-Id: <1168122953.26086.230.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2007-01-03 at 13:12 -0800, akpm@osdl.org wrote:
> -# define __raw_spin_lock_irq(lock) __raw_spin_lock(lock)
> +
> +static inline void __raw_spin_lock_irq(raw_spinlock_t *lock)
> +{
> +       asm volatile("\n1:\t"
> +                    LOCK_PREFIX " ; decb %0\n\t"
> +                    "jns 3f\n"
> +                    STI_STRING "\n"
> +                    "2:\t"
> +                    "rep;nop\n\t"
> +                    "cmpb $0,%0\n\t"
> +                    "jle 2b\n\t"
> +                    CLI_STRING "\n"
> +                    "jmp 1b\n"
> +                    "3:\n\t"
> +                    : "+m" (lock->slock) : : "memory");
> +}
>  #endif
>   

This doesn't compile when CONFIG_PARAVIRT is enabled. It changes the
CLI_STRING and STI_STRING values.

Daniel

