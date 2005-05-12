Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262095AbVELSNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbVELSNF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 14:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbVELSNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 14:13:04 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:24568 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262095AbVELSKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 14:10:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=tFg1idR6z7dPUujpBD+8w0kniPAuGWytPABTQUOvWYWtX6LotoVBQRJFRa8mHn4+igxpDGn46zbzXZJeq2zx40S+L5G17TEZoXibFIg/qFl3IIVZTpnZgunhkhazTnd7v8jOsGepwmKMR82l2D3W4EEHfpEFnYdeBOdrnC2A9/M=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm] Print KBD and AUX irqs correctly.
Date: Thu, 12 May 2005 22:14:17 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>
References: <20050512033100.017958f6.akpm@osdl.org>
In-Reply-To: <20050512033100.017958f6.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200505122214.17525.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fun in dmesg:

    --- dmesg-2.6.12-rc4
    +++ dmesg-2.6.12-rc4-mm1

    -PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 10	    <===
    +PNP: PS/2 controller doesn't have AUX irq; using default 0xc
     PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 112	    <======
    +serio: i8042 AUX port at 0x60,0x64 irq 12
     serio: i8042 KBD port at 0x60,0x64 irq 1			    <===

I never realized "irq 10" meant "KBD irq 1 and you don't have AUX irq". In
2.6.12-rc4-mm1 "irq 112" means "KBD irq 1 and AUX irq 12 (now assigned by
default)".

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

--- linux-2.6.12-rc4-mm1/drivers/input/serio/i8042-x86ia64io.h	2005-05-12 21:22:12.000000000 +0400
+++ linux-2.6.12-rc4-mm1-pnp/drivers/input/serio/i8042-x86ia64io.h	2005-05-12 21:22:45.000000000 +0400
@@ -284,10 +284,10 @@ static int i8042_pnp_init(void)
 	i8042_kbd_irq = i8042_pnp_kbd_irq;
 	i8042_aux_irq = i8042_pnp_aux_irq;
 
-	printk(KERN_INFO "PNP: PS/2 Controller [%s%s%s] at %#x,%#x irq %d%s%d\n",
+	printk(KERN_INFO "PNP: PS/2 Controller [%s%s%s] at %#x,%#x irq %d,%d\n",
 		i8042_pnp_kbd_name, (result_kbd > 0 && result_aux > 0) ? "," : "", i8042_pnp_aux_name,
 		i8042_data_reg, i8042_command_reg, i8042_kbd_irq,
-		(result_aux > 0) ? "," : "", i8042_aux_irq);
+		i8042_aux_irq);
 
 	return 0;
 }
