Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263551AbUEWUJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263551AbUEWUJR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 16:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263555AbUEWUJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 16:09:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:47518 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263551AbUEWUIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 16:08:50 -0400
Date: Sun, 23 May 2004 13:08:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp: fix swsusp with intel-agp
Message-Id: <20040523130809.03ca7209.akpm@osdl.org>
In-Reply-To: <20040523175444.GE804@elf.ucw.cz>
References: <20040521100734.GA31550@elf.ucw.cz>
	<20040521162044.7ad42db2.akpm@osdl.org>
	<20040523175444.GE804@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:
>
> > >
>  > > +#ifdef CONFIG_SOFTWARE_SUSPEND
>  > > +	{
>  > > +		extern char swsusp_pg_dir[PAGE_SIZE];
>  > > +		memcpy(swsusp_pg_dir, swapper_pg_dir, PAGE_SIZE);
>  > > +	}
>  > > +#endif
>  > 
>  > Please move the declaration of swsusp_pg_dir[] to a header file where it is
>  > visible to both the users and the definition site, then resend.
> 
>  Hmm, on second thought, it is accessed from one C file and once from
>  assembly => prototype should not be needed.
> 
>  Upon popular request I made it depend on CONFIG_PM (pmdisk will need
>  it, too, and suspend2 wants it also). If you don't like that please
>  simply replace CONFIG_PM with CONFIG_SOFTWARE_SUSPEND...

Mabe it's a sign of advancing years, but I still think that 4k is worth
saving ;)  I ended up with the below.

You say that pmdisk needs this.  I assume that means that we should also
replace swapper_pg_dir with swsusp_pg_dir in pmdisk.S?



From: Pavel Machek <pavel@suse.cz>

swsusp contained rather nasty bug where it killed machine when intel-agp or
anything else split kernel 4MB mapping.  Herbert Xu diagnosed this.  Fixed by
switching to "known good" mapping for during suspend/resume.


---

 25-akpm/arch/i386/mm/init.c      |   21 +++++++++++++++++++++
 25-akpm/arch/i386/power/swsusp.S |    2 +-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff -puN arch/i386/mm/init.c~swsusp-fix-swsusp-with-intel-agp arch/i386/mm/init.c
--- 25/arch/i386/mm/init.c~swsusp-fix-swsusp-with-intel-agp	2004-05-23 13:01:00.497765968 -0700
+++ 25-akpm/arch/i386/mm/init.c	2004-05-23 13:03:47.195424072 -0700
@@ -327,9 +327,30 @@ static void __init pagetable_init (void)
 #endif
 }
 
+#if defined(CONFIG_PM_DISK) || defined(CONFIG_SOFTWARE_SUSPEND)
+/*
+ * Swap suspend & friends need this for resume because things like the intel-agp
+ * driver might have split up a kernel 4MB mapping.
+ */
+char __nosavedata swsusp_pg_dir[PAGE_SIZE]
+	__attribute__ ((aligned (PAGE_SIZE)));
+
+static inline void save_pg_dir(void)
+{
+	memcpy(swsusp_pg_dir, swapper_pg_dir, PAGE_SIZE);
+}
+#else
+static inline void save_pg_dir(void)
+{
+}
+#endif
+
 void zap_low_mappings (void)
 {
 	int i;
+
+	save_pg_dir();
+
 	/*
 	 * Zap initial low-memory mappings.
 	 *
diff -puN arch/i386/power/swsusp.S~swsusp-fix-swsusp-with-intel-agp arch/i386/power/swsusp.S
--- 25/arch/i386/power/swsusp.S~swsusp-fix-swsusp-with-intel-agp	2004-05-23 13:01:00.499765664 -0700
+++ 25-akpm/arch/i386/power/swsusp.S	2004-05-23 13:01:00.503765056 -0700
@@ -36,7 +36,7 @@ ENTRY(do_magic)
 	jmp .L1449
 	.p2align 4,,7
 .L1450:
-	movl $swapper_pg_dir-__PAGE_OFFSET,%ecx
+	movl $swsusp_pg_dir-__PAGE_OFFSET,%ecx
 	movl %ecx,%cr3
 
 	call do_magic_resume_1

_

