Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129437AbQLBNLu>; Sat, 2 Dec 2000 08:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129561AbQLBNLa>; Sat, 2 Dec 2000 08:11:30 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:5637 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129437AbQLBNLV>; Sat, 2 Dec 2000 08:11:21 -0500
Date: 02 Dec 2000 11:14:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <7r4kOV1Xw-B@khms.westfalen.de>
In-Reply-To: <Pine.GSO.4.21.0012020034220.27040-100000@weyl.math.psu.edu>
Subject: Re: ext2 directory size bug (?)
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <20001202183021.D412@metastasis.f00f.org> <Pine.GSO.4.21.0012020034220.27040-100000@weyl.math.psu.edu>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@math.psu.edu (Alexander Viro)  wrote on 02.12.00 in <Pine.GSO.4.21.0012020034220.27040-100000@weyl.math.psu.edu>:

> On Sat, 2 Dec 2000, Chris Wedgwood wrote:
>
> > On Sat, Dec 02, 2000 at 12:14:34AM -0500, Alexander Viro wrote:
> >
> >     Not really. Anything that modifies directories holds both ->i_sem and
> >     ->i_zombie, lookups hold ->i_sem and emptiness checks (i.e. victim in
> >     rmdir and overwriting rename) hold ->i_zombie, readdir holds both.
> >
> > what performance issues does this raise in the cast of a directory
> > with _many_ files in it -- when we are renaming often involving that
> > directory?
> >
> > I ask this because certain MTAs do just that; and when you have
> > 10,000 to 100,000 messages queued I immagine you might spend much of
> > your time waiting for ->i_sem locks?
>
> And where do you get contending processes? 'Cause it takes at least two
> to get that...

More than one queue worker running, for example. On systems with that much  
mail, that's just about essential to have.

But I suspect scanning the directory is much worse than renaming. Scanning  
long ext2 (or traditional Unix, for that matter) directories gets *really*  
ugly. That's why Exim, for example, has the "split spool directory" code  
(works very similar to the traditional terminfo split).

> When you have that size of message queues your best bet is to split them
> into many directories, though - all FFS derivatives do linear searches, so
> locking or not, you are going to lose.

Exactly.

> > ext2 directories seem somewhat susepctable to corruption on badly
> > timed shutdowns anyhow; and I don't think there is any way to do
> > atomic writes to them with most disk hardware is there?

I don't think I've seen that. Possibly if you're doing massive directory  
creation just at that moment (unpacking a kernel source tarball, say), but  
in that case I'd call it expected on a non-journalling fs.

If anything, I've seen chopped-up regular files (usually stuff like spool  
files the MTA was just messing around with).

MfG Kai
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
