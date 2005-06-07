Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbVFGLeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbVFGLeR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 07:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVFGLeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 07:34:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12416 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261841AbVFGLdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 07:33:07 -0400
Date: Tue, 7 Jun 2005 12:32:56 +0100
From: "'Christoph Hellwig'" <hch@infradead.org>
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "'Christoph Hellwig'" <hch@infradead.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
       "Doelfel, Hardy" <hdoelfel@lsil.com>, "Ju, Seokmann" <sju@lsil.com>
Subject: Re: [PATCH scsi-misc 1/2][RESEND] megaraid_sas: LSI Logic MegaRAID SA S RAID Driver
Message-ID: <20050607113256.GA5439@infradead.org>
Mail-Followup-To: 'Christoph Hellwig' <hch@infradead.org>,
	"Bagalkote, Sreenivas" <sreenib@lsil.com>,
	'James Bottomley' <James.Bottomley@SteelEye.com>,
	"'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
	"Doelfel, Hardy" <hdoelfel@lsil.com>, "Ju, Seokmann" <sju@lsil.com>
References: <0E3FA95632D6D047BA649F95DAB60E57060CCEF9@exa-atlanta>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57060CCEF9@exa-atlanta>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The second patch was indeed mangled again.  I spent some time hacking it up so
I could get a patch that applies and compiles.

On Sat, Jun 04, 2005 at 02:11:30AM -0400, Bagalkote, Sreenivas wrote:
> Christoph,
> 
> 1. Most of your comments/feedback are included in this attempt. Please
> review this submission.

besides the issues mentioned next this looks pretty good, except you didn't
really run sparse, did you?  I have attached a patch that fixes up the __iomem
warnings, but there still many warnings left in the managment code left, which
look like direct userspace pointer dereferences.

