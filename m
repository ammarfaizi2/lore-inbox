Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268139AbUIPWJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268139AbUIPWJw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 18:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268113AbUIPWJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 18:09:27 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:7582 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S268004AbUIPWH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 18:07:27 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch] ide: kill /proc/ide/ide?/config
Date: Fri, 17 Sep 2004 00:01:02 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409170001.02057.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm going to send this to Andrew.
Comments, complaints, threats? :-)

[patch] ide: kill /proc/ide/ide?/config
 
I first wanted to deprecate it but after discovering that:
- writes to PCI config space are non-functional since 2.4.21
- reads of full PCI config space are allowed for normal users
I think that there we are better off removing it immediately.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
---

 linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide-proc.c |  257 -------------------
 1 files changed, 257 deletions(-)

diff -puN drivers/ide/ide-proc.c~ide_proc_config drivers/ide/ide-proc.c
--- linux-2.6.9-rc1-bk18/drivers/ide/ide-proc.c~ide_proc_config	2004-09-16 22:56:43.457198888 +0200
+++ linux-2.6.9-rc1-bk18-bzolnier/drivers/ide/ide-proc.c	2004-09-16 23:08:33.763215960 +0200
@@ -8,37 +8,6 @@
 /*
  * This is the /proc/ide/ filesystem implementation.
  *
- * The major reason this exists is to provide sufficient access
- * to driver and config data, such that user-mode programs can
- * be developed to handle chipset tuning for most PCI interfaces.
- * This should provide better utilities, and less kernel bloat.
- *
- * The entire pci config space for a PCI interface chipset can be
- * retrieved by just reading it.  e.g.    "cat /proc/ide3/config"
- *
- * To modify registers *safely*, do something like:
- *   echo "P40:88" >/proc/ide/ide3/config
- * That expression writes 0x88 to pci config register 0x40
- * on the chip which controls ide3.  Multiple tuples can be issued,
- * and the writes will be completed as an atomic set:
- *   echo "P40:88 P41:35 P42:00 P43:00" >/proc/ide/ide3/config
- *
- * All numbers must be specified using pairs of ascii hex digits.
- * It is important to note that these writes will be performed
- * after waiting for the IDE controller (both interfaces)
- * to be completely idle, to ensure no corruption of I/O in progress.
- *
- * Non-PCI registers can also be written, using "R" in place of "P"
- * in the above examples.  The size of the port transfer is determined
- * by the number of pairs of hex digits given for the data.  If a two
- * digit value is given, the write will be a byte operation; if four
- * digits are used, the write will be performed as a 16-bit operation;
- * and if eight digits are specified, a 32-bit "dword" write will be
- * performed.  Odd numbers of digits are not permitted.
- *
- * If there is an error *anywhere* in the string of registers/data
- * then *none* of the writes will be performed.
- *
  * Drive/Driver settings can be retrieved by reading the drive's
  * "settings" files.  e.g.    "cat /proc/ide0/hda/settings"
  * To write a new value "val" into a specific setting "name", use:
@@ -51,10 +20,6 @@
  * returned data as 256 16-bit words.  The "hdparm" utility will
  * be updated someday soon to use this mechanism.
  *
- * Feel free to develop and distribute fancy GUI configuration
- * utilities for your favorite PCI chipsets.  I'll be working on
- * one for the Promise 20246 someday soon.  -ml
- *
  */
 
 #include <linux/config.h>
@@ -74,227 +39,6 @@
 
 #include <asm/io.h>
 
