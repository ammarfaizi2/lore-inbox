Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265343AbUFBGJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265343AbUFBGJU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 02:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265349AbUFBGJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 02:09:20 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:965 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S265343AbUFBGJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 02:09:05 -0400
Message-ID: <40BD6EFE.1010209@candelatech.com>
Date: Tue, 01 Jun 2004 23:09:02 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jyotiraditya@softhome.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Select/Poll
References: <courier.40BD66BD.00006D7D@softhome.net>
In-Reply-To: <courier.40BD66BD.00006D7D@softhome.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jyotiraditya@softhome.net wrote:
> Hello All,
> In one of the threads named: "Linux's implementation of poll() not 
> scalable?'
> Linus has stated the following:
> **************
> Neither poll() nor select() have this problem: they don't get more
> expensive as you have more and more events - their expense is the number
> of file descriptors, not the number of events per se. In fact, both poll()
> and select() tend to perform _better_ when you have pending events, as
> they are both amenable to optimizations when there is no need for waiting,
> and scanning the arrays can use early-out semantics.
> **************
> Please help me understand the above.. I'm using select in a server to read
> on multiple FDs and the clients are dumping messages (of fixed size) in a
> loop on these FDs and the server maintainig those FDs is not able to get 
> all
> the messages.. Some of the last messages sent by each client are lost.
> If the number of clients and hence the number of FDs (in the server) is
> increased the loss of data is proportional.
> eg: 5 clients send messages (100 each) to 1 server and server receives
>   96 messages from each client.
>   10 clients send messages (100 by each) to 1 server and server again
>   receives 96 from each client.
> If a small sleep in introduced between sending messages the loss of data
> decreases.
> Also please explain the algorithm select uses to read messages on FDs and
> how does it perform better when number of FDs increases.

Try increasing your socket buffers so that the kernel will queue up more
packets while your user-space server is trying to wake up.

I used to have no problem receiving data with up to 1024 file descriptors
using select, but when you need more than 1024, you will need to go to poll
because fd_set has a maximum size of 1024 by default...

To increase your buffers, google for these files:
/proc/sys/net/core/wmem_max
/proc/sys/net/core/rmem_max
/proc/sys/net/core/netdev_max_backlog
...

Here is some sample code I use to set the buffer size based on the
maximum rate I think this socket will want to send:

int set_sock_wr_buffer_size(int desc, uint32 mx_rate) {
    int sz = (mx_rate / 40);
    if (sz < 32000) {
       sz = 32000;
    }
    if (sz > 4096000) {
       sz = 4096000;
    }

    while (sz >= 32000) {
       if (setsockopt(desc, SOL_SOCKET, SO_SNDBUF, (void*)&sz,
                      sizeof(sz)) < 0) {
          VLOG_WRN(VLOG << "ERROR: setting send buffer to: " << sz << " failed: "
                   << strerror(errno) << endl);
          sz = sz >> 1;
       }
       else {
          VLOG_INF(VLOG << "Set SNDBUF sz to: " << sz << " for desc: " << desc << endl);
          break;
       }
    }

    sz = max(2048000, sz);
    while (sz >= 32000) {
       if (setsockopt(desc, SOL_SOCKET, SO_RCVBUF, (void*)&sz,
                      sizeof(sz)) < 0) {
          VLOG_WRN(VLOG << "ERROR: setting receive buffer to: " << sz << " failed: "
                   << strerror(errno) << endl);
          sz = sz >> 1;
       }
       else {
          VLOG_INF(VLOG << "Set RCVBUF sz to: " << sz << " for desc: " << desc << endl);
          break;
       }
    }

    return sz;
}//set_sock_wr_buffer_size


Ben


> Thanks and Regards,
> Jyotiraditya -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

