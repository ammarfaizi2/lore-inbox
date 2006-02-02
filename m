Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423016AbWBBGbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423016AbWBBGbi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 01:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423018AbWBBGbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 01:31:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:47572 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1423016AbWBBGbh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 01:31:37 -0500
From: Neil Brown <neilb@suse.de>
To: Greg KH <greg@kroah.com>
Date: Thu, 2 Feb 2006 17:31:25 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17377.42813.479466.690408@cse.unsw.edu.au>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Aritz Bastida <aritzbastida@gmail.com>,
       Antonio Vargas <windenntw@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Right way to configure a driver? (sysfs, ioctl, proc, configfs,....)
In-Reply-To: message from Greg KH on Wednesday February 1
References: <7d40d7190601261206wdb22ccck@mail.gmail.com>
	<20060127050109.GA23063@kroah.com>
	<7d40d7190601270230u850604av@mail.gmail.com>
	<69304d110601270834q5fa8a078m63a7168aa7e288d1@mail.gmail.com>
	<7d40d7190601300323t1aca119ci@mail.gmail.com>
	<20060130213908.GA26463@kroah.com>
	<Pine.LNX.4.61.0602011553410.22529@yvahk01.tjqt.qr>
	<20060201151145.GA3744@kroah.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday February 1, greg@kroah.com wrote:
> On Wed, Feb 01, 2006 at 03:54:22PM +0100, Jan Engelhardt wrote:
> > >> 
> > >> I guess I could pass three values on the same file, like this:
> > >> $ echo "5  1000  500" > meminfo
> > >> 
> > >> I know that breaks the sysfs golden-rule, but how can I pass those
> > >> values _atomically_ then? Having three different files wouldn't be
> > >> atomic...
> > >
> > >That's what configfs was created for.  I suggest using that for things
> > >like this, as sysfs is not intended for it.
> > >
> > Can't we just somewhat merge all the duplicated functionality between procfs,
> > sysfs and configfs...
> 
> What "duplicated functionality"?  They all do different, unique
> things.

So why do you recommend configfs for something that is *almost* what
sysfs does well.

sysfs both exports information, and allows changes to some (not all)
of that information.
But as soon as someone wants an atomic change, which is conceptually a
very small difference, you say "use configfs" which is conceptually a
very big difference in interface.

Configfs - as I read the doco - is not really about providing generic
atomic configuration changes.

Configfs is for *Creating* kernel objects.
The basic sequence is:
  mkdir /config/subsystem/objectname
     # where you choose 'objectname' to be whatever you want.
  echo value > /config/subsystem/objectname/param1
  echo value > /config/subsystem/objectname/param2
  echo value > /config/subsystem/objectname/param3
  echo value > /config/subsystem/objectname/param4

and then the object is ready to go.
Notice that there is *NO* 'commit' step.  There is nothing here that
makes anything atomic.

So saying 'use configfs for atomic updates' doesn't seem rational...

To be fair, configfs is meant to have 'committable items', but they are
'currently unimplemented'.
If you have a 'committable' item, then the sequence instead would go
something like:

   mkdir /config/subsystem/pending/objectname
   echo value > /config/subsystem/pending/objectname/param1
   ...
   mv /config/subsystem/pending/objectname /config/subsystem/live

This does provide atomic updates but, apart from not being
implemented, it only allows atomic updates at object creation time.

If I have a live object, and I want to change some attributes
atomically, configfs DOES NOT LET ME DO THAT.

Conversely, it is quite easy to do this with sysfs.
As you have control over the 'read' and 'write' routines for each
attribute, you simply:
  - in your object, store the real attribute and a 'pending' copy.
  - define a special attribute, maybe called 'commit' such that:
     writing 'clear'  copies the real attributes in to the pending
        copy as well
     writing 'commit' copies the 'pending' copies into the real
        attributes atomically
  - when you write to an attribute, it updates the 'pending' copy.

So to do a atomic update, you:

 1/ get a flock lock on the directory (do sysfs directories support
    flock?)
 2/ write 'clear' to 'commit
 3/ make your changes
 4/ write 'commit' to 'commit
 5/ unflock.

Obvious the 'flock' could be replaced by lockfiles in /tmp or whatever
you want.

This doesn't mean that we don't need configfs (though I'm not yet
convinced).  The point of configfs seems to be *Creating* objects.
Maybe it is a good thing to use for this purpose (though if those
objects end up appearing in sysfs, it would seem like unnecessary
duplication). 
 
> 
> Patches are always welcome...
> 

True, patches are good.
But they don't stop people from recommending the wrong tool for the
job :-)
And they aren't needed to support atomic updates in sysfs.

Maybe what would be good is support for 'mkdir' in sysfs.
I would really like to be able to use 'mkdir' to create md devices,
but '/sys/block' is too flat.  If it had
  /sys/block/sd/scsi-block-devices
  /sys/block/hd/ide-block-devices
  /sys/block/loop/loop-block-devices
it would also have
  /sys/block/md/md-block-devices
and it would make sense to do a 
  mkdir /sys/block/md/0
or whatever to create a new md device.  But I don't think it makes
sense to 
  mkdir /sys/block/md0
because someone would have to parse the device name ('md0') to decide
which module to hand it off to.... oh well :-(

NeilBrown

