Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130251AbQKTBLz>; Sun, 19 Nov 2000 20:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129805AbQKTBLf>; Sun, 19 Nov 2000 20:11:35 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:32005 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129626AbQKTBLb>; Sun, 19 Nov 2000 20:11:31 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jasper Spaans <spaans@delft.corps.nl>
Date: Mon, 20 Nov 2000 11:41:11 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14872.29479.901021.472890@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
cc: Richard Henderson <rth@cygnus.com>, MOLNAR Ingo <mingo@chiara.elte.hu>,
        "David S. Miller" <davem@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [BUG] raid5 link error? (was [PATCH] raid5 fix after xor.c cleanup)
In-Reply-To: message from Jasper Spaans on Saturday November 18
In-Reply-To: <20001117234144.A14461@spaans.ds9a.nl>
	<20001118123536.A5674@spaans.ds9a.nl>
	<20001118235352.D2226@spaans.ds9a.nl>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday November 18, spaans@delft.corps.nl wrote:
> On Sat, Nov 18, 2000 at 12:35:36PM +0100, Jasper Spaans wrote:
> 
> > Hmm, next time I'll need to eat my own dogfood -- this patch doesn't work,
> > it only compiles. Don't use it.
> 
> It seems to me the original code was correct, but the linking isn't in the
> right order and the initcalls are in the wrong order (ie,
> raid5.c::raid5_init() is being called before xor.c::calibrate_xor_block() --
> any linking gurus out there who can help me out on this one?
> 
> Feeling a bit of a schizo, but getting used to my brown paper bag,
> 
> Regards

Yep... the link order is important isn't it.
At least three pairs of eyes looked and the changes to xor and no of
us spotted this dependancy - just shows how important beta testers are
- thanks.

The following patch changes the link order in the Makefile so that xor
is initiailised before md tries to autostart anything.
It also takes the theme a bit further and uses module_init/module_exit
to init and shutdown the raid personalities.  This allows us to remove
the explicit calls to raidXX_init from md.c, which is nice.

I have tested this patch both
   1/ monolithic kernel and autodetecting an array
   2/ md and all personalities modules

and it works fine.

It reduced the "#ifdef" count of the kernel by 8, which must be a good
thing :-)

NeilBrown



--- ./drivers/md/Makefile	2000/11/19 22:25:54	1.1
+++ ./drivers/md/Makefile	2000/11/20 00:33:08	1.2
@@ -16,11 +16,13 @@
 obj-n		:=
 obj-		:=
 
-obj-$(CONFIG_BLK_DEV_MD)	+= md.o
+# Note: link order is important. 
+# md personalities must come before md, and xor before raid5
 obj-$(CONFIG_MD_LINEAR)		+= linear.o
 obj-$(CONFIG_MD_RAID0)		+= raid0.o
 obj-$(CONFIG_MD_RAID1)		+= raid1.o
-obj-$(CONFIG_MD_RAID5)		+= raid5.o xor.o
+obj-$(CONFIG_MD_RAID5)		+= xor.o raid5.o 
+obj-$(CONFIG_BLK_DEV_MD)	+= md.o
 obj-$(CONFIG_BLK_DEV_LVM)	+= lvm-mod.o
 
 # Translate to Rules.make lists.
--- ./drivers/md/md.c	2000/11/19 22:27:17	1.1
+++ ./drivers/md/md.c	2000/11/20 00:33:08	1.2
@@ -3576,12 +3576,6 @@
 	create_proc_read_entry("mdstat", 0, NULL, md_status_read_proc, NULL);
 #endif
 }
-void hsm_init (void);
-void translucent_init (void);
-void linear_init (void);
-void raid0_init (void);
-void raid1_init (void);
-void raid5_init (void);
 
 int md__init md_init (void)
 {
@@ -3617,18 +3611,6 @@
 	md_register_reboot_notifier(&md_notifier);
 	raid_table_header = register_sysctl_table(raid_root_table, 1);
 
-#ifdef CONFIG_MD_LINEAR
-	linear_init ();
-#endif
-#ifdef CONFIG_MD_RAID0
-	raid0_init ();
-#endif
-#ifdef CONFIG_MD_RAID1
-	raid1_init ();
-#endif
-#ifdef CONFIG_MD_RAID5
-	raid5_init ();
-#endif
 	md_geninit();
 	return (0);
 }
--- ./drivers/md/linear.c	2000/11/19 22:33:21	1.1
+++ ./drivers/md/linear.c	2000/11/20 00:33:08	1.2
@@ -190,24 +190,16 @@
 	status:		linear_status,
 };
 
-#ifndef MODULE
-
-void md__init linear_init (void)
-{
-	register_md_personality (LINEAR, &linear_personality);
-}
-
-#else
-
-int init_module (void)
+static int md__init linear_init (void)
 {
-	return (register_md_personality (LINEAR, &linear_personality));
+	return register_md_personality (LINEAR, &linear_personality);
 }
 
-void cleanup_module (void)
+static void linear_exit (void)
 {
 	unregister_md_personality (LINEAR);
 }
 
-#endif
 
+module_init(linear_init);
+module_exit(linear_exit);
--- ./drivers/md/raid0.c	2000/11/19 22:39:37	1.1
+++ ./drivers/md/raid0.c	2000/11/20 00:33:08	1.2
@@ -333,24 +333,17 @@
 	status:		raid0_status,
 };
 
-#ifndef MODULE
-
-void raid0_init (void)
-{
-	register_md_personality (RAID0, &raid0_personality);
-}
-
-#else
-
-int init_module (void)
+static int md__init raid0_init (void)
 {
-	return (register_md_personality (RAID0, &raid0_personality));
+	return register_md_personality (RAID0, &raid0_personality);
 }
 
-void cleanup_module (void)
+void raid0_exit (void)
 {
 	unregister_md_personality (RAID0);
 }
 
-#endif
+module_init(raid0_init);
+module_exit(raid0_exit);
+
 
--- ./drivers/md/raid1.c	2000/11/19 22:39:42	1.1
+++ ./drivers/md/raid1.c	2000/11/20 00:33:08	1.2
@@ -1882,19 +1882,16 @@
 	sync_request:	raid1_sync_request
 };
 
-int raid1_init (void)
+static int md__init raid1_init (void)
 {
 	return register_md_personality (RAID1, &raid1_personality);
 }
 
-#ifdef MODULE
-int init_module (void)
-{
-	return raid1_init();
-}
-
-void cleanup_module (void)
+static void raid1_exit (void)
 {
 	unregister_md_personality (RAID1);
 }
-#endif
+
+module_init(raid1_init);
+module_exit(raid1_exit);
+
--- ./drivers/md/raid5.c	2000/11/19 22:39:46	1.1
+++ ./drivers/md/raid5.c	2000/11/20 00:33:08	1.2
@@ -2352,19 +2352,16 @@
 	sync_request:	raid5_sync_request
 };
 
-int raid5_init (void)
+static int md__init raid5_init (void)
 {
 	return register_md_personality (RAID5, &raid5_personality);
 }
 
-#ifdef MODULE
-int init_module (void)
-{
-	return raid5_init();
-}
-
-void cleanup_module (void)
+static void raid5_exit (void)
 {
 	unregister_md_personality (RAID5);
 }
-#endif
+
+module_init(raid5_init);
+module_exit(raid5_exit);
+
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
