Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130671AbQKVV7c>; Wed, 22 Nov 2000 16:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131566AbQKVV7W>; Wed, 22 Nov 2000 16:59:22 -0500
Received: from roc-24-93-10-55.rochester.rr.com ([24.93.10.55]:64508 "EHLO
        suzaku.fynet.org") by vger.kernel.org with ESMTP id <S130671AbQKVV7U>;
        Wed, 22 Nov 2000 16:59:20 -0500
Message-ID: <3A1C3A57.9768247B@fsc-usa.com>
Date: Wed, 22 Nov 2000 16:27:51 -0500
From: Brian Kress <kressb@fsc-usa.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Mauelshagen@Sistina.com
Subject: RFC: Modularize /proc/partitons (was Re: /proc/partitions for LVM)
In-Reply-To: <3A1C3523.A111CDD9@fsc-usa.com> <20001122221152.B4406@srv.t-online.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Heinz J. Mauelshagen" wrote:
> 
> On Wed, Nov 22, 2000 at 04:05:39PM -0500, Brian Kress wrote:
> >       Question about /proc/partitions and LVM.  LVM devices in
> > /proc/partitions currently show up as lvma, lvmb, etc, depending on
> > their device number.  This breaks things like mount by filesystem
> > name.  Back when LVM existed as a patch, I believe there was some
> > support in fs/partitions/check.c for showing the proper name for
> > the device (something like <vgname>/<lvname>).
> 
> Yes.
> It actually was <vgname>/<lvname>.
> 
> Linus didn't accept it though.
> 
> The code is still available in case he changes his mind.

	Yes, I can see that now looking through lvm.c.  (LVM_HD_NAME)
I'm guessing why he didn't take it is the minor hack of adding a
function pointer to genhd.c as a special case just for LVM.  
	A general solution to this problem would be nice.  The
big switch statement in disk_name in fs/paritions/check.c is kind
of ugly as it has generic code have to know things about specific
drivers.  
	How's this for an idea to generalize this.  Put a function
pointer in the gendisk structure for a specific function to call
for disk_name for disks for that gendisk.  That way, LVM gets its
<vgname>/<lvname>, IDE gets its two disks per major (special cased
right now), all the other special cases get what they need and future
drivers can call their devices whatever they like without touching
this file.  Makes the whole thing more modular.  Make a NULL for 
this function default to the old <name>a, <name>b, etc.
	What to people think about this?  If this sounds reasonable
I can come up with a patch.


Brian Kress
kressb@fsc-usa.com








> 
> >       Are their any plans for something like this to be added
> > or is their a reason it was taken out?
> >
> >
> >       BTW, 2.4.0-test11 is the first "perfect" kernel for me.  It
> > finally has everything I use working correctly.  (well, with a
> > small raid5 patch, anyway).
> >
> >
> > Brian Kress
> > kressb@fsc-usa.com
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
> 
> --
> 
> Regards,
> Heinz      -- The LVM guy --
> 
> =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
> 
> Heinz Mauelshagen                                 Sistina Software Inc.
> Senior Consultant/Developer                       Bartningstr. 12
>                                                   64289 Darmstadt
>                                                   Germany
> Mauelshagen@Sistina.com                           +49 6151 7103 86
>                                                        FAX 7103 96
> =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
