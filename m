Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279362AbRJWK5a>; Tue, 23 Oct 2001 06:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279369AbRJWK5U>; Tue, 23 Oct 2001 06:57:20 -0400
Received: from matrix2.enst.fr ([137.194.2.14]:41709 "HELO smtp2.enst.fr")
	by vger.kernel.org with SMTP id <S279362AbRJWK5L>;
	Tue, 23 Oct 2001 06:57:11 -0400
Message-Id: <200110231057.MAA23475@email.enst.fr>
Content-Type: text/plain; charset=US-ASCII
From: Mathieu Seigneurin <seigneur@email.enst.fr>
Subject: Multicast packet delivery question/issue (2.4.10)
Date: Tue, 23 Oct 2001 12:58:18 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

i'm having some issues with incoming multicast packets not being directed to 
the sockets I was expecting (ipv4, kernel 2.4.10 w/ext3, realtek RTL-8139 
NIC).

Short description:
-------------------
Here's what I do (from a Sun or IBM 1.3 Java VM):
- Create mcast socket A and set it up to listen on 239.0.0.1:12345
- Create mcast socket B and set it up to listen on 239.0.1.1:12345 (same 
process or not, though that shouldn't matter, really)
(The actual addresses have nothing to do with it, it's just the port that 
need to be the same)
Once the two sockets are up, if I send some multicast traffic on 239.0.0.1, 
both A and B receive it. Same thing with the other address. Basically, A and 
B can receive traffic from addresses they've not joined.

Now I guess the application should be able to filter the bad traffic out, but 
this behavior seems a bit odd.
Is it the expected behavior ? (it isn't on the Solaris boxes I have access 
to, as far as I can tell. I tried it after I was about sure that my code 
wasn't just complete crap.)
Do I need to send more info (hw/sw) for this to be undestandable ?

Any info appreciated. (I have not subscribed to this list directly, but get 
the digest version from lists.us.dell.com)
(I've tried searches on google and the lkml archives but coulnd't find 
anything.)
------------------

Now for my utter newbie wonderings inside the ipv4 kernel code, if you're 
interested.

Since I found this a bit strange, I looked in kernel-docs.txt for some 
pointers on networking, and found some real good doc, and started looking.
I found the following:

- multicast addresses a group has joined are stored in the list
	socket->protinfo.af_inet.mc_list
- that list is not checked (as far as I could determine, which is pretty 
weak) in the udp delivery code.

I then examined the udp_v4_mcast_next function which seemed to be where all 
the action was going on. That function does filter on the port, but only 
checks the socket->daddr and socket->rcv_saddr fields which in my limited 
testing were alway 0 (and thus ignored by the filter) for my multicast 
sockets. That was consistent with what I was experiencing on the application 
level.
Then, since I had nothing better to do, I gave a shot at actually changing 
the code and ended up with the diff at the end of this message. Now obviously 
I have no idea of the implications of such a thing - but if someone wants to 
tell me if this a good thing or not (I'm guessing it might actually break 
things that were relying on the current behavior), I'd be happy to hear about 
it.

Thanks a lot for having read this far!
Mathieu Seigneurin
CS student in Paris, France, and great fan of Linux and the people behind it.


--- ./linux-2.4.10-ext3.orig/net/ipv4/udp.c     Fri Sep  7 20:01:21 2001
+++ ./linux-2.4.10-ext3.new/net/ipv4/udp.c      Tue Oct 23 12:04:25 2001
@@ -87,6 +87,7 @@
 #include <net/ip.h>
 #include <net/protocol.h>
 #include <linux/skbuff.h>
+#include <linux/igmp.h>
 #include <net/sock.h>
 #include <net/udp.h>
 #include <net/icmp.h>
@@ -268,6 +269,7 @@
 {
        struct sock *s = sk;
        unsigned short hnum = ntohs(loc_port);
+       struct ip_mc_socklist *i;
        for(; s; s = s->next) {
                if ((s->num != hnum)                                    ||
                    (s->daddr && s->daddr!=rmt_addr)                    ||
@@ -275,7 +277,13 @@
                    (s->rcv_saddr  && s->rcv_saddr != loc_addr)         ||
                    (s->bound_dev_if && s->bound_dev_if != dif))
                        continue;
-               break;
+               // We know this packet is coming from a mcast port
+               // that the packet is from. We need to check
+               // if the user also joined this mcast address.
+               for (i=s->protinfo.af_inet.mc_list; i; i=i->next)
+                       if (i->multi.imr_multiaddr.s_addr == loc_addr)
+                               break; // out of the mc_list loop
+               if (i) break; // out of the sock list
        }
        return s;
 }

