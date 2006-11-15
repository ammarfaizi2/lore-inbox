Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030903AbWKOTJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030903AbWKOTJA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030904AbWKOTJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:09:00 -0500
Received: from aa011msr.fastwebnet.it ([85.18.95.71]:53997 "EHLO
	aa011msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1030903AbWKOTI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:08:58 -0500
Date: Wed, 15 Nov 2006 20:05:17 +0100
From: Mattia Dongili <malattia@linux.it>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, ego@in.ibm.com,
       Reuben Farrelly <reuben-linuxkernel@reub.net>,
       Andrew Morton <akpm@osdl.org>, davej@redhat.com,
       linux-kernel@vger.kernel.org,
       CPUFreq Mailing List <cpufreq@lists.linux.org.uk>,
       "Sadykov, Denis M" <denis.m.sadykov@intel.com>
Subject: [PATCH 2.6.19-rc5-mm2] cpufreq: set policy->curfreq on initialization
Message-ID: <20061115190517.GA2449@inferi.kami.home>
Mail-Followup-To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	ego@in.ibm.com, Reuben Farrelly <reuben-linuxkernel@reub.net>,
	Andrew Morton <akpm@osdl.org>, davej@redhat.com,
	linux-kernel@vger.kernel.org,
	CPUFreq Mailing List <cpufreq@lists.linux.org.uk>,
	"Sadykov, Denis M" <denis.m.sadykov@intel.com>
References: <EB12A50964762B4D8111D55B764A8454E4128E@scsmsx413.amr.corp.intel.com> <20061115183610.GA4812@inferi.kami.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061115183610.GA4812@inferi.kami.home>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.19-rc5-mm2-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Check the correct variable and set policy->cur upon acpi-cpufreq
initialization to allow the userspace governor to be used as default.

Signed-off-by: Mattia Dongili <malattia@linux.it>

---

Reuben, could you also try if this patch fixes the BUG()?
Thanks

diff --git a/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c b/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
index 18f4715..a630f94 100644
--- a/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
+++ b/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
@@ -699,14 +699,14 @@ static int acpi_cpufreq_cpu_init(struct
 	if (result)
 		goto err_freqfree;
 
-	switch (data->cpu_feature) {
+	switch (perf->control_register.space_id) {
 	case ACPI_ADR_SPACE_SYSTEM_IO:
 		/* Current speed is unknown and not detectable by IO port */
 		policy->cur = acpi_cpufreq_guess_freq(data, policy->cpu);
 		break;
 	case ACPI_ADR_SPACE_FIXED_HARDWARE:
 		acpi_cpufreq_driver.get = get_cur_freq_on_cpu;
-		get_cur_freq_on_cpu(cpu);
+		policy->cur = get_cur_freq_on_cpu(cpu);
 		break;
 	default:
 		break;
