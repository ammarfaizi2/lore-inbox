Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262901AbVCQAsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbVCQAsq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 19:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262892AbVCQAsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 19:48:45 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:13512 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262908AbVCQAcb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 19:32:31 -0500
Date: Wed, 16 Mar 2005 18:32:24 -0600 (CST)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@jo.austin.ibm.com
To: Jeff Garzik <jgarzik@pobox.com>
cc: Greg K-H <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add TPM hardware enablement driver
In-Reply-To: <422FC42B.7@pobox.com>
Message-ID: <Pine.LNX.4.61.0503161811020.5212@jo.austin.ibm.com>
References: <1110415321526@kroah.com> <422FC42B.7@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch at the bottom addresses a number of the concerns raised in this 
email along with a couple of other comments which this generated regarding 
not needing __force and the need for a MAINTAINERS entry.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>

On Wed, 9 Mar 2005, Jeff Garzik wrote:

> Greg KH wrote:
<snip>
> > +#define	TPM_MINOR			224	/* officially assigned
> > */
> > +
> > +#define	TPM_BUFSIZE			2048
> > +
> > +/* PCI configuration addresses */
> > +#define	PCI_GEN_PMCON_1			0xA0
> > +#define	PCI_GEN1_DEC			0xE4
> > +#define	PCI_LPC_EN			0xE6
> > +#define	PCI_GEN2_DEC			0xEC
> 
> enums preferred to #defines, as these provide more type information, and are
> more visible in a debugger.

fixed

> > +static LIST_HEAD(tpm_chip_list);
> > +static spinlock_t driver_lock = SPIN_LOCK_UNLOCKED;
> > +static int dev_mask[32];
> 
> don't use '32', create a constant and use that constant instead.
fixed

> > +		tpm_write_index(0x0D, 0x55);	/* unlock 4F */
> > +		tpm_write_index(0x0A, 0x00);	/* int disable */
> > +		tpm_write_index(0x08, base);	/* base addr lo */
> > +		tpm_write_index(0x09, (base & 0xFF00) >> 8);	/* base addr
> > hi */
> > +		tpm_write_index(0x0D, 0xAA);	/* lock 4F */
> 
> please define symbol names for the TPM registers

fixed 


> > +	down(&chip->timer_manipulation_mutex);
> > +	chip->time_expired = 0;
> > +	init_timer(&chip->device_timer);
> > +	chip->device_timer.function = tpm_time_expired;
> > +	chip->device_timer.expires = jiffies + 2 * 60 * HZ;
> > +	chip->device_timer.data = (unsigned long) &chip->time_expired;
> > +	add_timer(&chip->device_timer);
> 
> very wrong.  you init_timer() when you initialize 'chip'... once.  then during
> the device lifetime you add/mod/del the timer.
> 
> calling init_timer() could lead to corruption of state.

fixed

> > +static u8 cap_pcr[] = {
> > +	0, 193,			/* TPM_TAG_RQU_COMMAND */
> > +	0, 0, 0, 22,		/* length */
> > +	0, 0, 0, 101,		/* TPM_ORD_GetCapability */
> > +	0, 0, 0, 5,
> > +	0, 0, 0, 4,
> > +	0, 0, 1, 1
> > +};
> 
> const

fixed


> > +static u8 pcrread[] = {
> > +	0, 193,			/* TPM_TAG_RQU_COMMAND */
> > +	0, 0, 0, 14,		/* length */
> > +	0, 0, 0, 21,		/* TPM_ORD_PcrRead */
> > +	0, 0, 0, 0		/* PCR index */
> > +};
> 
> const

fixed

> > +
> > +	struct tpm_chp *chip =
> > +	    pci_get_drvdata(container_of(dev, struct pci_dev, dev));
> 
> use to_pci_dev()

fixed

