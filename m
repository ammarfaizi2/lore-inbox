Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262183AbVDFL77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbVDFL77 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 07:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbVDFL77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 07:59:59 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:62399 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262177AbVDFLrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 07:47:12 -0400
Message-Id: <20050406114653.064745000@faui31y>
References: <20050406114610.287064000@faui31y>
Date: Wed, 06 Apr 2005 13:46:11 +0200
From: Martin Waitz <tali@admingilde.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 1/6] DocBook: changes and extensions to the kernel documentation
Content-Disposition: inline; filename=some-changes-and-extensions-to-the-kernel-documentation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DocBook: changes and extensions to the kernel documentation

From: Pavel Pisa <pisa@cmp.felk.cvut.cz>

I have recompiled Linux kernel 2.6.11.5 documentation for me and our
university students again.  The documentation could be extended for more
sources which are equipped by structured comments for recent 2.6 kernels. 
I have tried to proceed with that task.  I have done that more times from
2.6.0 time and it gets boring to do same changes again and again.  Linux
kernel compiles after changes for i386 and ARM targets.  I have added
references to some more files into kernel-api book, I have added some
section names as well.  So please, check that changes do not break
something and that categories are not too much skewed.

I have changed kernel-doc to accept "fastcall" and "asmlinkage" words
reserved by kernel convention.  Most of the other changes are modifications
in the comments to make kernel-doc happy, accept some parameters
description and do not bail out on errors.  Changed <pid> to @pid in the
description, moved some #ifdef before comments to correct function to
comments bindings, etc.

You can see result of the modified documentation build at
  http://cmp.felk.cvut.cz/~pisa/linux/lkdb-2.6.11.tar.gz

Some more sources are ready to be included into kernel-doc generated
documentation.  Sources has been added into kernel-api for now.  Some more
section names added and probably some more chaos introduced as result of
quick cleanup work.

Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Martin Waitz <tali@admingilde.org>

 Documentation/DocBook/kernel-api.tmpl |  186 ++++++++++++++++++++++++++++++++--
 drivers/video/fbmem.c                 |    5 
 fs/proc/base.c                        |   10 -
 include/linux/fs.h                    |   12 +-
 include/linux/net.h                   |   38 +++---
 include/linux/skbuff.h                |    2 
 include/net/sock.h                    |  134 ++++++++++++------------
 kernel/exit.c                         |    2 
 kernel/power/swsusp.c                 |    2 
 mm/page_alloc.c                       |    3 
 mm/vmalloc.c                          |    8 -
 net/core/datagram.c                   |   28 ++---
 net/core/sock.c                       |   12 +-
 net/core/stream.c                     |   12 +-
 net/sunrpc/xdr.c                      |   12 +-
 scripts/kernel-doc                    |    2 
 16 files changed, 320 insertions(+), 148 deletions(-)

Index: linux-docbook/Documentation/DocBook/kernel-api.tmpl
===================================================================
--- linux-docbook.orig/Documentation/DocBook/kernel-api.tmpl	2005-04-06 12:13:12.673832313 +0200
+++ linux-docbook/Documentation/DocBook/kernel-api.tmpl	2005-04-06 12:24:11.943114418 +0200
@@ -49,13 +49,33 @@
 !Iinclude/asm-i386/unaligned.h
      </sect1>
 
-<!-- FIXME:
-  kernel/sched.c has no docs, which stuffs up the sgml.  Comment
-  out until somebody adds docs.  KAO
      <sect1><title>Delaying, scheduling, and timer routines</title>
-X!Ekernel/sched.c
+!Iinclude/linux/sched.h
+!Ekernel/sched.c
+!Ekernel/timer.c
+     </sect1>
+     <sect1><title>Internal Functions</title>
+!Ikernel/exit.c
+!Ikernel/signal.c
      </sect1>
-KAO -->
+
+     <sect1><title>Kernel objects manipulation</title>
+<!--
+X!Iinclude/linux/kobject.h
+-->
+!Elib/kobject.c
+     </sect1>
+
+     <sect1><title>Kernel utility functions</title>
+!Iinclude/linux/kernel.h
+<!-- This needs to clean up to make kernel-doc happy
+X!Ekernel/printk.c
+ -->
+!Ekernel/panic.c
+!Ekernel/sys.c
+!Ekernel/rcupdate.c
+     </sect1>
+
   </chapter>
 
   <chapter id="adt">
@@ -81,7 +101,9 @@ KAO -->
 !Elib/vsprintf.c
      </sect1>
      <sect1><title>String Manipulation</title>
-!Ilib/string.c
+<!-- All functions are exported at now
+X!Ilib/string.c
+ -->
 !Elib/string.c
      </sect1>
      <sect1><title>Bit Operations</title>
@@ -98,6 +120,25 @@ KAO -->
 !Iinclude/asm-i386/uaccess.h
 !Iarch/i386/lib/usercopy.c
      </sect1>
