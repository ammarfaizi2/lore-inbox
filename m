Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751577AbWEVD7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbWEVD7t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 23:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbWEVD40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 23:56:26 -0400
Received: from xenotime.net ([66.160.160.81]:4823 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751184AbWEVD4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 23:56:23 -0400
Date: Sun, 21 May 2006 20:57:35 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: mchehab@infradead.org, akpm <akpm@osdl.org>
Subject: [PATCH 3/14/] Doc. sources: expose video4linux/
Message-Id: <20060521205735.ca958add.rdunlap@xenotime.net>
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

Documentation/video4linux/:
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
 Documentation/video4linux/CQcam.txt |  203 ------------------------------------
 Documentation/video4linux/v4lgrab.c |  192 ++++++++++++++++++++++++++++++++++
 2 files changed, 195 insertions(+), 200 deletions(-)

--- linux-2617-rc4g9-docsrc-split.orig/Documentation/video4linux/CQcam.txt
+++ linux-2617-rc4g9-docsrc-split/Documentation/video4linux/CQcam.txt
@@ -185,207 +185,10 @@ this work is documented at the video4lin
 
 9.0 --- A sample program using v4lgrabber,
 
-This program is a simple image grabber that will copy a frame from the
+v4lgrab is a simple image grabber that will copy a frame from the
 first video device, /dev/video0 to standard output in portable pixmap
-format (.ppm)  Using this like: 'v4lgrab | convert - c-qcam.jpg'
-produced this picture of me at
-    http://mug.sys.virginia.edu/~drf5n/extras/c-qcam.jpg
-
--------------------- 8< ---------------- 8< -----------------------------
-
-/* Simple Video4Linux image grabber. */
-/*
- *	Video4Linux Driver Test/Example Framegrabbing Program
- *
- *	Compile with:
- *		gcc -s -Wall -Wstrict-prototypes v4lgrab.c -o v4lgrab
- *      Use as:
- *              v4lgrab >image.ppm
- *
- *	Copyright (C) 1998-05-03, Phil Blundell <philb@gnu.org>
- *      Copied from http://www.tazenda.demon.co.uk/phil/vgrabber.c
- *      with minor modifications (Dave Forrest, drf5n@virginia.edu).
- *
- */
-
-#include <unistd.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <stdio.h>
-#include <sys/ioctl.h>
-#include <stdlib.h>
-
-#include <linux/types.h>
-#include <linux/videodev.h>
-
-#define FILE "/dev/video0"
-
-/* Stole this from tvset.c */
-
-#define READ_VIDEO_PIXEL(buf, format, depth, r, g, b)                   \
-{                                                                       \
-	switch (format)                                                 \
-	{                                                               \
-		case VIDEO_PALETTE_GREY:                                \
-			switch (depth)                                  \
-			{                                               \
-				case 4:                                 \
-				case 6:                                 \
-				case 8:                                 \
-					(r) = (g) = (b) = (*buf++ << 8);\
-					break;                          \
-									\
-				case 16:                                \
-					(r) = (g) = (b) =               \
-						*((unsigned short *) buf);      \
-					buf += 2;                       \
-					break;                          \
-			}                                               \
-			break;                                          \
-									\
-									\
-		case VIDEO_PALETTE_RGB565:                              \
-		{                                                       \
-			unsigned short tmp = *(unsigned short *)buf;    \
-			(r) = tmp&0xF800;                               \
-			(g) = (tmp<<5)&0xFC00;                          \
-			(b) = (tmp<<11)&0xF800;                         \
-			buf += 2;                                       \
-		}                                                       \
-		break;                                                  \
-									\
-		case VIDEO_PALETTE_RGB555:                              \
-			(r) = (buf[0]&0xF8)<<8;                         \
-			(g) = ((buf[0] << 5 | buf[1] >> 3)&0xF8)<<8;    \
-			(b) = ((buf[1] << 2 ) & 0xF8)<<8;               \
-			buf += 2;                                       \
-			break;                                          \
-									\
-		case VIDEO_PALETTE_RGB24:                               \
-			(r) = buf[0] << 8; (g) = buf[1] << 8;           \
-			(b) = buf[2] << 8;                              \
-			buf += 3;                                       \
-			break;                                          \
-									\
-		default:                                                \
-			fprintf(stderr,                                 \
-				"Format %d not yet supported\n",        \
-				format);                                \
-	}                                                               \
-}
-
-int get_brightness_adj(unsigned char *image, long size, int *brightness) {
-  long i, tot = 0;
-  for (i=0;i<size*3;i++)
-    tot += image[i];
-  *brightness = (128 - tot/(size*3))/3;
-  return !((tot/(size*3)) >= 126 && (tot/(size*3)) <= 130);
-}
-
-int main(int argc, char ** argv)
-{
-  int fd = open(FILE, O_RDONLY), f;
-  struct video_capability cap;
-  struct video_window win;
-  struct video_picture vpic;
-
-  unsigned char *buffer, *src;
-  int bpp = 24, r, g, b;
-  unsigned int i, src_depth;
-
-  if (fd < 0) {
-    perror(FILE);
-    exit(1);
-  }
-
-  if (ioctl(fd, VIDIOCGCAP, &cap) < 0) {
-    perror("VIDIOGCAP");
-    fprintf(stderr, "(" FILE " not a video4linux device?)\n");
-    close(fd);
-    exit(1);
-  }
-
-  if (ioctl(fd, VIDIOCGWIN, &win) < 0) {
-    perror("VIDIOCGWIN");
-    close(fd);
-    exit(1);
-  }
-
-  if (ioctl(fd, VIDIOCGPICT, &vpic) < 0) {
-    perror("VIDIOCGPICT");
-    close(fd);
-    exit(1);
-  }
-
-  if (cap.type & VID_TYPE_MONOCHROME) {
-    vpic.depth=8;
-    vpic.palette=VIDEO_PALETTE_GREY;    /* 8bit grey */
-    if(ioctl(fd, VIDIOCSPICT, &vpic) < 0) {
-      vpic.depth=6;
-      if(ioctl(fd, VIDIOCSPICT, &vpic) < 0) {
-	vpic.depth=4;
-	if(ioctl(fd, VIDIOCSPICT, &vpic) < 0) {
-	  fprintf(stderr, "Unable to find a supported capture format.\n");
-	  close(fd);
-	  exit(1);
-	}
-      }
-    }
-  } else {
-    vpic.depth=24;
-    vpic.palette=VIDEO_PALETTE_RGB24;
-
-    if(ioctl(fd, VIDIOCSPICT, &vpic) < 0) {
-      vpic.palette=VIDEO_PALETTE_RGB565;
-      vpic.depth=16;
-
-      if(ioctl(fd, VIDIOCSPICT, &vpic)==-1) {
-	vpic.palette=VIDEO_PALETTE_RGB555;
-	vpic.depth=15;
-
-	if(ioctl(fd, VIDIOCSPICT, &vpic)==-1) {
-	  fprintf(stderr, "Unable to find a supported capture format.\n");
-	  return -1;
-	}
-      }
-    }
-  }
-
-  buffer = malloc(win.width * win.height * bpp);
-  if (!buffer) {
-    fprintf(stderr, "Out of memory.\n");
-    exit(1);
-  }
-
-  do {
-    int newbright;
-    read(fd, buffer, win.width * win.height * bpp);
-    f = get_brightness_adj(buffer, win.width * win.height, &newbright);
-    if (f) {
-      vpic.brightness += (newbright << 8);
-      if(ioctl(fd, VIDIOCSPICT, &vpic)==-1) {
-	perror("VIDIOSPICT");
-	break;
-      }
-    }
-  } while (f);
-
-  fprintf(stdout, "P6\n%d %d 255\n", win.width, win.height);
-
-  src = buffer;
-
-  for (i = 0; i < win.width * win.height; i++) {
-    READ_VIDEO_PIXEL(src, vpic.palette, src_depth, r, g, b);
-    fputc(r>>8, stdout);
-    fputc(g>>8, stdout);
-    fputc(b>>8, stdout);
-  }
-
-  close(fd);
-  return 0;
-}
--------------------- 8< ---------------- 8< -----------------------------
+format (.ppm)  To produce .jpg output, you can use it like this:
+'v4lgrab | convert - c-qcam.jpg'
 
 
 10.0 --- Other Information
--- /dev/null
+++ linux-2617-rc4g9-docsrc-split/Documentation/video4linux/v4lgrab.c
@@ -0,0 +1,192 @@
+/* Simple Video4Linux image grabber. */
+/*
+ *	Video4Linux Driver Test/Example Framegrabbing Program
+ *
+ *	Compile with:
+ *		gcc -s -Wall -Wstrict-prototypes v4lgrab.c -o v4lgrab
+ *      Use as:
+ *              v4lgrab >image.ppm
+ *
+ *	Copyright (C) 1998-05-03, Phil Blundell <philb@gnu.org>
+ *      Copied from http://www.tazenda.demon.co.uk/phil/vgrabber.c
+ *      with minor modifications (Dave Forrest, drf5n@virginia.edu).
+ *
+ */
+
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <sys/ioctl.h>
+#include <stdlib.h>
+
+#include <linux/types.h>
+#include <linux/videodev.h>
+
+#define FILE "/dev/video0"
+
+/* Stole this from tvset.c */
+
+#define READ_VIDEO_PIXEL(buf, format, depth, r, g, b)                   \
+{                                                                       \
+	switch (format)                                                 \
+	{                                                               \
+		case VIDEO_PALETTE_GREY:                                \
+			switch (depth)                                  \
+			{                                               \
+				case 4:                                 \
+				case 6:                                 \
+				case 8:                                 \
+					(r) = (g) = (b) = (*buf++ << 8);\
+					break;                          \
+									\
+				case 16:                                \
+					(r) = (g) = (b) =               \
+						*((unsigned short *) buf);      \
+					buf += 2;                       \
+					break;                          \
+			}                                               \
+			break;                                          \
+									\
+									\
+		case VIDEO_PALETTE_RGB565:                              \
+		{                                                       \
+			unsigned short tmp = *(unsigned short *)buf;    \
+			(r) = tmp&0xF800;                               \
+			(g) = (tmp<<5)&0xFC00;                          \
+			(b) = (tmp<<11)&0xF800;                         \
+			buf += 2;                                       \
+		}                                                       \
+		break;                                                  \
+									\
+		case VIDEO_PALETTE_RGB555:                              \
+			(r) = (buf[0]&0xF8)<<8;                         \
+			(g) = ((buf[0] << 5 | buf[1] >> 3)&0xF8)<<8;    \
+			(b) = ((buf[1] << 2 ) & 0xF8)<<8;               \
+			buf += 2;                                       \
+			break;                                          \
+									\
+		case VIDEO_PALETTE_RGB24:                               \
+			(r) = buf[0] << 8; (g) = buf[1] << 8;           \
+			(b) = buf[2] << 8;                              \
+			buf += 3;                                       \
+			break;                                          \
+									\
+		default:                                                \
+			fprintf(stderr,                                 \
+				"Format %d not yet supported\n",        \
+				format);                                \
+	}                                                               \
+}
+
+int get_brightness_adj(unsigned char *image, long size, int *brightness) {
+  long i, tot = 0;
+  for (i=0;i<size*3;i++)
+    tot += image[i];
+  *brightness = (128 - tot/(size*3))/3;
+  return !((tot/(size*3)) >= 126 && (tot/(size*3)) <= 130);
+}
+
+int main(int argc, char ** argv)
+{
+  int fd = open(FILE, O_RDONLY), f;
+  struct video_capability cap;
+  struct video_window win;
+  struct video_picture vpic;
+
+  unsigned char *buffer, *src;
+  int bpp = 24, r, g, b;
+  unsigned int i, src_depth;
+
+  if (fd < 0) {
+    perror(FILE);
+    exit(1);
+  }
+
+  if (ioctl(fd, VIDIOCGCAP, &cap) < 0) {
+    perror("VIDIOGCAP");
+    fprintf(stderr, "(" FILE " not a video4linux device?)\n");
+    close(fd);
+    exit(1);
+  }
+
+  if (ioctl(fd, VIDIOCGWIN, &win) < 0) {
+    perror("VIDIOCGWIN");
+    close(fd);
+    exit(1);
+  }
+
+  if (ioctl(fd, VIDIOCGPICT, &vpic) < 0) {
+    perror("VIDIOCGPICT");
+    close(fd);
+    exit(1);
+  }
+
+  if (cap.type & VID_TYPE_MONOCHROME) {
+    vpic.depth=8;
+    vpic.palette=VIDEO_PALETTE_GREY;    /* 8bit grey */
+    if(ioctl(fd, VIDIOCSPICT, &vpic) < 0) {
+      vpic.depth=6;
+      if(ioctl(fd, VIDIOCSPICT, &vpic) < 0) {
+	vpic.depth=4;
+	if(ioctl(fd, VIDIOCSPICT, &vpic) < 0) {
+	  fprintf(stderr, "Unable to find a supported capture format.\n");
+	  close(fd);
+	  exit(1);
+	}
+      }
+    }
+  } else {
+    vpic.depth=24;
+    vpic.palette=VIDEO_PALETTE_RGB24;
+
+    if(ioctl(fd, VIDIOCSPICT, &vpic) < 0) {
+      vpic.palette=VIDEO_PALETTE_RGB565;
+      vpic.depth=16;
+
+      if(ioctl(fd, VIDIOCSPICT, &vpic)==-1) {
+	vpic.palette=VIDEO_PALETTE_RGB555;
+	vpic.depth=15;
+
+	if(ioctl(fd, VIDIOCSPICT, &vpic)==-1) {
+	  fprintf(stderr, "Unable to find a supported capture format.\n");
+	  return -1;
+	}
+      }
+    }
+  }
+
+  buffer = malloc(win.width * win.height * bpp);
+  if (!buffer) {
+    fprintf(stderr, "Out of memory.\n");
+    exit(1);
+  }
+
+  do {
+    int newbright;
+    read(fd, buffer, win.width * win.height * bpp);
+    f = get_brightness_adj(buffer, win.width * win.height, &newbright);
+    if (f) {
+      vpic.brightness += (newbright << 8);
+      if(ioctl(fd, VIDIOCSPICT, &vpic)==-1) {
+	perror("VIDIOSPICT");
+	break;
+      }
+    }
+  } while (f);
+
+  fprintf(stdout, "P6\n%d %d 255\n", win.width, win.height);
+
+  src = buffer;
+
+  for (i = 0; i < win.width * win.height; i++) {
+    READ_VIDEO_PIXEL(src, vpic.palette, src_depth, r, g, b);
+    fputc(r>>8, stdout);
+    fputc(g>>8, stdout);
+    fputc(b>>8, stdout);
+  }
+
+  close(fd);
+  return 0;
+}


---
