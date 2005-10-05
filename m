Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932556AbVJEGnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbVJEGnn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 02:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbVJEGnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 02:43:43 -0400
Received: from web30303.mail.mud.yahoo.com ([68.142.200.96]:54444 "HELO
	web30303.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932556AbVJEGnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 02:43:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=XWDtOUACWkhrniEQHqRvkNAcI1Ok07PwVoLUQGtWr1Ma9ojT2dvpMBh0tFcsIqoIzH9E0XbgXcMdyzmm0ibTx3ls3s9qgkfxAtLDmB4mub6YVZWQTh/ax4IxOpOUBt/ZXYHwAa/h3vG1uODpsUt4tnbYN3lTNh+dPA90GazCpe4=  ;
Message-ID: <20051005064339.80683.qmail@web30303.mail.mud.yahoo.com>
Date: Tue, 4 Oct 2005 23:43:39 -0700 (PDT)
From: subbie subbie <subbie_subbie@yahoo.com>
Subject: Re: 3Ware 9500S-12 RAID controller -- poor performance
To: Ian Morgan <imorgan@webcon.ca>
Cc: linux-kernel@vger.kernel.org, v@iki.fi
In-Reply-To: <Pine.LNX.4.62.0510011957010.26437@dark.webcon.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Ian,

'noapic' was a recommendation by 3Ware / AMCC tech
support.   It did not help at all, as expected. 
Unfortunately they did not have any other
recommendations.

I've now removed 'noapic' and unfortunately nothing
has changed, really.   See current stats below.

# cat /proc/interrupts 
           CPU0       CPU1       
  0:   64713875        355    IO-APIC-edge  timer
  2:          0          0          XT-PIC  cascade
  8:          3          1    IO-APIC-edge  rtc
 14:          7          6    IO-APIC-edge  ide0
 16:  176847225  191855106   IO-APIC-level  eth0
 18:     499139     336893   IO-APIC-level  libata
 48:   31491551   22761438   IO-APIC-level  3w-9xxx
NMI:          0          0 
LOC:   64049632   64155206 
ERR:          0
MIS:          0

# uptime 
 08:39:14 up 2 days, 23:54,  8 users,  load average:
0.16, 0.13, 0.07

I have also tried playing with the parameters our
friend Ville has mentioned in his post, nothing has
come out of it.

I'm willing to give any developer here access to my
production machine so that they can see the situation
first hand.   Performance is just aweful.

I'm planning to ditch RAID5 on this card and try JBOD
and in spreading files evenly across my 12 disks,
hopefully this would give some benifit.

Something is very wrong with this card / driver /
firmware and or kernel combination,  hopefully someone
can help out.

Much appreciated

--- Ian Morgan <imorgan@webcon.ca> wrote:

> Why are you booting with 'noapic'.. in my experience
> that will seriously
> impact interrupt performance. Use the APIC if you've
> got it, which in this
> case you definitely do.
> 
> Yes, having your gigabit NIC and RAID controller on
> the same IRQ (in PIC
> mode) could definitely me a source of trouble.
> 
> In your web server testing, were you using an
> external traffic generator or
> an on-host process? If you try on-host (eliminating
> the network throughput
> and related interrupts) does performance improve?
> 
> So two biggest suggestions:
> 
> - Use the APIC. It is your friend.
> 
> - It looks like the 3ware card and gigabit nic are
> on different busses, but
> the pirq lines are being routed to the same legacy
> interrupt in PIC mode. So
> APIC mode should avoid that problem. If the
> controller and nic are actually
> on the same bus, separate them.
> 
> 
> Regards,
> Ian Morgan
> 
> -- 
>
-------------------------------------------------------------------
>   Ian E. Morgan          Vice President & C.O.O.    
>   Webcon, Inc.
>   imorgan at webcon dot ca        PGP: #2DA40D07    
>  www.webcon.ca
>      *  Customized Linux network solutions for your
> business  *
>
-------------------------------------------------------------------
> 
> 
> On Thu, 29 Sep 2005, subbie subbie wrote:
> 
> > Dear list,
> >
> > After almost two weeks of experimentation, google
> > searches and reading of posts, bug reports and
> > discussions I'm still far from an answer.  I'm
> hoping
> > someone on this list could shed some light on the
> > subject.
> >
> > I'm using a 3Ware 9500S-12 card and am able to
> produce
> > up to 400MB/s sustained read from my 12-disk 4.1TB
> > RAID5 SATA array, 128MB cache onboard, ext3
> formatted.
> >  All is well when performing a single read -- it
> > works nice and fast.
> >
> > The system is a web server, serving mid-size files
> > (50MB, each, on average).  All hell breaks loose
> when
> > doing many concurrent reads, anywhere between 200
> to
> > 400 concurrent streams things simply grind to a
> halt
> > and the system transfers a maximum of 12-14MB/s.
> >
> > I'm in the process of clearing up the array (this
> > would take some time) and restructuring it to JBOD
> > mode in order to use each disk individually.  I
> will
> > use a filesystem more suitable to streaming large
> > files, such as XFS.  But this would take time and
> I
> > would very much appreciate the advice of people in
> the
> > know if this is going to help at all.    It's hard
> for
> > me to make extreme experimentation (deleting,
> > formatting, reformatting) as this is a productio n
> > system with many files that I have no other place
> to
> > dump until they can be safely removed.  Though I'm
> > working on dumping them slowly to other, remote,
> > machines.
> >
> > I'm running the latest kernel, 2.6.13.2 and the
> latest
> > 3Ware driver, taken from the 3ware.com web site
> which
> > upon insmod, updates the card's firmware to the
> latest
> > version as well.
> >
> > In my experiments, I've tried using larger
> readahead,
> > currently at 16k (this helps, higher values do not
> > seem to help much), using the deadline scheduler
> for
> > this device, booting the system with the 'noapic'
> > option and playing with a bunch of VM tunable
> > parameters which I'm not sure that I should really
> be
> > touching.  At the moment only the readahead
> > modification is used as the other stuff simply
> didn't
> > help at all.
> >
> > With the stock kernel shipped with my
> distribution,
> > 2.6.8 and its old 3ware driver things were just as
> > worse but manifested themselves differently.   
> The
> > system was visibly (top, vmstat...) spending most
> of
> > its time in io-wait and load average was extremely
> > high, in the area of 10 to 20.   With the recent
> > kernel and driver mentioned above, the excessive
> > io-wait and load seems to have been resolved and
> > observed loadavg is between 1 and 4.
> >
> > I don't have much experience with systems that are
> > supposed to stream many files concurrently off a
> > hardware RAID of this configuration, but my gut
> > feeling is that something is very wrong and I
> should
> > be seeing a much higher read throughput.
> >
> > Trying to preempt people's questions I've tried to
> > include as much information as possible, a lot of
> > stuff is pasted below.
> >
> > I've just seen that the 3ware driver shares the
> same
> > IRQ with my ethernet card, which has got me a
> little
> > worried, should I be?
> >
> > System uptime, exactly 1 day:
> >
> > # cat /proc/interrupts
> >           CPU0       CPU1
> >  0:   21619638          0          XT-PIC  timer
> >  2:          0          0          XT-PIC  cascade
> >  8:          4          0          XT-PIC  rtc
> > 10:  268753224          0          XT-PIC 
> 3w-9xxx,
> > eth0
> > 14:         11          0          XT-PIC  ide0
> > 15:     337881          0          XT-PIC  libata
> > NMI:          0          0
> > LOC:   21110402   21557685
> > ERR:          0
> > MIS:          0
> >
> > # free
> >            total       used       free     shared
> > buffers     cached
> > Mem:       2075260    2024724      50536         
> 0
> >   5184    1388408
> > -/+ buffers/cache:     631132    1444128
> > Swap:      3903784          0    3903784
> >
> > # vmstat -n 1  (output of the last few seconds):
> > procs -----------memory---------- ---swap--
> > -----io---- --system-- ----cpu----
> > 0  0      0  49932   4760 1392980    0    0 15636
> > 32 3169  3697  4  6 30 60
> > 0  0      0  50816   4752 1392376    0    0  5844
> > 0 3114  3929  3  5 91  1
> > 0  0      0  50924   4772 1391404    0    0  9360
> > 0 3187  4348  6  6 76 13
> > 0  2      0  50552   4780 1391532    0    0 24976
> > 44 4077  3906  3  7 65 25
> > 0  1      0  50444   4780 1392688    0    0 20192
> > 0 5048  3914  7  8 56 30
> > 0  1      0  50568   4756 1392508    0    0 21248
> > 0 4060  3603  4  6 48 41
> > 0  0      0  50704   4724 1392268    0    0 30004
> > 0 3834  3369  4  9 65 22
> > 0  3      0  50556   4728 1392468    0    0  3248
> > 1832 2974  4514  2  5 58 35
> > 0  3      0  50308   4724 1392200    0    0  1288
> > 336 1766  1886  1  3 50 47
> > 0  4      0  50308   4732 1391852    0    0  2300
> > 408 1919  2158  0  3 51 46
> > 0  4      0  50556   4736 1390692    0    0  1856
> > 532 1488  1846  3  1 50 46
> > 0  3      0  50680   4740 1390620    0    0  4016
> > 1296 1577  1682  2  2 50 47
> > 0  3      0  50432   4752 1391628    0    0  2180
> > 72 1730  1945  2  2 51 46
> > 2  2      0  49924   4772 1391540    0    0 44372
> > 564 3403  2847  4  5 50 42
> > 0  0      0  50684   4784 1391528    0    0 28640
> > 216 3804  3847  7  8 69 16
> 
=== message truncated ===



		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
