Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271997AbRHVNKt>; Wed, 22 Aug 2001 09:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271998AbRHVNKj>; Wed, 22 Aug 2001 09:10:39 -0400
Received: from postfix2-2.free.fr ([213.228.0.140]:41220 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S271997AbRHVNKc> convert rfc822-to-8bit; Wed, 22 Aug 2001 09:10:32 -0400
Date: Wed, 22 Aug 2001 15:06:29 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Sven Heinicke <sven@research.nj.nec.com>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: With Daniel Phillips Patch (was: aic7xxx with 2.4.9 on 7899P) 
In-Reply-To: <15234.58734.200740.952923@abasin.nj.nec.com>
Message-ID: <20010822135854.H1225-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Aug 2001, Sven Heinicke wrote:

> Justin,
>
> I've tried removing your check, for writing bonnie++ still reports
> slower write times then IDE drive on the other system.  Daniel Phillips
> was great at helping me notice a problem that was causing slow down
> but not related to the aic7xxx driver, thus I am now trying the
> 7.4.8-ac8 kernel.

If you are referring to sequential writes, then I may add the following
comments to this thread. :-)

Given a more-or-less single-threaded sequential disk write load, the
sending of ORDERED TAGS should not impact significantly performances,
unless actual IOs queuing is extremally misordered.

You will get best performances for single-threaded sequential write load
by relying on kernel sorting and coalescing rather than on the ability of
the disk to accept a large number of tagged commands. As the aic7xxx
driver wants to use the largest possible number of queued commands, it
justs hits the worst case for performances of sequential writes, in my
opinion. Having write behind caching enabled by the device also helps a
lot for sequential writes.

You should enabled write caching and give a try with tagged command
queuing disabled (or using a small queue depth for your drives). BUT, you
must make sure that the low-level driver doesn't announce some large queue
to upper layers and queues internally the IOs. If it does so, the kernel
will not be able to sort and coalesce IOs and the device will be queued
with bunches of very small IOs.

--
To Justin:

Unless I missed some recent development, Linux SCSI does not allow to
dynamically resize device queues. Your FreeBSD-CAM layer do as we know.

As a result, once a device queue depth has been announced under Linux, SIM
must queue commands internally if it wants to use a shorter actual queue
for this device. All the IOs that are deferred this way aren't seen by
parts that perform optimizations. Theses parts are obviously the kernel
block device and the device itself. This cannot be good for performances
in my opinion. On the other hand, there are still some pathes that may
scan sequentially device queues and io request queues in the kernel. As
you know better than me, you are using heaps under FreeBSD-CAM that have
the advantage of allowing to handle priorities and consume less CPU. But
CPU is cheap nowadays...

So, let me write again than using large device queues by default under
Linux is not desirable, in my opinion. Personnaly, I use a device queue
depth of 16 commands under Linux for my drives. Under FreeBSD, my driver
announces 64 and relies on CAM for shrinking this depth if CAM thinks it
is better. Btw, none of my drives are able to handle more than 64
simultaneous commands (the fastest one is a Cheetah Ultra-160).


> I made your change whe will get try to get my user to test the system
> with and without your change.
>
>      Sven
>
> Justin T. Gibbs writes:
>  > >Disk access is faster then before but still slower then the IDE
>  > >drive.  Any ideas?
>  >
>  > It could be the occasionall ordered tag that is sent to the drive to
>  > prevent tag starvation.  If you search in drivers/scsi/aic7xxx/aic7xxx_linux.c
>  > for "OTAG_THRESH" and make that if test always fail (add an "&& 0") you will
>  > have effectively disabled this feature.  I should probably make it an option
>  > that defaults to off.
>  >
>  > --
>  > Justin

Regards,
  Gérard.

