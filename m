Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264337AbTDKLka (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 07:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264335AbTDKLka (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 07:40:30 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:56457 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S264337AbTDKLk2 (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 07:40:28 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [RFC] first try for swap prefetch
Date: Fri, 11 Apr 2003 13:51:55 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200304101948.12423.schlicht@uni-mannheim.de> <20030410161826.04332890.akpm@digeo.com>
In-Reply-To: <20030410161826.04332890.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_lxql+uCWAVoDSCv";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200304111352.05774.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_lxql+uCWAVoDSCv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

On April 11, Andrew Morton wrote:
> Thomas Schlichter <schlicht@uni-mannheim.de> wrote:
> > Hi,
> >
> > as mentioned a few days ago I was going to try to implement a swap
> > prefetch to better utilize the free memory. Now here is my first try.
>
> That's surprisingly cute.  Does it actually do anything noticeable?

Well, it fills free pagecache memory with swapped pages... ;-)

But at the moment I can not 'feel' any real improvement... :-(
I think the problem is that R/O pages are not written to swap space and so =
not=20
prefetched with my patch. But I will look after it...

> +	swapped_entry =3D kmalloc(sizeof(*swapped_entry), GFP_ATOMIC);
>
> These guys will need a slab cache (not SLAB_HW_CACHE_ALIGNED) to save
> space.

OK, I'll do it.

> +	swapped_entry =3D radix_tree_lookup(&swapped_root.tree, entry.val);
> +	if(swapped_entry) {
> +		list_del(&swapped_entry->list);
> +		radix_tree_delete(&swapped_root.tree, entry.val);
>
> you can just do
>
> 	if (radix_tree_delete(...) !=3D -ENOENT)
> 		list_del(...)
>
> +		read_swap_cache_async(entry);

Sorry, but I think I can not. The list_del() needs the value returned by=20
radix_tree_lookup(), so I can not kick it... By the way, the only reason fo=
r=20
the radix tree is to make this list_del() not O(n) for searching the list..=
=2E=20
Do you know how expensive the radix_tree_lookup() is? O(1) or O(log(n))?? F=
or=20
my shame I do not really know that data structure... :-(

> What you want here is a way of telling if the disk(s) which back the swap
> are idle.  We used to have that, but Hugh deleted it.  It can be put back,
> but it's probably better to put a `last_read_request_time' and
> `last_write_request_time' into struct backing_dev_info.  If nobody has us=
ed
> the disk in the past N milliseconds, then start the speculative swapin.

That's good. I was looking for anything like that but didn't find anything=
=20
fitting in the current sources...

> It might make sense to poke the speculative swapin code in the page-freei=
ng
> path too.

I wanted to do this but don't know which function is the correct one for th=
is.=20
But I will search harder... or can you give me a hint?

> And to put the speculatively-swapped-in pages at the tail of the inactive
> list (perhaps).

This may be a good idea...

> But first-up, some demonstrated goodness is needed...

Yup, but currently it improves nothing very much, as stated above, I think=
=20
first I should implement the R/O pages thing and investigete which part of=
=20
the kernel works against my code and frees some pages after I just filled=20
them...

Thank you for helping me with your comments!

Best regards
   Thomas
--Boundary-02=_lxql+uCWAVoDSCv
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+lqxlYAiN+WRIZzQRAkfvAKDa2Z7BLnLTbldH2mvtoa29LSmsmwCgqlV+
ZzmMx+E6ykJVVCgdYOvVNxI=
=4RLG
-----END PGP SIGNATURE-----

--Boundary-02=_lxql+uCWAVoDSCv--

