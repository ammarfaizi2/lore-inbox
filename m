Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263432AbRFFB1T>; Tue, 5 Jun 2001 21:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263441AbRFFB1A>; Tue, 5 Jun 2001 21:27:00 -0400
Received: from gw-yyz.somanetworks.com ([216.126.67.39]:38838 "EHLO
	somanetworks.com") by vger.kernel.org with ESMTP id <S263432AbRFFB0u>;
	Tue, 5 Jun 2001 21:26:50 -0400
Date: Tue, 5 Jun 2001 21:26:34 -0400
From: Mark Frazer <mark@somanetworks.com>
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: IP ToS routing problem and fix
Message-ID: <20010605212634.A19659@somanetworks.com>
Mail-Followup-To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Detectable, well, not really
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Alexey.  I've been having a problem getting ToS routing working
properly, well, the way I wanted it to.  Basically, it would not route
using anything except the RFC 1349 ToS settings.

I've prepared the attached patch to add a new configuration option to
allow routing based on RFC 2474 Diffserv DSCP values in the IPv4 TOS
field.

Attached is a test script which works for the following setup.

The test machine has eth1 and eth2 on the same ethernet network.  There is
another machine on the test ethernet network that the test machine pings.
The IP addresses used in the setup are:
test:eth1 = 192.168.0.1.
test:eth2 = 192.168.0.2.
target = 192.168.0.3.

I've also included the output of the test for an unpatched 2.4.5 system
and a patched 2.4.5 system.

Please have a look and let me know what you think.

I wouldn't promote putting this in the regular kernel until I've let it
run around here for a few weeks.

cheers
-mark

-- 
Mark Frazer <mark@somanetworks.com>

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch.dscp"

# Configure.help needs updating for the new config option.
# This option makes the old IP_ROUTE_TOS boolean a choice
# option allowing either the old RFC1349 behaviour or the
# RFC2474 behaviour.
diff -urN linux-2.4.5/Documentation/Configure.help linux-2.4.5-mjf/Documentation/Configure.help
--- linux-2.4.5/Documentation/Configure.help	Thu May 24 18:03:06 2001
+++ linux-2.4.5-mjf/Documentation/Configure.help	Mon Jun  4 18:23:31 2001
@@ -3943,13 +3943,30 @@
   equal "cost" and chooses one of them in a non-deterministic fashion
   if a matching packet arrives.
 
-IP: use TOS value as routing key
-CONFIG_IP_ROUTE_TOS
-  The header of every IP packet carries a TOS (Type Of Service) value
+IP: use of TOS value as routing key
+CONFIG_IP_ROUTE_TOSNOTUSED
+  The second octet of the IP header is defined by several Internet RFCs.
+  The linux routing facility can make a routing decision on several of
+  the interpretations of this RFC.  This second octect in the header was
+  originally named the Type of Service field in Postel's RFC 971.  This
+  choice allows you to select the treatment you wish to use in your
+  network.
+
+  None indicates that the ToS field will not be used to make routing
+  decisions.
+
+  TOS indicates that the ToS field will be treated as specified in
+  RFC 1349.  The header of every IP packet carries a single TOS value
   with which the packet requests a certain treatment, e.g. low latency
-  (for interactive traffic), high throughput, or high reliability. If
-  you say Y here, you will be able to specify different routes for
-  packets with different TOS values.
+  (for interactive traffic), high throughput, high reliability, or minimum
+  cost.  These settings are mutually exclusive.  Note that the minimum cost
+  setting is clobbered if ECN is activated.
+
+  DSCP indicates that the ToS field will be treated as specified in
+  RFC 2474.  This selects treating the field as a DiffServ Differentiated
+  Service Code Point which allow the top 6 bits of the field to be used
+  to specify a per hop behaviour which is generally set by policy at each
+  routing point in the network.
 
 IP: use netfilter MARK value as routing key
 CONFIG_IP_ROUTE_FWMARK

# Minor fix do netfilter location in the kernel docs.
diff -urN linux-2.4.5/Documentation/kernel-docs.txt linux-2.4.5-mjf/Documentation/kernel-docs.txt
--- linux-2.4.5/Documentation/kernel-docs.txt	Fri Apr  6 13:42:48 2001
+++ linux-2.4.5-mjf/Documentation/kernel-docs.txt	Mon May 28 12:37:26 2001
@@ -333,7 +333,8 @@
        
      * Title: "The Kernel Hacking HOWTO"
        Author: Various Talented People, and Rusty.
-       URL: http://www.samba.org/~netfilter/kernel-hacking-HOWTO.html
+       URL: http://netfilter.gnumonks.org/unreliable-guides/kernel-hacking/
+		lk-hacking-guide.html
        Keywords: HOWTO, kernel contexts, deadlock, locking, modules,
        symbols, return conventions.
        Description: From the Introduction: "Please understand that I
@@ -393,9 +394,8 @@
        
      * Title: "Linux Kernel Locking HOWTO"
        Author: Various Talented People, and Rusty.
-       URL:
-       http://netfilter.kernelnotes.org/unreliable-guides/kernel-locking-
-       HOWTO.html
+       URL: http://netfilter.gnumonks.org/unreliable-guides/kernel-locking/
+		lklockingguide.html
        Keywords: locks, locking, spinlock, semaphore, atomic, race
        condition, bottom halves, tasklets, softirqs.
        Description: The title says it all: document describing the


# I've placed the mask for valid DSCP values here.
diff -urN linux-2.4.5/include/linux/ip.h linux-2.4.5-mjf/include/linux/ip.h
--- linux-2.4.5/include/linux/ip.h	Fri May 25 21:01:27 2001
+++ linux-2.4.5-mjf/include/linux/ip.h	Mon Jun  4 18:31:30 2001
@@ -38,6 +38,8 @@
 #define IPTOS_PREC_PRIORITY             0x20
 #define IPTOS_PREC_ROUTINE              0x00
 
+/* RFC 2474 Diffserv code point */
+#define IPTOS_DSCP_MASK		0xFC
 
 /* IP options */
 #define IPOPT_COPY		0x80


# Here, I use either the TOS mask from RFC 1349 or 2474,
# as selected by the configuration.
diff -urN linux-2.4.5/include/net/route.h linux-2.4.5-mjf/include/net/route.h
--- linux-2.4.5/include/net/route.h	Fri May 25 21:02:42 2001
+++ linux-2.4.5-mjf/include/net/route.h	Mon Jun  4 18:42:36 2001
@@ -129,9 +129,17 @@
 }
 
 #ifdef CONFIG_INET_ECN
