Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268866AbUHaUKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268866AbUHaUKQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 16:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268985AbUHaUI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 16:08:58 -0400
Received: from frog.mt.lv ([159.148.172.197]:50585 "EHLO frog.mt.lv")
	by vger.kernel.org with ESMTP id S268866AbUHaT4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:56:32 -0400
From: Dmitry Golubev <dmitry@mikrotik.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: 2.6.8.1, additional options for embedded systems
Date: Tue, 31 Aug 2004 22:55:40 +0300
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_8eNNBIq2t3asum2"
Message-Id: <200408312255.40511.dmitry@mikrotik.com>
X-mikrotik.com-Virus_kerajs: Not scanned.
X-mikrotik.com-Virus_un_spam-kerajs: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_8eNNBIq2t3asum2
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Additionally to the patch I sent earlier today, this patch:
- adds option to disable IGMP (that's rarely needed for desktops)
- adds option to disable DOUBLEFAULT for x86 systems

Please apply both - saves about 20K compresses or 50K uncompressed, which is 
very good for embedded systems.

Dmitry

--Boundary-00=_8eNNBIq2t3asum2
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff1"

diff -Naur -X ./patt ./linux-2.6.8.1/arch/i386/kernel/Makefile ./linux-2.6.8.1_new/arch/i386/kernel/Makefile
--- ./linux-2.6.8.1/arch/i386/kernel/Makefile	2004-08-14 13:54:51.000000000 +0300
+++ ./linux-2.6.8.1_new/arch/i386/kernel/Makefile	2004-08-31 20:35:51.000000000 +0300
@@ -6,9 +6,9 @@
 
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
-		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o \
-		doublefault.o
+		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o
 
+obj-$(CONFIG_DOUBLEFAULT)	+= doublefault.o
 obj-y				+= cpu/
 obj-y				+= timers/
 obj-$(CONFIG_ACPI_BOOT)		+= acpi/
diff -Naur -X ./patt ./linux-2.6.8.1/arch/i386/kernel/cpu/common.c ./linux-2.6.8.1_new/arch/i386/kernel/cpu/common.c
--- ./linux-2.6.8.1/arch/i386/kernel/cpu/common.c	2004-08-14 13:54:48.000000000 +0300
+++ ./linux-2.6.8.1_new/arch/i386/kernel/cpu/common.c	2004-08-31 20:39:06.000000000 +0300
@@ -228,8 +228,9 @@
 		if (cap0 & (1<<19))
 			c->x86_cache_alignment = ((misc >> 8) & 0xff) * 8;
 	}
-
+#ifdef CONFIG_X86_CPU_VENDOR_INTEL
 	early_intel_workaround(c);
+#endif	
 }
 
 void __init generic_identify(struct cpuinfo_x86 * c)
@@ -460,28 +461,84 @@
  * Then, when cpu_init() is called, we can just iterate over that array.
  */
 
+#ifdef CONFIG_X86_CPU_VENDOR_INTEL
+
 extern int intel_cpu_init(void);
+
+#endif
+
+#ifdef CONFIG_X86_CPU_VENDOR_CYRIX
+
 extern int cyrix_init_cpu(void);
 extern int nsc_init_cpu(void);
+
+#endif
+
+#ifdef CONFIG_X86_CPU_VENDOR_AMD
+
 extern int amd_init_cpu(void);
+
+#endif
+
+#ifdef CONFIG_X86_CPU_VENDOR_CENTAUR
+
 extern int centaur_init_cpu(void);
+
+#endif
+
+#ifdef CONFIG_X86_CPU_VENDOR_TRANSMETA
+
 extern int transmeta_init_cpu(void);
+
+#endif
+
+#ifdef CONFIG_X86_CPU_VENDOR_RISE
+
 extern int rise_init_cpu(void);
+
+#endif
+
+#ifdef CONFIG_X86_CPU_VENDOR_NEXGEN
+
 extern int nexgen_init_cpu(void);
+
+#endif
+
+#ifdef CONFIG_X86_CPU_VENDOR_UMC
+
 extern int umc_init_cpu(void);
