Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270074AbUJTEKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270074AbUJTEKx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 00:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270193AbUJSXi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:38:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:8330 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270074AbUJSWqc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:32 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <1098225736472@kroah.com>
Date: Tue, 19 Oct 2004 15:42:16 -0700
Message-Id: <1098225736981@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.37, 2004/10/06 13:01:19-07:00, greg@kroah.com

[PATCH] ibmasm: fix __iomem warnings

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/misc/ibmasm/ibmasm.h   |    2 +-
 drivers/misc/ibmasm/ibmasmfs.c |    4 ++--
 drivers/misc/ibmasm/lowlevel.c |    2 +-
 drivers/misc/ibmasm/lowlevel.h |   30 +++++++++++++++---------------
 drivers/misc/ibmasm/uart.c     |    2 +-
 5 files changed, 20 insertions(+), 20 deletions(-)


diff -Nru a/drivers/misc/ibmasm/ibmasm.h b/drivers/misc/ibmasm/ibmasm.h
--- a/drivers/misc/ibmasm/ibmasm.h	2004-10-19 15:24:21 -07:00
+++ b/drivers/misc/ibmasm/ibmasm.h	2004-10-19 15:24:21 -07:00
@@ -158,7 +158,7 @@
 struct service_processor {
 	struct list_head	node;
 	spinlock_t		lock;
-	void 			*base_address;
+	void __iomem		*base_address;
 	unsigned int		irq;
 	struct command		*current_command;
 	struct command		*heartbeat;
diff -Nru a/drivers/misc/ibmasm/ibmasmfs.c b/drivers/misc/ibmasm/ibmasmfs.c
--- a/drivers/misc/ibmasm/ibmasmfs.c	2004-10-19 15:24:21 -07:00
+++ b/drivers/misc/ibmasm/ibmasmfs.c	2004-10-19 15:24:21 -07:00
@@ -520,7 +520,7 @@
 
 static ssize_t remote_settings_file_read(struct file *file, char __user *buf, size_t count, loff_t *offset)
 {
-	unsigned long address = (unsigned long)file->private_data;
+	void __iomem *address = (void __iomem *)file->private_data;
 	unsigned char *page;
 	int retval;
 	int len = 0;
@@ -554,7 +554,7 @@
 
 static ssize_t remote_settings_file_write(struct file *file, const char __user *ubuff, size_t count, loff_t *offset)
 {
-	unsigned long address = (unsigned long)file->private_data;
+	void __iomem *address = (void __iomem *)file->private_data;
 	char *buff;
 	unsigned int value;
 
diff -Nru a/drivers/misc/ibmasm/lowlevel.c b/drivers/misc/ibmasm/lowlevel.c
--- a/drivers/misc/ibmasm/lowlevel.c	2004-10-19 15:24:21 -07:00
+++ b/drivers/misc/ibmasm/lowlevel.c	2004-10-19 15:24:21 -07:00
@@ -58,7 +58,7 @@
 {
 	u32	mfa;
 	struct service_processor *sp = (struct service_processor *)dev_id;
-	void *base_address = sp->base_address;
+	void __iomem *base_address = sp->base_address;
 
 	if (!sp_interrupt_pending(base_address))
 		return IRQ_NONE;
diff -Nru a/drivers/misc/ibmasm/lowlevel.h b/drivers/misc/ibmasm/lowlevel.h
--- a/drivers/misc/ibmasm/lowlevel.h	2004-10-19 15:24:21 -07:00
+++ b/drivers/misc/ibmasm/lowlevel.h	2004-10-19 15:24:21 -07:00
@@ -52,51 +52,51 @@
 #define SCOUT_COM_C_BASE         0x0200   
 #define SCOUT_COM_D_BASE         0x0300   
 
-static inline int sp_interrupt_pending(void *base_address)
+static inline int sp_interrupt_pending(void __iomem *base_address)
 {
 	return SP_INTR_MASK & readl(base_address + INTR_STATUS_REGISTER);
 }
 
-static inline int uart_interrupt_pending(void *base_address)
+static inline int uart_interrupt_pending(void __iomem *base_address)
 {
 	return UART_INTR_MASK & readl(base_address + INTR_STATUS_REGISTER);
 }
 
-static inline void ibmasm_enable_interrupts(void *base_address, int mask)
+static inline void ibmasm_enable_interrupts(void __iomem *base_address, int mask)
 {
-	void *ctrl_reg = base_address + INTR_CONTROL_REGISTER;
+	void __iomem *ctrl_reg = base_address + INTR_CONTROL_REGISTER;
 	writel( readl(ctrl_reg) & ~mask, ctrl_reg);
 }
 
-static inline void ibmasm_disable_interrupts(void *base_address, int mask)
+static inline void ibmasm_disable_interrupts(void __iomem *base_address, int mask)
 {
-	void *ctrl_reg = base_address + INTR_CONTROL_REGISTER;
+	void __iomem *ctrl_reg = base_address + INTR_CONTROL_REGISTER;
 	writel( readl(ctrl_reg) | mask, ctrl_reg);
 }
 
-static inline void enable_sp_interrupts(void *base_address)
+static inline void enable_sp_interrupts(void __iomem *base_address)
 {
 	ibmasm_enable_interrupts(base_address, SP_INTR_MASK);
 }
 
-static inline void disable_sp_interrupts(void *base_address)
+static inline void disable_sp_interrupts(void __iomem *base_address)
 {
 	ibmasm_disable_interrupts(base_address, SP_INTR_MASK);
 }
 
-static inline void enable_uart_interrupts(void *base_address)
+static inline void enable_uart_interrupts(void __iomem *base_address)
 {
 	ibmasm_enable_interrupts(base_address, UART_INTR_MASK); 
 }
 
-static inline void disable_uart_interrupts(void *base_address)
+static inline void disable_uart_interrupts(void __iomem *base_address)
 {
 	ibmasm_disable_interrupts(base_address, UART_INTR_MASK); 
 }
 
 #define valid_mfa(mfa)	( (mfa) != NO_MFAS_AVAILABLE )
 
-static inline u32 get_mfa_outbound(void *base_address)
+static inline u32 get_mfa_outbound(void __iomem *base_address)
 {
 	int retry;
 	u32 mfa;
@@ -109,12 +109,12 @@
 	return mfa;
 }
 
-static inline void set_mfa_outbound(void *base_address, u32 mfa)
+static inline void set_mfa_outbound(void __iomem *base_address, u32 mfa)
 {
    	writel(mfa, base_address + OUTBOUND_QUEUE_PORT);
 }
 
-static inline u32 get_mfa_inbound(void *base_address)
+static inline u32 get_mfa_inbound(void __iomem *base_address)
 {
 	u32 mfa = readl(base_address + INBOUND_QUEUE_PORT);
 
@@ -124,12 +124,12 @@
 	return mfa;
 }
 
-static inline void set_mfa_inbound(void *base_address, u32 mfa)
+static inline void set_mfa_inbound(void __iomem *base_address, u32 mfa)
 {
    	writel(mfa, base_address + INBOUND_QUEUE_PORT);
 }
 
-static inline struct i2o_message *get_i2o_message(void *base_address, u32 mfa)
+static inline struct i2o_message *get_i2o_message(void __iomem *base_address, u32 mfa)
 {
 	return (struct i2o_message *)(GET_MFA_ADDR(mfa) + base_address);
 }
diff -Nru a/drivers/misc/ibmasm/uart.c b/drivers/misc/ibmasm/uart.c
--- a/drivers/misc/ibmasm/uart.c	2004-10-19 15:24:21 -07:00
+++ b/drivers/misc/ibmasm/uart.c	2004-10-19 15:24:21 -07:00
@@ -34,7 +34,7 @@
 void ibmasm_register_uart(struct service_processor *sp)
 {
 	struct serial_struct serial;
-	unsigned char *iomem_base;
+	void __iomem *iomem_base;
 
 	iomem_base = sp->base_address + SCOUT_COM_B_BASE;
 

