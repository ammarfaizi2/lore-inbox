Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268088AbUHFFDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268088AbUHFFDl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 01:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268089AbUHFFDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 01:03:41 -0400
Received: from gort.metaparadigm.com ([203.117.131.12]:44998 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S268088AbUHFFDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 01:03:32 -0400
Message-ID: <41131120.5060202@metaparadigm.com>
Date: Fri, 06 Aug 2004 13:03:28 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040802 Debian/1.7.1-5
X-Accept-Language: en
MIME-Version: 1.0
To: jeremy@goop.org, davej@codemonkey.org.uk
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] - Initial dothan speedstep support
Content-Type: multipart/mixed;
 boundary="------------020901040206010906060307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020901040206010906060307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

Was looking for a patch for Dothan cpufreq support but could only
find the stepping identification code here:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm6/broken-out/bk-cpufreq.patch

So here's a patch on top of the above patch that adds all of the
dothan frequency/voltages for processors 715, 725, 735, 745, 755

Tested and working as it should so far with a 745. The stepping in the
model table for the others may need to be tweaked.

The Dothan processor datasheet 30218903.pdf defines 4 voltages for
each frequency (VID#A through VID#D) whereas Banias only suggests a
typical voltage and no min or max for each freq so i've used the OP
macro to allow definition of all voltages (A through D) but the macro
currently just uses VID#C at compile time (the second lowest voltage
profile).

The docs define these 4 profiles but don't say anywhere in which cases
they should be used. I guess it may be a case of usage of the differing
profiles based on the tolerance and accuracy of the power supply in use
for the specific application.

~mc


--------------020901040206010906060307
Content-Type: text/x-patch;
 name="cupfreq-speedstep-dothan-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cupfreq-speedstep-dothan-1.patch"

--- ./arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c.bk-patched	2004-08-06 11:26:05.000000000 +0800
+++ ./arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2004-08-06 12:42:32.000000000 +0800
@@ -198,6 +198,82 @@
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
@@ -208,6 +284,13 @@
 }
 #define BANIAS(max)	_BANIAS(&cpu_id_banias, max, #max)
 
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
@@ -221,6 +304,11 @@
 	BANIAS(1500),
 	BANIAS(1600),
 	BANIAS(1700),
+	DOTHAN(&cpu_id_dothan_b0, 1500, "1.50"), /* check stepping and name */
+	DOTHAN(&cpu_id_dothan_b0, 1600, "1.60"), /* check stepping and name */
+	DOTHAN(&cpu_id_dothan_b0, 1700, "1.70"), /* check stepping and name */
+	DOTHAN(&cpu_id_dothan_b0, 1800, "1.80"),
+	DOTHAN(&cpu_id_dothan_b0, 2000, "2.00"), /* check stepping and name */
 	{ NULL, }
 };
 #undef _BANIAS

--------------020901040206010906060307--
