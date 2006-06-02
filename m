Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWFBIYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWFBIYk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 04:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWFBIYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 04:24:40 -0400
Received: from ns.dynamicweb.hu ([195.228.155.139]:41182 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1751319AbWFBIYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 04:24:39 -0400
Message-ID: <017001c6861d$eef931c0$1800a8c0@dcccs>
From: "Janos Haar" <djani22@netcenter.hu>
To: "Nathan Scott" <nathans@sgi.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-xfs@oss.sgi.com>
References: <004501c68225$00add170$1800a8c0@dcccs> <9a8748490605280917l73f5751cmf40674fc22726c43@mail.gmail.com> <01d801c6827c$fba04ca0$1800a8c0@dcccs> <01a801c683d2$e7a79c10$1800a8c0@dcccs> <200605301903.k4UJ3xQU008919@turing-police.cc.vt.edu> <1149038431.21827.20.camel@localhost.localdomain> <20060531143849.C478554@wobbly.melbourne.sgi.com> <00f501c68488$4d10c080$1800a8c0@dcccs> <20060602075826.B530100@wobbly.melbourne.sgi.com> <01ed01c685c8$b46ec6f0$1800a8c0@dcccs> <20060602094325.A531851@wobbly.melbourne.sgi.com>
Subject: Re: XFS related hang (was Re: How to send a break? - dump from frozen 64bit linux)
Date: Fri, 2 Jun 2006 10:01:12 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Nathan Scott" <nathans@sgi.com>
To: "Janos Haar" <djani22@netcenter.hu>
Cc: <linux-kernel@vger.kernel.org>; <linux-xfs@oss.sgi.com>
Sent: Friday, June 02, 2006 1:43 AM
Subject: Re: XFS related hang (was Re: How to send a break? - dump from
frozen 64bit linux)


> On Fri, Jun 02, 2006 at 12:14:04AM +0200, Janos Haar wrote:
> > ---- Original Message ----- 
> > > On Wed, May 31, 2006 at 10:00:33AM +0200, Janos Haar wrote:
> > > >
> > > > Hey, i think i found something.
> > > > My quota on my huge device is broken.
> > > > (inferno   -- 18014398504855404       0       0
> > 18446744073709551519
> > > > 0     0)
> > >
> > > Hmm, that is interesting.  I guess you don't know whether this
> > > accounting problem happened before you rebooted or whether it
> > > only just got this way (after journal recovery)?
> >
> > In my system, this huge device is difficult.
>
> Can you describe your hardware a bit more?  (and send xfs_info
> output too please).

[root@X64 ~]# xfs_info /mnt/md0
meta-data=/dev/md31              isize=256    agcount=2600, agsize=1240024
blks
         =                       sectsz=512   attr=0
data     =                       bsize=4096   blocks=3223457536, imaxpct=25
         =                       sunit=1      swidth=4 blks, unwritten=1
naming   =version 2              bsize=4096
log      =internal               bsize=4096   blocks=32768, version=1
         =                       sectsz=512   sunit=0 blks
realtime =none                   extsz=16384  blocks=0, rtextents=0

(I used the xfs_grow 2 times)

The hw:
I use 4 nodes, each has 3.3TiB (RAID4 array), and serves NBD.

On the concentrator the RAID0 makes one 12.9TiB from 4x3.3TiB nbd device.
The strip is 4kb. (tested, and optimal for performance)


>
> > I often need to reboot, and run xfs_repair, to make it clean. (nodes
hangs,
> > reboots, etc...)
>
> Ehrm, hmm, that smells fishy... does this device have a write
> cache enabled by any chance?

Yes, you have right!
I know, this is a big chance to corrupt the fs, but i need strongly the
write caching!

This quota corruption is from that case too....

>
> > Now is my default reboot option is xfs_repair -L, so i dont know, this
> > happens before, or after, sorry.
>
> Oh, thats bad, all bets are off then - you really cant go doing
> that routinely, thats an "in emergency only" big red button -

:-) Yes, i know.
But on my case, the service is much more important than the data inside the
fs.
I run a huge "free web storage", and i hate that thing, when i get up, and
can see, the system stops on the automatic reboot, and down for few hours...
>8-(
If it can reboot normally, and drop some MB or GB, this is a "little lose"
for me.

> it throws away the contents of the journal, and will pretty much
> guarantee filesystem corruption.

Anyway, if i remove the he -L, the boot hangs on mount about 8 from10 times.
The ~1GB lose of 4K strip can pretty much damage the journal too.....
If it can repair the fs (2 times from 10), it is often uncompleted, and some
minutes or hours lated i get the XFS_FORCE_SHUTDOWN message thanks to the
corruption....
(I planned to use an external log, but at this time i dont trust too much
the journal recovery....
And if the concentrator finish the flush, the journal notes that it is
completed, but the node can hang during write, and drop the data anyway.)


>
> But, it sounds alot like you may have a big hardware reliability
> issue there, which is going to make it difficult to distinguish
> any software problems.  However, if you find a way to reproduce
> that quota accounting problem (above), I'm all ears.

Sorry, but i cant.
Additionally, i allready have shut down the quota, and i cannot reproduce
the "bad quota related hang" problem.

Thanks a lot!

Janos

>
> cheers.
>
> -- 
> Nathan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

