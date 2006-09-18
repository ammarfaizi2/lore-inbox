Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965380AbWIREn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965380AbWIREn4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 00:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965383AbWIREnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 00:43:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:36884 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965378AbWIREnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 00:43:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=GwaFr1bNtAgagIzVwogKtwFnkapMr3PX866Oth/buwygmMtdvUfpaEetDD3byWMtOI3e5RBG2OgGUGG2OH5LEG9U2UKxXQalcmdM/d1u22pJESlM1incaRydML6cu4e8Adk0TVDOSuW9C7Uciyr6jXRNt7I48Xacfj/Zjlll/YA=
Date: Mon, 18 Sep 2006 08:43:48 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH] proper flags type of spin_lock_irqsave()
Message-ID: <20060918044348.GA5364@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 So far results of incomplete spin_lock_irqsave audit, and there is also
 local_irq_save()... I'll eventually add

	typedef unsigned long __bitwise__ lock_flags_t;

 so sparse could find future offenders. name OK?

 arch/ia64/kernel/mca.c             |    2 +-
 arch/ia64/sn/pci/pcibr/pcibr_ate.c |    2 +-
 arch/ia64/sn/pci/pcibr/pcibr_dma.c |    2 +-
 arch/parisc/kernel/firmware.c      |    7 ++++---
 arch/v850/kernel/memcons.c         |    2 +-
 arch/v850/kernel/rte_cb_leds.c     |    2 +-
 arch/v850/kernel/rte_mb_a_pci.c    |   12 ++++++------
 drivers/char/ds1286.c              |   15 ++++++++-------
 drivers/i2c/busses/i2c-ite.c       |    2 +-
 sound/oss/swarm_cs4297a.c          |    2 +-
 10 files changed, 25 insertions(+), 23 deletions(-)

