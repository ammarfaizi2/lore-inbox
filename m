Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261397AbTCTHHs>; Thu, 20 Mar 2003 02:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261402AbTCTHHs>; Thu, 20 Mar 2003 02:07:48 -0500
Received: from franka.aracnet.com ([216.99.193.44]:34489 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261397AbTCTHHq>; Thu, 20 Mar 2003 02:07:46 -0500
Date: Wed, 19 Mar 2003 23:15:19 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Adrian Bunk <bunk@fs.tum.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [patch] 2.5.65-mjb1: lkcd: fix dump_fmt.c for !CONFIG_SMP
Message-ID: <12290000.1048144518@[10.10.2.4]>
In-Reply-To: <20030319083025.GA23258@fs.tum.de>
References: <8230000.1047975763@[10.10.2.4]> <20030319083025.GA23258@fs.tum.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Mar 18, 2003 at 12:22:43AM -0800, Martin J. Bligh wrote:
>> ...
>> lkcd						LKCD team
>> 	Linux kernel crash dump support
>> ...
> 
> I got the following compile error for !CONFIG_SMP:

Errrm ... oops. Sorry about that. Thanks for all the testing, and to
you, Sam, and Christoph for suggested fixes. I've rolled up these, and 
a couple of other issues I found below ... could you try this? Compiles
for NUMA-Q and UP at least. Any feedback on the fixes welcome too ...

Thanks,

M.

diff -urpN -X /home/fletch/.diff.exclude 900-mjb1/drivers/dump/Makefile 901-lkcd_fixups/drivers/dump/Makefile
--- 900-mjb1/drivers/dump/Makefile	Mon Mar 17 21:50:08 2003
+++ 901-lkcd_fixups/drivers/dump/Makefile	Wed Mar 19 22:30:23 2003
@@ -1,7 +1,6 @@
 #
 # Makefile for the dump device drivers.
 #
-export-objs				:= dump_setup.o
 
 dump-y					:= dump_setup.o dump_fmt.o dump_filters.o dump_scheme.o dump_execute.o
 dump-$(CONFIG_X86)			+= dump_i386.o
diff -urpN -X /home/fletch/.diff.exclude 900-mjb1/drivers/dump/dump_netdev.c 901-lkcd_fixups/drivers/dump/dump_netdev.c
--- 900-mjb1/drivers/dump/dump_netdev.c	Mon Mar 17 21:50:08 2003
+++ 901-lkcd_fixups/drivers/dump/dump_netdev.c	Wed Mar 19 23:02:21 2003
@@ -556,9 +556,9 @@ do_netdump(struct dump_dev *net_dev, con
 		case COMM_GET_NR_PAGES:
 			reply.code = REPLY_NR_PAGES;
 			reply.nr = req.nr;
-			reply.info = max_mapnr;
+			reply.info = num_physpages;
                         reply.info = page_counter;
-			sprintf(tmp, "Number of pages: %ld\n", max_mapnr);
+			sprintf(tmp, "Number of pages: %ld\n", num_physpages);
 			dump_send_skb(dump_ndev, tmp, strlen(tmp), &reply);
 			break;
 
diff -urpN -X /home/fletch/.diff.exclude 900-mjb1/drivers/dump/dump_scheme.c 901-lkcd_fixups/drivers/dump/dump_scheme.c
--- 900-mjb1/drivers/dump/dump_scheme.c	Mon Mar 17 21:50:08 2003
+++ 901-lkcd_fixups/drivers/dump/dump_scheme.c	Wed Mar 19 22:59:05 2003
@@ -292,7 +292,7 @@ int dump_generic_configure(unsigned long
 	for (filter = dump_config.dumper->filter ;filter->selector; filter++) {
 		if (!filter->start && !filter->end) {
 			filter->start = 0;
-			filter->end = max_mapnr << PAGE_SHIFT;
+			filter->end = num_physpages << PAGE_SHIFT;
 		}
 	}
 
diff -urpN -X /home/fletch/.diff.exclude 900-mjb1/include/asm-i386/pgtable.h 901-lkcd_fixups/include/asm-i386/pgtable.h
--- 900-mjb1/include/asm-i386/pgtable.h	Mon Mar 17 21:58:58 2003
+++ 901-lkcd_fixups/include/asm-i386/pgtable.h	Wed Mar 19 22:03:48 2003
@@ -15,6 +15,7 @@
 #ifndef __ASSEMBLY__
 #include <asm/processor.h>
 #include <asm/fixmap.h>
+#include <asm/system.h>
 #include <linux/threads.h>
 
 #ifndef _I386_BITOPS_H
diff -urpN -X /home/fletch/.diff.exclude 900-mjb1/include/linux/dump.h 901-lkcd_fixups/include/linux/dump.h
--- 900-mjb1/include/linux/dump.h	Mon Mar 17 21:50:08 2003
+++ 901-lkcd_fixups/include/linux/dump.h	Wed Mar 19 22:08:59 2003
@@ -343,7 +343,7 @@ extern int	__dump_page_valid(unsigned lo
 #ifdef CONFIG_SMP
 extern void 	__dump_save_other_cpus(void);
 #else
-#define 	__dump_save_other_cpus(void)
+#define 	__dump_save_other_cpus()
 #endif
 
 #endif /* __KERNEL__ */
diff -urpN -X /home/fletch/.diff.exclude 900-mjb1/init/Makefile 901-lkcd_fixups/init/Makefile
--- 900-mjb1/init/Makefile	Mon Mar 17 21:50:08 2003
+++ 901-lkcd_fixups/init/Makefile	Wed Mar 19 22:14:30 2003
@@ -1,16 +1,15 @@
 #
 # Makefile for the linux kernel.
 #
-ifdef CONFIG_CRASH_DUMP
-EXTRA_TARGETS := kerntypes.o
-CFLAGS_kerntypes.o := -gstabs
-endif
 
 obj-y				:= main.o version.o mounts.o initramfs.o
 mounts-y			:= do_mounts.o
 mounts-$(CONFIG_DEVFS_FS)	+= do_mounts_devfs.o
 mounts-$(CONFIG_BLK_DEV_RAM)	+= do_mounts_rd.o
 mounts-$(CONFIG_BLK_DEV_MD)	+= do_mounts_md.o
+
+extra-$(CONFIG_CRASH_DUMP)	+= kerntypes.o
+CFLAGS_kerntypes.o		:= -gstabs
 
 # files to be removed upon make clean
 clean-files := ../include/linux/compile.h

