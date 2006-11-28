Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936106AbWK1UZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936106AbWK1UZZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 15:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936104AbWK1UZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 15:25:25 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:14735 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S936099AbWK1UZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 15:25:24 -0500
Date: Tue, 28 Nov 2006 21:23:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: mm-commits@vger.kernel.org, ak@suse.de, ashok.raj@intel.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: [patch] genapic: default to physical mode on hotplug CPU kernels
Message-ID: <20061128202322.GA29334@elte.hu>
References: <200611140109.kAE19f5e014490@shell0.pdx.osdl.net> <20061127141849.A9978@unix-os.sc.intel.com> <20061128063345.GA19523@elte.hu> <20061128111414.A16460@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061128111414.A16460@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:

> On Tue, Nov 28, 2006 at 07:33:46AM +0100, Ingo Molnar wrote:
> > -	if (clusters <= 1 && max_cluster <= 8 && cluster_cnt[0] == max_cluster)
> > +	if (max_apic < 8)
> 
> Patch mostly looks good.  Instead of checking for max_apic, can we use
> 	cpus_weight(cpu_possible_map) <= 8

ok - but i think it's still possible the BIOS tells us APIC IDs that are 
larger than 7, even if there are fewer CPUs. So i think the patch below 
should cover it. Agreed?

	Ingo

-------------------->
From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] genapic: default to physical mode on hotplug CPU kernels

default to physical mode on hotplug CPU kernels.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux/arch/x86_64/kernel/genapic.c
===================================================================
--- linux.orig/arch/x86_64/kernel/genapic.c
+++ linux/arch/x86_64/kernel/genapic.c
@@ -51,7 +51,7 @@ void __init clustered_apic_check(void)
 			max_apic = id;
 	}
 
-	if (max_apic < 8)
+	if (max_apic < 8 && cpus_weight(cpu_possible_map) <= 8)
 		genapic = &apic_flat;
 	else
 		genapic = &apic_physflat;
