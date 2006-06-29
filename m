Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751730AbWF2FMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbWF2FMa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 01:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751740AbWF2FMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 01:12:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7842 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751532AbWF2FM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 01:12:28 -0400
Message-Id: <200606290512.k5T5C9Rv008980@shell0.pdx.osdl.net>
Subject: + revert-input-atkbd-fix-hangeul-hanja-keys.patch added to -mm tree
To: mm-commits@vger.kernel.org
Cc: akpm@osdl.org, andrew.vasquez@qlogic.com, dtor_core@ameritech.net,
       dtor@mail.ru, linux-kernel@vger.kernel.org
From: akpm@osdl.org
Date: Wed, 28 Jun 2006 22:12:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch titled

     revert "Input: atkbd - fix HANGEUL/HANJA keys"

has been added to the -mm tree.  Its filename is

     revert-input-atkbd-fix-hangeul-hanja-keys.patch

See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
out what to do about this

------------------------------------------------------
Subject: revert "Input: atkbd - fix HANGEUL/HANJA keys"
From: Andrew Morton <akpm@osdl.org>

Revert 0ae051a19092d36112b5ba60ff8b5df7a5d5d23b, due to

To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Dmitry Torokhov <dtor@mail.ru>
Subject: keyboard repeat-rate borked with recent linux-2.6 git tree...
Date: 	Tue, 27 Jun 2006 14:03:19 -0700

Cc: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/char/keyboard.c        |    6 
 drivers/input/keyboard/atkbd.c |  208 +++++++++++--------------------
 2 files changed, 79 insertions(+), 135 deletions(-)

diff -puN drivers/char/keyboard.c~revert-input-atkbd-fix-hangeul-hanja-keys drivers/char/keyboard.c
--- a/drivers/char/keyboard.c~revert-input-atkbd-fix-hangeul-hanja-keys
+++ a/drivers/char/keyboard.c
@@ -1076,12 +1076,10 @@ static int emulate_raw(struct vc_data *v
 			put_queue(vc, 0x45 | up_flag);
 			return 0;
 		case KEY_HANGEUL:
-			if (!up_flag)
-				put_queue(vc, 0xf2);
+			if (!up_flag) put_queue(vc, 0xf1);
 			return 0;
 		case KEY_HANJA:
-			if (!up_flag)
-				put_queue(vc, 0xf1);
+			if (!up_flag) put_queue(vc, 0xf2);
 			return 0;
 	}
 
diff -puN drivers/input/keyboard/atkbd.c~revert-input-atkbd-fix-hangeul-hanja-keys drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c~revert-input-atkbd-fix-hangeul-hanja-keys
+++ a/drivers/input/keyboard/atkbd.c
@@ -55,7 +55,7 @@ static int atkbd_softraw = 1;
 module_param_named(softraw, atkbd_softraw, bool, 0);
 MODULE_PARM_DESC(softraw, "Use software generated rawmode");
 
-static int atkbd_scroll;
+static int atkbd_scroll = 0;
 module_param_named(scroll, atkbd_scroll, bool, 0);
 MODULE_PARM_DESC(scroll, "Enable scroll-wheel on MS Office and similar keyboards");
 
@@ -150,8 +150,8 @@ static unsigned char atkbd_unxlate_table
 #define ATKBD_RET_EMUL0		0xe0
 #define ATKBD_RET_EMUL1		0xe1
 #define ATKBD_RET_RELEASE	0xf0
-#define ATKBD_RET_HANJA		0xf1
-#define ATKBD_RET_HANGEUL	0xf2
+#define ATKBD_RET_HANGEUL	0xf1
+#define ATKBD_RET_HANJA		0xf2
 #define ATKBD_RET_ERR		0xff
 
 #define ATKBD_KEY_UNKNOWN	  0
@@ -170,13 +170,6 @@ static unsigned char atkbd_unxlate_table
 #define ATKBD_LED_EVENT_BIT	0
 #define ATKBD_REP_EVENT_BIT	1
 
