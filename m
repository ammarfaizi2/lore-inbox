Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAEILI>; Fri, 5 Jan 2001 03:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbRAEIK7>; Fri, 5 Jan 2001 03:10:59 -0500
Received: from [24.65.192.120] ([24.65.192.120]:2295 "EHLO webber.adilger.net")
	by vger.kernel.org with ESMTP id <S129183AbRAEIKx>;
	Fri, 5 Jan 2001 03:10:53 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101050810.f058AbP12432@webber.adilger.net>
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
In-Reply-To: <20010105020137.A1396@stefan.sime.com> "from Stefan Traby at Jan
 5, 2001 02:01:37 am"
To: Stefan Traby <stefan@hello-penguin.com>
Date: Fri, 5 Jan 2001 01:10:37 -0700 (MST)
CC: "Stephen C. Tweedie" <sct@redhat.com>,
        Daniel Phillips <phillips@innominate.de>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan, you write:
> [Re: read-only filesystem vs. read-only device]
> Anyway, it is "especially" critical on the root filesystem because the
> authors of filesystems can't support two ro states on boot.
> 
> Reiserfs allowed  -oro,noreplay.
> 
> Please tell me how to specify "noreplay" for the initial "/" mount :)

Actually, for ext3 Stephen added a kernel option "rootflags" so that you
can pass mount options to the root filesystem.  This was previously needed
to add a journal to an existing ext2 root filesystem.  I hope he keeps it
around anyways, and submits it as a regular kernel patch, because it is
useful for many other things.

> But this has nothing to do with forcing a write on "ro" mounts, which
> I interpret as design bug. (ro,noreplay is also a kind of design bug,
> everything except a virtual replay under physical ro conditions looks
> like a design bug to me because it breaks user expectations either
> by writing on "ro" or by giving an invalid view by "noreplay")

If the VM subsystem can tolerate keeping dirty pages around for a read-only
device then virtual replay can be made to work, for no more memory than
might be pinned by having a journal in the first place.  The only problem
is that normal journal pages will eventually be freed, whereas virtual
journal replay pages would not (until the filesystem is unmounted or mounted
read-write).  This _may_ be OK in some cases, but I think most people with
journalled filesystem have more journal space than RAM, so you will likely
get into bad situations very quickly, all for a technical nit.

Currently ext3 just refuses to load on a read-only device if the journal
is dirty.  However, changes are upcoming to allow LVM snapshots on ext3
filesystems, so there is little legitimate need for a dirty journal on
a read-only device.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
