Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965062AbVLVFBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965062AbVLVFBv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 00:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbVLVEtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:49:36 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:21712 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965048AbVLVEtZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:49:25 -0500
To: linux-m68k@vger.kernel.org
Subject: [PATCH 04/36] m68k: switch mac/misc.c to direct use of appropriate cuda/pmu/maciisi requests
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EpIOK-0004q9-FT@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 22 Dec 2005 04:49:24 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1134918770 -0500

kill ADBREQ_RAW use, replace adb_read_time(), etc. with per-type variants,
eliminated remapping from pmu ones, fix the ifdefs (PMU->PMU68K)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/m68k/mac/misc.c            |  323 ++++++++++++++++++++++++++-------------
 drivers/macintosh/via-maciisi.c |   18 ++
 2 files changed, 236 insertions(+), 105 deletions(-)

0b0fd1e11202d6f7db8785ea49bfd9f886555b80
diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index 5b80d7c..99dd2c1 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -39,72 +39,163 @@
 extern struct mac_booter_data mac_bi_data;
 static void (*rom_reset)(void);
 
-#ifdef CONFIG_ADB
-/*
- * Return the current time as the number of seconds since January 1, 1904.
- */
-
-static long adb_read_time(void)
+#ifdef CONFIG_ADB_CUDA
+static long cuda_read_time(void)
 {
-	volatile struct adb_request req;
+	struct adb_request req;
 	long time;
 
-	adb_request((struct adb_request *) &req, NULL,
-			ADBREQ_RAW|ADBREQ_SYNC,
-			2, CUDA_PACKET, CUDA_GET_TIME);
+	if (cuda_request(&req, NULL, 2, CUDA_PACKET, CUDA_GET_TIME) < 0)
+		return 0;
+	while (!req.complete)
+		cuda_poll();
 
 	time = (req.reply[3] << 24) | (req.reply[4] << 16)
 		| (req.reply[5] << 8) | req.reply[6];
 	return time - RTC_OFFSET;
 }
 
-/*
- * Set the current system time
- */
+static void cuda_write_time(long data)
+{
+	struct adb_request req;
+	data += RTC_OFFSET;
+	if (cuda_request(&req, NULL, 6, CUDA_PACKET, CUDA_SET_TIME,
+			(data >> 24) & 0xFF, (data >> 16) & 0xFF,
+			(data >> 8) & 0xFF, data & 0xFF) < 0)
+		return;
+	while (!req.complete)
+		cuda_poll();
+}
 
-static void adb_write_time(long data)
+static __u8 cuda_read_pram(int offset)
 {
-	volatile struct adb_request req;
+	struct adb_request req;
+	if (cuda_request(&req, NULL, 4, CUDA_PACKET, CUDA_GET_PRAM,
+			(offset >> 8) & 0xFF, offset & 0xFF) < 0)
+		return 0;
+	while (!req.complete)
+		cuda_poll();
+	return req.reply[3];
+}
 
-	data += RTC_OFFSET;
+static void cuda_write_pram(int offset, __u8 data)
+{
+	struct adb_request req;
+	if (cuda_request(&req, NULL, 5, CUDA_PACKET, CUDA_SET_PRAM,
+			(offset >> 8) & 0xFF, offset & 0xFF, data) < 0)
+		return;
+	while (!req.complete)
+		cuda_poll();
+}
+#else
+#define cuda_read_time() 0
+#define cuda_write_time(n)
+#define cuda_read_pram NULL
+#define cuda_write_pram NULL
+#endif
+
+#ifdef CONFIG_ADB_PMU68K
+static long pmu_read_time(void)
+{
+	struct adb_request req;
+	long time;
+
+	if (pmu_request(&req, NULL, 1, PMU_READ_RTC) < 0)
+		return 0;
+	while (!req.complete)
+		pmu_poll();
 
-	adb_request((struct adb_request *) &req, NULL,
-			ADBREQ_RAW|ADBREQ_SYNC,
-			6, CUDA_PACKET, CUDA_SET_TIME,
+	time = (req.reply[0] << 24) | (req.reply[1] << 16)
+		| (req.reply[2] << 8) | req.reply[3];
+	return time - RTC_OFFSET;
+}
+
+static void pmu_write_time(long data)
+{
+	struct adb_request req;
+	data += RTC_OFFSET;
+	if (pmu_request(&req, NULL, 5, PMU_SET_RTC,
 			(data >> 24) & 0xFF, (data >> 16) & 0xFF,
-			(data >> 8) & 0xFF, data & 0xFF);
+			(data >> 8) & 0xFF, data & 0xFF) < 0)
+		return;
+	while (!req.complete)
+		pmu_poll();
 }
 
