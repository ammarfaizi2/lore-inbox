Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272838AbRJQI0c>; Wed, 17 Oct 2001 04:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274990AbRJQI0W>; Wed, 17 Oct 2001 04:26:22 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:29931 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S272838AbRJQI0K>;
	Wed, 17 Oct 2001 04:26:10 -0400
Date: Wed, 17 Oct 2001 04:26:42 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Kamil Iskra <kamil@science.uva.nl>
cc: csmall@users.sourceforge.net, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.12 breaks fuser
In-Reply-To: <Pine.LNX.4.33.0110170858400.3761-100000@krakow.science.uva.nl>
Message-ID: <Pine.GSO.4.21.0110170332040.15716-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2001, Kamil Iskra wrote:

> I know nothing about kernel internals, so I can't pinpoint the exact
> change.  However, I debugged fuser with gdb and what I found out is that
> fuser expects the st_dev field of /proc/pid/fd/* to be 0 for sockets.  In
> 2.4.12 st_dev is 4, at least for TCP sockets, so fuser fails to match the
> entries.
> 
> I don't know if it's fuser that makes invalid assumptions or if it is a
> kernel bug.  I guess it's for you guys to decide.

fuser.  Hmm...  OK, our options:

	a) revert the last change in net/socket.c (go back to use of
get_empty_inode()).  Which we may have to do, since it's -STABLE and
while fuser makes an unwarranted assumption, it was not too unreasonable
to start with.  That would be

--- S11-pre1/net/socket.c	Sun Sep 30 17:16:28 2001
+++ S10/net/socket.c	Sun Sep 23 16:12:10 2001
@@ -440,10 +440,11 @@
 	struct inode * inode;
 	struct socket * sock;
 
-	inode = new_inode(sock_mnt->mnt_sb);
+	inode = get_empty_inode();
 	if (!inode)
 		return NULL;
 
+	inode->i_sb = sock_mnt->mnt_sb;
 	sock = socki_lookup(inode);
 
 	inode->i_mode = S_IFSOCK|S_IRWXUGO;

	b) fix fuser(1).  Notice that it's not hard - all we need is the
patch below (guaranteed to work correctly on earlier kernels - it simply
doesn't make assumptions about the value of st_dev used for sockets).
IMO also worth doing.

--- fuser.c.old	Mon Oct 25 14:00:43 1999
+++ fuser.c	Wed Oct 17 04:13:56 2001
@@ -676,6 +676,22 @@
     return 1;
 }
 
+static dev_t net_dev;
+
+static void find_net_dev(void)
+{
+    int fd = socket(PF_INET, SOCK_DGRAM, 0);
+    struct stat buf;
+    if (fd >= 0 && fstat(fd, &buf) == 0) {
+	net_dev = buf.st_dev;
+	close(fd);
+	return;
+    }
+    if (fd >= 0)
+	close(fd);
+    fprintf(stderr,"can't find sockets' device number");
+}
+
 
 static void usage(void)
 {
@@ -718,6 +734,7 @@
 	list_signals();
 	return 0;
     }
+    find_net_dev();
     while (--argc) {
 	argv++;
 	if (**argv == '-')
@@ -819,8 +836,8 @@
 		    for (walk = unix_cache; walk; walk = walk->next)
 			if (walk->fs_dev == st.st_dev && walk->fs_ino ==
 			  st.st_ino)
-			    enter_item(*argv,flags,sig_number,0,walk->net_ino,
-			      NULL);
+			    enter_item(*argv,flags,sig_number,net_dev,
+			      walk->net_ino, NULL);
 		}
 	    }
 	    else {
@@ -844,7 +861,7 @@
 		    if ((lcl_port == -1 || walk->lcl_port == lcl_port) &&
 		      (!rmt_addr || walk->rmt_addr == rmt_addr) &&
 		      (rmt_port == -1 || walk->rmt_port == rmt_port))
-			enter_item(*argv,flags,sig_number,0,walk->ino,
+			enter_item(*argv,flags,sig_number,net_dev,walk->ino,
 			    this_name_space);
 	    }
 	}