> > +#define  READ_PUBEK_RESULT_SIZE 314
> > +static u8 readpubek[] = {
> > +	0, 193,			/* TPM_TAG_RQU_COMMAND */
> > +	0, 0, 0, 30,		/* length */
> > +	0, 0, 0, 124,		/* TPM_ORD_ReadPubek */
> > +};
> > +
> > +static ssize_t show_pubek(struct device *dev, char *buf)
> > +{
> > +	u8 data[READ_PUBEK_RESULT_SIZE];
> 
> massive obj on stack

fixed

> > +	struct tpm_chip *chip =
> > +	    pci_get_drvdata(container_of(dev, struct pci_dev, dev));
> 
> to_pci_dev()

fixed

> > +static u8 cap_version[] = {
> > +	0, 193,			/* TPM_TAG_RQU_COMMAND */
> > +	0, 0, 0, 18,		/* length */
> > +	0, 0, 0, 101,		/* TPM_ORD_GetCapability */
> > +	0, 0, 0, 6,
> > +	0, 0, 0, 0
> > +};
> 
> const

fixed

> > +static u8 cap_manufacturer[] = {
> > +	0, 193,			/* TPM_TAG_RQU_COMMAND */
> > +	0, 0, 0, 22,		/* length */
> > +	0, 0, 0, 101,		/* TPM_ORD_GetCapability */
> > +	0, 0, 0, 5,
> > +	0, 0, 0, 4,
> > +	0, 0, 1, 3
> > +};
> 
> const

fixed

> 
> > +static ssize_t show_caps(struct device *dev, char *buf)
> > +{
> > +	u8 data[READ_PUBEK_RESULT_SIZE];
> 
> massive obj on stack

fixed

> > +	struct tpm_chip *chip =
> > +	    pci_get_drvdata(container_of(dev, struct pci_dev, dev));
> 
> to_pci_dev()

fixed

> > +	chip->data_buffer = kmalloc(TPM_BUFSIZE * sizeof(u8), GFP_KERNEL);
> > +	if (chip->data_buffer == NULL) {
> > +		chip->num_opens--;
> > +		pci_dev_put(chip->pci_dev);
> > +		return -ENOMEM;
> > +	}
> 
> what is the purpose of this pci_dev_get/put?  attempting to prevent hotplug or
> something?

Seems that since there is a refernce to the device in the chip structure 
and I am making the file private data pointer point to that chip structure 
this is another reference that must be accounted for. If you remove it 
with it open and attempt read or write bad things will happen.  This isn't 
really hotpluggable either as the TPM is on the motherboard.

> > +
> > +	/* cannot perform a write until the read has cleared
> > +	   either via tpm_read or a user_read_timer timeout */
> > +	while (atomic_read(&chip->data_pending) != 0) {
> > +		set_current_state(TASK_UNINTERRUPTIBLE);
> > +		schedule_timeout(TPM_TIMEOUT);
> 

> use msleep()

addressed in another patch by Nish

> > +	/* atomic tpm command send and result receive */
> > +	out_size = tpm_transmit(chip, chip->data_buffer, TPM_BUFSIZE);
> 
> major bug?  in_size may be smaller than TPM_BUFSIZE

chip->data_buffer is allocated in open and is always this size.  The 
operation needs to be atomic so the big buffer is to cover the size of a 
potentially larger result.  Only reading in_size from the user with 
copy_from_user

> > +	down(&chip->timer_manipulation_mutex);
> > +	init_timer(&chip->user_read_timer);
> > +	chip->user_read_timer.function = user_reader_timeout;
> > +	chip->user_read_timer.data = (unsigned long) chip;
> > +	chip->user_read_timer.expires = jiffies + (60 * HZ);
> > +	add_timer(&chip->user_read_timer);
> 
> again, don't repeatedly init_timer()
> 
fixed

> > +ssize_t tpm_read(struct file * file, char __user * buf,
> > +		 size_t size, loff_t * off)
> > +{
> > +	struct tpm_chip *chip = file->private_data;
> > +	int ret_size = -ENODATA;
> > +
> > +	if (atomic_read(&chip->data_pending) != 0) {	/* Result available */
> > +		down(&chip->timer_manipulation_mutex);
> > +		del_singleshot_timer_sync(&chip->user_read_timer);
> > +		up(&chip->timer_manipulation_mutex);
> > +
> > +		down(&chip->buffer_mutex);
> > +
> > +		ret_size = atomic_read(&chip->data_pending);
> > +		atomic_set(&chip->data_pending, 0);
> > +
> > +		if (ret_size == 0)	/* timeout just occurred */
> > +			ret_size = -ETIME;
> > +		else if (ret_size > 0) {	/* relay data */
> > +			if (size < ret_size)
> > +				ret_size = size;
> > +
> > +			if (copy_to_user((void __user *) buf,
> > +					 chip->data_buffer, ret_size)) {
> > +				ret_size = -EFAULT;
> > +			}
> > +		}
> > +		up(&chip->buffer_mutex);
> > +	}
> > +
> > +	return ret_size;
> 
> POSIX violation -- when there is no data available, returning a non-standard
> error is silly
> 
fixed

> > +
> > +	pci_dev_put(pci_dev);
> > +}
> 
> similar comment as before...  I don't see the need for pci_dev_put?

See justification above.

> > +static u8 savestate[] = {
> > +	0, 193,			/* TPM_TAG_RQU_COMMAND */
> > +	0, 0, 0, 10,		/* blob length (in bytes) */
> > +	0, 0, 0, 152		/* TPM_ORD_SaveState */
> > +};
> 
> const

fixed

> > +
> > +	init_MUTEX(&chip->buffer_mutex);
> > +	init_MUTEX(&chip->tpm_mutex);
> > +	init_MUTEX(&chip->timer_manipulation_mutex);
> > +	INIT_LIST_HEAD(&chip->list);
> 
> timer init should be here

fixed

> > +
> > +static int __init init_tpm(void)
> > +{
> > +	return 0;
> > +}
> > +
> > +static void __exit cleanup_tpm(void)
> > +{
> > +
> > +}
> > +
> > +module_init(init_tpm);
> > +module_exit(cleanup_tpm);
> 
> why?  just delete these, I would say.

fixed

> > +
> > +/* TPM addresses */
> > +#define	TPM_ADDR			0x4E
> > +#define	TPM_DATA			0x4F
> 
> enum preferred to #define

fixed

> > +/* Atmel definitions */
> > +#define	TPM_ATML_BASE			0x400
> > +
> > +/* write status bits */
> > +#define	ATML_STATUS_ABORT		0x01
> > +#define	ATML_STATUS_LASTBYTE		0x04
> > +
> > +/* read status bits */
> > +#define	ATML_STATUS_BUSY		0x01
> > +#define	ATML_STATUS_DATA_AVAIL		0x02
> > +#define	ATML_STATUS_REWRITE		0x04
> 
> enum preferred

fixed

> > +	if (count < size) {
> > +		dev_err(&chip->pci_dev->dev,
> > +			"Recv size(%d) less than available space\n", size);
> > +		for (; i < size; i++) {	/* clear the waiting data anyway */
> > +			status = inb(chip->vendor->base + 1);
> > +			if ((status & ATML_STATUS_DATA_AVAIL) == 0) {
> > +				dev_err(&chip->pci_dev->dev,
> > +					"error reading data\n");
> > +				return -EIO;
> > +			}
> > +		}
> > +		return -EIO;
> > +	}
> 
> are you REALLY sure you want to eat data?

if the buffer isn't big enough the driver is broken so I don't see this as 
a problem.  See the comment abover where tpm_tranmit is called.  That is 
how you get into this code.

> > +/* National definitions */
> > +#define	TPM_NSC_BASE			0x360
> > +#define	TPM_NSC_IRQ			0x07
> > +
> > +#define	NSC_LDN_INDEX			0x07
> > +#define	NSC_SID_INDEX			0x20
> > +#define	NSC_LDC_INDEX			0x30
> > +#define	NSC_DIO_INDEX			0x60
> > +#define	NSC_CIO_INDEX			0x62
> > +#define	NSC_IRQ_INDEX			0x70
> > +#define	NSC_ITS_INDEX			0x71
> > +
> > +#define	NSC_STATUS			0x01
> > +#define	NSC_COMMAND			0x01
> > +#define	NSC_DATA			0x00
> > +
> > +/* status bits */
> > +#define	NSC_STATUS_OBF			0x01	/* output buffer full
> > */
> > +#define	NSC_STATUS_IBF			0x02	/* input buffer full
> > */
> > +#define	NSC_STATUS_F0			0x04	/* F0 */
> > +#define	NSC_STATUS_A2			0x08	/* A2 */
> > +#define	NSC_STATUS_RDY			0x10	/* ready to receive
> > command */
> > +#define	NSC_STATUS_IBR			0x20	/* ready to receive
> > data */
> > +
> > +/* command bits */
> > +#define	NSC_COMMAND_NORMAL		0x01	/* normal mode */
> > +#define	NSC_COMMAND_EOC			0x03
> > +#define	NSC_COMMAND_CANCEL		0x22
> 
> enum

fixed

> > +		schedule_timeout(TPM_TIMEOUT);
> 
> use msleep()

fixed

> > +		}
> > +	}
> > +	while (!expired);
> 
> infinite loop:  expired never cleared
> 

fixed in another patch

> > +		set_current_state(TASK_UNINTERRUPTIBLE);
> > +		schedule_timeout(TPM_TIMEOUT);
> 
> msleep()

fixed in another patch


> > +	}
> > +	while (!expired);
> 
> another infinite loop?

