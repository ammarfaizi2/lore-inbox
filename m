Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261386AbRFBVSB>; Sat, 2 Jun 2001 17:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261425AbRFBVRv>; Sat, 2 Jun 2001 17:17:51 -0400
Received: from ns.caldera.de ([212.34.180.1]:65177 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S261386AbRFBVRq>;
	Sat, 2 Jun 2001 17:17:46 -0400
Date: Sat, 2 Jun 2001 23:17:37 +0200
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Cc: okir@caldera.de
Subject: BUG: 2.4.x NFS client mmap race
Message-ID: <20010602231737.A1300@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While debugging a rather strange WINE problem I came across a 2.4.x 
NFS race condition.

I trimmed down the WINE code to a very small testcase, attached below, 
which has following test patterns:
	
	ext2 local			: SUCCESS
	2.4.5-ac6  -> 2.2.10 (unfsd)	: FAIL
	2.4.2-ac26 -> 2.4.2ac26	(knfsd)	: FAIL
	2.2.14     -> 2.4.2ac26	(knfsd)	: SUCCESS

For me this looks like there is a problem in the 2.4 NFS client.

The sleep() appears to be a key part. If we only sleep 1 second the
test usually succeeds. With 5 it always fails.

I am using the default mount options for nfs.

Ciao, Marcus

#include <stdio.h>
#include <assert.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/mman.h>
#include <sys/stat.h>

main() {
    int fd;
    unsigned char *ptr;
    char buf[10];

    memset(buf,'0',10);

    fd = open("/home/lstcore/mm/test.out",O_RDWR|O_CREAT|O_TRUNC,0644);
    assert(fd!=-1);


    ftruncate(fd,512);
    ptr=mmap(NULL,512,PROT_WRITE|PROT_READ,MAP_SHARED,fd,0);
    ptr[0]=0x42;
    munmap(ptr,512);

    sleep(5);

    ftruncate(fd,69632);
    ptr=mmap(NULL,69632,PROT_WRITE|PROT_READ,MAP_SHARED,fd,0);
    assert(ptr[0]==0x42);

    fprintf(stderr,"There was no race. Lucky you!\n");
}
