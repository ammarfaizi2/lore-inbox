Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbUDHG5i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 02:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbUDHG5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 02:57:35 -0400
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:31132 "EHLO kiwi.cs.ucla.edu")
	by vger.kernel.org with ESMTP id S261996AbUDHG5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 02:57:01 -0400
To: bug-coreutils@gnu.org
Cc: Andy Isaacson <adi@hexapodia.org>, Andrew Morton <akpm@osdl.org>,
       Bruce Allen <ballen@gravity.phys.uwm.edu>, linux-kernel@vger.kernel.org
Subject: Re: dd PATCH: add conv=direct
References: <Pine.GSO.4.21.0404071627530.9017-100000@dirac.phys.uwm.edu>
From: Paul Eggert <eggert@CS.UCLA.EDU>
Date: Wed, 07 Apr 2004 23:56:28 -0700
In-Reply-To: <Pine.GSO.4.21.0404071627530.9017-100000@dirac.phys.uwm.edu> (Bruce
 Allen's message of "Wed, 7 Apr 2004 16:35:27 -0500 (CDT)")
Message-ID: <87r7uzlzz7.fsf@penguin.cs.ucla.edu>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bruce Allen <ballen@gravity.phys.uwm.edu> writes:

> let me argue that it ALSO makes sense to allow O_DIRECT (as an
> independent option) on the input side.

At the end of this message is a proposed patch to implement everything
people other than myself have asked for so far, along with several
other things since I was in the neighborhood.

This patch adds the following NEWS entry, which I'll repeat here to
make it easy to see what's going on:

  dd has new conversions for the conv= option:

    nocreat   do not create the output file
    excl      fail if the output file already exists
    fdatasync physically write output file data before finishing
    fsync     likewise, but also write metadata

  dd has new iflags= and oflags= options with the following flags:

    append    append mode (makes sense for output file only)
    direct    use direct I/O for data
    dsync     use synchronized I/O for data
    sync      likewise, but also for metadata
    nonblock  use non-blocking I/O
    nofollow  do not follow symlinks
    noctty    do not assign controlling terminal from file

This patch is relative to coreutils CVS, so your line numbers may
differ.  I didn't add hooks for Solaris-style directio, because that
turns out to be a systemwide property and perhaps should be in a
different command.

2004-04-07  Paul Eggert  <eggert@twinsun.com>

	* NEWS: New dd conv= symbols nocreat, excl, fdatasync, fsync,
	and new dd options iflag= and oflag=.
	* doc/coreutils.texi (dd invocation): Likewise.
	* src/dd.c (usage): Likewise.
	* m4/jm-macros.m4 (jm_MACROS): Check for fdatasync within
	-lrt and -lposix4, so that it can be used in Solaris 2.5.1 and later.
	* src/Makefile.am (dd_LDADD, shred_LDADD): Add fdatasync's lib.
	* src/dd.c (fdatasync) [!HAVE_FDATASYNC]: New macro.
	(C_NOCREAT, C_EXCL, C_FDATASYNC, C_FSYNC): New macros.
	(input_flags, output_flags): New vars.
	(LONGEST_SYMBOL): New macro.
	(struct symbol_value): Renamed from struct conversion.  Members
	symbol and value renamed from convname and conversion.  The
	symbol value is now an array instead of a pointer; this saves
	a bit of space and time in practice.  All uses changed.
	(conversions): Add nocreat, excl, fdatasync, fsync.  Now const.
	(flags): New constant array.
	(iflag_error_msgid, oflag_error_msgid): New constants.
	(parse_symbols): Renamed from parse_conversion and generalized
	to handle either conversion or flag symbols.
	(scanargs): Adjust uses of parse_symbols accodingly.  Add
	support for iflag= and oflag=.  Reject attempts to use
	both excl and nocreat.
	(set_fd_flags): New function.
	(dd_copy): Just return X rather than calling quit (X), since our
	caller invokes quit with the returned value.  Add support for
	fdatasync and fsync.
	(main): Add support for iflags=, oflags=, and new conv= symbols.
	* src/system.h (O_DIRECT, O_DSYNC, O_NDELAY, O_NOFOLLOW,
	O_RSYNC, O_SYNC): Define to 0 if not already defined.
	
	* NEWS: Remove duplicate mention of BLOCKSIZE.

Index: NEWS
===================================================================
RCS file: /home/meyering/coreutils/cu/NEWS,v
retrieving revision 1.198
diff -p -u -r1.198 NEWS
--- NEWS	7 Apr 2004 10:56:00 -0000	1.198
+++ NEWS	8 Apr 2004 04:01:34 -0000
@@ -9,14 +9,24 @@ GNU coreutils NEWS                      
 
 ** New features
 
-   stty now provides support (iutf8) for setting UTF-8 input mode.
+  dd has new conversions for the conv= option:
 
-   'df', 'du', and 'ls' now take the default block size from the
-   BLOCKSIZE environment variable if the BLOCK_SIZE, DF_BLOCK_SIZE,
-   DU_BLOCK_SIZE, and LS_BLOCK_SIZE environment variables are not set.
-   Unlike the other variables, though, BLOCKSIZE does not affect
-   values like 'ls -l' sizes that are normally displayed as bytes.
-   This new behavior is for compatibility with BSD.
+    nocreat   do not create the output file
+    excl      fail if the output file already exists
+    fdatasync physically write output file data before finishing
+    fsync     likewise, but also write metadata
+
+  dd has new iflags= and oflags= options with the following flags:
+
+    append    append mode (makes sense for output file only)
+    direct    use direct I/O for data
+    dsync     use synchronized I/O for data
+    sync      likewise, but also for metadata
+    nonblock  use non-blocking I/O
+    nofollow  do not follow symlinks
+    noctty    do not assign controlling terminal from file
+
+  stty now provides support (iutf8) for setting UTF-8 input mode.
 
   With stat, a specified format is no longer automatically newline terminated.
   If you want a newline at the end of your output, append `\n' to the format
Index: doc/coreutils.texi
===================================================================
RCS file: /home/meyering/coreutils/cu/doc/coreutils.texi,v
retrieving revision 1.175
diff -p -u -r1.175 coreutils.texi
--- doc/coreutils.texi	7 Apr 2004 09:50:48 -0000	1.175
+++ doc/coreutils.texi	8 Apr 2004 04:55:38 -0000
@@ -6580,6 +6580,17 @@ when an odd number of bytes are read---t
 @cindex read errors, ignoring
 Continue after read errors.
 
+@item nocreat
+@opindex nocreat
+@cindex creating output file, avoiding
+Do not create the output file; the output file must already exist.
+
+@item excl
+@opindex excl
+@cindex creating output file, requiring
+Fail if the output file already exists; @command{dd} must create the
+output file itself.
+
 @item notrunc
 @opindex notrunc
 @cindex truncating output file, avoiding
@@ -6590,7 +6601,85 @@ Do not truncate the output file.
 Pad every input block to size of @samp{ibs} with trailing zero bytes.
 When used with @samp{block} or @samp{unblock}, pad with spaces instead of
 zero bytes.
+
+@item fdatasync
+@opindex fdatasync
+@cindex synchronized data writes, before finishing
+Synchronize output data just before finishing.  This forces a physical
+write of output data.
+
+@item fsync
+@opindex fsync
+@cindex synchronized data and metadata writes, before finishing
+Synchronize output data and metadata just before finishing.  This
+forces a physical write of output data and metadata.
+
+@end table
+
+@item iflag=@var{flag}[,@var{flag}]@dots{}
+@opindex iflag
+Access the input file using the flags specified by the @var{flag}
+argument(s).  (No spaces around any comma(s).)
+
+@item oflag=@var{flag}[,@var{flag}]@dots{}
+@opindex oflag
+Access the output file using the flags specified by the @var{flag}
+argument(s).  (No spaces around any comma(s).)
+
+Flags:
+
+@table @samp
+
+@item append
+@opindex append
+@cindex appending to the output file
+Write in append mode, so that even if some other process is writing to
+this file, every @command{dd} write will append to the current
+contents of the file.  This flag makes sense only for output.
+
+@item direct
+@opindex direct
+@cindex direct I/O
+Use direct I/O for data, avoiding the buffer cache.
+
+@item dsync
+@opindex dsync
+@cindex synchronized data reads
+Use synchronized I/O for data.  For the output file, this forces a
+physical write of output data on each write.  For the input file,
+this flag can matter when reading from a remote file that has been
+written to synchronously by some other process.  Metadata (e.g.,
+last-access and last-modified time) is not necessarily synchronized.
+
+@item sync
+@opindex sync
+@cindex synchronized data and metadata I/O
+Use synchronized I/O for both data and metadata.
+
+@item nonblock
+@opindex nonblock
+@cindex nonblocking I/O
+Use non-blocking I/O.
+
+@item nofollow
+@opindex nofollow
+@cindex symbolic links, following
+Do not follow symbolic links.
+
+@item noctty
+@opindex noctty
+@cindex controlling terminal
+Do not assign the file to be a controlling terminal for @command{dd}.
+This has no effect when the file is not a terminal.
+
 @end table
+
+These flags are not supported on all systems, and @samp{dd} rejects
+attempts to use them when they are not supported.  When reading from
+standard input or writing to standard output, the @samp{nofollow} and
+@samp{noctty} flags should not be specified, and the other flags
+(e.g., @samp{nonblock}) can affect how other processes behave with the
+affected file descriptors, even after @command{dd} exits.
 
 @end table
 
Index: m4/jm-macros.m4
===================================================================
RCS file: /home/meyering/coreutils/cu/m4/jm-macros.m4,v
retrieving revision 1.184
diff -p -u -r1.184 jm-macros.m4
--- m4/jm-macros.m4	20 Dec 2003 17:57:30 -0000	1.184
+++ m4/jm-macros.m4	8 Apr 2004 05:30:05 -0000
@@ -81,7 +81,6 @@ AC_DEFUN([jm_MACROS],
   AC_CHECK_FUNCS( \
     endgrent \
     endpwent \
-    fdatasync \
     ftruncate \
     gethrtime \
     hasmntopt \
@@ -110,6 +109,15 @@ AC_DEFUN([jm_MACROS],
   AC_FUNC_STRTOD
   AC_REQUIRE([GL_FUNC_GETCWD_PATH_MAX])
   AC_REQUIRE([GL_FUNC_READDIR])
+
+  # for dd.c and shred.c
+  fetish_saved_libs=$LIBS
+    AC_SEARCH_LIBS([fdatasync], [rt posix4],
+		   [test "$ac_cv_search_fdatasync" = "none required" ||
+		    LIB_FDATASYNC=$ac_cv_search_fdatasync])
+    AC_SUBST([LIB_FDATASYNC])
+    AC_CHECK_FUNCS(fdatasync)
+  LIBS=$fetish_saved_libs
 
   # See if linking `seq' requires -lm.
   # It does on nearly every system.  The single exception (so far) is
Index: src/Makefile.am
===================================================================
RCS file: /home/meyering/coreutils/cu/src/Makefile.am,v
retrieving revision 1.34
diff -p -u -r1.34 Makefile.am
--- src/Makefile.am	17 Mar 2004 10:14:17 -0000	1.34
+++ src/Makefile.am	8 Apr 2004 05:23:13 -0000
@@ -32,10 +32,11 @@ AM_CPPFLAGS = -I.. -I$(srcdir) -I$(top_s
 # replacement functions defined in libfetish.a.
 LDADD = ../lib/libfetish.a $(LIBINTL) ../lib/libfetish.a
 
-# for clock_gettime
+# for clock_gettime and fdatasync
+dd_LDADD = $(LDADD) $(LIB_FDATASYNC)
 dir_LDADD = $(LDADD) $(LIB_CLOCK_GETTIME)
 ls_LDADD = $(LDADD) $(LIB_CLOCK_GETTIME)
-shred_LDADD = $(LDADD) $(LIB_CLOCK_GETTIME)
+shred_LDADD = $(LDADD) $(LIB_CLOCK_GETTIME) $(LIB_FDATASYNC)
 vdir_LDADD = $(LDADD) $(LIB_CLOCK_GETTIME)
 
 ## If necessary, add -lm to resolve use of pow in lib/strtod.c.
Index: src/dd.c
===================================================================
RCS file: /home/meyering/coreutils/cu/src/dd.c,v
retrieving revision 1.154
diff -p -u -r1.154 dd.c
--- src/dd.c	21 Jan 2004 22:53:49 -0000	1.154
+++ src/dd.c	8 Apr 2004 06:26:20 -0000
@@ -49,6 +49,10 @@
 # define S_TYPEISSHM(Stat_ptr) 0
 #endif
 
+#if ! HAVE_FDATASYNC
+# define fdatasync(fd) (errno = ENOSYS, -1)
+#endif
+
 #define ROUND_UP_OFFSET(X, M) ((M) - 1 - (((X) + (M) - 1) % (M)))
 #define PTR_ALIGN(Ptr, M) ((Ptr) \
 			   + ROUND_UP_OFFSET ((char *)(Ptr) - (char *)0, (M)))
@@ -80,6 +84,10 @@
 #define C_SYNC 02000
 /* Use separate input and output buffers, and combine partial input blocks. */
 #define C_TWOBUFS 04000
+#define C_NOCREAT 010000
+#define C_EXCL 020000
+#define C_FDATASYNC 040000
+#define C_FSYNC 0100000
 
 /* The name this program was run with. */
 char *program_name;
@@ -111,6 +119,10 @@ static uintmax_t max_records = (uintmax_
 /* Bit vector of conversions to apply. */
 static int conversions_mask = 0;
 
+/* Open flags for the input and output files.  */
+static int input_flags = 0;
+static int output_flags = 0;
+
 /* If nonzero, filter characters through the translation table.  */
 static int translation_needed = 0;
 
@@ -143,13 +155,18 @@ static size_t oc = 0;
 /* Index into current line, for `conv=block' and `conv=unblock'.  */
 static size_t col = 0;
 
-struct conversion
+/* A longest symbol in the struct symbol_values table below.  */
+#define LONGEST_SYMBOL "fdatasync"
+
+/* A symbol and the corresponding integer value.  */
+struct symbol_value
 {
-  char *convname;
-  int conversion;
+  char symbol[sizeof LONGEST_SYMBOL];
+  int value;
 };
 
-static struct conversion conversions[] =
+/* Conversion symbols, for conv="...".  */
+static struct symbol_value const conversions[] =
 {
   {"ascii", C_ASCII | C_TWOBUFS},	/* EBCDIC to ASCII. */
   {"ebcdic", C_EBCDIC | C_TWOBUFS},	/* ASCII to EBCDIC. */
@@ -160,9 +177,26 @@ static struct conversion conversions[] =
   {"ucase", C_UCASE | C_TWOBUFS},	/* Translate lower to upper case. */
   {"swab", C_SWAB | C_TWOBUFS},	/* Swap bytes of input. */
   {"noerror", C_NOERROR},	/* Ignore i/o errors. */
+  {"nocreat", C_NOCREAT},	/* Do not create output file.  */
+  {"excl", C_EXCL},		/* Fail if the output file already exists.  */
   {"notrunc", C_NOTRUNC},	/* Do not truncate output file. */
   {"sync", C_SYNC},		/* Pad input records to ibs with NULs. */
-  {NULL, 0}
+  {"fdatasync", C_FDATASYNC},	/* Synchronize output data before finishing.  */
+  {"fsync", C_FSYNC},		/* Also synchronize output metadata.  */
+  {"", 0}
+};
+
+/* Flags, for iflag="..." and oflag="...".  */
+static struct symbol_value const flags[] =
+{
+  {"append",	O_APPEND},
+  {"direct",	O_DIRECT},
+  {"dsync",	O_DSYNC},
+  {"noctty",	O_NOCTTY},
+  {"nofollow",	O_NOFOLLOW},
+  {"nonblock",	O_NONBLOCK},
+  {"sync",	O_SYNC},
+  {"",		0}
 };
 
 /* Translation table formed by applying successive transformations. */
@@ -290,14 +324,16 @@ Copy a file, converting and formatting a
 \n\
   bs=BYTES        force ibs=BYTES and obs=BYTES\n\
   cbs=BYTES       convert BYTES bytes at a time\n\
-  conv=KEYWORDS   convert the file as per the comma separated keyword list\n\
+  conv=CONVS      convert the file as per the comma separated symbol list\n\
   count=BLOCKS    copy only BLOCKS input blocks\n\
   ibs=BYTES       read BYTES bytes at a time\n\
 "), stdout);
       fputs (_("\
   if=FILE         read from FILE instead of stdin\n\
+  iflag=FLAGS     read as per the comma separated symbol list\n\
   obs=BYTES       write BYTES bytes at a time\n\
   of=FILE         write to FILE instead of stdout\n\
+  oflag=FLAGS     write as per the comma separated symbol list\n\
   seek=BLOCKS     skip BLOCKS obs-sized blocks at start of output\n\
   skip=BLOCKS     skip BLOCKS ibs-sized blocks at start of input\n\
 "), stdout);
@@ -308,7 +344,8 @@ Copy a file, converting and formatting a
 BLOCKS and BYTES may be followed by the following multiplicative suffixes:\n\
 xM M, c 1, w 2, b 512, kB 1000, K 1024, MB 1000*1000, M 1024*1024,\n\
 GB 1000*1000*1000, G 1024*1024*1024, and so on for T, P, E, Z, Y.\n\
-Each KEYWORD may be:\n\
+\n\
+Each CONV symbol may be:\n\
 \n\
 "), stdout);
       fputs (_("\
@@ -320,15 +357,38 @@ Each KEYWORD may be:\n\
   lcase     change upper case to lower case\n\
 "), stdout);
       fputs (_("\
+  nocreat   do not create the output file\n\
+  excl      fail if the output file already exists\n\
   notrunc   do not truncate the output file\n\
   ucase     change lower case to upper case\n\
   swab      swap every pair of input bytes\n\
   noerror   continue after read errors\n\
   sync      pad every input block with NULs to ibs-size; when used\n\
               with block or unblock, pad with spaces rather than NULs\n\
+  fdatasync physically write output file data before finishing\n\
+  fsync     likewise, but also write metadata\n\
 "), stdout);
       fputs (_("\
 \n\
+Each FLAG symbol may be:\n\
+\n\
+  append    append mode (makes sense only for output)\n\
+"), stdout);
+      if (O_DIRECT)
+	fputs (_("  direct    use direct I/O for data\n"), stdout);
+      if (O_DSYNC)
+	fputs (_("  dsync     use synchronized I/O for data\n"), stdout);
+      if (O_SYNC)
+	fputs (_("  sync      likewise, but also for metadata\n"), stdout);
+      if (O_NONBLOCK)
+	fputs (_("  nonblock  use non-blocking I/O\n"), stdout);
+      if (O_NOFOLLOW)
+	fputs (_("  nofollow  do not follow symlinks\n"), stdout);
+      if (O_NOCTTY)
+	fputs (_("  noctty    do not assign controlling terminal from file\n"),
+	       stdout);
+      fputs (_("\
+\n\
 Note that sending a SIGUSR1 signal to a running `dd' process makes it\n\
 print to standard error the number of records read and written so far,\n\
 then to resume copying.\n\
@@ -486,33 +546,47 @@ write_output (void)
   oc = 0;
 }
 
-/* Interpret one "conv=..." option.
+/* Diagnostics for invalid iflag="..." and oflag="..." symbols.  */
+static char const iflag_error_msgid[] = N_("invalid input flag: %s");
+static char const oflag_error_msgid[] = N_("invalid output flag: %s");
+
+/* Interpret one "conv=..." or similar option STR according to the
+   symbols in TABLE, returning the flags specified.  If the option
+   cannot be parsed, use ERROR_MSGID to generate a diagnostic.
    As a by product, this function replaces each `,' in STR with a NUL byte.  */
 
-static void
-parse_conversion (char *str)
+static int
+parse_symbols (char *str, struct symbol_value const *table,
+	       char const *error_msgid)
 {
-  char *new;
-  int i;
+  int value = 0;
 
   do
     {
-      new = strchr (str, ',');
+      struct symbol_value const *entry;
+      char *new = strchr (str, ',');
       if (new != NULL)
 	*new++ = '\0';
-      for (i = 0; conversions[i].convname != NULL; i++)
-	if (STREQ (conversions[i].convname, str))
-	  {
-	    conversions_mask |= conversions[i].conversion;
-	    break;
-	  }
-      if (conversions[i].convname == NULL)
+      for (entry = table; ; entry++)
 	{
-	  error (0, 0, _("invalid conversion: %s"), quote (str));
-	  usage (EXIT_FAILURE);
+	  if (! entry->symbol[0])
+	    {
+	      error (0, 0, _(error_msgid), quote (str));
+	      usage (EXIT_FAILURE);
+	    }
+	  if (STREQ (entry->symbol, str))
+	    {
+	      if (! entry->value)
+		error (EXIT_FAILURE, 0, _(error_msgid), quote (str));
+	      value |= entry->value;
+	      break;
+	    }
 	}
       str = new;
-  } while (new != NULL);
+    }
+  while (str);
+
+  return value;
 }
 
 /* Return the value of STR, interpreted as a non-negative decimal integer,
@@ -574,7 +648,12 @@ scanargs (int argc, char **argv)
       else if (STREQ (name, "of"))
 	output_file = val;
       else if (STREQ (name, "conv"))
-	parse_conversion (val);
+	conversions_mask |= parse_symbols (val, conversions,
+					   N_("invalid conversion: %s"));
+      else if (STREQ (name, "iflag"))
+	input_flags |= parse_symbols (val, flags, iflag_error_msgid);
+      else if (STREQ (name, "oflag"))
+	output_flags |= parse_symbols (val, flags, oflag_error_msgid);
       else
 	{
 	  int invalid = 0;
@@ -638,6 +717,12 @@ scanargs (int argc, char **argv)
     output_blocksize = DEFAULT_BLOCKSIZE;
   if (conversion_blocksize == 0)
     conversions_mask &= ~(C_BLOCK | C_UNBLOCK);
+
+  if (input_flags & (O_DSYNC | O_SYNC))
+    input_flags |= O_RSYNC;
+
+  if ((conversions_mask & (C_EXCL | C_NOCREAT)) == (C_EXCL | C_NOCREAT))
+    error (EXIT_FAILURE, 0, _("cannot combine excl and nocreat"));
 }
 
 /* Fix up translation table. */
@@ -928,6 +1013,22 @@ copy_with_unblock (char const *buf, size
     }
 }
 
+/* Set the file descriptor flags for FD that correspond to the nonzero bits
+   in FLAGS.  The file's name is NAME.  */
+
+static void
+set_fd_flags (int fd, int flags, char const *name)
+{
+  if (flags)
+    {
+      int old_flags = fcntl (fd, F_GETFL);
+      int new_flags = old_flags | flags;
+      if (old_flags < 0
+	  || (new_flags != old_flags && fcntl (fd, F_SETFL, new_flags) == -1))
+	error (EXIT_FAILURE, errno, _("setting flags for %s"), quote (name));
+    }
+}
+
 /* The main loop.  */
 
 static int
@@ -994,7 +1095,7 @@ dd_copy (void)
     }
 
   if (max_records == 0)
