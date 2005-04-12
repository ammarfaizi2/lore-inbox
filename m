Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbVDLQWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbVDLQWW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 12:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbVDLQTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 12:19:19 -0400
Received: from smtp2.wanadoo.fr ([193.252.22.29]:41778 "EHLO smtp2.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262391AbVDLQQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 12:16:29 -0400
X-ME-UUID: 20050412161627290.46FAB1C00237@mwinf0212.wanadoo.fr
Message-ID: <425BF468.1040403@wanadoo.fr>
Date: Tue, 12 Apr 2005 18:16:40 +0200
From: Yves Crespin <crespin.quartz@wanadoo.fr>
Organization: Quartz
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: read failed EINVAL with O_DIRECT flag
References: <425ACC89.3090207@wanadoo.fr> <20050411204948.26ab87f0.rddunlap@osdl.org>
In-Reply-To: <20050411204948.26ab87f0.rddunlap@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got compilation error when I call vmalloc() from a user program 
(w/o defined __KENEL).
How can I obtains an buffer alignement from a "user program" ?

Randy.Dunlap wrote:

>On Mon, 11 Apr 2005 21:14:17 +0200 Yves Crespin wrote:
>
>| Hello,
>| 
>| Using O_DIRECT flag, read() failed and errno is EINVAL.
>| kernel 2.4.22
>| Filesystem Ext3 mount on /home
>| What's wrong ?
>| Thanks
>
>In fs/buffer.c, it wants the buffer & the length (size) to be aligned:
>
>function: brw_kiovec()
>
>	/* 
>	 * First, do some alignment and validity checks 
>	 */
>	for (i = 0; i < nr; i++) {
>		iobuf = iovec[i];
>		if ((iobuf->offset & (size-1)) ||
>		    (iobuf->length & (size-1)))
>			return -EINVAL;
>		if (!iobuf->nr_pages)
>			panic("brw_kiovec: iobuf not initialised");
>	}
>
>so in your program, malloc() the buf [pointer] (larger than needed)
>and then align it to a page boundary and pass that aligned pointer
>to read().
>
>
>| /* --- start code --- */
>| #include <stdio.h>
>| #include <unistd.h>
>| #include <stdlib.h>
>| #include <sys/types.h>
>| #include <sys/stat.h>
>| #include <fcntl.h>
>| #include <errno.h>
>| 
>| #define O_BINARY    0
>| 
>| int main(int argc,char *argv[])
>| {
>|     struct stat    sbuf;
>|     char    buf[8192];
>|     int    openFlags;
>|     int    fd;
>|     int    nb;
>|     int    size;
>| 
>|     if (argc!=2){
>|         printf("Missing file name\n");
>|         exit(2);
>|     }
>|     openFlags = O_RDWR|O_BINARY|O_NOCTTY;
>|     openFlags |= O_DIRECT;    /* Not POSIX */
>|     fd = open(argv[1],openFlags,0666);
>|     if (fd==-1){
>|         printf("open failed [%s] %#o %#o errno 
>| %d\n",argv[1],openFlags,0666,errno);
>|         exit(1);
>|     }
>|     if (fstat(fd,&sbuf)<0){
>|         printf("fstat failed\n");
>|         exit(1);
>|     }
>|     size = sbuf.st_blksize;
>|     if (size > sizeof(buf)){
>|         printf("Page size too big\n");
>|         exit(3);
>|     }
>|     if (size > sbuf.st_size){
>|         printf("File too small\n");
>|         exit(3);
>|     }
>|     nb = read(fd,buf,size);
>|     if (nb != size){
>|         printf("read failed fd %d size %d nb %d errno 
>| %d\n",fd,size,nb,errno);
>|         exit(1);
>|     }
>|     if (close(fd)){
>|         printf("close failed\n");
>|         exit(1);
>|     }
>|     return 0;
>| }
>
>---
>~Randy
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

