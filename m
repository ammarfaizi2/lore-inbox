Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288058AbSBRWBZ>; Mon, 18 Feb 2002 17:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288050AbSBRWBQ>; Mon, 18 Feb 2002 17:01:16 -0500
Received: from CompactServ-SUrNet.ll.surnet.ru ([195.54.9.58]:54773 "EHLO
	zzz.zzz") by vger.kernel.org with ESMTP id <S288040AbSBRWBH>;
	Mon, 18 Feb 2002 17:01:07 -0500
Date: Tue, 19 Feb 2002 03:00:04 +0500
From: Denis Zaitsev <zzz@cd-club.ru>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] a little strings-aware code change
Message-ID: <20020219030003.D1639@zzz.zzz.zzz>
In-Reply-To: <200202180612.g1I6C4L25410@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200202180612.g1I6C4L25410@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Sun, Feb 17, 2002 at 11:12:04PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This little patch does nothing with the functionality of devfsd, but
with the C code.  There are a number of constructions like:

       [PFXLEN = strlen(prefix);]
        if (strncmp(str, prefix, PFXLEN) == 0)
                do_something_with(str + PFXLEN);

It is not the best way to do such a things.  The idea is to implement
the special function, which will test the string for some prefix and
return the address of a place of the string after that prefix or NULL
in case of an absence of the success.  The construction above becomes
better:

        if (ptr= strtry(str, prefix))
                do_something_with(ptr);

And the new function itself is more lightweight than alone strncmp,
and just much more effective than <strlen + strncmp> in a couple.  It
is good again.  So, all the idea seems to be healthy.  I call this
function "strtry", as it tries its arg for the given prefix.

Richard, please, apply this patch, if you find it useful.  It is
against devfsd-1.3.22.  By the way, I've arranged the
        strrchr (devname, '/') + 1
stuff, so this thing to be done once instead of multiply times in the
original.


diff -dpruN devfsd-1.3.22.orig/GNUmakefile devfsd-1.3.22/GNUmakefile
--- devfsd-1.3.22.orig/GNUmakefile	Tue Jan 15 09:09:29 2002
+++ devfsd-1.3.22/GNUmakefile	Sun Feb 17 22:03:11 2002
@@ -58,4 +58,5 @@ distclean: clean
 
 
 # Dependencies: made by hand
-devfsd.o: devfsd.h version.h
+devfsd.o: devfsd.h strtry.h version.h
+compat_name.o: strtry.h
diff -dpruN devfsd-1.3.22.orig/compat_name.c devfsd-1.3.22/compat_name.c
--- devfsd-1.3.22.orig/compat_name.c	Mon Jan 21 02:05:57 2002
+++ devfsd-1.3.22/compat_name.c	Sun Feb 17 22:34:04 2002
@@ -71,6 +71,7 @@
 #  include <string.h>
 #  include <ctype.h>
 #endif
+#include "strtry.h"
 
 #ifndef IDE6_MAJOR        /*  In case we're building with an ancient kernel  */
 #  define IDE6_MAJOR      88
