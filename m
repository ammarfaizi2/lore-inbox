Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966217AbWKNRJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966217AbWKNRJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 12:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966220AbWKNRJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 12:09:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32926 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S966217AbWKNRJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 12:09:55 -0500
Date: Tue, 14 Nov 2006 09:09:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: 2.6.19-rc5-mm2
Message-Id: <20061114090932.50a9917c.akpm@osdl.org>
In-Reply-To: <20061114084130.68721fcd.akpm@osdl.org>
References: <20061114014125.dd315fff.akpm@osdl.org>
	<200611141346.52401.m.kozlowski@tuxland.pl>
	<20061114084130.68721fcd.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2006 08:41:30 -0800
Andrew Morton <akpm@osdl.org> wrote:

> This should fix it:
> 
> 
> diff -puN arch/i386/kernel/alternative.c~fix-x86_64-mm-patch-inline-replacements-for arch/i386/kernel/alternative.c
> --- a/arch/i386/kernel/alternative.c~fix-x86_64-mm-patch-inline-replacements-for
> +++ a/arch/i386/kernel/alternative.c
> @@ -381,10 +381,7 @@ void apply_paravirt(struct paravirt_patc
>  extern struct paravirt_patch __start_parainstructions[],
>  	__stop_parainstructions[];
>  #else
> -void apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *end)
> -{
> -}
> -extern struct paravirt_patch *__start_parainstructions, *__stop_parainstructions;
> +#define apply_paravirt(start, end) do { } while (0)
>  #endif	/* CONFIG_PARAVIRT */
>  
>  void __init alternative_instructions(void)

hm, but that breaks x86.   Maybe this..


 arch/i386/kernel/alternative.c   |    5 -----
 include/asm-i386/alternative.h   |    4 ++++
 include/asm-x86_64/alternative.h |    4 ++++
 3 files changed, 8 insertions(+), 5 deletions(-)

diff -puN arch/i386/kernel/alternative.c~fix-x86_64-mm-patch-inline-replacements-for arch/i386/kernel/alternative.c
--- a/arch/i386/kernel/alternative.c~fix-x86_64-mm-patch-inline-replacements-for
+++ a/arch/i386/kernel/alternative.c
@@ -380,11 +380,6 @@ void apply_paravirt(struct paravirt_patc
 }
 extern struct paravirt_patch __start_parainstructions[],
 	__stop_parainstructions[];
-#else
-void apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *end)
-{
-}
-extern struct paravirt_patch *__start_parainstructions, *__stop_parainstructions;
 #endif	/* CONFIG_PARAVIRT */
 
 void __init alternative_instructions(void)
diff -puN include/asm-i386/alternative.h~fix-x86_64-mm-patch-inline-replacements-for include/asm-i386/alternative.h
--- a/include/asm-i386/alternative.h~fix-x86_64-mm-patch-inline-replacements-for
+++ a/include/asm-i386/alternative.h
@@ -119,6 +119,10 @@ static inline void alternatives_smp_swit
 #endif
 
 struct paravirt_patch;
+#ifdef CONFIG_PARAVIRT
 void apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *end);
+#else
+#define apply_paravirt(start, end) do { } while (0)
+#endif
 
 #endif /* _I386_ALTERNATIVE_H */
diff -puN include/asm-x86_64/alternative.h~fix-x86_64-mm-patch-inline-replacements-for include/asm-x86_64/alternative.h
--- a/include/asm-x86_64/alternative.h~fix-x86_64-mm-patch-inline-replacements-for
+++ a/include/asm-x86_64/alternative.h
@@ -134,6 +134,10 @@ static inline void alternatives_smp_swit
 #endif
 
 struct paravirt_patch;
+#ifdef CONFIG_PARAVIRT
 void apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *end);
+#else
+#define apply_paravirt(start, end) do { } while (0)
+#endif
 
 #endif /* _X86_64_ALTERNATIVE_H */
_


Unpleasant duplication there.  Perhaps we should have linux/alternative.h

