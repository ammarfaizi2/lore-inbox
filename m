Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262590AbVCJAos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbVCJAos (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 19:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbVCJAfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 19:35:07 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:8361 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S262577AbVCJASg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:18:36 -0500
Message-ID: <422F9259.2010003@candelatech.com>
Date: Wed, 09 Mar 2005 16:18:33 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christian Schmid <webmaster@rapidforum.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
References: <4229E805.3050105@rapidforum.com> <422BAAC6.6040705@candelatech.com> <422BB548.1020906@rapidforum.com> <422BC303.9060907@candelatech.com> <422BE33D.5080904@yahoo.com.au> <422C1D57.9040708@candelatech.com> <422C1EC0.8050106@yahoo.com.au> <422D468C.7060900@candelatech.com> <422DD5A3.7060202@rapidforum.com> <422F8A8A.8010606@candelatech.com> <422F8C58.4000809@rapidforum.com>
In-Reply-To: <422F8C58.4000809@rapidforum.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schmid wrote:
>> Yes, 2.6.11.  I have tuned max_backlog and some other TCP and networking
>> related settings to give more buffers etc to networking tasks.  I have 
>> not
>> tried any significant disk-IO while doing these tests.
>>
>> I finally got my systems set up so I can run my WAN emulator at full 
>> 1Gbps:
>>
>> I am getting right at 986Mbps throughput with 30ms round-trip latency
>> (15ms in both directions).
>>
>> So, latency does not seem to be the problem either.
>>
>> I think the problem can be narrowed down to:
>>
>> 1)  Non-optimal kernel network tunings on your server.
> 
> 
> I used all the default-settings on 2.6.11

Here are my settings.  Hopefully it will be clear what I'm
talking about..yell if you need details.  Please note that I explicitly
set the send buffers to 128k and the rcv to 16k in my test so the min and max
socket queue lengths do not matter here.

my $dflt_tx_queue_len = 2000;   # Ethernet driver transmit-queue length.  Might be worth making
                                 # it bigger for GigE nics.

my $netdev_max_backlog = 5000; # Maximum number of packets, queued on the INPUT side, when
                                # the interface receives pkts faster than it can process them.

my $wmem_max = 4096000;  # Write memory buffer.  This is probably fine for any setup,
                          # and could be smaller (256000) for < 5Mbps connections.

my $wmem_default = 128000;  # Write memory buffer.  This is probably fine for any setup,
                             # and could be smaller (256000) for < 5Mbps connections.

my $rmem_max = 8096000;  # Receive memory (packet) buffer.  If you are running
                          # lots of very fast traffic,
                          # you may want to make this larger if you are running over
                          # fast, high-latency networks.
                          # For < 5Mbps of traffic, 512000 should be fine.

my $rmem_default = 128000;  # Receive memory (packet) buffer.


# If this is not 1, then the tcp_* settings below will not be applied.
my $modify_tcp_settings = 1;

# See the kernel documentation: Documentation/networking/ip-sysctl.txt
my $tcp_rmem_min     = 4096;
my $tcp_rmem_default = 256000;  # TCP specific receive memory pool size.
my $tcp_rmem_max     = 30000000;  # TCP specific receive memory pool size.

my $tcp_wmem_min     = 4096;
my $tcp_wmem_default = 256000;  # TCP specific write memory pool size.
my $tcp_wmem_max     = 30000000;  # TCP specific write memory pool size.

my $tcp_mem_lo       = 20000000; # Below here there is no memory pressure.
my $tcp_mem_pressure = 30000000; # Can use up to 30MB for TCP buffers.
my $tcp_mem_high     = 60000000; # Can use up to 60MB for TCP buffers.


> 
>> 2)  Disk-IO (my disk is small and slow compared to a 'real' server, 
>> not sure I can
>>      really test this side of things, and I have not tried as of yet.)
> 
> 
> This doesnt explain the speed-up when I change lower_zone_protection 
> from 0 to 1024. It also doesnt explain the slowdown on 2.6.11 compared 
> to 2.6.10

Disk-IO uses buffers, so a change here could easily starve the rest
of your system.  I'm just saying I can't reliably test this.  To be honest,
my machines are already throwing allocation failures in the ethernet drivers
and I've had the OOM killer kill my main process several times.  So, my machines
are running right at their memory limit, even w/out any disk IO.

>> 3)  Your clients have much more latency and/or don't have enough 
>> bandwidth
>>      to fully load your server.  Since you didn't answer before:  I 
>> assume you
>>      do not have a reliable test bed and are just hoping that enough 
>> clients connect
>>      to do your benchmarking.
> 
> 
> Yes I just wait until they connect. On the graph it only takes about 2 
> minutes until 3000 sockets are created again.

But, you could get unlucky and have 3000 people on a shitty dialup
connection connect to you.  That does not make it easy to reliably
test the system.


>> 4)  There is something strange with sendfile and/or your application's 
>> coding.
> 
> 
> I am not doing more than calling sendfile. There  is nothing one can do 
> wrong.
> 
>> My suggestion would be to eliminate these variables by coming up with 
>> a repeatable
>> test bed, alternative traffic generators, WAN/Network emulators for 
>> latency, etc.
> 
> 
> The problem still is that 1) it speeds up immediately when 
> lower_zone_protection is raised to 1024. This proves it is NOT a 
> disk-bottleneck. And second: it got much worse with 2.6.11 and 
> lower_zone_protection disappeared on 2.6.11

So, maybe a VM problem?  That would be a good place to focus since
I think we can be fairly certain it isn't a problem in just the
networking code.  Otherwise, my tests would show lower bandwidth.

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