-#define IPTOS_RT_MASK	(IPTOS_TOS_MASK & ~3)
+#define IPTOS_ECN_TOS_MASK 0xFC
 #else
-#define IPTOS_RT_MASK	IPTOS_TOS_MASK
+#define IPTOS_ECN_TOS_MASK 0xFF
+#endif
+
+#ifdef CONFIG_IP_ROUTE_RFC1349_TOS
+#define IPTOS_RT_MASK	(IPTOS_TOS_MASK & IPTOS_ECN_TOS_MASK)
+#elif defined CONFIG_IP_ROUTE_RFC2474_DSCP
+#define IPTOS_RT_MASK	(IPTOS_DSCP_MASK & IPTOS_ECN_TOS_MASK)
+#else
+#define IPTOS_RT_MASK	(IPTOS_TOS_MASK & IPTOS_ECN_TOS_MASK)
 #endif



# set up the choice option 
diff -urN linux-2.4.5/net/ipv4/Config.in linux-2.4.5-mjf/net/ipv4/Config.in
--- linux-2.4.5/net/ipv4/Config.in	Tue May  1 23:59:24 2001
+++ linux-2.4.5-mjf/net/ipv4/Config.in	Mon Jun  4 18:33:36 2001
@@ -14,7 +14,16 @@
       bool '      IP: fast network address translation' CONFIG_IP_ROUTE_NAT
    fi
    bool '    IP: equal cost multipath' CONFIG_IP_ROUTE_MULTIPATH
-   bool '    IP: use TOS value as routing key' CONFIG_IP_ROUTE_TOS
+ choice '    IP: use of TOS value as routing key' \
+        "None		CONFIG_IP_ROUTE_TOSNOTUSED \
+         TOS		CONFIG_IP_ROUTE_RFC1349_TOS \
+         DSCP		CONFIG_IP_ROUTE_RFC2474_DSCP"	None
+   if [ "$CONFIG_IP_ROUTE_RFC1349_TOS" = "y" ]; then
+	define_bool CONFIG_IP_ROUTE_TOS y
+   fi
+   if [ "$CONFIG_IP_ROUTE_RFC2474_DSCP" = "y" ]; then
+	define_bool CONFIG_IP_ROUTE_TOS y
+   fi
    bool '    IP: verbose route monitoring' CONFIG_IP_ROUTE_VERBOSE
    bool '    IP: large routing tables' CONFIG_IP_ROUTE_LARGE_TABLES
 fi



# A missed KERN_ERR in a printk.
diff -urN linux-2.4.5/net/ipv4/fib_rules.c linux-2.4.5-mjf/net/ipv4/fib_rules.c
--- linux-2.4.5/net/ipv4/fib_rules.c	Tue May  1 23:59:24 2001
+++ linux-2.4.5-mjf/net/ipv4/fib_rules.c	Thu May 31 14:01:19 2001
@@ -155,7 +155,7 @@
 		if (r->r_dead)
 			kfree(r);
 		else
