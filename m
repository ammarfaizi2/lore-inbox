Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265135AbTAWMLk>; Thu, 23 Jan 2003 07:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265139AbTAWMLk>; Thu, 23 Jan 2003 07:11:40 -0500
Received: from inway106.cdi.cz ([213.151.81.106]:31443 "EHLO luxik.cdi.cz")
	by vger.kernel.org with ESMTP id <S265135AbTAWMLi>;
	Thu, 23 Jan 2003 07:11:38 -0500
Date: Thu, 23 Jan 2003 13:12:49 +0100 (CET)
From: devik <devik@cdi.cz>
X-X-Sender: <devik@devix>
To: <linux-kernel@vger.kernel.org>
cc: <lartc@mailman.ds9a.nl>
Subject: TCP probably broken in W2K
Message-ID: <Pine.LNX.4.33.0301231309020.518-100000@devix>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

this is not exactly Linux problem but it is VERY interesting
and as I'm linux developer I'm posting it here.

Situation:
Win2k, workstation (service packs unknown at the moment as
I have no access to it) connecting via FTP to Linux 2.4.18.
We tried several programs at w2k, both clients and servers.
At linux we tried proftpd, ncftp, wget.
We connect via Internet, DSL+w2k in Italia, leasedline+Linux
in Czech, both 256kbit.

Symptoms:
Transfered files from w2k are corrupted inside. I've written
analyzer  which tries to locate each block of corrupted file
in good copy of it. We used 96MB test file. Here are details:

block 0:43032576(43032577) matched at 0 (off 0)
block 43032577:43159553(126977) matched at 43036672 (off 4095)
block 43159554:55193602(12034049) matched at 43167744 (off 8190)
block 55193603:57233410(2039808) matched at 55205888 (off 12285)
block 57233411:88076291(30842881) matched at 57233411 (off 0)
block 88076292:97873920(9797629) matched at 88080387 (off 4095)

The offset 0 at line 5 is because we "resumed" download
from that point.
>From TCP stream, 4095 bytes is missing at some places, see:

[devik@devix]$ hexdump -f /hfmt -s 43032570 -n 16 xxx.ok
2909ffa: b7 3b 00 76  80 f2 86 76  d6 db 59 e5  d4 41 fe 04
         ^^^^^^^^^^^^^^^^^^^^^
[devik@devix]$ hexdump -f /hfmt -s 43032570 -n 16 xxx.bad
2909ffa: b7 3b 00 76  80 f2 86 fa  19 75 6f a4  fc 7f 35 cc
                      P1-^^ P2 vvvvvvvvvvvvvvvvvvvvvvvvvvvv
[devik@devix]$ hexdump -f /hfmt -s $[43032570+4095] -n 16 xxx.ok
290aff9: 59 d7 9f 6f  50 b4 c8 fa  19 75 6f a4  fc 7f 35 cc

You can see that xxx.bad ends with 80 f2. Then 86 76 should
continue but fa 19 is here (which is 4095 bytes latter in
good copy of file).
Here is relevant part of tcpdump of xxx.bad transfer:

0x04b0   ebe7 8f5c 6b37 f1ff 773d c567 ef07 6489        ...\k7..w=.g..d.
0x04c0   cfa3 c809 f3c4 84e8 2008 b73b 0076 80f2        ...........;.v..
                                              ^^-P1
x.x.x.x.1384 > y.y.y.y.12151: P 43032576:43034028(1452) ack 1 win 17424 (DF)
0x0000   4500 05d4 33c8 4000 6f06 3618 5074 24cc        E...3.@.o.6.Pt$.
0x0010   d597 516c 0568 2f77 1325 dcdf 485a c2f7        ..Ql.h/w.%..HZ..
0x0020   5018 4410 56c7 0000 86fa 1975 6fa4 fc7f        P.D.V......uo...
                             ^^-P2
0x0030   35cc 9649 6d79 de7c f93f 0faf f3f8 6fdb        5..Imy.|.?....o.

(Marks P1 and P2 are here so you can easily pair two lists above)
You can see that the break is NOT at packet boundary but rather
inside of second packet (after the first byte). It means that there
is no problem with tcp transfer itself (also tcp checksum and sequence
numbers are ok). It seems as if sending computer (win2k+DSLmodem)
feeds system calls badly. I'd blame ftp client (which runs at win2k)
but the same problem was true when win2k was running as ftp server.
So we have probably bug in win2k maybe paging related (4095 is too
similar to 4096 which is pagesize).
In the file there was more missing data blocks and ALL 4095 bytes.
And ALWAYS the last byte before missing block is the first byte
of new TCP packet as in example above.
Also always the first of packet pair is LESS THAN 1452 and has
PUSH bit set - it seems that it was the last packet of
"send" syscall block. See:
P 43023192:43024384(1192) ack 1 win 17424 (DF)
. 43024384:43025836(1452) ack 1 win 17424 (DF)
. 43025836:43027288(1452) ack 1 win 17424 (DF)
P 43027288:43028480(1192) ack 1 win 17424 (DF)
. 43028480:43029932(1452) ack 1 win 17424 (DF)
. 43029932:43031384(1452) ack 1 win 17424 (DF)
P 43031384:43032576(1192) ack 1 win 17424 (DF)
-- missing 4095 bytes here ---
P 43032576:43034028(1452) ack 1 win 17424 (DF)
. 43034028:43035480(1452) ack 1 win 17424 (DF)
P 43035480:43036673(1193) ack 1 win 17424 (DF)

You can see that typical sequence contains 4096
bytes (1192+1452+1452). Then PUSH packet is emited.
At place where data is missing in above listing
you see two PUSHes in sequence.
Seems like if some win32 routine missed one page,
but realized it somehow because last packet has
size 1193 instead of 1192.

Anyone knows about this bug or where should I ask ?

-------------------------------
    Martin Devera aka devik
Linux kernel QoS/HTB maintainer
  http://luxik.cdi.cz/~devik/

