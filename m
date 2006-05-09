Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWEIXBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWEIXBn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 19:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWEIXBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 19:01:43 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:60575 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751357AbWEIXBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 19:01:43 -0400
From: Dan Smith <danms@us.ibm.com>
To: mingz@ele.uri.edu
Cc: device-mapper development <dm-devel@redhat.com>,
       linux-kernel@vger.kernel.org,
       Xen Developers <xen-devel@lists.xensource.com>
Subject: Re: [dm-devel] [RFC] dm-userspace
References: <87u08g553l.fsf@caffeine.beaverton.ibm.com>
	<1146092129.14129.333.camel@localhost.localdomain>
Date: Tue, 09 May 2006 16:02:09 -0700
Message-ID: <m33bfig5u6.fsf@guaranine.beaverton.ibm.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

(I'm including the xen-devel list on this, as things are starting to
get interesting).

MZ> do u have any benchmark results about overhead?

So, I've spent some time over the last week working to improve
performance and collect some benchmark data.

I moved to using slab caches for the request and remap objects, which
helped a little.  I also added a poll() method to the control device,
which improved performance significantly.  Finally, I changed the
internal remap storage data structure to a hash table, which had a
very large performance impact (about 8x).

Copying data to a device backed by dm-userspace presents a worst-case
scenario, especially with a small block-size like what qcow uses.  In
one of my tests, I copy about 20MB of data to a dm-userspace device,
backed by files hooked up to the loopback driver.  I compare this with
a "control" of a single loop-mounted image file (i.e., without
dm-userspace or CoW).  I measured the time to mount, copy, and unmount
the device, which (with the recent performance improvements) are
approximately:

  Normal Loop:        1 seconds
  dm-userspace/qcow: 10 seconds

For comparison, before adding poll() and the hash table, the
dm-userspace number was over 70 seconds.

One of the most interesting cases for us, however, is providing a
CoW-based VM disk image, which is mostly used for reading, with a
small amount of writing for configuration data.  To test this, I used
Xen to compare a fresh FC4 boot (firstboot, where things like SSH keys
are generated and written to disk) that used an LVM volume as root to
using dm-userspace (and loopback-files) as the root.  The numbers are
approximately:

  LVM root:          26 seconds
  dm-userspace/qcow: 27 seconds

Note that this does not yet include any read-ahead type behavior, nor
does it include priming the kernel module with remaps at create-time
(which results in a few initial compulsory "misses").  Also, I removed
the remap expiration functionality while adding the hash table and
have not yet added it back, so that may further improve performance
for large amounts of remaps (and bucket collisions).

Here is a link to a patch against 2.6.16.14:

  http://static.danplanet.com/dm-userspace/dmu-2.6.16.14-patch

Here are links to the userspace library, as well as the cow daemon,
which provides qcow support:

  http://static.danplanet.com/dm-userspace/libdmu-0.2.tar.gz
  http://static.danplanet.com/dm-userspace/cowd-0.1.tar.gz

(Note that the daemon is still rather rough, and the qcow
implementation has some bugs.  However, it works for light testing and
the occasional luck-assisted heavy testing)

As always, comments welcome and appreciated :)

=2D-=20
Dan Smith
IBM Linux Technology Center
Open Hypervisor Team
email: danms@us.ibm.com

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEYR9zwtEf7b4GJVQRAvHmAJsG/Jh2ggcexQCC8DS+n8BXqFkP2ACfSUWj
WA8qS/9RSlNUeDb05Vujogg=
=Cl9x
-----END PGP SIGNATURE-----
--=-=-=--
