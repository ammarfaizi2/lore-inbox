Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbTKYQZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 11:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbTKYQZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 11:25:58 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:30434 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S261838AbTKYQZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 11:25:51 -0500
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Jes Sorensen <jes@wildopensource.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: hash table sizes
Date: Tue, 25 Nov 2003 17:25:07 +0100
User-Agent: KMail/1.5.9
Cc: Alexander Viro <viro@math.psu.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, jbarnes@sgi.com, steiner@sgi.com
References: <16323.23221.835676.999857@gargle.gargle.HOWL> <20031125134222.GA8039@holomorphy.com> <yq0fzgcimf8.fsf@wildopensource.com>
In-Reply-To: <yq0fzgcimf8.fsf@wildopensource.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_jJ4w/peI6DM2tz1";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200311251725.07573.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_jJ4w/peI6DM2tz1
Content-Type: multipart/mixed;
  boundary="Boundary-01=_jJ4w/p+2O53PTCz"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_jJ4w/p+2O53PTCz
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Jens,

I was wondering about you funny formula, too. (especially because it was 23=
 -=20
(PAGE_SHIFT -1) and not 24 - PAGE_SHIFT ;-) So I wanted to find out why thi=
s:
1:	mempages >>=3D (23 - (PAGE_SHIFT - 1));
2:	order =3D max(2, fls(mempages));
3:	order =3D min(12, order);

should be similar to this original code:
4:	mempages >>=3D (14 - PAGE_SHIFT);
5:	mempages *=3D sizeof(struct hlist_head);
6:	for (order =3D 0; ((1UL << order) << PAGE_SHIFT) < mempages; order++)
7:		;

Well, first I saw that lines 2 and 3 make order to be between 2 and 12. OK=
=20
this is new, and I like it ;-) Then I saw you tried to convert the ugly lin=
es=20
6 + 7 into a fls() call. Fine! (I like that, too) Line 6 + 7 can be convert=
ed=20
to following (almost equivalent) lines:
6 + 7	-> 8a:	order =3D fls(mempages) - PAGE_SHIFT;
or
6 + 7	-> 8b:	order =3D fls(mempages >> PAGE_SHIFT);

Now the shift is not present in line 2, so I folded it from line 8b into li=
ne=20
4 and got:
4	-> 9:	mempages >>=3D 14;
5:		mempages *=3D sizeof(struct hlist_head);
8b	-> 10:	order =3D fls(mempages);

But to make the math a bit more correct the multiplication from line 5 has =
to=20
be done before the shift in line 9. So I got following simple two lines=20
equivalent to lines 4 to 7:
5 + 9	-> 11:	mempages =3D (mempages * sizeof(struct hlist_head)) >> 14;
10:		order =3D fls(mempages);

So, now we can compare line 1 and 11. OK, let's assume PAGE_SHIFT =3D 12. S=
o we=20
get:
1	-> 12:	mempages >>=3D (23 - (12 - 1)); // right shift by 12

If sizeof(struct hlist_head) =3D=3D 4, we get for line 10:
11	-> 13:	mempages =3D (mempages * 4) >> 14; // right shift by 12

And HURRAY, we've got it...!
But they are only equivalent if (PAGE_SHIFT =3D=3D 12) && (sizeof(struct=20
hlist_head) =3D=3D 4)...

So I propose the attached patch which should be closer to the original and=
=20
makes order not to be greater than 12. (Btw. this only changes anything for=
=20
more than 2^24 pages of memory, so I think this is a good idea!)

Best reagrds
   Thomas Schlichter

On Tuesday 25 November 2003 14:54, Jes Sorensen wrote:
> >>>>> "William" =3D=3D William Lee Irwin <wli@holomorphy.com> writes:
>
> William> On Tue, Nov 25, 2003 at 08:35:49AM -0500, Jes Sorensen wrote:
> >> + mempages >>=3D (23 - (PAGE_SHIFT - 1)); + order =3D max(2,
> >> fls(mempages)); + order =3D min(12, order);
>
> William> This is curious; what's 23 - (PAGE_SHIFT - 1) supposed to
> William> represent?
>
> Well MB >> 2 or consider it trial and error ;-)
>
> Cheers,
> Jes

