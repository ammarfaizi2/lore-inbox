Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932751AbWBURRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932751AbWBURRt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 12:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932748AbWBURR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 12:17:29 -0500
Received: from [151.97.230.9] ([151.97.230.9]:3806 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932751AbWBURRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 12:17:22 -0500
X-Antivirus-MYDOMAIN-Mail-From: blaisorblade@yahoo.it via ssc.unict.it
X-Antivirus-MYDOMAIN: 1.25-st-qms (Clear:RC:1(151.97.230.9):. Processed in 0.063561 secs Process 16080)
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 1/6] uml: correct error messages in COW driver
Date: Tue, 21 Feb 2006 18:16:20 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060221171620.509.70255.stgit@zion.home.lan>
In-Reply-To: <20060221171535.509.28286.stgit@zion.home.lan>
References: <20060221171535.509.28286.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Improve some error messages in the COW driver, and say V3, not V2, when talking
about V3 format. Also resync with our userspace code utility a bit more.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/cow_sys.h  |    2 +-
 arch/um/drivers/cow_user.c |   21 ++++++++++++---------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/um/drivers/cow_sys.h b/arch/um/drivers/cow_sys.h
index c83fc5d..df25263 100644
--- a/arch/um/drivers/cow_sys.h
+++ b/arch/um/drivers/cow_sys.h
@@ -33,7 +33,7 @@ static inline int cow_file_size(char *fi
 	return(os_file_size(file, size_out));
 }
 
-static inline int cow_write_file(int fd, char *buf, int size)
+static inline int cow_write_file(int fd, void *buf, int size)
 {
 	return(os_write_file(fd, buf, size));
 }
diff --git a/arch/um/drivers/cow_user.c b/arch/um/drivers/cow_user.c
index fbe2217..d1c86bc 100644
--- a/arch/um/drivers/cow_user.c
+++ b/arch/um/drivers/cow_user.c
@@ -176,7 +176,7 @@ int write_cow_header(char *cow_file, int
 	err = -ENOMEM;
 	header = cow_malloc(sizeof(*header));
 	if(header == NULL){
-		cow_printf("Failed to allocate COW V3 header\n");
+		cow_printf("write_cow_header - failed to allocate COW V3 header\n");
 		goto out;
 	}
 	header->magic = htonl(COW_MAGIC);
@@ -196,15 +196,17 @@ int write_cow_header(char *cow_file, int
 
 	err = os_file_modtime(header->backing_file, &modtime);
 	if(err < 0){
-		cow_printf("Backing file '%s' mtime request failed, "
-			   "err = %d\n", header->backing_file, -err);
+		cow_printf("write_cow_header - backing file '%s' mtime "
+			   "request failed, err = %d\n", header->backing_file,
+			   -err);
 		goto out_free;
 	}
 
 	err = cow_file_size(header->backing_file, size);
 	if(err < 0){
-		cow_printf("Couldn't get size of backing file '%s', "
-			   "err = %d\n", header->backing_file, -err);
+		cow_printf("write_cow_header - couldn't get size of "
+			   "backing file '%s', err = %d\n",
+			   header->backing_file, -err);
 		goto out_free;
 	}
 
@@ -214,10 +216,11 @@ int write_cow_header(char *cow_file, int
 	header->alignment = htonl(alignment);
 	header->cow_format = COW_BITMAP;
 
-	err = os_write_file(fd, header, sizeof(*header));
+	err = cow_write_file(fd, header, sizeof(*header));
 	if(err != sizeof(*header)){
-		cow_printf("Write of header to new COW file '%s' failed, "
-			   "err = %d\n", cow_file, -err);
+		cow_printf("write_cow_header - write of header to "
+			   "new COW file '%s' failed, err = %d\n", cow_file,
+			   -err);
 		goto out_free;
 	}
 	err = 0;
@@ -299,7 +302,7 @@ int read_cow_header(int (*reader)(__u64,
 	}
 	else if(version == 3){
 		if(n < sizeof(header->v3)){
-			cow_printf("read_cow_header - failed to read V2 "
+			cow_printf("read_cow_header - failed to read V3 "
 				   "header\n");
 			goto out;
 		}

