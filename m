Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263187AbTF0I7C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 04:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263633AbTF0I7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 04:59:02 -0400
Received: from mail.atr.bydgoszcz.pl ([212.122.192.35]:7879 "EHLO
	mail.atr.bydgoszcz.pl") by vger.kernel.org with ESMTP
	id S263187AbTF0I65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 04:58:57 -0400
From: "Adam Flizikowski" <adam_fli@poczta.onet.pl>
To: <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>
Subject: How to do kernel packet forwarding performance analysys - please comment on my method 
Date: Fri, 27 Jun 2003 11:12:32 +0200
Message-ID: <GMEGLMHAELFDACHHIEPIMEBGCFAA.adam_fli@poczta.onet.pl>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 1 (Highest)
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4925.2800
Importance: High
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I want to analyze how much time is spent on forwarding process in linux
kernel.

This is second post but the matter is very important to me. I am dealing
with this for few months now.

To accomplish this I looked at networking code linux_src/net/ipv4/* and did
simple (I started with C programming for the purpose of this analyzys so
apologize my possibly simple problems) modifications in files.

To learn packet trace trough the kernel, I read some docs on forwarding
fucntions executed. Later on I found some tips on measuring time in Linux
(O'Reilly Device drivers). The most precise measurements (as far as I know)
is rdtscl() that gives cycle count.

I put code snippets like:
*********************************************************************
rdtscl(start);

/* some important networking code .. like irq, rcv, fwd, dev_xmit */

rdtscl(end);

printk("[irq] serving irq took %li cycles", end-start);

******************************************************************

..all over vital forwarding components. Compiled it (kernel 2.4.18, x386)
ane generated some traffic with IP Traffic trial software.

As a result please see example dmesg underneath... ([x,y] means
gettimeofday() usec's):
>>dmesg
[1055450168,605398][irq] (numer cyklu->-1665244472)
[1055450168,605464][rx_irq] numer cyklu->-1665229089
[1055450168,605515][rx_irq] (eth_copy_and_sum) trwalo : 1125

[1055450168,605585]call netif_rx(pakiet nr[126]) (numer cyklu->-1665200955)
[1055450168,605623]started netif_rx() (numer cyklu->-1665191843)
[1055450168,605661][netif_rx()] packet is put to backlog: (numer
cyklu->-1665183171)
[1055450168,605747][netif_rx]jump to ip_rcv1(). (numer cyklu->-1665163077)
[1055450168,605803][netif_rx]jump to ip_rcv2(). (numer cyklu->-1665150012)
[1055450168,605845][netif_rx]jump to ip_rcv3(). (numer cyklu->-1665140257)
[1055450168,605877][ip_rcv()] pakiet_seq[0] rozpoczeto ip_rcv() (numer
cyklu -1665132875)
[1055450168,605919][ip_rcv()] pakiet_seq[26112] fast_csum() took=311
[1055450168,606000]determining: locally/forward ...
[1055450168,606025][ip_route_input]rt_hash_code() took= -176
[1055450168,606056][ip_route_input]started lookup
>>

But I am aware that this code (i mean - my modifications) kills performance,
if not disturbs outcomes completely ;(

Problem is that dmesg buffer is TOO SMALL (although i am aware i can modify
its size in print.c) and every packets brings lots of data on the screen.
What I would like to do is to run some 2mbps (2 flows; EF PHB and BE PHB)
and see how packet size influences processing time of forwarding steps
(including classification, lookup, fwd, queueing etc.). THIS IS IMPOSSIBLE
with such a small dmesg-buffer and using file system writes for every packet
(this harms outcomes - i thinnk).


Now I am thinking about two things that might help me in my analyzys:
1) creating some mmap'ed memory object and writing timing info to shared
buffer, so that I can postprocess it after experimental packet number have
been sent (forwarded)

2) totally changing the way of measurements


My question is:

A) could anyone COMMENT on my solution to forwarding performance tracing

B) could anyone SUGGEST other (better) way to do this efficiently and to get
reliable data (times)

C) does it have anything in common with kernel profiling??? if yes please
explain me how should I do this

D) ..anything helpfull welcomed here, maybye someone has tried something
like this and would like to share her/his experiences???

i would be most grateful for any comments on my EMAIL.

desperately looking for answer

adam


