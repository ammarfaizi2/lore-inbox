Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267786AbRGQHU2>; Tue, 17 Jul 2001 03:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267789AbRGQHUJ>; Tue, 17 Jul 2001 03:20:09 -0400
Received: from femail1.rdc1.on.home.com ([24.2.9.88]:61627 "EHLO
	femail1.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S267786AbRGQHUE>; Tue, 17 Jul 2001 03:20:04 -0400
Date: Tue, 17 Jul 2001 03:19:56 -0400 (EDT)
From: "Mike A. Harris" <mharris@redhat.com>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Jeff Hartmann <jhartmann@valinux.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, John Cavan <johnc@damncats.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 4.1.0 DRM
In-Reply-To: <3B532BB7.1050300@valinux.com>
Message-ID: <Pine.LNX.4.33.0107170232140.1440-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
X-Spam-To: uce@ftc.gov
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jul 2001, Jeff Hartmann wrote:

>Date: Mon, 16 Jul 2001 12:00:23 -0600
>From: Jeff Hartmann <jhartmann@valinux.com>
>To: Alan Cox <alan@lxorguk.ukuu.org.uk>
>Cc: John Cavan <johnc@damncats.org>, linux-kernel@vger.kernel.org
>Content-Type: text/plain; charset=us-ascii; format=flowed
>Subject: Re: 4.1.0 DRM (was Re: Linux 2.4.6-ac3)
>
>Alan Cox wrote:
>
>>> Why not do something similar to the aic7xxx driver? Place the old DRM in
>>> code in a pre-X4.1.0 subdirectory, with a warning that it will become
>>> obsolete as of 2.5, and bring in the new code. When you build the
>>> kernel, you can then choose which DRM version you want and everybody is
>>> happy.
>>
>>
>> Thats certainly possible, Ideally you would want both module sets to
>> co-exist. That way the user can build all of DRM and get the right ones loading
>> via modprobe
>>
>> Alan
>
>Actually I have something like this pretty much working.  Unfortunately
>I was working on a project full time during the 4.1.0 release.  With the
>addition of this code, the old modules will coexist with newer modules.
>Basically the newer modules will have their version numbers appended to
>their names, this way a user can build all the drm modules, and things
>will just work.  Hopefully we can get a 4.1.1 release out soon which
>will do this.  This will make the 4.0 -> 4.1 have to be a compile time
>decision, but 4.1 -> 4.1.1 and higher will just coexist with each
>other.  I'm currently working out integrating this into the kernel
>build, and I should hopefully have a patch for Linus and Alan soon.

This is something that is very very much needed IMHO, so I
applaud your effort to resolve this problem Jeff.

Some background on the existing DRM problems from a package
maintainer's perspective:

The sole reason that XFree86 4.0.1 is frozen in stone in Red Hat
Linux 7.0 right now, and 4.0.3 in Red Hat Linux 7.1 is because of
DRM not being backwards compatible.  Right now XFree86 4.1.0 is
in rawhide, and the DRM in it is not back-compatible either.

This makes package/distro maintenance of XFree86 very difficult
as we can only ship one set of DRM modules in our kernel, and we
are not willing to force everyone using DRI to upgrade XFree86
just because we released a kernel errata, nor can we expect to
force everyone to upgrade their kernel because they want to use
the new XFree86.

As such I must maintain a separate XFree86 for each distro
release right now.  This is extremely difficult, and means that
time is divided between fixing issues with each release, in
addition to backwards compatibility with 3.3.6 servers also.  In
the end, the user loses out because of the duplication of effort
syncing multiple releases, etc.  Other Linux vendors no doubt
suffer from this problem as well.

What I would personally like to be able to do is to ship the
current XFree86 at any given point in time, and when a new
release comes out, release it in our next distro release, and
then as an errata release for previous distro releases thus
unifying the XFree86 used across the board, and truely improving
quality, hardware support, speed, etc.

It just isn't possible with the current DRM however, and I do not
see an easy way to solve this problem for current releases.  We
certainly cannot tell users to rebuild DRM themselves depending
on the kernel they're using.

Another option suggested to me privately by someone is to do as
VMware does and dynamically recompile the proper DRM based on
which kernel is present and which XFree86, however that means the
user's running DRM is subject to conditions outside our control
such as the compiler used, the exact kernel used, etc.. and if we
were to do that, we would have to advertise zero support "if it
works great, if not, sorry" for DRM, which is not acceptable
either.

Other options include separating DRM from our kernel RPM and
having multiple DRM packages.  This is very ugly and prone to all
kinds of problems although it is the best looking current
solution I can think of.  These binary DRM packages would be
dependant on specific kernel *and* XFree86 releases, and would
expand exponentially as both kernel errata and XFree86 errata
were released.

So the long term solution is indeed to make the DRM support
stable across a kernel stable release at a minimum, and
preferably have it implemented so that multiple DRM interfaces
can coexist as long as deemed necessary, and then be deprecated
at some point long in the future.

Another problem, is if Linus doesn't accept the DRM from 4.1.0
(completely understandably) into the official 2.4.x kernel
series, then we either:

1) Ship DRM from 4.1.0 and lose DRM compatibility with the
   official kernel, which would be construed in the public as
   breaking compatibility unnecessarily (conspiratalists
   would say "with evil intent to break compatibility on
   purpose", which definitely WILL NOT HAPPEN.

2) Do not ship DRM from 4.1.0, instead shipping 4.0.3 DRM as it
   is what is in the standard kernel.  Thus leaving everyone with
   broken 3D hardware support entirely.  This isn't acceptable
   for millions of really obvious reasons.

3) Don't ship 4.1.0, falling back to 4.0.3 instead.  This
   would not be good because of all the fantastic hard work that
   has went into the 4.1.0 release including the vastly improved
   DRM (performance wise and support wise), and countless other
   reasons including user outrage for not including the new
   release, likely with some new conspiracy twists also. I'm sure
   /. would double in banner ad revenue over a decision like this
   also, and while I wish them well, I hope it is not at our
   expense, so no dice on this option in my book.

4) Shipping DRM in the XFree86 package doesn't work because it
   means the kernel can't be updated without killing DRM, or
   also releaseing an XFree86 errata.  Not feasible because it
   makes upgrading either a horrendous user experience not to
   mention a horrendous developer/QA experience.

5) Shipping DRM in a separate package, breaking our unified kernel
   packaging.  Every kernel errata would need a DRM errata also,
   and every XFree86 errata would possibly need multiple DRM errata.
   The permutations that result are likely to have all sorts of
   upgrade problems unforseen.

The current way DRM exists makes it difficult to ship a quality
product that both simplifies packaging and end user
installation/upgrading, etc.

I'm glad to see that this real problem is taken seriously and I
hope future XFree86 releases will solve the issue at runtime.
In the interim, I'm open to any suggestions people may have on
rectifying the existing releases.  Please send any suggestions
privately to me in a separate email.

I very much look forward to the day I can release unified XFree86
updates to our users, and also cut down on duplication.

Thanks in advance,
TTYL


----------------------------------------------------------------------
Mike A. Harris                  Shipping/mailing address:
OS Systems Engineer             190 Pittsburgh Ave., Sault Ste. Marie,
XFree86 maintainer		Ontario, Canada, P6C 5B3
Red Hat Inc.			Phone: (705)949-2136
http://www.redhat.com		ftp://people.redhat.com/mharris
----------------------------------------------------------------------

