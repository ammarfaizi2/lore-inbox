Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263268AbTEMRyp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 13:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263302AbTEMRyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 13:54:45 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:49165 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263268AbTEMRyW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 13:54:22 -0400
Date: Tue, 13 May 2003 20:07:05 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, hch@infradead.org, gregkh@kroah.com,
       linux-security-module@wirex.com
Subject: Re: [PATCH] Early init for security modules
Message-ID: <20030513180705.GB1170@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org, hch@infradead.org,
	gregkh@kroah.com, linux-security-module@wirex.com
References: <20030512200309.C20068@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030512200309.C20068@figure1.int.wirex.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 08:03:09PM -0700, Chris Wright wrote:
> 
> --- 1.30/arch/i386/vmlinux.lds.S	Tue May  6 06:54:06 2003
> +++ edited/arch/i386/vmlinux.lds.S	Mon May 12 16:20:10 2003
> @@ -81,6 +81,9 @@
>    __con_initcall_start = .;
>    .con_initcall.init : { *(.con_initcall.init) }
>    __con_initcall_end = .;
> +  __security_initcall_start = .;
> +  .security_initcall.init : { *(.security_initcall.init) }
> +  __security_initcall_end = .;

I would much prefer to have only:

+ SECURITY_INIT

and moving the common stuff to include/asm-generic/vmlinux.lds.h.
Note that I moved definition of _start and _stop inside brackets.
Doing this makes sure the start address is always correct, independent
of the end address of last section.

Starting a new section will align to member with biggest alignment,
so we may see _start have a wrong value in some cases.

Using SECURITY_INIT will make changes to all architectures
even more trivial.

	Sam

===== include/asm-generic/vmlinux.lds.h 1.7 vs edited =====
--- 1.7/include/asm-generic/vmlinux.lds.h	Mon Feb  3 22:00:30 2003
+++ edited/include/asm-generic/vmlinux.lds.h	Tue May 13 20:02:45 2003
@@ -45,3 +45,9 @@
 		*(__ksymtab_strings)					\
 	}
 
+#define SECURITY_INIT							\
+	.security_initcall.init : {					\
+		__security_initcall_start = .;				\
+	       	*(.security_initcall.init) 				\
+		__security_initcall_end = .;				\
+	}

