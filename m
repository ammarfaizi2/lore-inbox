Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275068AbRJJVDk>; Wed, 10 Oct 2001 17:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275061AbRJJVDa>; Wed, 10 Oct 2001 17:03:30 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:58576 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S275021AbRJJVDR>; Wed, 10 Oct 2001 17:03:17 -0400
Subject: Re: Changes to ide-cd for 2.4.1 are broken?
Date: 10 Oct 2001 23:03:43 +0200
Organization: Chemnitz University of Technology
Message-ID: <87het7b428.fsf@kosh.ultra.csn.tu-chemnitz.de>
In-Reply-To: <001801c09e3a$4a189270$653b090a@sulaco> <m27l29tj87.fsf@boreas.yi.org.> <m28zj05j7y.fsf@boreas.yi.org.> <008401c0f20f$4458dec0$643b090a@sulaco>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
To: linux-kernel@vger.kernel.org
From: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

[ This is a very old thread; please see [1] for a complete list and [2] for
  technical details ]

johnsom@home.com ("Michael Johnson") writes:

> So, the patch you are proposing will always consider the tray open,
> even if it is closed.  Why do you need this behavior?

I need the behavior to close the tray when it is open. Currently it will
never by closed.


> Why is checking CDS_TRAY_OPEN, to see if the tray is open, broken?

CDS_TRAY_OPEN will never be returned; only CDS_NO_DISC.


> The code in cdrom.c looks fine to me.

The code there is fine. The code in ide-cd.c is broken:

|       if (sense.asc == 0x3a && (!sense.ascq||sense.ascq == 1))
|               return CDS_NO_DISC;
|       else
|               return CDS_TRAY_OPEN;

Assuming the tray is open. Then ATAPI IDE-CD drives will have an
unspecified ASCQ -- which is mostly zero (see ATAPI specification).
Therefore, it will be returned CDS_NO_DISC. This is wrong; the
correct result should be CDS_TRAY_OPEN because it is a more special
description of the state than CDS_NO_DISC and the layers above are
trusting in this value.

CDS_NO_DISC would lead to an immediate error in the open_for_data()
function in cdrom.c, but CDS_TRAY_OPEN makes it possible to close the
tray automatically.

This can be demonstrated by:

| [kernel <2.4.1; open tray]
| $ rmmod cdrom
| $ modprobe cdrom autoclose=1
| $ mount /cdrom
| ... tray will be closed and the CD mounted ...
| $
| 
| [kernel >=2.4.1; open tray]
| $ rmmod cdrom
| $ modprobe cdrom autoclose=0
| $ mount /cdrom
| mount: No medium found
| $

As you can see, the current behavior makes the 'autoclose' option
effectless on "normal" IDE-CDROMs. Only special CDROMs following the
Mt Fuji standard can profit from the ASCQ test.

I suggest the patch already given in [3] and will append it again.


> > Hi all, this is an old thread. It was started because the return
> > value from cd info was changed in 2.4.1 in the case when the tray
> > might be open or there simply be no disc in the drive for an IDE
> > CD-ROM.
> > [...]
> > > > >Right, old ATAPI has 3a/02 as the only possible condition, so
> > > > >we can't really tell between no disc and tray open. I guess the
> > > > >safest is to just keep the old behaviour for !ascq and report
> > > > >open.
> > >
> > > > I don't understand why the current(2.4.1) behavior is a problem...
> >
> > Unfortunately changing the return code means that the generic cdrom.c
> > code is broekn, in particular [...] to close when attempted to be
> > mounted.



Enrico

Footnotes: 
[1]  http://marc.theaimsgroup.com/?t=98244733600003&w=2&r=1 

[2]  http://marc.theaimsgroup.com/?l=linux-kernel&m=98252992732626&w=2

[3]  http://marc.theaimsgroup.com/?l=linux-kernel&m=98244720319144&w=2


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=patch-cdrom.diff

--- linux/drivers/ide/ide-cd.c.orig	Tue May 29 11:24:24 2001
+++ linux/drivers/ide/ide-cd.c	Tue May 29 11:25:44 2001
@@ -2319,10 +2319,7 @@
 		 * any other way to detect this...
 		 */
 		if (sense.sense_key == NOT_READY) {
-			if (sense.asc == 0x3a && (!sense.ascq||sense.ascq == 1))
-				return CDS_NO_DISC;
-			else
-				return CDS_TRAY_OPEN;
+			if (sense.asc == 0x3a) return CDS_TRAY_OPEN;
 		}
 
 		return CDS_DRIVE_NOT_READY;

--=-=-=--

