Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318526AbSH1Axn>; Tue, 27 Aug 2002 20:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318519AbSH1Axn>; Tue, 27 Aug 2002 20:53:43 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:33195 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318518AbSH1Axh>;
	Tue, 27 Aug 2002 20:53:37 -0400
Importance: Normal
Sensitivity: 
Subject: IPv6 PMTU/MTU related patch for 2.5.31 kernel
To: linux-kernel@vger.kernel.org
Cc: linux-net@vger.kernel.org, "LTC IPv6" <LTC_IPv6@us.ibm.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFB2D76E3D.4582658B-ON88256C22.005CB002@boulder.ibm.com>
From: "Shirley Ma" <xma@us.ibm.com>
Date: Tue, 27 Aug 2002 17:56:34 -0700
X-MIMETrack: Serialize by Router on D03NM037/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 08/27/2002 06:57:50 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will fix the following IPv6 PMTU & MTU problems:

1.PMTU is not RFC1981 conformance to Section 4. Protocol Requirements.

An attempt to detect an increase MUST NOT be done less than 5 minutes
after a Packet Too Big Messages has been received for the give path.
The recommended setting for this timer is twice its minimum value (10
minutes).

Without the patch TAHI test failure on detecting PMTU increase, after
applying
this patch all PMTU tests pass.

2. PMTU doesn't set as IPV6_MIN_MTU if detecting any MTU size less than
   IPV6_MIN_MTU.

3. Administratively changing MTU doesn't reflect on interface route

Produce this problem by doing below steps on one side:

      a. ifconfig eth0 mtu 1400
      b. ping6 -s 1450 xxxx (the other side ipv6 address)   (tcpdump will
find
the fragmented packets)
      c. ifconfig eth0 mtu 1500
      d. ping6 -s 1450 xxxx (the other side ipv6 address)   (packets are
still
fragmented, pmtu = 1500 will never be taken place.)

4.Interface MTU change isn't taken place for IPv6.

There is  a bug in addrconf_notify(). If bring interface down and change
the MTU size, after bringing the interface up, the changed MTU doesn't
reflect
in IPv6. It is easy to reproduce it.

Produce this problem by doing below steps on one side:

      a. ifdown eth0
      b. ifconfig eth0 mtu 1400
      c. ifup eth0
      d. ping6 -s 1450 xxxx (the other side ipv6 address)

5.  Route dereference is negative in ndisc_na_rcv(). If race happens, check
route reference == 0 is invalid,
potentially cause poiner to NULL. In file ndisc_na_rcv() under
linux24/net/ipv6/ndisc.c
file, route deference happens twice. The derefence before ip6_del_rt()
shouldn't
happen. ip6_del_rt() itself will do the deference.


Any comments are welcome!


Thanks

Shirley Ma


diff -urN linux-2.5.31/net/ipv6/addrconf.c linux-2.5.31pmtu/net/ipv6/addrconf.c
--- linux-2.5.31/net/ipv6/addrconf.c      Sat Aug 10 18:41:55 2002
+++ linux-2.5.31pmtu/net/ipv6/addrconf.c  Wed Aug 14 09:33:20 2002
@@ -1272,9 +1272,8 @@
 int addrconf_notify(struct notifier_block *this, unsigned long event,
                void * data)
 {
-     struct net_device *dev;
-
-     dev = (struct net_device *) data;
+     struct net_device *dev = (struct net_device *) data;
+     struct inet6_dev *idev = __in6_dev_get(dev);

      switch(event) {
      case NETDEV_UP:
@@ -1291,16 +1290,27 @@
                  addrconf_dev_config(dev);
                  break;
            };
+           if (idev) {
+                 /* If the MTU changed during the interface down, when the
+                    interface up, the changed MTU must be reflected in the
+                    idev as well as routers.
+                  */
+                 if (idev->cnf.mtu6 != dev->mtu && dev->mtu >= IPV6_MIN_MTU) {
+                       rt6_mtu_change(dev, dev->mtu);
+                       idev->cnf.mtu6 = dev->mtu;
+                 }
+                 /* If the changed mtu during down is lower than IPV6_MIN_MTU
+                    stop IPv6 on this interface.
+                  */
+                 if (dev->mtu < IPV6_MIN_MTU)
+                       addrconf_ifdown(dev, event != NETDEV_DOWN);
+           }
            break;

      case NETDEV_CHANGEMTU:
-           if (dev->mtu >= IPV6_MIN_MTU) {
-                 struct inet6_dev *idev;
-
-                 if ((idev = __in6_dev_get(dev)) == NULL)
-                       break;
-                 idev->cnf.mtu6 = dev->mtu;
+           if ( idev && dev->mtu >= IPV6_MIN_MTU) {
                  rt6_mtu_change(dev, dev->mtu);
+                 idev->cnf.mtu6 = dev->mtu;
                  break;
            }

diff -urN linux-2.5.31/net/ipv6/ndisc.c linux-2.5.31pmtu/net/ipv6/ndisc.c
--- linux-2.5.31/net/ipv6/ndisc.c   Sat Aug 10 18:41:41 2002
+++ linux-2.5.31pmtu/net/ipv6/ndisc.c     Wed Aug 14 09:27:41 2002
@@ -1166,7 +1166,6 @@
                              if (rt) {
                                    /* It is safe only because
                                       we aer in BH */
-                                   dst_release(&rt->u.dst);
                                    ip6_del_rt(rt);
                              }
                        }
diff -urN linux-2.5.31/net/ipv6/route.c linux-2.5.31pmtu/net/ipv6/route.c
--- linux-2.5.31/net/ipv6/route.c   Sat Aug 10 18:41:23 2002
+++ linux-2.5.31pmtu/net/ipv6/route.c     Wed Aug 14 09:33:27 2002
@@ -976,7 +976,11 @@
            if (net_ratelimit())
                  printk(KERN_DEBUG "rt6_pmtu_discovery: invalid MTU value %d\n",
                         pmtu);
-           return;
+           /* According to RFC1981, the PMTU is set to the IPv6 minimum
+              link MTU if the node receives a Packet Too Big message
+              reporting next-hop MTU that is less than the IPv6 minimum MTU.
+            */
+           pmtu = IPV6_MIN_MTU;
      }

      rt = rt6_lookup(daddr, saddr, dev->ifindex, 0);
