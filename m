Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262741AbREOLpT>; Tue, 15 May 2001 07:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262742AbREOLpJ>; Tue, 15 May 2001 07:45:09 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:21263 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S262741AbREOLpD>; Tue, 15 May 2001 07:45:03 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>
Date: Tue, 15 May 2001 21:44:29 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15105.5789.377277.276674@notabene.cse.unsw.edu.au>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: message from Linus Torvalds on Monday May 14
In-Reply-To: <15104.17957.253821.765483@notabene.cse.unsw.edu.au>
	<Pine.LNX.4.21.0105142332550.23955-100000@penguin.transmeta.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday May 14, torvalds@transmeta.com wrote:
> 
> On Tue, 15 May 2001, Neil Brown wrote:
> > 
> > I want to create a new block device - it is a different interface to
> > the software-raid code that allows the arrays to be partitioned using
> > normal partition tables.
> 
> See the other posts about creating a "disk" layer. Think of it as just a
> simple "lvm" thing, except on a higher level (ie not on the request level,
> but on the level _before_ we get to queuing the thing at all).
> 
> Plug the thing in at "__blk_get_queue()", and you're done.
> 

Ok, I'm begining to get the idea.
Ofcourse setting the "queue" function that __blk_get_queue call to do
a lookup of the minor and choose an appropriate queue for the "real"
device wont work as you need to munge bh->b_rdev too.
But you could define a make_request_fn instead which simply
changes b_rdev from the major/minor of the virtual disk device to the
(dynamically allocated) major/minor of the real device.

You would still nee to make sure the blk_size[], blksize_size[],
hardsect_size[], max_readahead[], max_sectors[] all got handled
properly.  Thats probably not too hard.

So this would mean that my new driver (mdp) gets a dynamically
allocated major number which is probably never seen from user-space
(though I could look in /proc/devices if I wanted to), and it is
accessed through /dev/diskAN for some value of A and different
partitions N.

So far I'm with you (I think).

Does the minor number for this "disk" layer have N bits for partition
number and 8-N bits (later to be 20-N bits or similar) for device
number?   If so we are limited to a smallish number of discs for now.
If not (and partitions are packed densely) then changing the
partitioning of a drive could be awkward.

Finally, how do I say that I want the root filesystem to be on a
particular "mdp" device+partition.  I cannot assume that my device
will be the first to register with the "disk" layer, so I cannot be
sure that "root=/dev/diska1" will work.
Maybe a boot line option like:
    diska=mdp,0
could be used.  Each device that registers with "disk" defines a
__setup handler for "disk" which checks if it should register as a
particular "disk".
So if "mdp" finds that there is an mdp device 0, and wants to register
it with "disk" then:
  if "diskX=mdp,0" is a boot option for some X, register it with "disk"
    as device "X-'a'"
  else register it with "disk" as "largest-available-device".

Does that make sense?   It feels a bit ugly though


The brick wall the I feel that I am hitting is that there needs to
be a name space to communicate device identities between kernelspace
and userspace.  You are saying that major numbers are no longer to be
that namespace (at least, not for new drivers) so we have to come up
with a new namespace, which will obviously involve textual names.
There seem to be three options:

 1/ devfs - but not everybody likes that (and there are certainly
     aspects that I am uncomfortable with)
 2/ ugly hacks like the above and like name_to_kdev_t
 3/ "something else" which either hasn't been proposed or hasn't been
     agreed on. (I have my own ideasbut insufficient time).

I guess your goal in establishing the moratorium on new majors is to
force people to break down this brick wall, either by accepting devfs,
pushing through ugly hacks, or finding that "something else".

I'll keep looking for a sledgehammer:-)

NeilBrown
