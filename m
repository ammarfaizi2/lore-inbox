Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262107AbSJEHYT>; Sat, 5 Oct 2002 03:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262113AbSJEHYT>; Sat, 5 Oct 2002 03:24:19 -0400
Received: from web13113.mail.yahoo.com ([216.136.174.181]:46451 "HELO
	web13113.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262107AbSJEHYS>; Sat, 5 Oct 2002 03:24:18 -0400
Message-ID: <20021005071621.6628.qmail@web13113.mail.yahoo.com>
Date: Sat, 5 Oct 2002 00:16:21 -0700 (PDT)
From: devnetfs <devnetfs@yahoo.com>
Subject: questions regarding sending/recving udp packets in kernel
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am trying to write a kernel module, to send and receive udp packets. 
I have the following questions/problems:

[1] 
I wish to receive packets asynchronously (thru a callback), rather 
than polling [i.e calling udp_recvmsg() periodically to check for
packtets]. 

To get this done, presently after creating a socket (sock_create), I 
replace sk->data_ready with my own function, which when called (by the
kernel) wakes up a kernel thread that does skb_recv_datagram() to get a
udp sk_buff.

Is this the correct approach? or is there a better way to register a
callback with the core-networking subsystem, which will get called and
deliver the pkt, when a udp pkt arrives on an ip/port?


[2]
The memory allocted for the sk_buff (which i get thru
skb_recv_datagram() is charged to the socket (i created). But I wish to
use this sk_buff in my module (for processing etc.) so i dont call
kfree_skb for a long time (hence the rmem_alloc does not get
decremented). I tried to unlink the sk_buff from the socket list by
calling skb_unlink() but that does NOT decrease 'rmem_alloc'.

How do I cleanly (and truly) unlink a sk_buff from a socket list and
decrease equivalent memory charged to this socket? I would be calling
kfree_skb() later though which will eventually decrease rmem_alloc, but
I wish to do it as part of skb_unlink(). Please advice.


[3]
My kernel module sends/recvs UDP pkts process and store these packets
internally sk_buffs only. But udp_sendmsg() requires an iovec.
I can construct an iovec from an sk_buff and give it to udp_sendmsg()
but that will involve an additional COPYING from one kernel memory 
space (sk_buff data buffer) to another new buffer (for iovec). I want 
to avoid this xtra copying.

Am I missing something? 
And if above approach does involve extra copying is there a way to
transmit a udp packet if one has the data in form of sk_buff (assuming
there is head space for ether+ip+udp header)?


Thanks in advance,

Regards,
Abhi.

I am not subscribed to this list. Please Cc: me the replies. -- thanks.



__________________________________________________
Do you Yahoo!?
Faith Hill - Exclusive Performances, Videos & More
http://faith.yahoo.com
