Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966186AbWKNQlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966186AbWKNQlo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 11:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966199AbWKNQlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 11:41:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64406 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S966186AbWKNQlm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 11:41:42 -0500
Date: Tue, 14 Nov 2006 08:41:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: 2.6.19-rc5-mm2
Message-Id: <20061114084130.68721fcd.akpm@osdl.org>
In-Reply-To: <200611141346.52401.m.kozlowski@tuxland.pl>
References: <20061114014125.dd315fff.akpm@osdl.org>
	<200611141346.52401.m.kozlowski@tuxland.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2006 13:46:51 +0100
Mariusz Kozlowski <m.kozlowski@tuxland.pl> wrote:

> Hello,
> 
> 	On every box I tried I got this warning:
> 
> $ make 
> scripts/kconfig/conf -s arch/i386/Kconfig
> Warning! Found recursive dependency: INET IPV6 DLM (null) DLM_TCP INET

yup.  The GFS guys have since fixed that.

> Second thing: the same thing as with 2.6.19-rc5-mm1 happens:
> 
> > > > >   LD      .tmp_vmlinux1
> > > > > arch/x86_64/kernel/built-in.o(.init.text+0x31b7): In function
> > > > > `alternative_instructions': arch/i386/kernel/alternative.c:437: 
> undefined
> > > > > reference to `__stop_parainstructions'
> > > > > 
> arch/x86_64/kernel/built-in.o(.init.text+0x31be):arch/i386/kernel/alterna
> > > > >tive.c:437: undefined reference to `__start_parainstructions' make: ***
> > > > > [.tmp_vmlinux1] Error 1
> > > >
> > > > Thanks.  Please send me the .config and I'll see if it's still 
> happening.
> > > 
> > > Please find .config attached.
> > 
> > Thanks.  The paravirt patches have churned a bit recently and we appear to
> > have fixed this one.
> 
> Here it goes:
> 
>   LD      .tmp_vmlinux1
> arch/x86_64/kernel/built-in.o(.init.text+0x328f): In function 
> `alternative_instructions':
> arch/i386/kernel/alternative.c:437: undefined reference to 
> `__stop_parainstructions'
> arch/x86_64/kernel/built-in.o(.init.text+0x3296):arch/i386/kernel/alternative.c:437: 
> undefined reference to `__start_parainstructions'
> make: *** [.tmp_vmlinux1] Error 1

Strange, I don't get that with your .config.  I guess it's a binutils
difference.

This should fix it:


diff -puN arch/i386/kernel/alternative.c~fix-x86_64-mm-patch-inline-replacements-for arch/i386/kernel/alternative.c
--- a/arch/i386/kernel/alternative.c~fix-x86_64-mm-patch-inline-replacements-for
+++ a/arch/i386/kernel/alternative.c
@@ -381,10 +381,7 @@ void apply_paravirt(struct paravirt_patc
 extern struct paravirt_patch __start_parainstructions[],
 	__stop_parainstructions[];
 #else
-void apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *end)
-{
-}
-extern struct paravirt_patch *__start_parainstructions, *__stop_parainstructions;
+#define apply_paravirt(start, end) do { } while (0)
 #endif	/* CONFIG_PARAVIRT */
 
 void __init alternative_instructions(void)
_