@@ -137,35 +138,31 @@ const char *get_old_name (const char *de
 */
 {
     const char *compat_name = NULL;
-    char *ptr;
+    char *ptr, *rsl = strrchr (devname, '/') + 1;/* right slash + 1 */
     struct translate_struct *trans;
 
     for (trans = translate_table; trans->match != NULL; ++trans)
-    {
-	size_t len = strlen (trans->match);
-
-	if (strncmp (devname, trans->match, len) == 0)
+	if (ptr = strtry (devname, trans->match))
 	{
-	    if (trans->format == NULL) return (devname + len);
-	    sprintf (buffer, trans->format, devname + len);
+	    if (trans->format == NULL) return (ptr);
+	    sprintf (buffer, trans->format, ptr);
 	    return (buffer);
 	}
-    }
-    if (strncmp (devname, "sbp/", 4) == 0)
+    if (strtry (devname, "sbp/"))
     {
 	sprintf (buffer, "sbpcd%u", minor);
 	compat_name = buffer;
     }
-    else if (strncmp (devname, "scsi/", 5) == 0)
+    else if (strtry (devname, "scsi/"))
     {   /*  All SCSI devices  */
 	if (strcmp (devname + namelen - 7, "generic") == 0)
 	{
 	    sprintf (buffer, "sg%u", minor);
 	    compat_name = buffer;
 	}
-	else if (strncmp (ptr = (strrchr (devname, '/') + 1), "mt", 2) == 0)
+	else if (ptr = strtry (rsl, "mt"))
 	{
-	    char mode = ptr[2];
+	    char mode = *ptr;
 
 	    if (mode == 'n') mode = '\0';
 	    sprintf (buffer, "nst%u%c", minor & 0x1f, mode);
@@ -179,15 +176,15 @@ const char *get_old_name (const char *de
 	}
 	else if (strcmp (devname + namelen - 4, "disc") == 0)
 	    compat_name = write_old_sd_name (buffer, major, minor, "");
-	else if (strncmp (ptr = (strrchr (devname, '/') + 1), "part", 4) == 0)
-	    compat_name = write_old_sd_name (buffer, major, minor, ptr + 4);
+	else if (ptr = strtry (rsl, "part"))
+	    compat_name = write_old_sd_name (buffer, major, minor, ptr);
 	return (compat_name);
     }
-    else if (strncmp (devname, "ide/host", 8) == 0)
+    else if (strtry (devname, "ide/host"))
     {   /*  All IDE devices  */
-	if (strncmp (ptr = (strrchr (devname, '/') + 1), "mt", 2) == 0)
+	if (ptr = strtry (rsl, "mt"))
 	{
-	    sprintf (buffer, "%sht%d", ptr + 2, minor & 0x7f);
+	    sprintf (buffer, "%sht%d", ptr, minor & 0x7f);
 	    compat_name = buffer;
 	}
 	else if (strcmp (devname + namelen - 4, "disc") == 0)
@@ -196,10 +193,10 @@ const char *get_old_name (const char *de
 		      get_old_ide_name (major, minor) );
 	    compat_name = buffer;
 	}
-	else if (strncmp (ptr = (strrchr (devname, '/') + 1), "part", 4) == 0)
+	else if (ptr = strtry (rsl, "part"))
 	{
 	    sprintf (buffer, "hd%c%s",
-		     get_old_ide_name (major, minor), ptr + 4);
+		     get_old_ide_name (major, minor), ptr);
 	    compat_name = buffer;
 	}
 	else if (strcmp (devname + namelen - 2, "cd") == 0)
@@ -210,20 +207,20 @@ const char *get_old_name (const char *de
 	}
 	return (compat_name);
     }
-    else if (strncmp (devname, "vcc/", 4) == 0)
+    else if (ptr = strtry (devname, "vcc/"))
     {
-	sprintf (buffer, "vcs%s", devname + 4);
+	sprintf (buffer, "vcs%s", ptr);
 	if (buffer[3] == '0') buffer[3] = '\0';
 	compat_name = buffer;
     }
-    else if (strncmp (devname, "pty/", 4) == 0)
+    else if (ptr = strtry (devname, "pty/"))
     {
-	int index = atoi (devname + 5);
+	int index = atoi (ptr + 1);
 	const char *pty1 = "pqrstuvwxyzabcde";
 	const char *pty2 = "0123456789abcdef";
 
 	sprintf (buffer, "%cty%c%c",
-		 (devname[4] == 'm') ? 'p' : 't',
+		 (*ptr == 'm') ? 'p' : 't',
 		 pty1[index >> 4], pty2[index & 0x0f]);
 	compat_name = buffer;
     }
diff -dpruN devfsd-1.3.22.orig/devfsd.c devfsd-1.3.22/devfsd.c
--- devfsd-1.3.22.orig/devfsd.c	Mon Jan 21 02:07:31 2002
+++ devfsd-1.3.22/devfsd.c	Sun Feb 17 21:58:18 2002
@@ -273,6 +273,7 @@
 #include <rpcsvc/yp_prot.h>
 #include <karma.h>
 #include "devfsd.h"
+#include "strtry.h"
 #include "version.h"
 
 #ifndef RTLD_DEFAULT  /*  Libc 5 doesn't define it, but it works  */
@@ -1416,7 +1417,7 @@ static void action_compat (const struct 
 {
     const char *compat_name = NULL;
     const char *dest_name = info->devname;
-    char *ptr;
+    char *ptr, *rsl = strrchr (info->devname, '/') + 1;/* right slash + 1 */
     char compat_buf[STRING_LENGTH], dest_buf[STRING_LENGTH];
     static char function_name[] = "action_compat";
 
@@ -1430,22 +1431,21 @@ static void action_compat (const struct 
 	break;
       case AC_MKNEWCOMPAT:
       case AC_RMNEWCOMPAT:
-	if (strncmp (info->devname, "scsi/", 5) == 0)
+	if (ptr = strtry (info->devname, "scsi/"))
 	{
 	    int mode, host, bus, target, lun;
 
-	    sscanf (info->devname + 5, "host%d/bus%d/target%d/lun%d/",
+	    sscanf (ptr, "host%d/bus%d/target%d/lun%d/",
 		    &host, &bus, &target, &lun);
 	    compat_name = compat_buf;
 	    snprintf (dest_buf, sizeof (dest_buf), "../%s", info->devname);
 	    dest_name = dest_buf;
-	    if (strncmp (ptr = (strrchr (info->devname, '/') + 1), "mt", 2)
-		== 0)
+	    if (ptr = strtry (rsl, "mt"))
 	    {
 		char rewind = info->devname[info->namelen - 1];
 
 		if (rewind != 'n') rewind = '\0';
-		switch (ptr[2])
+		switch (*ptr)
 		{
 		  default:
 		    mode = 0;
@@ -1472,36 +1472,33 @@ static void action_compat (const struct 
 	    else if (strcmp (info->devname + info->namelen - 4, "disc") == 0)
 		sprintf (compat_buf, "sd/c%db%dt%du%d",
 			 host, bus, target, lun);
-	    else if (strncmp (ptr = (strrchr (info->devname, '/') + 1), "part",
-			      4) == 0)
+	    else if (ptr = strtry (rsl, "part"))
 		sprintf ( compat_buf, "sd/c%db%dt%du%dp%d",
-			  host, bus, target, lun, atoi (ptr + 4) );
+			  host, bus, target, lun, atoi (ptr) );
 	    else compat_name = NULL;
 	}
-	else if (strncmp (info->devname, "ide/host", 8) == 0)
+	else if (ptr = strtry (info->devname, "ide/host"))
 	{
 	    int host, bus, target, lun;
 
-	    sscanf (info->devname + 4, "host%d/bus%d/target%d/lun%d/",
+	    sscanf (ptr, "%d/bus%d/target%d/lun%d/",
 		    &host, &bus, &target, &lun);
 	    compat_name = compat_buf;
-	    snprintf (dest_buf, sizeof (dest_buf), "../%s", info->devname + 4);
+	    snprintf (dest_buf, sizeof (dest_buf), "../%s", ptr - 4);
 	    dest_name = dest_buf;
 	    if (strcmp (info->devname + info->namelen - 4, "disc") == 0)
 		sprintf (compat_buf, "ide/hd/c%db%dt%du%d",
 			 host, bus, target, lun);
-	    else if (strncmp (ptr = (strrchr (info->devname, '/') + 1), "part",
-			      4) == 0)
+	    else if (ptr = strtry (rsl, "part"))
 		sprintf ( compat_buf, "ide/hd/c%db%dt%du%dp%d",
-			  host, bus, target, lun, atoi (ptr + 4) );
+			  host, bus, target, lun, atoi (ptr) );
 	    else if (strcmp (info->devname + info->namelen - 2, "cd") == 0)
 		sprintf (compat_buf, "ide/cd/c%db%dt%du%d",
 			 host, bus, target,lun);
-	    else if (strncmp (ptr = (strrchr (info->devname, '/') + 1), "mt",
-			      2) == 0)
+	    else if (ptr = strtry (rsl, "mt"))
 		snprintf (compat_buf, sizeof (compat_buf),
 			  "ide/mt/c%db%dt%du%d%s",
-			  host, bus, target, lun, ptr + 2);
+			  host, bus, target, lun, ptr);
 	    else compat_name = NULL;
 	}
 	break;
diff -dpruN devfsd-1.3.22.orig/strtry.h devfsd-1.3.22/strtry.h
--- devfsd-1.3.22.orig/strtry.h	Thu Jan  1 05:00:00 1970
+++ devfsd-1.3.22/strtry.h	Sun Feb 17 21:38:10 2002
@@ -0,0 +1,11 @@
+/*
+  Tries if a string begins from some prefix. Returns an address of a
+  char after that prefix or NULL.
+*/
+extern inline
+char *strtry(const char *s, const char *try)
+{
+    char c;
+    do if (!(c= *try++)) return (char*)s;
+    while (*s++ == c); return NULL;
+}