+
+#endif
+
 void early_cpu_detect(void);
 
 void __init early_cpu_init(void)
 {
+#ifdef CONFIG_X86_CPU_VENDOR_INTEL
 	intel_cpu_init();
+#endif
+#ifdef CONFIG_X86_CPU_VENDOR_CYRIX
 	cyrix_init_cpu();
 	nsc_init_cpu();
+#endif
+#ifdef CONFIG_X86_CPU_VENDOR_AMD
 	amd_init_cpu();
+#endif
+#ifdef CONFIG_X86_CPU_VENDOR_CENTAUR
 	centaur_init_cpu();
+#endif
+#ifdef CONFIG_X86_CPU_VENDOR_TRANSMETA
 	transmeta_init_cpu();
+#endif
+#ifdef CONFIG_X86_CPU_VENDOR_RISE
 	rise_init_cpu();
+#endif
+#ifdef CONFIG_X86_CPU_VENDOR_NEXGEN
 	nexgen_init_cpu();
+#endif
+#ifdef CONFIG_X86_CPU_VENDOR_UMC
 	umc_init_cpu();
+#endif
 	early_cpu_detect();
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
@@ -556,10 +613,14 @@
 	load_TR_desc();
 	load_LDT(&init_mm.context);
 
+#ifdef CONFIG_DOUBLEFAULT
+
 	/* Set up doublefault TSS pointer in the GDT */
 	__set_tss_desc(cpu, GDT_ENTRY_DOUBLEFAULT_TSS, &doublefault_tss);
 	cpu_gdt_table[cpu][GDT_ENTRY_DOUBLEFAULT_TSS].b &= 0xfffffdff;
 
+#endif
+
 	/* Clear %fs and %gs. */
 	asm volatile ("xorl %eax, %eax; movl %eax, %fs; movl %eax, %gs");
 
diff -Naur -X ./patt ./linux-2.6.8.1/init/Kconfig ./linux-2.6.8.1_new/init/Kconfig
--- ./linux-2.6.8.1/init/Kconfig	2004-08-14 13:55:59.000000000 +0300
+++ ./linux-2.6.8.1_new/init/Kconfig	2004-08-31 21:48:02.000000000 +0300
@@ -285,6 +285,15 @@
 
 	  If unsure, say N.
 
+config DOUBLEFAULT
+       depends on X86
+       bool "Enable doublefault exception handler" if EMBEDDED
+       default y
+       help
+         If unsure, say Y.
+	 
+	 You will save about 10KB disabling this handler.
+
 endmenu		# General setup
 
 
diff -Naur -X ./patt ./linux-2.6.8.1/net/ipv4/Kconfig ./linux-2.6.8.1_new/net/ipv4/Kconfig
--- ./linux-2.6.8.1/net/ipv4/Kconfig	2004-08-14 13:55:48.000000000 +0300
+++ ./linux-2.6.8.1_new/net/ipv4/Kconfig	2004-08-31 20:15:56.000000000 +0300
@@ -261,6 +261,15 @@
 	  gated-5). This routing protocol is not used widely, so say N unless
 	  you want to play with it.
 
+config IP_IGMP
+	bool "IP: IGMP support"
+	depends on INET
+	default y
+	help
+	  Internet Group Management Protocol support. Saying N here effectively
+	  disables support for IP multicasting and saves about 14KB of kernel
+	  size. If unsure say Y.
+
 config ARPD
 	bool "IP: ARP daemon support (EXPERIMENTAL)"
 	depends on INET && EXPERIMENTAL
diff -Naur -X ./patt ./linux-2.6.8.1/net/ipv4/Makefile ./linux-2.6.8.1_new/net/ipv4/Makefile
--- ./linux-2.6.8.1/net/ipv4/Makefile	2004-08-14 13:54:52.000000000 +0300
+++ ./linux-2.6.8.1_new/net/ipv4/Makefile	2004-08-31 20:17:52.000000000 +0300
@@ -6,9 +6,10 @@
 	     ip_input.o ip_fragment.o ip_forward.o ip_options.o \
 	     ip_output.o ip_sockglue.o \
 	     tcp.o tcp_input.o tcp_output.o tcp_timer.o tcp_ipv4.o tcp_minisocks.o \
-	     tcp_diag.o datagram.o raw.o udp.o arp.o icmp.o devinet.o af_inet.o igmp.o \
+	     tcp_diag.o datagram.o raw.o udp.o arp.o icmp.o devinet.o af_inet.o \
 	     sysctl_net_ipv4.o fib_frontend.o fib_semantics.o fib_hash.o
 
+obj-$(CONFIG_IP_IGMP) += igmp.o
 obj-$(CONFIG_PROC_FS) += proc.o
 obj-$(CONFIG_IP_MULTIPLE_TABLES) += fib_rules.o
 obj-$(CONFIG_IP_ROUTE_NAT) += ip_nat_dumb.o