fixed in another patch


New patch:


diff -uprN linux-2.6.11.3-orig/drivers/char/tpm/tpm_atmel.c linux-2.6.11.3/drivers/char/tpm/tpm_atmel.c
--- linux-2.6.11.3-orig/drivers/char/tpm/tpm_atmel.c	2005-03-16 19:31:32.000000000 -0600
+++ linux-2.6.11.3/drivers/char/tpm/tpm_atmel.c	2005-03-16 19:31:32.000000000 -0600
@@ -22,17 +22,21 @@
 #include "tpm.h"
 
 /* Atmel definitions */
-#define        TPM_ATML_BASE                   0x400
+enum {
+	TPM_ATML_BASE = 0x400
+};
 
 /* write status bits */
-#define        ATML_STATUS_ABORT               0x01
-#define        ATML_STATUS_LASTBYTE            0x04
-
+enum {
+	ATML_STATUS_ABORT = 0x01,
+	ATML_STATUS_LASTBYTE = 0x04
+};
 /* read status bits */
-#define        ATML_STATUS_BUSY                0x01
-#define        ATML_STATUS_DATA_AVAIL          0x02
-#define        ATML_STATUS_REWRITE             0x04
-
+enum {
+	ATML_STATUS_BUSY = 0x01,
+	ATML_STATUS_DATA_AVAIL = 0x02,
+	ATML_STATUS_REWRITE = 0x04
+};
 
 static int tpm_atml_recv(struct tpm_chip *chip, u8 * buf, size_t count)
 {
diff -uprN linux-2.6.11.3-orig/drivers/char/tpm/tpm.c linux-2.6.11.3/drivers/char/tpm/tpm.c
--- linux-2.6.11.3-orig/drivers/char/tpm/tpm.c	2005-03-16 19:31:32.000000000 -0600
+++ linux-2.6.11.3/drivers/char/tpm/tpm.c	2005-03-16 19:31:32.000000000 -0600
@@ -28,19 +28,34 @@
 #include <linux/spinlock.h>
 #include "tpm.h"
 
-#define        TPM_MINOR                       224	/* officially assigned */
-
-#define        TPM_BUFSIZE                     2048
+enum {
+	TPM_MINOR = 224,	/* officially assigned */
+	TPM_BUFSIZE = 2048,
+	TPM_NUM_DEVICES = 256,
+	TPM_NUM_MASK_ENTRIES = TPM_NUM_DEVICES / (8 * sizeof(int))
+};
 
 /* PCI configuration addresses */
-#define        PCI_GEN_PMCON_1                 0xA0
-#define        PCI_GEN1_DEC                    0xE4
-#define        PCI_LPC_EN                      0xE6
-#define        PCI_GEN2_DEC                    0xEC
+enum {
+	PCI_GEN_PMCON_1 = 0xA0,
+	PCI_GEN1_DEC = 0xE4,
+	PCI_LPC_EN = 0xE6,
+	PCI_GEN2_DEC = 0xEC
+};
+
+enum {
+	TPM_LOCK_REG = 0x0D,
+	TPM_INTERUPT_REG = 0x0A,
+	TPM_BASE_ADDR_LO = 0x08,
+	TPM_BASE_ADDR_HI = 0x09,
+	TPM_UNLOCK_VALUE = 0x55,
+	TPM_LOCK_VALUE = 0xAA,
+	TPM_DISABLE_INTERUPT_VALUE = 0x00
+};
 
 static LIST_HEAD(tpm_chip_list);
 static spinlock_t driver_lock = SPIN_LOCK_UNLOCKED;
-static int dev_mask[32];
+static int dev_mask[TPM_NUM_MASK_ENTRIES];
 
 static void user_reader_timeout(unsigned long ptr)
 {
@@ -102,11 +117,11 @@ int tpm_lpc_bus_init(struct pci_dev *pci
 			pci_write_config_dword(pci_dev, PCI_GEN_PMCON_1,
 					       tmp);
 		}
-		tpm_write_index(0x0D, 0x55);	/* unlock 4F */
-		tpm_write_index(0x0A, 0x00);	/* int disable */
-		tpm_write_index(0x08, base);	/* base addr lo */
-		tpm_write_index(0x09, (base & 0xFF00) >> 8);	/* base addr hi */
-		tpm_write_index(0x0D, 0xAA);	/* lock 4F */
+		tpm_write_index(TPM_LOCK_REG, TPM_UNLOCK_VALUE);	/* unlock 4F */
+		tpm_write_index(TPM_INTERUPT_REG, TPM_DISABLE_INTERUPT_VALUE);	/* int disable */
+		tpm_write_index(TPM_BASE_ADDR_LO, base);	/* base addr lo */
+		tpm_write_index(TPM_BASE_ADDR_HI, (base & 0xFF00) >> 8);	/* base addr hi */
+		tpm_write_index(TPM_LOCK_REG, TPM_LOCK_VALUE);	/* lock 4F */
 		break;
 	case PCI_VENDOR_ID_AMD:
 		/* nothing yet */
@@ -121,16 +136,14 @@ EXPORT_SYMBOL_GPL(tpm_lpc_bus_init);
 /*
  * Internal kernel interface to transmit TPM commands
  */
-static ssize_t tpm_transmit(struct tpm_chip *chip, const char *buf,
-			    size_t bufsiz)
+static ssize_t
+tpm_transmit(struct tpm_chip *chip, const char *buf, size_t bufsiz)
 {
 	ssize_t len;
 	u32 count;
-	__be32 *native_size;
 	unsigned long stop;
 
-	native_size = (__force __be32 *) (buf + 2);
-	count = be32_to_cpu(*native_size);
+	count = be32_to_cpu(*((__be32 *) (buf + 2)));
 
 	if (count == 0)
 		return -ENODATA;
@@ -157,7 +170,8 @@ static ssize_t tpm_transmit(struct tpm_c
 		}
 		msleep(TPM_TIMEOUT);	/* CHECK */
 		rmb();
-	} while (time_before(jiffies, stop));
+	}
+	while (time_before(jiffies, stop));
 
 
 	chip->vendor->cancel(chip);
@@ -176,7 +190,7 @@ static ssize_t tpm_transmit(struct tpm_c
 
 #define TPM_DIGEST_SIZE 20
 #define CAP_PCR_RESULT_SIZE 18
-static u8 cap_pcr[] = {
+static const u8 cap_pcr[] = {
 	0, 193,			/* TPM_TAG_RQU_COMMAND */
 	0, 0, 0, 22,		/* length */
 	0, 0, 0, 101,		/* TPM_ORD_GetCapability */
@@ -186,7 +200,7 @@ static u8 cap_pcr[] = {
 };
 
 #define READ_PCR_RESULT_SIZE 30
-static u8 pcrread[] = {
+static const u8 pcrread[] = {
 	0, 193,			/* TPM_TAG_RQU_COMMAND */
 	0, 0, 0, 14,		/* length */
 	0, 0, 0, 21,		/* TPM_ORD_PcrRead */
@@ -197,20 +211,20 @@ static ssize_t show_pcrs(struct device *
 {
 	u8 data[READ_PCR_RESULT_SIZE];
 	ssize_t len;
-	int i, j, index, num_pcrs;
+	int i, j, num_pcrs;
+	__be32 index;
 	char *str = buf;
 
-	struct tpm_chip *chip =
-	    pci_get_drvdata(container_of(dev, struct pci_dev, dev));
+	struct tpm_chip *chip = pci_get_drvdata(to_pci_dev(dev));
 	if (chip == NULL)
 		return -ENODEV;
 
 	memcpy(data, cap_pcr, sizeof(cap_pcr));
-	if ((len = tpm_transmit(chip, data, sizeof(data)))
-	    < CAP_PCR_RESULT_SIZE)
+	if ((len =
+	     tpm_transmit(chip, data, sizeof(data))) < CAP_PCR_RESULT_SIZE)
 		return len;
 
-	num_pcrs = be32_to_cpu(*((__force __be32 *) (data + 14)));
+	num_pcrs = be32_to_cpu(*((__be32 *) (data + 14)));
 
 	for (i = 0; i < num_pcrs; i++) {
 		memcpy(data, pcrread, sizeof(pcrread));
@@ -230,7 +244,7 @@ static ssize_t show_pcrs(struct device *
 static DEVICE_ATTR(pcrs, S_IRUGO, show_pcrs, NULL);
 
 #define  READ_PUBEK_RESULT_SIZE 314
-static u8 readpubek[] = {
+static const u8 readpubek[] = {
 	0, 193,			/* TPM_TAG_RQU_COMMAND */
 	0, 0, 0, 30,		/* length */
 	0, 0, 0, 124,		/* TPM_ORD_ReadPubek */
@@ -238,23 +252,27 @@ static u8 readpubek[] = {
 
 static ssize_t show_pubek(struct device *dev, char *buf)
 {
-	u8 data[READ_PUBEK_RESULT_SIZE];
+	u8 *data;
 	ssize_t len;
-	__be32 *native_val;
-	int i;
+	int i, rc;
 	char *str = buf;
 
-	struct tpm_chip *chip =
-	    pci_get_drvdata(container_of(dev, struct pci_dev, dev));
+	struct tpm_chip *chip = pci_get_drvdata(to_pci_dev(dev));
 	if (chip == NULL)
 		return -ENODEV;
 
+	data = kmalloc(READ_PUBEK_RESULT_SIZE, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
 	memcpy(data, readpubek, sizeof(readpubek));
 	memset(data + sizeof(readpubek), 0, 20);	/* zero nonce */
 
 	if ((len = tpm_transmit(chip, data, sizeof(data))) <
-	    READ_PUBEK_RESULT_SIZE)
-		return len;
+	    READ_PUBEK_RESULT_SIZE) {
+		rc = len;
+		goto out;
+	}
 
 	/* 
 	   ignore header 10 bytes
@@ -267,8 +285,6 @@ static ssize_t show_pubek(struct device 
 	   ignore checksum 20 bytes
 	 */
 
-	native_val = (__force __be32 *) (data + 34);
-
 	str +=
 	    sprintf(str,
 		    "Algorithm: %02X %02X %02X %02X\nEncscheme: %02X %02X\n"
@@ -279,21 +295,23 @@ static ssize_t show_pubek(struct device 
 		    data[15], data[16], data[17], data[22], data[23],
 		    data[24], data[25], data[26], data[27], data[28],
 		    data[29], data[30], data[31], data[32], data[33],
-		    be32_to_cpu(*native_val)
-	    );
+		    be32_to_cpu(*((__be32 *) (data + 32))));
 
 	for (i = 0; i < 256; i++) {
 		str += sprintf(str, "%02X ", data[i + 39]);
 		if ((i + 1) % 16 == 0)
 			str += sprintf(str, "\n");
 	}
-	return str - buf;
+	rc = str - buf;
+      out:
+	kfree(data);
+	return rc;
 }
 
 static DEVICE_ATTR(pubek, S_IRUGO, show_pubek, NULL);
 
 #define CAP_VER_RESULT_SIZE 18
-static u8 cap_version[] = {
+static const u8 cap_version[] = {
 	0, 193,			/* TPM_TAG_RQU_COMMAND */
 	0, 0, 0, 18,		/* length */
 	0, 0, 0, 101,		/* TPM_ORD_GetCapability */
@@ -302,7 +320,7 @@ static u8 cap_version[] = {
 };
 
 #define CAP_MANUFACTURER_RESULT_SIZE 18
-static u8 cap_manufacturer[] = {
+static const u8 cap_manufacturer[] = {
 	0, 193,			/* TPM_TAG_RQU_COMMAND */
 	0, 0, 0, 22,		/* length */
 	0, 0, 0, 101,		/* TPM_ORD_GetCapability */
@@ -313,12 +331,12 @@ static u8 cap_manufacturer[] = {
 
 static ssize_t show_caps(struct device *dev, char *buf)
 {
-	u8 data[READ_PUBEK_RESULT_SIZE];
+	u8 data[(CAP_VER_RESULT_SIZE > CAP_MANUFACTURER_RESULT_SIZE) ?
+		CAP_VER_RESULT_SIZE : CAP_MANUFACTURER_RESULT_SIZE];
 	ssize_t len;
 	char *str = buf;
 
-	struct tpm_chip *chip =
-	    pci_get_drvdata(container_of(dev, struct pci_dev, dev));
+	struct tpm_chip *chip = pci_get_drvdata(to_pci_dev(dev));
 	if (chip == NULL)
 		return -ENODEV;
 
@@ -329,12 +347,12 @@ static ssize_t show_caps(struct device *
 		return len;
 
 	str += sprintf(str, "Manufacturer: 0x%x\n",
-		       be32_to_cpu(*(data + 14)));
+		       be32_to_cpu(*((__be32 *) (data + 14))));
 
 	memcpy(data, cap_version, sizeof(cap_version));
 
-	if ((len = tpm_transmit(chip, data, sizeof(data))) <
-	    CAP_VER_RESULT_SIZE)
+	if ((len =
+	     tpm_transmit(chip, data, sizeof(data))) < CAP_VER_RESULT_SIZE)
 		return len;
 
 	str +=
@@ -404,30 +422,22 @@ int tpm_release(struct inode *inode, str
 {
 	struct tpm_chip *chip = file->private_data;
 
-	file->private_data = NULL;
-
 	spin_lock(&driver_lock);
+	file->private_data = NULL;
 	chip->num_opens--;
-	spin_unlock(&driver_lock);
-
-	down(&chip->timer_manipulation_mutex);
-	if (timer_pending(&chip->user_read_timer))
-		del_singleshot_timer_sync(&chip->user_read_timer);
-	else if (timer_pending(&chip->device_timer))
-		del_singleshot_timer_sync(&chip->device_timer);
-	up(&chip->timer_manipulation_mutex);
-
-	kfree(chip->data_buffer);
+	del_singleshot_timer_sync(&chip->user_read_timer);
 	atomic_set(&chip->data_pending, 0);
-
 	pci_dev_put(chip->pci_dev);
+	kfree(chip->data_buffer);
+	spin_unlock(&driver_lock);
 	return 0;
 }
 
 EXPORT_SYMBOL_GPL(tpm_release);
 
-ssize_t tpm_write(struct file * file, const char __user * buf,
-		  size_t size, loff_t * off)
+ssize_t
+tpm_write(struct file * file, const char __user * buf,
+	  size_t size, loff_t * off)
 {
 	struct tpm_chip *chip = file->private_data;
 	int in_size = size, out_size;
@@ -449,52 +459,38 @@ ssize_t tpm_write(struct file * file, co
 	}
 
 	/* atomic tpm command send and result receive */
+	dev_info(&chip->pci_dev->dev, "data_buffer size: %d\n",
+		 sizeof(*chip->data_buffer));
 	out_size = tpm_transmit(chip, chip->data_buffer, TPM_BUFSIZE);
 
 	atomic_set(&chip->data_pending, out_size);
 	up(&chip->buffer_mutex);
 
 	/* Set a timeout by which the reader must come claim the result */
-	down(&chip->timer_manipulation_mutex);
-	init_timer(&chip->user_read_timer);
-	chip->user_read_timer.function = user_reader_timeout;
-	chip->user_read_timer.data = (unsigned long) chip;
-	chip->user_read_timer.expires = jiffies + (60 * HZ);
-	add_timer(&chip->user_read_timer);
-	up(&chip->timer_manipulation_mutex);
+	mod_timer(&chip->user_read_timer, jiffies + (60 * HZ));
 
 	return in_size;
 }
 
 EXPORT_SYMBOL_GPL(tpm_write);
 
-ssize_t tpm_read(struct file * file, char __user * buf,
-		 size_t size, loff_t * off)
+ssize_t
+tpm_read(struct file * file, char __user * buf, size_t size, loff_t * off)
 {
 	struct tpm_chip *chip = file->private_data;
-	int ret_size = -ENODATA;
+	int ret_size;
 
-	if (atomic_read(&chip->data_pending) != 0) {	/* Result available */
-		down(&chip->timer_manipulation_mutex);
-		del_singleshot_timer_sync(&chip->user_read_timer);
-		up(&chip->timer_manipulation_mutex);
+	del_singleshot_timer_sync(&chip->user_read_timer);
+	ret_size = atomic_read(&chip->data_pending);
+	atomic_set(&chip->data_pending, 0);
+	if (ret_size > 0) {	/* relay data */
+		if (size < ret_size)
+			ret_size = size;
 
 		down(&chip->buffer_mutex);
-
-		ret_size = atomic_read(&chip->data_pending);
-		atomic_set(&chip->data_pending, 0);
-
-		if (ret_size == 0)	/* timeout just occurred */
-			ret_size = -ETIME;
-		else if (ret_size > 0) {	/* relay data */
-			if (size < ret_size)
-				ret_size = size;
-
-			if (copy_to_user((void __user *) buf,
-					 chip->data_buffer, ret_size)) {
-				ret_size = -EFAULT;
-			}
-		}
+		if (copy_to_user
+		    ((void __user *) buf, chip->data_buffer, ret_size))
+			ret_size = -EFAULT;
 		up(&chip->buffer_mutex);
 	}
 
@@ -516,8 +512,6 @@ void __devexit tpm_remove(struct pci_dev
 
 	list_del(&chip->list);
 
-	spin_unlock(&driver_lock);
-
 	pci_set_drvdata(pci_dev, NULL);
 	misc_deregister(&chip->vendor->miscdev);
 
@@ -525,9 +519,12 @@ void __devexit tpm_remove(struct pci_dev
 	device_remove_file(&pci_dev->dev, &dev_attr_pcrs);
 	device_remove_file(&pci_dev->dev, &dev_attr_caps);
 
+	spin_unlock(&driver_lock);
+
 	pci_disable_device(pci_dev);
 
-	dev_mask[chip->dev_num / 32] &= !(1 << (chip->dev_num % 32));
+	dev_mask[chip->dev_num / TPM_NUM_MASK_ENTRIES] &=
+	    !(1 << (chip->dev_num % TPM_NUM_MASK_ENTRIES));
 
 	kfree(chip);
 
@@ -565,7 +562,6 @@ EXPORT_SYMBOL_GPL(tpm_pm_suspend);
 int tpm_pm_resume(struct pci_dev *pci_dev)
 {
 	struct tpm_chip *chip = pci_get_drvdata(pci_dev);
-
 	if (chip == NULL)
 		return -ENODEV;
 
@@ -585,8 +581,9 @@ EXPORT_SYMBOL_GPL(tpm_pm_resume);
  * upon errant exit from this function specific probe function should call
  * pci_disable_device
  */
-int tpm_register_hardware(struct pci_dev *pci_dev,
-			  struct tpm_vendor_specific *entry)
+int
+tpm_register_hardware(struct pci_dev *pci_dev,
+		      struct tpm_vendor_specific *entry)
 {
 	char devname[7];
 	struct tpm_chip *chip;
@@ -601,17 +598,21 @@ int tpm_register_hardware(struct pci_dev
 
 	init_MUTEX(&chip->buffer_mutex);
 	init_MUTEX(&chip->tpm_mutex);
-	init_MUTEX(&chip->timer_manipulation_mutex);
 	INIT_LIST_HEAD(&chip->list);
 
+	init_timer(&chip->user_read_timer);
+	chip->user_read_timer.function = user_reader_timeout;
+	chip->user_read_timer.data = (unsigned long) chip;
+
 	chip->vendor = entry;
 
 	chip->dev_num = -1;
 
-	for (i = 0; i < 32; i++)
-		for (j = 0; j < 8; j++)
+	for (i = 0; i < TPM_NUM_MASK_ENTRIES; i++)
+		for (j = 0; j < 8 * sizeof(int); j++)
 			if ((dev_mask[i] & (1 << j)) == 0) {
-				chip->dev_num = i * 32 + j;
+				chip->dev_num =
+				    i * TPM_NUM_MASK_ENTRIES + j;
 				dev_mask[i] |= 1 << j;
 				goto dev_num_search_complete;
 			}
@@ -633,12 +634,15 @@ int tpm_register_hardware(struct pci_dev
 	chip->vendor->miscdev.dev = &(pci_dev->dev);
 	chip->pci_dev = pci_dev_get(pci_dev);
 
+	spin_lock(&driver_lock);
+
 	if (misc_register(&chip->vendor->miscdev)) {
 		dev_err(&chip->pci_dev->dev,
 			"unable to misc_register %s, minor %d\n",
 			chip->vendor->miscdev.name,
 			chip->vendor->miscdev.minor);
 		pci_dev_put(pci_dev);
+		spin_unlock(&driver_lock);
 		kfree(chip);
 		dev_mask[i] &= !(1 << j);
 		return -ENODEV;
@@ -652,24 +656,12 @@ int tpm_register_hardware(struct pci_dev
 	device_create_file(&pci_dev->dev, &dev_attr_pcrs);
 	device_create_file(&pci_dev->dev, &dev_attr_caps);
 
+	spin_unlock(&driver_lock);
 	return 0;
 }
 
 EXPORT_SYMBOL_GPL(tpm_register_hardware);
 
-static int __init init_tpm(void)
-{
-	return 0;
-}
-
-static void __exit cleanup_tpm(void)
-{
-
-}
-
-module_init(init_tpm);
-module_exit(cleanup_tpm);
-
 MODULE_AUTHOR("Leendert van Doorn (leendert@watson.ibm.com)");
 MODULE_DESCRIPTION("TPM Driver");
 MODULE_VERSION("2.0");
diff -uprN linux-2.6.11.3-orig/drivers/char/tpm/tpm.h linux-2.6.11.3/drivers/char/tpm/tpm.h
--- linux-2.6.11.3-orig/drivers/char/tpm/tpm.h	2005-03-16 19:31:32.000000000 -0600
+++ linux-2.6.11.3/drivers/char/tpm/tpm.h	2005-03-16 19:31:32.000000000 -0600
@@ -24,11 +24,15 @@
 #include <linux/delay.h>
 #include <linux/miscdevice.h>
 
-#define TPM_TIMEOUT    5	/* msecs */
+enum {
+	TPM_TIMEOUT = 5		/* msecs */
+};
 
 /* TPM addresses */
-#define        TPM_ADDR                        0x4E
-#define        TPM_DATA                        0x4F
+enum {
+	TPM_ADDR = 0x4E,
+	TPM_DATA = 0x4F
+};
 
 struct tpm_chip;
 
@@ -57,8 +61,6 @@ struct tpm_chip {
 
 	struct timer_list user_read_timer;	/* user needs to claim result */
 	struct semaphore tpm_mutex;	/* tpm is processing */
-	struct timer_list device_timer;	/* tpm is processing */
-	struct semaphore timer_manipulation_mutex;
 
 	struct tpm_vendor_specific *vendor;
 
diff -uprN linux-2.6.11.3-orig/drivers/char/tpm/tpm_nsc.c linux-2.6.11.3/drivers/char/tpm/tpm_nsc.c
--- linux-2.6.11.3-orig/drivers/char/tpm/tpm_nsc.c	2005-03-16 19:31:32.000000000 -0600
+++ linux-2.6.11.3/drivers/char/tpm/tpm_nsc.c	2005-03-16 19:31:32.000000000 -0600
@@ -22,34 +22,42 @@
 #include "tpm.h"
 
 /* National definitions */
-#define        TPM_NSC_BASE                    0x360
-#define        TPM_NSC_IRQ                     0x07
+enum {
+	TPM_NSC_BASE = 0x360,
+	TPM_NSC_IRQ = 0x07
+};
 
-#define        NSC_LDN_INDEX                   0x07
-#define        NSC_SID_INDEX                   0x20
-#define        NSC_LDC_INDEX                   0x30
-#define        NSC_DIO_INDEX                   0x60
-#define        NSC_CIO_INDEX                   0x62
-#define        NSC_IRQ_INDEX                   0x70
-#define        NSC_ITS_INDEX                   0x71
-
-#define        NSC_STATUS                      0x01
-#define        NSC_COMMAND                     0x01
-#define        NSC_DATA                        0x00
+enum {
+	NSC_LDN_INDEX = 0x07,
+	NSC_SID_INDEX = 0x20,
+	NSC_LDC_INDEX = 0x30,
+	NSC_DIO_INDEX = 0x60,
+	NSC_CIO_INDEX = 0x62,
+	NSC_IRQ_INDEX = 0x70,
+	NSC_ITS_INDEX = 0x71
+};
 
-/* status bits */
-#define        NSC_STATUS_OBF                  0x01	/* output buffer full */
-#define        NSC_STATUS_IBF                  0x02	/* input buffer full */
-#define        NSC_STATUS_F0                   0x04	/* F0 */
-#define        NSC_STATUS_A2                   0x08	/* A2 */
-#define        NSC_STATUS_RDY                  0x10	/* ready to receive command */
-#define        NSC_STATUS_IBR                  0x20	/* ready to receive data */
+enum {
+	NSC_STATUS = 0x01,
+	NSC_COMMAND = 0x01,
+	NSC_DATA = 0x00
+};
 
+/* status bits */
+enum {
+	NSC_STATUS_OBF = 0x01,	/* output buffer full */
+	NSC_STATUS_IBF = 0x02,	/* input buffer full */
+	NSC_STATUS_F0 = 0x04,	/* F0 */
+	NSC_STATUS_A2 = 0x08,	/* A2 */
+	NSC_STATUS_RDY = 0x10,	/* ready to receive command */
+	NSC_STATUS_IBR = 0x20	/* ready to receive data */
+};
 /* command bits */
-#define        NSC_COMMAND_NORMAL              0x01	/* normal mode */
-#define        NSC_COMMAND_EOC                 0x03
-#define        NSC_COMMAND_CANCEL              0x22
-
+enum {
+	NSC_COMMAND_NORMAL = 0x01,	/* normal mode */
+	NSC_COMMAND_EOC = 0x03,
+	NSC_COMMAND_CANCEL = 0x22
+};
 /*
  * Wait for a certain status to appear
  */
diff -uprN linux-2.6.11.3-orig/MAINTAINERS linux-2.6.11.3/MAINTAINERS
--- linux-2.6.11.3-orig/MAINTAINERS	2005-03-13 00:44:28.000000000 -0600
+++ linux-2.6.11.3/MAINTAINERS	2005-03-16 19:08:54.000000000 -0600
@@ -2087,6 +2087,13 @@ M:	perex@suse.cz
 L:	alsa-devel@alsa-project.org
 S:	Maintained
 
+TPM DEVICE DRIVER
+P:	Kylene Hall
+M:	kjhall@us.ibm.com
+W:	http://tpmdd.sourceforge.net
+L:	tpmdd-devel@lists.sourceforge.net
+S:	Maintained
+
 UltraSPARC (sparc64):
 P:	David S. Miller
 M:	davem@davemloft.net
