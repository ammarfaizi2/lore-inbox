Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbUKWVpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbUKWVpR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 16:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbUKWVoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 16:44:32 -0500
Received: from c7ns3.center7.com ([216.250.142.14]:59824 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S261378AbUKWVm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 16:42:57 -0500
Message-ID: <41A3B23C.2080406@devicelogics.com>
Date: Tue, 23 Nov 2004 14:57:16 -0700
From: "Jeff V. Merkey" <jmerkey@devicelogics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: ltd@cisco.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9 pktgen module causes INIT process respawning   and
  sickness
References: <5.1.0.14.2.20041122144144.04e3d9f0@171.71.163.14.suse.lists.linux.kernel>	<419E6B44.8050505@devicelogics.com.suse.lists.linux.kernel>	<419E6B44.8050505@devicelogics.com.suse.lists.linux.kernel>	<5.1.0.14.2.20041122144144.04e3d9f0@171.71.163.14.suse.lists.linux.kernel>	<5.1.0.14.2.20041123094109.04003720@171.71.163.14.suse.lists.linux.kernel>	<41A2862A.2000602@devicelogics.com.suse.lists.linux.kernel> <p73k6sc1epi.fsf@bragg.suse.de>
In-Reply-To: <p73k6sc1epi.fsf@bragg.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi,

For network forensics and analysis, it is almost a requirement if you 
are using Linux. The bus speeds on these systems
also support 450 MB/S throughput for disk and network I/O. I agree it's 
not that interesting if you are
deploying file servers that are remote attached on PPPoE and PPP as a 
network server or workstation, given
that NFS and userspace servers like SAMBA are predominant in Linux as 
file service. High performance real time
network analysis is a different story. High performance I/O file service 
and storage are also
interesting and I can see folks wanting it.

I guess I have a hard time understanding the following statement,

" ... perhaps [supporting 10 GbE and 1GbE for high performance beyond 
remote internet access ] is not that interesting ... "

Hope it's not too wet in Germany this time of year. I am heading back to 
Stolberg and Heinsberg
to show off our new baby boy born Oct 11, 2004 to his O-ma and O-O-ma (I 
guess this is how you spell this)
end of January (I hope). I might be even make it to Nurnberg while I'm 
at it. :-)

Implementation of this with skb's would not be trivial. M$ in their 
network drivers did this sort of circular list of pages
structure per adapter for receives and use it "pinned" to some of their 
proprietary drivers in W2K and would use their
version of an skb as a "pointer" of sorts that could dynamically assign 
a filled page from this list as a "receive" then perform
the user space copy from the page and release it back to the adapter. 
This allowed them to fill the ring buffers with static
addresses and copy into user space as fast as they could allocate 
control blocks.

For linux, I would guess the easiest way to do this same sort of thing 
would be to allocate a page per ring buffer
entry, pin the entries, and use allocated skb buffers to point into the 
buffer long enough to copy out the data. This would
**HELP** currently but not fix the problem completely, but the approach 
would allow linux to easily move to a table driven
method since it would switch from a ring of pinned pages to tables of 
pinned pages that could be swapped in and out.

We would need to logically detach the memory from the skb and make the 
skb a pointer block into the skb->data
area of the list. M$ does something similiar to what I described. It 
does make the whole skb_clone thing
a lot more complicated but for those apps that need to "hold" skb's 
which is infrequent for most cases,
someone could just call skb_clone() when they needed a private sopy of 
and skb->data pair.

Jeff

Andi Kleen wrote:

>"Jeff V. Merkey" <jmerkey@devicelogics.com> writes:
>  
>
>>I can sustain full line rate gigabit on two adapters at the tsame time
>>with a 12 CLK interpacket gap time and 0 dropped packets at 64
>>byte sizes from a Smartbits to Linux provided the adapter ring buffer
>>is loaded with static addresses. This demonstrates that it is
>>possible to sustain 64 byte packet rates at full line rate with
>>current DMA architectures on 400 Mhz buses with Linux.
>>(which means it will handle any network loading scenario). The
>>bottleneck from my measurements appears to be the
>>overhead of serializing writes to the adapter ring buffer IO
>>memory. The current drivers also perform interrupt
>>coalescing very well with Linux. What's needed is a method for
>>submission of ring buffer entries that can be sent in large
>>scatter gather listings rather than one at a time. Ring buffers
>>    
>>
>
>Batching would also decrease locking overhead on the Linux side (less
>spinlocks taken)
>
>We do it already for TCP using TSO for upto 64K packets when
>the hardware supports it. There were some ideas some time back
>to do it also for routing and other protocols - basically passing 
>lists of skbs to hard_start_xmit instead of always single ones - 
>but nobody implemented it so far.
>
>It was one entry in the "ideas to speed up the network stack" 
>list i posted some time back.
>
>With TSO working fine it doesn't seem to be that pressing.
>
>One problem with the TSO implementation is that TSO only works for a
>single connection. If you have hundreds that chatter in small packets
>it won't help batching that up. Problem is that batching data from
>separate sockets up would need more global lists and add possible SMP
>scalability problems from more locks and more shared state. This 
>is a real concern on Linux now - 512 CPU machines are really unforgiving.
>
>However in practice it doesn't seem to be that big a problem because
>it's extremly unlikely that you'll sustain even a gigabit ethernet
>with such a multi process load. It has far more non network CPU
>overhead than a simple packet generator or pktgen.
>
>So overall I agree with Lincoln that the small packet case is not
>that interesting except perhaps for DOS testing.
>
>-Andi
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

