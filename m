Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbWH3Mpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWH3Mpd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 08:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbWH3Mpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 08:45:32 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:52822 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750898AbWH3Mp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 08:45:29 -0400
Date: Wed, 30 Aug 2006 14:45:26 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [S390] cleanup sysinfo and add system z9 specific extensions.
Message-ID: <20060830124526.GH22276@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[S390] cleanup sysinfo and add system z9 specific extensions.

With System z9 additional fields have been added to the output of the
store system information instruction. This patch adds the new model
information field and the alternate cpu capability fields to the
output of /proc/sysinfo. While we at it clean up the code as well.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 drivers/s390/sysinfo.c |  453 ++++++++++++++++++++++++-------------------------
 1 files changed, 230 insertions(+), 223 deletions(-)

diff -urpN linux-2.6/drivers/s390/sysinfo.c linux-2.6-patched/drivers/s390/sysinfo.c
--- linux-2.6/drivers/s390/sysinfo.c	2006-08-30 14:24:13.000000000 +0200
+++ linux-2.6-patched/drivers/s390/sysinfo.c	2006-08-30 14:25:00.000000000 +0200
@@ -11,19 +11,18 @@
 #include <linux/init.h>
 #include <asm/ebcdic.h>
 
-struct sysinfo_1_1_1
-{
+struct sysinfo_1_1_1 {
 	char reserved_0[32];
 	char manufacturer[16];
 	char type[4];
 	char reserved_1[12];
-	char model[16];
+	char model_capacity[16];
 	char sequence[16];
 	char plant[4];
+	char model[16];
 };
 
-struct sysinfo_1_2_1
-{
+struct sysinfo_1_2_1 {
 	char reserved_0[80];
 	char sequence[16];
 	char plant[4];
@@ -31,9 +30,12 @@ struct sysinfo_1_2_1
 	unsigned short cpu_address;
 };
 
-struct sysinfo_1_2_2
-{
-	char reserved_0[32];
+struct sysinfo_1_2_2 {
+	char format;
+	char reserved_0[1];
+	unsigned short acc_offset;
+	char reserved_1[24];
+	unsigned int secondary_capability;
 	unsigned int capability;
 	unsigned short cpus_total;
 	unsigned short cpus_configured;
@@ -42,8 +44,12 @@ struct sysinfo_1_2_2
 	unsigned short adjustment[0];
 };
 
-struct sysinfo_2_2_1
-{
+struct sysinfo_1_2_2_extension {
+	unsigned int alt_capability;
+	unsigned short alt_adjustment[0];
+};
+
+struct sysinfo_2_2_1 {
 	char reserved_0[80];
 	char sequence[16];
 	char plant[4];
@@ -51,15 +57,11 @@ struct sysinfo_2_2_1
 	unsigned short cpu_address;
 };
 
-struct sysinfo_2_2_2
-{
+struct sysinfo_2_2_2 {
 	char reserved_0[32];
 	unsigned short lpar_number;
 	char reserved_1;
 	unsigned char characteristics;
-	#define LPAR_CHAR_DEDICATED	(1 << 7)
-	#define LPAR_CHAR_SHARED	(1 << 6)
-	#define LPAR_CHAR_LIMITED	(1 << 5)
 	unsigned short cpus_total;
 	unsigned short cpus_configured;
 	unsigned short cpus_standby;
@@ -71,12 +73,14 @@ struct sysinfo_2_2_2
 	unsigned short cpus_shared;
 };
 
-struct sysinfo_3_2_2
-{
+#define LPAR_CHAR_DEDICATED	(1 << 7)
+#define LPAR_CHAR_SHARED	(1 << 6)
+#define LPAR_CHAR_LIMITED	(1 << 5)
+
+struct sysinfo_3_2_2 {
 	char reserved_0[31];
 	unsigned char count;
-	struct
-	{
+	struct {
 		char reserved_0[4];
 		unsigned short cpus_total;
 		unsigned short cpus_configured;
@@ -90,136 +94,223 @@ struct sysinfo_3_2_2
 	} vm[8];
 };
 
-union s390_sysinfo
+static inline int stsi(void *sysinfo, int fc, int sel1, int sel2)
 {
-	struct sysinfo_1_1_1 sysinfo_1_1_1;
-	struct sysinfo_1_2_1 sysinfo_1_2_1;
-	struct sysinfo_1_2_2 sysinfo_1_2_2;
-	struct sysinfo_2_2_1 sysinfo_2_2_1;
-	struct sysinfo_2_2_2 sysinfo_2_2_2;
-	struct sysinfo_3_2_2 sysinfo_3_2_2;
-};
-
-static inline int stsi (void *sysinfo, 
-                        int fc, int sel1, int sel2)
-{
-	int cc, retv;
+	register int r0 asm("0") = (fc << 28) | sel1;
+	register int r1 asm("1") = sel2;
 
-#ifndef CONFIG_64BIT
-	__asm__ __volatile__ (	"lr\t0,%2\n"
-				"\tlr\t1,%3\n"
-				"\tstsi\t0(%4)\n"
-				"0:\tipm\t%0\n"
-				"\tsrl\t%0,28\n"
-				"1:lr\t%1,0\n"
-				".section .fixup,\"ax\"\n"
-				"2:\tlhi\t%0,3\n"
-				"\tbras\t1,3f\n"
-				"\t.long 1b\n"
-				"3:\tl\t1,0(1)\n"
-				"\tbr\t1\n"
-				".previous\n"
-				".section __ex_table,\"a\"\n"
-				"\t.align 4\n"
-				"\t.long 0b,2b\n"
-				".previous\n"
-				: "=d" (cc), "=d" (retv)
-				: "d" ((fc << 28) | sel1), "d" (sel2), "a" (sysinfo) 
-				: "cc", "memory", "0", "1" );
-#else
-	__asm__ __volatile__ (	"lr\t0,%2\n"
-				"lr\t1,%3\n"
-				"\tstsi\t0(%4)\n"
-				"0:\tipm\t%0\n"
-				"\tsrl\t%0,28\n"
-				"1:lr\t%1,0\n"
-				".section .fixup,\"ax\"\n"
-				"2:\tlhi\t%0,3\n"
-				"\tjg\t1b\n"
-				".previous\n"
-				".section __ex_table,\"a\"\n"
-				"\t.align 8\n"
-				"\t.quad 0b,2b\n"
-				".previous\n"
-				: "=d" (cc), "=d" (retv)
-				: "d" ((fc << 28) | sel1), "d" (sel2), "a" (sysinfo) 
-				: "cc", "memory", "0", "1" );
-#endif
-
-	return cc? -1 : retv;
+	asm volatile(
+		"   stsi 0(%2)\n"
+		"0: jz   2f\n"
+		"1: lhi  %0,%3\n"
+		"2:\n"
+		EX_TABLE(0b,1b)
+		: "+d" (r0) : "d" (r1), "a" (sysinfo), "K" (-ENOSYS)
+		: "cc", "memory" );
+	return r0;
 }
 
-static inline int stsi_0 (void)
+static inline int stsi_0(void)
 {
 	int rc = stsi (NULL, 0, 0, 0);
-	return rc == -1 ? rc : (((unsigned int)rc) >> 28);
+	return rc == -ENOSYS ? rc : (((unsigned int) rc) >> 28);
 }
 
-static inline int stsi_1_1_1 (struct sysinfo_1_1_1 *info)
+static int stsi_1_1_1(struct sysinfo_1_1_1 *info, char *page, int len)
 {
-	int rc = stsi (info, 1, 1, 1);
-	if (rc != -1)
-	{
-		EBCASC (info->manufacturer, sizeof(info->manufacturer));
-		EBCASC (info->type, sizeof(info->type));
-		EBCASC (info->model, sizeof(info->model));
-		EBCASC (info->sequence, sizeof(info->sequence));
-		EBCASC (info->plant, sizeof(info->plant));
-	}
-	return rc == -1 ? rc : 0;
+	if (stsi(info, 1, 1, 1) == -ENOSYS)
+		return len;
+
+	EBCASC(info->manufacturer, sizeof(info->manufacturer));
+	EBCASC(info->type, sizeof(info->type));
+	EBCASC(info->model, sizeof(info->model));
+	EBCASC(info->sequence, sizeof(info->sequence));
+	EBCASC(info->plant, sizeof(info->plant));
+	EBCASC(info->model_capacity, sizeof(info->model_capacity));
+	len += sprintf(page + len, "Manufacturer:         %-16.16s\n",
+		       info->manufacturer);
+	len += sprintf(page + len, "Type:                 %-4.4s\n",
+		       info->type);
+	if (info->model[0] != '\0')
+		/*
+		 * Sigh: the model field has been renamed with System z9
+		 * to model_capacity and a new model field has been added
+		 * after the plant field. To avoid confusing older programs
+		 * the "Model:" prints "model_capacity model" or just
+		 * "model_capacity" if the model string is empty .
+		 */
+		len += sprintf(page + len,
+			       "Model:                %-16.16s %-16.16s\n",
+			       info->model_capacity, info->model);
+	else
+		len += sprintf(page + len, "Model:                %-16.16s\n",
+			       info->model_capacity);
+	len += sprintf(page + len, "Sequence Code:        %-16.16s\n",
+		       info->sequence);
+	len += sprintf(page + len, "Plant:                %-4.4s\n",
+		       info->plant);
+	len += sprintf(page + len, "Model Capacity:       %-16.16s\n",
+		       info->model_capacity);
+	return len;
 }
 
-static inline int stsi_1_2_1 (struct sysinfo_1_2_1 *info)
+#if 0 /* Currently unused */
+static int stsi_1_2_1(struct sysinfo_1_2_1 *info, char *page, int len)
 {
-	int rc = stsi (info, 1, 2, 1);
-	if (rc != -1)
-	{
-		EBCASC (info->sequence, sizeof(info->sequence));
-		EBCASC (info->plant, sizeof(info->plant));
-	}
-	return rc == -1 ? rc : 0;
+	if (stsi(info, 1, 2, 1) == -ENOSYS)
+		return len;
+
+	len += sprintf(page + len, "\n");
+	EBCASC(info->sequence, sizeof(info->sequence));
+	EBCASC(info->plant, sizeof(info->plant));
+	len += sprintf(page + len, "Sequence Code of CPU: %-16.16s\n",
+		       info->sequence);
+	len += sprintf(page + len, "Plant of CPU:         %-16.16s\n",
+		       info->plant);
+	return len;
 }
+#endif
 
-static inline int stsi_1_2_2 (struct sysinfo_1_2_2 *info)
+static int stsi_1_2_2(struct sysinfo_1_2_2 *info, char *page, int len)
 {
-	int rc = stsi (info, 1, 2, 2);
-	return rc == -1 ? rc : 0;
+	struct sysinfo_1_2_2_extension *ext;
+	int i;
+
+	if (stsi(info, 1, 2, 2) == -ENOSYS)
+		return len;
+	ext = (struct sysinfo_1_2_2_extension *)
+		((unsigned long) info + info->acc_offset);
+
+	len += sprintf(page + len, "\n");
+	len += sprintf(page + len, "CPUs Total:           %d\n",
+		       info->cpus_total);
+	len += sprintf(page + len, "CPUs Configured:      %d\n",
+		       info->cpus_configured);
+	len += sprintf(page + len, "CPUs Standby:         %d\n",
+		       info->cpus_standby);
+	len += sprintf(page + len, "CPUs Reserved:        %d\n",
+		       info->cpus_reserved);
+
+	if (info->format == 1) {
+		/*
+		 * Sigh 2. According to the specification the alternate
+		 * capability field is a 32 bit floating point number
+		 * if the higher order 8 bits are not zero. Printing
+		 * a floating point number in the kernel is a no-no,
+		 * always print the number as 32 bit unsigned integer.
+		 * The user-space needs to know about the stange
+		 * encoding of the alternate cpu capability.
+		 */
+		len += sprintf(page + len, "Capability:           %u %u\n",
+			       info->capability, ext->alt_capability);
+		for (i = 2; i <= info->cpus_total; i++)
+			len += sprintf(page + len,
+				       "Adjustment %02d-way:    %u %u\n",
+				       i, info->adjustment[i-2],
+				       ext->alt_adjustment[i-2]);
+
+	} else {
+		len += sprintf(page + len, "Capability:           %u\n",
+			       info->capability);
+		for (i = 2; i <= info->cpus_total; i++)
+			len += sprintf(page + len,
+				       "Adjustment %02d-way:    %u\n",
+				       i, info->adjustment[i-2]);
+	}
+
+	if (info->secondary_capability != 0)
+		len += sprintf(page + len, "Secondary Capability: %d\n",
+			       info->secondary_capability);
+
+	return len;
 }
 
-static inline int stsi_2_2_1 (struct sysinfo_2_2_1 *info)
+#if 0 /* Currently unused */
+static int stsi_2_2_1(struct sysinfo_2_2_1 *info, char *page, int len)
 {
-	int rc = stsi (info, 2, 2, 1);
-	if (rc != -1)
-	{
-		EBCASC (info->sequence, sizeof(info->sequence));
-		EBCASC (info->plant, sizeof(info->plant));
-	}
-	return rc == -1 ? rc : 0;
+	if (stsi(info, 2, 2, 1) == -ENOSYS)
+		return len;
+
+	len += sprintf(page + len, "\n");
+	EBCASC (info->sequence, sizeof(info->sequence));
+	EBCASC (info->plant, sizeof(info->plant));
+	len += sprintf(page + len, "Sequence Code of logical CPU: %-16.16s\n",
+		       info->sequence);
+	len += sprintf(page + len, "Plant of logical CPU: %-16.16s\n",
+		       info->plant);
+	return len;
 }
+#endif
 
-static inline int stsi_2_2_2 (struct sysinfo_2_2_2 *info)
+static int stsi_2_2_2(struct sysinfo_2_2_2 *info, char *page, int len)
 {
-	int rc = stsi (info, 2, 2, 2);
-	if (rc != -1)
-	{
-		EBCASC (info->name, sizeof(info->name));
-  	}
-	return rc == -1 ? rc : 0;
+	if (stsi(info, 2, 2, 2) == -ENOSYS)
+		return len;
+
+	EBCASC (info->name, sizeof(info->name));
+
+	len += sprintf(page + len, "\n");
+	len += sprintf(page + len, "LPAR Number:          %d\n",
+		       info->lpar_number);
+
+	len += sprintf(page + len, "LPAR Characteristics: ");
+	if (info->characteristics & LPAR_CHAR_DEDICATED)
+		len += sprintf(page + len, "Dedicated ");
+	if (info->characteristics & LPAR_CHAR_SHARED)
+		len += sprintf(page + len, "Shared ");
+	if (info->characteristics & LPAR_CHAR_LIMITED)
+		len += sprintf(page + len, "Limited ");
+	len += sprintf(page + len, "\n");
+
+	len += sprintf(page + len, "LPAR Name:            %-8.8s\n",
+		       info->name);
+
+	len += sprintf(page + len, "LPAR Adjustment:      %d\n",
+		       info->caf);
+
+	len += sprintf(page + len, "LPAR CPUs Total:      %d\n",
+		       info->cpus_total);
+	len += sprintf(page + len, "LPAR CPUs Configured: %d\n",
+		       info->cpus_configured);
+	len += sprintf(page + len, "LPAR CPUs Standby:    %d\n",
+		       info->cpus_standby);
+	len += sprintf(page + len, "LPAR CPUs Reserved:   %d\n",
+		       info->cpus_reserved);
+	len += sprintf(page + len, "LPAR CPUs Dedicated:  %d\n",
+		       info->cpus_dedicated);
+	len += sprintf(page + len, "LPAR CPUs Shared:     %d\n",
+		       info->cpus_shared);
+	return len;
 }
 
-static inline int stsi_3_2_2 (struct sysinfo_3_2_2 *info)
+static int stsi_3_2_2(struct sysinfo_3_2_2 *info, char *page, int len)
 {
-	int rc = stsi (info, 3, 2, 2);
-	if (rc != -1)
-	{
-		int i;
-		for (i = 0; i < info->count; i++)
-		{
-			EBCASC (info->vm[i].name, sizeof(info->vm[i].name));
-			EBCASC (info->vm[i].cpi, sizeof(info->vm[i].cpi));
-		}
+	int i;
+
+	if (stsi(info, 3, 2, 2) == -ENOSYS)
+		return len;
+	for (i = 0; i < info->count; i++) {
+		EBCASC (info->vm[i].name, sizeof(info->vm[i].name));
+		EBCASC (info->vm[i].cpi, sizeof(info->vm[i].cpi));
+		len += sprintf(page + len, "\n");
+		len += sprintf(page + len, "VM%02d Name:            %-8.8s\n",
+			       i, info->vm[i].name);
+		len += sprintf(page + len, "VM%02d Control Program: %-16.16s\n",
+			       i, info->vm[i].cpi);
+
+		len += sprintf(page + len, "VM%02d Adjustment:      %d\n",
+			       i, info->vm[i].caf);
+
+		len += sprintf(page + len, "VM%02d CPUs Total:      %d\n",
+			       i, info->vm[i].cpus_total);
+		len += sprintf(page + len, "VM%02d CPUs Configured: %d\n",
+			       i, info->vm[i].cpus_configured);
+		len += sprintf(page + len, "VM%02d CPUs Standby:    %d\n",
+			       i, info->vm[i].cpus_standby);
+		len += sprintf(page + len, "VM%02d CPUs Reserved:   %d\n",
+			       i, info->vm[i].cpus_reserved);
 	}
-	return rc == -1 ? rc : 0;
+	return len;
 }
 
 
@@ -227,118 +318,34 @@ static int proc_read_sysinfo(char *page,
                              off_t off, int count,
                              int *eof, void *data)
 {
-	unsigned long info_page = get_zeroed_page (GFP_KERNEL); 
-	union s390_sysinfo *info = (union s390_sysinfo *) info_page;
-	int len = 0;
-	int level;
-	int i;
+	unsigned long info = get_zeroed_page (GFP_KERNEL);
+	int level, len;
 	
 	if (!info)
 		return 0;
 
-	level = stsi_0 ();
+	len = 0;
+	level = stsi_0();
+	if (level >= 1)
+		len = stsi_1_1_1((struct sysinfo_1_1_1 *) info, page, len);
 
-	if (level >= 1 && stsi_1_1_1 (&info->sysinfo_1_1_1) == 0)
-	{
-		len += sprintf (page+len, "Manufacturer:         %-16.16s\n",
-				info->sysinfo_1_1_1.manufacturer);
-		len += sprintf (page+len, "Type:                 %-4.4s\n",
-				info->sysinfo_1_1_1.type);
-		len += sprintf (page+len, "Model:                %-16.16s\n",
-				info->sysinfo_1_1_1.model);
-		len += sprintf (page+len, "Sequence Code:        %-16.16s\n",
-				info->sysinfo_1_1_1.sequence);
-		len += sprintf (page+len, "Plant:                %-4.4s\n",
-				info->sysinfo_1_1_1.plant);
-	}
+	if (level >= 1)
+		len = stsi_1_2_2((struct sysinfo_1_2_2 *) info, page, len);
 
-	if (level >= 1 && stsi_1_2_2 (&info->sysinfo_1_2_2) == 0)
-	{
-		len += sprintf (page+len, "\n");
-		len += sprintf (page+len, "CPUs Total:           %d\n",
-				info->sysinfo_1_2_2.cpus_total);
-		len += sprintf (page+len, "CPUs Configured:      %d\n",
-				info->sysinfo_1_2_2.cpus_configured);
-		len += sprintf (page+len, "CPUs Standby:         %d\n",
-				info->sysinfo_1_2_2.cpus_standby);
-		len += sprintf (page+len, "CPUs Reserved:        %d\n",
-				info->sysinfo_1_2_2.cpus_reserved);
-	
-		len += sprintf (page+len, "Capability:           %d\n",
-				info->sysinfo_1_2_2.capability);
-
-		for (i = 2; i <= info->sysinfo_1_2_2.cpus_total; i++)
-			len += sprintf (page+len, "Adjustment %02d-way:    %d\n",
-					i, info->sysinfo_1_2_2.adjustment[i-2]);
-	}
+	if (level >= 2)
+		len = stsi_2_2_2((struct sysinfo_2_2_2 *) info, page, len);
 
-	if (level >= 2 && stsi_2_2_2 (&info->sysinfo_2_2_2) == 0)
-	{
-		len += sprintf (page+len, "\n");
-		len += sprintf (page+len, "LPAR Number:          %d\n",
-				info->sysinfo_2_2_2.lpar_number);
-
-		len += sprintf (page+len, "LPAR Characteristics: ");
-		if (info->sysinfo_2_2_2.characteristics & LPAR_CHAR_DEDICATED)
-			len += sprintf (page+len, "Dedicated ");
-		if (info->sysinfo_2_2_2.characteristics & LPAR_CHAR_SHARED)
-			len += sprintf (page+len, "Shared ");
-		if (info->sysinfo_2_2_2.characteristics & LPAR_CHAR_LIMITED)
-			len += sprintf (page+len, "Limited ");
-		len += sprintf (page+len, "\n");
-	
-		len += sprintf (page+len, "LPAR Name:            %-8.8s\n",
-				info->sysinfo_2_2_2.name);
-	
-		len += sprintf (page+len, "LPAR Adjustment:      %d\n",
-				info->sysinfo_2_2_2.caf);
-	
-		len += sprintf (page+len, "LPAR CPUs Total:      %d\n",
-				info->sysinfo_2_2_2.cpus_total);
-		len += sprintf (page+len, "LPAR CPUs Configured: %d\n",
-				info->sysinfo_2_2_2.cpus_configured);
-		len += sprintf (page+len, "LPAR CPUs Standby:    %d\n",
-				info->sysinfo_2_2_2.cpus_standby);
-		len += sprintf (page+len, "LPAR CPUs Reserved:   %d\n",
-				info->sysinfo_2_2_2.cpus_reserved);
-		len += sprintf (page+len, "LPAR CPUs Dedicated:  %d\n",
-				info->sysinfo_2_2_2.cpus_dedicated);
-		len += sprintf (page+len, "LPAR CPUs Shared:     %d\n",
-				info->sysinfo_2_2_2.cpus_shared);
-	}
-
-	if (level >= 3 && stsi_3_2_2 (&info->sysinfo_3_2_2) == 0)
-	{
-		for (i = 0; i < info->sysinfo_3_2_2.count; i++)
-		{
-			len += sprintf (page+len, "\n");
-			len += sprintf (page+len, "VM%02d Name:            %-8.8s\n",
-					i, info->sysinfo_3_2_2.vm[i].name);
-			len += sprintf (page+len, "VM%02d Control Program: %-16.16s\n",
-					i, info->sysinfo_3_2_2.vm[i].cpi);
-	
-			len += sprintf (page+len, "VM%02d Adjustment:      %d\n",
-					i, info->sysinfo_3_2_2.vm[i].caf);
-	
-			len += sprintf (page+len, "VM%02d CPUs Total:      %d\n",
-					i, info->sysinfo_3_2_2.vm[i].cpus_total);
-			len += sprintf (page+len, "VM%02d CPUs Configured: %d\n",
-					i, info->sysinfo_3_2_2.vm[i].cpus_configured);
-			len += sprintf (page+len, "VM%02d CPUs Standby:    %d\n",
-					i, info->sysinfo_3_2_2.vm[i].cpus_standby);
-			len += sprintf (page+len, "VM%02d CPUs Reserved:   %d\n",
-					i, info->sysinfo_3_2_2.vm[i].cpus_reserved);
-		}
-	}
+	if (level >= 3)
+		len = stsi_3_2_2((struct sysinfo_3_2_2 *) info, page, len);
 
-	free_page (info_page);
+	free_page (info);
         return len;
 }
 
 static __init int create_proc_sysinfo(void)
 {
-	create_proc_read_entry ("sysinfo", 0444, NULL, 
-				proc_read_sysinfo, NULL);
+	create_proc_read_entry("sysinfo", 0444, NULL,
+			       proc_read_sysinfo, NULL);
 	return 0;
 }
 