-    quit (exit_status);
+    return exit_status;
 
   while (1)
     {
@@ -1061,7 +1162,7 @@ dd_copy (void)
 	  if (nwritten != n_bytes_read)
 	    {
 	      error (0, errno, _("writing %s"), quote (output_file));
-	      quit (EXIT_FAILURE);
+	      return EXIT_FAILURE;
 	    }
 	  else if (n_bytes_read == input_blocksize)
 	    w_full++;
@@ -1122,7 +1223,7 @@ dd_copy (void)
       if (nwritten != oc)
 	{
 	  error (0, errno, _("writing %s"), quote (output_file));
-	  quit (EXIT_FAILURE);
+	  return EXIT_FAILURE;
 	}
     }
 
@@ -1130,6 +1231,24 @@ dd_copy (void)
   if (real_obuf)
     free (real_obuf);
 
+  if ((conversions_mask & C_FDATASYNC) && fdatasync (STDOUT_FILENO) != 0)
+    {
+      if (errno != ENOSYS && errno != EINVAL)
+	{
+	  error (0, errno, "fdatasync %s", quote (output_file));
+	  exit_status = EXIT_FAILURE;
+	}
+      conversions_mask |= C_FSYNC;
+    }
+
+  if (conversions_mask & C_FSYNC)
+    while (fsync (STDOUT_FILENO) != 0)
+      if (errno != EINTR)
+	{
+	  error (0, errno, "fsync %s", quote (output_file));
+	  return EXIT_FAILURE;
+	}
+
   return exit_status;
 }
 
