Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbTEBUpI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 16:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263165AbTEBUpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 16:45:08 -0400
Received: from [12.47.58.20] ([12.47.58.20]:61848 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263163AbTEBUpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 16:45:05 -0400
Date: Fri, 2 May 2003 13:54:04 -0700
From: Andrew Morton <akpm@digeo.com>
To: dipankar@in.ibm.com
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reducing overheads in fget/fput
Message-Id: <20030502135404.0ba2ca66.akpm@digeo.com>
In-Reply-To: <20030502171726.GA1414@in.ibm.com>
References: <20030428165240.GA1105@in.ibm.com>
	<20030428193228.GP10374@parcelfarce.linux.theplanet.co.uk>
	<20030428195836.GD1105@in.ibm.com>
	<20030502171726.GA1414@in.ibm.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 May 2003 20:57:22.0860 (UTC) FILETIME=[6D99DEC0:01C310ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma <dipankar@in.ibm.com> wrote:
>
> > That shouldn't be very difficult to fix. For the fget_light/fput_light
> > pair in a syscall, we make the files->count == 1 check only once at the 
> > beginning. Do you see a problem with that ?
> 
> Here is a patch that fixes that.

This patch is fairly foul.

> kernel           sys time     std-dev
> ------------     --------     -------
> UP - vanilla     2.104        0.028
> SMP - vanilla    2.976        0.023
> UP - file        1.867        0.019
> SMP - file       2.719        0.026

But it is localised, and makes a substantial difference.

I inlined fput_light:

diff -puN fs/file_table.c~fget-speedup-inline-fput_light fs/file_table.c
--- 25/fs/file_table.c~fget-speedup-inline-fput_light	Fri May  2 13:51:45 2003
+++ 25-akpm/fs/file_table.c	Fri May  2 13:52:23 2003
@@ -141,19 +141,12 @@ void close_private_file(struct file *fil
 	security_file_free(file);
 }
 
-void fput(struct file * file)
+void fput(struct file *file)
 {
 	if (atomic_dec_and_test(&file->f_count))
 		__fput(file);
 }
 
-void fput_light(struct file * file, int flag)
-{
-	if (unlikely(flag))
-		if (atomic_dec_and_test(&file->f_count))
-			__fput(file);
-}
-
 /* __fput is called from task context when aio completion releases the last
  * last use of a struct file *.  Do not use otherwise.
  */
diff -puN include/linux/file.h~fget-speedup-inline-fput_light include/linux/file.h
--- 25/include/linux/file.h~fget-speedup-inline-fput_light	Fri May  2 13:51:45 2003
+++ 25-akpm/include/linux/file.h	Fri May  2 13:52:52 2003
@@ -35,7 +35,13 @@ struct files_struct {
 
 extern void FASTCALL(__fput(struct file *));
 extern void FASTCALL(fput(struct file *));
-extern void FASTCALL(fput_light(struct file *, int));
+
+static inline void fput_light(struct file *file, int flag)
+{
+	if (unlikely(flag))
+		fput(file);
+}
+
 extern struct file * FASTCALL(fget(unsigned int fd));
 extern struct file * FASTCALL(fget_light(unsigned int fd, int *flag));
 extern void FASTCALL(set_close_on_exec(unsigned int fd, int flag));

_

