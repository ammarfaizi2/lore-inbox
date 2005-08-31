Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbVHaVHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbVHaVHH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 17:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbVHaVHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 17:07:07 -0400
Received: from [63.227.221.253] ([63.227.221.253]:64434 "EHLO home.keithp.com")
	by vger.kernel.org with ESMTP id S964963AbVHaVHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 17:07:05 -0400
Subject: Re: State of Linux graphics
From: Keith Packard <keithp@keithp.com>
To: Discuss issues related to the xorg tree 
	<xorg@lists.freedesktop.org>
Cc: lkml <linux-kernel@vger.kernel.org>, keithp@keithp.com
In-Reply-To: <20050831200641.GH27940@tuolumne.arden.org>
References: <9e47339105083009037c24f6de@mail.gmail.com>
	 <1125422813.20488.43.camel@localhost>
	 <20050831063355.GE27940@tuolumne.arden.org>
	 <1125512970.4798.180.camel@evo.keithp.com>
	 <20050831200641.GH27940@tuolumne.arden.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-J5Pg3XuzYGYUW1l6J6JR"
Date: Wed, 31 Aug 2005 14:06:54 -0700
Message-Id: <1125522414.4798.222.camel@evo.keithp.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-J5Pg3XuzYGYUW1l6J6JR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-08-31 at 13:06 -0700, Allen Akin wrote:
> On Wed, Aug 31, 2005 at 11:29:30AM -0700, Keith Packard wrote:
> | The real goal is to provide a good programming environment for 2D
> | applications, not to push some particular low-level graphics library.
>=20
> I think that's a reasonable goal.
>=20
> My red flag goes up at the point where the 2D programming environment
> pushes down into device drivers and becomes an OpenGL peer.  That's
> where we risk redundancy of concepts, duplication of engineering effort,
> and potential semantic conflicts.

Right, the goal is to have only one driver for the hardware, whether an
X server for simple 2D only environments or a GL driver for 2D/3D
environments. I think the only questions here are about the road from
where we are to that final goal.

> For just one small example, we now have several ways of specifying the
> format of a pixel and creating source and destination surfaces based on
> a format.  Some of those formats and surfaces can't be used directly by
> Render, and some can't be used directly by OpenGL.  Furthermore, the
> physical resources have to be managed by some chunk of software that
> must now resolve conflicts between two APIs.

As long as Render is capable of exposing enough information about the GL
formats for 2D applications to operate, I think we're fine. GL provides
far more functionality than we need for 2D applications being designed
and implemented today; picking the right subset and sticking to that is
our current challenge.

> The ARB took a heck of a long time getting consensus on the framebuffer
> object extension in OpenGL because image resource management is a
> difficult problem at the hardware level.  By adding a second low-level
> software interface we've made it even harder.  We've also put artificial
> barriers between "2D" clients and useful "3D" functionality, and between
> "3D" clients and useful "2D" functionality.  I don't see that the nature
> of computer graphics really justifies such a separation (and in fact the
> OpenGL designers argued against it almost 15 years ago).

At the hardware level, there is no difference. However, at the
application level, GL is not a very friendly 2D application-level API.
Abstracting 3D hardware functionality to make it paletable to 2D
developers remains the key goal of Render and cairo.

Note that by layering cairo directly on GL rather than the trip through
Render and the X server, one idea was to let application developers use
the cairo API to "paint" on 3D surfaces without creating an intermediate
texture. Passing through the X server and Render will continue to draw
application content to pixels before it is applied to the final screen
geometry.

> So I think better integration is also a reasonable goal.

Current efforts in solving the memory management issues with the DRM
environment should make the actual consumer of that memory irrelevant,
so we can (at least as a temporary measure) run GL and old-style X
applications on the same card and expect them to share memory in a more
integrated fashion. The integration of 2D and 3D acceleration into a
single GL-based system will take longer, largely as we wait for the GL
drivers to catch up to the requirements of the Xgl implementation that
we already have.

> I believe we're doing well with layered implementation strategies like
> Xgl and Glitz.

I've been pleased that our early assertions about Render being
compatible with GL drawing semantics have been borne out in practice,
and that our long term goal of a usable GL-based X server are possible
if not quite ready for prime-time.

>   Where we might do better is in (1) extending OpenGL to
> provide missing functionality, rather than creating peer low-level APIs;

I'm not sure we have any significant new extensions to create here;
we've got a pretty good handle on how X maps to GL and it seems to work
well enough with suitable existing extensions.

> (2) expressing the output of higher-level services in terms of OpenGL
> entities (vertex buffer objects, framebuffer objects including textures,
> shader programs, etc.) so that apps can mix-and-match them and
> scene-graph libraries can optimize their use;=20

This will be an interesting area of research; right now, 2D applications
are fairly sketchy about the structure of their UIs, so attempting to
wrap them into more structured models will take some effort.

Certainly ensuring that cairo on glitz can be used to paint into an
arbitrary GL context will go some ways in this direction.

> (3) finishing decent
> OpenGL drivers for small and old hardware to address people's concerns
> about running modern apps on those systems.

The question is whether this is interesting enough to attract developer
resources. So far, 3D driver work has proceeded almost entirely on the
newest documented hardware that people could get. Going back and
spending months optimizing software 3D rendering code so that it works
as fast as software 2D code seems like a thankless task.

And this, unfortunately, may well drive the fundemental APIs of the
system for some time to come. 2D application development must target the
broadest possible platorms, and so any significant installed base of
software-only 3D hardware will tend to block adoption of 3D apis where
unneeded.

So, I believe applications will target the Render API for the
foreseeable future. We already know how to accelerate this API in pure
software implementations; that work has recently gained a bit of steam
as cairo starts to make itself more prevalent in application
development.=20

That Render can be efficiently implemented on top of OpenGL means that
we should be able to avoid re-implementation of hardware acceleration
for cards which already support performant GL implementations.

What this fails to do is expose GL as the fundemental drawing API to
applications themselves, so the mixture of 2D and 3D drawing that we'd
like to see may not be possible for most applications.

-keith


--=-J5Pg3XuzYGYUW1l6J6JR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDFhvuQp8BWwlsTdMRAl7EAKCXP6z8ulx++Ap/UVC6DMMwqREheQCcCUDu
+ftl+d8763Payn58gHPdE5M=
=CeYX
-----END PGP SIGNATURE-----

--=-J5Pg3XuzYGYUW1l6J6JR--
