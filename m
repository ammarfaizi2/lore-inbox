Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262499AbUEQX4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbUEQX4D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 19:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUEQX4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 19:56:03 -0400
Received: from taco.zianet.com ([216.234.192.159]:40966 "HELO taco.zianet.com")
	by vger.kernel.org with SMTP id S262499AbUEQXws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 19:52:48 -0400
From: Steven Cole <elenstev@mesatop.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s && s->tree' failed: The saga continues.)
Date: Mon, 17 May 2004 17:52:08 -0600
User-Agent: KMail/1.6.1
Cc: mason@suse.com, torvalds@osdl.org, lm@bitmover.com, wli@holomorphy.com,
       hugh@veritas.com, adi@bitmover.com, support@bitmover.com,
       linux-kernel@vger.kernel.org
References: <200405132232.01484.elenstev@mesatop.com> <1084828124.26340.22.camel@spc0.esa.lanl.gov> <20040517142946.571a3e91.akpm@osdl.org>
In-Reply-To: <20040517142946.571a3e91.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_oAVqAxWLQyqgo/C"
Message-Id: <200405171752.08400.elenstev@mesatop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_oAVqAxWLQyqgo/C
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 17 May 2004 03:29 pm, Andrew Morton wrote:
> Steven Cole <elenstev@mesatop.com> wrote:
> >
> > 1) Apply your patch to 2.6.6-current, build with PREEMPT
> > 2) Test bk pull via ppp on reiserfs until and if it breaks.
> > 3) Test bk pull via ppp on ext3 and take a look at the s.ChangeSet file
> > if/when the failure occurs.
> > 4) Apply akpm's patch here:
> > http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D108478018304305&w=3D2
> > 5) Repeat 2,3
>=20
> Nope.  Please just see if this makes the problem go away:
>=20
> --- 25/fs/buffer.c~a	Mon May 17 14:28:51 2004
> +++ 25-akpm/fs/buffer.c	Mon May 17 14:29:02 2004
> @@ -2723,7 +2723,6 @@ int block_write_full_page(struct page *p
>  	 * writes to that region are not written out to the file."
>  	 */
>  	kaddr =3D kmap_atomic(page, KM_USER0);
> -	memset(kaddr + offset, 0, PAGE_CACHE_SIZE - offset);
>  	flush_dcache_page(page);
>  	kunmap_atomic(kaddr, KM_USER0);
>  	return __block_write_full_page(inode, page, get_block, wbc);
>=20
> _
>=20
> If this patch is confirmed to fix things up, then and only then should you
> bother testing the vmtruncate patch.
>=20
> Thanks.
>=20
>=20
OK, applied your one-liner above with PREEMPT.

Pull bk://linux.bkbits.net/linux-2.5
=A0 -> file://home/steven/BK/save-2.6
=2D--------------------- Receiving the following csets --------------------=
=2D--
1.1727 1.1726 1.1725 1.1626.1.10 1.1626.1.9 1.1626.1.8 1.1626.1.7
1.1612.11.1 1.1371.746.12 1.1371.746.11 1.1371.746.10 1.1371.746.9
1.1371.746.8 1.1371.746.7 1.1371.746.6 1.1371.746.5 1.1371.746.4
1.1371.746.3 1.1371.746.2 1.1371.746.1
=2D------------------------------------------------------------------------=
=2D--
ChangeSet: 20 deltas
[snipped list of files]
=2D------------------------------------------------------------------------=
=2D-
takepatch: saved entire patch in PENDING/2004-05-17.01
=2D------------------------------------------------------------------------=
=2D-
Applying =A020 revisions to ChangeSet renumber: can't read SCCS info in "RE=
SYNC/SCCS/s.ChangeSet" =A0 =A0 =A0 .
bk: takepatch.c:1343: applyCsetPatch: Assertion `s && s->tree' failed.
11760 bytes uncompressed to 57721, 4.91X expansion
[steven@spc save-2.6]$ exit
Script done, file is test1
[steven@spc save-2.6]$ saga <RESYNC/SCCS/s.ChangeSet
=46ound null start 0xfb259a end 0xfb3000 len 0xa66 line 478846

The above was on reiserfs and happened on the very first pull.

Attaching the source of saga.c for reference.

So, what next doc? =A0Back out that one-liner and try your vmtruncate?
Or try Chris' patch for reiserfs?

At the moment I'm testing on ext3, which survived the two pull/unpulls. =A0
This is like watching paint dry.

I'll do some more bk unpull and bk pull cycles until this breaks on ext3.

Steven

--Boundary-00=_oAVqAxWLQyqgo/C
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="saga.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="saga.c"

#include <stdio.h>
main()
{
	int	c, where = -1, line = 0;
	int	start;
	int	null = 0;

	while ((c = getchar()) != EOF) {
		where++;
		if (c == '\n') line++;
		if (c && null) {
			fprintf(stderr,
			    "Found null start 0x%x end 0x%x len 0x%x line %d\n",
			    start, where, where - start, line);
		}
		if (c) {null = 0; continue;}
		if (null) continue;
		start = where;
		null = 1;
	}
}

--Boundary-00=_oAVqAxWLQyqgo/C--
