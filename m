Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131482AbRARVwK>; Thu, 18 Jan 2001 16:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132754AbRARVwA>; Thu, 18 Jan 2001 16:52:00 -0500
Received: from [204.76.174.2] ([204.76.174.2]:49933 "EHLO uccs3.uccsda.org")
	by vger.kernel.org with ESMTP id <S131482AbRARVvv>;
	Thu, 18 Jan 2001 16:51:51 -0500
From: Andrew <andrewd@uccsda.org>
Reply-To: depaan@bibleinfo.com
To: linux-kernel@vger.kernel.org
Subject: kernel 2.4, iproute2 and routing rules that refuse to match
Date: Thu, 18 Jan 2001 13:51:28 -0800
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <0101181351280C.02284@orion>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I'm posting here as a last resort. I've been working on this problem for about
two months now without success. I've tried everything I can think of to no
avail. I'm hoping that by posting here, someone can at least point me in the
right direction. If replying to the list, please CC my email address.

I'm trying to configure a box to do rule based routing and act as a smart 
router between a couple of internal networks, and two independant connections 
to the internet. The machine I'm working with is
a 486DX100 with 32MB of ram and 4 10-T nics in it. 3 are 3c503's and one is a 
3c507. I'm using a Redhat 6.2 base install, and have manually upgraded as 
necessary allong the way to the point that I am now running the latest 2.4 
official release.

I'm having a very strange problem with rule based routing. I've narrowed it 
down quite a bit
and I'm not sure where to go from here. I've posted several time to the 
advanced routing
mailing list without success. I don't know if this is too complicated for 
people or what.
Though I have a hard time believing this based on my testing, I suppose it 
could be a bug
in the code or something. If it is, I wouldn't think it too hard to fix 
(famous last words),
but having never hacked at the kernel before, I wouldn't even know where to 
begin looking.

More likely, I'm just missing something. I have observed the exact same 
behavior under
kernels 2.2.16, 2.2.17, 2.2.18, and 2.4.0 (just released). I am currently 
running kernel
2.4.0.

Anyway, let me describe my problem. I've narrowed things down to a very 
simple test case.
Just as a point of reference, I start by freshly booting my linux router (see 
below),
and when it comes up, I use the "ip rule ls" command to list my routing 
rules, seeing the following:

#router:~> ip rule ls
0:      from all lookup local 
32766:  from all lookup main 
32767:  from all lookup default 

quite normal. here's my topology:
                                 
                                  |
                                  |                +-------+
                                  +----------------+ orion +
                                  |                +-------+
                                  |                (172.X.X.2)
                                  |(172.X.X.1)
                                  |eth0
         _/\__/\_             +---+----+            _/\__/\_
        /        \     (63...)|  Linux |(204...)   /        \
       ( Internet )-----------+(Router)+----------( Internet )
        \_  __  _/        eth3|        |eth2       \_  __  _/
          \/  \/              +----+---+             \/  \/   
                               eth1|63..
                                   |204..x
                                   |
                 --+---------------+----------+--  <---single physical net
                   |                          |        (i.e. one hub)
                   |                          |
               +---+---+ 63..1            +---+---+ 63..2
               | Linux | 63..4            | Linux | 63..3
               +-------+ 204..1           +-------+ 204..2
                         204..4                     204..3


Starting with all my interfaces up, and with the rule's shown by "ip rule ls" 
above, 
I run the following script:(slightly edited to protect the guilty)

#!/bin/sh
#
##############################################################################
# Define routing rules
##############################################################################

#rules for packets coming in eth0 (LAN)
        ip rule add iif eth0 to 204.x.x.0/24 lookup to-lan priority 100
        ip rule add iif eth0 lookup main priority 110

#catch all rule 
        ip rule add from 0.0.0.0/0 type blackhole lookup bit-bucket priority 
500


##############################################################################
# Create routing tables referenced by rules above
#       Note: the table names used below must exist in the 
#             /etc/iproute2/rt_tables file
##############################################################################

#to-lan table routes
        ip route add default dev eth0 table to-lan

#bit-bucket table routes
        ip route add blackhole default table bit-bucket

# Make rules/routes active
ip route flush cache

# Enable IP forwarding since it is disabled by default
echo "1" > /proc/sys/net/ipv4/ip_forward

#---------end script

When I'm all done, an ip rule ls shows the following

0:      from all lookup local 
100:    from all to 204.x.x.0/24 iif eth0 lookup to-lan
110:    from all iif eth0 lookup main
500:    from all lookup bit-bucket blackhole
32766:  from all lookup main 
32767:  from all lookup default 

So far so good. I can now hop over to orion and begin to test. I set
the default gw on orion to point to 172.x.x.1 and try to ping 
204.x.x.2 (our dns server) which answers back fine. So rule 100
is working and redirecting things to the cisco router on our 172
network which has that particular 204 network attached to it.

But when I ping 172.x.x.1, my router's address, I get nothing. Hopping
over to the router's terminal and running tcpdump shows me that the packets
are indeed arriving but they aren't making it. As it ends up, they are 
getting blackholed by rule 500 above. I know this because If I delete
rule 500 from the command line the ping starts getting responded to, 
having been matched by rule 32766. Furthermore if I delete rule 32766 
after that, it quits again.  Alternately, instead of removing rule 500, I can 
insert rule 105 as follows:

#router:~> ip rule add from 0/0 lookup main priority 105

and things start working just fine.

What seems to be happening is that for some reason packets coming in are not
matching the condition of the specific local interface specified
by rule 110, and are winding up matching the blackhole rule that 
follows.

I've spent many hours pouring through Alexy's ip-cref document, and from what 
I can tell I'm doing the right things. I've tried various permutations of the 
offending rule, and it seems
that anything which tries to match an address, an address range, or
a local interface on a locally attached network won't match. Sure the ip 
command takes and
adds the rule OK but the kernel won't match the packets like it seems it 
should.

Incidentally, routing across my router works just fine. If I match the 
destination
address range of the boxes on the other side of my router, and route the
packets to the DMZ, everything works great. 

It's almost as if there is a bug in the rule matching code somewhere
which doesn't properly handle this specific condition. But then again,
why would this bug manifest itself across so many different kernels, including
2.4.0 in which I understand the networking has been completely rewritten?

One important gotcha I found when testing is after every change you make,
you have to run "ip route flush cache" to make it take effect. I've
been down that road already, we're not dealing with that here.

Anyway, I've troubleshot this about as far as I can with the knowledge I 
currently have, and I was hoping someone out there might have some usefull
suggestions.

You can review my postings about this issue in the lartc advanced routing
mailing list archives by looking through q4 of 2000 for the following
subject lines:

(http://mailman.ds9a.nl/pipermail/lartc/2000q4/author.html)

[LARTC] A complicated routing scenario (for me at least)  
[LARTC] Backup Route   Andrew 
[LARTC] A bug in ip?   Andrew 
[LARTC] simple routing problem... (what am I missing?)   Andrew 
[LARTC] Can't one filter based on a single destination address?   Andrew 
[LARTC] Advanced Routing problem (Can someone PLEASE answer this!)   Andrew 

Thanks in advance for any help. If this advanced routing is going to be of
any use to me, I need to get this resoved. The only other option I know of
is to buy another $10,000 cisco router (not very appealing to say the least).

-Andrew


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
