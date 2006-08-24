Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbWHXP3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbWHXP3Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 11:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965064AbWHXP3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 11:29:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:19629 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964991AbWHXP3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 11:29:15 -0400
Subject: [PATCH 4/4] Some extra --combine hacks.
From: David Woodhouse <dwmw2@infradead.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1156429585.3012.58.camel@pmac.infradead.org>
References: <1156429585.3012.58.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 16:28:52 +0100
Message-Id: <1156433332.3012.123.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do not apply. Mostly just Makefile hacks to make --combine get used by
using multi-obj compilation in a few places. The correct fix is to use
--combine properly for all C files in built-in.o

We do start to see interesting reductions in size in net/*/built-in.o
when we do this, though...

diff --git a/arch/i386/mm/Makefile b/arch/i386/mm/Makefile
index 80908b5..3bc5bc6 100644
--- a/arch/i386/mm/Makefile
+++ b/arch/i386/mm/Makefile
@@ -2,9 +2,12 @@ #
 # Makefile for the linux i386-specific parts of the memory manager.
 #
 
-obj-y	:= init.o pgtable.o fault.o ioremap.o extable.o pageattr.o mmap.o
+mm-y	:= init.o pgtable.o fault.o ioremap.o extable.o pageattr.o mmap.o
 
-obj-$(CONFIG_NUMA) += discontig.o
-obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
-obj-$(CONFIG_HIGHMEM) += highmem.o
-obj-$(CONFIG_BOOT_IOREMAP) += boot_ioremap.o
+mm-$(CONFIG_NUMA) += discontig.o
+mm-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
+mm-$(CONFIG_HIGHMEM) += highmem.o
+mm-$(CONFIG_BOOT_IOREMAP) += boot_ioremap.o
+
+obj-y := mm.o
+obj-m := $(mm-m)
diff --git a/drivers/md/Makefile b/drivers/md/Makefile
index 34957a6..48e925d 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -11,9 +11,9 @@ md-mod-objs     := md.o bitmap.o
 raid456-objs	:= raid5.o raid6algos.o raid6recov.o raid6tables.o \
 		   raid6int1.o raid6int2.o raid6int4.o \
 		   raid6int8.o raid6int16.o raid6int32.o \
-		   raid6altivec1.o raid6altivec2.o raid6altivec4.o \
-		   raid6altivec8.o \
 		   raid6mmx.o raid6sse1.o raid6sse2.o
+#		   raid6altivec1.o raid6altivec2.o raid6altivec4.o \
+#		   raid6altivec8.o \
 hostprogs-y	:= mktables
 
 # Note: link order is important.  All raid personalities
diff --git a/init/Makefile b/init/Makefile
index 633a268..6ca5c48 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -2,13 +2,12 @@ #
 # Makefile for the linux kernel.
 #
 
-obj-y				:= main.o version.o mounts.o initramfs.o
-obj-$(CONFIG_GENERIC_CALIBRATE_DELAY) += calibrate.o
-
-mounts-y			:= do_mounts.o
-mounts-$(CONFIG_BLK_DEV_RAM)	+= do_mounts_rd.o
-mounts-$(CONFIG_BLK_DEV_INITRD)	+= do_mounts_initrd.o
-mounts-$(CONFIG_BLK_DEV_MD)	+= do_mounts_md.o
+obj-y			:= init.o version.o
+init-y				:= main.o initramfs.o do_mounts.o
+init-$(CONFIG_GENERIC_CALIBRATE_DELAY) += calibrate.o
+init-$(CONFIG_BLK_DEV_RAM)	+= do_mounts_rd.o
+init-$(CONFIG_BLK_DEV_INITRD)	+= do_mounts_initrd.o
+init-$(CONFIG_BLK_DEV_MD)	+= do_mounts_md.o
 
 # files to be removed upon make clean
 clean-files := ../include/linux/compile.h
diff --git a/ipc/Makefile b/ipc/Makefile
index 0a6d626..7f23e4d 100644
--- a/ipc/Makefile
+++ b/ipc/Makefile
@@ -2,8 +2,9 @@ #
 # Makefile for the linux ipc.
 #
 
-obj-$(CONFIG_SYSVIPC_COMPAT) += compat.o
-obj-$(CONFIG_SYSVIPC) += util.o msgutil.o msg.o sem.o shm.o
+ipc-$(CONFIG_SYSVIPC_COMPAT) += compat.o
+ipc-$(CONFIG_SYSVIPC) += util.o msgutil.o msg.o sem.o shm.o
 obj_mq-$(CONFIG_COMPAT) += compat_mq.o
-obj-$(CONFIG_POSIX_MQUEUE) += mqueue.o msgutil.o $(obj_mq-y)
+ipc-$(CONFIG_POSIX_MQUEUE) += mqueue.o msgutil.o $(obj_mq-y)
 
+obj-y := ipc.o
diff --git a/net/core/Makefile b/net/core/Makefile
index 2645ba4..2dc2473 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -17,3 +17,6 @@ obj-$(CONFIG_NET_PKTGEN) += pktgen.o
 obj-$(CONFIG_WIRELESS_EXT) += wireless.o
 obj-$(CONFIG_NETPOLL) += netpoll.o
 obj-$(CONFIG_NET_DMA) += user_dma.o
+
+netcore-y := $(obj-y)
+obj-y := netcore.o
diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 849043c..9f91102 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -5,6 +5,7 @@
 #ifndef _LINUX_KALLSYMS_H
 #define _LINUX_KALLSYMS_H
 
+#include <linux/stddef.h>
 
 #define KSYM_NAME_LEN 127
 
diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
index 4878fc5..767ef0f 100644
--- a/net/ipv4/Makefile
+++ b/net/ipv4/Makefile
@@ -2,7 +2,9 @@ #
 # Makefile for the Linux TCP/IP (INET) layer.
 #
 
-obj-y     := route.o inetpeer.o protocol.o \
+obj-y	:= ipv4.o
+
+ipv4-y     := route.o inetpeer.o protocol.o \
 	     ip_input.o ip_fragment.o ip_forward.o ip_options.o \
 	     ip_output.o ip_sockglue.o inet_hashtables.o \
 	     inet_timewait_sock.o inet_connection_sock.o \
@@ -11,42 +13,45 @@ obj-y     := route.o inetpeer.o protocol
 	     datagram.o raw.o udp.o arp.o icmp.o devinet.o af_inet.o igmp.o \
 	     sysctl_net_ipv4.o fib_frontend.o fib_semantics.o
 
-obj-$(CONFIG_IP_FIB_HASH) += fib_hash.o
-obj-$(CONFIG_IP_FIB_TRIE) += fib_trie.o
-obj-$(CONFIG_PROC_FS) += proc.o
-obj-$(CONFIG_IP_MULTIPLE_TABLES) += fib_rules.o
-obj-$(CONFIG_IP_MROUTE) += ipmr.o
-obj-$(CONFIG_NET_IPIP) += ipip.o
-obj-$(CONFIG_NET_IPGRE) += ip_gre.o
-obj-$(CONFIG_SYN_COOKIES) += syncookies.o
-obj-$(CONFIG_INET_AH) += ah4.o
-obj-$(CONFIG_INET_ESP) += esp4.o
-obj-$(CONFIG_INET_IPCOMP) += ipcomp.o
-obj-$(CONFIG_INET_XFRM_TUNNEL) += xfrm4_tunnel.o
-obj-$(CONFIG_INET_TUNNEL) += tunnel4.o
-obj-$(CONFIG_INET_XFRM_MODE_TRANSPORT) += xfrm4_mode_transport.o
-obj-$(CONFIG_INET_XFRM_MODE_TUNNEL) += xfrm4_mode_tunnel.o
-obj-$(CONFIG_IP_PNP) += ipconfig.o
-obj-$(CONFIG_IP_ROUTE_MULTIPATH_RR) += multipath_rr.o
-obj-$(CONFIG_IP_ROUTE_MULTIPATH_RANDOM) += multipath_random.o
-obj-$(CONFIG_IP_ROUTE_MULTIPATH_WRANDOM) += multipath_wrandom.o
-obj-$(CONFIG_IP_ROUTE_MULTIPATH_DRR) += multipath_drr.o
-obj-$(CONFIG_NETFILTER)	+= netfilter.o netfilter/
+ipv4-$(CONFIG_IP_FIB_HASH) += fib_hash.o
+ipv4-$(CONFIG_IP_FIB_TRIE) += fib_trie.o
+ipv4-$(CONFIG_PROC_FS) += proc.o
+ipv4-$(CONFIG_IP_MULTIPLE_TABLES) += fib_rules.o
+ipv4-$(CONFIG_IP_MROUTE) += ipmr.o
+ipv4-$(CONFIG_NET_IPIP) += ipip.o
+ipv4-$(CONFIG_NET_IPGRE) += ip_gre.o
+ipv4-$(CONFIG_SYN_COOKIES) += syncookies.o
+ipv4-$(CONFIG_INET_AH) += ah4.o
+ipv4-$(CONFIG_INET_ESP) += esp4.o
+ipv4-$(CONFIG_INET_IPCOMP) += ipcomp.o
+ipv4-$(CONFIG_INET_XFRM_TUNNEL) += xfrm4_tunnel.o
+ipv4-$(CONFIG_INET_TUNNEL) += tunnel4.o
+ipv4-$(CONFIG_INET_XFRM_MODE_TRANSPORT) += xfrm4_mode_transport.o
+ipv4-$(CONFIG_INET_XFRM_MODE_TUNNEL) += xfrm4_mode_tunnel.o
+ipv4-$(CONFIG_IP_PNP) += ipconfig.o
+ipv4-$(CONFIG_IP_ROUTE_MULTIPATH_RR) += multipath_rr.o
+ipv4-$(CONFIG_IP_ROUTE_MULTIPATH_RANDOM) += multipath_random.o
+ipv4-$(CONFIG_IP_ROUTE_MULTIPATH_WRANDOM) += multipath_wrandom.o
+ipv4-$(CONFIG_IP_ROUTE_MULTIPATH_DRR) += multipath_drr.o
+ipv4-$(CONFIG_NETFILTER)	+= netfilter.o
+obj-$(CONFIG_NETFILTER)		+= netfilter/
 obj-$(CONFIG_IP_VS) += ipvs/
-obj-$(CONFIG_INET_DIAG) += inet_diag.o 
-obj-$(CONFIG_IP_ROUTE_MULTIPATH_CACHED) += multipath.o
-obj-$(CONFIG_INET_TCP_DIAG) += tcp_diag.o
-obj-$(CONFIG_NET_TCPPROBE) += tcp_probe.o
-obj-$(CONFIG_TCP_CONG_BIC) += tcp_bic.o
-obj-$(CONFIG_TCP_CONG_CUBIC) += tcp_cubic.o
-obj-$(CONFIG_TCP_CONG_WESTWOOD) += tcp_westwood.o
-obj-$(CONFIG_TCP_CONG_HSTCP) += tcp_highspeed.o
-obj-$(CONFIG_TCP_CONG_HYBLA) += tcp_hybla.o
-obj-$(CONFIG_TCP_CONG_HTCP) += tcp_htcp.o
-obj-$(CONFIG_TCP_CONG_VEGAS) += tcp_vegas.o
-obj-$(CONFIG_TCP_CONG_VENO) += tcp_veno.o
-obj-$(CONFIG_TCP_CONG_SCALABLE) += tcp_scalable.o
-obj-$(CONFIG_TCP_CONG_LP) += tcp_lp.o
+ipv4-$(CONFIG_INET_DIAG) += inet_diag.o 
+ipv4-$(CONFIG_IP_ROUTE_MULTIPATH_CACHED) += multipath.o
+ipv4-$(CONFIG_INET_TCP_DIAG) += tcp_diag.o
+ipv4-$(CONFIG_NET_TCPPROBE) += tcp_probe.o
+ipv4-$(CONFIG_TCP_CONG_BIC) += tcp_bic.o
+ipv4-$(CONFIG_TCP_CONG_CUBIC) += tcp_cubic.o
+ipv4-$(CONFIG_TCP_CONG_WESTWOOD) += tcp_westwood.o
+ipv4-$(CONFIG_TCP_CONG_HSTCP) += tcp_highspeed.o
+ipv4-$(CONFIG_TCP_CONG_HYBLA) += tcp_hybla.o
+ipv4-$(CONFIG_TCP_CONG_HTCP) += tcp_htcp.o
+ipv4-$(CONFIG_TCP_CONG_VEGAS) += tcp_vegas.o
+ipv4-$(CONFIG_TCP_CONG_VENO) += tcp_veno.o
+ipv4-$(CONFIG_TCP_CONG_SCALABLE) += tcp_scalable.o
+ipv4-$(CONFIG_TCP_CONG_LP) += tcp_lp.o
 
-obj-$(CONFIG_XFRM) += xfrm4_policy.o xfrm4_state.o xfrm4_input.o \
+ipv4-$(CONFIG_XFRM) += xfrm4_policy.o xfrm4_state.o xfrm4_input.o \
 		      xfrm4_output.o
+
+obj-m := $(ipv4-m)
diff --git a/net/sched/Makefile b/net/sched/Makefile
index 0f06aec..c605cc1 100644
--- a/net/sched/Makefile
+++ b/net/sched/Makefile
@@ -41,3 +41,6 @@ obj-$(CONFIG_NET_EMATCH_NBYTE)	+= em_nby
 obj-$(CONFIG_NET_EMATCH_U32)	+= em_u32.o
 obj-$(CONFIG_NET_EMATCH_META)	+= em_meta.o
 obj-$(CONFIG_NET_EMATCH_TEXT)	+= em_text.o
+
+netsched-y := $(obj-y)
+obj-y := netsched.o
diff --git a/net/xfrm/Makefile b/net/xfrm/Makefile
index 693aac1..3500f84 100644
--- a/net/xfrm/Makefile
+++ b/net/xfrm/Makefile
@@ -5,3 +5,5 @@ #
 obj-$(CONFIG_XFRM) := xfrm_policy.o xfrm_state.o xfrm_input.o xfrm_algo.o
 obj-$(CONFIG_XFRM_USER) += xfrm_user.o
 
+xfrm-y := $(obj-y)
+obj-y := xfrm.o
diff --git a/fs/Makefile b/fs/Makefile
index 8913542..faedce0 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -34,7 +34,6 @@ obj-$(CONFIG_BINFMT_FLAT)	+= binfmt_flat
 
 obj-$(CONFIG_FS_MBCACHE)	+= mbcache.o
 obj-$(CONFIG_FS_POSIX_ACL)	+= posix_acl.o xattr_acl.o
-obj-$(CONFIG_NFS_COMMON)	+= nfs_common/
 
 obj-$(CONFIG_QUOTA)		+= dquot.o
 obj-$(CONFIG_QFMT_V1)		+= quota_v1.o
@@ -42,6 +41,12 @@ obj-$(CONFIG_QFMT_V2)		+= quota_v2.o
 obj-$(CONFIG_QUOTACTL)		+= quota.o
 
 obj-$(CONFIG_DNOTIFY)		+= dnotify.o
+obj-$(CONFIG_PROFILING)		+= dcookies.o
+
+fs-y := $(obj-y)
+obj-y := fs.o
+
+obj-$(CONFIG_NFS_COMMON)	+= nfs_common/
 
 obj-$(CONFIG_PROC_FS)		+= proc/
 obj-y				+= partitions/
@@ -49,7 +54,6 @@ obj-$(CONFIG_SYSFS)		+= sysfs/
 obj-$(CONFIG_CONFIGFS_FS)	+= configfs/
 obj-y				+= devpts/
 
-obj-$(CONFIG_PROFILING)		+= dcookies.o
  
 # Do not add any filesystems before this line
 obj-$(CONFIG_REISERFS_FS)	+= reiserfs/
diff --git a/drivers/net/e1000/Makefile b/drivers/net/e1000/Makefile
index 5dea2b7..9bece1d 100644
--- a/drivers/net/e1000/Makefile
+++ b/drivers/net/e1000/Makefile
@@ -31,6 +31,10 @@ #
 # Makefile for the Intel(R) PRO/1000 ethernet driver
 #
 
+# Disable use of --combine for now. GCC PR28779
+CONFIG_COMBINED_COMPILE=
+
 obj-$(CONFIG_E1000) += e1000.o
 
 e1000-objs := e1000_main.o e1000_hw.o e1000_ethtool.o e1000_param.o
+

-- 
dwmw2

