Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270765AbTHOTmM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 15:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270767AbTHOTmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 15:42:12 -0400
Received: from niobium.golden.net ([199.166.210.90]:10747 "EHLO
	niobium.golden.net") by vger.kernel.org with ESMTP id S270765AbTHOTmG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 15:42:06 -0400
Date: Fri, 15 Aug 2003 15:42:01 -0400
From: Paul Mundt <lethal@linux-sh.org>
To: linux-kernel@vger.kernel.org
Subject: vm_operations_struct sync/unmap replacements?
Message-ID: <20030815194201.GA9787@linux-sh.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This particular issue seems to have been raised before (at least in the unmap
case) according to google, but there doesn't seem to be any obvious resolution
that I've been able to find.

In short, we need (or rather, want) both sync and unmap for a store queue
implementation for sh. The main requirement is manually remapping special
virtual addresses that we know ahead of time against a phys addr handed off
by mmap(). Writes to the remapped area subsequently need to be flushed from
the queues (which would work quite nicely from msync()). Looking through
mm/msync.c it seems that fsync() is the only candidate for a driver callback,
which unfortunately isn't quite as nice as the old sync() where both the
size and the base could be specified directly.

Also, since allocations are tracked in a list, the unmap() functionality would
be nice to have, as it provides us with a much saner method for cleaning up
this stuff. The only other option I see here is to do this at VMA close time,
which can potentially leave us with stale entries for quite awhile, and also
leaves us with the overhead of linearly searching the list and cleaning up
after the allocations.

It seems that both of these were removed around 2.4-test time, since apparently
there weren't any users at the time. Is there any objection to adding these
back in for 2.6? Does anyone have any suggestions for any useful workarounds
for getting the same sort of functionality without having to resort to endless
ioctl stupidity?


--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/PTeJ1K+teJFxZ9wRAnMeAJ9GRsv5KHp9wqLNQKI+EJarwG09EwCfX8Nm
5Kj5k7HiKPT5IcQJpxOpPa4=
=hArU
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
