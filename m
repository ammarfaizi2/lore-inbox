Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312753AbSCVQgC>; Fri, 22 Mar 2002 11:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312754AbSCVQfr>; Fri, 22 Mar 2002 11:35:47 -0500
Received: from port-212-202-185-53.reverse.qdsl-home.de ([212.202.185.53]:27663
	"EHLO el-zoido.localnet") by vger.kernel.org with ESMTP
	id <S312753AbSCVQfb>; Fri, 22 Mar 2002 11:35:31 -0500
Message-ID: <3C9B5D4E.9CA3593D@trash.net>
Date: Fri, 22 Mar 2002 17:35:26 +0100
From: Patrick McHardy <kaber@trash.net>
X-Mailer: Mozilla 4.75 [de] (X11; U; Linux 2.4.18-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Guus Sliepen <guus@warande3094.warande.uu.nl>
CC: linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Updated Equalize patch
In-Reply-To: <3C9A4270.56C09FCB@trash.net> <20020321203835.GT20420@sliepen.warande.net> <3C9A489D.DD8993C1@trash.net> <20020321210520.GU20420@sliepen.warande.net>
Content-Type: multipart/mixed;
 boundary="------------4E58E2178CFCC10BA32DCEF9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dies ist eine mehrteilige Nachricht im MIME-Format.
--------------4E58E2178CFCC10BA32DCEF9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi.

Unfortunately i overlooked one read_lock(..), here's the corrected patch.

> I'll try out your updated patch later, but can you tell me if it
> works without warnings or errors for you? What is the maximum throughput
> you get?

What kind of warnings/errors do you mean ?
I haven't tested it extensively yet, but the first results look very
promising,
equalizing traffic over two links (256kbit + 128kbit) resulted in a total
bandwidth
of 363kbit with one connection, although it didn't work right until i started
a ping
in the background. Also my second gateway was marked "dead" but this is
non-related i guess. I'll do some more testing this weekend and let you know.

Bye, Patrick



--------------4E58E2178CFCC10BA32DCEF9
Content-Type: text/plain; charset=us-ascii;
 name="equalize_2.4.18.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="equalize_2.4.18.patch"

diff -urN linux-2.4.18-clean/Documentation/networking/load-balancing.txt linux-2.4.18/Documentation/networking/load-balancing.txt
--- linux-2.4.18-clean/Documentation/networking/load-balancing.txt	Thu Jan  1 01:00:00 1970
+++ linux-2.4.18/Documentation/networking/load-balancing.txt	Fri Mar 22 17:21:21 2002
@@ -0,0 +1,125 @@
+Load balancing using multipaths (patch version: 5)
+==================================================
+
+Contact Guus Sliepen <sliepen@phys.uu.nl> if you need help, want to know
+more, have remarks or further idea's with relation to this.
+
+Intro
+-----
+
+If you have multiple physical network links to another computer, and you want
+some kind of load balancing, you can now do so. Please note that this only
+applies to IPv4 traffic, not for IPX, IPv6 or any other protocol (yet).
+
+Needed
+-----
+
+* LATEST iproute package from ftp://ftp.inr.ac.ru/ip-routing/
+* CONFIG_IP_ROUTE_MULTIPATH enabled in kernel configuration (it's in
+  Networking options, below the Advanced Router option you'll have to enable
+  too)
+* Ofcourse you must also have patched your kernel and recompiled it for this
+  feature to be enabled.
+   
+To do
+-----
+
+* Make sure the devices you want to combine are up, they all accept the
+  packets you want to send (ie, they must all have the same IP address/netmask
+  or something clever to get the same result)
+* Just to make sure, remove any routes via those devices (route del ...)
+* Now add all routes via one iproute command using the 'nexthops' statement:
+
+  ip route add <destaddress>/<netmask> equalize \\
+     nexthop dev <first device> \\
+     nexthop dev <second device> \\
+     nexthop ...
+     
+* Just to make sure, flush route cache:
+
+  echo 1 >/proc/sys/net/ipv4/route/flush
+  
+Example
+-------
+
+This is an example showing how to make a 20 Mbit connection between two
+computers using 2 10 Mbit ethernet cards per computer. Computer 1 has IP
+192.168.1.1 and computer 2 has IP 192.168.1.2. We start from scratch:
+
+[computer1]~/>ifconfig eth0 192.168.1.1 netmask 255.255.255.0
+[computer1]~/>route del -net 192.168.1.0 netmask 255.255.255.0
+[computer1]~/>ifconfig eth1 192.168.1.1 netmask 255.255.255.0
+[computer1]~/>route del -net 192.168.1.0 netmask 255.255.255.0
+[computer1]~/>ip route add 192.168.1.0/24 equalize nexthop dev eth0 nexthop dev eth1
+[computer1]~/>echo 1 >/proc/sys/net/ipv4/route/flush
+
+[computer2]~/>ifconfig eth0 192.168.1.2 netmask 255.255.255.0
+[computer2]~/>route del -net 192.168.1.0 netmask 255.255.255.0
+[computer2]~/>ifconfig eth1 192.168.1.2 netmask 255.255.255.0
+[computer2]~/>route del -net 192.168.1.0 netmask 255.255.255.0
+[computer2]~/>ip route add 192.168.1.0/24 equalize nexthop dev eth0 nexthop dev eth1
+[computer2]~/>echo 1 >/proc/sys/net/ipv4/route/flush
+
+You can even add more computers, just replace the x in 192.168.1.x with the
+number of your computer, and make sure all eth0's are connected to each other
+and all eth1's. You can also use more devices, just ifconfig them all and
+remove the default routes that are generated, and add extra nexthops.
+
+Notes
+-----
+
+If you want to add a gateway entry in your routing table, and want it to be
+balanced too, you first have to make singlepath entries for every network
+interface you want to use, after that add the gateway with all the nexthops
+filled in, then delete the singlepath routes and then add the normal
+multipath route.
+
+Older patch versions used a /proc entry to control load-balancing. This does
+not work anymore. You should use the 'equalize' flag instead while adding new
+routes. You need a fresh version of iproute for that.
+
+Status
+------
+
+Packet type:		Balanced?	Note
+----------------------------------------------------------------------
+ARP			no		But we don't want them to ;)
+ICMP			yes
+Connectionless UDP	yes
+Connected UDP		yes
+Broadcast UDP		no		Would be nice if it would,
+					but this is rarely used for
+					high bandwith data transfers.
+TCP			yes		At least all data packets are,
+					maybe some control packets are
+					not.
+
+(Known) Bugs
+------------
+
+Due to the nature of the patch, every packet that follows a multipath uses
+a little memory that is not instantly cleaned up, but after a short period.
+This means that if your load gets higher, memory useage is higher. Since
+there is a limit to the memory that can be allocated for the packets, there
+is also a load limit. I cannot give exact numbers, however this patch does
+work with a load of 20 Mbit/s without problems on a 486 dx2 66, but not
+with a load of 400 Mbit/s on a box with multiple 400 Mhz Xeon processors.
+If the load gets too high, no memory is left for network IO, which stops
+for a while if that happens. The kernel should not crash if this happens.
+
+Technically
+-----------
+
+Load balancing needed a slight adjustment to the unpatched linux kernel,
+because of the route cache. Multipath is an option already found in the old
+2.1.x kernels. However, once a packet arrives, and it matches a multipath
+route, a (quasi random) device out of the list of nexthops is taken for its
+destination. That's okay, but after that the kernel puts everything into a
+hash table, and the next time a packet with the same source/dest/tos arrives,
+it finds it is in the hash table, and routes it via the same device as last
+time. The adjustment I made is as follows: If the kernel sees that the route
+to be taken has got the 'equalize' flag set, it not only selects the random
+device, but also tags the packet with the RTCF_EQUALIZE flag. If another
+packet of the same kind arrives, it is looked up in the hash table. It then
+checks if our flag is set, and if so, it deletes the entry in the cache and
+has to recalculate the destination again.
diff -urN linux-2.4.18-clean/include/linux/in_route.h linux-2.4.18/include/linux/in_route.h
--- linux-2.4.18-clean/include/linux/in_route.h	Fri Jun 12 07:52:33 1998
+++ linux-2.4.18/include/linux/in_route.h	Fri Mar 22 17:21:21 2002
@@ -18,6 +18,7 @@
 #define RTCF_MASQ	0x00400000
 #define RTCF_SNAT	0x00800000
 #define RTCF_DOREDIRECT 0x01000000
+#define RTCF_EQUALIZE	0x02000000
 #define RTCF_DIRECTSRC	0x04000000
 #define RTCF_DNAT	0x08000000
 #define RTCF_BROADCAST	0x10000000
diff -urN linux-2.4.18-clean/net/ipv4/fib_semantics.c linux-2.4.18/net/ipv4/fib_semantics.c
--- linux-2.4.18-clean/net/ipv4/fib_semantics.c	Mon Feb 25 20:38:14 2002
+++ linux-2.4.18/net/ipv4/fib_semantics.c	Fri Mar 22 17:21:21 2002
@@ -101,6 +101,10 @@
 };
 
 