--Boundary-01=_jJ4w/p+2O53PTCz
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="hash_sizes.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="hash_sizes.diff"

=2D-- linux-2.6.0-test9-mm5/fs/dcache.c.orig	Tue Nov 25 15:29:38 2003
+++ linux-2.6.0-test9-mm5/fs/dcache.c	Tue Nov 25 16:18:37 2003
@@ -1530,9 +1530,8 @@
 static void __init dcache_init(unsigned long mempages)
 {
 	struct hlist_head *d;
=2D	unsigned long order;
 	unsigned int nr_hash;
=2D	int i;
+	int i, order;
=20
 	/*=20
 	 * A constructor could be added for stable state like the lists,
@@ -1552,12 +1551,10 @@
 =09
 	set_shrinker(DEFAULT_SEEKS, shrink_dcache_memory);
=20
=2D#if PAGE_SHIFT < 13
=2D	mempages >>=3D (13 - PAGE_SHIFT);
=2D#endif
=2D	mempages *=3D sizeof(struct hlist_head);
=2D	for (order =3D 0; ((1UL << order) << PAGE_SHIFT) < mempages; order++)
=2D		;
+	mempages =3D (mempages * sizeof(struct hlist_head)) >> 13;
+	order =3D fls(mempages);
+	if (order > 12)
+		order =3D 12;
=20
 	do {
 		unsigned long tmp;
@@ -1575,7 +1572,7 @@
 			__get_free_pages(GFP_ATOMIC, order);
 	} while (dentry_hashtable =3D=3D NULL && --order >=3D 0);
=20
=2D	printk(KERN_INFO "Dentry cache hash table entries: %d (order: %ld, %ld =
bytes)\n",
+	printk(KERN_INFO "Dentry cache hash table entries: %d (order: %d, %ld byt=
es)\n",
 			nr_hash, order, (PAGE_SIZE << order));
=20
 	if (!dentry_hashtable)
=2D-- linux-2.6.0-test9-mm5/fs/inode.c.orig	Tue Nov 25 15:33:22 2003
+++ linux-2.6.0-test9-mm5/fs/inode.c	Tue Nov 25 16:17:38 2003
@@ -1319,17 +1319,16 @@
 void __init inode_init(unsigned long mempages)
 {
 	struct hlist_head *head;
=2D	unsigned long order;
 	unsigned int nr_hash;
=2D	int i;
+	int i, order;
=20
 	for (i =3D 0; i < ARRAY_SIZE(i_wait_queue_heads); i++)
 		init_waitqueue_head(&i_wait_queue_heads[i].wqh);
=20
=2D	mempages >>=3D (14 - PAGE_SHIFT);
=2D	mempages *=3D sizeof(struct hlist_head);
=2D	for (order =3D 0; ((1UL << order) << PAGE_SHIFT) < mempages; order++)
=2D		;
+	mempages =3D (mempages * sizeof(struct hlist_head)) >> 14;
+	order =3D fls(mempages);
+	if (order > 12)
+		order =3D 12;
=20
 	do {
 		unsigned long tmp;
@@ -1347,7 +1346,7 @@
 			__get_free_pages(GFP_ATOMIC, order);
 	} while (inode_hashtable =3D=3D NULL && --order >=3D 0);
=20
=2D	printk("Inode-cache hash table entries: %d (order: %ld, %ld bytes)\n",
+	printk("Inode-cache hash table entries: %d (order: %d, %ld bytes)\n",
 			nr_hash, order, (PAGE_SIZE << order));
=20
 	if (!inode_hashtable)

--Boundary-01=_jJ4w/p+2O53PTCz--

--Boundary-03=_jJ4w/peI6DM2tz1
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/w4JjYAiN+WRIZzQRAiw7AJ0c//zZXzuI+Cq/uskksb0C89MPYwCgxJdV
fS+Stlc7sd5sTzO3zohLCso=
=+WmE
-----END PGP SIGNATURE-----

--Boundary-03=_jJ4w/peI6DM2tz1--
