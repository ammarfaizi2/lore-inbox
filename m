Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264735AbRFQOty>; Sun, 17 Jun 2001 10:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264738AbRFQOto>; Sun, 17 Jun 2001 10:49:44 -0400
Received: from shiva.jussieu.fr ([134.157.0.129]:28679 "EHLO shiva.jussieu.fr")
	by vger.kernel.org with ESMTP id <S264735AbRFQOtb>;
	Sun, 17 Jun 2001 10:49:31 -0400
From: Roberto Di Cosmo <Roberto.Di-Cosmo@pps.jussieu.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15148.49603.742951.360288@beryllium.pps.jussieu.fr>
Date: Sun, 17 Jun 2001 16:42:11 +0200 (CEST)
To: hpa@zytor.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, pavel@suse.cz (Pavel Machek),
        Roberto.Di-Cosmo@pps.jussieu.fr (Roberto Di Cosmo),
        linux-kernel@vger.kernel.org, demolinux@demolinux.org
Subject: [isocompr PATCH]: first comparison with HPA's zisofs
In-Reply-To: <E159r4y-0001bR-00@the-village.bc.nu>
In-Reply-To: <20010611225944.B959@bug.ucw.cz>
	<E159r4y-0001bR-00@the-village.bc.nu>
X-Mailer: VM 6.72 under 21.1 (patch 9) "Canyonlands" XEmacs Lucid
Reply-To: Roberto Di Cosmo <roberto@dicosmo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Peter,
     I posted about a week ago a first fixed and very stable version of the old
isocompr patch for 2.2.18 kernels, that is similar in goal to your zisofs, 
which I was not aware of.

I had a very very quick look at the code of the zisofs patch for 2.4.x: 
it seems to me that it was written with the old isocompr patch in mind
(very similar changes in mkisofs, similar options for mounting uncompressed),
and with many desirable features added (account for the 2.4 page cache,
for multithreading, for blocksize different from 4096 for compression
etc.). As a first impression, I think zisofs looks superior to isocompr,
but I would like to do some testing to confirm this.

I have only the following (minor) criticisms 

- the transparent compression scheme does not rely on a special
  filename extension (it was .gZ in isocompr): a file foo gets
  compressed to a file foo, and the only way to see if foo is
  compressed or not is to read the header. This has pros and cons...
  and I wonder what the reasons of this choice are.

- the tools allow to compress/decompress only a whole directory tree,
  while it should be possible to act on a single file also: in DemoLinux
  not all files are compressed (some must be readable under (hem...) other
  less interesting OSs for example ;-)) and the distinction is not on
  a per-directory basis.
  [easy to fix, see patch at the end of this message: I did this to
  be able to try zisofs with DemoLinux]

- it seems to me that this was written with 2.4.x in mind, and I did not
  find a version for 2.2.x kernels :-(

Now I wonder, if zisofs is going to be included into 2.5 (I would strongly
vote in favour!), would it be worthwhile to include a compatibility mode
to read the isocompr blocksized format too?

all the best

--Roberto Di Cosmo
 
------------------------------------------------------------------
Professeur
PPS                      E-mail: dicosmo@pps.jussieu.fr
Universite Paris VII     WWW  : http://www.pps.jussieu.fr/~dicosmo
Case 7014                Tel  : ++33-(1)-44 27 86 55
2, place Jussieu         Fax  : ++33-(1)-44 27 68 49
F-75251 Paris Cedex 05
FRANCE.                  MIME/NextMail accepted
------------------------------------------------------------------
Office location:
 
Bureau 6C14 (6th floor)
175, rue du Chevaleret, XIII
Metro Chevaleret, ligne 6
------------------------------------------------------------------


Here comes the patch to mkzftree to add a -F option to compress/decompress
a file only

diff -ubr zisofs-tools-0.09/mkzftree.c zisofs-tools-0.10/mkzftree.c
--- zisofs-tools-0.09/mkzftree.c	Mon May  7 03:27:53 2001
+++ zisofs-tools-0.10/mkzftree.c	Sun Jun 17 16:45:47 2001
@@ -1,4 +1,4 @@
-/* $Id: mkzftree.c,v 1.8 2001/05/07 01:27:53 hpa Exp $ */
+/* $Id: mkzftree.c,v 1.9 2001/06/77 01:27:53 dicosmo Exp $ */
 /* ----------------------------------------------------------------------- *
  *   
  *   Copyright 2001 H. Peter Anvin - All Rights Reserved
@@ -11,6 +11,11 @@
  *
  * ----------------------------------------------------------------------- */
 
+/* ----------------------------------------------------------------------- *
+   R. Di Cosmo: added code to allow compressing and decompressing a single 
+                file instead of a full directory  (06/17/2001)                        
+ * ----------------------------------------------------------------------- */
+
 /*
  * mkzffile.c
  *
@@ -89,6 +94,8 @@
 int level = 9;			/* Compression level */
 int parallel = 0;		/* Parallelism (0 = strictly serial) */
 int onefs = 0;			/* One filesystem only */
+int onefile = 0;			/* One file only */
+int decompressing = 0;			/* Compression/decompression flag */
 enum verbosity verbosity = vl_error;	/* Default verbosity */
 
 /* Program name */
@@ -542,6 +549,60 @@
   return -1;
 }
 
