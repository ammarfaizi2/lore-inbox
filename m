Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423140AbWJRX7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423140AbWJRX7i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 19:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423175AbWJRX7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 19:59:37 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:26287 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1423140AbWJRX7g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 19:59:36 -0400
Subject: Re: 2.6.19-rc2-mm1
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Chris Mason <chris.mason@oracle.com>
In-Reply-To: <453672FD.9080206@yahoo.com.au>
References: <20061016230645.fed53c5b.akpm@osdl.org>
	 <1161185599.18117.1.camel@dyn9047017100.beaverton.ibm.com>
	 <45364CE9.7050002@yahoo.com.au>
	 <1161191747.18117.9.camel@dyn9047017100.beaverton.ibm.com>
	 <45366515.4050308@yahoo.com.au>
	 <1161194303.18117.17.camel@dyn9047017100.beaverton.ibm.com>
	 <45366F08.6050903@yahoo.com.au>  <453672FD.9080206@yahoo.com.au>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 16:59:23 -0700
Message-Id: <1161215963.18117.40.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-19 at 04:31 +1000, Nick Piggin wrote:
> Nick Piggin wrote:
> 
> > I can't see anything yet, but I'll keep looking (and try to reproduce
> > if I can get TLP working).
> 
> Ah, it is probably exercising the -EFAULT path, and the code in
> Andrew's tree goes into an infinite loop I think.
> 
> We can't test for a fault off the atomic copy, because that needn't
> indicate an unmapped area. What we need to do is change
> fault_in_pages_readable to return ret, and catch and return that
> in the caller if it is an error.
> 
> My usual workstation is down ATM otherwise I would send you a patch.
> Unless someone beats me to it, I'll send you one tomorrow.
> 
> Thanks,
> Nick
> 

Here is the test case which reproduces the problem on my ppc box
consistently. But happens occasionally on amd64 box. 

But writev01 test from LTP always hits the problem on amd64 & ppc64.

Thanks,
Badari

Here is the strace output:

# strace /tmp/tst
execve("/tmp/tst", ["/tmp/tst"], [/* 64 vars */]) = 0
uname({sys="Linux", node="elm3b155", ...}) = 0
brk(0)                                  = 0x10020000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=99239, ...}) = 0
mmap(NULL, 99239, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40030000
close(3)                                = 0
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\1\274"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1401050, ...}) = 0
mmap(0xfeb0000, 1272876, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
0xfeb0000
madvise(0xfeb0000, 1272876, MADV_SEQUENTIAL|0x1) = 0
mmap(0xffd0000, 131072, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|
MAP_FIXED, 3, 0x110000) = 0xffd0000
close(3)                                = 0
munmap(0x40030000, 99239)               = 0
open("writev_data_file", O_RDWR|O_CREAT, 0666) = 3
writev(3, [{"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
64}, {ptrace: umoven: Input/output error
0xffffffff, 64}, {"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
\0"..., 64}], 3


Test (shamelessly yanked it from writev01 test):
=================================================


#include <stdio.h>
#include <sys/types.h>
#include <signal.h>
#include <sys/uio.h>
#include <sys/fcntl.h>
#include <memory.h>
#include <errno.h>
#include <sys/mman.h>

#define K_1     1024

#define CHUNK           64              /* single chunk */
#define MAX_IOVEC       16
#define DATA_FILE       "writev_data_file"

char buf1[K_1], buf2[K_1], buf3[K_1];

struct iovec wr_iovec[MAX_IOVEC] = {
        {buf1,                  CHUNK},
        {(caddr_t)-1,           CHUNK},
        {(buf1 + CHUNK),        CHUNK},
};


int main()
{
        int fd, ret;

        if ((fd = open(DATA_FILE, O_RDWR|O_CREAT, 0666)) < 0) {
                perror("open failed");
                exit(1);
        }

        ret = writev(fd, wr_iovec, 3);
        if (ret < 0) {
                perror("writev failed");
                exit(2);
        }

        close(fd);
}



