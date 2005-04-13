Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVDMNQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVDMNQJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 09:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVDMNQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 09:16:09 -0400
Received: from smtp6.wanadoo.fr ([193.252.22.25]:13898 "EHLO smtp6.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261320AbVDMNPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 09:15:49 -0400
X-ME-UUID: 20050413131548143.2310E1C00255@mwinf0603.wanadoo.fr
Message-ID: <425D1B83.50809@wanadoo.fr>
Date: Wed, 13 Apr 2005 15:15:47 +0200
From: Yves Crespin <crespin.quartz@wanadoo.fr>
Organization: Quartz
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: read failed EINVAL with O_DIRECT flag
References: <425ACC89.3090207@wanadoo.fr>	<20050411204948.26ab87f0.rddunlap@osdl.org>	<425BF468.1040403@wanadoo.fr> <20050412094752.0f4d88a5.rddunlap@osdl.org>
In-Reply-To: <20050412094752.0f4d88a5.rddunlap@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 >| How can I obtains an buffer alignement from a "user program" ?
 >
 >I actually left that as an exercise (after I did it at home
 >last night).  Did you read the hint (below)?

Well ... either with malloc() and alignement or posix_memalign(),
read() still failed!
My read buffer is in user space, so it's copy to kernel space.
Inside the read() call, it's the kernel buffer which must be aligned?

 >
 >| >In fs/buffer.c, it wants the buffer & the length (size) to be aligned:
 >| >
 >| >function: brw_kiovec()
 >| >
 >| >    /*
 >| >     * First, do some alignment and validity checks
 >| >     */
 >| >    for (i = 0; i < nr; i++) {
 >| >        iobuf = iovec[i];
 >| >        if ((iobuf->offset & (size-1)) ||
 >| >            (iobuf->length & (size-1)))
 >| >            return -EINVAL;
 >| >        if (!iobuf->nr_pages)
 >| >            panic("brw_kiovec: iobuf not initialised");
 >| >    }
 >| >
 >| >so in your program, malloc() the buf [pointer] (larger than needed)
 >| >and then align it to a page boundary and pass that aligned pointer
 >| >to read().
 >| >
/* --- start code --- */
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>

#define O_BINARY    0

int main(int argc,char *argv[])
{
    struct stat    sbuf;
    char *        buf;
    int        openFlags;
    int        fd;
    int        nb;
    off_t        size;
    blksize_t    blksize;
    off_t        offset;

    if (argc!=2){
        printf("Missing file name\n");
        exit(2);
    }
    printf("[%s]\n",argv[1]);
    openFlags = O_RDWR|O_BINARY|O_NOCTTY;
    openFlags |= O_DIRECT;    /* Not POSIX */
    fd = open(argv[1],openFlags,0666);
    if (fd==-1){
        printf("open failed [%s] %#o %#o errno 
%d\n",argv[1],openFlags,0666,errno);
        exit(1);
    }
    if (fstat(fd,&sbuf)<0){
        printf("fstat failed\n");
        exit(1);
    }
    blksize = sbuf.st_blksize;
    size = sbuf.st_size;
    nb = posix_memalign((void **)&buf,blksize,size);
    if (nb!=0){
        printf("posix_memalign blksize %lu size %lu failed 
%d\n",blksize,size,nb);
        exit(3);
    }
#if 0
    free(buf);
    buf = malloc(2*blksize);
#endif
    printf("direct: buf %p buf & (blksize-1) %lu\n",buf,(unsigned 
long)buf & (unsigned long)(blksize-1));
    for (offset=0;offset<blksize;offset++){
        if (!((unsigned long)(buf+offset) & (unsigned long)(blksize-1))){
            printf("offset: buf %p buf & (blksize-1) %lu offset 
%lu\n",buf+offset,(unsigned long)(buf+offset) & (unsigned 
long)(blksize-1),offset);
            break;
        }
    }
    printf("align:  buf %p buf & (blksize-1) %lu\n",buf+offset,(unsigned 
long)(buf+offset) & (unsigned long)(blksize-1));
    nb = read(fd,buf+offset,blksize);
    if (nb != blksize){
        printf("read failed fd %d buf %p buf & (blksize-1) %lu blksize 
%lu size %lu nb %d errno %d\n",
                fd,buf+offset,(unsigned long)(buf+offset) & (unsigned 
long)(blksize-1),
                (unsigned long)blksize,size,nb,errno);
        exit(1);
    }
    if (close(fd)){
        printf("close failed\n");
        exit(1);
    }
    free(buf);
    return 0;
}
/* --- end code --- */