-/*
- * Get a byte from the NVRAM
- */
+static __u8 pmu_read_pram(int offset)
+{
+	struct adb_request req;
+	if (pmu_request(&req, NULL, 3, PMU_READ_NVRAM,
+			(offset >> 8) & 0xFF, offset & 0xFF) < 0)
+		return 0;
+	while (!req.complete)
+		pmu_poll();
+	return req.reply[3];
+}
 
-static __u8 adb_read_pram(int offset)
+static void pmu_write_pram(int offset, __u8 data)
 {
-	volatile struct adb_request req;
+	struct adb_request req;
+	if (pmu_request(&req, NULL, 4, PMU_WRITE_NVRAM,
+			(offset >> 8) & 0xFF, offset & 0xFF, data) < 0)
+		return;
+	while (!req.complete)
+		pmu_poll();
+}
+#else
+#define pmu_read_time() 0
+#define pmu_write_time(n)
+#define pmu_read_pram NULL
+#define pmu_write_pram NULL
+#endif
 
-	adb_request((struct adb_request *) &req, NULL,
-			ADBREQ_RAW|ADBREQ_SYNC,
-			4, CUDA_PACKET, CUDA_GET_PRAM,
-			(offset >> 8) & 0xFF, offset & 0xFF);
-	return req.reply[3];
+#ifdef CONFIG_ADB_MACIISI
+extern int maciisi_request(struct adb_request *req,
+			void (*done)(struct adb_request *), int nbytes, ...);
+
+static long maciisi_read_time(void)
+{
+	struct adb_request req;
+	long time;
+
+	if (maciisi_request(&req, NULL, 2, CUDA_PACKET, CUDA_GET_TIME))
+		return 0;
+
+	time = (req.reply[3] << 24) | (req.reply[4] << 16)
+		| (req.reply[5] << 8) | req.reply[6];
+	return time - RTC_OFFSET;
 }
 
-/*
- * Write a byte to the NVRAM
- */
+static void maciisi_write_time(long data)
+{
+	struct adb_request req;
+	data += RTC_OFFSET;
+	maciisi_request(&req, NULL, 6, CUDA_PACKET, CUDA_SET_TIME,
+			(data >> 24) & 0xFF, (data >> 16) & 0xFF,
+			(data >> 8) & 0xFF, data & 0xFF);
+}
 
-static void adb_write_pram(int offset, __u8 data)
+static __u8 maciisi_read_pram(int offset)
 {
-	volatile struct adb_request req;
+	struct adb_request req;
+	if (maciisi_request(&req, NULL, 4, CUDA_PACKET, CUDA_GET_PRAM,
+			(offset >> 8) & 0xFF, offset & 0xFF))
+		return 0;
+	return req.reply[3];
+}
 
-	adb_request((struct adb_request *) &req, NULL,
-			ADBREQ_RAW|ADBREQ_SYNC,
-			5, CUDA_PACKET, CUDA_SET_PRAM,
-			(offset >> 8) & 0xFF, offset & 0xFF,
-			data);
+static void maciisi_write_pram(int offset, __u8 data)
+{
+	struct adb_request req;
+	maciisi_request(&req, NULL, 5, CUDA_PACKET, CUDA_SET_PRAM,
+			(offset >> 8) & 0xFF, offset & 0xFF, data);
 }
-#endif /* CONFIG_ADB */
+#else
+#define maciisi_read_time() 0
+#define maciisi_write_time(n)
+#define maciisi_read_pram NULL
+#define maciisi_write_pram NULL
+#endif
 
 /*
  * VIA PRAM/RTC access routines
@@ -305,42 +396,55 @@ static void oss_shutdown(void)
 
 static void cuda_restart(void)
 {
-	adb_request(NULL, NULL, ADBREQ_RAW|ADBREQ_SYNC,
-			2, CUDA_PACKET, CUDA_RESET_SYSTEM);
+	struct adb_request req;
+	if (cuda_request(&req, NULL, 2, CUDA_PACKET, CUDA_RESET_SYSTEM) < 0)
+		return;
+	while (!req.complete)
+		cuda_poll();
 }
 
 static void cuda_shutdown(void)
 {
-	adb_request(NULL, NULL, ADBREQ_RAW|ADBREQ_SYNC,
-			2, CUDA_PACKET, CUDA_POWERDOWN);
+	struct adb_request req;
+	if (cuda_request(&req, NULL, 2, CUDA_PACKET, CUDA_POWERDOWN) < 0)
+		return;
+	while (!req.complete)
+		cuda_poll();
 }
 
 #endif /* CONFIG_ADB_CUDA */
 
