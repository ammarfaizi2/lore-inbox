Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135926AbRAGHIL>; Sun, 7 Jan 2001 02:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135953AbRAGHIC>; Sun, 7 Jan 2001 02:08:02 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:25353 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S135926AbRAGHHs>;
	Sun, 7 Jan 2001 02:07:48 -0500
Message-ID: <3A58249F.86DD52BC@candelatech.com>
Date: Sun, 07 Jan 2001 01:11:11 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission 
 policy!) (Benchmarks)
In-Reply-To: <3A578F27.D2A9DF52@candelatech.com> <20010107042959.A14330@gruyere.muc.suse.de> <3A580B31.7998C783@candelatech.com> <20010107062744.A15198@gruyere.muc.suse.de>
Content-Type: multipart/mixed;
 boundary="------------9BC101C2C1F69CA8BF3B57E3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9BC101C2C1F69CA8BF3B57E3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andi Kleen wrote:

> > I'm willing to run such benchmarks, but what would make a good benchmark,
> > other than ifconfig -a?
> 
> ifconfig -a is fine IMHO. Everything else I know is just a single pass through
> the lists (which even at 4000 is not very significant)

Hardware:  Celeron 500, mostly idle (ie not too scientific!!)
ifconfig:
  [root@candle bin]# /sbin/ifconfig --version
  net-tools 1.57
  ifconfig 1.40 (2000-05-21)
(vlan_test.pl is attached)

My conclusion:  The patch definately helps in this instance, but
  this instance may not be realistic.

***********************************************************************
This is with the hash patch enabled: (2.4.prerelease + VLAN patch) (run 2)
***********************************************************************

[root@candle bin]# time vlan_test.pl 
Adding VLAN interfaces 1 through 4000
Done adding 4000 VLAN interfaces in 76 seconds.
Doing ifconfig -a
10.47user 6.33system 0:16.80elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (116major+421minor)pagefaults 0swaps
Removing VLAN interfaces 1 through 4000
Done deleting 4000 VLAN interfaces in 58 seconds.

Going to add and remove 2 interfaces 1000 times.
Done adding/removing 2 VLAN interfaces 1000 times in 46 seconds.
74.12user 115.26system 3:22.81elapsed 93%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (2821121major+677780minor)pagefaults 0swaps


***********************************************************************
This is with the patch disabled: (2.4.0 + VLAN patch) (run 1)
***********************************************************************

[root@candle /root]# time vlan_test.pl
Adding VLAN interfaces 1 through 4000
Done adding 4000 VLAN interfaces in 132 seconds.
Doing ifconfig -a
10.72user 96.31system 1:55.31elapsed 92%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (117major+423minor)pagefaults 0swaps
Removing VLAN interfaces 1 through 4000
Done deleting 4000 VLAN interfaces in 65 seconds.

Going to add and remove 2 interfaces 1000 times.
Done adding/removing 2 VLAN interfaces 1000 times in 47 seconds.
74.20user 257.83system 6:04.46elapsed 91%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (2821122major+677782minor)pagefaults 0swaps


***********************************************************************
This is with the patch enabled: (2.4.0 + VLAN patch) (run 1)
***********************************************************************

[root@candle /root]# time vlan_test.pl
Adding VLAN interfaces 1 through 4000
Done adding 4000 VLAN interfaces in 83 seconds.
Doing ifconfig -a
10.61user 10.22system 0:23.43elapsed 88%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (117major+423minor)pagefaults 0swaps
Removing VLAN interfaces 1 through 4000
Done deleting 4000 VLAN interfaces in 64 seconds.

Going to add and remove 2 interfaces 1000 times.
Done adding/removing 2 VLAN interfaces 1000 times in 47 seconds.
73.69user 120.69system 3:44.10elapsed 86%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (2821122major+677782minor)pagefaults 0swaps


***********************************************************************
This is with the patch enabled: (2.4.0 + VLAN patch) (run 2)
***********************************************************************

[root@candle /root]# time vlan_test.pl
Adding VLAN interfaces 1 through 4000
Done adding 4000 VLAN interfaces in 80 seconds.
Doing ifconfig -a
10.62user 6.31system 0:18.63elapsed 90%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (117major+423minor)pagefaults 0swaps
Removing VLAN interfaces 1 through 4000
Done deleting 4000 VLAN interfaces in 61 seconds.

