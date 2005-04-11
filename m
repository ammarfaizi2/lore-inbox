Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbVDKUuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVDKUuu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 16:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbVDKUuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 16:50:50 -0400
Received: from smtp9.wanadoo.fr ([193.252.22.22]:28384 "EHLO smtp9.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261917AbVDKUuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 16:50:07 -0400
X-ME-UUID: 20050411204957284.06E66240012F@mwinf0909.wanadoo.fr
Message-ID: <425ACC89.3090207@wanadoo.fr>
Date: Mon, 11 Apr 2005 21:14:17 +0200
From: Yves Crespin <crespin.quartz@wanadoo.fr>
Organization: Quartz
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: read failed EINVAL with O_DIRECT flag
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Using O_DIRECT flag, read() failed and errno is EINVAL.
kernel 2.4.22
Filesystem Ext3 mount on /home
What's wrong ?
Thanks

Yves Crespin

#gcc -Wall -D_GNU_SOURCE direct.c -o direct
#cp direct d
#./direct d
#open failed [d] 040402 0666 errno 22
#

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
    char    buf[8192];
    int    openFlags;
    int    fd;
    int    nb;
    int    size;

    if (argc!=2){
        printf("Missing file name\n");
        exit(2);
    }
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
    size = sbuf.st_blksize;
    if (size > sizeof(buf)){
        printf("Page size too big\n");
        exit(3);
    }
    if (size > sbuf.st_size){
        printf("File too small\n");
        exit(3);
    }
    nb = read(fd,buf,size);
    if (nb != size){
        printf("read failed fd %d size %d nb %d errno 
%d\n",fd,size,nb,errno);
        exit(1);
    }
    if (close(fd)){
        printf("close failed\n");
        exit(1);
    }
    return 0;
}
/* --- end code --- */


