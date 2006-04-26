Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWDZAun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWDZAun (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 20:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWDZAun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 20:50:43 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:61872 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932320AbWDZAum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 20:50:42 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] swsusp: support creating bigger images
Date: Wed, 26 Apr 2006 10:49:33 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200604242355.08111.rjw@sisk.pl> <20060425222526.GG6379@elf.ucw.cz> <200604260043.03481.rjw@sisk.pl>
In-Reply-To: <200604260043.03481.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2609063.WIiYFG1Q4G";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604261049.39592.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2609063.WIiYFG1Q4G
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 26 April 2006 08:43, Rafael J. Wysocki wrote:
> Hi,
>
> On Wednesday 26 April 2006 00:25, Pavel Machek wrote:
> > > > It does apply to all of the LRU pages. This is what I've been doing
> > > > for years now. The only corner case I've come across is XFS. It sti=
ll
> > > > wants to write data even when there's nothing to do and it's threads
> > > > are frozen (IIRC - haven't looked at it for a while). I got around
> > > > that by freezing bdevs when freezing processes.
> > >
> > > This means if we freeze bdevs, we'll be able to save all of the LRU
> > > pages, except for the pages mapped by the current task, without
> > > copying.  I think we can try to do this, but we'll need a patch to
> > > freeze bdevs for this purpose. ;-)
> >
> > ...adding more dependencies to how vm/blockdevs work. I'd say current
> > code is complex enough...
>
> Well, why don't we see the patch?  If it's too complex, we can just decide
> not to use it. :-)

In Suspend2, I'm still using a different version of process.c to what you g=
uys=20
have. In my version, I thaw kernelspace, then thaw bdevs, then thaw userspa=
ce.=20
The version below just thaws bdevs after thawing all processes. I think tha=
t=20
might need modification, but thought I'd post this now so you can see how=20
complicated or otherwise it is.

Regards,

Nigel

diff -ruN linux-2.6.17-rc2/kernel/power/process.c bdev-freeze/kernel/power/=
process.c
=2D-- linux-2.6.17-rc2/kernel/power/process.c	2006-04-19 14:27:36.000000000=
 +1000
+++ bdev-freeze/kernel/power/process.c	2006-04-26 10:44:56.000000000 +1000
@@ -19,6 +19,56 @@
  */
 #define TIMEOUT	(20 * HZ)
=20
+struct frozen_fs
+{
+	struct list_head fsb_list;
+	struct super_block *sb;
+};
+
+LIST_HEAD(frozen_fs_list);
+
+void freezer_make_fses_rw(void)
+{
+	struct frozen_fs *fs, *next_fs;
+
+	list_for_each_entry_safe(fs, next_fs, &frozen_fs_list, fsb_list) {
+		thaw_bdev(fs->sb->s_bdev, fs->sb);
+
+		list_del(&fs->fsb_list);
+		kfree(fs);
+	}
+}
+
+/*=20
+ * Done after userspace is frozen, so there should be no danger of
+ * fses being unmounted while we're in here.
+ */
+int freezer_make_fses_ro(void)
+{
+	struct frozen_fs *fs;
+	struct super_block *sb;
+
+	/* Generate the list */
+	list_for_each_entry(sb, &super_blocks, s_list) {
+		if (!sb->s_root || !sb->s_bdev ||
+		    (sb->s_frozen =3D=3D SB_FREEZE_TRANS) ||
+		    (sb->s_flags & MS_RDONLY))
+			continue;
+
+		fs =3D kmalloc(sizeof(struct frozen_fs), GFP_ATOMIC);
+		fs->sb =3D sb;
+		list_add_tail(&fs->fsb_list, &frozen_fs_list);
+	};
+
+	/* Do the freezing in reverse order so filesystems dependant
+	 * upon others are frozen in the right order. (Eg loopback
+	 * on ext3). */
+	list_for_each_entry_reverse(fs, &frozen_fs_list, fsb_list)
+		freeze_bdev(fs->sb->s_bdev);
+
+	return 0;
+}
+
=20
 static inline int freezeable(struct task_struct * p)
 {
@@ -77,6 +127,7 @@
 	printk( "Stopping tasks: " );
 	start_time =3D jiffies;
 	user_frozen =3D 0;
+	bdevs_frozen =3D 0;
 	do {
 		nr_user =3D todo =3D 0;
 		read_lock(&tasklist_lock);
@@ -107,6 +158,10 @@
 			start_time =3D jiffies;
 		}
 		user_frozen =3D !nr_user;
+
+		if (user_frozen && !bdevs_frozen)
+			freezer_make_fses_ro();
+
 		yield();			/* Yield is okay here */
 		if (todo && time_after(jiffies, start_time + TIMEOUT))
 			break;
@@ -156,6 +211,8 @@
 			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
 	} while_each_thread(g, p);
=20
+	freezer_make_fses_rw();
+
 	read_unlock(&tasklist_lock);
 	schedule();
 	printk( " done\n" );


=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart2609063.WIiYFG1Q4G
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBETsOjN0y+n1M3mo0RAr3jAKCj6Xwqz0EIoF0W5kx6ztxtDNzW4gCgwNE/
Wmi0pMRJXsWAFEmS7I5W2xQ=
=5c8p
-----END PGP SIGNATURE-----

--nextPart2609063.WIiYFG1Q4G--
