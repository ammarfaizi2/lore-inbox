Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWAYHLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWAYHLR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 02:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWAYHLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 02:11:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62920 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750744AbWAYHLQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 02:11:16 -0500
Date: Tue, 24 Jan 2006 23:10:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
Cc: ebiederm@xmission.com, ak@suse.de, vgoyal@in.ibm.com,
       linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Subject: Re: [PATCH 1/5] stack overflow safe kdump (2.6.16-rc1-i386) -
 safe_smp_processor_id
Message-Id: <20060124231052.7c9fcbec.akpm@osdl.org>
In-Reply-To: <1138171868.2370.62.camel@localhost.localdomain>
References: <1138171868.2370.62.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fernando Luis Vazquez Cao <fernando@intellilink.co.jp> wrote:
>
> On the event of a stack overflow critical data that usually resides at
> the bottom of the stack is likely to be stomped and, consequently, its
> use should be avoided.
> 
> In particular, in the i386 and IA64 architectures the macro
> smp_processor_id ultimately makes use of the "cpu" member of struct
> thread_info which resides at the bottom of the stack. x86_64, on the
> other hand, is not affected by this problem because it benefits from
> the use of the PDA infrastructure.
> 
> To circumvent this problem I suggest implementing
> "safe_smp_processor_id()" (it already exists in x86_64) for i386 and
> IA64 and use it as a replacement for smp_processor_id in the reboot path
> to the dump capture kernel. This is a possible implementation for i386.
> 
> ...
>
> +int safe_smp_processor_id(void) {

Please fix coding style.

>  #endif
>  
> +extern int safe_smp_processor_id(void);
>  extern int __cpu_disable(void);
>  extern void __cpu_die(unsigned int cpu);
>  #endif /* !__ASSEMBLY__ */
>  
>  #else /* CONFIG_SMP */
>  
> +#define safe_smp_processor_id() 0
>  #define cpu_physical_id(cpu)		boot_cpu_physical_apicid

It assumes that all x86 SMP machines have APICs.  That's untrue of Voyager.
I think we can probably live with this assumption - others would know
better than I.
