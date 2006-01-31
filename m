Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWAaPNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWAaPNU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 10:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbWAaPNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 10:13:20 -0500
Received: from ns2.suse.de ([195.135.220.15]:11433 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750926AbWAaPNT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 10:13:19 -0500
Date: Tue, 31 Jan 2006 16:13:17 +0100
From: Kurt Garloff <garloff@suse.de>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] OOM kill: children accounting
Message-ID: <20060131151317.GD9188@tpkurt.wlan.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="19uQFt6ulqmgNgg1"
Content-Disposition: inline
X-Operating-System: Linux 2.6.16-rc1-git3-5-xen i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E
Organization: SUSE/Novell
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--19uQFt6ulqmgNgg1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

in the badness() calculation, there's currently this piece of code:

        /*
         * Processes which fork a lot of child processes are likely
         * a good choice. We add the vmsize of the children if they
         * have an own mm. This prevents forking servers to flood the
         * machine with an endless amount of children
         */
        list_for_each(tsk, &p->children) {
                struct task_struct *chld;
                chld =3D list_entry(tsk, struct task_struct, sibling);
                if (chld->mm !=3D p->mm && chld->mm)
                        points +=3D chld->mm->total_vm;
        }


The intention is clear: If some server (apache) keeps spawning new=20
children and we run OOM, we want to kill the father rather than=20
picking a child.
This -- to some degree -- also helps a bit with getting fork bombs
under control, though I'd consider this a desirable side-effect
rather than a feature.

There's one problem with this:=20
No matter how many or few children there are, if just one of them
misbehaves, and all others (including the father) do everything right,
we still always kill the whole family. This hits in real life; whether
it's javascript in konqueror resulting in kdeinit (and thus the whole
KDE session) being hit or just a classical server that spawns children.

Sidenote: The killer does kill all direct children as well, not only
the selected father, see oom_kill_process().

The idea in attached patch is that we do want to account the memory
consumption of the (direct) children to the father -- however not fully.
This maintains the property that fathers with too many children will
still very likely be picked, whereas a single misbehaving child has
the chance to be picked by the OOM killer.

In the patch I account only half (rounded up) of the children's vm_size
to the parent. This means that if one child eats more mem than the
rest of the family, it will be picked, otherwise it's still the father
and thus the whole family that gets selected.

This is heuristics -- we could debate whether accounting for a fourth
would be better than for half of it. Or -- if people would consider it
worth the trouble -- make it a sysctl. For now I sticked to accounting
for half, which should IMHO be a significant improvement.

The patch does one more thing: As users tend to be irritated by the
choice of killed processes (mainly because the children are killed
first, despite some of them having a very low OOM score), I added
some more output: The selected (father) process will be reported first
and it's oom_score printed to syslog.

Patch is against current 2.6.16-git.


=46rom: Kurt Garloff <garloff@suse.de>
Subject: Only account for half of children's vm size in oom score calculati=
on

This should still give the parent enough point in case of fork bombs.
If any child however has more than 50% of the vm size of all children
together, it'll get a higher score and be elected.

This patch also makes the kernel display the oom_score.

Signed-off-by: Kurt Garloff <garloff@suse.de>

--- linux-2.6-hg/mm/oom_kill.c.orig	2006-01-26 17:43:35.000000000 +0100
+++ linux-2.6-hg/mm/oom_kill.c	2006-01-27 17:04:40.000000000 +0100
@@ -58,15 +58,17 @@ unsigned long badness(struct task_struct
=20
 	/*
 	 * Processes which fork a lot of child processes are likely
-	 * a good choice. We add the vmsize of the children if they
+	 * a good choice. We add half the vmsize of the children if they
 	 * have an own mm. This prevents forking servers to flood the
-	 * machine with an endless amount of children
+	 * machine with an endless amount of children. In case a single
+	 * child is eating the vast majority of memory, adding only half
+	 * to the parents will make the child our kill candidate of choice.
 	 */
 	list_for_each(tsk, &p->children) {
 		struct task_struct *chld;
 		chld =3D list_entry(tsk, struct task_struct, sibling);
 		if (chld->mm !=3D p->mm && chld->mm)
-			points +=3D chld->mm->total_vm;
+			points +=3D chld->mm->total_vm/2 + 1;
 	}
=20
 	/*
@@ -136,12 +138,12 @@ unsigned long badness(struct task_struct
  *
  * (not docbooked, we don't want this one cluttering up the manual)
  */
-static struct task_struct * select_bad_process(void)
+static struct task_struct * select_bad_process(unsigned long *ppoints)
 {
-	unsigned long maxpoints =3D 0;
 	struct task_struct *g, *p;
 	struct task_struct *chosen =3D NULL;
 	struct timespec uptime;
+	*ppoints =3D 0;
=20
 	do_posix_clock_monotonic_gettime(&uptime);
 	do_each_thread(g, p) {
@@ -169,9 +171,9 @@ static struct task_struct * select_bad_p
 			return p;
=20
 		points =3D badness(p, uptime.tv_sec);
-		if (points > maxpoints || !chosen) {
+		if (points > *ppoints || !chosen) {
 			chosen =3D p;
-			maxpoints =3D points;
+			*ppoints =3D points;
 		}
 	} while_each_thread(g, p);
 	return chosen;
@@ -237,12 +239,15 @@ static struct mm_struct *oom_kill_task(t
 	return mm;
 }
=20
-static struct mm_struct *oom_kill_process(struct task_struct *p)
+static struct mm_struct *oom_kill_process(struct task_struct *p,
+					  unsigned long points)
 {
  	struct mm_struct *mm;
 	struct task_struct *c;
 	struct list_head *tsk;
-
+=09
+	printk(KERN_ERR "Out of Memory: Kill process %d (%s) score %li and childr=
en.\n",
+		p->pid, p->comm, points);
 	/* Try to kill a child first */
 	list_for_each(tsk, &p->children) {
 		c =3D list_entry(tsk, struct task_struct, sibling);
@@ -267,6 +272,7 @@ void out_of_memory(gfp_t gfp_mask, int o
 {
 	struct mm_struct *mm =3D NULL;
 	task_t * p;
+	unsigned long points;
=20
 	if (printk_ratelimit()) {
 		printk("oom-killer: gfp_mask=3D0x%x, order=3D%d\n",
@@ -277,7 +283,7 @@ void out_of_memory(gfp_t gfp_mask, int o
 	cpuset_lock();
 	read_lock(&tasklist_lock);
 retry:
-	p =3D select_bad_process();
+	p =3D select_bad_process(&points);
=20
 	if (PTR_ERR(p) =3D=3D -1UL)
 		goto out;
@@ -289,7 +295,7 @@ retry:
 		panic("Out of memory and no killable processes...\n");
 	}
=20
-	mm =3D oom_kill_process(p);
+	mm =3D oom_kill_process(p, points);
 	if (!mm)
 		goto retry;
=20

--=20
Kurt Garloff

--19uQFt6ulqmgNgg1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD336NxmLh6hyYd04RAvNwAKCRZ/6hkUkTXEDB39woKdf5xD/yAwCeNf89
2DF9ebGXbGhXfgpOG8Boj9Y=
=HOGW
-----END PGP SIGNATURE-----

--19uQFt6ulqmgNgg1--
