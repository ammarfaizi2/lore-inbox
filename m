Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277315AbRJEGD5>; Fri, 5 Oct 2001 02:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277318AbRJEGDr>; Fri, 5 Oct 2001 02:03:47 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:51653 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S277315AbRJEGDi>;
	Fri, 5 Oct 2001 02:03:38 -0400
Message-ID: <3BBD4D54.96A08A3D@candelatech.com>
Date: Thu, 04 Oct 2001 23:04:04 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Henson <kern@wolf.ericsson.net.nz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Throughput @100Mbs on link of ~10ms latency
In-Reply-To: <Pine.LNX.4.33.0110051704430.16678-100000@wolf.ericsson.net.nz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Henson wrote:
> 
> Hi,
> 
> Can someone give me a pointer to a FAQ on how to tune a 2.4 machine to
> achieve high throughput (approx i/f speed 100Mbits/sec) on a link with the
> following characteristics:
> 
> Latency         Throughput
> 
> 9-10ms          3.8 MByte/s
> 3-4ms           7-8MByte/s
> 
> I have implemented:
> 
> echo "4096 87380 4194304" > /proc/sys/net/ipv4/tcp_rmem
> echo "4096 65536 4194304" > /proc/sys/net/ipv4/tcp_wmem
> 
> from http://www-didc.lbl.gov/tcp-wan.html
> 
> this lifted the performance from ~1MByte/s to the 3.8 above.
> 
> When the receiving machine is freebsd I get 10.05 MBytes/s which
> is interesting - but when sending from BSD I get the same rate.
> 

Some things I change to increase performance (it seems to help...)
(I'm cutting & pasting from a perl script, so you'll need to interpret
 it a bit..)

# NOTE:  For faster systems I usually bump the *mem* settings up to 4MB.

my $netdev_max_backlog = 4096; # Maximum number of packets, queued on the INPUT side, when
                               # the interface receives pkts faster than it can process them.

my $wmem_max = 512000;  # Write memory buffer.  This is probably fine for any setup,
                        # and could be smaller (256000) for < 5Mbps connections.

my $wmem_default = 512000;  # Write memory buffer.  This is probably fine for any setup,
                            # and could be smaller (256000) for < 5Mbps connections.

my $rmem_max = 1024000;  # Receive memory (packet) buffer.  If you are running lots of very fast traffic,
                         # you may want to make this larger, up to 4096000 or so.  If you are
                         # at around 20Mbps of traffic per connection or smaller, then 1024000
                         # is plenty.  For < 5Mbps of traffic, 512000 should be fine.

my $rmem_default = 1024000;  # Receive memory (packet) buffer.  If you are running lots of very fast traffic,
                             # you may want to make this larger, up to 4096000 or so.  If you are
                             # at around 20Mbps of traffic per connection or smaller, then 1024000
                             # is plenty.  For < 5Mbps of traffic, 512000 should be fine.

printAndExec("echo $wmem_max > /proc/sys/net/core/wmem_max");
printAndExec("echo $wmem_default > /proc/sys/net/core/wmem_default");
printAndExec("echo $rmem_max > /proc/sys/net/core/rmem_max");
printAndExec("echo $rmem_default > /proc/sys/net/core/rmem_default");
printAndExec("echo $netdev_max_backlog > /proc/sys/net/core/netdev_max_backlog");


And of course, make sure you can get the performance with a known fast network
(and near zero latency) first!!

The e100 has some interesting options that seem to make it handle high packet
counts better, as well as giving it bigger descriptor lists, but I haven't
really benchmarked it..

Ben

> cheers
> Mark
> 
> [root@tsaturn ncftp]# lsmod
> Module                  Size  Used by
> autofs                 11264   1  (autoclean)
> 3c59x                  25344   1  (autoclean)
> e100                   44240   1  (autoclean)
> ipchains               38976   0  (unused)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
