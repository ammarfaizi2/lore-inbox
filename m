Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265457AbTBGQXB>; Fri, 7 Feb 2003 11:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265982AbTBGQXB>; Fri, 7 Feb 2003 11:23:01 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:5250 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S265457AbTBGQW7>;
	Fri, 7 Feb 2003 11:22:59 -0500
Date: Fri, 07 Feb 2003 16:32:34 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Martin Zielinski <mz@seh.de>, linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: TCP Connection times out
Message-ID: <2175555904.1044635554@[192.168.100.5]>
In-Reply-To: <200302071531.53214.mz@seh.de>
References: <200302071531.53214.mz@seh.de>
X-Mailer: Mulberry/2.2.1 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This would seem to me to be a bug.

What tcp_send_probe0 in net/ipv4/tcpoutput.c is trying to do is
to double the timeout for each TCP backoff, then cap it to
a particular maximum. However, if there are enough backoffs,
the doubling procedure results in a wraparound, and a zero
timeout. This is wrong - it should be whatever the maximum
is. There's also a bug on the other path BTW.

Something like the following (rather too heavyweight, and
completely untested, manually generated) patch might work.
Being manually generate the whitespace is almost
certaintly screwed so you probably want to just go edit the
2 lines in question. There is probably a much more elegant
way to do this without resorting to 64 bit arithmetic
but this mechanism at least puts no more constraints
on tp->rto and TCP_xxxx.

Alex

--- net/ipv4/tcp_output.c.old    Fri Feb  7 16:16:36 2003
+++ net/ipv4/tcp_output.c        Fri Feb  7 16:20:18 2003
@@ -1429,7 +1429,7 @@
                tp->backoff++;
                tp->probes_out++;
                tcp_reset_xmit_timer (sk, TCP_TIME_PROBE0,
-                                     min(u32, tp->rto << tp->backoff, TCP_RTO_MAX));
+                                     min(u64, (u64)tp->rto << ( (tp->backoff < 32) ? tp->backoff : 32), TCP_RTO_MAX));
        } else {
                /* If packet was not sent due to local congestion,
                 * do not backoff and do not remember probes_out.
@@ -1440,6 +1440,6 @@
                if (!tp->probes_out)
                        tp->probes_out=1;
                tcp_reset_xmit_timer (sk, TCP_TIME_PROBE0,
-                                     min(unsigned int, tp->rto << tp->backoff, TCP_RESOURCE_PROBE_INTERVAL));
+                                     min(u64, (u64)tp->rto << ( (tp->backoff < 32) ? tp->backoff : 32), TCP_RESOURCE_PROBE_INTERVAL));
        }
 }




--On 07 February 2003 15:31 +0100 Martin Zielinski <mz@seh.de> wrote:

> Thanks for the prompt reply.
> The situation is a bit different. Sorry for not providing all infos:
>
> Actually the printer network interface ACKs all incoming packets
> with window size zero
>
> Everything is fine until the standard TCP/IP implementation shifts
> a "22" (tp->rto) 31 (tp->backoff) times to the left and sends 16 ACKS in
> 0.5ms, because it does no timeouts between them.
>
> A "60 minute paper empty"-situation should not cause problems.
>
> I could provide a tcpdump trace of this, if wanted.
>
> Thanks,
> martin
>
> On Friday 07 February 2003 14:49, Richard B. Johnson wrote:
>> On Fri, 7 Feb 2003, Martin Zielinski wrote:
>> > Hello,
>> > I'm not on the list, so I'm not really informed what's going on. But...
>> >
>> > our problem is a network printer the has paper empty.
>> > The socket connection to the printer broke down after ~45 minutes with
>> > errno 110 (Connection timed out).
>> >
>> > Linux base version is 2.4.18 on a strongarm machine.
>> >
>> > Tracking this down brought us to the tcp_send_probe0 function in
>> > net/ipv4/tcp_output.c.
>> > The tp->backoff value becomes allways increased.
>> > on this machine from 31 on  (tp->rto << tp->backoff) is 0.
>> >
>> > The xmit timer is set to this timeout value - resulting in an ACK
>> > burst. If the TCP sender gets the (default) 16 ACKS out, before the
>> > receiver can answer them, the connection dies.
>> > This happened every night, when the printer received a huge job from a
>> > foreign  office.
>> >
>> > If this isn't a bug, it should be made configurable. Or do we miss
>> > something?
>> >
>> > Thanks.
>>
>> Get new firmware for your printer. It's broken. The connection
>> timed out because the connection timed out, i.e., when the printer
>> is out of paper, it refuses to ACK incoming packets. You do not
>> modify a standard TCP/IP implementation to fix a broken printer.
>>
>> The printer is expecting to hold-off incoming network data, by
>> refusing to ACK it, until someone adds more paper. This is
>> unconsionable behavior that violates any standards of Engineering
>> practice. There is no time-out you could increase because the
>> printer may be out-of-paper forever, i.e., somebody needs to go
>> buy some. Network-connected devices just can't do things this
>> way. The name of the vendor should be published and the vendor
>> "educated" in such a way that no such printers remain connected
>> to a network until they are fixed.
>>
>> And, if Linux didn't follow the standard, and let dead "connected"
>> devices remain in a connected state, servers that use connections
>> would would become impossible.
>>
>> Cheers,
>> Dick Johnson
>> Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
>> Why is the government concerned about the lunatic fringe? Think about it.
>
> --
> Martin Zielinski       mz@seh.de
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>



--
Alex Bligh
