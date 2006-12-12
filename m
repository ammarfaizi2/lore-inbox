Return-Path: <linux-kernel-owner+w=401wt.eu-S1751576AbWLLUnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbWLLUnX (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 15:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbWLLUnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 15:43:22 -0500
Received: from smtp1.netcabo.pt ([212.113.174.28]:43762 "EHLO
	exch01smtp10.hdi.tvcabo" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751576AbWLLUnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 15:43:21 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CANajfkXVFtNER2dsb2JhbACNSgEBKg
Date: Tue, 12 Dec 2006 20:43:16 +0000
From: Luciano Miguel Ferreira Rocha <strange@nsk.no-ip.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] usr/gen_init_cpio.c: support for hard links
Message-ID: <20061212204316.GC25353@nsk.no-ip.org>
Mail-Followup-To: Luciano Miguel Ferreira Rocha <strange@nsk.no-ip.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 12 Dec 2006 20:43:20.0135 (UTC) FILETIME=[28923D70:01C71E2E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luciano Rocha <strange@nsk.no-ip.org>

Extend usr/gen_init_cpio.c "file" entry, adding support for hard links.

Previous format:
file <name> <location> <mode> <uid> <gid>

New format:
file <name> <location> <mode> <uid> <gid> [<hard links>]

The hard links specification is optional, keeping the previous
behaviour.

All hard links are defined sequentially in the resulting cpio and the
file data is present only in the last link. This is the behaviour of
GNU's cpio and is supported by the kernel initramfs extractor.

Signed-off-by: Luciano Rocha <strange@nsk.no-ip.org>

---

diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
index 83acd6c..8365db6 100644
--- a/usr/gen_init_cpio.c
+++ b/usr/gen_init_cpio.c
@@ -14,6 +14,7 @@ #include <limits.h>
  * Original work by Jeff Garzik
  *
  * External file lists, symlink, pipe and fifo support by Thayne Harbaugh
+ * Hard link support by Luciano Rocha
  */
 
 #define xstr(s) #s
@@ -286,16 +287,19 @@ static int cpio_mknod_line(const char *l
 	return rc;
 }
 
-/* Not marked static to keep the compiler quiet, as no one uses this yet... */
 static int cpio_mkfile(const char *name, const char *location,
-			unsigned int mode, uid_t uid, gid_t gid)
+			unsigned int mode, uid_t uid, gid_t gid,
+			unsigned int nlinks)
 {
 	char s[256];
 	char *filebuf = NULL;
 	struct stat buf;
+	long size;
 	int file = -1;
 	int retval;
 	int rc = -1;
+	int namesize;
+	int i;
 
 	mode |= S_IFREG;
 
@@ -323,29 +327,41 @@ static int cpio_mkfile(const char *name,
 		goto error;
 	}
 
-	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
-	       "%08X%08X%08X%08X%08X%08X%08X",
-		"070701",		/* magic */
-		ino++,			/* ino */
-		mode,			/* mode */
-		(long) uid,		/* uid */
-		(long) gid,		/* gid */
-		1,			/* nlink */
-		(long) buf.st_mtime,	/* mtime */
-		(int) buf.st_size,	/* filesize */
-		3,			/* major */
-		1,			/* minor */
-		0,			/* rmajor */
-		0,			/* rminor */
-		(unsigned)strlen(name) + 1,/* namesize */
-		0);			/* chksum */
-	push_hdr(s);
-	push_string(name);
-	push_pad();
+	size = 0;
+	for (i = 1; i <= nlinks; i++) {
+		/* data goes on last link */
+		if (i == nlinks) size = buf.st_size;
+
+		namesize = strlen(name) + 1;
+		sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
+		       "%08lX%08X%08X%08X%08X%08X%08X",
+			"070701",		/* magic */
+			ino,			/* ino */
+			mode,			/* mode */
+			(long) uid,		/* uid */
+			(long) gid,		/* gid */
+			nlinks,			/* nlink */
+			(long) buf.st_mtime,	/* mtime */
+			size,			/* filesize */
+			3,			/* major */
+			1,			/* minor */
+			0,			/* rmajor */
+			0,			/* rminor */
+			namesize,		/* namesize */
+			0);			/* chksum */
+		push_hdr(s);
+		push_string(name);
+		push_pad();
+
+		if (size) {
+			fwrite(filebuf, size, 1, stdout);
+			offset += size;
+			push_pad();
+		}
 
-	fwrite(filebuf, buf.st_size, 1, stdout);
-	offset += buf.st_size;
-	push_pad();
+		name += namesize;
+	}
+	ino++;
 	rc = 0;
 	
 error:
