Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbVCAN70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbVCAN70 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 08:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVCAN70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 08:59:26 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:21703 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261815AbVCAN6p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 08:58:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=e3oM8HWu90AdYS54eUb5XWgj8ns6yydlQGRFUmBipN8En5gji4+9I5YpUG5LY3ykGdyAPLr2EObflF6H0bdmfN5wuIbJJHouZDpERHl9tPLHAKU1UJ4McnhKwvdEHU6ODQKS6H1pgLsp3+hwaubfhkOhe0FCfsQEDLlq1eYVjQc=
Message-ID: <537f59d105030105581cf1ea70@mail.gmail.com>
Date: Tue, 1 Mar 2005 19:28:36 +0530
From: Vinay Reddy <vinayvinay@gmail.com>
Reply-To: Vinay Reddy <vinayvinay@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re:Kernel Panic due to NF_IP_LOCAL_OUT handler calling itself again
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
There is an update.

The protocol I am writing is a source routing based protocol called
Meghadoot similar to the wireless networks DSR, as written by Alex Song
(http://piconet.sf.net). I am using netfilter, I am using linux 2.6.5
(supplied along with FC2), without the SMP and PREEMPTIBLE options.
I have a seperate header called MeghHeader, which carries the source
route and it comes b/w the iph and the tcph. I am using an isolated
machine called A from which I send out ping packets. Here is what is
happening:
In my local_out_handler, I cruft the source routing header, route the
packet using ip_route_output (which causes an arp request to be send).
And then call the output routine passed to me by netfilter (okfn).
As the arp request obviously will fail, and hence
skb->dst->neighbour->output points to neigh_resolve_output, which sends
the arp request, and queues the skb in the neigh->arp_queue, the
neigh->state is NUD_INCOMPLETE.
When neigh_timer_handle fires, it walks thru the arp_queue and sends an
icmp dest unreach for each of the queued skb's thru the
ipv4_link_failure function.
Please note that my local_out_handler is serialized by having a
spinlock at its entry.
Hence my debugging output looks something like this:
        Entering local out with icmp packet type 8, code 0 : The normal
ping
packet, in pings context.
        ... Some more of the above
        Entering local out with icmp packet type 3, code 1 : The icmp
dest
unreach, given off in the TIMER_SOFTIRQ context, when
neigh_timer_handler is fired.
        ...And then some more of the two...

        Now this is something, that has totally freaked me out ....

        I sometimes get an icmp skb in my local out handler with some
invalid
type say like 234 etc, As a hack in my local_out_handler, I return
NF_DROP ('cos I noticed that icmp_send, assumes that the type is
correct before indexing into the icmp table). As soon as my
local_out_handler exits with this screwed up skb,(Again, my
local_out_handler is not reentrant, it is locked by a spinlock) I get
either a bad eip or a null eip somewhere in the neigh_timer_handler.
The stack dump looks like this. (The full debugging output, including
the oops message is available online at
http://www.cs.iitm.ernet.in/~dvagr/helpme):
I am trying to ping the machine 10.6.6.2, whose route is hardcoded into
10.6.6.5.
<------------ My debugging output begins ---------------->
Meghadoot: ****************** Entering local out *******************
function addr 224c483, dst output 224a842<2>
Meghadoot: okfn points to :Address: 224c483, name: dst_output, offset:
0,size: 1c, module: Kernel<2>,
Meghadoot: skb->dst->output points to : Address: 224a842, name:
ip_output, offset: 0,size: 5c, module: Kernel<2>
Meghadoot: local out handler, dumping call trace
 [<22926360>] local_out_handler+0x4e/0x296 [megh_linux]
 [<0224c483>] dst_output+0x0/0x1c
 [<0224a842>] ip_output+0x0/0x5c
 [<0223c787>] nf_iterate+0x40/0x89
 [<0224c483>] dst_output+0x0/0x1c
 [<0223ca91>] nf_hook_slow+0x90/0x101
 [<0224c483>] dst_output+0x0/0x1c
 [<0224c0dc>] ip_push_pending_frames+0x2cf/0x37c
 [<0224c483>] dst_output+0x0/0x1c
 [<0226686f>] icmp_send+0x35e/0x397
 [<02107352>] do_IRQ+0x134/0x169
 [<02239dc9>] neigh_timer_handler+0x0/0x112
 [<0211de03>] run_timer_softirq+0x10b/0x12a
 [<0211af6d>] __do_softirq+0x35/0x73
 [<021078f5>] do_softirq+0x46/0x4d
 =======================
 [<0210737b>] do_IRQ+0x15d/0x169
 [<0210403b>] default_idle+0x23/0x26
 [<0210408c>] cpu_idle+0x1f/0x34
 [<02318612>] start_kernel+0x174/0x176

Meghadoot: In context: in_softirq:1024,in_irq:0,in_interrupt:1024<2>
Meghadoot: local out called in context of swapper<2>
Meghadoot: finished dumping stack ....<2>
Meghadoot: Entered local Out handler,printing skb info<2>
Meghadoot: Local out handler , icmp type is 0, code is 0<2>s:127.0.0.1
d:127.0.0.1 and protocol is 1<2> (Valid icmph->type, I return NF_DROP
if icmph->type > NR_ICMP_TYPES )
Meghadoot: Got Locally destined packet (ie iph->daddr = MYIPADDR )<2>,
returned NF_ACCEPT.
Meghadoot: ****************** Exiting local out
*******************<1>Unable to handle kernel NULL pointer dereference
at virtual address 00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<00000000>]    Not tainted
EFLAGS: 00010206   (2.6.5-1.358)
EIP is at 0x0
eax: 00000000   ebx: 00000000   ecx: 0000b404   edx: 00000007
esi: 00000000   edi: 00000000   ebp: 00000000   esp: 02344fb0
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=02344000 task=022c5aa0)
Stack: 00020000 00000000 00594400 1c8e4900 00000056 02239dc9 1c8e495c
0211de03
       02344fd0 02344fd0 0234007b 00000001 02369428 0000000a 02316000
0211af6d
       02317f94 00000046 00000000 021078f5
Call Trace:
 [<02239dc9>] neigh_timer_handler+0x0/0x112
 [<0211de03>] run_timer_softirq+0x10b/0x12a
 [<0211af6d>] __do_softirq+0x35/0x73
 [<021078f5>] do_softirq+0x46/0x4d
 =======================
 [<0210737b>] do_IRQ+0x15d/0x169
 [<0210403b>] default_idle+0x23/0x26
 [<0210408c>] cpu_idle+0x1f/0x34
 [<02318612>] start_kernel+0x174/0x176

Code:  Bad EIP value.
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

<---------------------- End of debugging dump --------------------->

I will be really greateful, if any one of you could help me out with
this. Please.

Expecting your reply eagerly.
Regards,
Vinay
