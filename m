Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268781AbUIQTaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268781AbUIQTaI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 15:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268950AbUIQTaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 15:30:08 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:55211 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S268781AbUIQT37 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 15:29:59 -0400
Message-Id: <200409171929.i8HJTq92024659@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm1 
In-Reply-To: Your message of "Thu, 16 Sep 2004 19:30:22 +0200."
             <20040916173022.GA6793@devserv.devel.redhat.com> 
From: Valdis.Kletnieks@vt.edu
References: <20040916024020.0c88586d.akpm@osdl.org> <200409161345.56131.norberto+linux-kernel@bensa.ath.cx> <1095354962.2698.22.camel@laptop.fenrus.com> <200409161428.10717.norberto+linux-kernel@bensa.ath.cx>
            <20040916173022.GA6793@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-386619809P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 17 Sep 2004 15:29:51 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-386619809P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <31490.1095449391.1@turing-police.cc.vt.edu>

On Thu, 16 Sep 2004 19:30:22 +0200, Arjan van de Ven said:

> I would consider it REALLY weird for a module to use detailed vmalloc
> knowledge like this. Does anyone know what they are doing?????

Here's the problematic code:

        // start off by tracking down which page within this allocation
        // we're looking at. do this by searching for the physical address
        // in our page table.
        for (i = 0; i < at->num_pages; i++)
        {
            if ((address == (unsigned long) at->page_table[i].phys_addr))
            {
                unsigned long retaddr = (unsigned long) at->page_table[i].phys_addr;

                // if we've allocated via vmalloc on a highmem system, the
                // physical address may not be accessible via PAGE_OFFSET,
                // that's ok, we have a simple linear pointer already.
                if (at->flags & NV_ALLOC_TYPE_VMALLOC)
                {
                    return (void *)((unsigned char *) at->key_mapping + (i << PAGE_SHIFT) + offset);
                }

                if (retaddr <= MAXMEM)
                {
                    return __va((retaddr + offset));
                }

                // ?? this may be a contiguous allocation, fall through
                // to below? or should I just check at->flag here?
            }
        }


It gets hung up because MAXMEM is:

#define MAXMEM                        (-__PAGE_OFFSET-__VMALLOC_RESERVE)

and in arch/i386/mm/init.c we have:

unsigned int __VMALLOC_RESERVE = 128 << 20;

but alas without an EXPORT_SYMBOL() so it's not visible to modules. The old
definition was:

#define __VMALLOC_RESERVE (128 << 20)

Change was introduced with the 'tune-vmalloc-size' patch in -rc2-mm1 that added
the boot-time 'vmalloc=' parameter.

I admit not knowing the memory manager or the NVidia well enough to know what
they *should* be doing instead.....


--==_Exmh_-386619809P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBSzsvcC3lWbTT17ARAsaNAKDudWfXYmf52erboUVcaANkATxw6ACgjqfn
Uy7wSN7t3yURsrdTrroM6zg=
=DtSK
-----END PGP SIGNATURE-----

--==_Exmh_-386619809P--