diff -Naur -X ./patt ./linux-2.6.8.1/net/ipv4/af_inet.c ./linux-2.6.8.1_new/net/ipv4/af_inet.c
--- ./linux-2.6.8.1/net/ipv4/af_inet.c	2004-08-14 13:54:50.000000000 +0300
+++ ./linux-2.6.8.1_new/net/ipv4/af_inet.c	2004-08-31 19:51:58.000000000 +0300
@@ -379,8 +379,9 @@
 		long timeout;
 
 		/* Applications forget to leave groups before exiting */
+#ifdef CONFIG_IP_IGMP
 		ip_mc_drop_socket(sk);
-
+#endif
 		/* If linger is set, we don't return until the close
 		 * is complete.  Otherwise we return immediately. The
 		 * actually closing is done the same either way.
diff -Naur -X ./patt ./linux-2.6.8.1/net/ipv4/devinet.c ./linux-2.6.8.1_new/net/ipv4/devinet.c
--- ./linux-2.6.8.1/net/ipv4/devinet.c	2004-08-14 13:54:51.000000000 +0300
+++ ./linux-2.6.8.1_new/net/ipv4/devinet.c	2004-08-31 19:49:55.000000000 +0300
@@ -165,9 +165,11 @@
 #ifdef CONFIG_SYSCTL
 	devinet_sysctl_register(in_dev, &in_dev->cnf);
 #endif
+#ifdef CONFIG_IP_IGMP
 	ip_mc_init_dev(in_dev);
 	if (dev->flags & IFF_UP)
 		ip_mc_up(in_dev);
+#endif
 out:
 	return in_dev;
 out_kfree:
@@ -184,7 +186,9 @@
 
 	in_dev->dead = 1;
 
+#ifdef CONFIG_IP_IGMP
 	ip_mc_destroy_dev(in_dev);
+#endif
 
 	while ((ifa = in_dev->ifa_list) != NULL) {
 		inet_del_ifa(in_dev, &in_dev->ifa_list, 0);
@@ -981,10 +985,14 @@
 			in_dev->cnf.no_xfrm = 1;
 			in_dev->cnf.no_policy = 1;
 		}
+#ifdef CONFIG_IP_IGMP
 		ip_mc_up(in_dev);
+#endif
 		break;
 	case NETDEV_DOWN:
+#ifdef CONFIG_IP_IGMP
 		ip_mc_down(in_dev);
+#endif
 		break;
 	case NETDEV_CHANGEMTU:
 		if (dev->mtu >= 68)
diff -Naur -X ./patt ./linux-2.6.8.1/net/ipv4/ip_sockglue.c ./linux-2.6.8.1_new/net/ipv4/ip_sockglue.c
--- ./linux-2.6.8.1/net/ipv4/ip_sockglue.c	2004-08-14 13:55:09.000000000 +0300
+++ ./linux-2.6.8.1_new/net/ipv4/ip_sockglue.c	2004-08-31 19:33:07.000000000 +0300
@@ -523,6 +523,9 @@
 			if (!val)
 				skb_queue_purge(&sk->sk_error_queue);
 			break;
+
+#ifdef CONFIG_IP_IGMP
+
 		case IP_MULTICAST_TTL:
 			if (sk->sk_type == SOCK_STREAM)
 				goto e_inval;
@@ -839,6 +842,9 @@
 				kfree(gsf);
 			break;
 		}
+
+#endif
+
 		case IP_ROUTER_ALERT:	
 			err = ip_ra_control(sk, val ? 1 : 0, NULL);
 			break;
@@ -970,6 +976,9 @@
 		case IP_RECVERR:
 			val = inet->recverr;
 			break;
+
+#ifdef CONFIG_IP_IGMP
+
 		case IP_MULTICAST_TTL:
 			val = inet->mc_ttl;
 			break;
@@ -1025,6 +1034,9 @@
 			release_sock(sk);
 			return err;
 		}
+
+#endif
+
 		case IP_PKTOPTIONS:		
 		{
 			struct msghdr msg;
diff -Naur -X ./patt ./linux-2.6.8.1/net/ipv4/route.c ./linux-2.6.8.1_new/net/ipv4/route.c
--- ./linux-2.6.8.1/net/ipv4/route.c	2004-08-14 13:56:23.000000000 +0300
+++ ./linux-2.6.8.1_new/net/ipv4/route.c	2004-08-31 19:46:49.000000000 +0300
@@ -1453,6 +1453,8 @@
         rt->rt_type = res->type;
 }
 
+#ifdef CONFIG_IP_IGMP
+
 static int ip_route_input_mc(struct sk_buff *skb, u32 daddr, u32 saddr,
 				u8 tos, struct net_device *dev, int our)
 {
@@ -1538,6 +1540,8 @@
 	return -EINVAL;
 }
 
+#endif
+
 /*
  *	NOTE. We drop all the packets that has local source
  *	addresses, because every properly looped back packet
@@ -1898,6 +1902,9 @@
 	   route cache entry is created eventually.
 	 */
 	if (MULTICAST(daddr)) {
+
+#ifdef CONFIG_IP_IGMP
+
 		struct in_device *in_dev;
 
 		read_lock(&inetdev_lock);
@@ -1915,6 +1922,9 @@
 			}
 		}
 		read_unlock(&inetdev_lock);
