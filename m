Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262541AbVAKCOC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbVAKCOC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 21:14:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbVAKCLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 21:11:49 -0500
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:57013 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262595AbVAKCJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 21:09:55 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] ACPI using smp_processor_id in preemptible code
Date: Mon, 10 Jan 2005 21:09:48 -0500
User-Agent: KMail/1.6.2
Cc: Li Shaohua <shaohua.li@intel.com>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>
References: <16A54BF5D6E14E4D916CE26C9AD30575F05409@pdsmsx402.ccr.corp.intel.com> <20050110095508.GJ1353@elf.ucw.cz> <1105405464.18834.4.camel@sli10-desk.sh.intel.com>
In-Reply-To: <1105405464.18834.4.camel@sli10-desk.sh.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200501102109.51513.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 January 2005 08:04 pm, Li Shaohua wrote:
> On Mon, 2005-01-10 at 17:55, Pavel Machek wrote:
> > > >I enabled CPU hotplug and preemptible debugging... now I get...
> > > >
> > > >BUG: using smp_processor_id() in preemptible [00000001] code:
> > > >swapper/0
> > > >caller is acpi_processor_idle+0xb/0x235
> > > > [<c020ba28>] smp_processor_id+0xa8/0xc0
> > > > [<c02338ce>] acpi_processor_idle+0xb/0x235
> > > > [<c02338c3>] acpi_processor_idle+0x0/0x235
> > > > [<c02338ce>] acpi_processor_idle+0xb/0x235
> > > > [<c02338c3>] acpi_processor_idle+0x0/0x235
> > > > [<c02338c3>] acpi_processor_idle+0x0/0x235
> > > > [<c02338c3>] acpi_processor_idle+0x0/0x235
> > > > [<c0101115>] cpu_idle+0x75/0x110
> > > > [<c04f5988>] start_kernel+0x158/0x180
> > > > [<c04f5390>] unknown_bootoption+0x0/0x1e0
> > > It doesn't trouble to me. It's in idle thread.
> > 
> > You mean it does not happen to you? On my machine it fills logs very
> > quickly...
> What I mean is idle thread can't be migrated so this doesn't impact the
> correctness. I guess the preemptible debugging can't recognise such
> situation.
>

Why don't you just move that statement down, like in the patch below.
Also, if processor is not registered but idle thread managed to call
acpi_processor_idle I think it's BUG()...

I also cut out unnecessary local variable initializations.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

-- 
Dmitry

===== drivers/acpi/processor.c 1.72 vs edited =====
--- 1.72/drivers/acpi/processor.c	2004-12-03 02:25:47 -05:00
+++ edited/drivers/acpi/processor.c	2005-01-10 20:58:38 -05:00
@@ -337,15 +337,11 @@
 static void
 acpi_processor_idle (void)
 {
-	struct acpi_processor	*pr = NULL;
-	struct acpi_processor_cx *cx = NULL;
-	unsigned int			next_state = 0;
-	unsigned int		sleep_ticks = 0;
-	u32			t1, t2 = 0;
-
-	pr = processors[smp_processor_id()];
-	if (!pr)
-		return;
+	struct acpi_processor	*pr;
+	struct acpi_processor_cx *cx;
+	unsigned int		next_state;
+	unsigned int		sleep_ticks;
+	u32			t1, t2;
 
 	/*
 	 * Interrupts must be disabled during bus mastering calculations and
@@ -361,6 +357,10 @@
 		local_irq_enable();
 		return;
 	}
+
+	pr = processors[smp_processor_id()];
+	if (!pr)
+		BUG();
 
 	cx = &(pr->power.states[pr->power.state]);
 
