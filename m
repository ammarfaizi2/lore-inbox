Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281748AbRKSDrp>; Sun, 18 Nov 2001 22:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281751AbRKSDr1>; Sun, 18 Nov 2001 22:47:27 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:17367 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S281748AbRKSDrK>; Sun, 18 Nov 2001 22:47:10 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 19 Nov 2001 14:47:21 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15352.32969.717938.153375@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Devlinks.  Code.  (Dcache abuse?)
In-Reply-To: message from Alan Cox on Friday November 16
In-Reply-To: <15348.58752.207182.488419@notabene.cse.unsw.edu.au>
	<E164gCQ-0003YZ-00@the-village.bc.nu>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday November 16, alan@lxorguk.ukuu.org.uk wrote:
> >    A device special file is a gateway between a user (admin)
> >    controlled name space (the filesystem) and a kernel imposed name
> >    space (major/minor numbers) that recognises and imposes access
> >    control (owner/group/permissions).
> > 
> > The (a) problem with this is that major/minor numbers are too limited,
> 
> Textual names have unsolved problems too
> 	1.	Who administers the namespace

lanana??

> 	2.	When trademarks get entangled whats the disputes procedure
> 
> Do you want to create a situation where a future kernel is likely to be
> forced to change a device naming because an "official" vendor driver appears
> too and they demand the namespace and wave trademarks around ?
> 

I admit I hadn't thought about this sort of issue at all.  trademarks
are certainly something we want to avoid.
So I thought about it for a couple of days, and:

Looking through the names provided by "devfs", I don't see any place
for a trade-mark-like name to go.  It is mostly generic names, like
"disc", "cdrom", "scsi", "tty", "host", and numbers.

As I understand trademarks, they are granted for a particular context.
There is no conflict between "Dove" as a brand name for soap, "Dove"
as a brand name for chocolate, and "Dove" as used by bird watchers in
their taxonomy.

Similarly, device names that Linux uses are, and should be,  generic
words and exist in a name-space that is not really trademark-able.

Interestingly, I have a driver for a battery-backed memory card made
by "Micro Memory" (or "umem").  The driver presents the card as a
normal block device and you would use it just like a disc driver (only
with lower latency).  So I would like to identify it as a "disc
drive".
But Linux has no generic "disc" type, so I really need to allocate a
new major number and give it a name (for /proc/devices) which will
inevitably be "umem" or similar.  Thus the current scheme seems to
encourage using trademarks more than a properly structured scheme 
would.

However my thoughts about names didn't stop there, so nor will this
email :-)
While the naming in "devfs" has a lot of good points, it does not have
a clear, over-arching, strucure, so it is not clear how/where best to
add things.  This points to another problem with textual name spaces
that you did not mention: They are just *too* flexable.
They give you enough rope to shoot yourself in the foot, and all
that.  Just look at procfs.

So I think that it is very important that a simple and elegant naming
scheme is used that, to use the venacular:
  (a) is _right_ and
  (b) is right.

What seems right to me is to have a three level hierarchy with clear
meanings for the three levels so that in every case, the choice of
name will be obvious, and where trade marks and such will just never
be considered as candidates.
The three levels (which correspond loosely to major/minor/char-or-block)
are "address-space", "address", and "interface".
The "address space" would be something like
 "scsi", "pci", "disc", "tty", "usb", "printer", "devid", "md"

Each of them are very generic terms.
The "address" is something that is specific to the address space.
It will sometimes be a "physical" address, sometimes a sequential
number, sometimes a content-based address, and often a combination of
2 of those.  It will very often be numeric. It may have an internal
hierarchical structure. 
So in the "scsi" address space, addresses would be 4 numbers
representing host, bus, device, unit.  "host" would be a sequential
number, the others have some external significance.
In the "pci" address space, you would have bus/device/function.
The "disc" address space would be simple sequentially assigned
numbers.

"devid" addresses are device id's such as pci ids, or usb ids, or
pcmcia device ids (does that work, are they all one big address
space??) followed by an instance number: 1, 2, 3 etc.

The "interface" part indicates what sort of object can be found at
that address in that address space.

For example pci bus 1, device 4, function 1 might be a SCSI
controller, the 3rd scsi controler in the system,
so
   pci/1/4/1/scsi
is a devlink pointing at scsi/3
This host has one buss(channel) with several devices(ids). Device 3 is a
disc drive, the 12th disc drive in the system, so
   scsi/3/0/3/0/disc
is a devlink to disk/12, and
   scsi/3/0/3/0/generic
is a char-special device which provides generic access to the device.

This disc has 4 partitions, so
   disc/12/0    is a block device for the whole disc
   disc/12/1    is a block device for the first partition
   disc/12/2    is a block device for the second partition
etc.

   devid/9005/00CF/1

is an alias rather than a real device, and so would not be 
a directory containing interfaces but a devlink to pci/1/4/1.

You might note that the names of address spaces are often also the
names of interfaces.  "scsi" and "disc" fill both roles in the above
example.
So a full name to a target might have the form:
  interface/address/interface/address/interface/address
e.g.
   pci/1/4/1/scsi/0/3/0/disc/1

I am undecided if this should be broken with devlinks as in the above
example, or if there should be a primary name with no "sequence
number" addresses, and everything else is devlink aliases.
i.e.
  scsi/3 -> pci/1/4/1/scsi
  disc/12 -> scsi/0/3/0/disc

This is more like what devfs does.

In a fairly real sense, it doesn't make any difference, but I'm not
sure yet.

In many ways this is similar to the naming that devfs uses.
Some differences are:
 - devfs put lots of redundant words in the address part:
    "host" "bus" "cdrom" etc.  
   I gather these are Linus-mandated.  But I find them *very*
   noisy.
 - devfs puts a lot of miscellaneous stuff in the top level.
   I would want to group them into one namespace. e.g.:
       misc/memory/mem
       misc/memory/kmem
       misc/memory/zero
       misc/memory/null
       misc/random/random
       misc/random/urandom
 - Some parts of devfs use a slightly different structure. For
   example, "pty" contains both master and slave devices, with the "m"
   or "s" preceeding the number.  The above scheme would instead give
   an address space of "pty", addresses of seqential numbers, and
   interfaces of "master" and "slave", so
    pty/1/master       instead of   pty/m1
    pty/2/slave        instead of   pty/s2


What I would really like to see is a very light weight naming scheme
used internally by the kernel, and devlinks and devfs should just be
different ways to expose that scheme to userspace.... I wonder how
much code that would take....

NeilBrown