+
+#endif
+
 		return -EINVAL;
 	}
 	return ip_route_input_slow(skb, daddr, saddr, tos, dev);
@@ -2131,7 +2141,11 @@
 			fib_info_put(res.fi);
 			res.fi = NULL;
 		}
-	} else if (res.type == RTN_MULTICAST) {
+	}
+	
+#ifdef CONFIG_IP_IGMP
+	
+	else if (res.type == RTN_MULTICAST) {
 		flags |= RTCF_MULTICAST|RTCF_LOCAL;
 		if (!ip_check_mc(in_dev, oldflp->fl4_dst, oldflp->fl4_src, oldflp->proto))
 			flags &= ~RTCF_LOCAL;
@@ -2145,6 +2159,8 @@
 		}
 	}
 
+#endif
+
 	rth = dst_alloc(&ipv4_dst_ops);
 	if (!rth)
 		goto e_nobufs;
diff -Naur -X ./patt ./linux-2.6.8.1/net/ipv4/udp.c ./linux-2.6.8.1_new/net/ipv4/udp.c
--- ./linux-2.6.8.1/net/ipv4/udp.c	2004-08-14 13:54:50.000000000 +0300
+++ ./linux-2.6.8.1_new/net/ipv4/udp.c	2004-08-31 19:40:19.000000000 +0300
@@ -275,6 +275,8 @@
 	return sk;
 }
 
+#ifdef CONFIG_IP_IGMP
+
 static inline struct sock *udp_v4_mcast_next(struct sock *sk,
 					     u16 loc_port, u32 loc_addr,
 					     u16 rmt_port, u32 rmt_addr,
@@ -303,6 +305,8 @@
   	return s;
 }
 
+#endif
+
 /*
  * This routine is called by the ICMP module when it gets some
  * sort of error condition.  If err < 0 then the socket should
@@ -1040,6 +1044,8 @@
 	return 0;
 }
 
+#ifdef CONFIG_IP_IGMP
+
 /*
  *	Multicasts and broadcasts go to each listener.
  *
@@ -1082,6 +1088,8 @@
 	return 0;
 }
 
+#endif
+
 /* Initialize UDP checksum. If exited with zero value (success),
  * CHECKSUM_UNNECESSARY means, that no more checks are required.
  * Otherwise, csum completion requires chacksumming packet body,
@@ -1116,7 +1124,6 @@
   	struct sock *sk;
   	struct udphdr *uh;
 	unsigned short ulen;
-	struct rtable *rt = (struct rtable*)skb->dst;
 	u32 saddr = skb->nh.iph->saddr;
 	u32 daddr = skb->nh.iph->daddr;
 	int len = skb->len;
@@ -1140,9 +1147,14 @@
 	if (udp_checksum_init(skb, uh, ulen, saddr, daddr) < 0)
 		goto csum_error;
 
+#ifdef CONFIG_IP_IGMP
+
+	struct rtable *rt = (struct rtable*)skb->dst;
 	if(rt->rt_flags & (RTCF_BROADCAST|RTCF_MULTICAST))
 		return udp_v4_mcast_deliver(skb, uh, saddr, daddr);
 
+#endif
+
 	sk = udp_v4_lookup(saddr, uh->source, daddr, uh->dest, skb->dev->ifindex);
 
 	if (sk != NULL) {

--Boundary-00=_8eNNBIq2t3asum2--
