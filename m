Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWDZWpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWDZWpO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 18:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWDZWpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 18:45:14 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:62621 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S964881AbWDZWpM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 18:45:12 -0400
From: Dan Smith <danms@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: device-mapper development <dm-devel@redhat.com>
Subject: [RFC] dm-userspace
Date: Wed, 26 Apr 2006 15:45:02 -0700
Message-ID: <87u08g553l.fsf@caffeine.beaverton.ibm.com>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

Xen needs to be able to directly access disk formats such as QEMU's
qcow, VMware's vmdk, and possibly others.  Most of these formats are
based on copy-on-write ideas, and thus have a base image and a bunch
of modified blocks stored elsewhere.  Presenting this to a virtual
machine transparently as a normal block device would be ideal.  The
solution I propose is to use device-mapper for redirecting block
accesses to the appropriate locations within either the base image or
the COW space, with the following constraints:

1. The block-allocation algorithm and formatting scheme should not be
   in the kernel.  This gives the most flexibility and puts the
   complexity in userspace.
2. Actual data flow should happen only in the kernel, and userspace
   should be able to control it without the blocks being passed back
   and forth.

So, I developed a generic device-mapper target called dm-userspace
which allows a userspace application to control the block mapping in a
mostly generic way.  With the functionality it provides, I was able to
write a userspace daemon that handles the mapping of blocks such that
a qcow file could be presented as a single block device, mounted and
accessed as if it were a normal disk.  If/when VMware releases their
vmdk spec under the GPL, adding support for it would be relatively
simple.  This would give us a unified block device to export to the
virtual machine, that would be backed by a complex format such as vmdk
or qcow.

In addition to providing support for the above scenario, dm-userspace
could be used for other things as well.  It's possible that new
device-mapper targets could be developed in userspace using a special
application that used dm-userspace to simulate the kernel
environment.  Additionally, filesystem debuggers may be able to use
dm-userspace to provide interactive control and logging of disk
writes.=20

A patch against 2.6.16.9 to add dm-userspace to the kernel is
available here:

  http://static.danplanet.com/dm-userspace/dmu-2.6.16.9.patch

After you have a patched kernel, you can build the (very tiny) helper
library and example program, available here:

  http://static.danplanet.com/dm-userspace/libdmu-0.1.tar.gz

Comments would be appreciated :)

=2D-=20
Dan Smith
IBM Linux Technology Center
Open Hypervisor Team
email: danms@us.ibm.com

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBET/f9wtEf7b4GJVQRAjj7AJ9Fu2hFEEVW9bnAhvLyPDk7Frc6mwCeNbGG
NVpEU/eIoL3WGCKLlZWBGBU=
=jcgr
-----END PGP SIGNATURE-----
--=-=-=--

