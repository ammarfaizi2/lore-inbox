Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbVLHUQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbVLHUQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 15:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbVLHUQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 15:16:28 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:65284 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932337AbVLHUQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 15:16:27 -0500
Date: Thu, 8 Dec 2005 21:16:23 +0100
From: Willy TARREAU <willy@w.ods.org>
To: Jan =?iso-8859-1?Q?Oberl=E4nder?= <mindriot@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.32 Oops in scsi_dispatch_cmd
Message-ID: <20051208201623.GA5029@pcw.home.local>
References: <20051207093747.GA1154@hek501.hek.uni-karlsruhe.de> <20051207215014.GB15993@alpha.home.local> <20051207225244.GA11955@hek501.hek.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051207225244.GA11955@hek501.hek.uni-karlsruhe.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 07, 2005 at 11:52:44PM +0100, Jan Oberländer wrote:
> On Wed, Dec 07, 2005 at 10:50:14PM +0100, Willy Tarreau wrote:
> > On Wed, Dec 07, 2005 at 10:37:47AM +0100, Jan Oberländer wrote:
> > > I've been receiving Oops repeatedly
> > 
> > could you send your .config and gcc version please ? I've checked the
> > code and it's not easy to find what data is accessed in your oopses.
> 
> I attached the .config.
> 
> $ gcc -v
> Reading specs from /usr/lib/gcc-lib/i486-linux/3.3.5/specs
> Configured with: ../src/configure -v
> --enable-languages=c,c++,java,f77,pascal,objc,ada,treelang --prefix=/usr
> --mandir=/usr/share/man --infodir=/usr/share/info
> --with-gxx-include-dir=/usr/include/c++/3.3 --enable-shared
> --enable-__cxa_atexit --with-system-zlib --enable-nls
> --without-included-gettext --enable-clocale=gnu --enable-debug
> --enable-java-gc=boehm --enable-java-awt=xlib --enable-objc-gc
> i486-linux
> Thread model: posix
> gcc version 3.3.5 (Debian 1:3.3.5-13)

OK, thanks, I could reproduce the same code.


> > > The tar process is run from a backup scripts that mounts an IDE
> > > drive partition, writes a backup to it and unmounts it.  It's always
> > > been the tar process behind this crash.  Some system details:
> > 
> > could you please also tell us what partition tar reads data from ?
> > I've understood that you have some disks on your adaptec card and some
> > software RAID, so if you could roughly explain the setup, it would be
> > great.
> 
> The setup:
> 
> /dev/hda on onboard IDE
> /dev/sd{a,b,c,d,e,f} on Adaptec
> md0 : active raid5 sdd1[2] sdc1[1] sdb1[0]
> md1 : active raid5 sdd2[2] sdc2[1] sdb2[0]
> md3 : active raid5 sdd3[2] sdc3[1] sdb3[0]
> md2 : active raid1 sdf1[1] sde1[0]
> 
> The backup script roughly does the following:
> 1. mount hda
> 2. backup data from the md*,sd* devices to hda
> 3. umount hda
> 
> As I said, the IDE drive was on an ATA RAID card at first, visible to
> the system as /dev/sdg.  I changed this because of the tainted ATA RAID
> module, but I'm receiving the same oops either way.
> 
> > It may be doable with a few more info. Please also confirm that your
> > System.map really matches your kernel (for the oops report).
> 
> I double-checked.

Fine.

> Tell me if you need any further information.

I must say I'm a bit lost, I found this in drivers/scsi.c :

672             if (host->hostt->use_new_eh_code) {
673                     scsi_add_timer(SCpnt, SCpnt->timeout_per_command, scsi_times_out);
674             } else {
675                     scsi_add_timer(SCpnt, SCpnt->timeout_per_command,
676                                    scsi_old_times_out);
677             }


The oops you're reporting shows that eax==0 below :

   mov    0x24(%edi),%eax
   testb  $0x4,0x67(%eax)

But at this point, eax=(struct Scsi_Host_Template *)host->hostt,
so host->hostt == NULL. The problem is that it is assigned only
once in drivers/scsi/host.c:scsi_register(), and it directly takes
the Scsi_Host_Template *tpnt passed as the first argument, which
is dereferenced many times before being assigned to host->hostt,
so it should have crashed far earlier and never reached this code.

So unless I'm missing something, I see two possibilities :
  - a bug somewhere else corrupted the struct Scsi_Host and
    put a NULL in hostt ;

  - a hardware problem is having fun of you. I'd personnaly
    check in this area first.

So I suggest that you run memtest on the whole system over night
if possible (at least several hours) to check memory. If you
cannot stop the system this long, then you might also exchange
all SIMMs with another system and check whether the problem
still happens.

What is possible too is a chipset problem or CPU overheating
during those intensive backup activity.

Good luck,
Willy

PS: please keep the whole CC list on LKML, as people generally
don't read the list all the day.

