Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbWD0CWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWD0CWm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 22:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbWD0CWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 22:22:42 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:60111 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964886AbWD0CWl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 22:22:41 -0400
From: Dan Smith <danms@us.ibm.com>
To: mingz@ele.uri.edu
Cc: device-mapper development <dm-devel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [dm-devel] [RFC] dm-userspace
References: <87u08g553l.fsf@caffeine.beaverton.ibm.com>
	<1146092129.14129.333.camel@localhost.localdomain>
	<87psj45420.fsf@caffeine.beaverton.ibm.com>
	<1146094877.14129.343.camel@localhost.localdomain>
Date: Wed, 26 Apr 2006 19:22:48 -0700
In-Reply-To: <1146094877.14129.343.camel@localhost.localdomain> (Ming Zhang's
	message of "Wed, 26 Apr 2006 19:41:17 -0400")
Message-ID: <87irov69l3.fsf@caffeine.beaverton.ibm.com>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

MZ> o. :P 50% is a considerable amount. anyway, good start. ;)

Indeed, it is a considerable performance hit, but I haven't really
done much in the way of a serious performance analysis.

MZ> pure read or read and write mixed?

Actually IIRC, that was the write performance only (I used bonnie++ to
get the numbers).  I believe the read performance is generally good
for large blocks.  If the block is already mapped for write, then you
get the reads for free.  I really should resurrect my older tests and
see if I can produce something more current :)

My previous numbers were gathered by using an additional step of
actually rewriting the device-mapper table periodically, using
dm-linear to statically map blocks that were mapped for writing.  I
think that with a better data structure in dm-userspace (i.e. better
than a linked-list), performance will be better without the need to
constantly suspend and resume the device to change tables.

MZ> if this is the scenario, then may be more aggressive mapping can
MZ> be used here.

Right, so the userspace side may be able to improve performance by
mapping blocks in advance.  If it is believed that the next several
blocks will be written to sequentially, the userspace app can push
mappings for those in the same message as the response to the initial
block, which would eliminate several additional requests.

Perhaps something could be done with certain CoW formats that would
allow the userspace app to push a bunch of mappings that it believes
might be needed, and then have the kernel report back later which were
actually used.  In that case, you could reclaim space in the CoW
device that you incorrectly predicted would be needed.

MZ> u might have interest on this. some developers are working on a
MZ> general scsi target layer that pass scsi cdb to user space for
MZ> processing while keep data transfer in kernel space. so both of u
MZ> will meet same overhead here. so 2 projects might learn from each
MZ> other on this.

Great!

MZ> ps, trivial thing, the userspace_request is frequently used and
MZ> can use a slab cache.

Ah, ok, good point... thanks ;)

=2D-=20
Dan Smith
IBM Linux Technology Center
Open Hypervisor Team
email: danms@us.ibm.com

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEUCr6wtEf7b4GJVQRAkM0AJ0YpBxs49Qrd4NFwJgQbgPVG4gMpwCfVIxJ
d4hlZz9wI5EBmQdWdiJ4hhw=
=sSzU
-----END PGP SIGNATURE-----
--=-=-=--

