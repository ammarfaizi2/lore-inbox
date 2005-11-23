Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932507AbVKWELE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbVKWELE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 23:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbVKWELE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 23:11:04 -0500
Received: from mail.deathmatch.net ([216.200.85.210]:1682 "EHLO
	mail.deathmatch.net") by vger.kernel.org with ESMTP id S932507AbVKWELC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 23:11:02 -0500
Date: Tue, 22 Nov 2005 23:11:00 -0500
From: Bob Copeland <me@bobcopeland.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] partitions: Read Rio Karma boot sector
Message-ID: <20051123041100.GB5595@hash.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Rio Karma has a proprietary boot sector with an MSDOS-like partition
table.  Add support for it to enable mounting of the device.

Signed-off-by: Bob Copeland <me@bobcopeland.com>

---

(I don't know who, if anyone, owns fs/partitions and MAINTAINERS didn't 
seem clear on that point.)

 fs/partitions/Kconfig  |    7 ++++++
 fs/partitions/Makefile |    1 +
 fs/partitions/check.c  |    4 +++
 fs/partitions/karma.c  |   57 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/partitions/karma.h  |    8 +++++++
 5 files changed, 77 insertions(+), 0 deletions(-)
 create mode 100644 fs/partitions/karma.c
 create mode 100644 fs/partitions/karma.h

applies-to: 3f92a0ea6d1780823f2c56e512942bcc6e7817ef
37c5c6803376f54306a7690bfb99c96cff5534de
diff --git a/fs/partitions/Kconfig b/fs/partitions/Kconfig
index deb25b6..f916ef1 100644
--- a/fs/partitions/Kconfig
+++ b/fs/partitions/Kconfig
@@ -225,4 +225,11 @@ config EFI_PARTITION
 	  were partitioned using EFI GPT.  Presently only useful on the
 	  IA-64 platform.
 
+config KARMA_PARTITION
+	bool "Karma Partition support"
+	depends on PARTITION_ADVANCED
+	help
+	  Say Y here if you would like to mount the Rio Karma MP3 player,
+          as it uses a proprietary partition table.
+
 #      define_bool CONFIG_ACORN_PARTITION_CUMANA y
diff --git a/fs/partitions/Makefile b/fs/partitions/Makefile
index 66d5cc2..42c7d38 100644
--- a/fs/partitions/Makefile
+++ b/fs/partitions/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_SUN_PARTITION) += sun.o
 obj-$(CONFIG_ULTRIX_PARTITION) += ultrix.o
 obj-$(CONFIG_IBM_PARTITION) += ibm.o
 obj-$(CONFIG_EFI_PARTITION) += efi.o
+obj-$(CONFIG_KARMA_PARTITION) += karma.o
diff --git a/fs/partitions/check.c b/fs/partitions/check.c
index 8dc1822..ac10938 100644
--- a/fs/partitions/check.c
+++ b/fs/partitions/check.c
@@ -35,6 +35,7 @@
 #include "ibm.h"
 #include "ultrix.h"
 #include "efi.h"
+#include "karma.h"
 
 #ifdef CONFIG_BLK_DEV_MD
 extern void md_autodetect_dev(dev_t dev);
@@ -103,6 +104,9 @@ static int (*check_part[])(struct parsed
 #ifdef CONFIG_IBM_PARTITION
 	ibm_partition,
 #endif
+#ifdef CONFIG_KARMA_PARTITION
+	karma_partition,
+#endif
 	NULL
 };
  
diff --git a/fs/partitions/karma.c b/fs/partitions/karma.c
new file mode 100644
index 0000000..b4f5fed
--- /dev/null
+++ b/fs/partitions/karma.c
@@ -0,0 +1,57 @@
+/*
+ *  fs/partitions/karma.c
+ *  Rio Karma partition info.
+ *
+ *  Copyright (C) 2005 Bob Copeland (me@bobcopeland.com)
+ *  based on ofs.c
+ */
+
+#include "check.h"
+#include "karma.h"
+
+int karma_partition(struct parsed_partitions *state, struct block_device *bdev)
+{
+	int i;
+	int slot = 1;
+	Sector sect;
+	unsigned char *data;
+	struct disklabel {
+		u8 reserved[270];
+		struct d_partition {
+			__le32 res;
+			u8 fstype;
+			u8 res2[3];
+			__le32 offset;
+			__le32 size;
+		} partitions[2];
+		u8 blank[208];
+		__le16 magic;
+	} __attribute__((packed)) *label;
+	struct d_partition *p;
+
+	data = read_dev_sector(bdev, 0, &sect);
+	if (!data)
+		return -1;
+
+	label = (struct disklabel *) data;
+	if (le16_to_cpu(label->magic) != KARMA_LABEL_MAGIC) {
+		put_dev_sector(sect);
+		return 0;
+	}
+
+	p = label->partitions;
+	for (i = 0 ; i < 2; i++, p++) {
+		if (slot == state->limit)
+			break;
+
+		if (p->fstype == 0x4d && le32_to_cpu(p->size)) {
+			put_partition(state, slot, le32_to_cpu(p->offset),
+				le32_to_cpu(p->size));
+		}
+		slot++;
+	}
+	printk("\n");
+	put_dev_sector(sect);
+	return 1;
+}
+
diff --git a/fs/partitions/karma.h b/fs/partitions/karma.h
new file mode 100644
index 0000000..ecf7d3f
--- /dev/null
+++ b/fs/partitions/karma.h
@@ -0,0 +1,8 @@
+/*
+ *  fs/partitions/karma.h
+ */
+
+#define KARMA_LABEL_MAGIC		0xAB56
+
+int karma_partition(struct parsed_partitions *state, struct block_device *bdev);
+
---
0.99.9i
-- 
Bob Copeland %% www.bobcopeland.com 
