Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbTDLExv (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 00:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbTDLExv (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 00:53:51 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:54731 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S263152AbTDLExt (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 00:53:49 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [RFC] first try for swap prefetch
Date: Sat, 12 Apr 2003 07:05:05 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200304101948.12423.schlicht@uni-mannheim.de> <200304111352.05774.schlicht@uni-mannheim.de> <20030411143932.6bd0b08a.akpm@digeo.com>
In-Reply-To: <20030411143932.6bd0b08a.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_V65l+492lQP+UWT";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200304120705.26408.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_V65l+492lQP+UWT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

On April 1, Andrew Morton wrote:
> Thomas Schlichter <schlicht@uni-mannheim.de> wrote:
> > > you can just do
> > >
> > > 	if (radix_tree_delete(...) !=3D -ENOENT)
> > > 		list_del(...)
> > >
> > > +		read_swap_cache_async(entry);
> >
> > Sorry, but I think I can not. The list_del() needs the value returned by
> > radix_tree_lookup(), so I can not kick it...
>
> OK, I'll change radix_tree_delete() to return the deleted object address =
if
> it was found, else NULL.  That's a better API.

That's right, I like it better that way, too!
Thank you for the patch!

> > Do you know how expensive the radix_tree_lookup() is? O(1) or O(log(n))=
??
> > For my shame I do not really know that data structure... :-(
>
> It is proportional to
>
> 	log_base_64(largest index which the tree has ever stored)
>
> log_base_64: because each node has 64 slots.  Each time maxindex grows by=
 a
> factor of 64 we need to introduce a new level.
>
> "largest index ever": because we do not (and cannot feasibly) reduce the
> height when items are removed.

Thanks for the detailed answer.

> > > It might make sense to poke the speculative swapin code in the
> > > page-freeing path too.
> >
> > I wanted to do this but don't know which function is the correct one for
> > this. But I will search harder... or can you give me a hint?
>
> free_pages_bulk() would probably suit.

I don't think so, as this is part of the buddy allocator which controls the=
=20
usage of the physical memory. Now I've implemented following:

1. Add an entry when a page is removed by the kswapd.
2. Remove the entry when the page is added to the page_cache.
3. Remove the entry when the page is removed from the page_cache.

So with point 3 I cover the freeing of the pages. But as the kswapd calls t=
he=20
function from 3, too, I do the 1st point after kswapd did do point3...

To finish my second (and surely better) try I just need one more=20
information...

How can I get the file pointer for a buffered page with the information=20
available in the kswapd (minly the page struct)??

This is very importand because, as described above, I extract the needed=20
information for my prefetch daemon in the kswapd. My daemon needs the file=
=20
pointer to be able to load the buffer pages with the page_cache_read()=20
function from the mm/filemap.c file.

I'm sorry if I bother you...

Best regards
   Thomas
--Boundary-02=_V65l+492lQP+UWT
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+l56VYAiN+WRIZzQRAvguAKDKgT367ETwCOvTvme6EdVvMi6WZgCgtUYX
bHaseUH9L3x/T4qnFE+rwuw=
=aBOj
-----END PGP SIGNATURE-----

--Boundary-02=_V65l+492lQP+UWT--

