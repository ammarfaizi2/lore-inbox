Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262642AbVCSRBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262642AbVCSRBU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 12:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbVCSRBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 12:01:20 -0500
Received: from exosec.net1.nerim.net ([62.212.114.195]:37897 "EHLO
	mail-out1.exosec.net") by vger.kernel.org with ESMTP
	id S262642AbVCSRBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 12:01:05 -0500
Date: Sat, 19 Mar 2005 18:01:00 +0100
From: Willy Tarreau <wtarreau@exosec.fr>
To: linux-kernel@vger.kernel.org
Cc: grant_nospam@dodo.com.au
Subject: linux-2.4.29-hf5
Message-ID: <20050319170100.GA17236@exosec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's the fifth hotfix for linux-2.4.29 :

    http://linux.exosec.net/kernel/2.4-hf/

NOTE: This update fixes a remote security issue on PPP servers which is also
fixed in 2.4.30-rc1 (thanks to Paul Mackerras).

I've appended the changelog from 2.4.29-hf4 below, and the incremental diff
(very small).

I'd like to thank particularly Grant Coady, who has compiled a lot of -hf
kernels on several of his machines and maintains a build report on his page
linked below. Those interested can check his site for more information :

    http://scatter.mine.nu/linux-2.4-hotfix/

When Marcelo starts 2.4.30-bk, I'll start a 2.4.30-hf and still maintain
2.4.29-hf in parallel (at least as long as I'll see downloads of this version
in the server's logs). Of course, given the small number of changes between
2.4.29 and 2.4.30-rc1, everyone is encouraged to upgrade to 2.4.30 ASAP and
stick to mainline as much as possible.

Regards,
Willy

--

Changelog From 2.4.29-hf4 to 2.4.29-hf5 (semi-automated)
---------------------------------------
'+' = added ; '-' = removed

Note: This update fixes a remote security issue on PPP servers.


+ ppp-server-remote-dos-1                                      (Paul Mackerras)

  Remote Linux DoS on ppp servers (CAN-2005-0384)

+ x86_64-fix-x87-tag-word-emulation-1                          (Roland McGrath)

  Fix x87 fnsave Tag Word emulation when using FXSR (SSE).
  The fxsave instruction does not save the x87 tag word (only the empty bits),
  and we re-created the old-style x87 tags incorrectly. The registers are saved
  in "stack order" in the save area, but the tag word bits are in "hardware
  order", and we need to get the right register state. Both x86 and x86-64
  needed this fix.

+ possible-pty-line-discipline-race-1                          (Linus Torvalds)

  [PATCH] Workaround possible pty line discipline race.
  It's in no way "correct", in that the race hasn't actually gone away by this
  patch, but the patch makes it unimportant. We may end up calling a stale line
  discipline, which is still very wrong, but it so happens that we don't much
  care in practice. I think that in a 2.4.x tree there are some theoretical SMP
  races with module unloading etc (which the 2.6.x code doesn't have because
  module unload stops the other CPU's - maybe that part got backported to
  2.4.x?), but quite frankly, I suspect that even in 2.4.x they are entirely
  theoretical and impossible to actually hit. And again, in theory some line
  discipline might do something strange in it's "chars_in_buffer" routine that
  would be problematic. In practice that's just not the case: the
  "chars_in_buffer()" routine might return a bogus _value_ for a stale line
  discipline thing, but none of them seem to follow any pointers that might
  have become invalid (and in fact, most ldiscs don't even have that function).

+ softdog-does-not-reboot-on-close-1                           (Jacques Basson)

  There is a bug in the softdog.c (v 0.05) in the 2.4 kernel series (certainly
  in 2.4.29 and there are no references to it in the latest Changelog) that
  won't reboot the machine if /dev/watchdog is closed unexpectedly and nowayout
  is not set.

- scsi-tapes-allow-lseek-1                                    (Marcelo Tosatti)
+ scsi-tapes-allow-lseek-2                                    (Marcelo Tosatti)

  Fixed lseek on OSST tapes too.
 
+ write-throttling-ignore-free-highmem-1                     (Andrea Arcangeli)

  I got reports of stalls with heavy writes on 2.4. There was a mistake in
  nr_free_buffer_pages. That function is definitely meant _not_ to take highmem
  into account (dirty cache cannot spread over highmem in 2.4 [even when on top
  of fs]). For unknown reasons it was actually taking highmem into account. The
  code was obviously meant to not take into account see the GFP_USER and
  zonelist, except it wasn't using the zonelist. That is a severe problem
  because there will be no write throttling at all, and no bdflush wakeup
  either. This is a noop for all systems <800M (1G shouldn't be noticeable
  either). This is why most people can't notice.

+ get_user_pages-no-pg_reserved-1                            (Andrea Arcangeli)

  get_user_pages() shall not grab PG_reserved pages.
 
+ sparc32-fix-parallel-build-1                                (crn:netunix.com)

  [SPARC32]: Fix build dependencies for vmlinux.o
  This helps make parallel builds work properly.

--

diff -urN linux-2.4.29-hf4/Makefile linux-2.4.29-hf5/Makefile
--- linux-2.4.29-hf4/Makefile	2005-03-19 17:50:48.000000000 +0100
+++ linux-2.4.29-hf5/Makefile	2005-03-19 17:47:41.000000000 +0100
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
 SUBLEVEL = 29
-EXTRAVERSION = -hf4
+EXTRAVERSION = -hf5
 
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 
diff -urN linux-2.4.29-hf4/arch/i386/kernel/i387.c linux-2.4.29-hf5/arch/i386/kernel/i387.c
--- linux-2.4.29-hf4/arch/i386/kernel/i387.c	2003-08-25 13:44:39.000000000 +0200
+++ linux-2.4.29-hf5/arch/i386/kernel/i387.c	2005-03-19 17:47:41.000000000 +0100
@@ -128,16 +128,17 @@
 static inline unsigned long twd_fxsr_to_i387( struct i387_fxsave_struct *fxsave )
 {
 	struct _fpxreg *st = NULL;
+	unsigned long tos = (fxsave->swd >> 11) & 7;
 	unsigned long twd = (unsigned long) fxsave->twd;
 	unsigned long tag;
 	unsigned long ret = 0xffff0000;
 	int i;
 
-#define FPREG_ADDR(f, n)	((char *)&(f)->st_space + (n) * 16);
+#define FPREG_ADDR(f, n)	((void *)&(f)->st_space + (n) * 16);
 
 	for ( i = 0 ; i < 8 ; i++ ) {
 		if ( twd & 0x1 ) {
-			st = (struct _fpxreg *) FPREG_ADDR( fxsave, i );
+			st = FPREG_ADDR( fxsave, (i - tos) & 7 );
 
 			switch ( st->exponent & 0x7fff ) {
 			case 0x7fff:
diff -urN linux-2.4.29-hf4/arch/sparc/Makefile linux-2.4.29-hf5/arch/sparc/Makefile
--- linux-2.4.29-hf4/arch/sparc/Makefile	2004-08-08 01:26:04.000000000 +0200
+++ linux-2.4.29-hf5/arch/sparc/Makefile	2005-03-19 17:47:41.000000000 +0100
@@ -45,6 +45,7 @@
 	$(TOPDIR)/arch/sparc/lib/lib.a
 
 # This one has to come last
+_dir_arch/sparc/boot : $(patsubst %, _dir_%, $(SUBDIRS))
 SUBDIRS += arch/sparc/boot
 CORE_FILES_NO_BTFIX := $(CORE_FILES)
 CORE_FILES += arch/sparc/boot/btfix.o
diff -urN linux-2.4.29-hf4/arch/sparc/boot/Makefile linux-2.4.29-hf5/arch/sparc/boot/Makefile
--- linux-2.4.29-hf4/arch/sparc/boot/Makefile	2002-08-03 02:39:43.000000000 +0200
+++ linux-2.4.29-hf5/arch/sparc/boot/Makefile	2005-03-19 17:47:41.000000000 +0100
@@ -26,11 +26,14 @@
 BTLIBS := $(CORE_FILES_NO_BTFIX) $(FILESYSTEMS) \
 	$(DRIVERS) $(NETWORKS)
 
-# I wanted to make this depend upon BTOBJS so that a parallel
-# build would work, but this fails because $(HEAD) cannot work
-# properly as it will cause head.o to be built with the implicit
-# rules not the ones in kernel/Makefile.  Someone please fix. --DaveM
-vmlinux.o: dummy
+GENFILES := include/linux/version.h include/linux/compile.h $(foreach dirname, $(CORE_FILES_NO_BTFIX), _dir_$(dir $(dirname)))
+.PHONY : $(GENFILES)
+GENFILES += $(BTOBJS)
+
+$(GENFILES):
+	$(MAKE) -C $(TOPDIR) $@
+
+vmlinux.o: $(GENFILES)
 	$(LD) -r $(patsubst %,$(TOPDIR)/%,$(BTOBJS)) \
 		--start-group \
 		$(patsubst %,$(TOPDIR)/%,$(BTLIBS)) \
diff -urN linux-2.4.29-hf4/arch/x86_64/ia32/fpu32.c linux-2.4.29-hf5/arch/x86_64/ia32/fpu32.c
--- linux-2.4.29-hf4/arch/x86_64/ia32/fpu32.c	2003-06-13 16:51:32.000000000 +0200
+++ linux-2.4.29-hf5/arch/x86_64/ia32/fpu32.c	2005-03-19 17:47:41.000000000 +0100
@@ -28,16 +28,17 @@
 static inline unsigned long twd_fxsr_to_i387(struct i387_fxsave_struct *fxsave)
 {
 	struct _fpxreg *st = NULL;
+	unsigned long tos = (fxsave->swd >> 11) & 7;
 	unsigned long twd = (unsigned long) fxsave->twd;
 	unsigned long tag;
 	unsigned long ret = 0xffff0000;
 	int i;
 
-#define FPREG_ADDR(f, n)	((char *)&(f)->st_space + (n) * 16);
+#define FPREG_ADDR(f, n)	((void *)&(f)->st_space + (n) * 16);
 
 	for (i = 0 ; i < 8 ; i++) {
 		if (twd & 0x1) {
-			st = (struct _fpxreg *) FPREG_ADDR( fxsave, i );
+			st = FPREG_ADDR( fxsave, (i - tos) & 7 );
 
 			switch (st->exponent & 0x7fff) {
 			case 0x7fff:
diff -urN linux-2.4.29-hf4/drivers/char/pty.c linux-2.4.29-hf5/drivers/char/pty.c
--- linux-2.4.29-hf4/drivers/char/pty.c	2005-01-27 18:57:32.000000000 +0100
+++ linux-2.4.29-hf5/drivers/char/pty.c	2005-03-19 17:47:41.000000000 +0100
@@ -218,13 +218,15 @@
 static int pty_chars_in_buffer(struct tty_struct *tty)
 {
 	struct tty_struct *to = tty->link;
+	ssize_t (*chars_in_buffer)(struct tty_struct *);
 	int count;
 
-	if (!to || !to->ldisc.chars_in_buffer)
+	/* We should get the line discipline lock for "tty->link" */
+	if (!to || !(chars_in_buffer = to->ldisc.chars_in_buffer))
 		return 0;
 
 	/* The ldisc must report 0 if no characters available to be read */
-	count = to->ldisc.chars_in_buffer(to);
+	count = chars_in_buffer(to);
 
 	if (tty->driver.subtype == PTY_TYPE_SLAVE) return count;
 
diff -urN linux-2.4.29-hf4/drivers/char/softdog.c linux-2.4.29-hf5/drivers/char/softdog.c
--- linux-2.4.29-hf4/drivers/char/softdog.c	2003-11-28 19:26:20.000000000 +0100
+++ linux-2.4.29-hf5/drivers/char/softdog.c	2005-03-19 17:47:41.000000000 +0100
@@ -124,7 +124,7 @@
 	 *	Shut off the timer.
 	 * 	Lock it in if it's a module and we set nowayout
 	 */
-	if (expect_close || nowayout == 0) {
+	if (expect_close && nowayout == 0) {
 		del_timer(&watchdog_ticktock);
 	} else {
 		printk(KERN_CRIT "SOFTDOG: WDT device closed unexpectedly.  WDT will not stop!\n");
diff -urN linux-2.4.29-hf4/drivers/net/ppp_async.c linux-2.4.29-hf5/drivers/net/ppp_async.c
--- linux-2.4.29-hf4/drivers/net/ppp_async.c	2005-01-27 18:57:32.000000000 +0100
+++ linux-2.4.29-hf5/drivers/net/ppp_async.c	2005-03-19 17:47:41.000000000 +0100
@@ -996,7 +996,7 @@
 	data += 4;
 	dlen -= 4;
 	/* data[0] is code, data[1] is length */
-	while (dlen >= 2 && dlen >= data[1]) {
+	while (dlen >= 2 && dlen >= data[1] && data[1] >= 2) {
 		switch (data[0]) {
 		case LCP_MRU:
 			val = (data[2] << 8) + data[3];
diff -urN linux-2.4.29-hf4/drivers/scsi/osst.c linux-2.4.29-hf5/drivers/scsi/osst.c
--- linux-2.4.29-hf4/drivers/scsi/osst.c	2004-08-08 01:26:05.000000000 +0200
+++ linux-2.4.29-hf5/drivers/scsi/osst.c	2005-03-19 17:47:41.000000000 +0100
@@ -5505,7 +5505,6 @@
 	read:		osst_read,
 	write:		osst_write,
 	ioctl:		osst_ioctl,
-	llseek:		no_llseek,
 	open:		os_scsi_tape_open,
 	flush:		os_scsi_tape_flush,
 	release:	os_scsi_tape_close,
diff -urN linux-2.4.29-hf4/mm/memory.c linux-2.4.29-hf5/mm/memory.c
--- linux-2.4.29-hf4/mm/memory.c	2005-01-27 18:57:34.000000000 +0100
+++ linux-2.4.29-hf5/mm/memory.c	2005-03-19 17:47:41.000000000 +0100
@@ -499,9 +499,11 @@
 				/* FIXME: call the correct function,
 				 * depending on the type of the found page
 				 */
-				if (!pages[i])
-					goto bad_page;
-				page_cache_get(pages[i]);
+				if (!pages[i] || PageReserved(pages[i])) {
+					if (pages[i] != ZERO_PAGE(start))
+						goto bad_page;
+				} else
+					page_cache_get(pages[i]);
 			}
 			if (vmas)
 				vmas[i] = vma;
diff -urN linux-2.4.29-hf4/mm/page_alloc.c linux-2.4.29-hf5/mm/page_alloc.c
--- linux-2.4.29-hf4/mm/page_alloc.c	2004-11-17 12:54:22.000000000 +0100
+++ linux-2.4.29-hf5/mm/page_alloc.c	2005-03-19 17:47:41.000000000 +0100
@@ -551,7 +551,7 @@
 		class_idx = zone_idx(zone);
 
 		sum += zone->nr_cache_pages;
-		for (zone = pgdat->node_zones; zone < pgdat->node_zones + MAX_NR_ZONES; zone++) {
+		for (; zone; zone = *zonep++) {
 			int free = zone->free_pages - zone->watermarks[class_idx].high;
 			if (free <= 0)
 				continue;


