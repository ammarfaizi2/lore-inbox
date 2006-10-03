Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWJCPKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWJCPKR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 11:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWJCPKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 11:10:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54203 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964811AbWJCPKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 11:10:15 -0400
Date: Tue, 3 Oct 2006 08:10:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Randy Dunlap <rdunlap@xenotime.net>
cc: akpm <akpm@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC] Math-emu kills the kernel on Athlon64 X2
In-Reply-To: <20061002213809.7a3f995f.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.64.0610030805490.3952@g5.osdl.org>
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com>
 <p73venk2sjw.fsf@verdi.suse.de> <9a8748490609191414m6748f2fu521637df29ef9e8e@mail.gmail.com>
 <Pine.LNX.4.64.0609191453310.4388@g5.osdl.org> <20061002191638.093fde85.rdunlap@xenotime.net>
 <Pine.LNX.4.64.0610021932080.3952@g5.osdl.org> <20061002213809.7a3f995f.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 Oct 2006, Randy Dunlap wrote:
> 
> OK, how about something more direct and less obtrusive, like this?

I think this is fine, but I also think it's a bit hacky.

Wouldn't it make more sense to make the whole "nofxsr" thing just clear 
the capability, ie just a diff like the appended...

Does that work for you? If so, we should _also_ make sure that "no387" 
calls this function too, so that you don't have to do _both_ no387 and 
nofxsr, which is clearly silly. Once you do no387, the kernel should do 
the nofxsr for you, methinks..

		Linus

---
diff --git a/arch/i386/kernel/cpu/common.c b/arch/i386/kernel/cpu/common.c
index 2799baa..7ac3c9e 100644
--- a/arch/i386/kernel/cpu/common.c
+++ b/arch/i386/kernel/cpu/common.c
@@ -185,6 +185,7 @@ static void __cpuinit get_cpu_vendor(str
 static int __init x86_fxsr_setup(char * s)
 {
 	disable_x86_fxsr = 1;
+	clear_bit(X86_FEATURE_FXSR, boot_cpu_data.x86_capability);
 	return 1;
 }
 __setup("nofxsr", x86_fxsr_setup);
