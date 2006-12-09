Return-Path: <linux-kernel-owner+w=401wt.eu-S936478AbWLII7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936478AbWLII7Y (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 03:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936477AbWLII7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 03:59:24 -0500
Received: from gate.crashing.org ([63.228.1.57]:57623 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936410AbWLII7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 03:59:23 -0500
Subject: Re: Oops in pata_pdc2027x
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: albertl@mail.com
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, ppc-dev <linuxppc-dev@ozlabs.org>
In-Reply-To: <457790F0.2070208@tw.ibm.com>
References: <20061205170144.0b98d7e6.sfr@canb.auug.org.au>
	 <457790F0.2070208@tw.ibm.com>
Content-Type: text/plain
Date: Sat, 09 Dec 2006 18:57:12 +1100
Message-Id: <1165651032.1103.123.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could that be related to the fix

[PATCH] libata: fix oops with sparsemem

That Arnd Bergmann just posted ? I'm copying it below in case you
haven't seen it.

----

                              From: 
Arnd Bergmann
<arnd.bergmann@de.ibm.com>
                                To: 
jgarzik@pobox.com
                                Cc: 
linux-ide@vger.kernel.org,
linux-kernel@vger.kernel.org,
linuxppc-dev@ozlabs.org
                           Subject: 
[PATCH] libata: fix oops with
sparsemem
                              Date: 
Fri, 8 Dec 2006 19:14:40 +0100
(Sat, 05:14 EST)


libata incorrectly passes NULL arguments to sg_set_buf, which
crashes on powerpc64 when looking for the corresponding mem_section.

This introduces a new ata_exec_nodma() wrapper that takes no buffer
arguments and does not call sg_set_buf either. In order to make it
easier to detect this sort of problem, it also adds a WARN_ON(!buf)
to sg_set_buf() so we get a log message even platforms without
sparsemem.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/drivers/ata/libata-core.c
===================================================================
--- linux-2.6.orig/drivers/ata/libata-core.c
+++ linux-2.6/drivers/ata/libata-core.c
@@ -1332,7 +1332,7 @@ unsigned ata_exec_internal_sg(struct ata
 }
 
 /**
- *     ata_exec_internal_sg - execute libata internal command
+ *     ata_exec_internal - execute libata internal command
  *     @dev: Device to which the command is sent
  *     @tf: Taskfile registers for the command and the result
  *     @cdb: CDB for packet command
@@ -1361,6 +1361,25 @@ unsigned ata_exec_internal(struct ata_de
 }
 
 /**
+ *     ata_exec_nodma - execute libata internal command
+ *     @dev: Device to which the command is sent
+ *     @tf: Taskfile registers for the command and the result
+ *
+ *     Wrapper around ata_exec_internal_sg() which takes no
+ *     data buffer.
+ *
+ *     LOCKING:
+ *     None.  Should be called with kernel context, might sleep.
+ *
+ *     RETURNS:
+ *     Zero on success, AC_ERR_* mask on failure
+ */
+static unsigned ata_exec_nodma(struct ata_device *dev, struct
ata_taskfile *tf)
+{
+       return ata_exec_internal_sg(dev, tf, NULL, DMA_NONE, NULL, 0);
+}
+
+/**
  *     ata_do_simple_cmd - execute simple internal command
  *     @dev: Device to which the command is sent
  *     @cmd: Opcode to execute
@@ -1384,7 +1403,7 @@ unsigned int ata_do_simple_cmd(struct at
        tf.flags |= ATA_TFLAG_DEVICE;
        tf.protocol = ATA_PROT_NODATA;
 
-       return ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
+       return ata_exec_nodma(dev, &tf);
 }
 
 /**
@@ -3475,7 +3494,7 @@ static unsigned int ata_dev_set_xfermode
        tf.protocol = ATA_PROT_NODATA;
        tf.nsect = dev->xfer_mode;
 
-       err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
+       err_mask = ata_exec_nodma(dev, &tf);
 
        DPRINTK("EXIT, err_mask=%x\n", err_mask);
        return err_mask;
@@ -3513,7 +3532,7 @@ static unsigned int ata_dev_init_params(
        tf.nsect = sectors;
        tf.device |= (heads - 1) & 0x0f; /* max head = num. of heads - 1
*/
 
-       err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
+       err_mask = ata_exec_nodma(dev, &tf);
 
        DPRINTK("EXIT, err_mask=%x\n", err_mask);
        return err_mask;
Index: linux-2.6/include/linux/scatterlist.h
===================================================================
--- linux-2.6.orig/include/linux/scatterlist.h
+++ linux-2.6/include/linux/scatterlist.h
@@ -8,6 +8,8 @@
 static inline void sg_set_buf(struct scatterlist *sg, const void *buf,
                              unsigned int buflen)
 {
+       WARN_ON(!buf); /* virt_to_page(NULL) crashes with sparsemem */
+
        sg->page = virt_to_page(buf);
        sg->offset = offset_in_page(buf);
        sg->length = buflen;
_______________________________________________

