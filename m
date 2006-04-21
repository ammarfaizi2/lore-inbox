Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWDUTbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWDUTbO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 15:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWDUTbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 15:31:13 -0400
Received: from mail.parknet.jp ([210.171.160.80]:18952 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S932348AbWDUTbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 15:31:11 -0400
X-AuthUser: hirofumi@parknet.jp
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] X86_NUMAQ build fix
References: <87irp2x69s.fsf@duaron.myhome.or.jp>
	<1145643558.3373.34.camel@localhost.localdomain>
	<874q0mwyor.fsf@duaron.myhome.or.jp>
	<1145645988.3373.38.camel@localhost.localdomain>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 22 Apr 2006 04:31:05 +0900
In-Reply-To: <1145645988.3373.38.camel@localhost.localdomain> (Dave Hansen's message of "Fri, 21 Apr 2006 11:59:48 -0700")
Message-ID: <87zmievi86.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On Sat, 2006-04-22 at 03:50 +0900, OGAWA Hirofumi wrote:
>> Dave Hansen <haveblue@us.ibm.com> writes:
>
> Ahh, so NUMAQ and VISWS don't seem to allow or want ACPI code.
> Especially for the NUMAQ, I don't think we should even mess with this
> too much.  Just fix it in the build system and directly disallow NUMAQ
> && ACPI. 
>
> We already have this:
>
> menu "ACPI (Advanced Configuration and Power Interface) Support"
>         depends on !X86_VISWS
>
> Just add the NUMAQ in there, too.

Oh, thanks a lot for noticeing this. Fixed patch is here.

[compile test only. I don't have NUMAQ, and I just wanted to see
"objdump -S" of NUMA's code.]
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>



Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 arch/i386/boot/compressed/misc.c |    4 +++-
 arch/i386/kernel/smpboot.c       |    2 +-
 drivers/acpi/Kconfig             |    1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff -puN arch/i386/pci/Makefile~numaq-build-fix arch/i386/pci/Makefile
diff -puN arch/i386/boot/compressed/misc.c~numaq-build-fix arch/i386/boot/compressed/misc.c
--- linux-2.6/arch/i386/boot/compressed/misc.c~numaq-build-fix	2006-04-22 04:15:04.000000000 +0900
+++ linux-2.6-hirofumi/arch/i386/boot/compressed/misc.c	2006-04-22 04:15:04.000000000 +0900
@@ -122,7 +122,9 @@ static int vidport;
 static int lines, cols;
 
 #ifdef CONFIG_X86_NUMAQ
-static void * xquad_portio = NULL;
+/* hack to avoid using xquad_portio=NULL */
+#undef outb_p
+#define outb_p		outb_local_p
 #endif
 
 #include "../../../../lib/inflate.c"
diff -puN arch/i386/kernel/smpboot.c~numaq-build-fix arch/i386/kernel/smpboot.c
--- linux-2.6/arch/i386/kernel/smpboot.c~numaq-build-fix	2006-04-22 04:15:04.000000000 +0900
+++ linux-2.6-hirofumi/arch/i386/kernel/smpboot.c	2006-04-22 04:15:04.000000000 +0900
@@ -1116,9 +1116,9 @@ static void smp_tune_scheduling (void)
  */
 
 static int boot_cpu_logical_apicid;
+#ifdef CONFIG_X86_NUMAQ
 /* Where the IO area was mapped on multiquad, always 0 otherwise */
 void *xquad_portio;
-#ifdef CONFIG_X86_NUMAQ
 EXPORT_SYMBOL(xquad_portio);
 #endif
 
diff -puN drivers/acpi/Kconfig~numaq-build-fix drivers/acpi/Kconfig
--- linux-2.6/drivers/acpi/Kconfig~numaq-build-fix	2006-04-22 04:16:35.000000000 +0900
+++ linux-2.6-hirofumi/drivers/acpi/Kconfig	2006-04-22 04:16:41.000000000 +0900
@@ -4,6 +4,7 @@
 
 menu "ACPI (Advanced Configuration and Power Interface) Support"
 	depends on !X86_VISWS
+	depends on !X86_NUMAQ
 	depends on !IA64_HP_SIM
 	depends on IA64 || X86
 
_
