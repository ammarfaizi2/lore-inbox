Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030334AbVLGTy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030334AbVLGTy5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 14:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbVLGTy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 14:54:57 -0500
Received: from fmr24.intel.com ([143.183.121.16]:5304 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030331AbVLGTy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 14:54:56 -0500
Date: Wed, 7 Dec 2005 11:54:52 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: linux-kernel@vger.kernel.org
Cc: linux-ia64@vger.kernel.org, Andreas Schwab <schwab@suse.de>
Subject: [PATCH] Drop per-irq counters from /proc/stat (Was: Reading /proc/stat is slooow)
Message-ID: <20051207195452.GA8873@agluck-lia64.sc.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F05204A1E@scsmsx401.amr.corp.intel.com> <894E37DECA393E4D9374E0ACBBE7427003BC9642@pdsmsx402.ccr.corp.intel.com> <20051206165800.GA6277@agluck-lia64.sc.intel.com> <jeslt6xib3.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jeslt6xib3.fsf@sykes.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 06:10:40PM +0100, Andreas Schwab wrote:
> "Luck, Tony" <tony.luck@intel.com> writes:
> 
> > 2) The problem loop is already #ifdef'd out for PPC64 and ALPHA.  We could add
> > IA64 to that exclusive club and just not include the per irq sums.  Since kstat_irqs()
> > computes the sums in an "int", they will wrap frequently on a large system
> > (512 cpus * default 250Hz = 128000 ... which wraps a 32-bit unsigned in 9 hours
> > and 19 minutes) ... so their usefulness is questionable.  Does xosview use
> > the per-irq values?
> 
> It doesn't use them, it uses /proc/interrupts instead.  So IMHO this would
> be the preferred solution.

Anyone know of any applications that *DO* depend on the per-irq counters
in /proc/stat?

I could just add IA64 to the ugly #ifdef:

-#if !defined(CONFIG_PPC64) && !defined(CONFIG_ALPHA)
+#if !defined(CONFIG_PPC64) && !defined(CONFIG_ALPHA) && !defined(CONFIG_IA64)

But perhaps it might be simpler to skip straight to this:

[PATCH] Drop per-irq counters from /proc/stat

It is very expensive to produce the per-irq counter values in /proc/stat
(the code does a very cache unfriendly walk across all percpu structures
for each irq).  Some architectures (PPC64, ALPHA) don't provide this
information in this file.  Applications which do want this can derive it
by adding the percpu values in /proc/interrupts.

Signed-off-by: Tony Luck <tony.luck@intel.com>

---

diff --git a/fs/proc/proc_misc.c b/fs/proc/proc_misc.c
index 5b6b0b6..64d96bf 100644
--- a/fs/proc/proc_misc.c
+++ b/fs/proc/proc_misc.c
@@ -396,15 +396,10 @@ static int show_stat(struct seq_file *p,
 			(unsigned long long)cputime64_to_clock_t(softirq),
 			(unsigned long long)cputime64_to_clock_t(steal));
 	}
-	seq_printf(p, "intr %llu", (unsigned long long)sum);
-
-#if !defined(CONFIG_PPC64) && !defined(CONFIG_ALPHA)
-	for (i = 0; i < NR_IRQS; i++)
-		seq_printf(p, " %u", kstat_irqs(i));
-#endif
+	seq_printf(p, "intr %llu\n", (unsigned long long)sum);
 
 	seq_printf(p,
-		"\nctxt %llu\n"
+		"ctxt %llu\n"
 		"btime %lu\n"
 		"processes %lu\n"
 		"procs_running %lu\n"


-Tony