> 2. Endianness handling: I would like to hold off endianness handling till we
> finish the internal discussion. LSI Logic does not yet support this HW on
> big endian systems (we don't test on those systems). Current megaraid
> drivers also don't have endianness handling for this reason. I want to take
> this up as a possible future update.

We require new pci drivers to work on all architectures, so endianess handling
is required.  If megaraid_mbox slipped though that was an accident.

> 3. Management Interface:
> 	i.  I think you misunderstood the presence of SMP and STP in the driver.
> 	This is _NOT_ a SAS HBA driver. This is a RAID driver on SAS controller.

Actually it's a SAS HBA driver too, for the physical devices you expose aswell.
While we're at it please remove the inquiry sniffing in megasas_complete_cmd.
Doing anything magic with luns must happen in ->slave_configure, and in this
case you should not hide the physical disk devices from the midlayer but rather
set the BLIST_NO_ULD_ATTACH in slave_configure so managment applications can
still issue scsi commands via the sg driver while the disk driver doésn't attach
to it.  That way you can issue SG_IO requests on all logical and physical devices
and avoid the SCSI-level passthrough ioctls.

> 	Driver is not doing anything that belongs in transport layer. Management
> 	applications issue SMP/STP commands embedded in message frames to the
> 	physical drives. You will see that all I am doing is handle the SG lists
> 	appropriately.

SMP/STP-passthrough is job of the SAS transport class that's been in
discussion/development and not the low-level driver.

> 	ii. As far as I know, a full-fledged complex management application has
> 	no alternative to ioctls to interface with driver. I am not sure how
> 	sysfs can satisfy anything but most trivial of these tasks. There is a
> 	large amount of binary data exchanged between application and the driver.

In the FC transport class we have avoided ioctls completely so far.  There might
be issues we will need ioctls for, but they should stay outside the actual
low-level drivers.

Except for these issues the driver looks pretty nice now, thanks.

And here's the iomem sparse fixes:


--- megaraid/megaraid_sas.c	2005-06-07 12:41:10.000000000 +0200
+++ megaraid-hch/megaraid_sas.c	2005-06-07 13:12:32.000000000 +0200
@@ -117,7 +117,7 @@ megasas_return_cmd(struct megasas_instan
  * @regs:			MFI register set
  */
 static inline void
-megasas_enable_intr(struct megasas_register_set *regs)
+megasas_enable_intr(struct megasas_register_set __iomem *regs)
 {
 	writel(1, &(regs)->outbound_intr_mask);
 
@@ -130,7 +130,7 @@ megasas_enable_intr(struct megasas_regis
  * @regs:			MFI register set
  */
 static inline void
-megasas_disable_intr(struct megasas_register_set *regs)
+megasas_disable_intr(struct megasas_register_set __iomem *regs)
 {
 	u32 mask = readl(&regs->outbound_intr_mask) & (~0x00000001);
 	writel(mask, &regs->outbound_intr_mask);
@@ -1271,7 +1199,7 @@ megasas_isr(int irq, void *devp, struct 
  * has to wait for the ready state.
  */
 static int
-megasas_transition_to_ready(struct megasas_register_set *reg_set)
+megasas_transition_to_ready(struct megasas_register_set __iomem *reg_set)
 {
 	int	i;
 	u8	max_wait;
@@ -1695,7 +1623,7 @@ megasas_init_mfi(struct megasas_instance
 	u32				reply_q_sz;
 	u32				max_sectors_1;
 	u32				max_sectors_2;
-	struct megasas_register_set	*reg_set;
+	struct megasas_register_set __iomem *reg_set;
 
 	struct megasas_cmd		*cmd;
 	struct megasas_ctrl_info	*ctrl_info;
@@ -1715,8 +1643,7 @@ megasas_init_mfi(struct megasas_instance
 		return -EBUSY;
 	}
 
-	instance->reg_set = (struct megasas_register_set*) ioremap_nocache(
-						instance->base_addr, 8192);
+	instance->reg_set = ioremap_nocache(instance->base_addr, 8192);
 
 	if (!instance->reg_set) {
 		printk( KERN_DEBUG "megasas: Failed to map IO mem\n" );
--- megaraid/megaraid_sas.h	2005-06-07 12:41:26.000000000 +0200
+++ megaraid-hch/megaraid_sas.h	2005-06-07 12:47:41.000000000 +0200
@@ -543,30 +543,29 @@ struct megasas_ctrl_info {
 
 struct megasas_register_set {
 
-	u32 __iomem	reserved_0[4];			/*0000h*/
+	u32 	reserved_0[4];			/*0000h*/
 
-	u32 __iomem	inbound_msg_0;			/*0010h*/
-	u32 __iomem	inbound_msg_1;			/*0014h*/
-	u32 __iomem	outbound_msg_0;			/*0018h*/
-	u32 __iomem	outbound_msg_1;			/*001Ch*/
+	u32 	inbound_msg_0;			/*0010h*/
+	u32 	inbound_msg_1;			/*0014h*/
+	u32 	outbound_msg_0;			/*0018h*/
+	u32 	outbound_msg_1;			/*001Ch*/
 
-	u32 __iomem	inbound_doorbell;		/*0020h*/
-	u32 __iomem	inbound_intr_status;		/*0024h*/
-	u32 __iomem	inbound_intr_mask;		/*0028h*/
+	u32 	inbound_doorbell;		/*0020h*/
+	u32 	inbound_intr_status;		/*0024h*/
+	u32 	inbound_intr_mask;		/*0028h*/
 
-	u32 __iomem	outbound_doorbell;		/*002Ch*/
-	u32 __iomem	outbound_intr_status;		/*0030h*/
-	u32 __iomem	outbound_intr_mask;		/*0034h*/
+	u32 	outbound_doorbell;		/*002Ch*/
+	u32 	outbound_intr_status;		/*0030h*/
+	u32 	outbound_intr_mask;		/*0034h*/
 
-	u32 __iomem	reserved_1[2];			/*0038h*/
+	u32 	reserved_1[2];			/*0038h*/
 
-	u32 __iomem	inbound_queue_port;		/*0040h*/
-	u32 __iomem	outbound_queue_port;		/*0044h*/
+	u32 	inbound_queue_port;		/*0040h*/
+	u32 	outbound_queue_port;		/*0044h*/
 
-	u32 __iomem	reserved_2;			/*004Ch*/
-
-	u32 __iomem	index_registers[1004];		/*0050h*/
+	u32 	reserved_2;			/*004Ch*/
 
+	u32 	index_registers[1004];		/*0050h*/
 } __attribute__ ((packed));
 
 struct megasas_sge32 {
@@ -998,9 +997,9 @@ struct megasas_evt_detail {
 
 struct megasas_instance {
 
-	u32 __iomem				*producer;
+	u32 					*producer;
 	dma_addr_t				producer_h;
-	u32 __iomem				*consumer;
+	u32 					*consumer;
 	dma_addr_t				consumer_h;
 
 	u32					*reply_queue;
