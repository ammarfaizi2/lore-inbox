Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWFXB5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWFXB5V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 21:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWFXB5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 21:57:20 -0400
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:62348 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750826AbWFXB5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 21:57:20 -0400
Date: Fri, 23 Jun 2006 21:54:00 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [linux-pm] swsusp regression [Was: 2.6.17-mm1]
To: Andrew Morton <akpm@osdl.org>
Cc: Frederik Deweerdt <deweerdt@free.fr>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-pm <linux-pm@vger.kernel.org>
Message-ID: <200606232156_MC3-1-C354-D5AE@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060623023124.138d432f.akpm@osdl.org>

On Fri, 23 Jun 2006 02:31:24 -0700, Andrew Morton wrote:

> > > Code: 05 c4 42 43 c0 31 43 43 c0 c3 8b 2d 68 6e 54 c0 8b 1d 60 6e 54 c0 8b 35 6c 6e 54 c0 8b 3d 70 6d 54 c0 ff 35 74 6e 54 c0 9d c3 90 <e8> 6d 38 ea ff e8 a2 ff ff ff 6a 03 e8 ec b6 de ff 83 c4 04 c3
> > > EIP: [c043431c>] do_suspend_lowlevel+0x0/0x15 SS:ESP 0068:f6cb6ea4
> >   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Ha, wait a moment, this is interesting line. Can you trace down which
> > instruction causes this?
> > 
> > We recently changed pagetable handling during swsusp, perhaps thats
> > it? It went to Linus few minutes ago...
> 
> That's a good possibility.  It does appear to be oopsing at the first
> instruction of arch/i386/kernel/acpi/wakeup.S:do_suspend_lowlevel(). 
> Perhaps there's enough info in that oops trace to tell us whether it was
> the instruction fetch which oopsed.
> 
> One wonders whether this will help...
> 
> --- a/arch/i386/kernel/acpi/wakeup.S~a
> +++ a/arch/i386/kernel/acpi/wakeup.S
> @@ -270,6 +270,7 @@ ALIGN
>  ENTRY(saved_magic)   .long   0
>  ENTRY(saved_eip)     .long   0
>  
> +.text
>  save_registers:
>       leal    4(%esp), %eax
>       movl    %eax, saved_context_esp
> @@ -304,6 +305,7 @@ ret_point:
>       call    restore_processor_state
>       ret
>  
> +.data
>  ALIGN
>  # saved registers
>  saved_gdt:   .long   0,0


This is in 2.6.17-mm1 already:


From: Shaohua Li <shaohua.li@intel.com>

Move do_suspend_lowlevel to correct segment.  If it is in the same hugepage
with ro data, mark_rodata_ro will make it unexecutable.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/i386/kernel/acpi/wakeup.S |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff -puN arch/i386/kernel/acpi/wakeup.S~move-do_suspend_lowlevel-to-correct-segment arch/i386/kerne
--- a/arch/i386/kernel/acpi/wakeup.S~move-do_suspend_lowlevel-to-correct-segment
+++ a/arch/i386/kernel/acpi/wakeup.S
@@ -265,11 +265,6 @@ ENTRY(acpi_copy_wakeup_routine)
        movl    $0x12345678, saved_magic
        ret

-.data
-ALIGN
-ENTRY(saved_magic)     .long   0
-ENTRY(saved_eip)       .long   0
-
 save_registers:
        leal    4(%esp), %eax
        movl    %eax, saved_context_esp
@@ -304,7 +299,11 @@ ret_point:
        call    restore_processor_state
        ret

+.data
 ALIGN
+ENTRY(saved_magic)     .long   0
+ENTRY(saved_eip)       .long   0
+
 # saved registers
 saved_gdt:     .long   0,0
 saved_idt:     .long   0,0
_
-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
