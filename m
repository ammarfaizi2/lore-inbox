Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276933AbRJQQZj>; Wed, 17 Oct 2001 12:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276956AbRJQQZa>; Wed, 17 Oct 2001 12:25:30 -0400
Received: from gold.MUSKOKA.COM ([216.123.107.5]:49425 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S276933AbRJQQZO>;
	Wed, 17 Oct 2001 12:25:14 -0400
Message-ID: <3BCAB9B1.2F85F523@yahoo.com>
Date: Wed, 17 Oct 2001 08:25:53 -0400
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.19 i586)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Making diff(1) of linux kernels faster
In-Reply-To: <Pine.LNX.4.33.0110140841540.15323-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 14 Oct 2001, Paul Gortmaker wrote:
> >
> > Well, I taught diff to read each tree sequentially 1st and the results
...

> Could you maybe instead of pre-reading the whole tree, just pre-read one
> directory at a time?
...

> Even just doing it one directory at a time should improve speed
> _noticeably_. I'd bet you'll get close to the same improvement, with much
> less memory pressure..
> 
>                 Linus

Yup, on the small 8MB tree (v1.2.0) it seems to be the same improvement
(within the errors of my $0.02 test) and doesn't require gobs of ram. 

On a more real world test; on a 90% full ext2 2GB disk with 2.4.10
trees on a 32MB machine, this patch cuts the diff time in about 1/2.
(The first version of the patch would have been pathological on such
a low mem machine - essentially doubling the time taken vs. unpatched.)
Obviously maximum improvement would be for unfragmented trees living
at opposite edges of the disk and with more mem - so I would expect 
that people should see a minimum of a factor of two improvement.

Oh, and prereading the dirs of both trees (vs. just one and letting 
normal execution read in the 2nd) seems to offer better improvements.
(Steady stream of requests results in better merging perhaps?)

This was all running under a 2.2.x kernel btw; might have time to 
test on a 2.4.x one later.  Either way, it kind of makes you wonder 
why nobody had done this earlier (not to mention feeding the source
to indent -kr -i8...)

Paul.

diff -urz orig/diffutils-2.7/diff.c diffutils-2.7/diff.c
--- orig/diffutils-2.7/diff.c	Thu Sep 22 12:47:00 1994
+++ diffutils-2.7/diff.c	Mon Oct 15 06:01:08 2001
@@ -206,6 +206,7 @@
   {"exclude", 1, 0, 'x'},
   {"exclude-from", 1, 0, 'X'},
   {"side-by-side", 0, 0, 'y'},
+  {"zoom", 0, 0, 'z'},
   {"unified", 2, 0, 'U'},
   {"left-column", 0, 0, 129},
   {"suppress-common-lines", 0, 0, 130},
@@ -244,7 +245,7 @@
   /* Decode the options.  */
 
   while ((c = getopt_long (argc, argv,
-			   "0123456789abBcC:dD:efF:hHiI:lL:nNpPqrsS:tTuU:vwW:x:X:y",
+			   "0123456789abBcC:dD:efF:hHiI:lL:nNpPqrsS:tTuU:vwW:x:X:yz",
 			   longopts, 0)) != EOF)
     {
       switch (c)
@@ -493,6 +494,11 @@
 	  specify_style (OUTPUT_SDIFF);
 	  break;
 
+	case 'z':
+	  /* Pre-read each dir sequentially to prime cache, avoid seeks. */
+	  preread_dir = 1;
+	  break;
+
 	case 'W':
 	  /* Set the line width for OUTPUT_SDIFF.  */
 	  if (ck_atoi (optarg, &width) || width <= 0)
@@ -736,6 +742,7 @@
 "-S FILE  --starting-file=FILE  Start with FILE when comparing directories.\n",
 "--horizon-lines=NUM  Keep NUM lines of the common prefix and suffix.",
 "-d  --minimal  Try hard to find a smaller set of changes.",
+"-z  --zoom  Read ahead whole directories (with -r) at a time.",
 "-H  --speed-large-files  Assume large files and many scattered small changes.\n",
 "-v  --version  Output version info.",
 "--help  Output this help.",
@@ -990,6 +997,15 @@
 	}
       else
 	{
+
+          /* Sometimes faster to load a whole dir into OS's cache 1st */
+
+          if (recursive && preread_dir)
+	    {
+              preread(inf[0].name);
+              preread(inf[1].name);
+            }
+		
 	  val = diff_dirs (inf, compare_files, depth);
 	}
 
diff -urz orig/diffutils-2.7/diff.h diffutils-2.7/diff.h
--- orig/diffutils-2.7/diff.h	Thu Sep 22 12:47:00 1994
+++ diffutils-2.7/diff.h	Mon Oct 15 05:33:57 2001
@@ -93,6 +93,9 @@
 /* File labels for `-c' output headers (-L).  */
 EXTERN char *file_label[2];
 
+/* 1 if dirs should be read sequentially to avoid seeks during recursive. */
+EXTERN int	preread_dir;
+
 struct regexp_list
 {
   struct re_pattern_buffer buf;
diff -urz orig/diffutils-2.7/io.c diffutils-2.7/io.c
--- orig/diffutils-2.7/io.c	Thu Sep 22 12:47:00 1994
+++ diffutils-2.7/io.c	Mon Oct 15 05:38:07 2001
@@ -182,6 +182,59 @@
       current->buffer = xrealloc (current->buffer, current->bufsize);
     }
 }
+
+/* Preload the OS's cache with all files in one dir (Avoids disk seeks). */
+
+void
+preread (dir)
+	const char *dir;
+{
+
+  DIR *d;
+  struct dirent *dent;
+
+  d = opendir(dir);
+  if (d == NULL) return;
+
+  while ((dent = readdir(d)) != NULL)
+    {
+
+      char *name, *path;
+      struct file_data *f;
+
+      name = dent->d_name;
+      if (name[0] == '.' && (name[1] == 0 || (name[1] == '.' && name[2] == 0)))
+            continue;
+
+      f = xmalloc(sizeof(struct file_data));
+      memset(f, 0, sizeof(struct file_data));
+
+      path = xmalloc(strlen(dir)+strlen(name)+2);
+      strcpy(path, dir);
+      strcat(path, "/");
+      strcat(path, name);
+
+      if (stat(path, &f->stat) != 0 || !S_ISREG(f->stat.st_mode))
+        {
+           free(f);
+           free(path);
+           continue;
+        }
+	
+      f->desc = open(path, O_RDONLY);
+      if (f->desc != -1)
+        {
+          slurp(f); 
+          if (f->bufsize != 0)
+            free(f->buffer);
+          close(f->desc);
+        }
+      free(f); 
+      free(path);
+  }
+  closedir(d);
+}
+
 
 /* Split the file into lines, simultaneously computing the equivalence class for
    each line. */