-#ifdef CONFIG_ADB_PMU
+#ifdef CONFIG_ADB_PMU68K
 
 void pmu_restart(void)
 {
-	adb_request(NULL, NULL, ADBREQ_RAW|ADBREQ_SYNC,
-			3, PMU_PACKET, PMU_SET_INTR_MASK,
-			PMU_INT_ADB|PMU_INT_TICK);
-
-	adb_request(NULL, NULL, ADBREQ_RAW|ADBREQ_SYNC,
-			2, PMU_PACKET, PMU_RESET);
+	struct adb_request req;
+	if (pmu_request(&req, NULL,
+			2, PMU_SET_INTR_MASK, PMU_INT_ADB|PMU_INT_TICK) < 0)
+		return;
+	while (!req.complete)
+		pmu_poll();
+	if (pmu_request(&req, NULL, 1, PMU_RESET) < 0)
+		return;
+	while (!req.complete)
+		pmu_poll();
 }
 
 void pmu_shutdown(void)
 {
-	adb_request(NULL, NULL, ADBREQ_RAW|ADBREQ_SYNC,
-			3, PMU_PACKET, PMU_SET_INTR_MASK,
-			PMU_INT_ADB|PMU_INT_TICK);
-
-	adb_request(NULL, NULL, ADBREQ_RAW|ADBREQ_SYNC,
-			6, PMU_PACKET, PMU_SHUTDOWN,
-			'M', 'A', 'T', 'T');
+	struct adb_request req;
+	if (pmu_request(&req, NULL,
+			2, PMU_SET_INTR_MASK, PMU_INT_ADB|PMU_INT_TICK) < 0)
+		return;
+	while (!req.complete)
+		pmu_poll();
+	if (pmu_request(&req, NULL, 5, PMU_SHUTDOWN, 'M', 'A', 'T', 'T') < 0)
+		return;
+	while (!req.complete)
+		pmu_poll();
 }
 
-#endif /* CONFIG_ADB_PMU */
+#endif
 
 /*
  *-------------------------------------------------------------------
@@ -351,21 +455,22 @@ void pmu_shutdown(void)
 
 void mac_pram_read(int offset, __u8 *buffer, int len)
 {
-	__u8 (*func)(int) = NULL;
+	__u8 (*func)(int);
 	int i;
 
-	if (macintosh_config->adb_type == MAC_ADB_IISI ||
-	    macintosh_config->adb_type == MAC_ADB_PB1 ||
-	    macintosh_config->adb_type == MAC_ADB_PB2 ||
-	    macintosh_config->adb_type == MAC_ADB_CUDA) {
-#ifdef CONFIG_ADB
-		func = adb_read_pram;
-#else
-		return;
-#endif
-	} else {
+	switch(macintosh_config->adb_type) {
+	case MAC_ADB_IISI:
+		func = maciisi_read_pram; break;
+	case MAC_ADB_PB1:
+	case MAC_ADB_PB2:
+		func = pmu_read_pram; break;
+	case MAC_ADB_CUDA:
+		func = cuda_read_pram; break;
+	default:
 		func = via_read_pram;
 	}
+	if (!func)
+		return;
 	for (i = 0 ; i < len ; i++) {
 		buffer[i] = (*func)(offset++);
 	}
@@ -373,21 +478,22 @@ void mac_pram_read(int offset, __u8 *buf
 
 void mac_pram_write(int offset, __u8 *buffer, int len)
 {
-	void (*func)(int, __u8) = NULL;
+	void (*func)(int, __u8);
 	int i;
 
-	if (macintosh_config->adb_type == MAC_ADB_IISI ||
-	    macintosh_config->adb_type == MAC_ADB_PB1 ||
-	    macintosh_config->adb_type == MAC_ADB_PB2 ||
-	    macintosh_config->adb_type == MAC_ADB_CUDA) {
-#ifdef CONFIG_ADB
-		func = adb_write_pram;
-#else
-		return;
-#endif
-	} else {
+	switch(macintosh_config->adb_type) {
+	case MAC_ADB_IISI:
+		func = maciisi_write_pram; break;
+	case MAC_ADB_PB1:
+	case MAC_ADB_PB2:
+		func = pmu_write_pram; break;
+	case MAC_ADB_CUDA:
+		func = cuda_write_pram; break;
+	default:
 		func = via_write_pram;
 	}
+	if (!func)
+		return;
 	for (i = 0 ; i < len ; i++) {
 		(*func)(offset++, buffer[i]);
 	}
@@ -408,7 +514,7 @@ void mac_poweroff(void)
 	} else if (macintosh_config->adb_type == MAC_ADB_CUDA) {
 		cuda_shutdown();
 #endif
-#ifdef CONFIG_ADB_PMU
+#ifdef CONFIG_ADB_PMU68K
 	} else if (macintosh_config->adb_type == MAC_ADB_PB1
 		|| macintosh_config->adb_type == MAC_ADB_PB2) {
 		pmu_shutdown();
@@ -448,7 +554,7 @@ void mac_reset(void)
 	} else if (macintosh_config->adb_type == MAC_ADB_CUDA) {
 		cuda_restart();
 #endif
-#ifdef CONFIG_ADB_PMU
+#ifdef CONFIG_ADB_PMU68K
 	} else if (macintosh_config->adb_type == MAC_ADB_PB1
 		|| macintosh_config->adb_type == MAC_ADB_PB2) {
 		pmu_restart();
@@ -588,20 +694,22 @@ int mac_hwclk(int op, struct rtc_time *t
 	unsigned long now;
 
 	if (!op) { /* read */
