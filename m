Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261968AbTCHAwb>; Fri, 7 Mar 2003 19:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261756AbTCHAwa>; Fri, 7 Mar 2003 19:52:30 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:33548 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261975AbTCHAnF>;
	Fri, 7 Mar 2003 19:43:05 -0500
Date: Fri, 7 Mar 2003 16:43:40 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] gen_init_cpio fixes for 2.5.64
Message-ID: <20030308004340.GB23071@kroah.com>
References: <20030305060817.GC26458@kroah.com> <20030308004249.GA23071@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030308004249.GA23071@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet 1.1124, 2003/03/07 16:39:06-08:00, greg@kroah.com

gen_init_cpio: Add the ability to add files to the cpio image.


 usr/gen_init_cpio.c |   90 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 90 insertions(+)


diff -Nru a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
--- a/usr/gen_init_cpio.c	Fri Mar  7 16:48:24 2003
+++ b/usr/gen_init_cpio.c	Fri Mar  7 16:48:24 2003
@@ -5,10 +5,28 @@
 #include <string.h>
 #include <unistd.h>
 #include <time.h>
+#include <fcntl.h>
 
 static unsigned int offset;
 static unsigned int ino = 721;
 
+static void push_string(const char *name)
+{
+	unsigned int name_len = strlen(name) + 1;
+
+	fputs(name, stdout);
+	putchar(0);
+	offset += name_len;
+}
+
+static void push_pad (void)
+{
+	while (offset & 3) {
+		putchar(0);
+		offset++;
+	}
+}
+
 static void push_rest(const char *name)
 {
 	unsigned int name_len = strlen(name) + 1;
@@ -118,6 +136,78 @@
 		0);			/* chksum */
 	push_hdr(s);
 	push_rest(name);
+}
+
+/* Not marked static to keep the compiler quiet, as no one uses this yet... */
+void cpio_mkfile(const char *filename, const char *location,
+			unsigned int mode, uid_t uid, gid_t gid)
+{
+	char s[256];
+	char *filebuf;
+	struct stat buf;
+	int file;
+	int retval;
+	int i;
+
+	mode |= S_IFREG;
+
+	retval = stat (filename, &buf);
+	if (retval) {
+		fprintf (stderr, "Filename %s could not be located\n", filename);
+		goto error;
+	}
+
+	file = open (filename, O_RDONLY);
+	if (file < 0) {
+		fprintf (stderr, "Filename %s could not be opened for reading\n", filename);
+		goto error;
+	}
+
+	filebuf = malloc(buf.st_size);
+	if (!filebuf) {
+		fprintf (stderr, "out of memory\n");
+		goto error_close;
+	}
+
+	retval = read (file, filebuf, buf.st_size);
+	if (retval < 0) {
+		fprintf (stderr, "Can not read %s file\n", filename);
+		goto error_free;
+	}
+
+	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
+	       "%08X%08X%08X%08X%08X%08X%08X",
+		"070701",		/* magic */
+		ino++,			/* ino */
+		mode,			/* mode */
+		(long) uid,		/* uid */
+		(long) gid,		/* gid */
+		1,			/* nlink */
+		(long) buf.st_mtime,	/* mtime */
+		(int) buf.st_size,	/* filesize */
+		3,			/* major */
+		1,			/* minor */
+		0,			/* rmajor */
+		0,			/* rminor */
+		strlen(location) + 1,	/* namesize */
+		0);			/* chksum */
+	push_hdr(s);
+	push_string(location);
+	push_pad();
+
+	for (i = 0; i < buf.st_size; ++i)
+		fputc(filebuf[i], stdout);
+	close(file);
+	free(filebuf);
+	push_pad();
+	return;
+	
+error_free:
+	free(filebuf);
+error_close:
+	close(file);
+error:
+	exit(-1);
 }
 
 int main (int argc, char *argv[])