-#define ATKBD_XL_ERR		0x01
-#define ATKBD_XL_BAT		0x02
-#define ATKBD_XL_ACK		0x04
-#define ATKBD_XL_NAK		0x08
-#define ATKBD_XL_HANGEUL	0x10
-#define ATKBD_XL_HANJA		0x20
-
 static struct {
 	unsigned char keycode;
 	unsigned char set2;
@@ -218,7 +211,8 @@ struct atkbd {
 	unsigned char emul;
 	unsigned char resend;
 	unsigned char release;
-	unsigned long xl_bit;
+	unsigned char bat_xl;
+	unsigned char err_xl;
 	unsigned int last;
 	unsigned long time;
 
@@ -251,65 +245,17 @@ ATKBD_DEFINE_ATTR(set);
 ATKBD_DEFINE_ATTR(softrepeat);
 ATKBD_DEFINE_ATTR(softraw);
 
-static const unsigned int xl_table[] = {
-	ATKBD_RET_BAT, ATKBD_RET_ERR, ATKBD_RET_ACK,
-	ATKBD_RET_NAK, ATKBD_RET_HANJA, ATKBD_RET_HANGEUL,
-};
-
-/*
- * Checks if we should mangle the scancode to extract 'release' bit
- * in translated mode.
- */
-static int atkbd_need_xlate(unsigned long xl_bit, unsigned char code)
-{
-	int i;
-
-	if (code == ATKBD_RET_EMUL0 || code == ATKBD_RET_EMUL1)
-		return 0;
-
-	for (i = 0; i < ARRAY_SIZE(xl_table); i++)
-		if (code == xl_table[i])
-			return test_bit(i, &xl_bit);
-
-	return 1;
-}
-
-/*
- * Calculates new value of xl_bit so the driver can distinguish
- * between make/break pair of scancodes for select keys and PS/2
- * protocol responses.
- */
-static void atkbd_calculate_xl_bit(struct atkbd *atkbd, unsigned char code)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(xl_table); i++) {
-		if (!((code ^ xl_table[i]) & 0x7f)) {
-			if (code & 0x80)
-				__clear_bit(i, &atkbd->xl_bit);
-			else
-				__set_bit(i, &atkbd->xl_bit);
-			break;
-		}
-	}
-}
 
-/*
- * Encode the scancode, 0xe0 prefix, and high bit into a single integer,
- * keeping kernel 2.4 compatibility for set 2
- */
-static unsigned int atkbd_compat_scancode(struct atkbd *atkbd, unsigned int code)
+static void atkbd_report_key(struct input_dev *dev, struct pt_regs *regs, int code, int value)
 {
-	if (atkbd->set == 3) {
-		if (atkbd->emul == 1)
-			code |= 0x100;
-        } else {
-		code = (code & 0x7f) | ((code & 0x80) << 1);
-		if (atkbd->emul == 1)
-			code |= 0x80;
-	}
-
-	return code;
+	input_regs(dev, regs);
+	if (value == 3) {
+		input_report_key(dev, code, 1);
+		input_sync(dev);
+		input_report_key(dev, code, 0);
+	} else
+		input_event(dev, EV_KEY, code, value);
+	input_sync(dev);
 }
 
 /*
@@ -321,11 +267,9 @@ static irqreturn_t atkbd_interrupt(struc
 			unsigned int flags, struct pt_regs *regs)
 {
 	struct atkbd *atkbd = serio_get_drvdata(serio);
-	struct input_dev *dev = atkbd->dev;
 	unsigned int code = data;
-	int scroll = 0, hscroll = 0, click = -1, add_release_event = 0;
+	int scroll = 0, hscroll = 0, click = -1;
 	int value;
-	unsigned char keycode;
 
 #ifdef ATKBD_DEBUG
 	printk(KERN_DEBUG "atkbd.c: Received %02x flags %02x\n", data, flags);
@@ -354,17 +298,25 @@ static irqreturn_t atkbd_interrupt(struc
 	if (!atkbd->enabled)
 		goto out;
 
-	input_event(dev, EV_MSC, MSC_RAW, code);
+	input_event(atkbd->dev, EV_MSC, MSC_RAW, code);
 
 	if (atkbd->translated) {
 
-		if (atkbd->emul || atkbd_need_xlate(atkbd->xl_bit, code)) {
+		if (atkbd->emul ||
+		    (code != ATKBD_RET_EMUL0 && code != ATKBD_RET_EMUL1 &&
+		     code != ATKBD_RET_HANGEUL && code != ATKBD_RET_HANJA &&
+		     (code != ATKBD_RET_ERR || atkbd->err_xl) &&
+	             (code != ATKBD_RET_BAT || atkbd->bat_xl))) {
 			atkbd->release = code >> 7;
 			code &= 0x7f;
 		}
 
-		if (!atkbd->emul)
-			atkbd_calculate_xl_bit(atkbd, data);
+		if (!atkbd->emul) {
+		     if ((code & 0x7f) == (ATKBD_RET_BAT & 0x7f))
+			atkbd->bat_xl = !(data >> 7);
+		     if ((code & 0x7f) == (ATKBD_RET_ERR & 0x7f))
+			atkbd->err_xl = !(data >> 7);
+		}
 	}
 
 	switch (code) {
@@ -381,48 +333,47 @@ static irqreturn_t atkbd_interrupt(struc
 		case ATKBD_RET_RELEASE:
 			atkbd->release = 1;
 			goto out;
-		case ATKBD_RET_ACK:
-		case ATKBD_RET_NAK:
-			printk(KERN_WARNING "atkbd.c: Spurious %s on %s. "
-			       "Some program might be trying access hardware directly.\n",
-			       data == ATKBD_RET_ACK ? "ACK" : "NAK", serio->phys);
-			goto out;
 		case ATKBD_RET_HANGEUL:
+			atkbd_report_key(atkbd->dev, regs, KEY_HANGEUL, 3);
+			goto out;
 		case ATKBD_RET_HANJA:
-			/*
-			 * These keys do not report release and thus need to be
-			 * flagged properly
-			 */
-			add_release_event = 1;
-			break;
+			atkbd_report_key(atkbd->dev, regs, KEY_HANJA, 3);
+			goto out;
 		case ATKBD_RET_ERR:
 			printk(KERN_DEBUG "atkbd.c: Keyboard on %s reports too many keys pressed.\n", serio->phys);
 			goto out;
 	}
 
