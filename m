Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314981AbSEXU1p>; Fri, 24 May 2002 16:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315042AbSEXU1o>; Fri, 24 May 2002 16:27:44 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:41296 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314981AbSEXU1l>; Fri, 24 May 2002 16:27:41 -0400
Date: Fri, 24 May 2002 22:26:58 +0200
From: Andrea Arcangeli <andrea@e-mind.com>
To: Dan Kegel <dank@kegel.com>
Cc: Andrew Morton <akpm@zip.com.au>, Hugh Dickins <hugh@veritas.com>,
        Christoph Rohland <cr@sap.com>, Jens Axboe <axboe@suse.de>,
        linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020524202658.GI15703@dualathlon.random>
In-Reply-To: <Pine.LNX.4.21.0204292127480.1709-100000@localhost.localdomain> <3CEDF94C.592636A6@kegel.com> <3CEDFCED.D10CD618@zip.com.au> <3CEE806D.D52FBEA5@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ speaking for myself in this whole email, and CC'ed l-k ]

On Fri, May 24, 2002 at 11:03:25AM -0700, Dan Kegel wrote:
> software patent on Tux... http://lwn.net/daily/

I'm more lucky than most of you because the original article is in
Italian so I can understand all the details. btw, I noticed the italian
linux community is very aware and responsive (we even had a law proposal
to help the free software IIRC).

Just for reference I attached the 13 line long patch in -aa that is
being requested to be put under this patent:

	http://l2.espacenet.com/espacenet/viewer?PN=WO0217597&CY=ep&LG=en&DB=EPD

the code is available also from here:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre8aa4/60_atomic-lookup-5

and in the tux patches at www.redhat.com/~mingo/ that I merged in my
tree and that are shipped with various vendor kernels.

Now dropping this feature from tux is a matter of a few hours and it
cannot make difference if your vfs working set fits in dcache, but
that's not the problem. I wonder what's next, should I apply for a
patent for the classzone algorithm in the memory balancing or is Ingo
going to patent the O1 scheduler too? Ingo, Alan, Arjan, DaveM are so much
worried about binary only modules, Alan even speaks about the DMCA all
over the place, this is an order of magnitude worse, this even forbids
you to use this tequnique despite you may invented it too from scratch
and it's your own idea too. To make the opposite example despite IBM is
a big patent producer IBM even allowed the usage of their RCU patents in
the linux kernel (I've the paperwork under my desk and Linus should have
received too), and other stuff donated to gcc and probably much more
that I don't know about, IMHO exactly to avoid linux to be castrated by
patents. So this news is totally stunning from my part.

