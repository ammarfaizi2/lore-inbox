Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbUCGNmE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 08:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbUCGNmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 08:42:04 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:33670 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S261966AbUCGNlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 08:41:55 -0500
Date: Sun, 07 Mar 2004 21:41:24 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Pavel Machek" <pavel@ucw.cz>,
       "kernel list" <linux-kernel@vger.kernel.org>
Subject: Re: Highmem emulation for 2.6?
References: <20040307125939.GA965@elf.ucw.cz> <opr4htvdoa4evsfm@smtp.pacific.net.th>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr4huzawi4evsfm@smtp.pacific.net.th>
In-Reply-To: <opr4htvdoa4evsfm@smtp.pacific.net.th>
User-Agent: Opera M2/7.50 (Linux, build 600)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is one more patch which checks zone alignment.

It was rejected by Andrew, but if you experiment with
highmem emulation I suggest you use it together with
highmem-userfriendly patch at least until it works.

This patch is pre-codingstyle-update and may need some
cleanup, sorry ;)

The following is applicable to all architectures using zones.

When zone alignment goes wrong, a message is printed:
         BUG: wrong zone alignment, it will crash

_BUT_ kernel runs until it dies of the alignment problems - it took me
hours until I found the message after looking elsewhere

This patch:

- Should zone alignment fail, it will force a BUG() once the BUG handler inits
- Improves the messages of zone init to help debug zone alignment problems

Regards
Michael

Example invalid zone alignment after disabling auto-alignment:

300MB HIGHMEM available.
195MB LOWMEM available.
On node 0 totalpages: 126960, zones aligned at: 0x400000
   DMA zone: 4096 pages, LIFO batch:1, physical start address at: 0x0
   Normal zone: 46064 pages, LIFO batch:11, physical start address at: 0x1000000
   HighMem zone: 76800 pages, LIFO batch:16, physical start address at: 0xc3f0000
   HighMem zone: FATAL ERROR invalid zone alignment at: 0x3f0000 - will force kernel
BUG
DMI 2.3 present.
Building zonelist for node : 0
Kernel command line: vga=0xf07 root=/dev/hda4 console=tty0 console=ttyS0,115200n8r
devfs=nomount nousb acpi=off init=/bin/bash highmem=300m
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 2399.836 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x60
Memory: 498216k/507840k available (1930k kernel code, 8600k reserved, 990k data,
160k init, 307200k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4734.97 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
------------[ cut here ]------------
kernel BUG at init/main.c:464!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c03de5e7>]    Not tainted
EFLAGS: 00010202
EIP is at start_kernel+0x14f/0x190
eax: cc3e7a60   ebx: 00010809   ecx: c044af48   edx: cc3e7ad0
esi: 00099800   edi: c0105000   ebp: 0008e000   esp: c03ddff8
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c03dc000 task=c035e7e0)
Stack: c0406ea0 c010017e
Call Trace:

Code: 0f 0b d0 01 7b 3f 2e c0 e8 80 95 00 00 e8 6f 23 00 00 e8 c2
  <0>Kernel panic: Attempted to kill the idle task!
In idle task - not syncing

diff -uN -r -X /home/mhf/sys/dont/dontdiff linux-2.6.2-Vanilla/arch/i386/kernel/
setup.c linux-2.6.2-mhf177/arch/i386/kernel/setup.c
--- linux-2.6.2-Vanilla/arch/i386/kernel/setup.c2004-02-06 19:36:54.000000000 +0800
+++ linux-2.6.2-mhf177/arch/i386/kernel/setup.c2004-02-08 04:07:39.000000000 +0800
@@ -581,9 +581,12 @@
  #endif /* CONFIG_ACPI_BOOT */

  /*
- * highmem=size forces highmem to be exactly 'size' bytes.
+ * highmem=size forces highmem to be at most 'size' bytes.
   * This works even on boxes that have no highmem otherwise.
   * This also works to reduce highmem size on bigger boxes.
+ *
+ * Note: highmem sise is adjusted downward for proper zone
+ *       alignment of the highmem physical start address.
   */
  if (c == ' ' && !memcmp(from, "highmem=", 8))
  highmem_pages = memparse(from+8, &from) >> PAGE_SHIFT;
@@ -650,6 +653,11 @@
  /*
   * Determine low and high memory ranges:
   */