-	code = atkbd_compat_scancode(atkbd, code);
-
-	if (atkbd->emul && --atkbd->emul)
-		goto out;
-
-	keycode = atkbd->keycode[code];
+	if (atkbd->set != 3)
+		code = (code & 0x7f) | ((code & 0x80) << 1);
+	if (atkbd->emul) {
+		if (--atkbd->emul)
+			goto out;
+		code |= (atkbd->set != 3) ? 0x80 : 0x100;
+	}
 
-	if (keycode != ATKBD_KEY_NULL)
-		input_event(dev, EV_MSC, MSC_SCAN, code);
+	if (atkbd->keycode[code] != ATKBD_KEY_NULL)
+		input_event(atkbd->dev, EV_MSC, MSC_SCAN, code);
 
-	switch (keycode) {
+	switch (atkbd->keycode[code]) {
 		case ATKBD_KEY_NULL:
 			break;
 		case ATKBD_KEY_UNKNOWN:
-			printk(KERN_WARNING
-			       "atkbd.c: Unknown key %s (%s set %d, code %#x on %s).\n",
-			       atkbd->release ? "released" : "pressed",
-			       atkbd->translated ? "translated" : "raw",
-			       atkbd->set, code, serio->phys);
-			printk(KERN_WARNING
-			       "atkbd.c: Use 'setkeycodes %s%02x <keycode>' to make it known.\n",
-			       code & 0x80 ? "e0" : "", code & 0x7f);
-			input_sync(dev);
+			if (data == ATKBD_RET_ACK || data == ATKBD_RET_NAK) {
+				printk(KERN_WARNING "atkbd.c: Spurious %s on %s. Some program, "
+				       "like XFree86, might be trying access hardware directly.\n",
+				       data == ATKBD_RET_ACK ? "ACK" : "NAK", serio->phys);
+			} else {
+				printk(KERN_WARNING "atkbd.c: Unknown key %s "
+				       "(%s set %d, code %#x on %s).\n",
+				       atkbd->release ? "released" : "pressed",
+				       atkbd->translated ? "translated" : "raw",
+				       atkbd->set, code, serio->phys);
+				printk(KERN_WARNING "atkbd.c: Use 'setkeycodes %s%02x <keycode>' "
+				       "to make it known.\n",
+				       code & 0x80 ? "e0" : "", code & 0x7f);
+			}
+			input_sync(atkbd->dev);
 			break;
 		case ATKBD_SCR_1:
 			scroll = 1 - atkbd->release * 2;
@@ -446,35 +397,33 @@ static irqreturn_t atkbd_interrupt(struc
 			hscroll = 1;
 			break;
 		default:
-			if (atkbd->release) {
-				value = 0;
-				atkbd->last = 0;
-			} else if (!atkbd->softrepeat && test_bit(keycode, dev->key)) {
-				/* Workaround Toshiba laptop multiple keypress */
-				value = time_before(jiffies, atkbd->time) && atkbd->last == code ? 1 : 2;
-			} else {
-				value = 1;
-				atkbd->last = code;
-				atkbd->time = jiffies + msecs_to_jiffies(dev->rep[REP_DELAY]) / 2;
-			}
+			value = atkbd->release ? 0 :
+				(1 + (!atkbd->softrepeat && test_bit(atkbd->keycode[code], atkbd->dev->key)));
 
-			input_regs(dev, regs);
-			input_report_key(dev, keycode, value);
-			input_sync(dev);
-
-			if (value && add_release_event) {
-				input_report_key(dev, keycode, 0);
-				input_sync(dev);
+			switch (value) {	/* Workaround Toshiba laptop multiple keypress */
+				case 0:
+					atkbd->last = 0;
+					break;
+				case 1:
+					atkbd->last = code;
+					atkbd->time = jiffies + msecs_to_jiffies(atkbd->dev->rep[REP_DELAY]) / 2;
+					break;
+				case 2:
+					if (!time_after(jiffies, atkbd->time) && atkbd->last == code)
+						value = 1;
+					break;
 			}
+
+			atkbd_report_key(atkbd->dev, regs, atkbd->keycode[code], value);
 	}
 
 	if (atkbd->scroll) {
-		input_regs(dev, regs);
+		input_regs(atkbd->dev, regs);
 		if (click != -1)
-			input_report_key(dev, BTN_MIDDLE, click);
-		input_report_rel(dev, REL_WHEEL, scroll);
-		input_report_rel(dev, REL_HWHEEL, hscroll);
-		input_sync(dev);
+			input_report_key(atkbd->dev, BTN_MIDDLE, click);
+		input_report_rel(atkbd->dev, REL_WHEEL, scroll);
+		input_report_rel(atkbd->dev, REL_HWHEEL, hscroll);
+		input_sync(atkbd->dev);
 	}
 
 	atkbd->release = 0;
@@ -815,9 +764,6 @@ static void atkbd_set_keycode_table(stru
 			for (i = 0; i < ARRAY_SIZE(atkbd_scroll_keys); i++)
 				atkbd->keycode[atkbd_scroll_keys[i].set2] = atkbd_scroll_keys[i].keycode;
 	}
-
-	atkbd->keycode[atkbd_compat_scancode(atkbd, ATKBD_RET_HANGEUL)] = KEY_HANGUEL;
-	atkbd->keycode[atkbd_compat_scancode(atkbd, ATKBD_RET_HANJA)] = KEY_HANJA;
 }
 
 /*
_

Patches currently in -mm which might be from akpm@osdl.org are

origin.patch
x86-do_irq-check-irq-number.patch
load_module-cleanup.patch
x86_64-oprofile-build-fix.patch
vsnprintf-fix.patch
generic_file_buffered_write-handle-zero-length-iovec-segments-stable.patch
disable-debugging-version-of-write_lock.patch
git-acpi.patch
git-acpi-fixup.patch
acpi_srat-needs-acpi.patch
acpi-asus-s3-resume-fix-fix.patch
sony_apci-resume.patch
git-agpgart.patch
kauditd_thread-warning-fix.patch
i2c-801-64bit-resource-fix.patch
git-geode-fixup.patch
git-gfs2.patch
git-gfs2-fixup.patch
gfs2-get_sb_dev-fix.patch
revert-input-atkbd-fix-hangeul-hanja-keys.patch
revert-ignore-makes-built-in-rules-variables.patch
revert-sparc-build-breakage.patch
git-klibc.patch
git-klibc-fixup.patch
git-hdrcleanup-vs-git-klibc-on-ia64.patch
git-hdrcleanup-vs-git-klibc-on-ia64-2.patch
git-libata-all.patch
sata-is-bust-on-s390.patch
forcedeth-typecast-cleanup.patch
drivers-net-ns83820c-add-paramter-to-disable-auto.patch
af_unix-datagram-getpeersec-fix.patch
git-pcmcia-fixup.patch
powerpc-kcofnig-warning-fix.patch
git-sas.patch
git-sas-sas_discover-build-fix.patch
serial-8250-sysrq-deadlock-fix.patch
serial-fix-uart_bug_txen-test.patch
revert-gregkh-pci-pci-test-that-drivers-properly-call-pci_set_master.patch
clear-abnormal-poweroff-flag-on-via-southbridges-fix-resume-fix.patch
revert-VIA-quirk-fixup-additional-PCI-IDs.patch
revert-PCI-quirk-VIA-IRQ-fixup-should-only-run-for-VIA-southbridges.patch
git-scsi-misc.patch
git-scsi-misc-fixup.patch
areca-raid-linux-scsi-driver.patch
git-scsi-target-fixup.patch
pm-usb-hcds-use-pm_event_prethaw-fix.patch
git-supertrak-fixup.patch
bcm43xx-opencoded-locking-fix.patch
adix-tree-rcu-lockless-readside-update-tidy.patch
zoned-vm-counters-create-vmstatc-h-from-page_allocc-h-s390-fix.patch
zoned-vm-counters-create-vmstatc-h-from-page_allocc-h-fix.patch
zoned-vm-counters-basic-zvc-zoned-vm-counter-implementation-tidy.patch
zoned-vm-counters-basic-zvc-zoned-vm-counter-implementation-export-vm_stat.patch
zoned-vm-counters-convert-nr_mapped-to-per-zone-counter-fix.patch
zoned-vm-counters-remove-nr_file_mapped-from-scan-control-structure-fix.patch
zoned-vm-counters-conversion-of-nr_slab-to-per-zone-counter-fix.patch
zoned-vm-counters-conversion-of-nr_pagetables-to-per-zone-counter-fix.patch
zoned-vm-counters-conversion-of-nr_dirty-to-per-zone-counter-fix.patch
zoned-vm-counters-conversion-of-nr_writeback-to-per-zone-counter.patch
zoned-vm-counters-conversion-of-nr_writeback-to-per-zone-counter-fix.patch
zoned-vm-counters-conversion-of-nr_unstable-to-per-zone-counter-nfs-fix.patch
zoned-vm-counters-conversion-of-nr_unstable-to-per-zone-counter-fix.patch
zoned-vm-counters-conversion-of-nr_bounce-to-per-zone-counter.patch
zoned-vm-counters-conversion-of-nr_bounce-to-per-zone-counter-fix.patch
zoned-vm-counters-remove-read_page_state.patch
mm-tracking-shared-dirty-pages-checks.patch
mm-tracking-shared-dirty-pages-wimp.patch
slab-consolidate-code-to-free-slabs-from-freelist-fix.patch
acx1xx-wireless-driver.patch
tiacx-pci-build-fix.patch
tiacx-ia64-fix.patch
add-smp_setup_processor_id.patch
deprecate-smbfs-in-favour-of-cifs.patch
destroy-the-dentries-contributed-by-a-superblock-on-unmounting-fix.patch
cond_resched-fix.patch
reiserfs-on-demand-bitmap-loading-fix.patch
per-task-delay-accounting-proc-export-of-aggregated-block-i-o-delays-warning-fix.patch
delay-accounting-taskstats-interface-send-tgid-once-fixes.patch
sched-clean-up-fallout-of-recent-changes-fix.patch
swap_prefetch-vs-zoned-counters.patch
mark-address_space_operations-const-vs-ecryptfs-mmap-operations.patch
ecryptfs-alpha-build-fix.patch
ecryptfs-more-elegant-aes-key-size-manipulation-tidy.patch
ecryptfs-get_sb_dev-fix.patch
namespaces-add-nsproxy-dont-include-compileh.patch
namespaces-utsname-switch-to-using-uts-namespaces-alpha-fix.patch
namespaces-utsname-use-init_utsname-when-appropriate-cifs-update.patch
namespaces-utsname-implement-utsname-namespaces-export.patch
namespaces-utsname-implement-utsname-namespaces-dont-include-compileh.patch
namespaces-utsname-sysctl-hack-cleanup-2-fix.patch
ipc-namespace-core-fix.patch
task-watchers-task-watchers-tidy.patch
task-watchers-add-support-for-per-task-watchers-warning-fix.patch
readahead-sysctl-parameters-fix.patch
make-copy_from_user_inatomic-not-zero-the-tail-on-i386-vs-reiser4.patch
reiser4-hardirq-include-fix.patch
reiser4-run-truncate_inode_pages-in-reiser4_delete_inode.patch
reiser4-get_sb_dev-fix.patch
reiser4-vs-zoned-allocator.patch
hpt3xx-rework-rate-filtering-tidy.patch
genirq-rename-desc-handler-to-desc-chip-power-fix.patch
genirq-rename-desc-handler-to-desc-chip-ia64-fix.patch
genirq-rename-desc-handler-to-desc-chip-ia64-fix-2.patch
genirq-rename-desc-handler-to-desc-chip-terminate_irqs-fix.patch
genirq-ia64-build-fix.patch
lockdep-add-disable-enable_irq_lockdep-api-fix.patch
lockdep-irqtrace-subsystem-x86_64-support-fix.patch
srcu-rcu-variant-permitting-read-side-blocking-fixes.patch
srcu-add-srcu-operations-to-rcutorture-fix.patch
srcu-2-add-srcu-operations-to-rcutorture-fix.patch
ro-bind-mounts-elevate-write-count-during-entire-ncp_ioctl-tidy.patch
nr_blockdev_pages-in_interrupt-warning.patch
device-suspend-debug.patch
revert-tty-buffering-comment-out-debug-code.patch
slab-leaks3-default-y.patch
x86-kmap_atomic-debugging.patch

