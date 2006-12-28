Return-Path: <linux-kernel-owner+w=401wt.eu-S1754849AbWL1NSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754849AbWL1NSc (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 08:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754851AbWL1NSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 08:18:32 -0500
Received: from moutng.kundenserver.de ([212.227.126.179]:57313 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754849AbWL1NSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 08:18:30 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-mtd@lists.infradead.org
Subject: [RFC] MTD driver for MMC cards
Date: Thu, 28 Dec 2006 14:18:19 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, drzeus-mmc@drzeus.cx, dwmw2@infradead.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612281418.20643.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an experiment on how an SD/MMC card could be used in the MTD layer.
I don't currently have a system set up to test this, so this driver is
completely _untested_ and therefore you should consider it _broken_.

You can get similar functionality by using the mmc_block driver together
with block2mtd, so you may wonder what the point of another driver is.
IMHO, there are two separate advantages from using a special driver:

* better use of low-level interfaces: the MTD driver can detect the
  erase block size of the card and erase sectors in advance instead of
  blocking in the write path. The MTD file systems also expect the
  underlying interface to be synchronous, so there is little point
  in using extra kernel threads to operate on the card in the background.

* It becomes possible to use MMC cards with jffs2 even with CONFIG_BLOCK
  disabled, which can save a significant amount of kernel memory on
  small machines that have an MMC slot but no other block device.

I still want to be sure that I'm on the right track with this driver
and did not make a conceptual mistake.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

---

Index: linux-cg/drivers/mmc/mmc.c
===================================================================
--- linux-cg.orig/drivers/mmc/mmc.c
+++ linux-cg/drivers/mmc/mmc.c
@@ -616,6 +616,8 @@ static void mmc_decode_csd(struct mmc_ca
 		csd->r2w_factor = UNSTUFF_BITS(resp, 26, 3);
 		csd->write_blkbits = UNSTUFF_BITS(resp, 22, 4);
 		csd->write_partial = UNSTUFF_BITS(resp, 21, 1);
+		csd->erase_blksize = (UNSTUFF_BITS(resp, 37, 5) + 1) *
+					(UNSTUFF_BITS(resp, 42, 5) + 1);
 	} else {
 		/*
 		 * We only understand CSD structure v1.1 and v1.2.
@@ -651,6 +653,8 @@ static void mmc_decode_csd(struct mmc_ca
 		csd->r2w_factor = UNSTUFF_BITS(resp, 26, 3);
 		csd->write_blkbits = UNSTUFF_BITS(resp, 22, 4);
 		csd->write_partial = UNSTUFF_BITS(resp, 21, 1);
+		csd->erase_blksize = (UNSTUFF_BITS(resp, 37, 5) + 1) *
+					(UNSTUFF_BITS(resp, 42, 5) + 1);
 	}
 }
 
Index: linux-cg/include/linux/mmc/card.h
===================================================================
--- linux-cg.orig/include/linux/mmc/card.h
+++ linux-cg/include/linux/mmc/card.h
@@ -32,6 +32,7 @@ struct mmc_csd {
 	unsigned int		max_dtr;
 	unsigned int		read_blkbits;
 	unsigned int		write_blkbits;
+	unsigned int		erase_blksize;
 	unsigned int		capacity;
 	unsigned int		read_partial:1,
 				read_misalign:1,
Index: linux-cg/drivers/mmc/mmc_mtd.c
===================================================================
--- /dev/null
+++ linux-cg/drivers/mmc/mmc_mtd.c
@@ -0,0 +1,274 @@
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/protocol.h>
+#include <linux/mtd/mtd.h>
+#include <linux/scatterlist.h>
+
+/*
+ * erase a range of erase groups aligned to mtd->erase_size
+ */
+static int mmc_mtd_erase(struct mtd_info *mtd, struct erase_info *instr)
+{
+	struct mmc_card *card = mtd->priv;
+	struct mmc_command cmd[3] = { {
+			.opcode = MMC_ERASE_GROUP_START,
+			.arg = instr->addr,
+			.flags = MMC_RSP_R1 | MMC_CMD_AC,
+		}, {
+			.opcode = MMC_ERASE_GROUP_END,
+			.arg = instr->addr + instr->len,
+			.flags = MMC_RSP_R1 | MMC_CMD_AC,
+		}, {
+			.opcode = MMC_ERASE,
+			.flags = MMC_RSP_R1B | MMC_CMD_AC,
+		},
+	};
+	int err, i;
+
+	dev_dbg(card->dev, "%s: from %ld len %ld\n", __FUNCTION__, from, len);
+
+	instr->state = MTD_ERASING;
+	err = mmc_card_claim_host(card);
+	if (err)
+		goto error;
+
+	for (i=0; i<3; i++) {
+		err = mmc_wait_for_cmd(card->host, cmd, 5);
+		if (err) {
+			dev_err(&card->dev, "%s: error %d in stage %d\n",
+				__FUNCTION__, err, i);
+			break;
+		}
+	}
+	mmc_card_release_host(card);
+	mtd_erase_callback(instr);
+error:
+	instr->state = err ? MTD_ERASE_FAILED : MTD_ERASE_DONE;
+	return err;
+}
+
+/*
+ * check if a write command was completed correctly
+ */
+static int mmc_mtd_get_status(struct mmc_card *card)
+{
+	int err;
+	struct mmc_command cmd;
+
+	err = mmc_card_claim_host(card);
+	if (err)
+		goto error;
+
+	do {
+		cmd = (struct mmc_command) {
+			.opcode = MMC_SEND_STATUS,
+			.arg = card->rca << 16,
+			.flags = MMC_RSP_R1 | MMC_CMD_AC,
+		};
+
+		err = mmc_wait_for_cmd(card->host, &cmd, 5);
+		if (err) {
+			dev_err(&card->dev, "error %d requesting status\n", err);
+			break;
+		}
+	} while (!(cmd.resp[0] & R1_READY_FOR_DATA));
+
+	mmc_card_release_host(card);
+error:
+	return err;
+}
+
+/*
+ * transfer a block to/from the card. The block needs to be aligned
+ * to mtd->writesize. If we want to implement an mtd_writev method,
+ * this needs to use stream operations with an appropriate stop
+ * command as well.
+ */
+static int mmc_mtd_transfer_low(struct mmc_card *card, loff_t off, size_t len,
+			size_t *retlen, u_char *buf, int write)
+{
+	struct scatterlist sg;
+	struct mmc_data data = {
+		.blksz = 1 << card->csd.read_blkbits,
+		.blocks = len >> card->csd.read_blkbits,
+		.flags = write ? MMC_DATA_WRITE : MMC_DATA_READ,
+		.sg = &sg,
+		.sg_len = 1,
+	};
+	struct mmc_command cmd = {
+		.arg = off,
+		.data = &data,
+		.flags = MMC_RSP_R1 | MMC_CMD_ADTC,
+		.opcode = write ? MMC_WRITE_BLOCK : MMC_READ_SINGLE_BLOCK,
+	};
+	struct mmc_request mrq = {
+		.cmd = &cmd,
+		.data = &data,
+	};
+	int ret;
+
+	dev_dbg(&card->dev, "%s off %ld, len %ld\n",
+		write ? "write" : "read", off, len);
+
+	sg_init_one(&sg, buf, len);
+	mmc_set_data_timeout(&data, card, write);
+	mmc_wait_for_req(card->host, &mrq);
+
+	if (cmd.error || data.error) {
+		dev_err(&card->dev, "error %d/%d sending read/write command\n",
+		        cmd.error, data.error);
+		ret = -EIO;
+	}
+
+	/* copied from the block driver, don't understand why this is needed */
+	if (write)
+		ret = mmc_mtd_get_status(card);
+
+	if (!ret)
+		*retlen = len;
+	return ret;
+}
+
+/*
+ * do some common sanity checks and locking for the actual transfer
+ * function.
+ */
+static int mmc_mtd_transfer(struct mtd_info *mtd, loff_t off, size_t len,
+			size_t *retlen, u_char *buf, int write)
+{
+	struct mmc_card *card = mtd->priv;
+	int ret;
+
+	if (off > mtd->size)
+		return -EINVAL;
+	if (off + len > mtd->size)
+		len = mtd->size - off;
+
+	if (retlen)
+		*retlen = 0;
+
+	ret = mmc_card_claim_host(card);
+	if (ret) {
+		dev_warn(&card->dev, "%s: mmc_card_claim_host returned %d\n",
+			__FUNCTION__, ret);
+		ret = -EIO;
+		goto error;
+	}
+
+	ret = mmc_mtd_transfer_low(card, off, len, retlen, buf, write);
+	mmc_card_release_host(card);
+error:
+	return ret;
+}
+
+static int mmc_mtd_read(struct mtd_info *mtd, loff_t from, size_t len,
+		size_t *retlen, u_char *buf)
+{
+	return mmc_mtd_transfer(mtd, from, len, retlen, buf, 0);
+}
+
+static int mmc_mtd_write(struct mtd_info *mtd, loff_t to, size_t len,
+		size_t *retlen, const u_char *buf)
+{
+	return mmc_mtd_transfer(mtd, to, len, retlen, (u_char *)buf, 1);
+}
+
+/*
+ * Initialize an mmc card. We create a new MTD device for each
+ * MMC card we find. The operations are rather straightforward,
+ * so we don't even need our own data structure to contain the
+ * mtd_info.
+ */
+static int mmc_mtd_probe(struct mmc_card *card)
+{
+	struct mtd_info *mtd;
+	int ret;
+
+	if (!(card->csd.cmdclass & CCC_ERASE))
+		return -ENODEV;
+
+	dev_info(&card->dev, "mmc card %s found\n", card->dev.bus_id);
+
+	mtd = kzalloc(GFP_KERNEL, sizeof *mtd);
+	if (!mtd)
+		return -ENOMEM;
+
+	sprintf(mtd->name, "mmc: %s", card->dev.bus_id);
+
+	/* Don't know if these computations are correct */
+	mtd->size = card->csd.capacity << (card->csd.read_blkbits - 9);
+	mtd->writesize = 1 << card->csd.write_blkbits;
+	mtd->erasesize = mtd->writesize * card->csd.erase_blksize;
+	dev_info(&card->dev, "size %d bytes, writesize %d, readsize %d\n",
+		mtd->size, mtd->writesize, mtd->erasesize);
+
+	/*
+	 * NAND is a relatively good approximation, but with the current
+	 * MTD scheme, we might need to get our own type
+	 */
+	mtd->type = MTD_NANDFLASH;
+	mtd->flags = MTD_CAP_NANDFLASH;
+
+	/*
+	 * operations that may be worthwhile implementing:
+	 *    writev, sync, lock, unlock, suspend, resume
+	 * In the mean time, these should be sufficient.
+	 */
+	mtd->erase = mmc_mtd_erase;
+	mtd->write = mmc_mtd_write;
+	mtd->writev = default_mtd_writev;
+	mtd->read = mmc_mtd_read;
+
+	mtd->owner = THIS_MODULE;
+	mtd->priv = card;
+	mmc_set_drvdata(card, mtd);
+
+	ret = add_mtd_device(mtd);
+	if (ret)
+		kfree(mtd);
+
+	return ret;
+}
+
+/*
+ * Not sure if this is safe. Can we call del_mtd_device while
+ * the device is still in use? Do we have a choice?
+ */
+static void mmc_mtd_remove(struct mmc_card *card)
+{
+	struct mtd_info *mtd;
+
+	mtd = mmc_get_drvdata(card);
+	del_mtd_device(mtd);
+	kfree(mtd);
+}
+
+/*
+ * This driver will match any card, so it conflicts with the
+ * mmc block driver. It's only possible to load one of them
+ * at a time.
+ */
+static struct mmc_driver mmc_mtd_driver = {
+	.drv		= {
+		.name	= "mmcmtd",
+	},
+	.probe		= mmc_mtd_probe,
+	.remove		= mmc_mtd_remove,
+};
+
+static int __init mmc_blk_init(void)
+{
+	return mmc_register_driver(&mmc_mtd_driver);
+}
+module_init(mmc_blk_init);
+
+static void __exit mmc_blk_exit(void)
+{
+	mmc_unregister_driver(&mmc_mtd_driver);
+}
+module_exit(mmc_blk_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Multimedia Card (MMC) MTD device driver");
+MODULE_AUTHOR("Arnd Bergmann <arnd@arndb.de>");
Index: linux-cg/drivers/mmc/Kconfig
===================================================================
--- linux-cg.orig/drivers/mmc/Kconfig
+++ linux-cg/drivers/mmc/Kconfig
@@ -29,6 +29,17 @@ config MMC_BLOCK
 	  mount the filesystem. Almost everyone wishing MMC support
 	  should say Y or M here.
 
+config MMC_MTD
+	tristate "MMC MTD device driver"
+	depends on MMC && MTD && (MMC_BLOCK = n || (MMC_BLOCK != y && MMC_BLOCK))
+	help
+	  Enable this to as an alternative to the MMC block driver.
+	  It makes it possible to use MMC memory cards with the
+	  MTD layer and file systems based on it, e.g. jffs2.
+	  Since both drivers operate on the same devices, you can't
+	  build them both into the kernel and you need to say M here
+	  if you want to build both.
+
 config MMC_ARMMMCI
 	tristate "ARM AMBA Multimedia Card Interface support"
 	depends on ARM_AMBA && MMC
Index: linux-cg/drivers/mmc/Makefile
===================================================================
--- linux-cg.orig/drivers/mmc/Makefile
+++ linux-cg/drivers/mmc/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_MMC)		+= mmc_core.o
 # Media drivers
 #
 obj-$(CONFIG_MMC_BLOCK)		+= mmc_block.o
+obj-$(CONFIG_MMC_MTD)		+= mmc_mtd.o
 
 #
 # Host drivers
