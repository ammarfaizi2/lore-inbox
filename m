Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278298AbRJSEVR>; Fri, 19 Oct 2001 00:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278300AbRJSEVJ>; Fri, 19 Oct 2001 00:21:09 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:24225 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S278298AbRJSEU5>; Fri, 19 Oct 2001 00:20:57 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Jeffrey W. Baker" <jwbaker@acm.org>, <linux-kernel@vger.kernel.org>
Date: Fri, 19 Oct 2001 14:21:22 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15311.43586.735550.760255@notabene.cse.unsw.edu.au>
Subject: Re: very slow RAID-1 resync
In-Reply-To: message from Neil Brown on Tuesday October 16
In-Reply-To: <15307.44327.541413.250400@notabene.cse.unsw.edu.au>
	<Pine.LNX.4.33.0110152052510.415-100000@desktop>
	<15308.7334.369332.30384@notabene.cse.unsw.edu.au>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday October 16, neilb@cse.unsw.edu.au wrote:
> On Monday October 15, jwbaker@acm.org wrote:
> > On Tue, 16 Oct 2001, Neil Brown wrote:
> > 
> > > On Monday October 15, hahn@physics.mcmaster.ca wrote:
> > > > > raid1d and raid1syncd are barely getting any CPU time on this otherwise
> > > > > idle SMP system.
> > > >
> > > > I noticed this too, on a uni, raid5 system;
> > > > the resync-throttling code doesn't seem to work well.
> > >
> > > It works great for me...
> > > What sort of drives do you have? SCSI? IDE? are you using both master
> > > and slave on an IDE controller?
> > 
> > 15,000 RPM SCSI u160 disks.
> 
> Just like mine.....
> 
> I would expect around 30Mb/sec when resyncing a single mirrored pair,
> and slightly less than that on each if you are syncing two mirrored
> pairs at once, as you would be getting close to the theoretical buss
> max (to resync two pairs at once at 30Mb/sec each you would need to
> but pushing 120Mb/sec over the buss, and I doubt that you would get
> that from u160 in practice).
> 

Just to follow up on this.  I did some testing on my test machine
which has two u160 adaptec scsi chains (one on the mother board, on 
a separate pci card) with a bunch of seagate st318451LC 18Gig 15000rpm
(Cheetah X15) drives which claim a transfer rate of 37.4 to 48.9
MB/sec.
That transfer rate is off a single track.  This might be a bit
simplist, but it takes 4ms to read a track, and 0.7 to step to the
next track, so thats a 16% drop in throughput when writing multiple
consecutive tracks, so I would expect a maximum sustained throughout
of 31.8 to 41.6 MB/sec when writing.

If I create a raid1 array with one drive on each scsi chain, I get a
rebuild rate of about 40M/sec, which is what I would expect.
If I create a second while the first is still building, the rates drop
to about 38M/sec.  I guess there is a bit more buss contention as we
are now at 50% of buss utilisation.
A third one and the speeds drop to around 31 M/sec, which is 93M/sec
on each buss.


If I create a raid5 array using 9 drives (4 on one channel, 5 on
other), and create it with one 8 working drives, one failed, and one
spare,  then reconstruction starts on the spare at about 22Mbytes/sec.

This sees 110 Mbytes/sec pass over one of the SCSI channels.

So the drives are not maxing out, and nor are the scsi busses.
I'm curious to know where the speed loss is coming from, but I think
that on the whole, the raid layer is going quite a good job of
keeping the drives busy.


Note that if I create a RAID5 array without any failed or spare
drives, then reconstruction speed is much lower.  I get 13M/sec.

This is because the "resync" process is optimised for an array that is
mostly in sync. "reconstruction" is a much more efficient way to
create a new raid5 array.

NeilBrown
