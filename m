Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289206AbSANLhT>; Mon, 14 Jan 2002 06:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288696AbSANLhB>; Mon, 14 Jan 2002 06:37:01 -0500
Received: from mta06ps.bigpond.com ([144.135.25.138]:30172 "EHLO
	mta06ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S288638AbSANLgn>; Mon, 14 Jan 2002 06:36:43 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com, cyeoh@samba.org, linux-kernel@vger.kernel.org,
        viro@math.psu.edu
Subject: Re: [PATCH] 2.5: PATH_MAX length fix 
In-Reply-To: Your message of "Mon, 14 Jan 2002 09:50:54 -0000."
             <E16Q3lW-0001Cv-00@the-village.bc.nu> 
Date: Mon, 14 Jan 2002 22:36:48 +1100
Message-Id: <E16Q5Q0-0002aN-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E16Q3lW-0001Cv-00@the-village.bc.nu> you write:
> > +++ working-2.4.14-pathmax/scripts/mkdep.c	Wed Nov 21 12:01:44 2001
> > @@ -218,7 +218,7 @@
> >  void add_path(const char * name)
> >  {
> >  	struct path_struct *path;
> > -	char resolved_path[PATH_MAX+1];
> > +	char resolved_path[PATH_MAX];
> >  	const char *name2;
> 
> This is a user mode application running on an unknown host. Its most 
> definitely correct and only safe before the change

Ack.  Thanks.  Regretfully, userspace must still be careful while
current (non-compliant) OSes like Linux still exist.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.14/include/linux/limits.h working-2.4.14-pathmax/include/linux/limits.h
--- linux-2.4.14/include/linux/limits.h	Thu Jul 29 03:30:10 1999
+++ working-2.4.14-pathmax/include/linux/limits.h	Wed Nov 21 10:59:37 2001
@@ -11,7 +11,7 @@
 #define MAX_CANON        255	/* size of the canonical input queue */
 #define MAX_INPUT        255	/* size of the type-ahead buffer */
 #define NAME_MAX         255	/* # chars in a file name */
-#define PATH_MAX        4095	/* # chars in a path name */
+#define PATH_MAX        4096	/* # chars in a path name including nul */
 #define PIPE_BUF        4096	/* # bytes in atomic write to a pipe */
 
 #define RTSIG_MAX	  32
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.14/fs/dcache.c working-2.4.14-pathmax/fs/dcache.c
--- linux-2.4.14/fs/dcache.c	Thu Oct  4 15:57:36 2001
+++ working-2.4.14-pathmax/fs/dcache.c	Wed Nov 21 12:04:18 2001
@@ -1262,7 +1262,7 @@
 		panic("Cannot create buffer head SLAB cache");
 
 	names_cachep = kmem_cache_create("names_cache", 
-			PATH_MAX + 1, 0, 
+			PATH_MAX, 0, 
 			SLAB_HWCACHE_ALIGN, NULL, NULL);
 	if (!names_cachep)
 		panic("Cannot create names SLAB cache");
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.14/fs/namei.c working-2.4.14-pathmax/fs/namei.c
--- linux-2.4.14/fs/namei.c	Thu Oct 18 07:46:29 2001
+++ working-2.4.14-pathmax/fs/namei.c	Wed Nov 21 10:57:58 2001
@@ -99,16 +99,17 @@
  * kernel data space before using them..
  *
  * POSIX.1 2.4: an empty pathname is invalid (ENOENT).
+ * PATH_MAX includes the nul terminator --RR.
  */
 static inline int do_getname(const char *filename, char *page)
 {
 	int retval;
-	unsigned long len = PATH_MAX + 1;
+	unsigned long len = PATH_MAX;
 
 	if ((unsigned long) filename >= TASK_SIZE) {
 		if (!segment_eq(get_fs(), KERNEL_DS))
 			return -EFAULT;
-	} else if (TASK_SIZE - (unsigned long) filename < PATH_MAX + 1)
+	} else if (TASK_SIZE - (unsigned long) filename < PATH_MAX)
 		len = TASK_SIZE - (unsigned long) filename;
 
 	retval = strncpy_from_user((char *)page, filename, len);