--- a/arch/ia64/kernel/mca.c
+++ b/arch/ia64/kernel/mca.c
@@ -221,7 +221,7 @@ ia64_log_get(int sal_info_type, u8 **buf
 {
 	sal_log_record_header_t     *log_buffer;
 	u64                         total_len = 0;
-	int                         s;
+	unsigned long               s;
 
 	IA64_LOG_LOCK(sal_info_type);
 
--- a/arch/ia64/sn/pci/pcibr/pcibr_ate.c
+++ b/arch/ia64/sn/pci/pcibr/pcibr_ate.c
@@ -160,7 +160,7 @@ void pcibr_ate_free(struct pcibus_info *
 
 	volatile u64 ate;
 	int count;
-	u64 flags;
+	unsigned long flags;
 
 	if (pcibr_invalidate_ate) {
 		/* For debugging purposes, clear the valid bit in the ATE */
--- a/arch/ia64/sn/pci/pcibr/pcibr_dma.c
+++ b/arch/ia64/sn/pci/pcibr/pcibr_dma.c
@@ -237,7 +237,7 @@ void sn_dma_flush(u64 addr)
 	int is_tio;
 	int wid_num;
 	int i, j;
-	u64 flags;
+	unsigned long flags;
 	u64 itte;
 	struct hubdev_info *hubinfo;
 	struct sn_flush_device_kernel *p;
--- a/arch/parisc/kernel/firmware.c
+++ b/arch/parisc/kernel/firmware.c
@@ -1049,7 +1049,7 @@ void pdc_iodc_putc(unsigned char c)
         static int __attribute__((aligned(8)))   iodc_retbuf[32];
         static char __attribute__((aligned(64))) iodc_dbuf[4096];
         unsigned int n;
-	unsigned int flags;
+	unsigned long flags;
 
         switch (c) {
         case '\n':
@@ -1088,7 +1088,8 @@ void pdc_iodc_putc(unsigned char c)
  */
 void pdc_iodc_outc(unsigned char c)
 {
-	unsigned int n, flags;
+	unsigned int n;
+	unsigned long flags;
 
 	/* fill buffer with one caracter and print it */
         static int __attribute__((aligned(8)))   iodc_retbuf[32];
@@ -1113,7 +1114,7 @@ void pdc_iodc_outc(unsigned char c)
  */
 int pdc_iodc_getc(void)
 {
-	unsigned int flags;
+	unsigned long flags;
         static int __attribute__((aligned(8)))   iodc_retbuf[32];
         static char __attribute__((aligned(64))) iodc_dbuf[4096];
 	int ch;
--- a/arch/v850/kernel/memcons.c
+++ b/arch/v850/kernel/memcons.c
@@ -30,7 +30,7 @@ static DEFINE_SPINLOCK(memcons_lock);
 
 static size_t write (const char *buf, size_t len)
 {
-	int flags;
+	unsigned long flags;
 	char *point;
 
 	spin_lock_irqsave (memcons_lock, flags);
--- a/arch/v850/kernel/rte_cb_leds.c
+++ b/arch/v850/kernel/rte_cb_leds.c
@@ -42,7 +42,7 @@ do {									\
 			len = LED_NUM_DIGITS - pos;			\
 									\
 		if (len > 0) {						\
-			int _flags;					\
+			unsigned long _flags;				\
 			const char *_end = buf + len;			\
 			img_decl = &leds_image[pos];			\
 									\
--- a/arch/v850/kernel/rte_mb_a_pci.c
+++ b/arch/v850/kernel/rte_mb_a_pci.c
@@ -365,7 +365,7 @@ static DEFINE_SPINLOCK(mb_sram_lock);
 static void *alloc_mb_sram (size_t size)
 {
 	struct mb_sram_free_area *prev, *fa;
-	int flags;
+	unsigned long flags;
 	void *mem = 0;
 
 	spin_lock_irqsave (mb_sram_lock, flags);
@@ -406,7 +406,7 @@ static void *alloc_mb_sram (size_t size)
 static void free_mb_sram (void *mem, size_t size)
 {
 	struct mb_sram_free_area *prev, *fa, *new_fa;
-	int flags;
+	unsigned long flags;
 	void *end = mem + size;
 
 	spin_lock_irqsave (mb_sram_lock, flags);
@@ -517,7 +517,7 @@ static DEFINE_SPINLOCK(dma_mappings_lock
 
 static struct dma_mapping *new_dma_mapping (size_t size)
 {
-	int flags;
+	unsigned long flags;
 	struct dma_mapping *mapping;
 	void *mb_sram_block = alloc_mb_sram (size);
 
@@ -575,7 +575,7 @@ static struct dma_mapping *new_dma_mappi
 
 static struct dma_mapping *find_dma_mapping (void *mb_sram_addr)
 {
-	int flags;
+	unsigned long flags;
 	struct dma_mapping *mapping;
 
 	spin_lock_irqsave (dma_mappings_lock, flags);
@@ -592,7 +592,7 @@ static struct dma_mapping *find_dma_mapp
 
 static struct dma_mapping *deactivate_dma_mapping (void *mb_sram_addr)
 {
-	int flags;
+	unsigned long flags;
 	struct dma_mapping *mapping, *prev;
 
 	spin_lock_irqsave (dma_mappings_lock, flags);
@@ -622,7 +622,7 @@ static struct dma_mapping *deactivate_dm
 static inline void
 free_dma_mapping (struct dma_mapping *mapping)
 {
-	int flags;
+	unsigned long flags;
 
 	free_mb_sram (mapping->mb_sram_addr, mapping->size);
 
--- a/drivers/char/ds1286.c
+++ b/drivers/char/ds1286.c
@@ -104,7 +104,7 @@ static int ds1286_ioctl(struct inode *in
 	switch (cmd) {
 	case RTC_AIE_OFF:	/* Mask alarm int. enab. bit	*/
 	{
-		unsigned int flags;
+		unsigned long flags;
 		unsigned char val;
 
 		if (!capable(CAP_SYS_TIME))
@@ -120,7 +120,7 @@ static int ds1286_ioctl(struct inode *in
 	}
 	case RTC_AIE_ON:	/* Allow alarm interrupts.	*/
 	{
-		unsigned int flags;
+		unsigned long flags;
 		unsigned char val;
 
 		if (!capable(CAP_SYS_TIME))
@@ -136,7 +136,7 @@ static int ds1286_ioctl(struct inode *in
 	}
 	case RTC_WIE_OFF:	/* Mask watchdog int. enab. bit	*/
 	{
-		unsigned int flags;
+		unsigned long flags;
 		unsigned char val;
 
 		if (!capable(CAP_SYS_TIME))
@@ -152,7 +152,7 @@ static int ds1286_ioctl(struct inode *in
 	}
 	case RTC_WIE_ON:	/* Allow watchdog interrupts.	*/
 	{
-		unsigned int flags;
+		unsigned long flags;
 		unsigned char val;
 
 		if (!capable(CAP_SYS_TIME))
@@ -434,7 +434,7 @@ static inline unsigned char ds1286_is_up
 static void ds1286_get_time(struct rtc_time *rtc_tm)
 {
 	unsigned char save_control;
-	unsigned int flags;
+	unsigned long flags;
 	unsigned long uip_watchdog = jiffies;
 
 	/*
@@ -494,7 +494,8 @@ static int ds1286_set_time(struct rtc_ti
 {
 	unsigned char mon, day, hrs, min, sec, leap_yr;
 	unsigned char save_control;
-	unsigned int yrs, flags;
+	unsigned int yrs;
+	unsigned long flags;
 
 
 	yrs = rtc_tm->tm_year + 1900;
@@ -552,7 +553,7 @@ static int ds1286_set_time(struct rtc_ti
 static void ds1286_get_alm_time(struct rtc_time *alm_tm)
 {
 	unsigned char cmd;
-	unsigned int flags;
+	unsigned long flags;
 
 	/*
 	 * Only the values that we read from the RTC are set. That
--- a/drivers/i2c/busses/i2c-ite.c
+++ b/drivers/i2c/busses/i2c-ite.c
@@ -109,7 +109,7 @@ static int iic_ite_getclock(void *data)
 static void iic_ite_waitforpin(void) {
    DEFINE_WAIT(wait);
    int timeout = 2;
-   long flags;
+   unsigned long flags;
 
    /* If interrupts are enabled (which they are), then put the process to
     * sleep.  This process will be awakened by two events -- either the
--- a/sound/oss/swarm_cs4297a.c
+++ b/sound/oss/swarm_cs4297a.c
@@ -725,7 +725,7 @@ static int serdma_reg_access(struct cs42
         serdma_t *d = &s->dma_dac;
         u64 *data_p;
         unsigned swptr;
-        int flags;
+        unsigned long flags;
         serdma_descr_t *descr;
 
         if (s->reg_request) {

