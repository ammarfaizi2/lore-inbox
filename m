Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315307AbSDWTFb>; Tue, 23 Apr 2002 15:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315311AbSDWTFa>; Tue, 23 Apr 2002 15:05:30 -0400
Received: from ip68-7-112-74.sd.sd.cox.net ([68.7.112.74]:4100 "EHLO
	clpanic.kennet.coplanar.net") by vger.kernel.org with ESMTP
	id <S315307AbSDWTF3>; Tue, 23 Apr 2002 15:05:29 -0400
Message-ID: <007f01c1eaf9$a63aeb40$7e0aa8c0@bridge>
From: "Jeremy Jackson" <jerj@coplanar.net>
To: "Alexander Viro" <viro@math.psu.edu>,
        "Alvaro Figueroa" <fede2@fuerzag.ulatina.ac.cr>
Cc: "LKML" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0204231041010.8087-100000@weyl.math.psu.edu>
Subject: Re: Adding snapshot capability to Linux
Date: Tue, 23 Apr 2002 12:04:00 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This type of snapshot is very desirable.  It can be done by remounting
the fs ro, then taking EVMS or LVM snapshot, but you can't do that with open
files.

For file level COW (not block level),
 I wonder if DMAPI available with SGI's XFS (IRIX & Linux)
provides the VFS like hooks that could be used to build such a system.

Perhaps it could be implemented on other FS or generically in VFS.  The nice
thing is it's a standard and already has a working implementation (XFS)

from dmapi man page (oss.sgi.com XFS project):

DESCRIPTION
dmi is a system interface used to implement the interface defined in the
X/Open document: Systems Management: Data Storage Management (XDSM) API
dated February 1997. This interface is made available on Silicon Graphics
systems by means of the libdm library.

That spec is available from opengroup.org to view online for free.

For a journaling fs cooperation with snapshot while rw,
the fs must accept a snapshot request,
pause in flight IO, sync all pending buffers, flush it's log, mark fs clean
(almost like umount)
continue the block dev snapshot, mark fs in use, resume io.

Not so bad for journaling fs?  Non journaling would be easier, I think.

How about having all FS export methods for this, and VFS export to
userspace.
The holy grail is to generically support consistent online snapshot backup,
no?

Jeremy

----- Original Message -----
From: "Alexander Viro" <viro@math.psu.edu>
To: "Alvaro Figueroa" <fede2@fuerzag.ulatina.ac.cr>
Cc: "LKML" <linux-kernel@vger.kernel.org>
Sent: Tuesday, April 23, 2002 7:45 AM
Subject: Re: Adding snapshot capability to Linux


>
>
> On 23 Apr 2002, Alvaro Figueroa wrote:
>
> > > Instead of changing VFS you can probably make a generic stackable FS
module
> > > .....that can stack on top of the physical filesystems  and happily
take
> > > snapshots at "FS" level :) ! and you can use the FIST to create a
basic
> > > stackable FS and then modify it to take care of snapshoting !
> >
> > Since this solution doens't solve Lisbor's request of using it on smb
> > filesystems, well, you could as well save up all of the programmer
> > cycles and use EVMS.
> >
> > It has a pluggin for treating normal partitions as EVMS objets, so you
> > don't need to translate them or so; and with EVMS you can even use RW
> > snapshots.
>
> You _can't_ get consistent snapshots without cooperation from fs.  LVM,
> EVMS, whatever.  Only filesystem knows what IO needs to be pushed to
> make what we have on device consistent and what IO needs to be held
> back.  Neither VFS nor device driver do not and can not have such
> knowledge - it depends both on fs layout and on implementation details.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