+     <sect1><title>More Memory Management Functions</title>
+!Iinclude/linux/rmap.h
+!Emm/readahead.c
+!Emm/filemap.c
+!Emm/memory.c
+!Emm/vmalloc.c
+!Emm/mempool.c
+!Emm/page-writeback.c
+!Emm/truncate.c
+     </sect1>
+  </chapter>
+
+
+  <chapter id="ipc">
+     <title>Kernel IPC facilities</title>
+
+     <sect1><title>IPC utilities</title>
+!Iipc/util.c
+     </sect1>
   </chapter>
 
   <chapter id="kfifo">
@@ -114,6 +155,10 @@ KAO -->
      <sect1><title>sysctl interface</title>
 !Ekernel/sysctl.c
      </sect1>
+
+     <sect1><title>proc filesystem interface</title>
+!Ifs/proc/base.c
+     </sect1>
   </chapter>
 
   <chapter id="debugfs">
@@ -127,6 +172,10 @@ KAO -->
 
   <chapter id="vfs">
      <title>The Linux VFS</title>
+     <sect1><title>The Filesystem types</title>
+!Iinclude/linux/fs.h
+!Einclude/linux/fs.h
+     </sect1>
      <sect1><title>The Directory Cache</title>
 !Efs/dcache.c
 !Iinclude/linux/dcache.h
@@ -142,13 +191,31 @@ KAO -->
 !Efs/locks.c
 !Ifs/locks.c
      </sect1>
+     <sect1><title>Other Functions</title>
+!Efs/mpage.c
+!Efs/namei.c
+!Efs/buffer.c
+!Efs/bio.c
+!Efs/seq_file.c
+!Efs/filesystems.c
+!Efs/fs-writeback.c
+!Efs/block_dev.c
+     </sect1>
   </chapter>
 
   <chapter id="netcore">
      <title>Linux Networking</title>
+     <sect1><title>Networking Base Types</title>
+!Iinclude/linux/net.h
+     </sect1>
      <sect1><title>Socket Buffer Functions</title>
 !Iinclude/linux/skbuff.h
+!Iinclude/net/sock.h
+!Enet/socket.c
 !Enet/core/skbuff.c
+!Enet/core/sock.c
+!Enet/core/datagram.c
+!Enet/core/stream.c
      </sect1>
      <sect1><title>Socket Filter</title>
 !Enet/core/filter.c
@@ -158,6 +225,14 @@ KAO -->
 !Enet/core/gen_stats.c
 !Enet/core/gen_estimator.c
      </sect1>
+     <sect1><title>SUN RPC subsystem</title>
+<!-- The !D functionality is not perfect, garbage has to be protected by comments
+!Dnet/sunrpc/sunrpc_syms.c
+-->
+!Enet/sunrpc/xdr.c
+!Enet/sunrpc/svcsock.c
+!Enet/sunrpc/sched.c
+     </sect1>
   </chapter>
 
   <chapter id="netdev">
@@ -194,11 +269,26 @@ X!Ekernel/module.c
 !Iarch/i386/kernel/irq.c
      </sect1>
 
+     <sect1><title>Resources Management</title>
+!Ekernel/resource.c
+     </sect1>
+
      <sect1><title>MTRR Handling</title>
 !Earch/i386/kernel/cpu/mtrr/main.c
      </sect1>
      <sect1><title>PCI Support Library</title>
 !Edrivers/pci/pci.c
+!Edrivers/pci/pci-driver.c
+!Edrivers/pci/remove.c
+!Edrivers/pci/pci-acpi.c
+<!-- kerneldoc does not understand to __devinit
+X!Edrivers/pci/search.c
+ -->
+!Edrivers/pci/msi.c
+!Edrivers/pci/bus.c
+!Edrivers/pci/hotplug.c
+!Edrivers/pci/probe.c
+!Edrivers/pci/rom.c
      </sect1>
      <sect1><title>PCI Hotplug Support Library</title>
 !Edrivers/pci/hotplug/pci_hotplug_core.c
@@ -223,6 +313,14 @@ X!Earch/i386/kernel/mca.c
 !Efs/devfs/base.c
   </chapter>
 
+  <chapter id="sysfs">
+     <title>The Filesystem for Exporting Kernel Objects</title>
+!Efs/sysfs/file.c
+!Efs/sysfs/dir.c
+!Efs/sysfs/symlink.c
+!Efs/sysfs/bin.c
+  </chapter>
+
   <chapter id="security">
      <title>Security Framework</title>
 !Esecurity/security.c
@@ -233,6 +331,61 @@ X!Earch/i386/kernel/mca.c
 !Ekernel/power/pm.c
   </chapter>
 
