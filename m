Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbUCQQlC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 11:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbUCQQlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 11:41:02 -0500
Received: from lx.quiotix.com ([199.164.185.7]:36536 "EHLO lx.quiotix.com")
	by vger.kernel.org with ESMTP id S261888AbUCQQkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 11:40:55 -0500
Message-ID: <40587F90.1040903@quiotix.com>
Date: Wed, 17 Mar 2004 08:40:48 -0800
From: Jeffrey Siegal <jbs@quiotix.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040218
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Why is fsync so much slower than O_SYNC?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is on FC1 with Fedora/Red Hat's 2.4.22-1.2174.nptlsmp kernel, 
writing to an ext3 file system (journal=ordered) on a 7200rpm IDE drive.

O_SYNC:
Creating
Starting
iter = 1000, latency = 8.413535ms

O_DSYNC:
Creating
Starting
iter = 1000, latency = 8.429431ms

fsync:
Creating
Starting
iter = 1000, latency = 34.499984ms

fdatasync:
Creating
Starting
iter = 1000, latency = 35.568508ms


--

#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/time.h>
#include <assert.h>

#define ITER 1000
#define FSIZE (512*ITER)

static inline unsigned long microtime()
{
   struct timeval tv;
   int ret;
   ret = gettimeofday(&tv, 0);
   assert(!ret);

   return tv.tv_sec * 1000000UL + tv.tv_usec;
}

#define OP_OPEN 1
#define OP_SYNC 2

static int do_open(char *fn, int extraflags)
{
   return open(fn, O_CREAT | O_TRUNC | O_WRONLY | extraflags, 0644);
}

static int flushmethod_O_SYNC(int op, int iarg, char * sarg) {
   switch (op) {
   case OP_OPEN:
     return do_open(sarg, O_SYNC);
   case OP_SYNC:
     return 0;
   default:
     assert(0);
   }
}

static int flushmethod_O_DSYNC(int op, int iarg, char * sarg)
{
   switch (op) {
   case OP_OPEN:
     return do_open(sarg, O_DSYNC);
   case OP_SYNC:
     return 0;
   default:
     assert(0);
   }
}

static int flushmethod_fsync(int op, int iarg, char * sarg)
{
   switch (op) {
   case OP_OPEN:
     return do_open(sarg, 0);
   case OP_SYNC:
     return fsync(iarg);
   default:
     assert(0);
   }
}
static int flushmethod_fdatasync(int op, int iarg, char * sarg)
{
   switch (op) {
   case OP_OPEN:
     return do_open(sarg, 0);
   case OP_SYNC:
     return fdatasync(iarg);
   default:
     assert(0);
   }
}

int runtest(int (*flushmethod)(int op, int iarg, char * sarg))
{
   char *filename = "tmp.tmp";
   int fd = flushmethod(OP_OPEN, 0, filename);
   int ret;

   printf("Creating\n");
   {
     char *p = calloc(1, FSIZE);
     ret = write(fd, p, FSIZE);
     if (ret != FSIZE) {
       printf("%d\n", ret);
       assert(0);
     }
     free(p);
   }
   ret = flushmethod(OP_SYNC, fd, 0);
   assert(ret == 0);

   printf("Starting\n");
   unsigned long start = microtime();
   int iter = ITER;
   int offset = 0;
   while (iter--) {
     char ch = 'A';
     ret = pwrite(fd, &ch, 1, offset % FSIZE);
     assert(ret == 1);
     ret = flushmethod(OP_SYNC, fd, 0);
     assert(ret == 0);
     offset += 512;
   }

   close(fd);
   unlink(filename);
   printf("iter = %d, latency = %lfms\n", ITER, (microtime() - 
start)/(ITER*1000.0));
}

int main(int argc, char *argv)
{
   printf("\nREADME: Make sure you have turned off hardware write 
caching (hdparm -W0 /dev/hda for IDE)\n\n");
   printf("O_SYNC:\n");
   runtest(flushmethod_O_SYNC);
   printf("\n");
   printf("O_DSYNC:\n");
   runtest(flushmethod_O_DSYNC);
   printf("\n");
   printf("fsync:\n");
   runtest(flushmethod_fsync);
   printf("\n");
   printf("fdatasync:\n");
   runtest(flushmethod_fdatasync);
}

