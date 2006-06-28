Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751613AbWF1WZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbWF1WZz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 18:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbWF1WZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 18:25:55 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:36498 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1751612AbWF1WZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 18:25:54 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [Suspend2][ 0/9] Extents support.
Date: Thu, 29 Jun 2006 08:25:46 +1000
User-Agent: KMail/1.9.1
Cc: Greg KH <greg@kroah.com>, Jens Axboe <axboe@suse.de>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <200606271858.21810.nigel@suspend2.net> <20060628211114.GC13397@elf.ucw.cz>
In-Reply-To: <20060628211114.GC13397@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1430492.ZgdUdivLp2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606290825.50674.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1430492.ZgdUdivLp2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 29 June 2006 07:11, Pavel Machek wrote:
> Hi!
>
> > > > Now I haven't followed the suspend2 vs swsusp debate very closely,
> > > > but it seems to me that your biggest problem with getting this merg=
ed
> > > > is getting consensus on where exactly this is going. Nobody wants t=
wo
> > > > different suspend modules in the kernel. So there are two options -
> > > > suspend2 is deemed the way to go, and it gets merged and replaces
> > > > swsusp. Or the other way around - people like swsusp more, and you
> > > > are doomed to maintain suspend2 outside the tree.
> > >
> > > Actually, there's a third option that is looking like the way forward,
> > > doing all of this from userspace and having no suspend-to-disk in the
> > > kernel tree at all.
> > >
> > > Pavel and others have a working implementation and are slowly moving
> > > toward adding all of the "bright and shiny" features that is in
> > > suspend2 to it (encryption, progress screens, abort by pressing a key,
> > > etc.) so that there is no loss of functionality.
> > >
> > > So I don't really see the future of suspend2 because of this...
> >
> > But what Rafael and Pavel are doing is really only moving the highest
> > level of controlling logic to userspace (ok, and maybe compression and
> > encryption too). Everything important (freezing other processes, atomic
> > copy and the guts of the I/O) is still done by the kernel.
>
> Can you do the same and move compression/encryption to userspace, too?
>
> And actually that "highest level" covers >50% of suspend2 code. That
> would be around 7K lines of code removed from kernel if you did the
> same, and suspend2 patch would be half the size...

That's not true. The compression and encryption support add ~1000 lines, as=
=20
you pointed out the other day. If I moved compression and encryption suppor=
t=20
to userspace, I'd remove 1000 lines and:

=2D add more code for getting the pages copied to and from userspace
=2D require the user to get and build $LIBRARIES for doing the compression
=2D require the user to get and build $HELPER for doing the interface to=20
Suspend2
=2D fail to leverage the perfectly good cryptoapi routines that are already=
=20
there
=2D slow the whole process down because I'd now have a copy to userspace fo=
r=20
every page being compressed/encrypted and a copy from userspace for every=20
output page.
=2D make life more complicated for distro maintainers and users because the=
y'd=20
have another set of dependencies to worry about and mess with.

I'm not saying it's impossible. I'm just saying it would make suspending mo=
re=20
complicated, at least potentially slower and more of a pain for everyone. O=
n=20
top of that, imagine if someone comes along and writes their own wizz-bang=
=20
compression module, then complains (without telling you they did it) that=20
Suspend2 trashed their hard disk when the bug is actually in their code. It=
's=20
another way in which your kernel can be tainted :)

> > And there _is_ loss of functionality - uswsusp still doesn't support
> > writing a full image of memory, writing to multiple swap devices
> > (partitions or files), or writing to ordinary files. They're getting the
> > low hanging fruit, but when
>
> That's userspace problem. Of course we are after low-hanging fruit,
> first, but uswsusp design (AND CURRENT KERNEL PARTS) allow you to get
> all the fruit with the right userspace.
>
> > it comes to these parts of the problem, they're going to require either
> > smoke and very good mirrors (eg the swap prefetching trick), or simply
> > refuse to implement them.
> >
> :-) I like the mirrors idea. Anyway Rafael *did* get code for saving
>
> whole memory at one point, but it looked quite dangerous to me. It was
> ~300 lines. I'm sure it can be resurrected.
>
> > If we take the problem one step further, and begin to think about
> > checkpointing, they're in even bigger trouble. I'll freely admit that I=
'd
> > have to redesign the way I store data so that random parts of the image
> > could be replaced, have hooks in mm to be able to learn what pages need
> > have changed and would also need filesystem support to handle that part
> > of the problem, but I'd at least be working in the right domain.
>
> Could you explain? I do not get the checkpointing remark.

Sure. Suspending to disk is a pretty similar problem to checkpointing, exce=
pt=20
that you want to continue running afterwards, keep the image and modify it=
=20
from time to time based on the changes in memory (having a checkpointing=20
filesystem too, of course). My point is that modifying uswsusp to do=20
checkpointing would be far harder precisely because you've pushed the highe=
st=20
level logic to userspace. It would be far more complicated, if not impossib=
le=20
for you to make the adjustments to do checkpointing.

Regards,

Nigel

=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart1430492.ZgdUdivLp2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEowHuN0y+n1M3mo0RArynAJ9WbBZmBavTNkwtbqkSC6BX+H0bigCfalkk
fVkR3Og7qZ0ABYuRaYbMCc8=
=vcOR
-----END PGP SIGNATURE-----

--nextPart1430492.ZgdUdivLp2--
