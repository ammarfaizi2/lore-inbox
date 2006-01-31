Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965025AbWAaFqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbWAaFqn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 00:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbWAaFqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 00:46:43 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:9182 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S965025AbWAaFqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 00:46:43 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ 15/23] [Suspend2] Helper for counting uninterruptible threads of a type.
Date: Tue, 31 Jan 2006 15:42:59 +1000
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
References: <20060126034518.3178.55397.stgit@localhost.localdomain> <200601302318.28922.rjw@sisk.pl> <20060130222541.GK2250@elf.ucw.cz>
In-Reply-To: <20060130222541.GK2250@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6782956.jyIpIvjvCV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601311543.04302.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart6782956.jyIpIvjvCV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 31 January 2006 08:25, Pavel Machek wrote:
> On Po 30-01-06 23:18:28, Rafael J. Wysocki wrote:
> > Hi,
> >
> > On Thursday 26 January 2006 04:45, Nigel Cunningham wrote:
> > > Add a helper which counts the number of patches of a type (all
> > > or userspace only) which are in TASK_UNINTERRUPTIBLE state.
> > > These tasks are signalled (just in case they leave that state at
> > > a later point), but we do not consider freezing to have failed
> > > if and when they do not enter the freezer.
> > >
> > > Note that when they eventually leave TASK_UNINTERRUPTIBLE state,
> > > they will enter the refrigerator, but will immediately exit if
> > > we no longer want to freeze at that point.
> >
> > I think we need to do something like this to prevent problems with
> > freezing under load.
>
> That is dangerous... task in UNINTERRUPTIBLE may hold some lock,
> AFAICT.
>
> No, there's some simple bug in refrigerator, and I/we need to fix
> that. Signals work under load, so refrigerator should, too.

I know you understand English, Pavel! Re-read what I wrote previously! The=
=20
problem is a race. You're telling processes that process I/O to freeze at t=
he=20
same time as you're telling processes that submit I/O to freeze. If kjourna=
ld=20
(eg) enters the refrigerator while dd is still running, dd is going to have=
 a=20
chance of getting stuck, waiting for some I/O to complete.

This also means your sys_sync is totally useless if anything is submitting=
=20
I/O, since there will still be I/O being submitted after the sync is done.=
=20
This is why (in the numbers I submitted yesterday), the current=20
implementation took so much longer than the new one. The sys_sync really on=
ly=20
introduces a big delay. It needs to be done after the things that generate=
=20
I/O have been stopped.

Regards,

Nigel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart6782956.jyIpIvjvCV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD3vjoN0y+n1M3mo0RAq4VAKCiBjlarHGQeQsHP1peLdN+r3LDMwCdEzrC
9jb5Bq7M/xtYKAPpDo+g0Tg=
=HskV
-----END PGP SIGNATURE-----

--nextPart6782956.jyIpIvjvCV--