+
+#define ZONE_REQUIRED_PAGE_ALIGNMENT (1UL << (MAX_ORDER-1))
+#define ZONE_REQUIRED_PAGE_ALIGNMENT_MASK (ZONE_REQUIRED_PAGE_ALIGNMENT-1)
+#define PAGES_FOR_64MB (64*1024*1024/PAGE_SIZE)
+
  unsigned long __init find_max_low_pfn(void)
  {
  unsigned long max_low_pfn;
@@ -661,14 +669,16 @@
  if (highmem_pages + MAXMEM_PFN < max_pfn)
  max_pfn = MAXMEM_PFN + highmem_pages;
  if (highmem_pages + MAXMEM_PFN > max_pfn) {
-printk("only %luMB highmem pages available, ignoring highmem size of
  %uMB.\n", pages_to_mb(max_pfn - MAXMEM_PFN), pages_to_mb(highmem_pages));
-highmem_pages = 0;
+printk("Warning reducing highmem=%uMB to: %luMB.\n",
+       pages_to_mb(highmem_pages),
+       pages_to_mb((max_pfn - MAXMEM_PFN)));
+highmem_pages = max_pfn - MAXMEM_PFN;
  }
  max_low_pfn = MAXMEM_PFN;
  #ifndef CONFIG_HIGHMEM
  /* Maximum memory usable is what is directly addressable */
-printk(KERN_WARNING "Warning only %ldMB will be used.\n",
-MAXMEM>>20);
+printk(KERN_WARNING "Warning only %dMB will be used.\n",
+       MAXMEM>>20);
  if (max_pfn > MAX_NONPAE_PFN)
  printk(KERN_WARNING "Use a PAE enabled kernel.\n");
  else
@@ -683,26 +693,61 @@
  }
  #endif /* !CONFIG_X86_PAE */
  #endif /* !CONFIG_HIGHMEM */
-} else {
-if (highmem_pages == -1)
-highmem_pages = 0;
+} else if (highmem_pages == -1)
+highmem_pages = 0;
  #ifdef CONFIG_HIGHMEM
-if (highmem_pages >= max_pfn) {
-printk(KERN_ERR "highmem size specified (%uMB) is bigger than pages
available (%luMB)!.\n", pages_to_mb(highmem_pages), pages_to_mb(max_pfn));
-highmem_pages = 0;
-}
-if (highmem_pages) {
-if (max_low_pfn-highmem_pages < 64*1024*1024/PAGE_SIZE){
-printk(KERN_ERR "highmem size %uMB results in smaller than 64MB
lowmem, ignoring it.\n", pages_to_mb(highmem_pages));
-highmem_pages = 0;
-}
-max_low_pfn -= highmem_pages;
-}
+if (!highmem_pages)
+goto out;
+if (max_pfn < PAGES_FOR_64MB + ZONE_REQUIRED_PAGE_ALIGNMENT * 2) {
+printk(KERN_ERR
+       "Error highmem support requires at least %luMB but only %luMB
are available.\n",
+       pages_to_mb(PAGES_FOR_64MB + ZONE_REQUIRED_PAGE_ALIGNMENT *
2),
+       pages_to_mb(max_pfn));
+highmem_pages = 0;
+goto out;
+}
+if (highmem_pages > max_pfn) {
+printk(KERN_WARNING
+       "Warning highmem=%uMB is bigger than available %luMB and will
be adjusted.\n",
+       pages_to_mb(highmem_pages), pages_to_mb(max_pfn));
+}
+if (highmem_pages <= ZONE_REQUIRED_PAGE_ALIGNMENT) {
+printk(KERN_WARNING
+       "Warning highmem=%uMB is too small and has been adjusted to:
  %luMB.\n",
+       pages_to_mb(highmem_pages),
+       pages_to_mb(ZONE_REQUIRED_PAGE_ALIGNMENT * 2));
+highmem_pages = ZONE_REQUIRED_PAGE_ALIGNMENT * 2;
+}
+if (max_low_pfn < highmem_pages || max_low_pfn-highmem_pages <
PAGES_FOR_64MB){
+highmem_pages = max_low_pfn - PAGES_FOR_64MB;
+printk(KERN_WARNING
+       "Warning highmem size adjusted for a minimum of 64MB lowmem
to: %uMB.\n",
+       pages_to_mb(highmem_pages));
+}
+max_low_pfn -= highmem_pages;
+goto out;
+/* remove this when done testing bad zone alignment kernel shutdown: end */
+
+if (max_low_pfn & ZONE_REQUIRED_PAGE_ALIGNMENT_MASK) {
+printk(KERN_WARNING
+       "Warning bad highmem zone alignment 0x%lx, highmem size will
be adjusted.\n",
+       (max_low_pfn & ZONE_REQUIRED_PAGE_ALIGNMENT_MASK) <<
PAGE_SHIFT);
+highmem_pages -= ZONE_REQUIRED_PAGE_ALIGNMENT -
+(max_low_pfn & ZONE_REQUIRED_PAGE_ALIGNMENT_MASK);
+max_low_pfn &= ~ZONE_REQUIRED_PAGE_ALIGNMENT_MASK;
+max_low_pfn += ZONE_REQUIRED_PAGE_ALIGNMENT;
+printk(KERN_WARNING
+       "Warning lowmem size adjusted  for zone alignment to:
  %luMB.\n",
+       pages_to_mb(max_low_pfn));
+printk(KERN_WARNING
+       "Warning highmem size adjusted for zone alignment to:
  %uMB.\n",
+        pages_to_mb(highmem_pages));
+}
  #else
-if (highmem_pages)
-printk(KERN_ERR "ignoring highmem size on non-highmem kernel!\n");
+if (highmem_pages)
+printk(KERN_ERR "ignoring highmem size on non-highmem kernel!\n");
  #endif
-}
+out:
  return max_low_pfn;
  }


