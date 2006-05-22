Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751571AbWEVD6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbWEVD6H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 23:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbWEVD44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 23:56:56 -0400
Received: from xenotime.net ([66.160.160.81]:11223 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751567AbWEVD4a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 23:56:30 -0400
Date: Sun, 21 May 2006 20:57:55 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, rgooch@atnf.csiro.au
Subject: [PATCH 13/14/] Doc. sources: expose mtrr
Message-Id: <20060521205755.65f19f4c.rdunlap@xenotime.net>
In-Reply-To: <20060521203349.40b40930.rdunlap@xenotime.net>
References: <20060521203349.40b40930.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Documentation/mtrr.txt:
Expose example and tool source files in the Documentation/ directory in
their own files instead of being buried (almost hidden) in readme/txt files.

This will make them more visible/usable to users who may need
to use them, to developers who may need to test with them, and
to janitors who would update them if they were more visible.

Also, if any of these possibly should not be in the kernel tree at
all, it will be clearer that they are here and we can discuss if
they should be removed.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/mtrr-add.c  |  105 +++++++++++++++++++++++
 Documentation/mtrr-show.c |   93 +++++++++++++++++++++
 Documentation/mtrr.txt    |  202 ----------------------------------------------
 3 files changed, 201 insertions(+), 199 deletions(-)

--- /dev/null
+++ linux-2617-rc4g9-docsrc-split/Documentation/mtrr-add.c
@@ -0,0 +1,105 @@
+/*  mtrr-add.c
+
+    Source file for mtrr-add (example programme to add an MTRRs using ioctl())
+
+    Copyright (C) 1997-1998  Richard Gooch
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+
+    Richard Gooch may be reached by email at  rgooch@atnf.csiro.au
+    The postal address is:
+      Richard Gooch, c/o ATNF, P. O. Box 76, Epping, N.S.W., 2121, Australia.
+*/
+
+/*
+    This programme will use an ioctl() on /proc/mtrr to add an entry. The first
+    available mtrr is used. This is an alternative to writing /proc/mtrr.
+
+
+    Written by      Richard Gooch   17-DEC-1997
+
+    Last updated by Richard Gooch   2-MAY-1998
+
+
+*/
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <errno.h>
+#include <asm/mtrr.h>
+
+#define TRUE 1
+#define FALSE 0
+#define ERRSTRING strerror (errno)
+
+static char *mtrr_strings[MTRR_NUM_TYPES] =
+{
+    "uncachable",               /* 0 */
+    "write-combining",          /* 1 */
+    "?",                        /* 2 */
+    "?",                        /* 3 */
+    "write-through",            /* 4 */
+    "write-protect",            /* 5 */
+    "write-back",               /* 6 */
+};
+
+int main (int argc, char **argv)
+{
+    int fd;
+    struct mtrr_sentry sentry;
+
+    if (argc != 4)
+    {
+	fprintf (stderr, "Usage:\tmtrr-add base size type\n");
+	exit (1);
+    }
+    sentry.base = strtoul (argv[1], NULL, 0);
+    sentry.size = strtoul (argv[2], NULL, 0);
+    for (sentry.type = 0; sentry.type < MTRR_NUM_TYPES; ++sentry.type)
+    {
+	if (strcmp (argv[3], mtrr_strings[sentry.type]) == 0) break;
+    }
+    if (sentry.type >= MTRR_NUM_TYPES)
+    {
+	fprintf (stderr, "Illegal type: \"%s\"\n", argv[3]);
+	exit (2);
+    }
+    if ( ( fd = open ("/proc/mtrr", O_WRONLY, 0) ) == -1 )
+    {
+	if (errno == ENOENT)
+	{
+	    fputs ("/proc/mtrr not found: not supported or you don't have a PPro?\n",
+		   stderr);
+	    exit (3);
+	}
+	fprintf (stderr, "Error opening /proc/mtrr\t%s\n", ERRSTRING);
+	exit (4);
+    }
+    if (ioctl (fd, MTRRIOC_ADD_ENTRY, &sentry) == -1)
+    {
+	fprintf (stderr, "Error doing ioctl(2) on /dev/mtrr\t%s\n", ERRSTRING);
+	exit (5);
+    }
+    fprintf (stderr, "Sleeping for 5 seconds so you can see the new entry\n");
+    sleep (5);
+    close (fd);
+    fputs ("I've just closed /proc/mtrr so now the new entry should be gone\n",
+	   stderr);
+}   /*  End Function main  */
--- /dev/null
+++ linux-2617-rc4g9-docsrc-split/Documentation/mtrr-show.c
@@ -0,0 +1,93 @@
+/*  mtrr-show.c
+
+    Source file for mtrr-show (example program to show MTRRs using ioctl()'s)
+
+    Copyright (C) 1997-1998  Richard Gooch
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+
+    Richard Gooch may be reached by email at  rgooch@atnf.csiro.au
+    The postal address is:
+      Richard Gooch, c/o ATNF, P. O. Box 76, Epping, N.S.W., 2121, Australia.
+*/
+
+/*
+    This program will use an ioctl() on /proc/mtrr to show the current MTRR
+    settings. This is an alternative to reading /proc/mtrr.
+
+
+    Written by      Richard Gooch   17-DEC-1997
+
+    Last updated by Richard Gooch   2-MAY-1998
+
+
+*/
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <errno.h>
+#include <asm/mtrr.h>
+
+#define TRUE 1
+#define FALSE 0
+#define ERRSTRING strerror (errno)
+
+static char *mtrr_strings[MTRR_NUM_TYPES] =
+{
+    "uncachable",               /* 0 */
+    "write-combining",          /* 1 */
+    "?",                        /* 2 */
+    "?",                        /* 3 */
+    "write-through",            /* 4 */
+    "write-protect",            /* 5 */
+    "write-back",               /* 6 */
+};
+
+int main ()
+{
+    int fd;
+    struct mtrr_gentry gentry;
+
+    if ( ( fd = open ("/proc/mtrr", O_RDONLY, 0) ) == -1 )
+    {
+	if (errno == ENOENT)
+	{
+	    fputs ("/proc/mtrr not found: not supported or you don't have a PPro?\n",
+		   stderr);
+	    exit (1);
+	}
+	fprintf (stderr, "Error opening /proc/mtrr\t%s\n", ERRSTRING);
+	exit (2);
+    }
+    for (gentry.regnum = 0; ioctl (fd, MTRRIOC_GET_ENTRY, &gentry) == 0;
+	 ++gentry.regnum)
+    {
+	if (gentry.size < 1)
+	{
+	    fprintf (stderr, "Register: %u disabled\n", gentry.regnum);
+	    continue;
+	}
+	fprintf (stderr, "Register: %u base: 0x%lx size: 0x%lx type: %s\n",
+		 gentry.regnum, gentry.base, gentry.size,
+		 mtrr_strings[gentry.type]);
+    }
+    if (errno == EINVAL) exit (0);
+    fprintf (stderr, "Error doing ioctl(2) on /dev/mtrr\t%s\n", ERRSTRING);
+    exit (3);
+}   /*  End Function main  */
--- linux-2617-rc4g9-docsrc-split.orig/Documentation/mtrr.txt
+++ linux-2617-rc4g9-docsrc-split/Documentation/mtrr.txt
@@ -100,206 +100,10 @@ or using bash:
 % echo "disable=2" >| /proc/mtrr
 ===============================================================================
 Reading MTRRs from a C program using ioctl()'s:
+See Documentation/mtrr-show.c
 
-/*  mtrr-show.c
-
-    Source file for mtrr-show (example program to show MTRRs using ioctl()'s)
-
-    Copyright (C) 1997-1998  Richard Gooch
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
-    Richard Gooch may be reached by email at  rgooch@atnf.csiro.au
-    The postal address is:
-      Richard Gooch, c/o ATNF, P. O. Box 76, Epping, N.S.W., 2121, Australia.
-*/
-
-/*
-    This program will use an ioctl() on /proc/mtrr to show the current MTRR
-    settings. This is an alternative to reading /proc/mtrr.
-
-
-    Written by      Richard Gooch   17-DEC-1997
-
-    Last updated by Richard Gooch   2-MAY-1998
-
-
-*/
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <sys/ioctl.h>
-#include <errno.h>
-#include <asm/mtrr.h>
-
-#define TRUE 1
-#define FALSE 0
-#define ERRSTRING strerror (errno)
-
-static char *mtrr_strings[MTRR_NUM_TYPES] =
-{
-    "uncachable",               /* 0 */
-    "write-combining",          /* 1 */
-    "?",                        /* 2 */
-    "?",                        /* 3 */
-    "write-through",            /* 4 */
-    "write-protect",            /* 5 */
-    "write-back",               /* 6 */
-};
-
-int main ()
-{
-    int fd;
-    struct mtrr_gentry gentry;
-
-    if ( ( fd = open ("/proc/mtrr", O_RDONLY, 0) ) == -1 )
-    {
-	if (errno == ENOENT)
-	{
-	    fputs ("/proc/mtrr not found: not supported or you don't have a PPro?\n",
-		   stderr);
-	    exit (1);
-	}
-	fprintf (stderr, "Error opening /proc/mtrr\t%s\n", ERRSTRING);
-	exit (2);
-    }
-    for (gentry.regnum = 0; ioctl (fd, MTRRIOC_GET_ENTRY, &gentry) == 0;
-	 ++gentry.regnum)
-    {
-	if (gentry.size < 1)
-	{
-	    fprintf (stderr, "Register: %u disabled\n", gentry.regnum);
-	    continue;
-	}
-	fprintf (stderr, "Register: %u base: 0x%lx size: 0x%lx type: %s\n",
-		 gentry.regnum, gentry.base, gentry.size,
-		 mtrr_strings[gentry.type]);
-    }
-    if (errno == EINVAL) exit (0);
-    fprintf (stderr, "Error doing ioctl(2) on /dev/mtrr\t%s\n", ERRSTRING);
-    exit (3);
-}   /*  End Function main  */
 ===============================================================================
-Creating MTRRs from a C programme using ioctl()'s:
-
-/*  mtrr-add.c
-
-    Source file for mtrr-add (example programme to add an MTRRs using ioctl())
-
-    Copyright (C) 1997-1998  Richard Gooch
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
-    Richard Gooch may be reached by email at  rgooch@atnf.csiro.au
-    The postal address is:
-      Richard Gooch, c/o ATNF, P. O. Box 76, Epping, N.S.W., 2121, Australia.
-*/
-
-/*
-    This programme will use an ioctl() on /proc/mtrr to add an entry. The first
-    available mtrr is used. This is an alternative to writing /proc/mtrr.
-
-
-    Written by      Richard Gooch   17-DEC-1997
-
-    Last updated by Richard Gooch   2-MAY-1998
-
-
-*/
-#include <stdio.h>
-#include <string.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <sys/ioctl.h>
-#include <errno.h>
-#include <asm/mtrr.h>
-
-#define TRUE 1
-#define FALSE 0
-#define ERRSTRING strerror (errno)
-
-static char *mtrr_strings[MTRR_NUM_TYPES] =
-{
-    "uncachable",               /* 0 */
-    "write-combining",          /* 1 */
-    "?",                        /* 2 */
-    "?",                        /* 3 */
-    "write-through",            /* 4 */
-    "write-protect",            /* 5 */
-    "write-back",               /* 6 */
-};
-
-int main (int argc, char **argv)
-{
-    int fd;
-    struct mtrr_sentry sentry;
+Creating MTRRs from a C program using ioctl()'s:
+See Documentation/mtrr-add.c
 
-    if (argc != 4)
-    {
-	fprintf (stderr, "Usage:\tmtrr-add base size type\n");
-	exit (1);
-    }
-    sentry.base = strtoul (argv[1], NULL, 0);
-    sentry.size = strtoul (argv[2], NULL, 0);
-    for (sentry.type = 0; sentry.type < MTRR_NUM_TYPES; ++sentry.type)
-    {
-	if (strcmp (argv[3], mtrr_strings[sentry.type]) == 0) break;
-    }
-    if (sentry.type >= MTRR_NUM_TYPES)
-    {
-	fprintf (stderr, "Illegal type: \"%s\"\n", argv[3]);
-	exit (2);
-    }
-    if ( ( fd = open ("/proc/mtrr", O_WRONLY, 0) ) == -1 )
-    {
-	if (errno == ENOENT)
-	{
-	    fputs ("/proc/mtrr not found: not supported or you don't have a PPro?\n",
-		   stderr);
-	    exit (3);
-	}
-	fprintf (stderr, "Error opening /proc/mtrr\t%s\n", ERRSTRING);
-	exit (4);
-    }
-    if (ioctl (fd, MTRRIOC_ADD_ENTRY, &sentry) == -1)
-    {
-	fprintf (stderr, "Error doing ioctl(2) on /dev/mtrr\t%s\n", ERRSTRING);
-	exit (5);
-    }
-    fprintf (stderr, "Sleeping for 5 seconds so you can see the new entry\n");
-    sleep (5);
-    close (fd);
-    fputs ("I've just closed /proc/mtrr so now the new entry should be gone\n",
-	   stderr);
-}   /*  End Function main  */
 ===============================================================================


---
