Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317982AbSGWHUr>; Tue, 23 Jul 2002 03:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317980AbSGWHUr>; Tue, 23 Jul 2002 03:20:47 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:40123 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S317978AbSGWHUm>; Tue, 23 Jul 2002 03:20:42 -0400
From: "Buddy Lumpkin" <b.lumpkin@attbi.com>
To: "Hayden Myers" <hayden@spinbox.com>, <linux-kernel@vger.kernel.org>
Cc: <linux-net@vger.kernel.org>
Subject: RE: 2.2 to 2.4... serious TCP send slowdowns
Date: Tue, 23 Jul 2002 00:24:34 -0700
Message-ID: <FJEIKLCALBJLPMEOOMECCEFCCPAA.b.lumpkin@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.10.10207221352430.27914-100000@compaq.skyline.net>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about a simple netstat -i, are you getting any collisions or errors?

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Hayden Myers
Sent: Monday, July 22, 2002 11:47 AM
To: linux-kernel@vger.kernel.org
Cc: linux-net@vger.kernel.org
Subject: Re: 2.2 to 2.4... serious TCP send slowdowns


On 20 Jul 2002, Alan Cox wrote:

> Your buffers are way too small buf_cnt wants to be probably 60K or
> higher. Making it large ensures one write syscall will fill all
> available space in the queue immediately drastically reducing syscall
> and wakeup rates. Also avoiding breaks in streaming.

I've played around with changing the buf_cnt size and tests in house have
surprisingly shown a slight slowdown when increasing it to 64k.  This is
most likely inconclusive but it didn't seem to make a large difference.   
I also tried to do away with the read and writen syscalls and replace them
with a sendfile call but this seems to have made things even slower.  

> 
> Without tcpdump data its hard to guess
> 
Tcpdump output is where I'm seeing the difference in the clients receive
window.  Below is tcpdump from the server 

