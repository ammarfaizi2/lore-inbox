Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278782AbRJ0N2a>; Sat, 27 Oct 2001 09:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278788AbRJ0N2L>; Sat, 27 Oct 2001 09:28:11 -0400
Received: from ns1.uklinux.net ([212.1.130.11]:13321 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S278782AbRJ0N2I>;
	Sat, 27 Oct 2001 09:28:08 -0400
Envelope-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Message-Id: <a0510030fb800638f396a@[192.168.239.101]>
In-Reply-To: <9i9lttg9ifdhigh57imv15jhakefk10p9c@4ax.com>
In-Reply-To: <9i9lttg9ifdhigh57imv15jhakefk10p9c@4ax.com>
Date: Sat, 27 Oct 2001 14:28:37 +0100
To: Stefan Hoffmeister <lkml.2001@econos.de>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: Bandwidth QoS for disks?
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I just lost another CD-R due to cron with lots and lots of on-disk
>seeking kicking in, killing all that bandwidth cdrecord needed - and I
>don't have one of these new and fancy burn-proof things (and, yes, I
>should have suspended cron and friends, but I am only human and
>computers are meant to made my life easier).
>
>Sure, I could instruct cdrecord to increase its own read-ahead cache
>from 4 MB to, say, 128 MB. But read-ahead cache != "QoS" (except for
>volume of data == size of read-ahead cache), only a lame attempt at,
>well, being helpful in an imperfect world.

If you increase cdrecord's FIFO, you are giving it more time to 
receive data, to refill the FIFO, and send the kernel a bigger 
request.  On an 8x writer, the 4Mb FIFO will empty in about 3.5 
seconds, which is not enough for an IDE disk to process a queue of 
seeks from the cronjob and return that quantity of data.  If you give 
it a decent-sized FIFO, for example 64Mb, you are giving it the 
chance to:

- Request one piece of data (smallish) when the FIFO is first drained.

- Wait for a queue of seeks to complete and the first piece to be returned.

- During this time, the FIFO is being further drained...  cdrecord 
then sends off a request for the larger deficit which now exists.

- The kernel will process the new queue of seeks from the cronjob, 
then hopefully return cdrecord's requested data all at once.

- The FIFO is still draining, to about twice the former level, but is 
now replenished to the former level.  cdrecord asks for the next 
(large size) chunk of data.

The bottleneck in terms of latency is probably not the kernel, but 
the IDE disk.  It can only process seeks at a certain rate, and it 
must return the data in-order due to the lame IDE spec (it need not 
perform the actual seeks in order, but that's another story).  Due to 
the serialised nature of the cronjobs themselves, the kernel is 
already putting cdrecord's requests fairly near the front of the 
queue (even though they're actually at the back), so there's not a 
great deal it can do to help.

Did I mention I have a 1993-built machine which can run an 8x writer 
from it's original disk?  The writer is no longer in that machine, 
but it hardly matters.  In both the old and new machines, I always 
use a relatively large FIFO, just to be safe.

-- 
--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
website:  http://www.chromatix.uklinux.net/vnc/
geekcode: GCS$/E dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$
           V? PS PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
tagline:  The key to knowledge is not to rely on people to teach you it.
