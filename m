Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbWDZXH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWDZXH2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 19:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWDZXH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 19:07:27 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:23681 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751057AbWDZXH1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 19:07:27 -0400
From: Dan Smith <danms@us.ibm.com>
To: mingz@ele.uri.edu
Cc: device-mapper development <dm-devel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [dm-devel] [RFC] dm-userspace
References: <87u08g553l.fsf@caffeine.beaverton.ibm.com>
	<1146092129.14129.333.camel@localhost.localdomain>
Date: Wed, 26 Apr 2006 16:07:35 -0700
In-Reply-To: <1146092129.14129.333.camel@localhost.localdomain> (Ming Zhang's
	message of "Wed, 26 Apr 2006 18:55:28 -0400")
Message-ID: <87psj45420.fsf@caffeine.beaverton.ibm.com>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

MZ> just curious, will the speed be a problem here?=20

I'm glad you asked... :)

MZ> considering each time it needs to contact user space for mapping a
MZ> piece of data.=20

Actually, that's not the case.  The idea is for mappings to be cached
in the kernel module so that the communication with userspace only
needs to happen once per block.  The thought is to ask once for a
read, and then remember that mapping until a write happens, which
might change the story.  If so, we ask userspace again.

Right now, the kernel module expires mappings in a pretty brain-dead
way to make sure the list doesn't get too long.  An intelligent data
structure and expiration method would probably improve performance
quite a bit.

I don't have any benchmark data to post right now.  I did some quick
analysis a while back and found it to be not too bad.  When using loop
devices as a backing store, I achieved performance as high as a little
under 50% of native.

MZ> and the size unit is per sector in dm?

Well, for qcow it is a sector, yes.  The module itself, however, can
use any block size (as long as it is a multiple of a sector).  Before
I started work on qcow support, I wrote a test application that used
2MiB blocks, which is where I got the approximately 50% performance
value I described above.

Our thought is that this would mostly be used for the OS images of
virtual machines, which shouldn't change much, which would help to
prevent constantly asking userspace to map blocks.

=2D-=20
Dan Smith
IBM Linux Technology Center
Open Hypervisor Team
email: danms@us.ibm.com

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBET/03wtEf7b4GJVQRAjriAKCEJYwRg30sBHBsR108iXXGS2cp0gCfWQXg
9/+VuCdkbTG4sDwHDQFUoNc=
=07tN
-----END PGP SIGNATURE-----
--=-=-=--