@@ -357,18 +373,51 @@ error:
 static int cpio_mkfile_line(const char *line)
 {
 	char name[PATH_MAX + 1];
+	char *dname = NULL; /* malloc'ed buffer for hard links */
 	char location[PATH_MAX + 1];
 	unsigned int mode;
 	int uid;
 	int gid;
+	int nlinks = 1;
+	int end = 0, dname_len = 0;
 	int rc = -1;
 
-	if (5 != sscanf(line, "%" str(PATH_MAX) "s %" str(PATH_MAX) "s %o %d %d", name, location, &mode, &uid, &gid)) {
+	if (5 > sscanf(line, "%" str(PATH_MAX) "s %" str(PATH_MAX)
+				"s %o %d %d %n",
+				name, location, &mode, &uid, &gid, &end)) {
 		fprintf(stderr, "Unrecognized file format '%s'", line);
 		goto fail;
 	}
-	rc = cpio_mkfile(name, location, mode, uid, gid);
+	if (end && isgraph(line[end])) {
+		int len;
+		int nend;
+
+		dname = malloc(strlen(line));
+		if (!dname) {
+			fprintf (stderr, "out of memory (%d)\n", dname_len);
+			goto fail;
+		}
+
+		dname_len = strlen(name) + 1;
+		memcpy(dname, name, dname_len);
+
+		do {
+			nend = 0;
+			if (sscanf(line + end, "%" str(PATH_MAX) "s %n",
+					name, &nend) < 1)
+				break;
+			len = strlen(name) + 1;
+			memcpy(dname + dname_len, name, len);
+			dname_len += len;
+			nlinks++;
+			end += nend;
+		} while (isgraph(line[end]));
+	} else {
+		dname = name;
+	}
+	rc = cpio_mkfile(dname, location, mode, uid, gid, nlinks);
  fail:
+	if (dname_len) free(dname);
 	return rc;
 }
 
@@ -381,22 +430,23 @@ void usage(const char *prog)
 		"describe the files to be included in the initramfs archive:\n"
 		"\n"
 		"# a comment\n"
-		"file <name> <location> <mode> <uid> <gid>\n"
+		"file <name> <location> <mode> <uid> <gid> [<hard links>]\n"
 		"dir <name> <mode> <uid> <gid>\n"
 		"nod <name> <mode> <uid> <gid> <dev_type> <maj> <min>\n"
 		"slink <name> <target> <mode> <uid> <gid>\n"
 		"pipe <name> <mode> <uid> <gid>\n"
 		"sock <name> <mode> <uid> <gid>\n"
 		"\n"
-		"<name>      name of the file/dir/nod/etc in the archive\n"
-		"<location>  location of the file in the current filesystem\n"
-		"<target>    link target\n"
-		"<mode>      mode/permissions of the file\n"
-		"<uid>       user id (0=root)\n"
-		"<gid>       group id (0=root)\n"
-		"<dev_type>  device type (b=block, c=character)\n"
-		"<maj>       major number of nod\n"
-		"<min>       minor number of nod\n"
+		"<name>       name of the file/dir/nod/etc in the archive\n"
+		"<location>   location of the file in the current filesystem\n"
+		"<target>     link target\n"
+		"<mode>       mode/permissions of the file\n"
+		"<uid>        user id (0=root)\n"
+		"<gid>        group id (0=root)\n"
+		"<dev_type>   device type (b=block, c=character)\n"
+		"<maj>        major number of nod\n"
+		"<min>        minor number of nod\n"
+		"<hard links> space separated list of other links to file\n"
 		"\n"
 		"example:\n"
 		"# A simple initramfs\n"