Going to add and remove 2 interfaces 1000 times.
Done adding/removing 2 VLAN interfaces 4000 times in 47 seconds.
74.05user 114.93system 3:33.00elapsed 88%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (2821122major+677782minor)pagefaults 0swaps


> 
> > Suppose I bind a raw socket to device vlan4001 (ie I have 4k in the list
> > before that one!!).  Currently, that means a linear search on all devices,
> > right?  In that extreme example, I would expect the hash to be very
> > useful.
> 
> Nope, it doesn't. Raw binding works via IP addresses, and the IP address resolution
> works via the routing table, which is extensively hashed.

Ahh, I meant raw, like raw Ethernet.  True, not used very often,
but I happen to have been using it lately :)

The original idea for the hashing came after I was severly chastised by a few
for even considering allowing 4000 VLAN Interfaces into the kernel.  The
complaint was that somehow having lots of devices was going to hurt performance.

The eventual conclusion (by me at least), was that there were no linear
lookups in any critical path I could think of.  However, things like
binding to interfaces, and searching for them (ifconfig -i vlan3999),
were doing (at least) linear searching, so hashing it might make the
user happier.

> 
> Packet socket binding or SO_BINDTODEVICE will search the list, but it is unlikely
> that these paths are worth optimizing for.

The patch has been written, so even if it helps just a little more than it
hurts, it might be worth including.  Of course, it may actually hurt more
than help.

I'd be very interested in lucid arguments as to why adding the patch would
actually be worse than not adding it, not just why I'm lame for considering
it *grin* :)

-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
--------------9BC101C2C1F69CA8BF3B57E3
Content-Type: application/x-perl;
 name="vlan_test.pl"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vlan_test.pl"

#!/usr/bin/perl

# For now, this just tests the addition and removal of 1000 VLAN interfaces on eth0

my $num_if = 4000;

`/usr/local/bin/vconfig set_name_type VLAN_PLUS_VID_NO_PAD`;

my $d = 5;
my $c = 5;

my $i;
print "Adding VLAN interfaces 1 through $num_if\n";
my $p = time();
for ($i = 1; $i<=$num_if; $i++) {
  `/usr/local/bin/vconfig add eth0 $i`;
  `ifconfig vlan$i 192.168.$c.$d`;
  `ifconfig vlan$i up`;

  $d++;
  if ($d > 250) {
    $d = 5;
    $c++;
  }
}
my $n = time();
my $diff = $n - $p;

print "Done adding $num_if VLAN interfaces in $diff seconds.\n";

sleep 2;

print "Doing ifconfig -a\n";
`time ifconfig -a > /tmp/vlan_test_ifconfig_a.txt`;

sleep 2;

print "Removing VLAN interfaces 1 through $num_if\n";
$d = 5;
$c = 5;
$p = time();
for ($i = 1; $i<=$num_if; $i++) {
  `/usr/local/bin/vconfig rem vlan$i`;

  $d++;
  if ($d > 250) {
    $d = 5;
    $c++;
  }
}
$n = time();
$diff = $n - $p;
print "Done deleting $num_if VLAN interfaces in $diff seconds.\n";

sleep 2;

my $tmp = $num_if / 4;
print "\nGoing to add and remove 2 interfaces $tmp times.\n";
$p = time();


for ($i = 1; $i<=$tmp; $i++) {
  `/usr/local/bin/vconfig add eth0 1`;
  `ifconfig vlan1 192.168.200.200`;
  `ifconfig vlan1 up`;

  `/usr/local/bin/vconfig add eth0 2`;
  `ifconfig vlan2 192.168.202.202`;
  `ifconfig vlan2 up`;

  `/usr/local/bin/vconfig rem vlan2`;
  `/usr/local/bin/vconfig rem vlan1`;
}
$n = time();
$diff = $n - $p;
print "Done adding/removing 2 VLAN interfaces $tmp times in $diff seconds.\n";

--------------9BC101C2C1F69CA8BF3B57E3--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
