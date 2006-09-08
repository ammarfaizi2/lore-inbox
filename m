Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbWIHPtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWIHPtw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 11:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbWIHPtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 11:49:52 -0400
Received: from mms2.broadcom.com ([216.31.210.18]:51726 "EHLO
	mms2.broadcom.com") by vger.kernel.org with ESMTP id S1750917AbWIHPtt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 11:49:49 -0400
X-Server-Uuid: D9EB6F12-1469-4C1C-87A2-5E4C0D6F9D06
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: Re: TG3 data corruption (TSO ?)
Date: Fri, 8 Sep 2006 08:49:41 -0700
Message-ID: <1551EAE59135BE47B544934E30FC4FC093FB19@NT-IRVA-0751.brcm.ad.broadcom.com>
In-Reply-To: <1157704257.31071.68.camel@localhost.localdomain>
Thread-Topic: TG3 data corruption (TSO ?)
thread-index: AcbTIbSdgE9nsH0yRomuXzAIuSCFGAAO8hqg
From: "Michael Chan" <mchan@broadcom.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       netdev@vger.kernel.org
cc: "David S. Miller" <davem@davemloft.net>,
       "Segher Boessenkool" <segher@kernel.crashing.org>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006090805; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413031303230352E34353031384638412E303031422D412D;
 ENG=IBF; TS=20060908154946; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006090805_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 691F4E9D3885551806-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Copying netdev.

Benjamin Herrenschmidt wrote:
> Hi !
> 
> I've been chasing with Segher a data corruption problem lately.
> Basically transferring huge amount of data (several Gb) and I get
> corrupted data at the rx side. I cannot tell for sure wether what I've
> been observing here is the same problem that segher's been seing on is
> blades, he will confirm or not. He also seemed to imply that reverting
> to an older kernel on the -receiver- side fixed it, which makes me
> wonder, since it's looks really like a sending side problem (see
> explanation below), if some change in, for exmaple, window scaling,
> might hide or trigger it. 

Please send me lspci and tg3 probing output so that I know what
tg3 hardware you're using.  I also want to look at the tcpdump or
ethereal on the mirrored port that shows the packet being corrupted.

