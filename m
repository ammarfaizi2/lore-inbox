Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291102AbSAaPTY>; Thu, 31 Jan 2002 10:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291103AbSAaPTO>; Thu, 31 Jan 2002 10:19:14 -0500
Received: from ASYNC14-7.NET.CS.CMU.EDU ([128.2.188.46]:61447 "EHLO
	mentor.odyssey.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S291102AbSAaPTF>; Thu, 31 Jan 2002 10:19:05 -0500
Date: Thu, 31 Jan 2002 10:19:17 -0500
To: Robert Love <rml@tech9.net>
Cc: torvalds@transmeta.com, viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5: further llseek cleanup (1/3)
Message-ID: <20020131151917.GA17060@mentor.odyssey.cs.cmu.edu>
Mail-Followup-To: Robert Love <rml@tech9.net>, torvalds@transmeta.com,
	viro@math.psu.edu, linux-kernel@vger.kernel.org
In-Reply-To: <1012459512.3213.148.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1012459512.3213.148.camel@phantasy>
User-Agent: Mutt/1.3.26i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 01:45:12AM -0500, Robert Love wrote:
> The 'push locking into llseek methods' patch was integrated into 2.5.3. 
> The networking filesystems, however, do not protect i_size and can not
> rely on the inode semaphore used in generic_file_llseek.

I'm not sure whether the Coda part of this patch is correct. Coda does
rely in the inode semaphore to protect from concurrency between the
userspace cachemanager that accesses the file on the host filesystem
directly and the applications that access the same file through the
/coda mount.

See for instance coda_file_write, where we also use the host inode
semaphore for protection. Only sys_stat() accesses i_size unprotected,
but that doesn't matter much in my opinion. Any application relying on
the result of sys_stat to do appending or subsequent lseeks would be
racy anyways. (and it can only be fixed correctly when we get a FS
specific getattr method).

Jan

So in my opinion, if your patch got applied, the Coda part needs to be
reverted.

#patch -R -p1 << EOF
diff -urN linux-2.5.3/fs/coda/file.c linux/fs/coda/file.c
--- linux-2.5.3/fs/coda/file.c	Thu Jan 31 01:08:54 2002
+++ linux/fs/coda/file.c	Thu Jan 31 01:09:47 2002
@@ -267,7 +267,7 @@
 }
 
 struct file_operations coda_file_operations = {
-	llseek:		generic_file_llseek,
+	llseek:		remote_llseek,
 	read:		coda_file_read,
 	write:		coda_file_write,
 	mmap:		coda_file_mmap,
EOF
