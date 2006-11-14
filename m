Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933279AbWKNAql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933279AbWKNAql (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 19:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933281AbWKNAql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 19:46:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48802 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933279AbWKNAqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 19:46:40 -0500
Date: Mon, 13 Nov 2006 16:42:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] arch/i386/kernel/io_apic.c: handle a negative
 return value
Message-Id: <20061113164256.805a7497.akpm@osdl.org>
In-Reply-To: <20061112174826.GC3382@stusta.de>
References: <20061112174826.GC3382@stusta.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Nov 2006 18:48:26 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> The Coverity checker noted that bad things might happen if 
> find_isa_irq_apic() returned -1.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6/arch/i386/kernel/io_apic.c.old	2006-11-12 18:41:24.000000000 +0100
> +++ linux-2.6/arch/i386/kernel/io_apic.c	2006-11-12 18:42:00.000000000 +0100
> @@ -2160,7 +2160,8 @@ static inline void unlock_ExtINT_logic(v
>  
>  	pin  = find_isa_irq_pin(8, mp_INT);
>  	apic = find_isa_irq_apic(8, mp_INT);
> -	if (pin == -1)
> +
> +	if ((pin == -1) || (apic == -1))
>  		return;
>  

I dunno about this.  For some reason I don't trust the apic code much.  At
present if find_isa_irq_apic() fails we at least have a chance of
blundering into a nnice oops or something.  By adding correct
error-checking we increase the chance of things just silently not working.

So let's see what this does...




From: Adrian Bunk <bunk@stusta.de>

The Coverity checker noted that bad things might happen if
find_isa_irq_apic() returned -1.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Cc: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/i386/kernel/io_apic.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletion(-)

diff -puN arch/i386/kernel/io_apic.c~arch-i386-kernel-io_apicc-handle-a-negative-return-value arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c~arch-i386-kernel-io_apicc-handle-a-negative-return-value
+++ a/arch/i386/kernel/io_apic.c
@@ -2166,9 +2166,17 @@ static inline void unlock_ExtINT_logic(v
 	unsigned char save_control, save_freq_select;
 
 	pin  = find_isa_irq_pin(8, mp_INT);
+	if (pin == -1) {
+		printk(KERN_ERR "unlock_ExtINT_logic: find_isa_irq_pin()
+				"failed\n");
+		return;
+	}
 	apic = find_isa_irq_apic(8, mp_INT);
-	if (pin == -1)
+	if (apic == -1) {
+		printk(KERN_ERR "unlock_ExtINT_logic: find_isa_irq_apic()
+				"failed\n");
 		return;
+	}
 
 	entry0 = ioapic_read_entry(apic, pin);
 	clear_IO_APIC_pin(apic, pin);
_