> 
> Now, first, I've been playing with ssh from /dev/zero on one machine
> to /dev/zero on the other. That allowed me to run enough 
> tests all over
> the place to have some idea of where the problem comes from since ssh
> will shoke at decryption when hitting the corruption.
> 
> The base setup where it happens often is 2 Quad G5's connected to a
> gigabit switch. Both were running some versions of 2.6.18-rc4 and -rc5
> (some random git actually, but see below as I've reproduced 
> the problem
> with today's git snapshot which includes the TG3 tx race fix among
> others).
> 
> I have reproduced with various machines as the receiver. A sungem in a
> Dual G5 and a virtual ethernet in a Power5 partition (so the 
> packets go
> to an e1000 then routed through an AIX IO server to a virtual
> ethernet :) are good examples of "variety" :) I haven't tested with
> non-PowerPC machines so far. I've also never been able to 
> reproduce with
> TSO disabled on the emitting TG3's
> 
> Then, I've hacked tridge "socklib" test program (a simple TCP server
> that pushes a known buffer and a simple TCP receiver that 
> connects to it
> and reads the data). I've added comparison of the data with what they
> are supposed to be on the receiving end. The interesting thing is that
> is much faster than ssh or whatever else I tried. ssh or rsync between
> those 2 Quad G5s give me about 35Mb/sec while I get to 
> 107Mb/sec average
> with the small test program.
> 
> The fun thing is, I've not been able to reproduce at all that 
> way. When
> the link is pretty much saturated, the problem doesn't occur !
> 
> As soon as I introduce a small delay (some crap waiting loop) in the
> sender to slow down the throughput to about 80Mb/sec, then the problem
> starts occuring every now and then (I don't have precise frquency data
> but I get a corruption every couple of gigabytes I'd say).
> 
> As for my previous tests, disabling TSO on the sending side 
> "fixes" it.
> 
> Below is a dump of what the corruption look like. I've trimmed the
> beginning and end of the dumped packet (the receiver does 8k 
> reads). The
> 0x5a are the expected data, the rest is corruption. They look like
> kernel pointers, but that isn't always the case (often though but that
> might not be relevant). The size and position within the buffer of the
> corrupted data is variable (doesn't seem to be specifically a page or
> anything nice and round like that).
> 
> I've configured the switch to send all the traffic between the two
> machines to a 3rd box and then recorded it with tcpdump (the 
> "spy" uses
> an e1000) and I can see the corrupted data in the recorded
> traces (the exact same pattern as detected by the receiver). 
> So it seems
> very likely at this point that the corruption happens on the sending
> side. The TCP checksums are correct I assume. I don't see any error
> count on the receiving tg3 nor suspicous message in dmesg indicating
> they aren't.
> 
> That's all the data I have at this point. I can't guarantee 100% that
> it's a TSO bug (it might be a bug that TSO renders visible 
> due to timing
> effects) but it looks like it since I've not reproduced yet with TSO
> disabled. I'll do an overnight test to confirm that though... 
> sometimes
> the bug can take it's time to show up ... I've seen it wait 
> 20Gb before
> it kicked in. Also the fact that fully loading the machine never
> produced it is strange.... smells like a race.
> 
> Cheers,
> Ben.
> 
> 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> 5a 5a 5a 5a 5a 5a 5a 5a 00 00 00 00 00 00 00 00
> 2f 63 70 75 73 00 7f 7e c0 00 00 00 01 cb 70 82
> 00 00 00 04 bf 1d db 4d c0 00 00 00 01 cb 92 00
> c0 00 00 01 7b fe 6d 98 c0 00 00 00 01 cb 70 91
> 00 00 00 04 df 5d fe fd c0 00 00 00 01 cb 92 10
> c0 00 00 01 7b fe 6d b8 c0 00 00 00 01 cb 71 0e
> 00 00 00 04 fe e2 fb cf c0 00 00 00 01 cb 92 20
> c0 00 00 01 7b fe 6d d8 c0 00 00 00 01 cb 71 1f
> 00 00 00 04 73 69 ed ff c0 00 00 00 01 cb 92 30
> c0 00 00 01 7b fe 6d f8 c0 00 00 00 01 cb 70 04
> 00 00 00 04 b9 fe cf ff c0 00 00 00 01 cb 92 40
> c0 00 00 01 7b fe 6e 18 c0 00 00 00 00 3f 7b c8
> 00 00 00 05 ff df b9 bc c0 00 00 01 7b fe 6e 38
> 00 00 00 00 00 00 00 00 63 70 75 73 00 8d f1 ce
> c0 00 00 01 7b fe 73 60 c0 00 00 00 01 cb 92 64
> ff 89 d6 80 ff 89 d6 80 00 00 00 01 00 00 00 00
> c0 00 00 01 7b fe 68 00 c0 00 00 01 7b fe 6e c8
> c0 00 00 01 7b fe 6e e0 00 00 00 00 00 00 00 00
> c0 00 00 01 7b fe 6c e8 c0 00 00 01 7b fe 73 70
> c0 00 00 01 7b fe 75 48 c0 00 00 01 7b fe 73 70
> c0 00 00 01 7b fe 73 70 c0 00 00 01 7b fa 9e 80
> 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 2f 63 70 75 73 2f 50 6f
> 77 65 72 50 43 2c 47 35 40 30 00 7e 5e 6f 4d ef
> c0 00 00 00 01 cb 70 6c 00 00 00 04 7f ee b7 fe
> c0 00 00 00 01 cb 92 64 c0 00 00 01 7b fe 6f 00
> c0 00 00 00 01 cb 71 35 00 00 00 04 bb cc e9 67
> c0 00 00 00 01 cb 92 74 c0 00 00 01 7b fe 6f 20
> c0 00 00 00 01 cb 71 39 00 00 00 04 2f fc eb b9
> c0 00 00 00 01 cb 92 84 c0 00 00 01 7b fe 6f 40
> c0 00 00 00 01 cb 71 3e 00 00 00 04 e7 5f be de
> c0 00 00 00 01 cb 92 94 c0 00 00 01 7b fe 6f 60
> c0 00 00 00 01 cb 71 49 00 00 00 04 e6 73 e7 a7
> c0 00 00 00 01 cb 92 a4 c0 00 00 01 7b fe 6f 80
> c0 00 00 00 01 cb 71 55 00 00 00 08 1b fb 77 f9
> c0 00 00 00 01 cb 92 b4 c0 00 00 01 7b fe 6f a0
> c0 00 00 00 01 cb 70 9d 00 00 00 04 b6 db 59 ef
> c0 00 00 00 01 cb 92 c8 c0 00 00 01 7b fe 6f c0
> c0 00 00 00 01 cb 71 5b 00 00 00 04 69 6f fc da
> c0 00 00 00 01 cb 92 d8 c0 00 00 01 7b fe 6f e0
> c0 00 00 00 01 cb 71 69 00 00 00 04 d6 7b 66 de
> c0 00 00 00 01 cb 92 e8 c0 00 00 01 7b fe 70 00
> 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> 
 

