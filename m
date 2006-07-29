Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422729AbWG2K2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422729AbWG2K2N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 06:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422734AbWG2K2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 06:28:13 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:63848 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1422729AbWG2K2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 06:28:12 -0400
Date: Sat, 29 Jul 2006 12:28:10 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Dave Jones <davej@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] i386: Do backtrace fallback too
Message-ID: <20060729102810.GA26709@harddisk-recovery.com>
References: <200607290300.k6T306Fc003168@hera.kernel.org> <20060729075414.GA16118@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060729075414.GA16118@redhat.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2006 at 03:54:14AM -0400, Dave Jones wrote:
> On Sat, Jul 29, 2006 at 03:00:06AM +0000, Linux Kernel wrote:
>  > commit c97d20a6c51067a38f53680d9609b4cf2867d077

[...]

> Hmm, this breaks the build for me..
> 
> arch/i386/kernel/traps.c: In function 'show_trace_log_lvl':
> arch/i386/kernel/traps.c:195: error: invalid type argument of '->'
> arch/i386/kernel/traps.c:198: error: invalid type argument of '->'
> arch/i386/kernel/traps.c:199: error: invalid type argument of '->'
> make[1]: *** [arch/i386/kernel/traps.o] Error 1
> 
> (The line numbers are different to mainline due to some unrelated
> patches, they point to the UNW_PC/UNW_SP usages),
> 
> 
> Also, shouldn't this..
> 
> 	print_symbol("DWARF2 unwinder stuck at %s\n",
> 		UNW_PC(info.regs));
> 
> be using %p ?

It should be UNWP_PC(&info), just like in the functions above. Here's a
patch:

Signed-off-by: Erik Mouw <erik@harddisk-recovery.com>

diff --git a/arch/i386/kernel/traps.c b/arch/i386/kernel/traps.c
index 3facc8f..017c015 100644
--- a/arch/i386/kernel/traps.c
+++ b/arch/i386/kernel/traps.c
@@ -190,11 +190,11 @@ static void show_trace_log_lvl(struct ta
 		if (unw_ret > 0 && !arch_unw_user_mode(&info)) {
 #ifdef CONFIG_STACK_UNWIND
 			print_symbol("DWARF2 unwinder stuck at %s\n",
-				     UNW_PC(info.regs));
+				     UNW_PC(&info));
 			if (call_trace == 1) {
 				printk("Leftover inexact backtrace:\n");
-				if (UNW_SP(info.regs))
-					stack = (void *)UNW_SP(info.regs);
+				if (UNW_SP(&info))
+					stack = (void *)UNW_SP(&info);
 			} else if (call_trace > 1)
 				return;
 			else


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