@@ -1014,9 +1018,14 @@
            nrt = rt6_cow(rt, daddr, saddr);
            if (!nrt->u.dst.error) {
                  nrt->u.dst.pmtu = pmtu;
-                 dst_set_expires(&rt->u.dst, ip6_rt_mtu_expires);
+                 /* According to RFC 1981, detecting PMTU increase shouldn't be
+                    happened within 5 mins, the recommended timer is 10 mins.
+                    Here this route expiration time is set to ip6_rt_mtu_expires
+                    which is 10 mins. After 10 mins the decreased pmtu is expired
+                    and detecting PMTU increase will be automatically happened.
+                  */
+                 dst_set_expires(&nrt->u.dst, ip6_rt_mtu_expires);
                  nrt->rt6i_flags |= RTF_DYNAMIC|RTF_EXPIRES;
-                 dst_release(&nrt->u.dst);
            }
      } else {
            nrt = ip6_rt_copy(rt);
@@ -1026,9 +1035,18 @@
            nrt->rt6i_dst.plen = 128;
            nrt->u.dst.flags |= DST_HOST;
            nrt->rt6i_nexthop = neigh_clone(rt->rt6i_nexthop);
-           dst_set_expires(&rt->u.dst, ip6_rt_mtu_expires);
+           dst_set_expires(&nrt->u.dst, ip6_rt_mtu_expires);
            nrt->rt6i_flags |= RTF_DYNAMIC|RTF_CACHE|RTF_EXPIRES;
            nrt->u.dst.pmtu = pmtu;
+           /* If there is no reference to this route, this route will be
+              deleted by fib6_run_gc() within 30 secs. The cached decreased
+              PMTU will be gone. It's possible to be deleted before any
+              other protocol using it. Then the old larger pmtu will be used,
+              which against RFC1981: detect an increase MUST NOT be done
+              less than 5 minutes after a Packet Too Big Messages has
+              been received for the given path.
+            */
+           dst_hold(&nrt->u.dst);
            rt6_ins(nrt);
      }

@@ -1380,15 +1398,32 @@
 static int rt6_mtu_change_route(struct rt6_info *rt, void *p_arg)
 {
      struct rt6_mtu_change_arg *arg = (struct rt6_mtu_change_arg *) p_arg;
-
+     struct inet6_dev *idev;
      /* In IPv6 pmtu discovery is not optional,
         so that RTAX_MTU lock cannot disable it.
         We still use this lock to block changes
         caused by addrconf/ndisc.
      */
+     idev = __in6_dev_get(arg->dev);
+     /* For administrative MTU increase, there is no way to discover
+        IPv6 PMTU increase, so PMTU increase should be updated here.
+        Since RFC 1981 doesn't include administrative MTU increase
+        update PMTU increase is a MUST. (i.e. jumbo frame)
+      */
+     /*
+        If new MTU is less than route PMTU, this new MTU will be the
+        lowest MTU in the path, update the route PMTU to refect PMTU
+        decreases; if new MTU is greater than route PMTU, and the
+        old MTU is the lowest MTU in the path, update the route PMTU
+        to refect the increase. In this case if the other nodes' MTU
+        also have the lowest MTU, TOO BIG MESSAGE will be lead to
+        PMTU discouvery.
+      */
      if (rt->rt6i_dev == arg->dev &&
-         rt->u.dst.pmtu > arg->mtu &&
-         !(rt->u.dst.mxlock&(1<<RTAX_MTU)))
+         !(rt->u.dst.mxlock&(1<<RTAX_MTU)) &&
+           (rt->u.dst.pmtu > arg->mtu ||
+            (rt->u.dst.pmtu < arg->mtu &&
+           rt->u.dst.pmtu == idev->cnf.mtu6)))
            rt->u.dst.pmtu = arg->mtu;
      rt->u.dst.advmss = max_t(unsigned int, arg->mtu - 60, ip6_rt_min_advmss);
      if (rt->u.dst.advmss > 65535-20)




