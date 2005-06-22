Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262533AbVFVV5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262533AbVFVV5A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 17:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262541AbVFVVy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 17:54:58 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:5128 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S262533AbVFVVvK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 17:51:10 -0400
Message-ID: <42B9DD48.6060601@slaphack.com>
Date: Wed, 22 Jun 2005 16:51:04 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: "Artem B. Bityuckiy" <dedekind@yandex.ru>,
       =?UTF-8?B?TWFya3VzIFTQlnJu?= =?UTF-8?B?cXZpc3Q=?= <mjt@nysv.org>,
       Christophe Saout <christophe@saout.de>, Andrew Morton <akpm@osdl.org>,
       Hans Reiser <reiser@namesys.com>, hch@infradead.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: reiser4 plugins
References: <200506221733.j5MHXEoH007541@laptop11.inf.utfsm.cl>
In-Reply-To: <200506221733.j5MHXEoH007541@laptop11.inf.utfsm.cl>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Horst von Brand wrote:
> Artem B. Bityuckiy <dedekind@yandex.ru> wrote:
> 
>>Markus TÐ–rnqvist wrote:
[...]
>>>                     and move the stuff to the VFS as needed or
>>>deemed necessary. And enable the pseudo interface, or at least
>>>set it in menuconfig and enable by default, it needs testing too.
> 
> 
> Then test it out of the standard tree...

Standard tree is actually a good place to test things.  That's why there
are so many things there that say "EXPERIMENTAL", and so many of those
don't work.  Some even refuse to compile.

>>atomic operations,
> 
> 
> What is atomic that isn't in the standard filesystems? How do you guarantee

We've been discussing this for quite awhile.  In standard filesystems,
the only things that are atomic are metadata.  If I rename a file and
crash, I'm guarenteed to either have renamed the file or not, and not be
caught halfway.

This does not apply to files.  In fact, the only way to perform an
atomic write on a file, using the filesystem's atomicity, is to write a
new file, nuke the old one, and rename the new one on top of the old one.

What we want is to have programs that can write small changes to one
file or to many files, lump all those changes into a transaction, and
have the transaction either succeed or fail.

> it doesn't stop the system dead in its tracks waiting for some very long
> transaction to finish?

We've also discussed this.  For one thing, if we can have transactions
in databases which don't stop the database dead in its tracks, why can't
we do it with filesystems?

But anyway, if you really want to know, ask someone else or read the
archives.  I wasn't really paying attention except to remember that this
issue was resolved.

>>                   different kinds of stat data,
> 
> 
> Usefulness? Sounds like kernel bloat leading to userspace bloat and
> applications/users wondering what the heck goes on when they don't grok the
> particular stat format.

So you allow multiple stat formats.  Bloat is not as big an issue here
as the bloat of existing systems which run on top of the FS and don't
cooperate.  Gnome and KDE each have their own VFS, for instance.

>>                                                 fibretions, etc,
> 
> 
> ???

Low-level tweaking.  I think the word is from some sort of calculus.

>>etc. Some thing is not yet ready - doesn't matter. Some of this is of
>>general interest, some is Reiser4-dedicated.
> 
> 
> I don't see anything that would interest me at least, so you can safely
> scratch the "general interest" part.

You're the sole general public?

>>New interfaces are needed to allow users to utilize that all.
> 
> 
> That is a quite strong argument /against/ it all in my book. It means bloat
> in /every/ filesystem, and they have shown to be able to do without for
> some 30 years now. I'd need /very/ strong reasons for adding something.

Spotlight on the Mac.  Users love it.  We can do it.  But not without
changing something in the filesystem.

Actually, I think we came up with several ways to do this, all of which
required Reiser4 interfaces.

It's "bloat" until you need it.

>>                                                              My point
>>is that the things that are of general interest must not be
>>Reiser4-only.
> 
> 
> Reiser4-only stuff is of very limited use, if it isn't just internal
> stuff. And that doesn't need any changes.

Only it does.  Reiser4 can't get into the kernel because it duplicates
the VFS in order to extend it.  It couldn't get in before because it
extended the VFS directly.

Maybe you just don't want this system to EVER get in, no matter what
they do to it?

>>              For example, I should have a possibility to implement
>>files-like-dir in _another_ FS using the same interfaces that Reiser4
>>uses. That's all I wanted to say.
> 
> 
> It has been argued over and over that that particular feature /can't/ be
> implemented sanely anyway, so it has to stay out. Besides not making any

It's been dropped for the moment, but it's been argued just as many
times that it can be done sanely.

> sense. "You've got files and directories" is a bit asymetrical and so not
> quite nice; "all you have is directories" is symmetrical, estetic, and
> completely useless; "some files are directories, some aren't; files in
> file-directories are different than regular files in directory-directories"
> is just a mindless jumble.

Or you can just say "There are no files.  There are no directories.
There are only objects, which contain a chunk of linear data and other
objects."

If you actually go read the whitepaper, you will discover that this is
actually a cleaner, more esthetic, and more useful model than the
current one.  It's just a little harder to do.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQrndSHgHNmZLgCUhAQKOCxAAlhBiu234fmMaUv7kYp0Xt1V2yjP67c8U
ggUbB6sSac1CDo3XQm3cWcR9jqVTTxDCZx012XVEM2MQ7n69YF6+xTxFK/wS69rO
cFh7ChBDe71YOB3aBQ1ojG5D/cM8G4VPVF3pt7ywqoEK67VNwynLvdjjWYYD5w9y
mZd+eRo6kpCmjakNwOpU4LOA8u3C+OK3o2bduzFSMquV9dckV4vt8rxTi1R1l12s
aTBuGc1yvye19vo6DQv28hVcqbv7GmyA5+oBg+TdsFF6Oy/+oR5h4bsfDlFR6Ycs
u23K0yS1b+Iivszqb/wM4CewmkiTOKlxjlR4t93isfsRM1alVeFTfsVP3OYBVRwO
42upk/yzVvliP32n5smZVssf99UK0LuXpb+NTIXABm7WDOtcGV1gC1zz93g0NcBw
Huh82+OPH1l8JXn+4iuZsHBx2VtG5Q7ZENGqXRcEZMb+bYECzFhPNVYBWlPBK+LC
rk/byrkO6zKBkQ5mh7BeK/JrcKVR/IEH+OjpSPmwuam5oPSaoHt9ep5zV+oFYCU6
KIRh8/p7br9i6A2WKUMs+v8j+LcA+Lg+8fbW7RC5LXjG6+QpwvBTuZGU5ykRbj2i
KmrQPCg3x3ZXDGkMLEUySPFL0P3JHpLxsf6tfVEZtsyXCHn1MOeo5sS13NLU719P
6wYcB+VAbSE=
=0NX7
-----END PGP SIGNATURE-----
