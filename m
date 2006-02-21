Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932754AbWBURRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932754AbWBURRY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 12:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932763AbWBURRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 12:17:23 -0500
Received: from [151.97.230.9] ([151.97.230.9]:3550 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932752AbWBURRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 12:17:22 -0500
X-Antivirus-MYDOMAIN-Mail-From: blaisorblade@yahoo.it via ssc.unict.it
X-Antivirus-MYDOMAIN: 1.25-st-qms (Clear:RC:1(151.97.230.9):. Processed in 0.292225 secs Process 16085)
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 6/6] uml: tidying COW code
Date: Tue, 21 Feb 2006 18:16:32 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060221171632.509.23287.stgit@zion.home.lan>
In-Reply-To: <20060221171535.509.28286.stgit@zion.home.lan>
References: <20060221171535.509.28286.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Improve (especially for coherence) some prototypes, and return code of
init_cow_file in error case - for a short write return -EINVAL, otherwise return
the error we got!

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/cow.h      |    2 +-
 arch/um/drivers/cow_sys.h  |    4 ++--
 arch/um/drivers/cow_user.c |    3 ++-
 arch/um/drivers/ubd_kern.c |    2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/um/drivers/cow.h b/arch/um/drivers/cow.h
index dc36b22..04e3958 100644
--- a/arch/um/drivers/cow.h
+++ b/arch/um/drivers/cow.h
@@ -46,7 +46,7 @@ extern int file_reader(__u64 offset, cha
 extern int read_cow_header(int (*reader)(__u64, char *, int, void *),
 			   void *arg, __u32 *version_out,
 			   char **backing_file_out, time_t *mtime_out,
-			   unsigned long long *size_out, int *sectorsize_out,
+			   __u64 *size_out, int *sectorsize_out,
 			   __u32 *align_out, int *bitmap_offset_out);
 
 extern int write_cow_header(char *cow_file, int fd, char *backing_file,
diff --git a/arch/um/drivers/cow_sys.h b/arch/um/drivers/cow_sys.h
index df25263..94de4ea 100644
--- a/arch/um/drivers/cow_sys.h
+++ b/arch/um/drivers/cow_sys.h
@@ -23,12 +23,12 @@ static inline char *cow_strdup(char *str
 	return(uml_strdup(str));
 }
 
-static inline int cow_seek_file(int fd, unsigned long long offset)
+static inline int cow_seek_file(int fd, __u64 offset)
 {
 	return(os_seek_file(fd, offset));
 }
 
-static inline int cow_file_size(char *file, unsigned long long *size_out)
+static inline int cow_file_size(char *file, __u64 *size_out)
 {
 	return(os_file_size(file, size_out));
 }
diff --git a/arch/um/drivers/cow_user.c b/arch/um/drivers/cow_user.c
index d1c86bc..61951b7 100644
--- a/arch/um/drivers/cow_user.c
+++ b/arch/um/drivers/cow_user.c
@@ -362,7 +362,8 @@ int init_cow_file(int fd, char *cow_file
 	if(err != sizeof(zero)){
 		cow_printf("Write of bitmap to new COW file '%s' failed, "
 			   "err = %d\n", cow_file, -err);
-		err = -EINVAL;
+		if (err >= 0)
+			err = -EINVAL;
 		goto out;
 	}
 
diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index f93af66..59f9890 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1141,7 +1141,7 @@ static int path_requires_switch(char *fr
 static int backing_file_mismatch(char *file, __u64 size, time_t mtime)
 {
 	unsigned long modtime;
-	long long actual;
+	unsigned long long actual;
 	int err;
 
 	err = os_file_modtime(file, &modtime);

