Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264296AbUDTW1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264296AbUDTW1t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 18:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264164AbUDTW0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 18:26:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:56742 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264559AbUDTVcA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 17:32:00 -0400
Date: Tue, 20 Apr 2004 14:34:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Tony Breeds <tony@bakeyournoodle.com>
Cc: linux-kernel@vger.kernel.org, Max Asbock <masbock@us.ibm.com>
Subject: Re: [PATCH] Kconfig dependancy update for drivers/misc/ibmasm
Message-Id: <20040420143418.08962d0b.akpm@osdl.org>
In-Reply-To: <20040420210110.GD3445@bakeyournoodle.com>
References: <20040420210110.GD3445@bakeyournoodle.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Breeds <tony@bakeyournoodle.com> wrote:
>
> 
> Hello,
> 	Some weeks ago I saw this compile error posted to lkml:
> 
> ---
> >   LD      .tmp_vmlinux1
> > drivers/built-in.o(.text+0x435e1): In function `ibmasm_register_uart':
> > : undefined reference to `register_serial'
> > drivers/built-in.o(.text+0x43649): In function `ibmasm_unregister_uart':
> > : undefined reference to `unregister_serial'
> > make: *** [.tmp_vmlinux1] Error 1
> > summer@Dolphin:~/pebble/kernel/linux-2.6.4$
> ---
> 
> This was created because ibmasm was set to yes BUT the 8250 was a
> module.  I believe the correct (tested) fix is below.

Seems sane to me, but I'm not sure why this wasn't done originally.  ie, this:

+#ifdef CONFIG_SERIAL_8250
 extern void ibmasm_register_uart(struct service_processor *sp);
 extern void ibmasm_unregister_uart(struct service_processor *sp);
+#else
+#define ibmasm_register_uart(sp)	do { } while(0)
+#define ibmasm_unregister_uart(sp)	do { } while(0)
+#endif

becomes unnecessary with your patch.

Max, any preferences?


> ################################################################################
> --- 2.6.4.clean/drivers/misc/Kconfig	2004-03-11 17:57:23.000000000 +1100
> +++ 2.6.4.noconfig/drivers/misc/Kconfig	2004-03-30 09:32:07.000000000 +1000
> @@ -6,7 +6,7 @@
>  
>  config IBM_ASM
>  	tristate "Device driver for IBM RSA service processor"
> -	depends on X86
> +	depends on X86 && SERIAL_8250
>  	default n
>  	---help---
>  	  This option enables device driver support for in-band access to the
> ################################################################################
> 
> Yours Tony
> 
>         linux.conf.au       http://lca2005.linux.org.au/
> 	Apr 18-23 2005      The Australian Linux Technical Conference!
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> ----- End forwarded message -----
> 
> Yours Tony
> 
>         linux.conf.au       http://lca2005.linux.org.au/
> 	Apr 18-23 2005      The Australian Linux Technical Conference!