-			printk("Freeing alive rule %p\n", r);
+			printk(KERN_ERR "Freeing alive rule %p\n", r);
 	}
 }
 
@@ -340,13 +340,13 @@
 		case RTN_UNREACHABLE:
 			read_unlock(&fib_rules_lock);
 			return -ENETUNREACH;
+		case RTN_PROHIBIT:
+			read_unlock(&fib_rules_lock);
+			return -EACCES;
 		default:
 		case RTN_BLACKHOLE:
 			read_unlock(&fib_rules_lock);
 			return -EINVAL;
-		case RTN_PROHIBIT:
-			read_unlock(&fib_rules_lock);
-			return -EACCES;
 		}
 
 		if ((tb = fib_get_table(r->r_table)) == NULL)



# a few comments for readability
diff -urN linux-2.4.5/net/ipv4/route.c linux-2.4.5-mjf/net/ipv4/route.c
--- linux-2.4.5/net/ipv4/route.c	Wed May 16 13:31:27 2001
+++ linux-2.4.5-mjf/net/ipv4/route.c	Thu May 31 16:32:56 2001
@@ -101,8 +101,8 @@
 
 #define RT_GC_TIMEOUT (300*HZ)
 
-int ip_rt_min_delay		= 2 * HZ;
-int ip_rt_max_delay		= 10 * HZ;
+int ip_rt_min_delay		= 2 * HZ;   /* try not to flush faster than */
+int ip_rt_max_delay		= 10 * HZ;  /* try to flush this fast */
 int ip_rt_max_size;
 int ip_rt_gc_timeout		= RT_GC_TIMEOUT;
 int ip_rt_gc_interval		= 60 * HZ;
@@ -398,6 +398,12 @@
   
 static spinlock_t rt_flush_lock = SPIN_LOCK_UNLOCKED;
 
