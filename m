Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279839AbRKFRWv>; Tue, 6 Nov 2001 12:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279856AbRKFRWl>; Tue, 6 Nov 2001 12:22:41 -0500
Received: from [141.30.228.244] ([141.30.228.244]:6414 "EHLO www.box.li")
	by vger.kernel.org with ESMTP id <S279853AbRKFRWf>;
	Tue, 6 Nov 2001 12:22:35 -0500
Date: Tue, 06 Nov 2001 18:24:22 +0100
From: Matthias Weidle <matt@box.li>
To: linux-kernel@vger.kernel.org
Subject: problems with GRE tunnels and PMTU discovery
Message-ID: <7580000.1005067462@atair.secunet.de>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!


i'm experiencing some trouble using GRE tunnels with PMTU discovery turned 
on.

i've already checked out the mailinglists and newsgroups for more infos but 
haven't found any solutions so far ...

first things first: here is my test setup.


    C1 ---- R1 ---- G1 ==== R2 ---- C2
             |               |
             |               |
              ----- G2 ------

             |------GRE------|


  ----  MTU 1500
  ====  MTU 1492


ok, what is that all about. C1 and C2 are some normal workstation PCs, R1 
and R2 are some linux routers which should have a few redundant links to 
each other over different gateways G1 and G2 (only 2 for simplicity here). 
in the real world there would be probably more intermediate gateways 
between R1 and R2.

now i wanna connect C1 and C2 over the routers R1 and R2 using GRE tunnels 
because we use private ips vor the C?---R? nets and don't want to use NAT.
so i have built two tunnels:
	R1 -- G1 -- R2
		and
	R1 -- G2 -- R2
for the two different paths between both routers.

on the router R1 i have set a route to the client net R2--C2 over the 
selected tunnel device and on router R2 vice versa for client net R1--C1.

in addition to that i use policy routing with multiple tables:
for example on R1:

  ip rule add from <ip_r1_1> table x
  ip rule add from <ip_r1_2> table y

  ip route add default via G1 dev eth1 table x
  ip route add default via G2 dev eth2 table y

equivalent entries are on R2.

the policy routing stuff is required since it might be that R1 has multiple 
connections via different gateways but R2 has only one connection, so we 
end up having only one ip address on R2 which we have to route via 
different gateways on R1 at the same time (for link checking purposes to 
select the best tunnel to use).

now that i described the setup a little bit i'll explain how the mtu 
problems arise:
i want to send packets between C1 and C2 ... take a ping for example.
what happens is that c1 sends the ping packet to R1 which in turn looks 
which gre tunnel to use (by looking up the route to c2). R1 then 
encapsulates the ping packet into one GRE packet with outer ips src=ip_r1_x 
and dst=ip_r2_x and sends this new packet over the appropriate gateway G?. 
on R2 the gre packet will be decapsulated and the inner packet is forwarded 
to C2 as the real destination.

so far so good! :)

as you probably noticed in the picture above one link has an MTU of 1492 
instead of the 1500 for ethernet (typical for ADSL for instance).

what happens if i send bigger packets for example by issuing a ping -s 2000 
to C2s destination?

well the ping packet will be fragmented on C1. then on R1 the two fragments 
will be GRE encapsulated and forwarded to G1. on G1 the bigger of the two 
fragments (which is 1500 with GRE header) can't be forwarded since the MTU 
to R2 is to small. hence G1 sends an ICMP UNREACHABLE NEED TO FRAG to R1 
since that is the src of the offending packet. R1 now receives that icmp 
and is supposed to lower the PMTU for the route to G1 so that the following 
packets will fit.
that much for theory ...

what happens in the real life is .... nothing :(
the icmp is silently ignored by the router R1 (and yes: i have enabled the 
pmtu discovery on R1 ... that is the default with linux 2.4.x).

i did some more investigation by looking at the code and discovered some 
issues:

in icmp.c: icmp_unreach(...)
if pmtu discovery is enabled and icmp need to frag is received there will 
be called the function ip_rt_frag_needed(...) which in turn tries to 
determine the new mtu size.
it is doing this by trying to find the appropriate route for that packet 
... but guess what: by putting some more debug output into the code i saw 
that the function is unable to find any route for that packet ... is this 
some issue with the multiple tables ???

as a workaround i added a temporary route to the main routing table and 
then the route was found and the mtu was set correctly.

at the end of the icmp_unreach(...) function there will be called all 
registered error handlers for the protocol mentioned in the icmp packet. in 
my case that is the error routine for protocol 47 (gre encap) -> 
ipgre_err(...) in ip_gre.c. this error routine is supposed to detect that 
the mtu has to be lowered again since the GRE headers have to be stripped 
off the mtu length ... but that does not happen in the code :(


any idea how that issue can be fixed?

any help will be much appreciated!


thanks and best regards,
-- matt.