+  <chapter id="devdrivers">
+     <title>Device drivers infrastructure</title>
+     <sect1><title>Device Drivers Base</title>
+<!--
+X!Iinclude/linux/device.h
+-->
+!Edrivers/base/driver.c
+!Edrivers/base/class_simple.c
+!Edrivers/base/core.c
+!Edrivers/base/firmware_class.c
+!Edrivers/base/transport_class.c
+!Edrivers/base/dmapool.c
+<!-- Cannot be included, because
+     attribute_container_add_class_device_adapter
+ and attribute_container_classdev_to_container
+     exceed allowed 44 characters maximum
+X!Edrivers/base/attribute_container.c
+-->
+!Edrivers/base/sys.c
+<!--
+X!Edrivers/base/interface.c
+-->
+!Edrivers/base/platform.c
+!Edrivers/base/bus.c
+     </sect1>
+     <sect1><title>Device Drivers Power Management</title>
+!Edrivers/base/power/main.c
+!Edrivers/base/power/resume.c
+!Edrivers/base/power/suspend.c
+     </sect1>
+     <sect1><title>Device Drivers ACPI Support</title>
+<!-- Internal functions only
+X!Edrivers/acpi/sleep/main.c
+X!Edrivers/acpi/sleep/wakeup.c
+X!Edrivers/acpi/motherboard.c
+X!Edrivers/acpi/bus.c
+-->
+!Edrivers/acpi/scan.c
+<!-- No correct structured comments
+X!Edrivers/acpi/pci_bind.c
+-->
+     </sect1>
+     <sect1><title>Device drivers PnP support</title>
+!Edrivers/pnp/core.c
+<!-- No correct structured comments
+X!Edrivers/pnp/system.c
+ -->
+!Edrivers/pnp/card.c
+!Edrivers/pnp/driver.c
+!Edrivers/pnp/manager.c
+!Edrivers/pnp/support.c
+     </sect1>
+  </chapter>
+
+
   <chapter id="blkdev">
      <title>Block Devices</title>
 !Edrivers/block/ll_rw_blk.c
@@ -250,7 +403,23 @@ X!Earch/i386/kernel/mca.c
 
   <chapter id="snddev">
      <title>Sound Devices</title>
+!Iinclude/sound/core.h
 !Esound/sound_core.c
+!Iinclude/sound/pcm.h
+!Esound/core/pcm.c
+!Esound/core/device.c
+!Esound/core/info.c
+!Esound/core/rawmidi.c
+!Esound/core/sound.c
+!Esound/core/memory.c
+!Esound/core/pcm_memory.c
+!Esound/core/init.c
+!Esound/core/isadma.c
+!Esound/core/control.c
+!Esound/core/pcm_lib.c
+!Esound/core/hwdep.c
+!Esound/core/pcm_native.c
+!Esound/core/memalloc.c
 <!-- FIXME: Removed for now since no structured comments in source
 X!Isound/sound_firmware.c
 -->
@@ -258,6 +427,7 @@ X!Isound/sound_firmware.c
 
   <chapter id="uart16x50">
      <title>16x50 UART Driver</title>
+!Iinclude/linux/serial_core.h
 !Edrivers/serial/serial_core.c
 !Edrivers/serial/8250.c
   </chapter>
@@ -310,9 +480,11 @@ X!Isound/sound_firmware.c
      <sect1><title>Frame Buffer Memory</title>
 !Edrivers/video/fbmem.c
      </sect1>
+<!--
      <sect1><title>Frame Buffer Console</title>
-!Edrivers/video/console/fbcon.c
+X!Edrivers/video/console/fbcon.c
      </sect1>
+-->
      <sect1><title>Frame Buffer Colormap</title>
 !Edrivers/video/fbcmap.c
      </sect1>
