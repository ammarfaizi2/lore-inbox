Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266721AbUIEO10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266721AbUIEO10 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 10:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266725AbUIEO1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 10:27:25 -0400
Received: from reptilian.maxnet.nu ([212.209.142.131]:52234 "EHLO
	reptilian.maxnet.nu") by vger.kernel.org with ESMTP id S266721AbUIEO1M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 10:27:12 -0400
From: Thomas Habets <thomas@habets.pp.se>
To: linux-kernel@vger.kernel.org
Subject: trivial dup_mmap() bug?
Date: Sun, 5 Sep 2004 16:26:05 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Message-Id: <200409051626.11701.thomas@habets.pp.se>
Content-Type: multipart/signed;
  boundary="nextPart12313465.zK2upBlNjN";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart12313465.zK2upBlNjN
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


=46rom what I see, dup_mmap() is supposed to copy from its parameter oldmm =
into=20
the other parameter mm, but it seems it copies from current->mm into mm.=20
oldmm is only used for locking.

This doesn't matter in current usage of the code since dup_mmap() is=20
only called with oldmm=3D=3Dcurrent->mm, but it still looks wrong to me. If=
 it's=20
supposed to be that way I'd would like to know why.

Here's a patch. Which should be correct. (it compiles with no errors? ship =
it)



=2D-- kernel/fork.c.orig 2004-09-05 12:56:43.000000000 +0200
+++ kernel/fork.c      2004-09-05 16:15:06.000000000 +0200
@@ -275,7 +275,7 @@
        struct mempolicy *pol;
=20
        down_write(&oldmm->mmap_sem);
=2D       flush_cache_mm(current->mm);
+       flush_cache_mm(oldmm);
        mm->locked_vm =3D 0;
        mm->mmap =3D NULL;
        mm->mmap_cache =3D NULL;
@@ -295,11 +295,11 @@
         * Add it first so that swapoff can see any swap entries.
         */
        spin_lock(&mmlist_lock);
=2D       list_add(&mm->mmlist, &current->mm->mmlist);
+       list_add(&mm->mmlist, &oldmm->mmlist);
        mmlist_nr++;
        spin_unlock(&mmlist_lock);
=20
=2D       for (mpnt =3D current->mm->mmap ; mpnt ; mpnt =3D mpnt->vm_next) {
+       for (mpnt =3D oldmm->mmap ; mpnt ; mpnt =3D mpnt->vm_next) {
                struct file *file;
=20
                if(mpnt->vm_flags & VM_DONTCOPY)
@@ -354,7 +354,7 @@
                rb_parent =3D &tmp->vm_rb;
=20
                mm->map_count++;
=2D               retval =3D copy_page_range(mm, current->mm, tmp);
+               retval =3D copy_page_range(mm, oldmm, tmp);
                spin_unlock(&mm->page_table_lock);
=20
                if (tmp->vm_ops && tmp->vm_ops->open)
@@ -366,7 +366,7 @@
        retval =3D 0;
=20
 out:
=2D       flush_tlb_mm(current->mm);
+       flush_tlb_mm(oldmm);
        up_write(&oldmm->mmap_sem);
        return retval;
 fail_nomem_policy:

=2D--------
typedef struct me_s {
  char name[]      =3D { "Thomas Habets" };
  char email[]     =3D { "thomas@habets.pp.se" };
  char kernel[]    =3D { "Linux" };
  char *pgpKey[]   =3D { "http://www.habets.pp.se/pubkey.txt" };
  char pgp[] =3D { "A8A3 D1DD 4AE0 8467 7FDE  0945 286A E90A AD48 E854" };
  char coolcmd[]   =3D { "echo '. ./_&. ./_'>_;. ./_" };
} me_t;

--nextPart12313465.zK2upBlNjN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBOyIDKGrpCq1I6FQRAp4CAKDacQy33WLNxTbtKLNHCVtOJbhAEQCfdWT/
tBI0ML2t7Id4U062Jf69hxE=
=0SAa
-----END PGP SIGNATURE-----

--nextPart12313465.zK2upBlNjN--
