Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265368AbSLBVb2>; Mon, 2 Dec 2002 16:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265380AbSLBVb2>; Mon, 2 Dec 2002 16:31:28 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:60377 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S265368AbSLBVbW>; Mon, 2 Dec 2002 16:31:22 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Date: Tue, 3 Dec 2002 08:38:25 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15851.53969.794768.513642@notabene.cse.unsw.edu.au>
Cc: Joel Becker <Joel.Becker@oracle.com>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: RFC - new raid superblock layout for md driver
In-Reply-To: message from Joe Thornber on Friday November 22
References: <15835.2798.613940.614361@notabene.cse.unsw.edu.au>
	<20021120160259.GW806@nic1-pc.us.oracle.com>
	<20021122101301.GB1508@reti>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday November 22, joe@fib011235813.fsnet.co.uk wrote:
> On Wed, Nov 20, 2002 at 08:03:00AM -0800, Joel Becker wrote:
> > 	Hmm, what is the intended future interaction of DM and MD?  Two
> > ways at the same problem?  Just curious.
> 
> 
> There are a couple of good arguments for moving the _mapping_ code
> from md into dm targets:
> 
> 1) Building a mirror is essentially just copying large amounts of data
>    around, exactly what is needed to implement move functionality for
>    arbitrarily remapping volumes.  (see
>    http://people.sistina.com/~thornber/pvmove_outline.txt).

Building a mirror may be just moving data around. But the interesting
issues in raid1 are more about maintaining a mirror:  read balancing,
retry on error, hot spares, etc.

> 
>    So I've always had every intention of implementing a mirror target
>    for dm.
> 
> 2) Extending raid 5 volumes becomes very simple if they are dm targets
>    since you just add another segment, this new segment could even
>    have different numbers of stripes.  eg,
> 
> 
>        old volume                             new volume
>    +--------------------+      +--------------------+--------------------+
>    | raid5 across 3 LVs |   => | raid5 across 3 LVs | raid5 across 5 LVs |
>    +--------------------+      +--------------------+--------------------+
> 
>    Of course this could be done ATM by stacking 'bottom LVs' -> mds ->
>    'top LV', but that does create more intermediate devices and
>    sacrifices space to the md metadata (eg, LVM has its own metadata
>    and doesn't need md to duplicate it).

But is this something that you would *want* to do???

To my mind, the raid1/raid5 almost always lives below any LVM or
partitioning scheme.  You use raid1/raid5 to combine drives (real,
physical drives) into virtual drives that are more reliable, and then
you partition them or whatever you want to do.  raid1 and raid5 on top
of LVM bits just doesn't make sense to me.

I say 'almost' above because there is one situation where something
else makes sense.  That is when you have a small number of drives in a
machine (3 to 5) and you really want RAID5 for all of these, but
booting only really works for RAID1.  So you partition the drives, use
RAID1 for the first partitions, and RAID5 for the rest.
put boot (or maybe root) on the RAID1 bit and all your interesting data
on the RAID5 bit.

[[ I just had this really sick idea of creating a raid level that did
data duplication (aka mirroring) for the first N stripes, and
stripe/parity (aka raid5) for the remaining stripes.  Then you just
combine your set of drives together with this level, and depending on
your choice of N, you get all raid1, all raid5, or a mixture which
allows booting off the early sectors....]]

> 
> MD would continue to exist as a seperate driver, it needs to read and
> write the md metadata at the beginning of the physical volumes, and
> implement all the nice recovery/hot spare features.  ie. dm does the
> mapping, md implements the policies by driving dm appropriately.  If
> other volume managers such as EVMS or LVM want to implement features
> not provided by md, they are free to drive dm directly.
> 
> I don't think it's a huge amount of work to refactor the md code, and
> now might be the right time if Neil is already changing things.  I
> would be more than happy to work on this if Neil agrees.

I would probably need a more concrete proposal before I had something
to agree with :-)

I really think the raid1/raid5 parts of MD are distinctly different
from DM, and they should remain separate.  However I am quite happy to
improve the interfaces so that seamless connections can be presented
by user-space tools.

For example,  md currently gets its 'super-block' information by
reading the device directly.  Soon it will have two separate routines
that get the super-block info, one for each super-block format.  I
would be quite happy for there to be a way for DM to give a device to
MD along with some routine that provided super-block info by getting
it out of some near-by LVM superblock rather than out of the device
itself.

Similarly, if an API could be designed for MD to provide higher levels
with access to the spare parts of it's superblock, e.g. for partition
table information, then that might make sense.

To summarise:  If you want tigher integration between MD and DM, do it
by defining useful interfaces, not by trying to tie them both together
into one big lump.

NeilBrown
