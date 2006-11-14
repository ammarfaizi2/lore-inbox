Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933158AbWKNHnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933158AbWKNHnY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 02:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933089AbWKNHnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 02:43:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59578 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933050AbWKNHnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 02:43:22 -0500
Date: Mon, 13 Nov 2006 23:43:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,
       Ingo Molnar <mingo@elte.hu>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
Subject: Re: [PATCH] Incorrect MSI interrupt type name
Message-Id: <20061113234315.767f7516.akpm@osdl.org>
In-Reply-To: <1163488977.4311.52.camel@ymzhang-perf.sh.intel.com>
References: <1163488977.4311.52.camel@ymzhang-perf.sh.intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2006 15:22:57 +0800
"Zhang, Yanmin" <yanmin_zhang@linux.intel.com> wrote:

> /proc/interrupts shows "<NULL>" for MSI interrupt type name on
> my ia64 machine.
> 
> Below patch against 2.6.19-rc5-mm1 fixes it.
> 
> Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>
> 
> ---
> 
> --- linux-2.6.19-rc5-mm1/arch/ia64/kernel/msi_ia64.c	2006-11-14 14:16:12.000000000 +0800
> +++ linux-2.6.19-rc5-mm1_fix/arch/ia64/kernel/msi_ia64.c	2006-11-14 15:08:37.000000000 +0800
> @@ -115,7 +115,7 @@ static int ia64_msi_retrigger_irq(unsign
>   * Generic ops used on most IA64 platforms.
>   */
>  static struct irq_chip ia64_msi_chip = {
> -	.name		= "PCI-MSI",
> +	.typename	= "PCI-MSI",
>  	.mask		= mask_msi_irq,
>  	.unmask		= unmask_msi_irq,
>  	.ack		= ia64_ack_msi_irq,

I think the bug is that ia64 is printing ->typename, whereas it should be
printing ->name:


 arch/ia64/kernel/iosapic.c |    2 +-
 arch/ia64/kernel/irq.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/ia64/kernel/iosapic.c~ia64-irqs-use-name-not-typename arch/ia64/kernel/iosapic.c
--- a/arch/ia64/kernel/iosapic.c~ia64-irqs-use-name-not-typename
+++ a/arch/ia64/kernel/iosapic.c
@@ -664,7 +664,7 @@ register_intr (unsigned int gsi, int vec
 			printk(KERN_WARNING
 			       "%s: changing vector %d from %s to %s\n",
 			       __FUNCTION__, vector,
-			       idesc->chip->typename, irq_type->typename);
+			       idesc->chip->name, irq_type->name);
 		idesc->chip = irq_type;
 	}
 	return 0;
diff -puN arch/ia64/kernel/irq.c~ia64-irqs-use-name-not-typename arch/ia64/kernel/irq.c
--- a/arch/ia64/kernel/irq.c~ia64-irqs-use-name-not-typename
+++ a/arch/ia64/kernel/irq.c
@@ -76,7 +76,7 @@ int show_interrupts(struct seq_file *p, 
 			seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
 		}
 #endif
-		seq_printf(p, " %14s", irq_desc[i].chip->typename);
+		seq_printf(p, " %14s", irq_desc[i].chip->name);
 		seq_printf(p, "  %s", action->name);
 
 		for (action=action->next; action; action = action->next)
_

