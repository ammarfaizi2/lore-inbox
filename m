Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131276AbRDOU4y>; Sun, 15 Apr 2001 16:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132326AbRDOU4p>; Sun, 15 Apr 2001 16:56:45 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:38621 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S131276AbRDOU4h>; Sun, 15 Apr 2001 16:56:37 -0400
Date: Sun, 15 Apr 2001 21:56:34 +0100 (BST)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <Linus.Torvalds@Helsinki.FI>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NTFS comment expanded, small fix.
In-Reply-To: <200104151816.UAA22871@cave.bitwizard.nl>
Message-ID: <Pine.SOL.3.96.1010415213647.21885I-100000@libra.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Apr 2001, Rogier Wolff wrote:
> Anton Altaparmakov wrote:
> > >Also, the "start" value that is read from the record, could be much 
> > larger than expected, which could lead to accessing random data. The
> > fixup should fail then, and this is also patched below.
> > 
> > No it can't (in theory). The volume would be corrupt if it was. That kind
> > of check belongs in ntfs fsck utility but not in kernel code.
> > 
> > In any case, the correct check, if you want one, would be:
> > 
> > if (start + (count * 2) > size)
> > 	return 0;
> 
> Of course this is the better check. I was being sloppy. 
> 
> I disagree with your "this belongs in an fsck-program". If this
> condition triggers, then indeed, the filesystem is corrupt. But if the
> "start" pointer is dereferenced, the kernel could be accessing an area
> that you don't want touched (e.g. if the buffer happens to be near 
> enough to the "end-of-memory", you could "Ooops" .
> 
> The kernel should validate all user-input as much as possible, and an
> ntfs-formatted-floppy should count as such.

Ok. I see your point. But you have to admitt that if it is possible for a
malicious person to gain physicall access to the machine your security is
already zero whatever you do. And I wouldn't expect any sane admin to want
to trash their mashine.

[According to MS of course, NTFS cannot be put on floppies but let's not
get into this discussion.]

> The "fixup" routine has a bunch of "return 0" conditions. These are
> similar to mine: If they trigger, the filesystem must be corrupt.
> It's a sanity check, which is neccesary to keep Linux stable.

Yes, but if you wanted to check for one and every single possibility of
how a filesystem could be trying to kill your fs driver then you driver
will end up with 90% of code being checks in the driver and this
resulting in the driver being slow as hell. If you can't trust your
fs, what can you trust? - That's what the dirty flag is for. If dirty on
mount run fsck to fix corruptions, after that assume that fs is not
corrupt...

But, point taken. I guess we want to safe guard all places where
corruption would result in dereferencing memory outside the buffer (here
ntfs record). It should be safe to ignore all other corruption, from 
this aspect of security.

I will be sending out all my fixes which are in -ac kernels to
Linus soon, myself, and I will include a patch to do a full bounds check
at this point.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

