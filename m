Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130423AbQLYD7f>; Sun, 24 Dec 2000 22:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130467AbQLYD7Z>; Sun, 24 Dec 2000 22:59:25 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:45723 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S130423AbQLYD7L>; Sun, 24 Dec 2000 22:59:11 -0500
Date: Sun, 24 Dec 2000 19:28:40 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: rgooch@atnf.csiro.au, linux-kernel@vger.kernel.org
Subject: Proposal: devfs names ending in %d or %u
Message-ID: <20001224192840.A12097@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	It seems that just about everything that uses devfs
contains some logic that attempts to construct an unused
device name with something like:

	static devnum = 0;

	sprintf (name, "lp%d", devnum++);
	devfs_register_device(..., name,...);

	Besides duplicating a lot of logic, making devfs support
more of a pain to add and uglier to look at, the numbering behvior
of these drivers can be inconsistent, especially if some devices
are being removed.  For example, as I insert and remove my PCMCIA
flash card, it becomes /dev/discs/disc1, /dev/discs/disc2,
/dev/discs/disc3, etc.

	I propose to change the devfs registration functions
to allow registrations of devices ending in %d or %u, in which
case it will use the first value, starting at 0, that generates a
string that already registered.  So, if I have disc0, disc1, and disc2,
and I remove the device containing disc1, then disc1 will be next
disc device name to be registered, then disc3, then disc4, etc.

	Just to illustrate, I have attached a patch that should
do it for device files, but I also want to do this for symlinks and
possibly directories.  So, I am not suggesting that anyone should
integrate this patch yet.

	This will make it a bit simpler to add devfs support to
the remaining drivers that do not have it, and it will make
numbering within devfs much simpler by default.  Of course, drivers
that want to do their own thing the current way would not be impeded
from doing so by this change.

	Anyhow, I thought I should post this suggestion to see if
anyone has any objections, better ideas, improvements or comments.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="diffs.devfs"

--- linux-2.4.0-test13-pre4/fs/devfs/base.c	Fri Nov 17 11:36:27 2000
+++ linux/fs/devfs/base.c	Sun Dec 10 13:50:29 2000
@@ -1238,6 +1253,7 @@
 {
     int is_new;
     struct devfs_entry *de;
+    int numeric_suffix;
 
     if (name == NULL)
     {
@@ -1292,8 +1308,16 @@
 	minor = next_devnum_block & 0xff;
 	++next_devnum_block;
     }
-    de = search_for_entry (dir, name, strlen (name), TRUE, TRUE, &is_new,
-			   FALSE);
+    numeric_suffix = 0;
+    do {
+	char realname[strlen(name)+11]; /* max 32-bit decimal integer is 10
+					  characters, plus one for
+					  terminating null. */
+	sprintf(realname, name, numeric_suffix);
+	numeric_suffix++;
+        de = search_for_entry (dir, realname, strlen (realname), TRUE, TRUE,
+			       &is_new, FALSE);
+    } while (!is_new && de != NULL && strcmp(name+strlen(name)-2, "%d") == 0); 
     if (de == NULL)
     {
 	printk ("%s: devfs_register(): could not create entry: \"%s\"\n",

--bg08WKrSYDhXBjb5--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
