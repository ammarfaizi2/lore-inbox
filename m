Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316712AbSGSPZm>; Fri, 19 Jul 2002 11:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316836AbSGSPZm>; Fri, 19 Jul 2002 11:25:42 -0400
Received: from noc.easyspace.net ([62.254.202.67]:15367 "EHLO
	noc.easyspace.net") by vger.kernel.org with ESMTP
	id <S316712AbSGSPZl>; Fri, 19 Jul 2002 11:25:41 -0400
Date: Fri, 19 Jul 2002 16:28:41 +0100
From: Sam Vilain <sam@vilain.net>
To: stoffel@lucent.com
Cc: matthias.andree@stud.uni-dortmund.de, linux-kernel@vger.kernel.org
Subject: Re: Backups done right (was [ANNOUNCE] Ext3 vs Reiserfs benchmarks)
In-Reply-To: <15668.39927.923118.516621@gargle.gargle.HOWL>
References: <20020716193831.GC22053@merlin.emma.line.org>
	<Pine.LNX.4.44.0207161408270.3452-100000@hawkeye.luckynet.adm>
	<20020716210639.GC30235@merlin.emma.line.org>
	<15668.39927.923118.516621@gargle.gargle.HOWL>
X-Mailer: Sylpheed version 0.7.8claws (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Face: NErb*2NY4\th?$s.!!]_9le_WtWE'b4;dk<5ot)OW2hErS|tE6~D3errlO^fVil?{qe4Lp_m\&Ja!;>%JqlMPd27X|;b!GH'O.,NhF*)e\ln4W}kFL5c`5t'9,(~Bm_&on,0Ze"D>rFJ$Y[U""nR<Y2D<b]&|H_C<eGu?ncl.w'<
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E17VZgR-0000Mt-00@hofmann>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stoffel@lucent.com wrote:

>   1. lock application(s), flush any outstanding transactions.
>   2. lock filesystems, flush any outstanding transactions.
>   3a. lock mirrored volume, flush any outstanding transactions, break
>       mirror.
>   3b. snapshot filesystem to another volume.

Or, to avoid the penalty of locking everything and bringing it down
and stuff:

  1. set a flag.

  2. start backing up blocks (read them raw of course, don't want to load
     those stressed higher level systems)

  3. If something wants to write to a block, quickly back up the old
     contents of the block before you write the new contents.  Unless of
     course you've already backed up that block.

Of course, step 3 does place a bit more unschedulable load on the
disk.  Heck, when the backups have just started, you're doubling the
latency of the devices.  You can avoid this with a transaction
journal; in fact, the cockier RDBMSes out there (eg, DMSII) don't even
bother to do this and assume that your transaction journal is on a
mirrored device - and hence there's no point in backing up the old
data, you just want to do one sweep of the disk - and replay the
journal to get current.

(note: implicit assumption: you're dealing with applications using
synchronous I/O, where it needs to be written to all mirrors before
it's trusted to be stored)

Ah, moot points - the Linux MD/LVM drivers are far too unsophisticated
to have journal devices ;-)
--
   Sam Vilain, sam@vilain.net     WWW: http://sam.vilain.net/
    7D74 2A09 B2D3 C30F F78E      GPG: http://sam.vilain.net/sam.asc
    278A A425 30A9 05B5 2F13

Law of Computability Applied to Social Sciences:
 If at first you don't suceed, transform your data set.