[root@install spinbox]# /usr/sbin/tcpdump src port 80
tcpdump: listening on eth0
11:37:21.003009 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53687: S 273731802:273731802(0) ack
2533363500 win 5792 <mss 1460,sackOK,timestamp 25697 104440615,nop,wscale
0> (DF)
11:37:21.006489 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53687: . ack 302 win 6432
<nop,nop,timestamp 25698 104440615> (DF)
11:37:21.009357 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53687: P 1:16(15) ack 302 win 6432
<nop,nop,timestamp 25698 104440615> (DF)
11:37:21.009529 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53687: P 16:123(107) ack 302 win 6432
<nop,nop,timestamp 25698 104440616> (DF)
11:37:21.009696 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53687: P 123:263(140) ack 302 win 6432
<nop,nop,timestamp 25698 104440616> (DF)
11:37:21.010081 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53687: . 263:1711(1448) ack 302 win
6432 <nop,nop,timestamp 25698 104440616> (DF)
11:37:21.010116 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53687: . 1711:3159(1448) ack 302 win
6432 <nop,nop,timestamp 25698 104440616> (DF)11:37:21.010687
install.skyline.net.http > leg-66-247-99-8-RLY.sprinthome.com.53687: P
3159:4607(1448) ack 302 win 6432 <nop,nop,timestamp 25698 104440616>
(DF)11:37:21.010698 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53687: . 4607:6055(1448) ack 302 win
6432 <nop,nop,timestamp 25698 104440616> (DF)11:37:21.010726
install.skyline.net.http > leg-66-247-99-8-RLY.sprinthome.com.53687: .
6055:7503(1448) ack 302 win 6432 <nop,nop,timestamp 25698 104440616>
(DF)11:37:21.010736 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53687: P 7503:8951(1448) ack 302 win
6432 <nop,nop,timestamp 25698 104440616> (DF)11:37:21.011557
install.skyline.net.http > leg-66-247-99-8-RLY.sprinthome.com.53687: .
8951:10399(1448) ack 302 win 6432 <nop,nop,timestamp 25698 104440616> (DF)
11:37:21.011571 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53687: . 10399:11847(1448) ack 302 win
6432 <nop,nop,timestamp 25698 104440616> (DF)
11:37:21.011583 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53687: FP 11847:12744(897) ack 302 win
6432 <nop,nop,timestamp 25698 104440616> (DF)
11:37:21.058316 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53688: S 265781655:265781655(0) ack
2534779761 win 5792 <mss 1460,sackOK,timestamp 25703 104440621,nop,wscale
0> (DF)
11:37:21.059682 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53688: . ack 334 win 6432
<nop,nop,timestamp 25703 104440621> (DF)
11:37:21.061403 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53688: P 1:16(15) ack 334 win 6432
<nop,nop,timestamp 25703 104440621> (DF)
11:37:21.061574 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53688: P 16:123(107) ack 334 win 6432
<nop,nop,timestamp 25703 104440621> (DF)
11:37:21.061732 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53688: P 123:263(140) ack 334 win 6432
<nop,nop,timestamp 25703 104440621> (DF)
11:37:21.061973 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53688: . 263:1711(1448) ack 334 win
6432 <nop,nop,timestamp 25703 104440621> (DF)
11:37:21.062000 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53688: . 1711:3159(1448) ack 334 win
6432 <nop,nop,timestamp 25703 104440621> (DF)11:37:21.062572
install.skyline.net.http > leg-66-247-99-8-RLY.sprinthome.com.53688: P
3159:4607(1448) ack 334 win 6432 <nop,nop,timestamp 25703 104440621>
(DF)11:37:21.062583 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53688: . 4607:6055(1448) ack 334 win
6432 <nop,nop,timestamp 25703 104440621> (DF)11:37:21.062611
install.skyline.net.http > leg-66-247-99-8-RLY.sprinthome.com.53688: .
6055:7503(1448) ack 334 win 6432 <nop,nop,timestamp 25703 104440621>
(DF)11:37:21.062619 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53688: P 7503:8951(1448) ack 334 win
6432 <nop,nop,timestamp 25703 104440621> (DF)11:37:21.063147
install.skyline.net.http > leg-66-247-99-8-RLY.sprinthome.com.53688: .
8951:10399(1448) ack 334 win 6432 <nop,nop,timestamp 25703 104440621> (DF)
11:37:21.063156 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53688: . 10399:11847(1448) ack 334 win
6432 <nop,nop,timestamp 25703 104440621> (DF)
11:37:21.063167 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53688: FP 11847:12744(897) ack 334 win
6432 <nop,nop,timestamp 25703 104440621> (DF)
11:37:21.093947 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53687: . ack 303 win 6432
<nop,nop,timestamp 25707 104440624> (DF)
11:37:21.112002 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53688: . ack 335 win 6432
<nop,nop,timestamp 25708 104440626> (DF)

According to the tcpdump manpage win 6432 is the number of bytes of
receive buffer space available the other direction of the connection. 

Below is a tcpdump session for the same request on the same client but
with the server on a 2.2.20 kernel.


