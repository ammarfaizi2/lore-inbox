Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266351AbUIAMn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266351AbUIAMn0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 08:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266319AbUIAMnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 08:43:25 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:3749 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S266467AbUIAMlP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 08:41:15 -0400
From: Einar Lueck <elueck@de.ibm.com>
Reply-To: lkml@einar-lueck.de
Organization: IBM Deutschland Entwicklung GmbH
Subject: [PATCH] net/ipv4 for Source VIPA support, kernel BK Head
Date: Wed, 1 Sep 2004 14:41:10 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409011441.10154.elueck@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following small patch (applies to BK head) addresses issues relevant for transparent NIC failover (especially in case of NFS). It allows to configure on a per device basis via sysctl an IP address (Source Virtual IP Address - Source VIPA) that is set as IP source address for all connections for which no bind has been applied. ?To allow for NIC failover one then just needs:
1. A dummy-Device set up with the Source VIPA
2. Outbound routes via both/all redundant NICs for the relevant packets (more precisely: dynamic routing with for example ZEBRA)
3. Routes to the Source VIPA on the relevant router having the IPs of the redundant NICs configured as gateways (more precisely: dynamic routing with for example ZEBRA)
Dynamic routing is mandatory as it is necessary that dead routes (e.g. NIC dead) are removed at the relevant router.

We tested this patch in the desired NFS failover usage scenario and of course without any Source VIPA configured.

The reason for the development of this patch is that the alternatives we thought of have serious limitations for the intended usage scenarios:
1. A User space tool intercepting connects and issuing binds (configuration on a per application basis) (refer to: http://oss.software.ibm.com/linux390/useful_add-ons_vipa.shtml)
This approach does not allow for NFS failover which we consider to be a very important use case because NFS works in kernel.
2. ip route xxx.xxx.xxx.xxx/xx src SourceVIPA
OSPF, etc. do not support automatic setup of and discovery of desired source addresses. As a consequence one would have to configure static routes for all use cases which is not desirable in complex routing scenarios and especially in presence of dynamic routing.
3. netfilter ((S)NAT)
NAT takes place after routing is applied and an IP address (e.g. IP of the output NIC) has been set for a packet. Consequently, returned packets are routed to the original IP address. As a result no failover is possible.
4. NIC bonding
There is a strong dependence on the switches' timeout for the IP/MAC pair. In addition to that, as far as we know not all NICs support bonding with failover.

I hope I described the overall use case comprehensible enough to clarify why we consider this patch as very useful and important.

Einar Lueck


diff -ruN linux-2.6.8.1/include/linux/inetdevice.h linux-2.6.8.1.new/include/linux/inetdevice.h
--- linux-2.6.8.1/include/linux/inetdevice.h	2004-08-31 17:50:03.000000000 +0200
+++ linux-2.6.8.1.new/include/linux/inetdevice.h	2004-08-31 18:07:01.000000000 +0200
@@ -27,6 +27,9 @@
 	int	no_policy;
 	int	force_igmp_version;
 	void	*sysctl;
+#ifdef CONFIG_IP_SOURCEVIPA
+        __u32   source_vipa;
+#endif
 };
 
 extern struct ipv4_devconf ipv4_devconf;
diff -ruN linux-2.6.8.1/include/linux/sysctl.h linux-2.6.8.1.new/include/linux/sysctl.h
--- linux-2.6.8.1/include/linux/sysctl.h	2004-08-31 17:50:04.000000000 +0200
+++ linux-2.6.8.1.new/include/linux/sysctl.h	2004-08-31 18:08:13.000000000 +0200
@@ -393,6 +393,9 @@
 	NET_IPV4_CONF_FORCE_IGMP_VERSION=17,
 	NET_IPV4_CONF_ARP_ANNOUNCE=18,
 	NET_IPV4_CONF_ARP_IGNORE=19,
+#ifdef CONFIG_IP_SOURCEVIPA
+       NET_IPV4_CONF_SOURCE_VIPA = 20
+#endif
 };
 
 /* /proc/sys/net/ipv4/netfilter */
diff -ruN linux-2.6.8.1/net/ipv4/Kconfig linux-2.6.8.1.new/net/ipv4/Kconfig
--- linux-2.6.8.1/net/ipv4/Kconfig	2004-08-31 17:50:04.000000000 +0200
+++ linux-2.6.8.1.new/net/ipv4/Kconfig	2004-08-31 18:10:11.000000000 +0200
@@ -115,6 +115,20 @@
 	  handled by the klogd daemon which is responsible for kernel messages
 	  ("man klogd").
 