I think it is in the interest of the US gov to do something to avoid
these three patents to pass and hurt the linux developement. I think
this is a breakpoint and they cannot ignore those issues at this point.
If they act now, they will stop the problem at its root and we don't
risk a fragmentation. Until it was only rtlinux to be patented that is
never been a showstopper because real time apps are a niche market and
they're not mainstream but the O_ATOMICLOOKUP API is even exported to
userspace! (for all the wrong reasons btw, because that's not yet part
of mainline for some unknown reason but if mainline collides on some
number I will notice in a jiffy and the collision could be resolved so
it's a minor problem compared to the patent) Even Ingo said once a few
years back to l-k that somebody should do something to at least avoid
the application of patentes to linux (I can search and forward you the
email if you're curious) and I certainly agreed with that opinion.

I can probably do nothing more than to write this email just to give
more awareness about the technical parts of the problem, so not really
much, but at least if the thing passes I felt I did all I could to try
to avoid it.

I would also suggest to apply the below patch to mainline (if something
to avoid collisions on the O_ flag #defines that as said is a minor
problem after all).

diff -urN 2.4.15pre1/fs/namei.c atomic-lookup/fs/namei.c
--- 2.4.15pre1/fs/namei.c	Wed Oct 24 08:04:22 2001
+++ atomic-lookup/fs/namei.c	Fri Nov  9 04:34:12 2001
@@ -448,9 +448,13 @@
 {
 	struct dentry *dentry;
 	struct inode *inode;
-	int err;
+	int err, atomic;
 	unsigned int lookup_flags = nd->flags;
 
+	atomic = 0;
+	if (lookup_flags & LOOKUP_ATOMIC)
+		atomic = 1;
+
 	while (*name=='/')
 		name++;
 	if (!*name)
@@ -519,6 +523,9 @@
 		/* This does the actual lookups.. */
 		dentry = cached_lookup(nd->dentry, &this, LOOKUP_CONTINUE);
 		if (!dentry) {
+			err = -EWOULDBLOCKIO;
+			if (atomic)
+				break;
 			dentry = real_lookup(nd->dentry, &this, LOOKUP_CONTINUE);
 			err = PTR_ERR(dentry);
 			if (IS_ERR(dentry))
@@ -582,6 +589,9 @@
 		}
 		dentry = cached_lookup(nd->dentry, &this, 0);
 		if (!dentry) {
+			err = -EWOULDBLOCKIO;
+			if (atomic)
+				break;
 			dentry = real_lookup(nd->dentry, &this, 0);
 			err = PTR_ERR(dentry);
 			if (IS_ERR(dentry))
@@ -924,6 +934,8 @@
 	
 	if (f & O_DIRECTORY)
 		retval |= LOOKUP_DIRECTORY;
+	if (f & O_ATOMICLOOKUP)
+		retval |= LOOKUP_ATOMIC;
 
 	return retval;
 }
diff -urN 2.4.15pre1/include/asm-alpha/fcntl.h atomic-lookup/include/asm-alpha/fcntl.h
--- 2.4.15pre1/include/asm-alpha/fcntl.h	Sun Sep 23 21:11:40 2001
+++ atomic-lookup/include/asm-alpha/fcntl.h	Fri Nov  9 04:34:12 2001
@@ -20,6 +20,7 @@
 #define O_DIRECTORY	0100000	/* must be a directory */
 #define O_NOFOLLOW	0200000 /* don't follow links */
 #define O_LARGEFILE	0400000 /* will be set by the kernel on every open */
+#define O_ATOMICLOOKUP  01000000 /* do atomic file lookup */
 #define O_DIRECT	02000000 /* direct disk access - should check with OSF/1 */
 
 #define F_DUPFD		0	/* dup */
diff -urN 2.4.15pre1/include/asm-i386/fcntl.h atomic-lookup/include/asm-i386/fcntl.h
--- 2.4.15pre1/include/asm-i386/fcntl.h	Sun Sep 23 21:11:40 2001
+++ atomic-lookup/include/asm-i386/fcntl.h	Fri Nov  9 04:34:12 2001
@@ -20,6 +20,7 @@
 #define O_LARGEFILE	0100000
 #define O_DIRECTORY	0200000	/* must be a directory */
 #define O_NOFOLLOW	0400000 /* don't follow links */
+#define O_ATOMICLOOKUP	01000000 /* do atomic file lookup */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -urN 2.4.15pre1/include/asm-ia64/fcntl.h atomic-lookup/include/asm-ia64/fcntl.h
--- 2.4.15pre1/include/asm-ia64/fcntl.h	Thu Nov 16 15:37:42 2000
+++ atomic-lookup/include/asm-ia64/fcntl.h	Fri Nov  9 04:34:12 2001
@@ -28,6 +28,7 @@
 #define O_LARGEFILE	0100000
 #define O_DIRECTORY	0200000	/* must be a directory */
 #define O_NOFOLLOW	0400000 /* don't follow links */
+#define O_ATOMICLOOKUP  01000000 /* do atomic file lookup */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -urN 2.4.15pre1/include/asm-ppc/fcntl.h atomic-lookup/include/asm-ppc/fcntl.h
--- 2.4.15pre1/include/asm-ppc/fcntl.h	Tue Nov  6 02:04:53 2001
+++ atomic-lookup/include/asm-ppc/fcntl.h	Fri Nov  9 04:34:42 2001
@@ -23,6 +23,7 @@
 #define O_NOFOLLOW      0100000	/* don't follow links */
 #define O_LARGEFILE     0200000
 #define O_DIRECT	0400000	/* direct disk access hint */
+#define O_ATOMICLOOKUP 01000000 /* do atomic file lookup */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -urN 2.4.15pre1/include/asm-sparc/fcntl.h atomic-lookup/include/asm-sparc/fcntl.h
--- 2.4.15pre1/include/asm-sparc/fcntl.h	Sun Sep 23 21:11:42 2001
+++ atomic-lookup/include/asm-sparc/fcntl.h	Fri Nov  9 04:34:12 2001
@@ -20,6 +20,7 @@
 #define O_DIRECTORY	0x10000	/* must be a directory */
 #define O_NOFOLLOW	0x20000	/* don't follow links */
 #define O_LARGEFILE	0x40000
+#define O_ATOMICLOOKUP  0x80000 /* do atomic file lookup */
 #define O_DIRECT        0x100000 /* direct disk access hint */
 
 #define F_DUPFD		0	/* dup */
diff -urN 2.4.15pre1/include/asm-sparc64/fcntl.h atomic-lookup/include/asm-sparc64/fcntl.h
--- 2.4.15pre1/include/asm-sparc64/fcntl.h	Sun Sep 23 21:11:42 2001
+++ atomic-lookup/include/asm-sparc64/fcntl.h	Fri Nov  9 04:34:12 2001
@@ -20,6 +20,7 @@
 #define O_DIRECTORY	0x10000	/* must be a directory */
 #define O_NOFOLLOW	0x20000	/* don't follow links */
 #define O_LARGEFILE	0x40000
+#define O_ATOMICLOOKUP  0x80000 /* do atomic file lookup */
 #define O_DIRECT        0x100000 /* direct disk access hint */
 
 
diff -urN 2.4.15pre1/include/linux/errno.h atomic-lookup/include/linux/errno.h
--- 2.4.15pre1/include/linux/errno.h	Fri Aug 17 05:02:27 2001
+++ atomic-lookup/include/linux/errno.h	Fri Nov  9 04:34:12 2001
@@ -21,6 +21,9 @@
 #define EBADTYPE	527	/* Type not supported by server */
 #define EJUKEBOX	528	/* Request initiated, but will not complete before timeout */
 
+/* Defined for TUX async IO */
+#define EWOULDBLOCKIO	530	/* Would block due to block-IO */
+
 #endif
 
 #endif
diff -urN 2.4.15pre1/include/linux/fs.h atomic-lookup/include/linux/fs.h
--- 2.4.15pre1/include/linux/fs.h	Tue Nov  6 02:04:53 2001
+++ atomic-lookup/include/linux/fs.h	Fri Nov  9 04:34:12 2001
@@ -1260,6 +1260,7 @@
 #define LOOKUP_POSITIVE		(8)
 #define LOOKUP_PARENT		(16)
 #define LOOKUP_NOALT		(32)
+#define LOOKUP_ATOMIC		(64)
 /*
  * Type of the last component on LOOKUP_PARENT
  */

Andrea
