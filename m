Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292837AbSB0Sia>; Wed, 27 Feb 2002 13:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292885AbSB0SiO>; Wed, 27 Feb 2002 13:38:14 -0500
Received: from erasmus.off.net ([64.39.30.25]:261 "EHLO erasmus.off.net")
	by vger.kernel.org with ESMTP id <S292883AbSB0Shz>;
	Wed, 27 Feb 2002 13:37:55 -0500
Date: Wed, 27 Feb 2002 13:37:55 -0500
From: Zach Brown <zab@zabbo.net>
To: linux-kernel@vger.kernel.org
Cc: Jes Sorensen <jes@trained-monkey.org>
Subject: Re: [BETA] First test release of Tigon3 driver
Message-ID: <20020227133755.H30524@erasmus.off.net>
In-Reply-To: <20020227125611.A20415@stud.ntnu.no> <20020227.040653.58455636.davem@redhat.com> <20020227132454.B24996@stud.ntnu.no> <20020227.042845.54186884.davem@redhat.com> <20020227.042845.54186884.davem@redhat.com>; <20020227170321.B22422@stud.ntnu.no> <3C7D0510.2C300D12@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C7D0510.2C300D12@redhat.com>; from arjanv@redhat.com on Wed, Feb 27, 2002 at 04:10:56PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Any programs or anything that could do a serious stresstest?  (Both hosts
> > are Dell PowerEdge 2550, RedHat Linux 7.2).
> 
> google for nttcp
> runs a nice tcp performance test...

I dig on gensink:

	http://jes.home.cern.ch/jes/gensink/

the attached hack gives it the ability to tx with sendfile() from a
ftruncate()ed tmpfile based on the presence of a 5th argument, which can
be fun with scatter/csum capable cards.  I've put up some rpms for the
lazy:

	http://www.zabbo.net/rpms/gensink/

5aa66dfd7749c77cb58de22fad96de  gensink-4.1-1sendfile.i386.rpm
04912a63bda95a79b6b835f340c924c2  gensink-4.1-1sendfile.src.rpm

enjoy.

- z

diff -urN gensink-4.1.orig/gen4.c gensink-4.1/gen4.c
--- gensink-4.1.orig/gen4.c	Wed May 16 10:08:01 2001
+++ gensink-4.1/gen4.c	Wed Feb 27 10:24:27 2002
@@ -48,20 +48,101 @@
 
 #include <sys/ioctl.h>
 
+#include <sys/sendfile.h>
+
+void sendfile_loop(int s, int rec_len)
+{
+	char *tmpdir_default = "/tmp";
+	char template[PATH_MAX];
+	char *tmpdir;
+	int fd;
+	int i;
+	ssize_t bytes_written;
+	off_t offset;
+
+	tmpdir = getenv("TMPDIR");
+	if ( tmpdir == NULL )
+		tmpdir = tmpdir_default;
+
+	snprintf(template, PATH_MAX, "%s/XXXXXX", tmpdir);
+
+	fd = mkstemp(template);
+	if ( fd < 0 ) {
+		perror("couldn't mkstemp() sendfile() backing file");
+		exit(-1);
+	}
+
+	unlink(template);
+
+	if ( ftruncate(fd, RECORD_BUFFER_SIZE + rec_len) < 0 ) {
+		perror("frunctate() backing file");
+		exit(-1);
+	}
+
+	offset = 0;
+
+	for (i = 1; i < 4000000; i++)
+	{
+		/* loop writing blocks */
+		if ((bytes_written = sendfile(s,fd,&offset,rec_len)) < 0) 
+			oops("write");
+		if ((bytes = bytes + bytes_written) >= REPORT_FREQ) 
+		{
+			report(1, "source", bytes);
+			bytes = 0;
+		}
+
+		if ( offset >= RECORD_BUFFER_SIZE )
+			offset = 0;
+	}
+
+	close(fd);
+}
+
+void write_loop(int s, int rec_len)
+{
+	char *record_buffer, *orig_record_ptr;
+	int i, bytes_written;
+
+	record_buffer = (char *)malloc(RECORD_BUFFER_SIZE + rec_len);
+	if (!record_buffer) {
+		fprintf(stderr, "Unable to allocate memory for transmit buffer\n");
+		exit(-1);
+	}
+
+	orig_record_ptr = record_buffer;
+	memset(record_buffer, 0, RECORD_BUFFER_SIZE);
+
+	for (i = 1; i < 4000000; i++)
+	{
+		/* loop writing blocks */
+		if ((bytes_written = write(s,record_buffer,rec_len)) < 0) 
+			oops("write");
+		if ((bytes = bytes + bytes_written) >= REPORT_FREQ) 
+		{
+			report(1, "source", bytes);
+			bytes = 0;
+		}
+		record_buffer += rec_len;
+		if ((unsigned long)record_buffer > (unsigned long)(orig_record_ptr + RECORD_BUFFER_SIZE))
+			record_buffer = orig_record_ptr;
+	}
+	free(orig_record_ptr);
+}
+
 int main(argc, argv)
 int argc; 
 char *argv[];
 {
 	struct sockaddr_in saddr;
-	char *record_buffer, *orig_record_ptr;
 	char reptext[256], *hostname;
-	int portnum, rec_len, bytes_written;
-	int i;
+	int portnum, rec_len;
+	int use_sendfile = 0;
 
 	/* check argument count */
-	if(argc != 5) 
+	if(argc < 5 || argc > 6)
 	{
-		fprintf(stderr,"Usage: %s server_host server_port record_length setsockopt\n", argv[0]);
+		fprintf(stderr, "Usage: %s server_host server_port record_length setsockopt [use_sendfile_boolean]\n", argv[0]);
 		exit(-1);
 	}
 
@@ -73,16 +154,11 @@
 		exit(-1);
 	}
 
-	record_buffer = (char *)malloc(RECORD_BUFFER_SIZE + rec_len);
-	if (!record_buffer) {
-		fprintf(stderr, "Unable to allocate memory for transmit buffer\n");
-		exit(-1);
-	}
-	orig_record_ptr = record_buffer;
-	memset(record_buffer, 0, RECORD_BUFFER_SIZE);
-
 	max = atoi(argv[4]);
 
+	if ( argc == 6 ) 
+		use_sendfile = atoi(argv[5]);
+
 	strcpy(reptext,"");
 	/* get the record length */
 	strncat(reptext, " reclen=", 255 - strlen(reptext));
@@ -122,24 +198,17 @@
   
 	printf("Max seg TCP : %d\n",maxseg);
 
+	printf("sending with %s\n", 
+		use_sendfile ? "sendfile(2)" : "write(2)");
+
 	/* initialise reporting */
 	report_start(reptext,1,0,1,argv);
 	report(1, "source", 0); 
 
-	for (i = 1; i < 4000000; i++)
-	{
-		/* loop writing blocks */
-		if ((bytes_written = write(s,record_buffer,rec_len)) < 0) 
-			oops("write");
-		if ((bytes = bytes + bytes_written) >= REPORT_FREQ) 
-		{
-			report(1, "source", bytes);
-			bytes = 0;
-		}
-		record_buffer += rec_len;
-		if ((unsigned long)record_buffer > (unsigned long)(orig_record_ptr + RECORD_BUFFER_SIZE))
-			record_buffer = orig_record_ptr;
-	}
-	free(orig_record_ptr);
+	if ( use_sendfile )
+		sendfile_loop(s, rec_len);
+	else
+		write_loop(s, rec_len);
+
 	return 0;
 }