@@ -1174,19 +1293,29 @@ main (int argc, char **argv)
 
   apply_translations ();
 
-  if (input_file != NULL)
+  if (input_file == NULL)
     {
-      if (open_fd (STDIN_FILENO, input_file, O_RDONLY, 0) < 0)
-	error (EXIT_FAILURE, errno, _("opening %s"), quote (input_file));
+      input_file = _("standard input");
+      set_fd_flags (STDIN_FILENO, input_flags, input_file);
     }
   else
-    input_file = _("standard input");
+    {
+      if (open_fd (STDIN_FILENO, input_file, O_RDONLY | input_flags, 0) < 0)
+	error (EXIT_FAILURE, errno, _("opening %s"), quote (input_file));
+    }
 
-  if (output_file != NULL)
+  if (output_file == NULL)
+    {
+      output_file = _("standard output");
+      set_fd_flags (STDOUT_FILENO, output_flags, output_file);
+    }
+  else
     {
       mode_t perms = S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH;
       int opts
-	= (O_CREAT
+	= (output_flags
+	   | (conversions_mask & C_NOCREAT ? 0 : O_CREAT)
+	   | (conversions_mask & C_EXCL ? O_EXCL : 0)
 	   | (seek_records || (conversions_mask & C_NOTRUNC) ? 0 : O_TRUNC));
 
       /* Open the output file with *read* access only if we might
@@ -1210,8 +1339,8 @@ main (int argc, char **argv)
 		   quote (output_file));
 
 	  /* Complain only when ftruncate fails on a regular file, a
-	     directory, or a shared memory object, as the 2000-08
-	     POSIX draft specifies ftruncate's behavior only for these
+	     directory, or a shared memory object, as
+	     POSIX 1003.1-2003 specifies ftruncate's behavior only for these
 	     file types.  For example, do not complain when Linux 2.4
 	     ftruncate fails on /dev/fd0.  */
 	  if (ftruncate (STDOUT_FILENO, o) != 0
@@ -1226,10 +1355,6 @@ main (int argc, char **argv)
 	    }
 	}
 #endif
-    }
-  else
-    {
-      output_file = _("standard output");
     }
 
   install_handler (SIGINT, interrupt_handler);
Index: src/system.h
===================================================================
RCS file: /home/meyering/coreutils/cu/src/system.h,v
retrieving revision 1.82
diff -p -u -r1.82 system.h
--- src/system.h	6 Apr 2004 13:55:00 -0000	1.82
+++ src/system.h	8 Apr 2004 03:39:01 -0000
@@ -197,6 +197,14 @@ initialize_exit_failure (int status)
 # define O_TEXT _O_TEXT
 #endif
 
+#if !defined O_DIRECT
+# define O_DIRECT 0
+#endif
+
+#if !defined O_DSYNC
+# define O_DSYNC 0
+#endif
+
 #if !defined O_NDELAY
 # define O_NDELAY 0
 #endif
@@ -207,6 +215,18 @@ initialize_exit_failure (int status)
 
 #if !defined O_NOCTTY
 # define O_NOCTTY 0
+#endif
+
+#if !defined O_NOFOLLOW
+# define O_NOFOLLOW 0
+#endif
+
+#if !defined O_RSYNC
+# define O_RSYNC 0
+#endif
+
+#if !defined O_SYNC
+# define O_SYNC 0
 #endif
 
 #ifdef __BEOS__
