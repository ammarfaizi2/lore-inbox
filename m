Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263395AbVHFSch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263395AbVHFSch (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 14:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263397AbVHFSce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 14:32:34 -0400
Received: from imap.gmx.net ([213.165.64.20]:35460 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263395AbVHFScc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 14:32:32 -0400
X-Authenticated: #1700068
From: Torsten Foertsch <torsten.foertsch@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Problem with smaps in 2.6.13-rc4-mm1
Date: Sat, 6 Aug 2005 20:29:49 +0200
User-Agent: KMail/1.7.1
References: <200508060915.28277.torsten.foertsch@gmx.net>
In-Reply-To: <200508060915.28277.torsten.foertsch@gmx.net>
Cc: Mauricio Lin <mauriciolin@gmail.com>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart187234337.1eqtHDluMX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508062029.55699.torsten.foertsch@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart187234337.1eqtHDluMX
Content-Type: multipart/mixed;
  boundary="Boundary-01=_eGQ9C6rYQanurGC"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_eGQ9C6rYQanurGC
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 06 August 2005 09:15, Torsten Foertsch wrote:
> when trying out smaps I have encountered the following problem:
> > cat /proc/$P/smaps | diff - /proc/$P/smaps
>
> 239,241c239,241
> < bfbaf000-bfbc4000 rw-p bfbaf000 00:00 0          [stack]
> < Size:                84 kB
> < Rss:                 24 kB
> ---
>
> > b7fc4000-b7fc6000 rwxp 00015000 08:02 12558      /lib/ld-2.3.4.so
> > Size:                 8 kB
> > Rss:                  8 kB
>
> 245c245
> < Private_Dirty:       24 kB
> ---
>
> > Private_Dirty:        8 kB

The problem occures because show_smap calls first show_map and then prints =
its=20
additional information to the seq_file. show_map checks if all it has to=20
print fits into the buffer and if yes marks the current vma as written. Whi=
le=20
that is correct for show_map it is not for show_smap. Here the vma should b=
e=20
marked as written only after the additional information is also written.

The attached patch cures the problem. It moves the functionality of the=20
show_map function to a new function show_map_internal that is called with a=
n=20
additional struct mem_size_stats* argument. Then show_map calls=20
show_map_internal with NULL as struct mem_size_stats* whereas show_smap cal=
ls=20
it with a real pointer. Now the final

	if (m->count < m->size)  /* vma is copied successfully */
		m->version =3D (vma !=3D get_gate_vma(task))? vma->vm_start: 0;

is done only if the whole entry fits into the buffer.

Torsten

--Boundary-01=_eGQ9C6rYQanurGC
Content-Type: text/x-diff;
  charset="utf-8";
  name="show_map_internal.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="show_map_internal.patch"

=2D-- linux-2.6.13-rc4-mm1/fs/proc/task_mmu.c~	2005-08-03 12:48:35.00000000=
0 +0200
+++ linux-2.6.13-rc4-mm1/fs/proc/task_mmu.c	2005-08-06 18:43:11.160005664 +=
0200
@@ -92,7 +92,16 @@
 	seq_printf(m, "%*c", len, ' ');
 }
=20
=2Dstatic int show_map(struct seq_file *m, void *v)
+struct mem_size_stats
+{
+	unsigned long resident;
+	unsigned long shared_clean;
+	unsigned long shared_dirty;
+	unsigned long private_clean;
+	unsigned long private_dirty;
+};
+
+static int show_map_internal(struct seq_file *m, void *v, struct mem_size_=
stats *mss)
 {
 	struct task_struct *task =3D m->private;
 	struct vm_area_struct *vma =3D v;
@@ -146,19 +155,31 @@
 		}
 	}
 	seq_putc(m, '\n');
+
+	if (mss)
+		seq_printf(m,
+			   "Size:          %8lu kB\n"
+			   "Rss:           %8lu kB\n"
+			   "Shared_Clean:  %8lu kB\n"
+			   "Shared_Dirty:  %8lu kB\n"
+			   "Private_Clean: %8lu kB\n"
+			   "Private_Dirty: %8lu kB\n",
+			   (vma->vm_end - vma->vm_start) >> 10,
+			   mss->resident >> 10,
+			   mss->shared_clean  >> 10,
+			   mss->shared_dirty  >> 10,
+			   mss->private_clean >> 10,
+			   mss->private_dirty >> 10);
+
 	if (m->count < m->size)  /* vma is copied successfully */
 		m->version =3D (vma !=3D get_gate_vma(task))? vma->vm_start: 0;
 	return 0;
 }
=20
=2Dstruct mem_size_stats
+static int show_map(struct seq_file *m, void *v)
 {
=2D	unsigned long resident;
=2D	unsigned long shared_clean;
=2D	unsigned long shared_dirty;
=2D	unsigned long private_clean;
=2D	unsigned long private_dirty;
=2D};
+	return show_map_internal(m, v, 0);
+}
=20
 static void smaps_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				unsigned long addr, unsigned long end,
@@ -248,33 +269,17 @@
 {
 	struct vm_area_struct *vma =3D v;
 	struct mm_struct *mm =3D vma->vm_mm;
=2D	unsigned long vma_len =3D (vma->vm_end - vma->vm_start);
 	struct mem_size_stats mss;
=20
 	memset(&mss, 0, sizeof mss);
=20
=2D	show_map(m, v);
=2D
 	if (mm) {
 		spin_lock(&mm->page_table_lock);
 		smaps_pgd_range(vma, vma->vm_start, vma->vm_end, &mss);
 		spin_unlock(&mm->page_table_lock);
 	}
=20
=2D	seq_printf(m,
=2D		   "Size:          %8lu kB\n"
=2D		   "Rss:           %8lu kB\n"
=2D		   "Shared_Clean:  %8lu kB\n"
=2D		   "Shared_Dirty:  %8lu kB\n"
=2D		   "Private_Clean: %8lu kB\n"
=2D		   "Private_Dirty: %8lu kB\n",
=2D		   vma_len >> 10,
=2D		   mss.resident >> 10,
=2D		   mss.shared_clean  >> 10,
=2D		   mss.shared_dirty  >> 10,
=2D		   mss.private_clean >> 10,
=2D		   mss.private_dirty >> 10);
=2D	return 0;
+	return show_map_internal(m, v, &mss);
 }
=20
 static void *m_start(struct seq_file *m, loff_t *pos)
@@ -288,7 +293,7 @@
 	/*
 	 * We remember last_addr rather than next_addr to hit with
 	 * mmap_cache most of the time. We have zero last_addr at
=2D	 * the begining and also after lseek. We will have -1 last_addr
+	 * the beginning and also after lseek. We will have -1 last_addr
 	 * after the end of the vmas.
 	 */
=20

--Boundary-01=_eGQ9C6rYQanurGC--

--nextPart187234337.1eqtHDluMX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBC9QGjwicyCTir8T4RAgmEAJ4w6ArjjriiOd9rfauKg/T9AjpPugCbBCVG
EWgzKLHk230QJuzWZqsqAt8=
=In8Z
-----END PGP SIGNATURE-----

--nextPart187234337.1eqtHDluMX--
