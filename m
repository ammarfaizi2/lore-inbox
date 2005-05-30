Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVE3Qbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVE3Qbj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 12:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbVE3Qbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 12:31:39 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:16133 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261640AbVE3Qba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 12:31:30 -0400
Message-Id: <200505301631.j4UGV8tK011951@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Andy Whitcroft <apw@shadowen.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5-mm1 - missing #define SECTIONS_SHIFT in sparsemem 
In-Reply-To: Your message of "Mon, 30 May 2005 00:27:19 BST."
             <429A4FD7.5040600@shadowen.org> 
From: Valdis.Kletnieks@vt.edu
References: <200505282238.j4SMcYdN014990@turing-police.cc.vt.edu>
            <429A4FD7.5040600@shadowen.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1117470668_10514P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 30 May 2005 12:31:08 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1117470668_10514P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <11942.1117470665.1@turing-police.cc.vt.edu>

On Mon, 30 May 2005 00:27:19 BST, Andy Whitcroft said:
> Valdis.Kletnieks@vt.edu wrote:
> > sparsemem-memory-model.patch references SECTIONS_SHIFT without defining it.
> > 
> > Caught this while compiling with -Wundef, causes lots of warnings
> > when it gets used in include/linux/mm.h.  The appended patch Works For Me,
> > although I wonder if the *real* problem isn't a missing '#ifdef CONFIG_SPARSEMEM'
> > around the code that uses it in mm.h.  
> >  
> > Signed-Off-By: valdis.kletnieks@vt.edu
> > 
> > --- linux-2.6.12-rc5-mm1/include/linux/mmzone.h.ifdef	2005-05-27 15:1
2:26.000000000 -0400
> > +++ linux-2.6.12-rc5-mm1/include/linux/mmzone.h	2005-05-27 16:26:40.000
000000 -0400
> > @@ -568,6 +568,7 @@ static inline int pfn_valid(unsigned lon
> >  void sparse_init(void);
> >  #else
> >  #define sparse_init()	do {} while (0)
> > +#define SECTIONS_SHIFT	0
> >  #endif /* CONFIG_SPARSEMEM */
> >  
> >  #ifdef CONFIG_NODES_SPAN_OTHER_NODES
> 
> Odd.  I guess there must be a reference from an unused function to this
> define when SPARSEMEM is off.  Can you send me your .config please and
> I'll have a look.

The warning comes out of *every* kernel module that #includes kernel/mm.h
and reaches line 424:

 #if SECTIONS_SHIFT+NODES_SHIFT+ZONES_SHIFT <= FLAGS_RESERVED
 #define NODES_WIDTH             NODES_SHIFT
 #else
 #define NODES_WIDTH             0
 #endif

That's not wrapped in a #ifdef CONFIG_DISCONTIGMEM or SPARSEMEN or HIGHMEM or
any of the other obvious candidates.  You only see the warning if you add
-Wundef to your CFLAGS.

I'll send the .config privately in a separate message. Pretty standard stock
defaults for a laptop with only 256M of memory. The quick quick
synopsis for the rest of you:

[/usr/src/linux-2.6.12-rc5-mm1]2 grep MEM .config
CONFIG_SHMEM=y
# CONFIG_TINY_SHMEM is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_SND_DEBUG_MEMORY=y



--==_Exmh_1117470668_10514P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCmz/McC3lWbTT17ARAsRsAKCxZPtz2K34mgcZQrKlKVUmJARyRACgzaBu
nQerNeu7nYrwvfi5hQIkKTM=
=3IQa
-----END PGP SIGNATURE-----

--==_Exmh_1117470668_10514P--