+config IP_SOURCEVIPA
+       bool "IP: Source Virtual IP Address"
+       help
+         If you say Y you are able to configure on a per device basis
+         virtual source ip addresses to be set for not explicitly
+         bound sockets. Thereby, one may force applications like
+         FTP, NFS, etc. to implicitly bind to dummy interfaces.
+         On the basis of dummy interfaces one may decouple applications
+         from physical interfaces and may as a consequence achieve a higher
+         degree of fault tolerance.
+
+         If unsure, say N.
+
+
 config IP_PNP
 	bool "IP: kernel level autoconfiguration"
 	depends on INET
diff -ruN linux-2.6.8.1/net/ipv4/devinet.c linux-2.6.8.1.new/net/ipv4/devinet.c
--- linux-2.6.8.1/net/ipv4/devinet.c	2004-08-31 17:50:04.000000000 +0200
+++ linux-2.6.8.1.new/net/ipv4/devinet.c	2004-08-31 18:27:25.000000000 +0200
@@ -57,6 +57,7 @@
 #include <linux/sysctl.h>
 #endif
 #include <linux/kmod.h>
+#include <linux/ctype.h>
 
 #include <net/ip.h>
 #include <net/route.h>
@@ -67,6 +68,9 @@
 	.send_redirects =  1,
 	.secure_redirects = 1,
 	.shared_media =	  1,
+#ifdef CONFIG_IP_SOURCEVIPA
+	.source_vipa = 0,
+#endif
 };
 
 static struct ipv4_devconf ipv4_devconf_dflt = {
@@ -75,6 +79,10 @@
 	.secure_redirects =  1,
 	.shared_media =	     1,
 	.accept_source_route = 1,
+#ifdef CONFIG_IP_SOURCEVIPA
+	.source_vipa = 0,
+#endif
+
 };
 
 static void rtmsg_ifa(int event, struct in_ifaddr *);
@@ -767,6 +775,9 @@
 u32 inet_select_addr(const struct net_device *dev, u32 dst, int scope)
 {
 	u32 addr = 0;
+#ifdef CONFIG_IP_SOURCEVIPA
+        u32 source_vipa = 0;
+#endif
 	struct in_device *in_dev;
 
 	rcu_read_lock();
@@ -784,11 +795,17 @@
 		if (!addr)
 			addr = ifa->ifa_local;
 	} endfor_ifa(in_dev);
+#ifdef CONFIG_IP_SOURCEVIPA
+	source_vipa = in_dev->cnf.source_vipa;
+#endif
 no_in_dev:
 	rcu_read_unlock();
 
 	if (addr)
 		goto out;
+#ifdef CONFIG_IP_SOURCEVIPA
+	source_vipa = 0;
+#endif
 
 	/* Not loopback addresses on loopback should be preferred
 	   in this case. It is importnat that lo is the first interface
@@ -804,6 +821,9 @@
 			if (ifa->ifa_scope != RT_SCOPE_LINK &&
 			    ifa->ifa_scope <= scope) {
 				addr = ifa->ifa_local;
+#ifdef CONFIG_IP_SOURCEVIPA
+				source_vipa = in_dev->cnf.source_vipa;
+#endif
 				goto out_unlock_both;
 			}
 		} endfor_ifa(in_dev);
@@ -812,6 +832,14 @@
 	read_unlock(&dev_base_lock);
 	rcu_read_unlock();
 out:
+#ifdef CONFIG_IP_SOURCEVIPA
+	/* Set Source Virtual IP Address (Source VIPA) if one is
+	   configured for the device and the device has a natural
+	   IP */
+	if (addr != 0 && source_vipa != 0) {
+		addr = source_vipa;
+	}
+#endif
 	return addr;
 }
 
@@ -1151,6 +1179,158 @@
 	return ret;
 }
 
