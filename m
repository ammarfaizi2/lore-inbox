Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314395AbSE3CO5>; Wed, 29 May 2002 22:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316156AbSE3CO4>; Wed, 29 May 2002 22:14:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:18355 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314395AbSE3COy>;
	Wed, 29 May 2002 22:14:54 -0400
Date: Wed, 29 May 2002 18:59:33 -0700 (PDT)
Message-Id: <20020529.185933.103256606.davem@redhat.com>
To: mathieu@newview.com
Cc: linux-kernel@vger.kernel.org, andre@linux-ide.org
Subject: Re: 2.4.19-pre9, IDE on Sparc, Big Disks
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020529172425.A15749@shookay.newview.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey Mathieu, give this patch a spin.  It makes it through
the compiler, but more interesting is if it fixes your
problem or not :-)

It's just the PowerPC code (from arch/ppc/kernel/setup.c).
There is nothing platform specific about any of this, it really
just belongs in drivers/ide/, and it can even run on Intel because
it is effectively a NOP on little-endian systems.  This would be
the best because then updates to this structure would likely be
accompanied with the matching changes to ide_fix_driveid().

I mean, let's have a look at current implementations:

Alpha:				little-endian, NOP
Arm:				little-endian, NOP
Cris:				little-endian, NOP
i386:				little-endian, NOP
ia64:				little-endian, NOP
M68k:				big-endian, byte-swap, same bug as Sparc
mips:				byte-swap when cpu is in big-endian mode
mips64:				No endian checks, BUG
parisc:				Big endian but no byte-swapping, bug?
				Anyone using IDE successfully on parisc?
ppc:				big-endian, byte swap
s390{,x}:			little-endian, NOP
sh:				BUG, does not check endianness
sparc/sparc64:			big-endian, byte swaps but is buggy.

What a mess, let's just fix this right :-)

--- include/asm-sparc64/ide.h.~1~	Wed May 29 17:57:14 2002
+++ include/asm-sparc64/ide.h	Wed May 29 19:04:43 2002
@@ -232,79 +232,93 @@
 #endif
 }
 
