Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLPCYu>; Fri, 15 Dec 2000 21:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131031AbQLPCYk>; Fri, 15 Dec 2000 21:24:40 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:34442 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129228AbQLPCY3>;
	Fri, 15 Dec 2000 21:24:29 -0500
Date: Fri, 15 Dec 2000 20:54:01 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kurt Garloff <garloff@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        miquels@cistron.nl, Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: TIOCGDEV ioctl
In-Reply-To: <Pine.LNX.4.10.10012151710040.1325-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0012152038560.13037-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Dec 2000, Linus Torvalds wrote:

> Please instead do the same thing /dev/tty does, namely a sane interface
> that shows it as a symlink in /proc (or even in /dev)


There you go... (/proc/tty/console -> /dev/tty<current_VC>; may very well
be dangling, but then you have a current VC even if your /dev consists
of /dev/console and nothing else, so there's nothing to do about that;
doesn't handle TIOCCONS redirects, but IMO that should be a separate
object anyway).
							Cheers,
								Al

diff -urN rc12-pre8/fs/proc/proc_tty.c rc12-pre8-tty/fs/proc/proc_tty.c
--- rc12-pre8/fs/proc/proc_tty.c	Sat Apr 22 02:35:31 2000
+++ rc12-pre8-tty/fs/proc/proc_tty.c	Sat Dec 16 00:14:20 2000
@@ -166,6 +166,26 @@
 	driver->proc_entry = 0;
 }
 
+extern int fg_console;
+static int proc_cons_readlink(struct dentry *dentry, char *buffer, int buflen)
+{
+	char tmp[30];
+	sprintf(tmp, "/dev/tty%d", fg_console);
+	return vfs_readlink(dentry,buffer,buflen,tmp);
+}
+
+static int proc_cons_follow_link(struct dentry *dentry, struct nameidata *nd)
+{
+	char tmp[30];
+	sprintf(tmp, "/dev/tty%d", fg_console);
+	return vfs_follow_link(nd,tmp);
+}	
+
+static struct inode_operations proc_cons_operations = {
+	readlink:	proc_cons_readlink,
+	follow_link:	proc_cons_follow_link,
+};
+
 /*
  * Called by proc_root_init() to initialize the /proc/tty subtree
  */
@@ -175,6 +195,9 @@
 		return;
 	proc_tty_ldisc = proc_mkdir("tty/ldisc", 0);
 	proc_tty_driver = proc_mkdir("tty/driver", 0);
+
+	proc_tty_console = create_proc_entry("tty/console", S_IFLNK|0777, NULL);
+	proc_tty_console->proc_iops = &proc_console_ops;
 
 	create_proc_read_entry("tty/ldiscs", 0, 0, tty_ldiscs_read_proc,NULL);
 	create_proc_read_entry("tty/drivers", 0, 0, tty_drivers_read_proc,NULL);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