-static int proc_ide_write_config(struct file *file, const char __user *buffer,
-				 unsigned long count, void *data)
-{
-	ide_hwif_t	*hwif = (ide_hwif_t *)data;
-	ide_hwgroup_t *mygroup = (ide_hwgroup_t *)(hwif->hwgroup);
-	ide_hwgroup_t *mategroup = NULL;
-	unsigned long timeout;
-	unsigned long flags;
-	const char *start = NULL, *msg = NULL;
-	struct entry { u32 val; u16 reg; u8 size; u8 pci; } *prog, *q, *r;
-	int want_pci = 0;
-	char *buf, *s;
-	int err;
-
-	if (hwif->mate && hwif->mate->hwgroup)
-		mategroup = (ide_hwgroup_t *)(hwif->mate->hwgroup);
-
-	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
-		return -EACCES;
-
-	if (count >= PAGE_SIZE)
-		return -EINVAL;
-
-	s = buf = (char *)__get_free_page(GFP_USER);
-	if (!buf)
-		return -ENOMEM;
-
-	err = -ENOMEM;
-	q = prog = (struct entry *)__get_free_page(GFP_USER);
-	if (!prog)
-		goto out;
-
-	err = -EFAULT;
-	if (copy_from_user(buf, buffer, count))
-		goto out1;
-
-	buf[count] = '\0';
-
-	while (isspace(*s))
-		s++;
-
-	while (*s) {
-		char *p;
-		int digits;
-
-		start = s;
-
-		if ((char *)(q + 1) > (char *)prog + PAGE_SIZE) {
-			msg = "too many entries";
-			goto parse_error;
-		}
-
-		switch (*s++) {
-			case 'R':	q->pci = 0;
-					break;
-			case 'P':	q->pci = 1;
-					want_pci = 1;
-					break;
-			default:	msg = "expected 'R' or 'P'";
-					goto parse_error;
-		}
-
-		q->reg = simple_strtoul(s, &p, 16);
-		digits = p - s;
-		if (!digits || digits > 4 || (q->pci && q->reg > 0xff)) {
-			msg = "bad/missing register number";
-			goto parse_error;
-		}
-		if (*p++ != ':') {
-			msg = "missing ':'";
-			goto parse_error;
-		}
-		q->val = simple_strtoul(p, &s, 16);
-		digits = s - p;
-		if (digits != 2 && digits != 4 && digits != 8) {
-			msg = "bad data, 2/4/8 digits required";
-			goto parse_error;
-		}
-		q->size = digits / 2;
-
-		if (q->pci) {
-#ifdef CONFIG_BLK_DEV_IDEPCI
-			if (q->reg & (q->size - 1)) {
-				msg = "misaligned access";
-				goto parse_error;
-			}
-#else
-			msg = "not a PCI device";
-			goto parse_error;
-#endif	/* CONFIG_BLK_DEV_IDEPCI */
-		}
-
-		q++;
-
-		if (*s && !isspace(*s++)) {
-			msg = "expected whitespace after data";
-			goto parse_error;
-		}
-		while (isspace(*s))
-			s++;
-	}
-
-	/*
-	 * What follows below is fucking insane, even for IDE people.
-	 * For now I've dealt with the obvious problems on the parsing
-	 * side, but IMNSHO we should simply remove the write access
-	 * to /proc/ide/.../config, killing that FPOS completely.
-	 */
-
-	err = -EBUSY;
-	timeout = jiffies + (3 * HZ);
-	spin_lock_irqsave(&ide_lock, flags);
-	while (mygroup->busy ||
-	       (mategroup && mategroup->busy)) {
-		spin_unlock_irqrestore(&ide_lock, flags);
-		if (time_after(jiffies, timeout)) {
-			printk("/proc/ide/%s/config: channel(s) busy, cannot write\n", hwif->name);
-			goto out1;
-		}
-		spin_lock_irqsave(&ide_lock, flags);
-	}
-
-#ifdef CONFIG_BLK_DEV_IDEPCI
-	if (want_pci && (!hwif->pci_dev || hwif->pci_dev->vendor)) {
-		spin_unlock_irqrestore(&ide_lock, flags);
-		printk("proc_ide: PCI registers not accessible for %s\n",
-			hwif->name);
-		err = -EINVAL;
-		goto out1;
-	}
-#endif	/* CONFIG_BLK_DEV_IDEPCI */
-
-	for (r = prog; r < q; r++) {
-		unsigned int reg = r->reg, val = r->val;
-		if (r->pci) {
-#ifdef CONFIG_BLK_DEV_IDEPCI
-			int rc = 0;
-			struct pci_dev *dev = hwif->pci_dev;
-			switch (q->size) {
-				case 1:	msg = "byte";
-					rc = pci_write_config_byte(dev, reg, val);
-					break;
-				case 2:	msg = "word";
-					rc = pci_write_config_word(dev, reg, val);
-					break;
-				case 4:	msg = "dword";
-					rc = pci_write_config_dword(dev, reg, val);
-					break;
-			}
-			if (rc) {
-				spin_unlock_irqrestore(&ide_lock, flags);
-				printk("proc_ide_write_config: error writing %s at bus %02x dev %02x reg 0x%x value 0x%x\n",
-					msg, dev->bus->number, dev->devfn, reg, val);
-				printk("proc_ide_write_config: error %d\n", rc);
-				err = -EIO;
-				goto out1;
-			}
-#endif	/* CONFIG_BLK_DEV_IDEPCI */
-		} else {	/* not pci */
-			switch (r->size) {
-				case 1:	hwif->OUTB(val, reg);
-					break;
-				case 2:	hwif->OUTW(val, reg);
-					break;
-				case 4:	hwif->OUTL(val, reg);
-					break;
-			}
-		}
-	}
-	spin_unlock_irqrestore(&ide_lock, flags);
-	err = count;
-out1:
-	free_page((unsigned long)prog);
-out:
-	free_page((unsigned long)buf);
-	return err;
-
-parse_error:
-	printk("parse error\n");
-	printk("proc_ide: error: %s: '%s'\n", msg, start);
-	err = -EINVAL;
-	goto out1;
-}
-
-static int proc_ide_read_config
-	(char *page, char **start, off_t off, int count, int *eof, void *data)
-{
-	char		*out = page;
-	int		len;
-
-#ifdef CONFIG_BLK_DEV_IDEPCI
-	ide_hwif_t	*hwif = (ide_hwif_t *)data;
-	struct pci_dev	*dev = hwif->pci_dev;
-	if ((hwif->pci_dev && hwif->pci_dev->vendor) && dev && dev->bus) {
-		int reg = 0;
-
-		out += sprintf(out, "pci bus %02x device %02x vendor %04x "
-				"device %04x channel %d\n",
-			dev->bus->number, dev->devfn,
-			hwif->pci_dev->vendor, hwif->pci_dev->device,
-			hwif->channel);
-		do {
-			u8 val;
-			int rc = pci_read_config_byte(dev, reg, &val);
-			if (rc) {
-				printk("proc_ide_read_config: error %d reading"
-					" bus %02x dev %02x reg 0x%02x\n",
-					rc, dev->bus->number, dev->devfn, reg);
-				out += sprintf(out, "??%c",
-					(++reg & 0xf) ? ' ' : '\n');
-			} else
-				out += sprintf(out, "%02x%c",
-					val, (++reg & 0xf) ? ' ' : '\n');
-		} while (reg < 0x100);
-	} else
-#endif	/* CONFIG_BLK_DEV_IDEPCI */
-		out += sprintf(out, "(none)\n");
-	len = out - page;
-	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
-}
-
 static int proc_ide_read_imodel
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
@@ -701,7 +445,6 @@ void destroy_proc_ide_drives(ide_hwif_t 
 
 static ide_proc_entry_t hwif_entries[] = {
 	{ "channel",	S_IFREG|S_IRUGO,	proc_ide_read_channel,	NULL },
-	{ "config",	S_IFREG|S_IRUGO|S_IWUSR,proc_ide_read_config,	proc_ide_write_config },
 	{ "mate",	S_IFREG|S_IRUGO,	proc_ide_read_mate,	NULL },
 	{ "model",	S_IFREG|S_IRUGO,	proc_ide_read_imodel,	NULL },
 	{ NULL,	0, NULL, NULL }
_
