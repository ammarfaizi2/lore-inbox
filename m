Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266940AbTBCRyh>; Mon, 3 Feb 2003 12:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266944AbTBCRyh>; Mon, 3 Feb 2003 12:54:37 -0500
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:59809 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S266940AbTBCRyf>;
	Mon, 3 Feb 2003 12:54:35 -0500
Message-ID: <3E3EAF04.9010308@candelatech.com>
Date: Mon, 03 Feb 2003 10:03:48 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: Chris Friesen <cfriesen@nortelnetworks.com>, davem@redhat.com, ahu@ds9a.nl,
       linux-kernel@vger.kernel.org
Subject: Re: problems achieving decent throughput with latency.
References: <200302031611.h13GBl9D019119@darkstar.example.net>
In-Reply-To: <200302031611.h13GBl9D019119@darkstar.example.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
>>>TCP can only send into a pipe as fast as it can see the
>>>ACKs coming back.  That is how TCP clocks its sending rate,
>>>and latency thus affects that.
>>
>>Wouldn't you just need larger windows?  The problem is latency, not 
>>bandwidth.
> 
> 
> Exactly - the original post says that no problems are experienced
> using UDP, which backs that up.

I started poking around, and found the tcp_mem, tcp_rmem, and tcp_wmem
tunables in /proc/sys/net/ipv4...

If I change the values, I see up to 25Mbps with 25ms of latency.
It would go higher, but I have uncovered a performance bug in my code that
drops a packet every now and then at those higher rates, so that backs tcp
off quickly.  I should have that fixed this evening and will continue testing.


Here are the values that I used.  The documentation I found is not overly
descriptive, so if anyone has any suggestions for improving my tunings, please
let me know!

Also, if it's as simple as allocating a few more buffers for tcp, maybe we
should consider defaulting to higher in the normal kernel?  (I'm not suggesting
**my** numbers..)

# See the kernel documentation: Documentation/networking/ip-sysctl.txt
my $tcp_rmem_min     = 4096;
my $tcp_rmem_default = 256000;  # TCP specific receive memory pool size.
my $tcp_rmem_max     = 3000000;  # TCP specific receive memory pool size.

my $tcp_wmem_min     = 4096;
my $tcp_wmem_default = 256000;  # TCP specific receive memory pool size.
my $tcp_wmem_max     = 3000000;  # TCP specific receive memory pool size.

my $tcp_mem_lo       = 20000000; # Below here there is no memory pressure.
my $tcp_mem_pressure = 30000000; # Can use up to 30MB for TCP buffers.
my $tcp_mem_high     = 30000000; # Can use up to 30MB for TCP buffers.




> 
> John.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