-#define T_CHAR          (0x0000)        /* char:  don't touch  */
-#define T_SHORT         (0x4000)        /* short: 12 -> 21     */
-#define T_INT           (0x8000)        /* int:   1234 -> 4321 */
-#define T_TEXT          (0xc000)        /* text:  12 -> 21     */
-
-#define T_MASK_TYPE     (0xc000)
-#define T_MASK_COUNT    (0x3fff)
-
-#define D_CHAR(cnt)     (T_CHAR  | (cnt))
-#define D_SHORT(cnt)    (T_SHORT | (cnt))
-#define D_INT(cnt)      (T_INT   | (cnt))
-#define D_TEXT(cnt)     (T_TEXT  | (cnt))
-
-static u_short driveid_types[] = {
-	D_SHORT(10),	/* config - vendor2 */
-	D_TEXT(20),	/* serial_no */
-	D_SHORT(3),	/* buf_type - ecc_bytes */
-	D_TEXT(48),	/* fw_rev - model */
-	D_CHAR(2),	/* max_multsect - vendor3 */
-	D_SHORT(1),	/* dword_io */
-	D_CHAR(2),	/* vendor4 - capability */
-	D_SHORT(1),	/* reserved50 */
-	D_CHAR(4),	/* vendor5 - tDMA */
-	D_SHORT(4),	/* field_valid - cur_sectors */
-	D_INT(1),	/* cur_capacity */
-	D_CHAR(2),	/* multsect - multsect_valid */
-	D_INT(1),	/* lba_capacity */
-	D_SHORT(194)	/* dma_1word - reservedyy */
-};
-
-#define num_driveid_types       (sizeof(driveid_types)/sizeof(*driveid_types))
-
 static __inline__ void ide_fix_driveid(struct hd_driveid *id)
 {
-	u_char *p = (u_char *)id;
-	int i, j, cnt;
-	u_char t;
+	int i;
+	u16 *stringcast;
 
-	for (i = 0; i < num_driveid_types; i++) {
-		cnt = driveid_types[i] & T_MASK_COUNT;
-		switch (driveid_types[i] & T_MASK_TYPE) {
-		case T_CHAR:
-			p += cnt;
-			break;
-		case T_SHORT:
-			for (j = 0; j < cnt; j++) {
-				t = p[0];
-				p[0] = p[1];
-				p[1] = t;
-				p += 2;
-			}
-			break;
-		case T_INT:
-			for (j = 0; j < cnt; j++) {
-				t = p[0];
-				p[0] = p[3];
-				p[3] = t;
-				t = p[1];
-				p[1] = p[2];
-				p[2] = t;
-				p += 4;
-			}
-			break;
-		case T_TEXT:
-			for (j = 0; j < cnt; j += 2) {
-				t = p[0];
-				p[0] = p[1];
-				p[1] = t;
-				p += 2;
-			}
-			break;
-		};
-	}
+	id->config         = __le16_to_cpu(id->config);
+	id->cyls           = __le16_to_cpu(id->cyls);
+	id->reserved2      = __le16_to_cpu(id->reserved2);
+	id->heads          = __le16_to_cpu(id->heads);
+	id->track_bytes    = __le16_to_cpu(id->track_bytes);
+	id->sector_bytes   = __le16_to_cpu(id->sector_bytes);
+	id->sectors        = __le16_to_cpu(id->sectors);
+	id->vendor0        = __le16_to_cpu(id->vendor0);
+	id->vendor1        = __le16_to_cpu(id->vendor1);
+	id->vendor2        = __le16_to_cpu(id->vendor2);
+	stringcast = (u16 *)&id->serial_no[0];
+	for (i = 0; i < (20/2); i++)
+	        stringcast[i] = __le16_to_cpu(stringcast[i]);
+	id->buf_type       = __le16_to_cpu(id->buf_type);
+	id->buf_size       = __le16_to_cpu(id->buf_size);
+	id->ecc_bytes      = __le16_to_cpu(id->ecc_bytes);
+	stringcast = (u16 *)&id->fw_rev[0];
+	for (i = 0; i < (8/2); i++)
+	        stringcast[i] = __le16_to_cpu(stringcast[i]);
+	stringcast = (u16 *)&id->model[0];
+	for (i = 0; i < (40/2); i++)
+	        stringcast[i] = __le16_to_cpu(stringcast[i]);
+	id->dword_io       = __le16_to_cpu(id->dword_io);
+	id->reserved50     = __le16_to_cpu(id->reserved50);
+	id->field_valid    = __le16_to_cpu(id->field_valid);
+	id->cur_cyls       = __le16_to_cpu(id->cur_cyls);
+	id->cur_heads      = __le16_to_cpu(id->cur_heads);
+	id->cur_sectors    = __le16_to_cpu(id->cur_sectors);
+	id->cur_capacity0  = __le16_to_cpu(id->cur_capacity0);
+	id->cur_capacity1  = __le16_to_cpu(id->cur_capacity1);
+	id->lba_capacity   = __le32_to_cpu(id->lba_capacity);
+	id->dma_1word      = __le16_to_cpu(id->dma_1word);
+	id->dma_mword      = __le16_to_cpu(id->dma_mword);
+	id->eide_pio_modes = __le16_to_cpu(id->eide_pio_modes);
+	id->eide_dma_min   = __le16_to_cpu(id->eide_dma_min);
+	id->eide_dma_time  = __le16_to_cpu(id->eide_dma_time);
+	id->eide_pio       = __le16_to_cpu(id->eide_pio);
+	id->eide_pio_iordy = __le16_to_cpu(id->eide_pio_iordy);
+	for (i = 0; i < 2; i++)
+		id->words69_70[i] = __le16_to_cpu(id->words69_70[i]);
+        for (i = 0; i < 4; i++)
+                id->words71_74[i] = __le16_to_cpu(id->words71_74[i]);
+	id->queue_depth	   = __le16_to_cpu(id->queue_depth);
+	for (i = 0; i < 4; i++)
+		id->words76_79[i] = __le16_to_cpu(id->words76_79[i]);
+	id->major_rev_num  = __le16_to_cpu(id->major_rev_num);
+	id->minor_rev_num  = __le16_to_cpu(id->minor_rev_num);
+	id->command_set_1  = __le16_to_cpu(id->command_set_1);
+	id->command_set_2  = __le16_to_cpu(id->command_set_2);
+	id->cfsse          = __le16_to_cpu(id->cfsse);
+	id->cfs_enable_1   = __le16_to_cpu(id->cfs_enable_1);
+	id->cfs_enable_2   = __le16_to_cpu(id->cfs_enable_2);
+	id->csf_default    = __le16_to_cpu(id->csf_default);
+	id->dma_ultra      = __le16_to_cpu(id->dma_ultra);
+	id->word89         = __le16_to_cpu(id->word89);
+	id->word90         = __le16_to_cpu(id->word90);
+	id->CurAPMvalues   = __le16_to_cpu(id->CurAPMvalues);
+	id->word92         = __le16_to_cpu(id->word92);
+	id->hw_config      = __le16_to_cpu(id->hw_config);
+	id->acoustic       = __le16_to_cpu(id->acoustic);
+	for (i = 0; i < 5; i++)
+		id->words95_99[i]  = __le16_to_cpu(id->words95_99[i]);
+	id->lba_capacity_2 = __le64_to_cpu(id->lba_capacity_2);
+	for (i = 0; i < 22; i++)
+		id->words104_125[i]   = __le16_to_cpu(id->words104_125[i]);
+	id->last_lun       = __le16_to_cpu(id->last_lun);
+	id->word127        = __le16_to_cpu(id->word127);
+	id->dlf            = __le16_to_cpu(id->dlf);
+	id->csfo           = __le16_to_cpu(id->csfo);
+	for (i = 0; i < 26; i++)
+		id->words130_155[i] = __le16_to_cpu(id->words130_155[i]);
+	id->word156        = __le16_to_cpu(id->word156);
+	for (i = 0; i < 3; i++)
+		id->words157_159[i] = __le16_to_cpu(id->words157_159[i]);
+	id->cfa_power      = __le16_to_cpu(id->cfa_power);
+	for (i = 0; i < 14; i++)
+		id->words161_175[i] = __le16_to_cpu(id->words161_175[i]);
+	for (i = 0; i < 31; i++)
+		id->words176_205[i] = __le16_to_cpu(id->words176_205[i]);
+	for (i = 0; i < 48; i++)
+		id->words206_254[i] = __le16_to_cpu(id->words206_254[i]);
+	id->integrity_word  = __le16_to_cpu(id->integrity_word);
 }
 
 /*