+#ifdef CONFIG_IP_SOURCEVIPA
+
+static int
+ipv4_inet_addr(const char *cp, void *dst)
+{
+	unsigned long value;
+	char *endp;
+	const char *startp;
+	unsigned char bytes[4];
+	int byteNo;
+	
+	*((int*)bytes) = 0;
+
+	startp = cp;
+	for (byteNo = 0; byteNo < 4; ++byteNo) {
+		value = simple_strtoul( startp, &endp, 10 );
+		if ( value > 0xFF ) {
+			return -EINVAL;
+		}
+		bytes[byteNo] = (char) value;
+		if ( *endp == 0 ) {
+			*((int *)dst) = *((int *)bytes);
+			return 0;
+		}
+		else if ( *endp == '.' ) {
+			startp = endp + 1;
+		}
+		else {
+			return -EINVAL;
+		}
+	}
+
+	return -EINVAL;
+}
+
+
+/**
+ * ipv4_doinetaddrstring_and_flush - read an ip address string sysctl
+ * @table: the sysctl table
+ * @write: %TRUE if this is a write to the sysctl file
+ * @filp: the file structure
+ * @buffer: the user buffer
+ * @lenp: the size of the user buffer
+ *
+ * Reads/writes a string representing an IP address from/to the user buffer. 
+ * It converts the string to an integer value through the use of 
+ * ipv4_inet_addr. 
+ * buffer provided is not large enough to hold the string, the
+ * string is truncated. The copied string is %NULL-terminated.
+ * If the string is being read by the user process, it is copied
+ * and a newline '\n' is added. It is truncated if the buffer is
+ * not large enough.
+ * On write operations the routing cache is flushed.
+ *
+ * Returns 0 on success.
+ */
+int 
+ipv4_doinetaddrstring_and_flush(ctl_table *table, int write, 
+				struct file *filp,
+				void __user *buffer, size_t *lenp, 
+				loff_t *ppos)
+{
+	char __user *p;
+	char *kerneltempbuffer;
+	int nullterminationpos;
+	int retval;
+	
+
+	if (!table->data || !table->maxlen || !*lenp ||
+	    (*ppos && !write)) {
+		*lenp = 0;
+		return 0;
+	}
+	
+	if (write) {
+		kerneltempbuffer = (char*) kmalloc(table->maxlen, GFP_KERNEL);
+		if (!kerneltempbuffer) {
+			return -EFAULT;
+		}
+		
+		/* copy data to kernel space */
+		if(strncpy_from_user(kerneltempbuffer, buffer, 
+				     table->maxlen) < 0) {
+			retval = -EFAULT;
+			goto cleanup;
+		}
+
+		/* set null-termination if necessary */
+		nullterminationpos = 0;
+		p = kerneltempbuffer;
+		while (nullterminationpos < table->maxlen) {
+			if (*p == '\n' || *p == 0)
+				break;
+						
+			++p;
+			++nullterminationpos;
+		}
+		if ( nullterminationpos == table->maxlen ) 
+			nullterminationpos--;
+		kerneltempbuffer[nullterminationpos] = 0;
+		
+		/* convert address */
+		retval = ipv4_inet_addr(kerneltempbuffer, table->data);
+		if ( retval != 0 ) {
+			goto cleanup;
+		}
+		*ppos += *lenp;
+
+		/* flush routing cache */
+		rt_cache_flush(0);
+		printk( KERN_DEBUG "%s: new IP written: %s(%u)", 
+			__FUNCTION__, kerneltempbuffer, 
+			*((__u32*)table->data) );
+	cleanup:
+		kfree( kerneltempbuffer );
+		goto out;
+
+	} else {
+		char inetaddrstr[16];
+		size_t len;
+		sprintf( inetaddrstr, "%u.%u.%u.%u", 
+			 *((unsigned char*)table->data),
+			 *((unsigned char*)table->data+1),
+			 *((unsigned char*)table->data+2),
+			 *((unsigned char*)table->data+3) );
+		len = strlen( inetaddrstr );
+		if ( len > table->maxlen)
+			len = table->maxlen;
+		if (len > *lenp)
+			len = *lenp;
+		if (len)
+			if(copy_to_user(buffer, inetaddrstr, len)) {
+				retval = -EFAULT;
+				goto out;
+			}
+		if (len < *lenp) {
+			if(put_user('\n', ((char __user *) buffer) + len)) {
+				retval = -EFAULT;
+				goto out;
+			}
+			len++;
+		}
+		*lenp = len;
+		*ppos += len;
+	}
+	retval = 0;
+ out:
+	return retval;
+}
+
+#endif /* CONFIG_IP_SOURCEVIPA */
+
 int ipv4_doint_and_flush(ctl_table *ctl, int write,
 			 struct file* filp, void __user *buffer,
 			 size_t *lenp, loff_t *ppos)
@@ -1209,7 +1389,11 @@
 
 static struct devinet_sysctl_table {
 	struct ctl_table_header *sysctl_header;
-	ctl_table		devinet_vars[20];
+#ifdef CONFIG_IP_SOURCEVIPA
+        ctl_table               devinet_vars[21];
+#else
+        ctl_table               devinet_vars[20];
+#endif
 	ctl_table		devinet_dev[2];
 	ctl_table		devinet_conf_dir[2];
 	ctl_table		devinet_proto_dir[2];
@@ -1371,6 +1555,16 @@
 			.proc_handler	= &ipv4_doint_and_flush,
 			.strategy	= &ipv4_doint_and_flush_strategy,
 		},
+#ifdef CONFIG_IP_SOURCEVIPA
+		{
+			.ctl_name	= NET_IPV4_CONF_SOURCE_VIPA,
+			.procname	= "source_vipa",
+			.data		= &ipv4_devconf.source_vipa,
+			.maxlen		= 16,
+			.mode		= 0644,
+			.proc_handler	= &ipv4_doinetaddrstring_and_flush
+		},
+#endif
 	},
 	.devinet_dev = {
 		{
