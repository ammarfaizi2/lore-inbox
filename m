Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932667AbWHMD20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932667AbWHMD20 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 23:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932669AbWHMD20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 23:28:26 -0400
Received: from spock.bluecherry.net ([66.138.159.248]:44957 "EHLO
	spock.bluecherry.net") by vger.kernel.org with ESMTP
	id S932667AbWHMD2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 23:28:25 -0400
Date: Sat, 12 Aug 2006 23:28:21 -0400
From: "Zephaniah E. Hull" <warp@aehallh.com>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Magnus =?iso-8859-1?Q?Vigerl=F6f?= <wigge@bigfoot.com>,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: input: evdev.c EVIOCGRAB semantics question
Message-ID: <20060813032821.GB5251@aehallh.com>
Mail-Followup-To: Dmitry Torokhov <dtor@insightbb.com>,
	Magnus =?iso-8859-1?Q?Vigerl=F6f?= <wigge@bigfoot.com>,
	linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
References: <200608121724.16119.wigge@bigfoot.com> <20060812165228.GA5255@aehallh.com> <200608122000.47904.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline
In-Reply-To: <200608122000.47904.dtor@insightbb.com>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 12, 2006 at 08:00:47PM -0400, Dmitry Torokhov wrote:
> On Saturday 12 August 2006 12:52, Zephaniah E. Hull wrote:
> > I can dust off the masking patch sometime here if Dmitry thinks that
> > he'd be willing to see a second method for this in addition to grabbing,
> > adding support to xf86-input-evdev would be trivial, and the same could
> > probably be said for the wacom driver that does grabbing at the moment.
> > 
> 
> I would not mind if we get it working right ;) Do we need to turn off
> "undesirable" handlers or do we want to limit output to one particular
> handler? I'd prefer the former, if possible. Do we keep a counter or
> set of counters so several processes can mask output, etc. Can we keep
> event delivery somewhat fast? 

EVIOCGRAB provides for the latter, though it seems to go too far and
mess with sysrq as well.

My old old EVIOCMASK patch just added a long (or was it an int?  It's
been a while) to each device struct, and to each handler struct, and if
they had bits set in common then they received the events, and if not
they did not.

That was the cost of a quick & operation and a branch in the input event
path, so not too expensive, though my memory seems to indicate that I
tried to play some evil games to invert the bits first to allow things
to be zero inited.

I'd definitely want to just rewrite it these days, but that approach is
fast, and if we define it something along the lines of 'bit 0 is the
kernel console layer, bit 1 is any further handlers in the kernel like
/dev/input/mice or the joystick interface, the rest belong to userspace'
that gives userspace plenty of bits for odd policy decisions.

One obvious catch is that programs would have to be careful to reset the
mask when leaving, though having the sysrq handler always present and
adding controls for 'reset input device masks' would be one escape
route for X masking keyboard events from the kernel, then crashing
messily.

We probably don't want to automaticly reset on close by a program that
did the masking, as I can see some cases where someone might want to use
a utility that adjusts the masks on input devices.


On a side note, if we mess with sysrq for the masking, we should add a
'ungrab all input devices' one as well.

Zephaniah E. Hull.

-- 
	  1024D/E65A7801 Zephaniah E. Hull <warp@aehallh.com>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

<aj> ``Who killed the server at the colo site?'' ``Weasel killed the
     server at the colo site'' ``Not me'' ``Then who?'' ``m2 killed the
     server at the colo site'' ...

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE3pxVRFMAi+ZaeAERAqGnAKDxMTxC5n0QleJF3AqaE4KwrWXmLwCg1U12
KLF9RzPPIFGxWEuKYp5yZgg=
=2e3l
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
