Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274972AbRJNJOG>; Sun, 14 Oct 2001 05:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274990AbRJNJN5>; Sun, 14 Oct 2001 05:13:57 -0400
Received: from gold.MUSKOKA.COM ([216.123.107.5]:52490 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S274972AbRJNJNu>;
	Sun, 14 Oct 2001 05:13:50 -0400
Message-ID: <3BC953B5.18870B14@yahoo.com>
Date: Sun, 14 Oct 2001 04:58:29 -0400
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.19 i586)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Making diff(1) of linux kernels faster
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A while ago somebody with too much memory was gloating that they 
would do a "find ... xargs cat>/dev/null" on several 2.4.x trees
so that diff wouldn't thrash the disk with a million seeks  :-)

Well, I taught diff to read each tree sequentially 1st and the results
were quite surprising (linux-2.2 kernel, two identical 8 MB trees, on 
some older hardware, average times reported, new diff option is "-z").

   diff -urN, nothing cached:  36 seconds
   diff -urzN, nothing cached:  7.5 seconds  (about 1/5 !!!!!)

   diff -urN, all cached:  1.04 seconds
   diff -urzN, all cached: 1.66 seconds

So, with the cold cache, my patch cut the time by a factor of 5(!!)
and the amount of audible death growls from the disk is also reduced.  
In the warm case, you pay a slight penalty since the simple hack
doesn't try to keep the file data around while priming the cache.

Now if I only had enough ram to personally test how much it helps
against a couple of 2.4.x kernel trees...  other stats welcomed.

Paul.

diff -ruz orig/diffutils-2.7/diff.c diffutils-2.7/diff.c
--- orig/diffutils-2.7/diff.c	Thu Sep 22 12:47:00 1994
+++ diffutils-2.7/diff.c	Sun Oct 14 03:59:33 2001
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
+	  /* Pre-read each tree sequentially to prime cache, avoid seeks. */
+	  preread_tree = 1;
+	  break;
+
 	case 'W':
 	  /* Set the line width for OUTPUT_SDIFF.  */
 	  if (ck_atoi (optarg, &width) || width <= 0)
@@ -736,6 +742,7 @@
 "-S FILE  --starting-file=FILE  Start with FILE when comparing directories.\n",
 "--horizon-lines=NUM  Keep NUM lines of the common prefix and suffix.",
 "-d  --minimal  Try hard to find a smaller set of changes.",
+"-z  --zoom  Assume both trees (with -r) will fit into machine core.",
 "-H  --speed-large-files  Assume large files and many scattered small changes.\n",
 "-v  --version  Output version info.",
 "--help  Output this help.",
@@ -990,6 +997,15 @@
 	}
       else
 	{
+
+          /* Sometimes faster to load each tree into OS's cache 1st */
+
+          if (depth == 0 && recursive && preread_tree)
+	    {
+              preread(inf[0].name);
+              preread(inf[1].name);
+            }
+		
 	  val = diff_dirs (inf, compare_files, depth);
 	}
 
diff -ruz orig/diffutils-2.7/diff.h diffutils-2.7/diff.h
--- orig/diffutils-2.7/diff.h	Thu Sep 22 12:47:00 1994
+++ diffutils-2.7/diff.h	Fri Oct 12 11:50:43 2001
@@ -93,6 +93,9 @@
 /* File labels for `-c' output headers (-L).  */
 EXTERN char *file_label[2];
 
+/* 1 if trees should be read sequentially to avoid seeks during recursive. */
+EXTERN int	preread_tree;
+
 struct regexp_list
 {
   struct re_pattern_buffer buf;
diff -ruz orig/diffutils-2.7/io.c diffutils-2.7/io.c
--- orig/diffutils-2.7/io.c	Thu Sep 22 12:47:00 1994
+++ diffutils-2.7/io.c	Fri Oct 12 11:51:55 2001
@@ -182,6 +182,64 @@
       current->buffer = xrealloc (current->buffer, current->bufsize);
     }
 }
+
+/* Preload the OS's cache with all files of one branch for recursive diffs */
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
+      if (stat(path, &f->stat) != 0)
+        {
+           free(f);
+           free(path);
+           continue;
+        }
+	
+      if (S_ISDIR(f->stat.st_mode))
+           preread(path);
+      else if (S_ISREG(f->stat.st_mode))
+        {
+          f->desc = open(path, O_RDONLY);
+          if (f->desc != -1)
+            {
+              slurp(f); 
+              if (f->bufsize != 0)
+                free(f->buffer);
+              close(f->desc);
+            }
+        } 
+      free(path);
+      free(f); 
+  }
+  closedir(d);
+}
+
 
 /* Split the file into lines, simultaneously computing the equivalence class for
    each line. */


