Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbVDLFVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbVDLFVp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 01:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVDLFVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 01:21:22 -0400
Received: from fire.osdl.org ([65.172.181.4]:12232 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262006AbVDLDt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 23:49:56 -0400
Date: Mon, 11 Apr 2005 20:49:48 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Yves Crespin <crespin.quartz@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: read failed EINVAL with O_DIRECT flag
Message-Id: <20050411204948.26ab87f0.rddunlap@osdl.org>
In-Reply-To: <425ACC89.3090207@wanadoo.fr>
References: <425ACC89.3090207@wanadoo.fr>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Apr 2005 21:14:17 +0200 Yves Crespin wrote:

| Hello,
| 
| Using O_DIRECT flag, read() failed and errno is EINVAL.
| kernel 2.4.22
| Filesystem Ext3 mount on /home
| What's wrong ?
| Thanks

In fs/buffer.c, it wants the buffer & the length (size) to be aligned:

function: brw_kiovec()

	/* 
	 * First, do some alignment and validity checks 
	 */
	for (i = 0; i < nr; i++) {
		iobuf = iovec[i];
		if ((iobuf->offset & (size-1)) ||
		    (iobuf->length & (size-1)))
			return -EINVAL;
		if (!iobuf->nr_pages)
			panic("brw_kiovec: iobuf not initialised");
	}

so in your program, malloc() the buf [pointer] (larger than needed)
and then align it to a page boundary and pass that aligned pointer
to read().


| /* --- start code --- */
| #include <stdio.h>
| #include <unistd.h>
| #include <stdlib.h>
| #include <sys/types.h>
| #include <sys/stat.h>
| #include <fcntl.h>
| #include <errno.h>
| 
| #define O_BINARY    0
| 
| int main(int argc,char *argv[])
| {
|     struct stat    sbuf;
|     char    buf[8192];
|     int    openFlags;
|     int    fd;
|     int    nb;
|     int    size;
| 
|     if (argc!=2){
|         printf("Missing file name\n");
|         exit(2);
|     }
|     openFlags = O_RDWR|O_BINARY|O_NOCTTY;
|     openFlags |= O_DIRECT;    /* Not POSIX */
|     fd = open(argv[1],openFlags,0666);
|     if (fd==-1){
|         printf("open failed [%s] %#o %#o errno 
| %d\n",argv[1],openFlags,0666,errno);
|         exit(1);
|     }
|     if (fstat(fd,&sbuf)<0){
|         printf("fstat failed\n");
|         exit(1);
|     }
|     size = sbuf.st_blksize;
|     if (size > sizeof(buf)){
|         printf("Page size too big\n");
|         exit(3);
|     }
|     if (size > sbuf.st_size){
|         printf("File too small\n");
|         exit(3);
|     }
|     nb = read(fd,buf,size);
|     if (nb != size){
|         printf("read failed fd %d size %d nb %d errno 
| %d\n",fd,size,nb,errno);
|         exit(1);
|     }
|     if (close(fd)){
|         printf("close failed\n");
|         exit(1);
|     }
|     return 0;
| }

---
~Randy
