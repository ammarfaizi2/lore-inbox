Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVDEQe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVDEQe2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 12:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVDEQe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 12:34:28 -0400
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:38785 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261471AbVDEQeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 12:34:18 -0400
Subject: [BUG mm] "fixed" i386 memcpy inlining buggy
From: Christophe Saout <christophe@saout.de>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Andrew Morton <akpm@osdl.org>, Jan Hubicka <hubicka@ucw.cz>,
       Gerold Jury <gerold.ml@inode.at>, jakub@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       gcc@gcc.gnu.org
In-Reply-To: <200504021526.53990.vda@ilport.com.ua>
References: <200503291542.j2TFg4ER027715@earth.phy.uc.edu>
	 <20050401214322.GA7175@atrey.karlin.mff.cuni.cz>
	 <200504021518.49479.vda@ilport.com.ua>
	 <200504021526.53990.vda@ilport.com.ua>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7IFbw1W0hM5tE/mBhjYS"
Date: Tue, 05 Apr 2005 18:34:04 +0200
Message-Id: <1112718844.22591.15.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7IFbw1W0hM5tE/mBhjYS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Denis,

the new i386 memcpy macro is a ticking timebomb.

I've been debugging a new mISDN crash, just to find out that a memcpy
was not inlined correctly.

Andrew, you should drop the fix-i386-memcpy.patch (or have it fixed).

This source code:

        mISDN_pid_t     pid;
	[...]
        memcpy(&st->mgr->pid, &pid, sizeof(mISDN_pid_t));

was compiled as:

        lea    0xffffffa4(%ebp),%esi    <---- %esi is loaded
(       add    $0x10,%ebx                      )
(       mov    %ebx,%eax                       ) something else
(       call   1613 <test_stack_protocol+0x83> ) %esi preserved
        mov    0xffffffa0(%ebp),%edx
        mov    0x74(%edx),%edi          <---- %edi is loaded
        add    $0x20,%edi                     offset in structure added
!       mov    $0x14,%esi        !!!!!! <---- %esi overwritten!
        mov    %esi,%ecx                <---- %ecx loaded
        repz movsl %ds:(%esi),%es:(%edi)

Apparently the compiled decided that the value 0x14 could be reused
afterwards (which it does for an inlined memset of the same size some
instructions below) and clobbers %esi.

Looking at the macro:

                __asm__ __volatile__(
                        ""
                        : "=3D&D" (edi), "=3D&S" (esi)
                        : "0" ((long) to),"1" ((long) from)
                        : "memory"
                );
        }
        if (n >=3D 5*4) {
                /* large block: use rep prefix */
                int ecx;
                __asm__ __volatile__(
                        "rep ; movsl"
                        : "=3D&c" (ecx)

it seems obvious that the compiled assumes it can reuse %esi and %edi
for something else between the two __asm__ sections. These should
probably be merged.


--=-7IFbw1W0hM5tE/mBhjYS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCUr38ZCYBcts5dM0RAjopAJ4sKskZyfDgfTRCLCgHUXm9xCe9TwCcDuyk
ot1+pcosdlePcnCT0WGg3qI=
=bZg/
-----END PGP SIGNATURE-----

--=-7IFbw1W0hM5tE/mBhjYS--