+#ifdef CONFIG_IP_ROUTE_MULTIPATH
+unsigned int mp_counter=0;
+#endif
+
 /* Release a nexthop info record */
 
 void free_fib_info(struct fib_info *fi)
@@ -955,7 +959,7 @@
 	   it is pretty bad approximation.
 	 */
 
-	w = jiffies % fi->fib_power;
+	w = mp_counter++ % fi->fib_power;
 
 	change_nexthops(fi) {
 		if (!(nh->nh_flags&RTNH_F_DEAD) && nh->nh_power) {
diff -urN linux-2.4.18-clean/net/ipv4/ip_output.c linux-2.4.18/net/ipv4/ip_output.c
--- linux-2.4.18-clean/net/ipv4/ip_output.c	Wed Oct 17 23:16:39 2001
+++ linux-2.4.18/net/ipv4/ip_output.c	Fri Mar 22 17:21:21 2002
@@ -354,7 +354,7 @@
 
 	/* Make sure we can route this packet. */
 	rt = (struct rtable *)__sk_dst_check(sk, 0);
-	if (rt == NULL) {
+	if (rt == NULL || rt->u.dst.obsolete || rt->rt_flags&RTCF_EQUALIZE) {
 		u32 daddr;
 
 		/* Use correct destination address if we have options. */
diff -urN linux-2.4.18-clean/net/ipv4/route.c linux-2.4.18/net/ipv4/route.c
--- linux-2.4.18-clean/net/ipv4/route.c	Mon Feb 25 20:38:14 2002
+++ linux-2.4.18/net/ipv4/route.c	Fri Mar 22 17:23:03 2002
@@ -1419,8 +1419,11 @@
 		goto martian_destination;
 
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
-	if (res.fi->fib_nhs > 1 && key.oif == 0)
+	if (res.fi->fib_nhs > 1 && key.oif == 0) {
 		fib_select_multipath(&key, &res);
+		if (res.fi->fib_flags&RTM_F_EQUALIZE)
+			flags |= RTCF_EQUALIZE;
+	}
 #endif
 	out_dev = in_dev_get(FIB_RES_DEV(res));
 	if (out_dev == NULL) {
@@ -1622,15 +1625,15 @@
 int ip_route_input(struct sk_buff *skb, u32 daddr, u32 saddr,
 		   u8 tos, struct net_device *dev)
 {
-	struct rtable * rth;
+	struct rtable * rth, **rthp;
 	unsigned	hash;
 	int iif = dev->ifindex;
 
 	tos &= IPTOS_RT_MASK;
 	hash = rt_hash_code(daddr, saddr ^ (iif << 5), tos);
 
-	read_lock(&rt_hash_table[hash].lock);
-	for (rth = rt_hash_table[hash].chain; rth; rth = rth->u.rt_next) {
+	write_lock(&rt_hash_table[hash].lock);
+	for (rthp=&rt_hash_table[hash].chain; (rth=*rthp); rthp=&rth->u.rt_next) {
 		if (rth->key.dst == daddr &&
 		    rth->key.src == saddr &&
 		    rth->key.iif == iif &&
@@ -1639,16 +1642,22 @@
 		    rth->key.fwmark == skb->nfmark &&
 #endif
 		    rth->key.tos == tos) {
+			if (rth->rt_flags&RTCF_EQUALIZE) {
+				*rthp = rth->u.rt_next;
+				rth->u.rt_next = NULL;
+				rt_free(rth);
+				break;
+			}
 			rth->u.dst.lastuse = jiffies;
 			dst_hold(&rth->u.dst);
 			rth->u.dst.__use++;
 			rt_cache_stat[smp_processor_id()].in_hit++;
-			read_unlock(&rt_hash_table[hash].lock);
+			write_unlock(&rt_hash_table[hash].lock);
 			skb->dst = (struct dst_entry*)rth;
 			return 0;
 		}
 	}
-	read_unlock(&rt_hash_table[hash].lock);
+	write_unlock(&rt_hash_table[hash].lock);
 
 	/* Multicast recognition logic is moved from route cache to here.
 	   The problem was that too many Ethernet cards have broken/missing
@@ -1852,8 +1861,11 @@
 	}
 
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
-	if (res.fi->fib_nhs > 1 && key.oif == 0)
+	if (res.fi->fib_nhs > 1 && key.oif == 0) {
 		fib_select_multipath(&key, &res);
+		if (res.fi->fib_flags&RTM_F_EQUALIZE)
+			flags |= RTCF_EQUALIZE;
+	}
 	else
 #endif
 	if (!res.prefixlen && res.type == RTN_UNICAST && !key.oif)
@@ -1984,12 +1996,12 @@
 int ip_route_output_key(struct rtable **rp, const struct rt_key *key)
 {
 	unsigned hash;
-	struct rtable *rth;
+	struct rtable *rth, **rthp;
 
 	hash = rt_hash_code(key->dst, key->src ^ (key->oif << 5), key->tos);
 
-	read_lock_bh(&rt_hash_table[hash].lock);
-	for (rth = rt_hash_table[hash].chain; rth; rth = rth->u.rt_next) {
+	write_lock_bh(&rt_hash_table[hash].lock);
+	for (rthp=&rt_hash_table[hash].chain; (rth=*rthp); rthp=&rth->u.rt_next) {
 		if (rth->key.dst == key->dst &&
 		    rth->key.src == key->src &&
 		    rth->key.iif == 0 &&
@@ -1999,16 +2011,22 @@
 #endif
 		    !((rth->key.tos ^ key->tos) &
 			    (IPTOS_RT_MASK | RTO_ONLINK))) {
+			if (rth->rt_flags&RTCF_EQUALIZE) {
+				*rthp = rth->u.rt_next;
+				rth->u.rt_next = NULL;
+				rt_free(rth);
+				break;
+			}
 			rth->u.dst.lastuse = jiffies;
 			dst_hold(&rth->u.dst);
 			rth->u.dst.__use++;
 			rt_cache_stat[smp_processor_id()].out_hit++;
-			read_unlock_bh(&rt_hash_table[hash].lock);
+			write_unlock_bh(&rt_hash_table[hash].lock);
 			*rp = rth;
 			return 0;
 		}
 	}
-	read_unlock_bh(&rt_hash_table[hash].lock);
+	write_unlock_bh(&rt_hash_table[hash].lock);
 
 	return ip_route_output_slow(rp, key);
 }	
diff -urN linux-2.4.18-clean/net/ipv4/udp.c linux-2.4.18/net/ipv4/udp.c
--- linux-2.4.18-clean/net/ipv4/udp.c	Mon Feb 25 20:38:14 2002
+++ linux-2.4.18/net/ipv4/udp.c	Fri Mar 22 17:21:21 2002
@@ -740,6 +740,14 @@
 	sk->state = TCP_ESTABLISHED;
 	sk->protinfo.af_inet.id = jiffies;
 
+ #ifdef CONFIG_IP_ROUTE_MULTIPATH
+	if(rt->rt_flags&RTCF_EQUALIZE) {
+		ip_rt_put(rt);
+		sk->dst_cache=NULL;
+	}
+	else
+ #endif
+	
 	sk_dst_set(sk, &rt->u.dst);
 	return(0);
 }

--------------4E58E2178CFCC10BA32DCEF9--

