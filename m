Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313540AbSDHMd1>; Mon, 8 Apr 2002 08:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313546AbSDHMd0>; Mon, 8 Apr 2002 08:33:26 -0400
Received: from gate.colubris.com ([206.162.167.230]:43252 "EHLO
	exchange.colubris.com") by vger.kernel.org with ESMTP
	id <S313540AbSDHMd0>; Mon, 8 Apr 2002 08:33:26 -0400
Message-ID: <3CB18D47.777EC3A3@colubris.com>
Date: Mon, 08 Apr 2002 08:29:59 -0400
From: Martin Gadbois <martin.gadbois@colubris.com>
Organization: Colubris Networks
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adam Khan <adam.khan@cavium.com>
CC: linux-kernel@vger.kernel.org, design@lists.freeswan.org
Subject: Re: [Design] suggestions for parallel processing of input and output   
 packets
In-Reply-To: <000001c1dd01$f83d0960$4310a8c0@Adamspc>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Apr 2002 12:29:52.0953 (UTC) FILETIME=[155A0A90:01C1DEF9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Khan wrote:

> Martin,
>
> Thanks for the info, extremely helpful. I have a couple more questions.
> The ipsec_tunnel_start_xmit() and ipsec_rcv() routines run as tasklets.
> In tasklets there is no sleeping or scheduling, From your notes
> I can use a kernel thread (BTW, a timer routine would sleep -
> I don't think thats allowed in this context?)

Why would it sleep?

setup_timer(callback_check_hw);
...
void callback_check_hw(...)
{
    while (packet available from h/w)
    {
        take packet;
        decide where to send it from packet's context;
        if(tx)
                ipsec_tunnel_send()
        else
                ipsec_rcv()
    }
}
or something like that...


>
>
> Kernel thread - Is this considered a separate context? Concerns -does
> the thread sleep - how often is the thread run?
> Pointers on with kernel threads and sample code will be appreciated.

Kernel threads are a normal process, but the processes' memory pages are
those of the kernel. No memory context switch required when the kernel
schedule those processes. They run as often as any other process with the
same priority. Since a kernel thread is a process, it can sleep on events
(timer, signals).
But in your situation, I would not use kernel threads - the time it takes
to schedule() a process is too much time to wait PER PACKET. Use a timer
instead, poll the H/W (or whatever) and if available, call the right
function with the completed packet. After all, if you use H/W crypto, you
want performance.

for 2.4.x, grep kernel_thread to find example of stock kernel threads.
(RTFC)
I also suggest Understanding the Linux Kernel, from O'reilly. A great book
on the current topics. (RTFM)


--
==============
Martin Gadbois
S/W Developper
Colubris Networks Inc.



