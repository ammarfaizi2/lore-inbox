Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314403AbSGRHgG>; Thu, 18 Jul 2002 03:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315202AbSGRHgG>; Thu, 18 Jul 2002 03:36:06 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:55769 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S314403AbSGRHgC>;
	Thu, 18 Jul 2002 03:36:02 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, sfr@canb.auug.org.au
Subject: [PATCH] Initcall depends automagic
Date: Thu, 18 Jul 2002 17:36:09 +1000
Message-Id: <20020718073932.D82A04164@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch generates initcall ordering based on the theory that if A.o
references a symbol in B.o, then B.o's initcall must preceed A.o's.
Kai and I came up with the approach, and Stephen Rothwell did all the
implementation brain sweat.  I did the typing.

Unfortunately, there are dependency loops in the kernel which make
this approach fail, but if someone wants to play with it and try to
untangle them, they are more than welcome.  One option would be to
look at more course-grained .o files, rather than *all* .o files
(eg. fs/ext2/ext2.o rather than fs/ext2/*.o).

I will be persuing my previous explicit initcall depends patch in the
meantime, as it offers an elegent solution that works now.

Cheers!
Rusty.
PS.  
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.26/Makefile working-2.5.26-initcall/Makefile
--- linux-2.5.26/Makefile	Wed Jul 17 10:25:45 2002
+++ working-2.5.26-initcall/Makefile	Thu Jul 18 16:57:45 2002
@@ -258,6 +258,7 @@
 		$(DRIVERS) \
 		$(NETWORKS) \
 		--end-group \
+		init/generated-initcalls.o \
 		-o vmlinux
 
 #	set -e makes the rule exit immediately on error
@@ -274,7 +275,10 @@
 	$(NM) vmlinux | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > System.map
 endef
 
-vmlinux: $(vmlinux-objs) FORCE
+init/generated-initcalls.c: $(vmlinux-objs) scripts/build-initcalls
+	sh -e scripts/build-initcalls $(OBJDUMP) >$@.tmp && mv $@.tmp $@
+
+vmlinux: $(vmlinux-objs) init/generated-initcalls.o FORCE
 	$(call if_changed_rule,link_vmlinux)
 
 #	The actual objects are generated when descending, 
@@ -585,6 +589,7 @@
 
 #	files removed with 'make clean'
 CLEAN_FILES += \
+	init/generated-initcalls.c init/generated-initcalls.c.tmp \
 	include/linux/compile.h \
 	vmlinux System.map \
 	drivers/char/consolemap_deftbl.c drivers/video/promcon_tbl.c \
@@ -646,7 +651,7 @@
 	@echo 'Cleaning up'
 	@find . -name SCCS -prune -o -name BitKeeper -prune -o \
 		\( -name \*.[oas] -o -name core -o -name .\*.cmd -o \
-		-name .\*.tmp -o -name .\*.d \) -type f -print \
+		-name .\*.tmp -o -name .\*.d -o -name \*.defined -o -name \*.undefined \) -type f -print \
 		| grep -v lxdialog/ | xargs rm -f
 	@rm -f $(CLEAN_FILES)
 	@$(MAKE) -C Documentation/DocBook clean
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.26/include/linux/init.h working-2.5.26-initcall/include/linux/init.h
--- linux-2.5.26/include/linux/init.h	Mon Jun 10 16:03:55 2002
+++ working-2.5.26-initcall/include/linux/init.h	Thu Jul 18 16:16:56 2002
@@ -48,27 +48,23 @@
 typedef int (*initcall_t)(void);
 typedef void (*exitcall_t)(void);
 
-extern initcall_t __initcall_start, __initcall_end;
-
-/* initcalls are now grouped by functionality into separate 
- * subsections. Ordering inside the subsections is determined
- * by link order. 
- * For backwards compatability, initcall() puts the call in 
- * the device init subsection.
- */
+/* initcalls are now magically ordered. */
 
-#define __define_initcall(level,fn) \
-	static initcall_t __initcall_##fn __attribute__ ((unused,__section__ (".initcall" level ".init"))) = fn
+#define core_initcall(fn)		__initcall(fn)
+#define postcore_initcall(fn)		__initcall(fn)
+#define arch_initcall(fn)		__initcall(fn)
+#define subsys_initcall(fn)		__initcall(fn)
+#define fs_initcall(fn)			__initcall(fn)
+#define device_initcall(fn)		__initcall(fn)
+#define late_initcall(fn)		__initcall(fn)
 
-#define core_initcall(fn)		__define_initcall("1",fn)
-#define postcore_initcall(fn)		__define_initcall("2",fn)
-#define arch_initcall(fn)		__define_initcall("3",fn)
-#define subsys_initcall(fn)		__define_initcall("4",fn)
-#define fs_initcall(fn)			__define_initcall("5",fn)
-#define device_initcall(fn)		__define_initcall("6",fn)
-#define late_initcall(fn)		__define_initcall("7",fn)
+#define __CAT3(a,b,c) a##b##c
+#define _CAT3(a,b,c) __CAT3(a,b,c)
 
-#define __initcall(fn) device_initcall(fn)
+#define __initcall(fn)							    \
+  int _CAT3(fn,__LINE__,KBUILD_BASENAME)(void) __attribute__((alias(#fn))); \
+  static inline initcall_t _CAT3(fn##test,__LINE__,KBUILD_BASENAME)(void)   \
+	{ return fn; }
 
 #define __exitcall(fn)								\
 	static exitcall_t __exitcall_##fn __exit_call = fn
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.26/init/main.c working-2.5.26-initcall/init/main.c
--- linux-2.5.26/init/main.c	Thu Jun 20 01:28:52 2002
+++ working-2.5.26-initcall/init/main.c	Thu Jul 18 16:03:08 2002
@@ -417,19 +417,7 @@
 
 struct task_struct *child_reaper = &init_task;
 
-static void __init do_initcalls(void)
-{
-	initcall_t *call;
-
-	call = &__initcall_start;
-	do {
-		(*call)();
-		call++;
-	} while (call < &__initcall_end);
-
-	/* Make sure there is no pending stuff from the initcall sequence */
-	flush_scheduled_tasks();
-}
+extern void do_initcalls(void);
 
 /*
  * Ok, the machine is now initialized. None of the devices
@@ -480,7 +468,10 @@
 	sock_init();
 
 	start_context_thread();
+
 	do_initcalls();
+	/* Make sure there is no pending stuff from the initcall sequence */
+	flush_scheduled_tasks();
 }
 
 extern void prepare_namespace(void);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.26/scripts/build-initcalls working-2.5.26-initcall/scripts/build-initcalls
--- linux-2.5.26/scripts/build-initcalls	Thu Jan  1 10:00:00 1970
+++ working-2.5.26-initcall/scripts/build-initcalls	Thu Jul 18 17:15:48 2002
@@ -0,0 +1,43 @@
+#! /bin/sh -e
+
+# If object file A uses a symbol from object file B, then call B's
+# initcalls before A's.
+OBJDUMP=$1
+
+DEFINED_FILE=.defined.all
+UNDEFINED_FILE=.undefined.all
+TMPFILE=.initcalls.sort.all
+#trap 'echo Exiting... >&2; rm -f "$DEFINED_FILE" "$UNDEFINED_FILE" "$TMPFILE"' 0
+
+# These are too hard!
+#TOOHARD="printk\|ext2_error"
+
+rm $DEFINED_FILE $UNDEFINED_FILE
+
+# Create file with "foo.o  symbol-defined-in-foo.o" lines into defined file,
+# "foo.o  symbol-required-by-foo.o" lines into undefined file.
+find . -name '*.defs' | while read f; do
+    objf=$(echo "$f" | sed 's/\.defs//')
+    awk "/^T/ { print \$2, \"$objf\" >> \"$DEFINED_FILE\"} \
+	/^U/ { print \$2, \"$objf\" >> \"$UNDEFINED_FILE\"}" $f
+done
+
+# Generate output
+echo "/* Auto-generated by build-initcalls: DO NOT EDIT. */"
+echo "#include <linux/init.h>"
+echo ""
+echo "void __init do_initcalls(void)"
+echo "{"
+
+# Sort before join.
+sort $DEFINED_FILE | grep -v '^'"$TOOHARD"' ' > $TMPFILE
+mv -f $TMPFILE $DEFINED_FILE
+sort $UNDEFINED_FILE > $TMPFILE
+mv -f $TMPFILE $UNDEFINED_FILE
+
+# Everybody loves join (but tsort can fail)
+join -o "1.2 2.2" $DEFINED_FILE $UNDEFINED_FILE | sort -u | tsort > $TMPFILE
+
+xargs $OBJDUMP -t < $TMPFILE | awk '/O[		]\.initcall\.init/ { print "	" $NF "();" }'
+
+echo "}"

================
Here is the output from a 2.5.26 build:

sh -e scripts/build-initcalls objdump >init/generated-initcalls.c.tmp && mv init/generated-initcalls.c.tmp init/generated-initcalls.c
tsort: input contains a loop:

tsort: ./fs/ext2/super.o
tsort: ./fs/ext2/inode.o
tsort: ./fs/ext2/fsync.o
tsort: ./fs/ext2/dir.o
tsort: ./fs/ext2/namei.o
tsort: ./fs/ext2/ialloc.o
tsort: ./fs/ext2/balloc.o
tsort: input contains a loop:

tsort: ./arch/i386/kernel/apic.o
tsort: ./fs/proc/proc_misc.o
tsort: ./fs/proc/root.o
tsort: ./init/main.o
tsort: ./arch/i386/kernel/smpboot.o
tsort: ./arch/i386/kernel/setup.o
tsort: ./arch/i386/kernel/head.o
tsort: ./mm/memory.o
tsort: ./mm/vmalloc.o
tsort: ./mm/swapfile.o
tsort: ./mm/vmscan.o
tsort: ./mm/page_alloc.o
tsort: ./net/ipv4/tcp_ipv4.o
tsort: ./net/ipv4/tcp_timer.o
tsort: ./net/ipv4/tcp_minisocks.o
tsort: ./net/ipv4/tcp_input.o
tsort: ./net/ipv4/tcp_output.o
tsort: ./net/ipv4/tcp.o
tsort: ./net/ipv4/af_inet.o
tsort: ./net/ipv4/udp.o
tsort: ./net/ipv4/raw.o
tsort: ./net/ipv4/ip_input.o
tsort: ./net/ipv4/route.o
tsort: ./net/ipv4/syncookies.o
tsort: ./net/ipv4/ip_output.o
tsort: ./net/ipv4/ip_options.o
tsort: ./net/ipv4/ip_sockglue.o
tsort: ./net/ipv4/ip_forward.o
tsort: ./net/ipv4/icmp.o
tsort: ./net/ipv4/protocol.o
tsort: ./net/ipv4/ip_fragment.o
tsort: ./net/ipv4/igmp.o
tsort: ./net/ipv4/devinet.o
tsort: ./net/ipv4/fib_semantics.o
tsort: ./net/ipv4/ip_nat_dumb.o
tsort: ./net/ipv4/fib_hash.o
tsort: ./net/ipv4/fib_frontend.o
tsort: ./net/ipv4/fib_rules.o
tsort: ./net/ipv4/arp.o
tsort: ./net/core/netfilter.o
tsort: ./net/socket.o
tsort: ./net/netlink/af_netlink.o
tsort: ./net/ipv4/tcp_diag.o
tsort: ./net/core/wireless.o
tsort: ./net/core/dev.o
tsort: ./net/sched/sch_generic.o
tsort: ./net/core/sock.o
tsort: ./net/core/filter.o
tsort: ./net/core/rtnetlink.o
tsort: ./net/core/neighbour.o
tsort: ./net/core/dst.o
tsort: ./net/ipv4/proc.o
tsort: ./net/core/iovec.o
tsort: ./net/core/datagram.o
tsort: ./fs/fcntl.o
tsort: ./kernel/futex.o
tsort: ./arch/i386/kernel/entry.o
tsort: ./arch/i386/kernel/vm86.o
tsort: ./arch/i386/kernel/traps.o
tsort: ./kernel/sched.o
tsort: ./mm/shmem.o
tsort: ./mm/mmap.o
tsort: ./mm/msync.o
tsort: ./mm/mremap.o
tsort: ./mm/mprotect.o
tsort: ./mm/mlock.o
tsort: ./mm/mincore.o
tsort: ./mm/filemap.o
tsort: ./mm/swap_state.o
tsort: ./mm/readahead.o
tsort: ./mm/page_io.o
tsort: ./mm/page-writeback.o
tsort: ./mm/mempool.o
tsort: ./mm/highmem.o
tsort: ./drivers/block/ll_rw_blk.o
tsort: ./fs/super.o
tsort: ./fs/ramfs/inode.o
tsort: ./fs/namespace.o
tsort: ./kernel/kmod.o
tsort: ./kernel/module.o
tsort: ./kernel/exec_domain.o
tsort: ./fs/open.o
tsort: ./net/core/scm.o
tsort: ./kernel/uid16.o
tsort: ./kernel/exit.o
tsort: ./mm/pdflush.o
tsort: ./kernel/sys.o
tsort: ./kernel/sysctl.o
tsort: ./fs/dquot.o
tsort: ./fs/inode.o
tsort: ./ipc/shm.o
tsort: ./ipc/util.o
tsort: ./ipc/sem.o
tsort: ./kernel/fork.o
tsort: ./kernel/ptrace.o
tsort: ./fs/proc/base.o
tsort: ./fs/proc/inode.o
tsort: ./fs/proc/generic.o
tsort: ./net/core/dev_mcast.o
tsort: ./ipc/msg.o
tsort: ./arch/i386/kernel/sys_i386.o
tsort: ./fs/proc/proc_tty.o
tsort: ./drivers/char/tty_io.o
tsort: ./fs/devices.o
tsort: ./init/do_mounts.o
tsort: ./fs/locks.o
tsort: ./fs/read_write.o
tsort: ./fs/pipe.o
tsort: ./fs/namei.o
tsort: ./fs/xattr.o
tsort: ./fs/stat.o
tsort: ./fs/quota.o
tsort: ./fs/filesystems.o
tsort: ./fs/driverfs/inode.o
tsort: ./drivers/base/fs.o
tsort: ./fs/partitions/check.o
tsort: ./fs/partitions/msdos.o
tsort: ./drivers/ide/main.o
tsort: ./drivers/ide/probe.o
tsort: ./drivers/ide/ioctl.o
tsort: ./drivers/ide/ide.o
tsort: ./drivers/ide/ide-taskfile.o
tsort: ./drivers/ide/ide-disk.o
tsort: ./drivers/ide/device.o
tsort: ./drivers/block/genhd.o
tsort: ./fs/block_dev.o
tsort: ./fs/devfs/base.o
tsort: ./fs/devfs/util.o
tsort: ./drivers/char/vc_screen.o
tsort: ./drivers/char/console.o
tsort: ./lib/bust_spinlocks.o
tsort: ./kernel/panic.o
tsort: ./net/core/skbuff.o
tsort: ./mm/oom_kill.o
tsort: ./mm/bootmem.o
tsort: ./arch/i386/mm/init.o
tsort: ./drivers/char/sysrq.o
tsort: ./drivers/char/serial.o
tsort: ./drivers/char/keyboard.o
tsort: ./drivers/char/vt.o
tsort: ./drivers/char/pc_keyb.o
tsort: ./arch/i386/kernel/dmi_scan.o
tsort: ./arch/i386/mm/ioremap.o
tsort: ./arch/i386/kernel/mpparse.o
tsort: ./lib/radix-tree.o
tsort: ./kernel/user.o
tsort: ./kernel/signal.o
tsort: ./kernel/timer.o
tsort: ./net/ipv4/inetpeer.o
tsort: ./kernel/itimer.o
tsort: ./fs/select.o
tsort: ./drivers/char/random.o
tsort: ./arch/i386/kernel/irq.o
tsort: ./drivers/char/tty_ioctl.o
tsort: ./drivers/char/n_tty.o
tsort: ./arch/i386/kernel/time.o
tsort: ./kernel/time.o
tsort: ./arch/i386/kernel/process.o
tsort: ./kernel/softirq.o
tsort: ./kernel/context.o
tsort: ./arch/i386/kernel/bluesmoke.o
tsort: ./arch/i386/kernel/cpu/common.o
tsort: ./arch/i386/kernel/cpu/transmeta.o
tsort: ./arch/i386/kernel/cpu/nexgen.o
tsort: ./arch/i386/kernel/cpu/intel.o
tsort: ./arch/i386/kernel/cpu/cyrix.o
tsort: ./arch/i386/kernel/cpu/centaur.o
tsort: ./arch/i386/kernel/cpu/amd.o
tsort: ./fs/proc/array.o
tsort: ./fs/exec.o
tsort: ./arch/i386/kernel/nmi.o
tsort: ./arch/i386/kernel/io_apic.o
tsort: ./arch/i386/kernel/i8259.o
tsort: ./drivers/pci/pci.o
tsort: ./drivers/pci/setup-res.o
tsort: ./drivers/pci/quirks.o
tsort: ./drivers/pci/probe.o
tsort: ./arch/i386/pci/common.o
tsort: ./arch/i386/pci/i386.o
tsort: ./drivers/ide/ide-pci.o
tsort: ./fs/buffer.o
tsort: ./fs/mpage.o
tsort: ./fs/fs-writeback.o
tsort: ./fs/attr.o
tsort: ./fs/direct-io.o
tsort: ./drivers/block/blkpg.o
tsort: ./arch/i386/mm/fault.o
tsort: ./arch/i386/kernel/signal.o
tsort: ./arch/i386/kernel/ptrace.o
tsort: ./fs/dnotify.o
tsort: ./fs/dcache.o
tsort: ./fs/libfs.o
tsort: ./fs/file_table.o
tsort: ./fs/readdir.o
tsort: ./fs/ioctl.o
tsort: ./fs/char_dev.o
tsort: ./fs/bio.o
tsort: ./drivers/char/pty.o
tsort: ./drivers/base/core.o
tsort: ./drivers/base/sys.o
tsort: ./drivers/base/power.o
tsort: ./drivers/base/driver.o
tsort: ./drivers/pci/pci-driver.o
tsort: ./drivers/base/bus.o
tsort: ./arch/i386/kernel/mtrr.o
tsort: ./drivers/char/selection.o
tsort: ./drivers/char/consolemap.o
tsort: ./drivers/char/misc.o
tsort: ./fs/bad_inode.o
tsort: ./kernel/printk.o
tsort: ./net/core/utils.o
tsort: ./mm/slab.o
tsort: ./kernel/resource.o
tsort: ./kernel/pm.o
tsort: ./fs/seq_file.o
tsort: ./fs/iobuf.o
tsort: ./fs/file.o
tsort: ./drivers/block/elevator.o
tsort: ./arch/i386/pci/pcbios.o
tsort: ./arch/i386/mm/pageattr.o
tsort: ./arch/i386/kernel/ldt.o
tsort: ./arch/i386/kernel/ioport.o
tsort: ./kernel/dma.o
tsort: ./arch/i386/kernel/cpu/rise.o
tsort: ./drivers/block/block_ioctl.o
tsort: ./lib/rwsem.o
tsort: ./arch/i386/kernel/semaphore.o
tsort: ./lib/brlock.o
tsort: ./kernel/capability.o
tsort: ./arch/i386/kernel/smp.o
make: *** [init/generated-initcalls.c] Error 1

Compilation exited abnormally with code 2 at Thu Jul 18 17:16:55