Index: linux-docbook/drivers/video/fbmem.c
===================================================================
--- linux-docbook.orig/drivers/video/fbmem.c	2005-04-06 12:13:12.674832161 +0200
+++ linux-docbook/drivers/video/fbmem.c	2005-04-06 12:24:11.946113964 +0200
@@ -1257,6 +1257,8 @@ int fb_new_modelist(struct fb_info *info
 static char *video_options[FB_MAX];
 static int ofonly;
 
+extern const char *global_mode_option;
+
 /**
  * fb_get_options - get kernel boot parameters
  * @name:   framebuffer name as it would appear in
@@ -1297,9 +1299,6 @@ int fb_get_options(char *name, char **op
 	return retval;
 }
 
-
-extern const char *global_mode_option;
-
 /**
  *	video_setup - process command line options
  *	@options: string of options
Index: linux-docbook/fs/proc/base.c
===================================================================
--- linux-docbook.orig/fs/proc/base.c	2005-04-06 12:13:12.675832010 +0200
+++ linux-docbook/fs/proc/base.c	2005-04-06 12:24:11.948113661 +0200
@@ -1701,13 +1701,13 @@ static struct inode_operations proc_self
 };
 
 /**
- * proc_pid_unhash -  Unhash /proc/<pid> entry from the dcache.
+ * proc_pid_unhash -  Unhash /proc/@pid entry from the dcache.
  * @p: task that should be flushed.
  *
- * Drops the /proc/<pid> dcache entry from the hash chains.
+ * Drops the /proc/@pid dcache entry from the hash chains.
  *
- * Dropping /proc/<pid> entries and detach_pid must be synchroneous,
- * otherwise e.g. /proc/<pid>/exe might point to the wrong executable,
+ * Dropping /proc/@pid entries and detach_pid must be synchroneous,
+ * otherwise e.g. /proc/@pid/exe might point to the wrong executable,
  * if the pid value is immediately reused. This is enforced by
  * - caller must acquire spin_lock(p->proc_lock)
  * - must be called before detach_pid()
@@ -1739,7 +1739,7 @@ struct dentry *proc_pid_unhash(struct ta
 }
 
 /**
- * proc_pid_flush - recover memory used by stale /proc/<pid>/x entries
+ * proc_pid_flush - recover memory used by stale /proc/@pid/x entries
  * @proc_entry: directoy to prune.
  *
  * Shrink the /proc directory that was used by the just killed thread.
Index: linux-docbook/include/linux/fs.h
===================================================================
--- linux-docbook.orig/include/linux/fs.h	2005-04-06 12:13:12.676831859 +0200
+++ linux-docbook/include/linux/fs.h	2005-04-06 12:24:11.951113207 +0200
@@ -1053,12 +1053,12 @@ static inline void file_accessed(struct 
 int sync_inode(struct inode *inode, struct writeback_control *wbc);
 
 /**
- * &export_operations - for nfsd to communicate with file systems
- * decode_fh:      decode a file handle fragment and return a &struct dentry
- * encode_fh:      encode a file handle fragment from a dentry
- * get_name:       find the name for a given inode in a given directory
- * get_parent:     find the parent of a given directory
- * get_dentry:     find a dentry for the inode given a file handle sub-fragment
+ * struct export_operations - for nfsd to communicate with file systems
+ * @decode_fh:      decode a file handle fragment and return a &struct dentry
+ * @encode_fh:      encode a file handle fragment from a dentry
+ * @get_name:       find the name for a given inode in a given directory
+ * @get_parent:     find the parent of a given directory
+ * @get_dentry:     find a dentry for the inode given a file handle sub-fragment
  *
  * Description:
  *    The export_operations structure provides a means for nfsd to communicate
Index: linux-docbook/include/linux/net.h
===================================================================
--- linux-docbook.orig/include/linux/net.h	2005-04-06 12:13:12.676831859 +0200
+++ linux-docbook/include/linux/net.h	2005-04-06 12:24:11.952113056 +0200
@@ -64,19 +64,19 @@ typedef enum {
 #define SOCK_PASSCRED		3
 
 #ifndef ARCH_HAS_SOCKET_TYPES
-/** sock_type - Socket types
- * 
+/**
+ * enum sock_type - Socket types
+ * @SOCK_STREAM: stream (connection) socket
+ * @SOCK_DGRAM: datagram (conn.less) socket
+ * @SOCK_RAW: raw socket
+ * @SOCK_RDM: reliably-delivered message
+ * @SOCK_SEQPACKET: sequential packet socket
+ * @SOCK_PACKET: linux specific way of getting packets at the dev level.
+ *		  For writing rarp and other similar things on the user level.
+ *
  * When adding some new socket type please
  * grep ARCH_HAS_SOCKET_TYPE include/asm-* /socket.h, at least MIPS
  * overrides this enum for binary compat reasons.
- * 
- * @SOCK_STREAM - stream (connection) socket
- * @SOCK_DGRAM - datagram (conn.less) socket
- * @SOCK_RAW - raw socket
- * @SOCK_RDM - reliably-delivered message
- * @SOCK_SEQPACKET - sequential packet socket 
- * @SOCK_PACKET - linux specific way of getting packets at the dev level.
- *		  For writing rarp and other similar things on the user level.
  */
 enum sock_type {
 	SOCK_STREAM	= 1,
@@ -93,15 +93,15 @@ enum sock_type {
 
 /**
  *  struct socket - general BSD socket
- *  @state - socket state (%SS_CONNECTED, etc)
- *  @flags - socket flags (%SOCK_ASYNC_NOSPACE, etc)
- *  @ops - protocol specific socket operations
- *  @fasync_list - Asynchronous wake up list
- *  @file - File back pointer for gc
- *  @sk - internal networking protocol agnostic socket representation
- *  @wait - wait queue for several uses
- *  @type - socket type (%SOCK_STREAM, etc)
- *  @passcred - credentials (used only in Unix Sockets (aka PF_LOCAL))
+ *  @state: socket state (%SS_CONNECTED, etc)
+ *  @flags: socket flags (%SOCK_ASYNC_NOSPACE, etc)
+ *  @ops: protocol specific socket operations
+ *  @fasync_list: Asynchronous wake up list
+ *  @file: File back pointer for gc
+ *  @sk: internal networking protocol agnostic socket representation
+ *  @wait: wait queue for several uses
+ *  @type: socket type (%SOCK_STREAM, etc)
+ *  @passcred: credentials (used only in Unix Sockets (aka PF_LOCAL))
  */
 struct socket {
 	socket_state		state;
Index: linux-docbook/include/linux/skbuff.h
===================================================================
--- linux-docbook.orig/include/linux/skbuff.h	2005-04-06 12:13:12.677831708 +0200
+++ linux-docbook/include/linux/skbuff.h	2005-04-06 12:24:11.954112753 +0200
@@ -974,6 +974,7 @@ static inline void __skb_queue_purge(str
 		kfree_skb(skb);
 }
 
+#ifndef CONFIG_HAVE_ARCH_DEV_ALLOC_SKB
 /**
  *	__dev_alloc_skb - allocate an skbuff for sending
  *	@length: length to allocate
@@ -986,7 +987,6 @@ static inline void __skb_queue_purge(str
  *
  *	%NULL is returned in there is no free memory.
  */
-#ifndef CONFIG_HAVE_ARCH_DEV_ALLOC_SKB
 static inline struct sk_buff *__dev_alloc_skb(unsigned int length,
 					      int gfp_mask)
 {
Index: linux-docbook/include/net/sock.h
===================================================================
--- linux-docbook.orig/include/net/sock.h	2005-04-06 12:13:12.678831557 +0200
+++ linux-docbook/include/net/sock.h	2005-04-06 12:24:11.956112450 +0200
@@ -90,17 +90,17 @@ do {	spin_lock_init(&((__sk)->sk_lock.sl
 struct sock;
 
 /**
-  *	struct sock_common - minimal network layer representation of sockets
-  *	@skc_family - network address family
-  *	@skc_state - Connection state
-  *	@skc_reuse - %SO_REUSEADDR setting
-  *	@skc_bound_dev_if - bound device index if != 0
-  *	@skc_node - main hash linkage for various protocol lookup tables
-  *	@skc_bind_node - bind hash linkage for various protocol lookup tables
-  *	@skc_refcnt - reference count
-  *
-  *	This is the minimal network layer representation of sockets, the header
-  *	for struct sock and struct tcp_tw_bucket.
+ *	struct sock_common - minimal network layer representation of sockets
+ *	@skc_family: network address family
+ *	@skc_state: Connection state
+ *	@skc_reuse: %SO_REUSEADDR setting
+ *	@skc_bound_dev_if: bound device index if != 0
+ *	@skc_node: main hash linkage for various protocol lookup tables
+ *	@skc_bind_node: bind hash linkage for various protocol lookup tables
+ *	@skc_refcnt: reference count
+ *
+ *	This is the minimal network layer representation of sockets, the header
+ *	for struct sock and struct tcp_tw_bucket.
   */
 struct sock_common {
 	unsigned short		skc_family;
@@ -114,60 +114,60 @@ struct sock_common {
 
 /**
   *	struct sock - network layer representation of sockets
-  *	@__sk_common - shared layout with tcp_tw_bucket
-  *	@sk_shutdown - mask of %SEND_SHUTDOWN and/or %RCV_SHUTDOWN
-  *	@sk_userlocks - %SO_SNDBUF and %SO_RCVBUF settings
-  *	@sk_lock -	synchronizer
-  *	@sk_rcvbuf - size of receive buffer in bytes
-  *	@sk_sleep - sock wait queue
-  *	@sk_dst_cache - destination cache
-  *	@sk_dst_lock - destination cache lock
-  *	@sk_policy - flow policy
-  *	@sk_rmem_alloc - receive queue bytes committed
-  *	@sk_receive_queue - incoming packets
-  *	@sk_wmem_alloc - transmit queue bytes committed
-  *	@sk_write_queue - Packet sending queue
-  *	@sk_omem_alloc - "o" is "option" or "other"
-  *	@sk_wmem_queued - persistent queue size
-  *	@sk_forward_alloc - space allocated forward
-  *	@sk_allocation - allocation mode
-  *	@sk_sndbuf - size of send buffer in bytes
-  *	@sk_flags - %SO_LINGER (l_onoff), %SO_BROADCAST, %SO_KEEPALIVE, %SO_OOBINLINE settings
-  *	@sk_no_check - %SO_NO_CHECK setting, wether or not checkup packets
-  *	@sk_route_caps - route capabilities (e.g. %NETIF_F_TSO)
-  *	@sk_lingertime - %SO_LINGER l_linger setting
-  *	@sk_hashent - hash entry in several tables (e.g. tcp_ehash)
-  *	@sk_backlog - always used with the per-socket spinlock held
-  *	@sk_callback_lock - used with the callbacks in the end of this struct
-  *	@sk_error_queue - rarely used
-  *	@sk_prot - protocol handlers inside a network family
-  *	@sk_err - last error
-  *	@sk_err_soft - errors that don't cause failure but are the cause of a persistent failure not just 'timed out'
-  *	@sk_ack_backlog - current listen backlog
-  *	@sk_max_ack_backlog - listen backlog set in listen()
-  *	@sk_priority - %SO_PRIORITY setting
-  *	@sk_type - socket type (%SOCK_STREAM, etc)
-  *	@sk_protocol - which protocol this socket belongs in this network family
-  *	@sk_peercred - %SO_PEERCRED setting
-  *	@sk_rcvlowat - %SO_RCVLOWAT setting
-  *	@sk_rcvtimeo - %SO_RCVTIMEO setting
-  *	@sk_sndtimeo - %SO_SNDTIMEO setting
-  *	@sk_filter - socket filtering instructions
-  *	@sk_protinfo - private area, net family specific, when not using slab
-  *	@sk_timer - sock cleanup timer
-  *	@sk_stamp - time stamp of last packet received
-  *	@sk_socket - Identd and reporting IO signals
-  *	@sk_user_data - RPC layer private data
-  *	@sk_sndmsg_page - cached page for sendmsg
-  *	@sk_sndmsg_off - cached offset for sendmsg
-  *	@sk_send_head - front of stuff to transmit
-  *	@sk_write_pending - a write to stream socket waits to start
-  *	@sk_state_change - callback to indicate change in the state of the sock
-  *	@sk_data_ready - callback to indicate there is data to be processed
-  *	@sk_write_space - callback to indicate there is bf sending space available
-  *	@sk_error_report - callback to indicate errors (e.g. %MSG_ERRQUEUE)
-  *	@sk_backlog_rcv - callback to process the backlog
-  *	@sk_destruct - called at sock freeing time, i.e. when all refcnt == 0
+  *	@__sk_common: shared layout with tcp_tw_bucket
+  *	@sk_shutdown: mask of %SEND_SHUTDOWN and/or %RCV_SHUTDOWN
+  *	@sk_userlocks: %SO_SNDBUF and %SO_RCVBUF settings
+  *	@sk_lock:	synchronizer
+  *	@sk_rcvbuf: size of receive buffer in bytes
+  *	@sk_sleep: sock wait queue
+  *	@sk_dst_cache: destination cache
+  *	@sk_dst_lock: destination cache lock
+  *	@sk_policy: flow policy
+  *	@sk_rmem_alloc: receive queue bytes committed
+  *	@sk_receive_queue: incoming packets
+  *	@sk_wmem_alloc: transmit queue bytes committed
+  *	@sk_write_queue: Packet sending queue
+  *	@sk_omem_alloc: "o" is "option" or "other"
+  *	@sk_wmem_queued: persistent queue size
+  *	@sk_forward_alloc: space allocated forward
+  *	@sk_allocation: allocation mode
+  *	@sk_sndbuf: size of send buffer in bytes
+  *	@sk_flags: %SO_LINGER (l_onoff), %SO_BROADCAST, %SO_KEEPALIVE, %SO_OOBINLINE settings
+  *	@sk_no_check: %SO_NO_CHECK setting, wether or not checkup packets
+  *	@sk_route_caps: route capabilities (e.g. %NETIF_F_TSO)
+  *	@sk_lingertime: %SO_LINGER l_linger setting
+  *	@sk_hashent: hash entry in several tables (e.g. tcp_ehash)
+  *	@sk_backlog: always used with the per-socket spinlock held
+  *	@sk_callback_lock: used with the callbacks in the end of this struct
+  *	@sk_error_queue: rarely used
+  *	@sk_prot: protocol handlers inside a network family
+  *	@sk_err: last error
+  *	@sk_err_soft: errors that don't cause failure but are the cause of a persistent failure not just 'timed out'
+  *	@sk_ack_backlog: current listen backlog
+  *	@sk_max_ack_backlog: listen backlog set in listen()
+  *	@sk_priority: %SO_PRIORITY setting
+  *	@sk_type: socket type (%SOCK_STREAM, etc)
+  *	@sk_protocol: which protocol this socket belongs in this network family
+  *	@sk_peercred: %SO_PEERCRED setting
+  *	@sk_rcvlowat: %SO_RCVLOWAT setting
+  *	@sk_rcvtimeo: %SO_RCVTIMEO setting
+  *	@sk_sndtimeo: %SO_SNDTIMEO setting
+  *	@sk_filter: socket filtering instructions
+  *	@sk_protinfo: private area, net family specific, when not using slab
+  *	@sk_timer: sock cleanup timer
+  *	@sk_stamp: time stamp of last packet received
+  *	@sk_socket: Identd and reporting IO signals
+  *	@sk_user_data: RPC layer private data
+  *	@sk_sndmsg_page: cached page for sendmsg
+  *	@sk_sndmsg_off: cached offset for sendmsg
+  *	@sk_send_head: front of stuff to transmit
+  *	@sk_write_pending: a write to stream socket waits to start
+  *	@sk_state_change: callback to indicate change in the state of the sock
+  *	@sk_data_ready: callback to indicate there is data to be processed
+  *	@sk_write_space: callback to indicate there is bf sending space available
+  *	@sk_error_report: callback to indicate errors (e.g. %MSG_ERRQUEUE)
+  *	@sk_backlog_rcv: callback to process the backlog
+  *	@sk_destruct: called at sock freeing time, i.e. when all refcnt == 0
  */
 struct sock {
 	/*
@@ -1223,8 +1223,8 @@ sock_recv_timestamp(struct msghdr *msg, 
 
 /**
  * sk_eat_skb - Release a skb if it is no longer needed
- * @sk - socket to eat this skb from
- * @skb - socket buffer to eat
+ * @sk: socket to eat this skb from
+ * @skb: socket buffer to eat
  *
  * This routine must be called with interrupts disabled or with the socket
  * locked so that the sk_buff queue operation is ok.
Index: linux-docbook/kernel/exit.c
===================================================================
--- linux-docbook.orig/kernel/exit.c	2005-04-06 12:13:12.678831557 +0200
+++ linux-docbook/kernel/exit.c	2005-04-06 12:24:11.958112148 +0200
@@ -209,7 +209,7 @@ static inline int has_stopped_jobs(int p
 }
 
 /**
- * reparent_to_init() - Reparent the calling kernel thread to the init task.
+ * reparent_to_init - Reparent the calling kernel thread to the init task.
  *
  * If a kernel thread is launched as a result of a system call, or if
  * it ever exits, it should generally reparent itself to init so that
Index: linux-docbook/kernel/power/swsusp.c
===================================================================
--- linux-docbook.orig/kernel/power/swsusp.c	2005-04-06 12:13:12.679831405 +0200
+++ linux-docbook/kernel/power/swsusp.c	2005-04-06 12:24:11.959111996 +0200
@@ -1099,7 +1099,7 @@ static struct pbe * swsusp_pagedir_reloc
 	return pblist;
 }
 
-/**
+/*
  *	Using bio to read from swap.
  *	This code requires a bit more work than just using buffer heads
  *	but, it is the recommended way for 2.5/2.6.
Index: linux-docbook/mm/page_alloc.c
===================================================================
--- linux-docbook.orig/mm/page_alloc.c	2005-04-06 12:13:12.680831254 +0200
+++ linux-docbook/mm/page_alloc.c	2005-04-06 12:24:11.962111542 +0200
@@ -1351,8 +1351,7 @@ static int __init build_zonelists_node(p
 #define MAX_NODE_LOAD (num_online_nodes())
 static int __initdata node_load[MAX_NUMNODES];
 /**
- * find_next_best_node - find the next node that should appear in a given
- *    node's fallback list
+ * find_next_best_node - find the next node that should appear in a given node's fallback list
  * @node: node whose fallback list we're appending
  * @used_node_mask: nodemask_t of already used nodes
  *
Index: linux-docbook/mm/vmalloc.c
===================================================================
--- linux-docbook.orig/mm/vmalloc.c	2005-04-06 12:13:12.680831254 +0200
+++ linux-docbook/mm/vmalloc.c	2005-04-06 12:24:11.963111391 +0200
@@ -475,6 +475,10 @@ void *vmalloc(unsigned long size)
 
 EXPORT_SYMBOL(vmalloc);
 
+#ifndef PAGE_KERNEL_EXEC
+# define PAGE_KERNEL_EXEC PAGE_KERNEL
+#endif
+
 /**
  *	vmalloc_exec  -  allocate virtually contiguous, executable memory
  *
@@ -488,10 +492,6 @@ EXPORT_SYMBOL(vmalloc);
  *	use __vmalloc() instead.
  */
 
-#ifndef PAGE_KERNEL_EXEC
-# define PAGE_KERNEL_EXEC PAGE_KERNEL
-#endif
-
 void *vmalloc_exec(unsigned long size)
 {
 	return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL_EXEC);
Index: linux-docbook/net/core/datagram.c
===================================================================
--- linux-docbook.orig/net/core/datagram.c	2005-04-06 12:13:12.681831103 +0200
+++ linux-docbook/net/core/datagram.c	2005-04-06 12:24:11.964111239 +0200
@@ -115,10 +115,10 @@ out_noerr:
 
 /**
  *	skb_recv_datagram - Receive a datagram skbuff
- *	@sk - socket
- *	@flags - MSG_ flags
- *	@noblock - blocking operation?
- *	@err - error code returned
+ *	@sk: socket
+ *	@flags: MSG_ flags
+ *	@noblock: blocking operation?
+ *	@err: error code returned
  *
  *	Get a datagram skbuff, understands the peeking, nonblocking wakeups
  *	and possible races. This replaces identical code in packet, raw and
@@ -201,10 +201,10 @@ void skb_free_datagram(struct sock *sk, 
 
 /**
  *	skb_copy_datagram_iovec - Copy a datagram to an iovec.
- *	@skb - buffer to copy
- *	@offset - offset in the buffer to start copying from
- *	@iovec - io vector to copy to
- *	@len - amount of data to copy from buffer to iovec
+ *	@skb: buffer to copy
+ *	@offset: offset in the buffer to start copying from
+ *	@iovec: io vector to copy to
+ *	@len: amount of data to copy from buffer to iovec
  *
  *	Note: the iovec is modified during the copy.
  */
@@ -377,9 +377,9 @@ fault:
 
 /**
  *	skb_copy_and_csum_datagram_iovec - Copy and checkum skb to user iovec.
- *	@skb - skbuff
- *	@hlen - hardware length
- *	@iovec - io vector
+ *	@skb: skbuff
+ *	@hlen: hardware length
+ *	@iovec: io vector
  * 
  *	Caller _must_ check that skb will fit to this iovec.
  *
@@ -425,9 +425,9 @@ fault:
 
 /**
  * 	datagram_poll - generic datagram poll
- *	@file - file struct
- *	@sock - socket
- *	@wait - poll table
+ *	@file: file struct
+ *	@sock: socket
+ *	@wait: poll table
  *
  *	Datagram poll: Again totally generic. This also handles
  *	sequenced packet sockets providing the socket receive queue
Index: linux-docbook/net/core/sock.c
===================================================================
--- linux-docbook.orig/net/core/sock.c	2005-04-06 12:13:12.682830952 +0200
+++ linux-docbook/net/core/sock.c	2005-04-06 12:24:11.966110937 +0200
@@ -617,10 +617,10 @@ lenout:
 
 /**
  *	sk_alloc - All socket objects are allocated here
- *	@family - protocol family
- *	@priority - for allocation (%GFP_KERNEL, %GFP_ATOMIC, etc)
- *	@prot - struct proto associated with this new sock instance
- *	@zero_it - if we should zero the newly allocated sock
+ *	@family: protocol family
+ *	@priority: for allocation (%GFP_KERNEL, %GFP_ATOMIC, etc)
+ *	@prot: struct proto associated with this new sock instance
+ *	@zero_it: if we should zero the newly allocated sock
  */
 struct sock *sk_alloc(int family, int priority, struct proto *prot, int zero_it)
 {
@@ -968,8 +968,8 @@ static void __release_sock(struct sock *
 
 /**
  * sk_wait_data - wait for data to arrive at sk_receive_queue
- * sk - sock to wait on
- * timeo - for how long
+ * @sk:    sock to wait on
+ * @timeo: for how long
  *
  * Now socket state including sk->sk_err is changed only under lock,
  * hence we may omit checks after joining wait queue.
Index: linux-docbook/net/core/stream.c
===================================================================
--- linux-docbook.orig/net/core/stream.c	2005-04-06 12:13:12.682830952 +0200
+++ linux-docbook/net/core/stream.c	2005-04-06 12:24:11.966110937 +0200
@@ -21,7 +21,7 @@
 
 /**
  * sk_stream_write_space - stream socket write_space callback.
- * sk - socket
+ * @sk: socket
  *
  * FIXME: write proper description
  */
@@ -43,8 +43,8 @@ EXPORT_SYMBOL(sk_stream_write_space);
 
 /**
  * sk_stream_wait_connect - Wait for a socket to get into the connected state
- * @sk - sock to wait on
- * @timeo_p - for how long to wait
+ * @sk: sock to wait on
+ * @timeo_p: for how long to wait
  *
  * Must be called with the socket locked.
  */
@@ -79,7 +79,7 @@ EXPORT_SYMBOL(sk_stream_wait_connect);
 
 /**
  * sk_stream_closing - Return 1 if we still have things to send in our buffers.
- * @sk - socket to verify
+ * @sk: socket to verify
  */
 static inline int sk_stream_closing(struct sock *sk)
 {
@@ -107,8 +107,8 @@ EXPORT_SYMBOL(sk_stream_wait_close);
 
 /**
  * sk_stream_wait_memory - Wait for more memory for a socket
- * @sk - socket to wait for memory
- * @timeo_p - for how long
+ * @sk: socket to wait for memory
+ * @timeo_p: for how long
  */
 int sk_stream_wait_memory(struct sock *sk, long *timeo_p)
 {
Index: linux-docbook/net/sunrpc/xdr.c
===================================================================
--- linux-docbook.orig/net/sunrpc/xdr.c	2005-04-06 12:13:12.683830800 +0200
+++ linux-docbook/net/sunrpc/xdr.c	2005-04-06 12:24:11.968110634 +0200
@@ -46,9 +46,9 @@ xdr_decode_netobj(u32 *p, struct xdr_net
 
 /**
  * xdr_encode_opaque_fixed - Encode fixed length opaque data
- * @p - pointer to current position in XDR buffer.
- * @ptr - pointer to data to encode (or NULL)
- * @nbytes - size of data.
+ * @p: pointer to current position in XDR buffer.
+ * @ptr: pointer to data to encode (or NULL)
+ * @nbytes: size of data.
  *
  * Copy the array of data of length nbytes at ptr to the XDR buffer
  * at position p, then align to the next 32-bit boundary by padding
@@ -76,9 +76,9 @@ EXPORT_SYMBOL(xdr_encode_opaque_fixed);
 
 /**
  * xdr_encode_opaque - Encode variable length opaque data
- * @p - pointer to current position in XDR buffer.
- * @ptr - pointer to data to encode (or NULL)
- * @nbytes - size of data.
+ * @p: pointer to current position in XDR buffer.
+ * @ptr: pointer to data to encode (or NULL)
+ * @nbytes: size of data.
  *
  * Returns the updated current XDR buffer position
  */
Index: linux-docbook/scripts/kernel-doc
===================================================================
--- linux-docbook.orig/scripts/kernel-doc	2005-04-06 12:13:12.684830649 +0200
+++ linux-docbook/scripts/kernel-doc	2005-04-06 12:24:11.970110331 +0200
@@ -1465,6 +1465,8 @@ sub dump_function($$) {
 
     $prototype =~ s/^static +//;
     $prototype =~ s/^extern +//;
+    $prototype =~ s/^fastcall +//;
+    $prototype =~ s/^asmlinkage +//;
     $prototype =~ s/^inline +//;
     $prototype =~ s/^__inline__ +//;
     $prototype =~ s/^#define +//; #ak added

--
Martin Waitz