+int munge_file(const char *in_path, const char *out_path, munger_func munger)
+{
+  FILE *in, *out;
+  int err = 0, rv = 0;
+  struct utimbuf ut;
+  struct stat st, sto;
+
+  message(vl_filename, "%s -> %s\n", in_path, out_path);
+
+    if ( lstat(in_path, &st) ) {
+      message(vl_error, "%s: Failed to stat file %s: %s\n",
+	      program, in_path, strerror(errno));
+      err = 1;
+    }
+    else if ( S_ISREG(st.st_mode) ) {
+	  /* Compress */
+            /* open the input and output files */
+            /* check for preexisting output file and continue only if -f is in action */
+            in = fopen(in_path, "rb");
+            if ( !in )
+              return -1;
+            if (! lstat(out_path, &sto) ) {  /* output file already exists! */
+              if (force ==0) {message(vl_error,"Cannot act on %s because %s already exist!\n",in_path,out_path); fclose(in);return -1;}}
+            out = fopen(out_path, "wb");
+            if ( !out ) {
+              err = errno;
+              fclose(in);
+              errno = err;
+              return -1;
+            }
+            /* do the actual work */
+              rv = munger(in, out, st.st_size);
+              
+              err = rv ? errno : 0;
+              fclose(in);
+              fclose(out);
+              
+#ifdef HAVE_LCHOWN
+                lchown(out_path, st.st_uid, st.st_gid);
+#endif
+#ifndef HAVE_LCHOWN
+                chown(out_path, st.st_uid, st.st_gid);
+#endif
+                chmod(out_path, st.st_mode);
+                ut.actime  = st.st_atime;
+                ut.modtime = st.st_mtime;
+                utime(out_path, &ut);
+    } else {
+      message(vl_error,"Skipping non regular file %s\n", in_path);
+    }
+  errno = err;
+  return rv;
+}
+
 int munge_path(const char *inpath, const char *outpath, struct stat *st, munger_func munger)
 {
   FILE *in, *out;
@@ -814,7 +875,8 @@
 static void usage(enum verbosity level, int err)
 {
   message(level,
-	  "Usage: %s [-vqfhux] [-p parallelism] [-z level] intree outtree\n",
+	  "Usage: %s [-vqfhux] [-p parallelism] [-z level] intree outtree\n   or: %s [-vqFhu] [-z level] infile outfile\n",
+	  program,
 	  program);
   exit(err);
 }
@@ -829,7 +891,7 @@
 
   program = argv[0];
 
-  while ( (opt = getopt(argc, argv, "vqfz:p:hux")) != EOF ) {
+  while ( (opt = getopt(argc, argv, "vqfFz:p:hux")) != EOF ) {
     switch(opt) {
     case 'f':
       force = 1;		/* Always compress */
@@ -853,6 +915,7 @@
       verbosity = vl_quiet;
       break;
     case 'u':
+      decompressing=1;
       munger = block_uncompress_file;
       break;
     case 'p':
@@ -861,6 +924,9 @@
     case 'x':
       onefs = 1;
       break;
+    case 'F':
+      onefile = 1;
+      break;
     default:
       usage(vl_error, 1);
       break;
@@ -870,6 +936,19 @@
   if ( (argc-optind) != 2 )
     usage(vl_error, 1);
 
+  if (onefile==1) { 
+    int l;
+    in = argv[optind];                         /* Input file  */
+    out = argv[optind+1];                      /* Output file */
+    if (decompressing==1) {
+      message(vl_filename, "Decompressing %s to %s\n", in,out);} 
+    else
+      message(vl_filename, "Compressing %s to %s\n", in,out);
+    munge_file(in,out,munger);
+  } else 
+  {
+
+
   in  = argv[optind];		/* Input tree */
   out = argv[optind+1];		/* Output tree */
 
@@ -897,4 +976,5 @@
   ut.actime  = st.st_atime;
   ut.modtime = st.st_mtime;
   utime(out, &ut);
+  }
 }