-		if (macintosh_config->adb_type == MAC_ADB_II) {
+		switch (macintosh_config->adb_type) {
+		case MAC_ADB_II:
+		case MAC_ADB_IOP:
 			now = via_read_time();
-		} else
-#ifdef CONFIG_ADB
-		if ((macintosh_config->adb_type == MAC_ADB_IISI) ||
-			   (macintosh_config->adb_type == MAC_ADB_PB1) ||
-			   (macintosh_config->adb_type == MAC_ADB_PB2) ||
-			   (macintosh_config->adb_type == MAC_ADB_CUDA)) {
-			now = adb_read_time();
-		} else
-#endif
-		if (macintosh_config->adb_type == MAC_ADB_IOP) {
-			now = via_read_time();
-		} else {
+			break;
+		case MAC_ADB_IISI:
+			now = maciisi_read_time();
+			break;
+		case MAC_ADB_PB1:
+		case MAC_ADB_PB2:
+			now = pmu_read_time();
+			break;
+		case MAC_ADB_CUDA:
+			now = cuda_read_time();
+			break;
+		default:
 			now = 0;
 		}
 
@@ -619,15 +727,20 @@ int mac_hwclk(int op, struct rtc_time *t
 		now = mktime(t->tm_year + 1900, t->tm_mon + 1, t->tm_mday,
 			     t->tm_hour, t->tm_min, t->tm_sec);
 
-		if (macintosh_config->adb_type == MAC_ADB_II) {
-			via_write_time(now);
-		} else if ((macintosh_config->adb_type == MAC_ADB_IISI) ||
-			   (macintosh_config->adb_type == MAC_ADB_PB1) ||
-			   (macintosh_config->adb_type == MAC_ADB_PB2) ||
-			   (macintosh_config->adb_type == MAC_ADB_CUDA)) {
-			adb_write_time(now);
-		} else if (macintosh_config->adb_type == MAC_ADB_IOP) {
+		switch (macintosh_config->adb_type) {
+		case MAC_ADB_II:
+		case MAC_ADB_IOP:
 			via_write_time(now);
+			break;
+		case MAC_ADB_CUDA:
+			cuda_write_time(now);
+			break;
+		case MAC_ADB_PB1:
+		case MAC_ADB_PB2:
+			pmu_write_time(now);
+			break;
+		case MAC_ADB_IISI:
+			maciisi_write_time(now);
 		}
 #endif
 	}
diff --git a/drivers/macintosh/via-maciisi.c b/drivers/macintosh/via-maciisi.c
index a196697..ad271e7 100644
--- a/drivers/macintosh/via-maciisi.c
+++ b/drivers/macintosh/via-maciisi.c
@@ -294,6 +294,24 @@ static void maciisi_sync(struct adb_requ
 		printk(KERN_ERR "maciisi_send_request: poll timed out!\n");
 }
 
+int
+maciisi_request(struct adb_request *req, void (*done)(struct adb_request *),
+	    int nbytes, ...)
+{
+	va_list list;
+	int i;
+
+	req->nbytes = nbytes;
+	req->done = done;
+	req->reply_expected = 0;
+	va_start(list, nbytes);
+	for (i = 0; i < nbytes; i++)
+		req->data[i++] = va_arg(list, int);
+	va_end(list);
+
+	return maciisi_send_request(req, 1);
+}
+
 /* Enqueue a request, and run the queue if possible */
 static int
 maciisi_write(struct adb_request* req)
-- 
0.99.9.GIT

