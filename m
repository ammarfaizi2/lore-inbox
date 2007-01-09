Return-Path: <linux-kernel-owner+w=401wt.eu-S1751321AbXAIKuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbXAIKuy (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbXAIKuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:50:54 -0500
Received: from gundega.hpl.hp.com ([192.6.19.190]:64793 "EHLO
	gundega.hpl.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbXAIKux (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:50:53 -0500
Date: Tue, 9 Jan 2007 02:49:07 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, ak@suse.de,
       Stephane Eranian <eranian@hpl.hp.com>
Subject: Re: [PATCH] add i386 idle notifier (take 3)
Message-ID: <20070109104907.GE27034@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20061220140500.GB30752@frankl.hpl.hp.com> <20061220210514.42ed08cc.akpm@osdl.org> <20061221091242.GA32601@frankl.hpl.hp.com> <20061222010641.GK6993@stusta.de> <20061222100700.GB1895@frankl.hpl.hp.com> <20061223114015.GQ6993@stusta.de> <20070103132015.GE7238@frankl.hpl.hp.com> <20070103230708.GM20714@stusta.de> <20070105105514.GF10599@frankl.hpl.hp.com> <20070105133653.GS20714@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070105133653.GS20714@stusta.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jan 05, 2007 at 02:36:53PM +0100, Adrian Bunk wrote:
> > > > > Where does the perfmon code use the EXPORT_SYMBOL's?
> > > > 
> > > > The perfmon patch includes several kernel modules which make use of
> > > > the exported entry points. The following symbols are exported:
> > > > 
> > > > pfm_pmu_register/pfm_pmu_unregister:
> > > > 	* PMU description module registration.
> > > > 	* Used to describe PMU model.
> > > > 	* Used by perfmon_p4.c, perfmon_core.c, perfmon_mckinley.c, and others
> > > > 
> > > > pfm_fmt_register/pfm_fmt_unregister:
> > > > 	* Sampling format module registration
> > > > 	* Used by perfmon_dfl_smpl.c, perfmon_pebs_smpl.c
> > > > 
> > > > pfm_interrupt_handler:
> > > > 	* PMU interrupt handler
> > > > 	* Used by MIPS-specific perfmon code
> > > > 
> > > > pfm_pmu_conf/pfm_controls:
> > > > 	* global state/control variable
> > > > 
> > > > All exported symbols are currently used. Why are you saying this adds bloat?
> > > 
> > > Which module uses idle_notifier_register/idle_notifier_unregister?
> > > 
> > None.
> > 
> > I have no issue with removing the EXPORT_SYMBOL on i386 and x86_64 if you
> > think that would help.
> 

As a follow-up to this discussion, here is a patch that remove unused
EXPORT_SYMBOL by the i386 idle notifier. It also make it more explicit
that the enter_idle() store must be atomic.

changelog:
	- do not export i386 idle notification registration entry points
	  because there is currently no user for this
	- make it more explicit that the store to idle_state must be atomic

signed-off-by: stephane eranian <eranian@hpl.hp.com>

--- linux-2.6.20-rc3-mm1.orig/arch/i386/kernel/process.c	2007-01-08 01:58:08.000000000 -0800
+++ linux-2.6.20-rc3-mm1/arch/i386/kernel/process.c	2007-01-08 02:01:59.000000000 -0800
@@ -87,19 +87,18 @@ void idle_notifier_register(struct notif
 {
 	atomic_notifier_chain_register(&idle_notifier, n);
 }
-EXPORT_SYMBOL_GPL(idle_notifier_register);
 
 void idle_notifier_unregister(struct notifier_block *n)
 {
 	atomic_notifier_chain_unregister(&idle_notifier, n);
 }
-EXPORT_SYMBOL(idle_notifier_unregister);
 
 static DEFINE_PER_CPU(volatile unsigned long, idle_state);
 
 void enter_idle(void)
 {
-	__get_cpu_var(idle_state) = 1;
+	/* needs to be atomic w.r.t. interrupts, not against other CPUs */
+	__set_bit(0, &__get_cpu_var(idle_state));
 	atomic_notifier_call_chain(&idle_notifier, IDLE_START, NULL);
 }
 