+/*
+ * Call with delay == -1 to schedule a route cache flush ASAP
+ *   which is in ip_rt_min_delay jiffies
+ * Call with delay == 0 to cause a route cache flush NOW!
+ * Call with another value to flush the cash in `delay' jiffies
+ */
 void rt_cache_flush(int delay)
 {
 	unsigned long now = jiffies;

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ip-test

#!/bin/bash

for dev in eth2 eth1
do
    ip route flush dev $dev
    ip link set $dev down
    ip addr flush dev $dev
done


ip addr add 192.168.0.1/24 brd + dev eth1
ip link set eth1 up

ip addr add 192.168.0.2/24 brd + dev eth2
ip link set eth2 up

ip route flush dev eth2
ip route flush dev eth1

ip route add 192.168.0.0/24 dsfield 0xe0 proto static table main dev eth2
ip route add 192.168.0.0/24 dsfield 0xc0 proto static table main dev eth2
ip route add 192.168.0.0/24 dsfield 0x08 proto static table main dev eth2
ip route add 192.168.0.0/24 dsfield 0x88 proto static table main dev eth2
ip route add 192.168.0.0/24 dsfield 0x89 proto static table main dev eth2
ip route add 192.168.0.0/24 dsfield 0x8c proto static table main dev eth2

ip route add 192.168.0.0/24 dsfield 0x00 proto static table main dev eth1

ip route list table main


rtn=0
while read tos src comment
do
    ping -Q $tos -c 1 192.168.0.3 > ip-test.$$
    if grep -q "from 192.168.$src :" ip-test.$$ ; then
	msg=ok
    else
	msg=FAILED!
	rtn=$(( $rtn + 1 ))
    fi
    echo -e \\ntos $tos should come from $src: $msg
    grep from ip-test.$$
done <<EOF
0x00 0.1
0xa0 0.1
0xa8 0.1
0xc0 0.2
0xe0 0.2
0x88 0.2
0x89 0.2	# ECN blows away lsb when enabled
0x8c 0.2
EOF

/bin/rm ip-test.$$

if [ $rtn -eq 0 ] ; then
	echo -e \\nAll tests passed
else
	echo -e \\nFailed $rtn tests
fi

exit $rtn

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="unpatched.results"

192.168.0.0/24 tos 0xe0 dev eth2  proto static  scope link 
192.168.0.0/24 tos 0xc0 dev eth2  proto static  scope link 
192.168.0.0/24 tos 0x8c dev eth2  proto static  scope link 
192.168.0.0/24 tos 0x89 dev eth2  proto static  scope link 
192.168.0.0/24 tos 0x88 dev eth2  proto static  scope link 
192.168.0.0/24 tos 0x08 dev eth2  proto static  scope link 
192.168.0.0/24 dev eth1  proto static  scope link 
10.11.0.0/16 dev eth0  proto kernel  scope link  src 10.11.11.103 
127.0.0.0/8 dev lo  scope link 
default via 10.11.1.1 dev eth0 

tos 0x00 should come from 0.1: ok
PING 192.168.0.3 (192.168.0.3) from 192.168.0.1 : 56(84) bytes of data.
64 bytes from 192.168.0.3: icmp_seq=0 ttl=255 time=250 usec

tos 0xa0 should come from 0.1: ok
PING 192.168.0.3 (192.168.0.3) from 192.168.0.1 : 56(84) bytes of data.
64 bytes from 192.168.0.3: icmp_seq=0 ttl=255 time=142 usec

tos 0xa8 should come from 0.1: FAILED!
PING 192.168.0.3 (192.168.0.3) from 192.168.0.2 : 56(84) bytes of data.
64 bytes from 192.168.0.3: icmp_seq=0 ttl=255 time=233 usec

tos 0xc0 should come from 0.2: FAILED!
PING 192.168.0.3 (192.168.0.3) from 192.168.0.1 : 56(84) bytes of data.
64 bytes from 192.168.0.3: icmp_seq=0 ttl=255 time=156 usec

tos 0xe0 should come from 0.2: FAILED!
PING 192.168.0.3 (192.168.0.3) from 192.168.0.1 : 56(84) bytes of data.
64 bytes from 192.168.0.3: icmp_seq=0 ttl=255 time=149 usec

tos 0x88 should come from 0.2: ok
PING 192.168.0.3 (192.168.0.3) from 192.168.0.2 : 56(84) bytes of data.
64 bytes from 192.168.0.3: icmp_seq=0 ttl=255 time=149 usec

tos 0x89 should come from 0.2: ok
PING 192.168.0.3 (192.168.0.3) from 192.168.0.2 : 56(84) bytes of data.
64 bytes from 192.168.0.3: icmp_seq=0 ttl=255 time=143 usec

tos 0x8c should come from 0.2: FAILED!
PING 192.168.0.3 (192.168.0.3) from 192.168.0.1 : 56(84) bytes of data.
64 bytes from 192.168.0.3: icmp_seq=0 ttl=255 time=151 usec

Failed 4 tests

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patched.results"

192.168.0.0/24 tos 0xe0 dev eth2  proto static  scope link 
192.168.0.0/24 tos 0xc0 dev eth2  proto static  scope link 
192.168.0.0/24 tos 0x8c dev eth2  proto static  scope link 
192.168.0.0/24 tos 0x89 dev eth2  proto static  scope link 
192.168.0.0/24 tos 0x88 dev eth2  proto static  scope link 
192.168.0.0/24 tos 0x08 dev eth2  proto static  scope link 
192.168.0.0/24 dev eth1  proto static  scope link 
10.11.0.0/16 dev eth0  proto kernel  scope link  src 10.11.11.103 
127.0.0.0/8 dev lo  scope link 
default via 10.11.1.1 dev eth0 

tos 0x00 should come from 0.1: ok
PING 192.168.0.3 (192.168.0.3) from 192.168.0.1 : 56(84) bytes of data.
64 bytes from 192.168.0.3: icmp_seq=0 ttl=255 time=234 usec

tos 0xa0 should come from 0.1: ok
PING 192.168.0.3 (192.168.0.3) from 192.168.0.1 : 56(84) bytes of data.
64 bytes from 192.168.0.3: icmp_seq=0 ttl=255 time=120 usec

tos 0xa8 should come from 0.1: ok
PING 192.168.0.3 (192.168.0.3) from 192.168.0.1 : 56(84) bytes of data.
64 bytes from 192.168.0.3: icmp_seq=0 ttl=255 time=204 usec

tos 0xc0 should come from 0.2: ok
PING 192.168.0.3 (192.168.0.3) from 192.168.0.2 : 56(84) bytes of data.
64 bytes from 192.168.0.3: icmp_seq=0 ttl=255 time=137 usec

tos 0xe0 should come from 0.2: ok
PING 192.168.0.3 (192.168.0.3) from 192.168.0.2 : 56(84) bytes of data.
64 bytes from 192.168.0.3: icmp_seq=0 ttl=255 time=122 usec

tos 0x88 should come from 0.2: ok
PING 192.168.0.3 (192.168.0.3) from 192.168.0.2 : 56(84) bytes of data.
64 bytes from 192.168.0.3: icmp_seq=0 ttl=255 time=125 usec

tos 0x89 should come from 0.2: ok
PING 192.168.0.3 (192.168.0.3) from 192.168.0.2 : 56(84) bytes of data.
64 bytes from 192.168.0.3: icmp_seq=0 ttl=255 time=125 usec

tos 0x8c should come from 0.2: ok
PING 192.168.0.3 (192.168.0.3) from 192.168.0.2 : 56(84) bytes of data.
64 bytes from 192.168.0.3: icmp_seq=0 ttl=255 time=126 usec

All tests passed

--IS0zKkzwUGydFO0o--
