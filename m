Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265768AbUHFLE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265768AbUHFLE6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 07:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268122AbUHFLE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 07:04:58 -0400
Received: from gort.metaparadigm.com ([203.117.131.12]:63962 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S265768AbUHFLEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 07:04:39 -0400
Message-ID: <411365C9.5020909@metaparadigm.com>
Date: Fri, 06 Aug 2004 19:04:41 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040802 Debian/1.7.1-5
X-Accept-Language: en
MIME-Version: 1.0
To: jeremy@goop.org, davej@codemonkey.org.uk
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] - Initial dothan speedstep support
References: <41131120.5060202@metaparadigm.com>
In-Reply-To: <41131120.5060202@metaparadigm.com>
Content-Type: multipart/mixed;
 boundary="------------080700070701060601020007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080700070701060601020007
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

On 08/06/04 13:03, Michael Clark wrote:
> Hi All,
> 
> Was looking for a patch for Dothan cpufreq support but could only
> find the stepping identification code here:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm6/broken-out/bk-cpufreq.patch 

I've since found there is a newer speedstep-centrino in 2.6.8-rc3-mm1
although still without dothan support but slight changes for more
informative messages about steppings without needed table support.

So i've rediffed table support for dothan b0 steppings to 2.6.8-rc3-mm1
and have verified by googling that b0 stepping exists for at least 1.5
through 1.8 (anyone have a 2.0GHz dothan?)

Also proofread the voltage tables against the docs just to make sure.

~mc

--------------080700070701060601020007
Content-Type: text/x-patch;
 name="cpufreq-speedstep-dothan-3-2.6.8-rc3-mm1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpufreq-speedstep-dothan-3-2.6.8-rc3-mm1.patch"

--- linux-2.6.8-rc3-mm1/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c.orig	2004-08-06 18:42:15.000000000 +0800
+++ linux-2.6.8-rc3-mm1/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2004-08-06 18:44:28.000000000 +0800
@@ -195,6 +195,82 @@
 	OP(1700, 1484),
 	{ .frequency = CPUFREQ_TABLE_END }
 };
+
+#undef OP
+
+/* Dothan processor datasheet 30218903.pdf defines 4 voltages for each
+   frequency (VID#A through VID#D) - this macro allows us to define all
+   of these but we only use the VID#C voltages at compile time - this may
+   need some work if we want to select the voltage profile at runtime. */
+
+#define OP(mhz, mva, mvb, mvc, mvd)					\
+	{								\
+		.frequency = (mhz) * 1000,				\
+		.index = (((mhz)/100) << 8) | ((mvc - 700) / 16)       	\
+	}
+
+/* Intel Pentium M processor 715 / 1.50GHz (Dothan) */
+static struct cpufreq_frequency_table dothan_1500[] =
+{
+	OP( 600,  988,  988,  988,  988),
+	OP( 800, 1068, 1068, 1068, 1052),
+	OP(1000, 1148, 1148, 1132, 1116),
+	OP(1200, 1228, 1212, 1212, 1180),
+	OP(1500, 1340, 1324, 1308, 1276),
+	{ .frequency = CPUFREQ_TABLE_END }
+};
+
+/* Intel Pentium M processor 725 / 1.60GHz (Dothan) */
+static struct cpufreq_frequency_table dothan_1600[] =
+{
+	OP( 600,  988,  988,  988,  988),
+	OP( 800, 1068, 1068, 1052, 1052),
+	OP(1000, 1132, 1132, 1116, 1116),
+	OP(1200, 1212, 1196, 1180, 1164),
+	OP(1400, 1276, 1260, 1244, 1228),
+	OP(1600, 1340, 1324, 1308, 1276),
+	{ .frequency = CPUFREQ_TABLE_END }
+};
+
+/* Intel Pentium M processor 735 / 1.70GHz (Dothan) */
+static struct cpufreq_frequency_table dothan_1700[] =
+{
+	OP( 600,  988,  988,  988,  988),
+	OP( 800, 1052, 1052, 1052, 1052),
+	OP(1000, 1116, 1116, 1116, 1100),
+	OP(1200, 1180, 1180, 1164, 1148),
+	OP(1400, 1244, 1244, 1228, 1212),
+	OP(1700, 1340, 1324, 1308, 1276),
+	{ .frequency = CPUFREQ_TABLE_END }
+};
+
+/* Intel Pentium M processor 745 / 1.80GHz (Dothan) */
+static struct cpufreq_frequency_table dothan_1800[] =
+{
+	OP( 600,  988,  988,  988,  988),
+	OP( 800, 1052, 1052, 1052, 1036),
+	OP(1000, 1116, 1100, 1100, 1084),
+	OP(1200, 1164, 1164, 1148, 1132),
+	OP(1400, 1228, 1212, 1212, 1180),
+	OP(1600, 1292, 1276, 1260, 1228),
+	OP(1800, 1340, 1324, 1308, 1276),
+	{ .frequency = CPUFREQ_TABLE_END }
+};
+
+/* Intel Pentium M processor 755 / 2.00GHz (Dothan) */
+static struct cpufreq_frequency_table dothan_2000[] =
+{
+	OP( 600,  988,  988,  988,  988),
+	OP( 800, 1052, 1036, 1036, 1036),
+	OP(1000, 1100, 1084, 1084, 1084),
+	OP(1200, 1148, 1132, 1132, 1116),
+	OP(1400, 1196, 1180, 1180, 1164),
+	OP(1600, 1244, 1228, 1228, 1196),
+	OP(1800, 1292, 1276, 1276, 1244),
+	OP(2000, 1340, 1324, 1308, 1276),
+	{ .frequency = CPUFREQ_TABLE_END }
+};
+
 #undef OP
 
 #define _BANIAS(cpuid, max, name)	\
@@ -205,6 +281,13 @@
 }
 #define BANIAS(max)	_BANIAS(&cpu_ids[CPU_BANIAS], max, #max)
 
+#define DOTHAN(cpuid, max, name)	\
+{	.cpu_id		= cpuid,	\
+	.model_name	= "Intel(R) Pentium(R) M processor " name "GHz", \
+	.max_freq	= (max)*1000,	\
+	.op_points	= dothan_##max,	\
+}
+
 /* CPU models, their operating frequency range, and freq/voltage
    operating points */
 static struct cpu_model models[] =
@@ -218,6 +301,11 @@
 	BANIAS(1500),
 	BANIAS(1600),
 	BANIAS(1700),
+	DOTHAN(&cpu_ids[CPU_DOTHAN_B0], 1500, "1.50"),
+	DOTHAN(&cpu_ids[CPU_DOTHAN_B0], 1600, "1.60"),
+	DOTHAN(&cpu_ids[CPU_DOTHAN_B0], 1700, "1.70"),
+	DOTHAN(&cpu_ids[CPU_DOTHAN_B0], 1800, "1.80"),
+	DOTHAN(&cpu_ids[CPU_DOTHAN_B0], 2000, "2.00"),
 
 	/* NULL model_name is a wildcard */
 	{ &cpu_ids[CPU_DOTHAN_A1], NULL, 0, NULL },
@@ -227,6 +315,7 @@
 };
 #undef _BANIAS
 #undef BANIAS
+#undef DOTHAN
 
 static int centrino_cpu_init_table(struct cpufreq_policy *policy)
 {

--------------080700070701060601020007--