[root@install spinbox]# /usr/sbin/tcpdump src port 80
tcpdump: listening on eth0
11:45:00.379901 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53702: S 754852391:754852391(0) ack
2999938034 win 30660 <mss 1460,sackOK,timestamp 11434 104486504,nop,wscale
0> (DF)
11:45:00.383374 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53702: . ack 302 win 30660
<nop,nop,timestamp 11435 104486504> (DF)
11:45:00.386345 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53702: P 1:16(15) ack 302 win 31856
<nop,nop,timestamp 11435 104486504> (DF)
11:45:00.386571 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53702: P 16:47(31) ack 302 win 31856
<nop,nop,timestamp 11435 104486504> (DF)
11:45:00.386855 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53702: P 47:73(26) ack 302 win 31856
<nop,nop,timestamp 11435 104486504> (DF)
11:45:00.387116 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53702: P 73:154(81) ack 302 win 31856
<nop,nop,timestamp 11435 104486504> (DF)
11:45:00.387314 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53702: P 154:263(109) ack 302 win 31856
<nop,nop,timestamp 11435 104486504> (DF)
11:45:00.427821 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53703: S 754496145:754496145(0) ack
3011203697 win 30660 <mss 1460,sackOK,timestamp 11439 104486508,nop,wscale
0> (DF)
11:45:00.429069 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53703: . ack 334 win 30660
<nop,nop,timestamp 11439 104486508> (DF)
11:45:00.435172 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53703: P 1:16(15) ack 334 win 31856
<nop,nop,timestamp 11440 104486508> (DF)
11:45:00.435392 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53703: P 16:47(31) ack 334 win 31856
<nop,nop,timestamp 11440 104486509> (DF)
11:45:00.435636 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53703: P 47:73(26) ack 334 win 31856
<nop,nop,timestamp 11440 104486509> (DF)
11:45:00.435825 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53703: P 73:210(137) ack 334 win 31856
<nop,nop,timestamp 11440 104486509> (DF)
11:45:00.436047 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53703: P 210:263(53) ack 334 win 31856
<nop,nop,timestamp 11440 104486509> (DF)
11:45:00.468318 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53702: P 263:1711(1448) ack 302 win
31856 <nop,nop,timestamp 11443 104486504> (DF)11:45:00.468380
install.skyline.net.http > leg-66-247-99-8-RLY.sprinthome.com.53702: P
1711:3159(1448) ack 302 win 31856 <nop,nop,timestamp 11443 104486504> (DF)
11:45:00.468422 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53702: P 3159:4607(1448) ack 302 win
31856 <nop,nop,timestamp 11443 104486504> (DF)
11:45:00.468467 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53702: . 4607:6055(1448) ack 302 win
31856 <nop,nop,timestamp 11443 104486504> (DF)
11:45:00.468945 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53702: . 6055:7503(1448) ack 302 win
31856 <nop,nop,timestamp 11443 104486512> (DF)
11:45:00.468959 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53702: . 7503:8951(1448) ack 302 win
31856 <nop,nop,timestamp 11443 104486512> (DF)
11:45:00.468980 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53702: . 8951:10399(1448) ack 302 win
31856 <nop,nop,timestamp 11443 104486512> (DF)
11:45:00.469235 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53702: . 10399:11847(1448) ack 302 win
31856 <nop,nop,timestamp 11443 104486512> (DF)
11:45:00.469250 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53702: FP 11847:12744(897) ack 302 win
31856 <nop,nop,timestamp 11443 104486512> (DF)
11:45:00.470040 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53703: P 263:1711(1448) ack 334 win
31856 <nop,nop,timestamp 11443 104486509> (DF)11:45:00.470077
install.skyline.net.http > leg-66-247-99-8-RLY.sprinthome.com.53703: P
1711:3159(1448) ack 334 win 31856 <nop,nop,timestamp 11443 104486509> (DF)
11:45:00.470120 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53703: P 3159:4607(1448) ack 334 win
31856 <nop,nop,timestamp 11443 104486509> (DF)
11:45:00.470257 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53703: . 4607:6055(1448) ack 334 win
31856 <nop,nop,timestamp 11443 104486509> (DF)
11:45:00.470638 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53703: . 6055:7503(1448) ack 334 win
31856 <nop,nop,timestamp 11443 104486513> (DF)
11:45:00.470654 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53703: . 7503:8951(1448) ack 334 win
31856 <nop,nop,timestamp 11443 104486513> (DF)
11:45:00.470675 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53703: . 8951:10399(1448) ack 334 win
31856 <nop,nop,timestamp 11443 104486513> (DF)
11:45:00.471015 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53703: . 10399:11847(1448) ack 334 win
31856 <nop,nop,timestamp 11443 104486513> (DF)
11:45:00.471048 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53703: FP 11847:12744(897) ack 334 win
31856 <nop,nop,timestamp 11443 104486513> (DF)
11:45:00.487840 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53702: . ack 303 win 31856
<nop,nop,timestamp 11445 104486514> (DF)
11:45:00.532997 install.skyline.net.http >
leg-66-247-99-8-RLY.sprinthome.com.53703: . ack 335 win 31856
<nop,nop,timestamp 11450 104486519> (DF)

Looks to be about the same amount of data going in each packet but the
clients receive window is much larger for some reason.  I tried tweaking
all of the window parameters I can find both in the kernel and in proc but
none seem to increase this number.  Is there a reason this number is much
lower in a vanilla 2.4 kernel?  I'm not very familiar with the 2.4 and
it's ways yet but I've been reading abou the autotuning algorithms that
have been put in place and lay suspect to them for the differences.  Any
ideas as to why the windows are very different?



Hayden Myers	
Support Manager
Skyline Network Technologies	
hayden@spinbox.com
(410)583-1337 option 2




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

