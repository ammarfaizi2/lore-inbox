Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278702AbRJ1WMu>; Sun, 28 Oct 2001 17:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278701AbRJ1WMk>; Sun, 28 Oct 2001 17:12:40 -0500
Received: from [63.231.122.81] ([63.231.122.81]:24378 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S278700AbRJ1WMZ>;
	Sun, 28 Oct 2001 17:12:25 -0500
Date: Sun, 28 Oct 2001 03:00:29 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] swap cleanup, forward compat hooks/LABEL
Message-ID: <20011028030029.E4229@lynx.no>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allocates space in the swap space on-disk struct for a swap label,
which can be used with the LABEL= support for /etc/fstab with the right
user-space tools.  This patch uses the same on-disk location for the label
that was used in a previously posted patch that does the same thing.

We also add a duplicate magic field (still holds "SWAPSPACE2") within the
info struct, as well as the PAGE_SIZE at which the swap was created.
Since these are at a fixed offset, it makes detecting the swap space setup
a lot easier, especially on systems (ARM?) which support multiple PAGE_SIZE
settings.

If people agree that "sizeof(int) = 4" then I would also like to change
the use of "int" everywhere to "u32", as it is kind of ugly to store
a (potentially) variable-sized value to the disk.

This does not really affect the kernel, and is totally compatible with
the current swap space setup.

This has been discussed several times previously, with no real objections
except "we should have labels in the partition table", but until something
like the ia64 EFI GUID partition table is in widespread use, swap space will
need to have LABEL support added to them.

I have agreement in principle from Andries to add LABEL support for swap space
to swapon.

Cheers, Andreas
=============================================================================
diff -ru linux.orig/include/linux/swap.h linux/include/linux/swap.h
--- linux.orig/include/linux/swap.h	Thu Oct 25 03:05:15 2001
+++ linux/include/linux/swap.h	Thu Oct 25 10:02:34 2001
@@ -19,26 +19,48 @@
  *
  * Having the magic at the end of the PAGE_SIZE makes detecting swap
  * areas somewhat tricky on machines that support multiple page sizes.
- * For 2.5 we'll probably want to move the magic to just beyond the
- * bootbits...
+ * So, in addition to the old magic.magic, we add a new info.magic (which
+ * should contain the same string) at a fixed offset to allow easier
+ * detection of swap devices.  We also store PAGE_SIZE for this swap space.
+ *
+ * Because we had "unsigned int padding[125]" written to on-disk structs,
+ * there is no guarantee of the size of an unsigned int across platforms.
+ * Hence the union to preserve the alignment of badpages[].  Any new data
+ * structs should be allocated inside info.s.
  */
+
+#define SWAP_MAGIC_OFFSET_OLD (PAGE_SIZE-10)
+#define SWAP_MAGIC_OFFSET_NEW (1024 + 3*sizeof(unsigned int) + 16)
+
 union swap_header {
-	struct 
+	struct
 	{
-		char reserved[PAGE_SIZE - 10];
+		char reserved[SWAP_MAGIC_OFFSET_OLD];
 		char magic[10];			/* SWAP-SPACE or SWAPSPACE2 */
 	} magic;
-	struct 
+	struct
 	{
 		char	     bootbits[1024];	/* Space for disklabel etc. */
 		unsigned int version;
 		unsigned int last_page;
 		unsigned int nr_badpages;
-		unsigned int padding[125];
+		union {
+			unsigned int	padding[125];	/* Compatibility size */
+			struct {
+				char		volume_label[16]; /* LABEL= */
+				char		magic[10]; /* SWAPSPACE2 */
+				char		unused[6]; /* alignment */
+				unsigned int	page_size; /* = PAGE_SIZE */
+			} sw;
+		} u;
 		unsigned int badpages[1];
 	} info;
 };
 
+#define sw_volume_label u.sw.volume_label
+#define sw_magic u.sw.magic
+#define sw_page_size u.sw.page_size
+
 #ifdef __KERNEL__
 
 /*
@@ -210,9 +233,7 @@
  * unfreeable instead of using dirty buffer magic, but the
  * next code-change time is when 2.5 is forked...
  */
-#ifndef _LINUX_KDEV_T_H
 #include <linux/kdev_t.h>
-#endif
 #ifndef _LINUX_MAJOR_H
 #include <linux/major.h>
 #endif
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

