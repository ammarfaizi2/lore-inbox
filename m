Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261455AbSIZTYX>; Thu, 26 Sep 2002 15:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261456AbSIZTYX>; Thu, 26 Sep 2002 15:24:23 -0400
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:13116 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S261455AbSIZTYV>;
	Thu, 26 Sep 2002 15:24:21 -0400
Date: Thu, 26 Sep 2002 21:29:32 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: mingo@redhat.com, davem@redhat.com, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] gfp_t
Message-ID: <20020926192931.GB1892@jaquet.dk>
References: <20020926044401.9C60D2C3CC@lists.samba.org> <20020926185924.GA1892@jaquet.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline
In-Reply-To: <20020926185924.GA1892@jaquet.dk>
User-Agent: Mutt/1.3.28i
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2002 at 08:59:24PM +0200, Rasmus Andersen wrote:
> On Thu, Sep 26, 2002 at 02:35:30PM +1000, Rusty Russell wrote:
> > This creates a mythical gfp_t for passing gfp states, and conversion
> > macros __GFP() and __UNGFP(), to give warnings, It's 55k, so
> > compressed and attached.
>=20
> This breaks ntfs/malloc.h which is doing the following:
> 49:       return __vmalloc(size, GFP_NOFS | __GFP_HIGHMEM, PAGE_KERNEL);
[...]

After having had a bit more caffeine, I guess I would like to
change my previous mail to: These two patches for mm/numa.c and
ntfs/malloc.h needs to be in your patchset as well.

--- linux-2.5.38/mm/numa.c	Sun Sep 22 06:25:17 2002
+++ /home/rasmus/transport/linux-2.5.38/mm/numa.c	Thu Sep 26 21:18:59 2002
@@ -42,10 +42,10 @@
=20
 #endif /* !CONFIG_DISCONTIGMEM */
=20
-struct page * alloc_pages_node(int nid, unsigned int gfp_mask, unsigned in=
t order)
+struct page * alloc_pages_node(int nid, gfp_t gfp_mask, unsigned int order)
 {
 #ifdef CONFIG_NUMA
-	return __alloc_pages(gfp_mask, order, NODE_DATA(nid)->node_zonelists + (g=
fp_mask & GFP_ZONEMASK));
+	return __alloc_pages(gfp_mask, order, NODE_DATA(nid)->node_zonelists + (_=
_UNGFP(gfp_mask) & GFP_ZONEMASK));
 #else
 	return alloc_pages(gfp_mask, order);
 #endif


--- linux-2.5.38/fs/ntfs/malloc.h	Sun Sep 22 06:25:01 2002
+++ /home/rasmus/transport/linux-2.5.38/fs/ntfs/malloc.h	Thu Sep 26 21:15:5=
5 2002
@@ -46,7 +46,7 @@
 		BUG();
 	}
 	if (likely(size >> PAGE_SHIFT < num_physpages))
-		return __vmalloc(size, GFP_NOFS | __GFP_HIGHMEM, PAGE_KERNEL);
+		return __vmalloc(size, gfp_sub(GFP_NOFS, __GFP_HIGHMEM), PAGE_KERNEL);
 	return NULL;
 }
=20

Regards,
  Rasmus

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9k2AblZJASZ6eJs4RAjLiAJwPxgN4eEklGgFTpf1lMkkXil7DlQCfdUX7
Lp82mmDNQstCONGsfHB4XcM=
=AAsX
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
