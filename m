Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262816AbSJLDEp>; Fri, 11 Oct 2002 23:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262815AbSJLDEp>; Fri, 11 Oct 2002 23:04:45 -0400
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:41872 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id <S262816AbSJLDEn>; Fri, 11 Oct 2002 23:04:43 -0400
From: "Joseph D. Wagner" <wagnerjd@prodigy.net>
To: "Linux Kernel Development List" <linux-kernel@vger.kernel.org>
Subject: RE: Strange load spikes on 2.4.19 kernel
Date: Fri, 11 Oct 2002 22:10:22 -0500
Message-ID: <001501c2719c$edcbaba0$53241c43@joe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I doubt it's the journal, but remember that data=journal requires a much
larger journal than data=ordered.

I'd suggest the following:

1) If you don't need to know when a file was last accessed, mount the
ext3 file system with the -noatime option.  This disables updating of
the "Last Accessed On:" property, which should significantly increase
throughput.

2) EXT3 is optimized for writes but it sounds like your server is used
primarily for reads.  (If, I'm wrong, ignore this point.)  Try:
/sbin/elvtune -r 16384 -w 8192 /dev/mount-point
	where mount-point is the partition (e.g. /dev/hda5)

If this only makes things worse, it means either 1) my numbers are too
big, or 2) your system should be optimized for writes.  (BTW, the
default is -r 4096 -w 8192.)

You can also try other elvtune settings.  Once you have found elvtune
settings that give you your most satisfactory mix of latency and
throughput for your application set, you can add the calls to the
/sbin/elvtune program to the end of your /etc/rc.d/rc.local script so
that they are set again to your chosen values at every boot.

3) If the above don't work, double the journal size.

Hope this helped.

Joseph Wagner

P.S.  You'd probably get more help from the ext3 mailing list.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Rob Mueller
Sent: Friday, October 11, 2002 9:26 PM
To: Andrew Morton
Cc: linux-kernel@vger.kernel.org; Jeremy Howard
Subject: Re: Strange load spikes on 2.4.19 kernel


> > Filesystem is ext3 with one big / partition (that's a mistake
> > we won't repeat, but too late now). This should be mounted
> > with data=journal given the kernel command line above, though
> > it's a bit hard to tell from the dmesg log:
> >
>
> It's possible tht the journal keeps on filling.  When that happens,
> everything has to wait for writeback into the main filesystem.
> Completion of that writeback frees up journal space and then
everything
> can unblock.
>
> Suggest you try data=ordered.

We have a 192M journal, and from the dmesg log it's saying that it's got
a 5
second flush interval, so I can't imagine that the journal is filling,
but
we'll try it and see I guess.

What I don't understand is why the spike is so sudden, and decays so
slowly.
It's Friday night now, so the load is fairly low. I setup a loop to dump
uptime information every 10 seconds and attached the result below. It's
running smoothly, then 'bam', it's hit with something big, which then
slowly
decays off.

A few extra things:
1. It happens every couple of minutes or so, but not exactly on any
time, so
it's not a cron job or anything
2. Viewing 'top', there are no extra processes obviously running when it
happens

Rob

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

