Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbTLHSYI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 13:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbTLHSYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 13:24:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:22937 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261500AbTLHSXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 13:23:44 -0500
Subject: Re: [PATCH linux-2.6.0-test10-mm1] dio-read-race-fix
From: Daniel McNeil <daniel@osdl.org>
To: Janet Morgan <janetmor@us.ibm.com>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1070674185.1929.9.camel@ibm-c.pdx.osdl.net>
References: <3FCD4B66.8090905@us.ibm.com>
	 <1070674185.1929.9.camel@ibm-c.pdx.osdl.net>
Content-Type: text/plain
Organization: 
Message-Id: <1070907814.707.2.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Dec 2003 10:23:34 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My patch did not fix the problem. :(

The tests over the weekend reported bad data.

The sampling of the i_size after dropping i_sem still looks wrong
to me.  I will keep looking and see if I can find another problem.


Daniel

On Fri, 2003-12-05 at 17:29, Daniel McNeil wrote:
> Janet,
> 
> I think I found the problem that is causing the dio reads to get
> unintialized data with buffer writes.  i_size is sampled after
> i_sem is dropped and after the i/o have completed.  i_size could
> have changed in the mean time.  This patch samples i_size before
> dropping i_sem.  I'll leave the test running over the weekend to
> verify.
> 
> Daniel
> 
> On Tue, 2003-12-02 at 18:33, Janet Morgan wrote:
> > Hi Suparna, Daniel,
> > 
> > Just wanted to let you know that I seem to be hitting a failure when I
> > run the testcase (attached) that Stephen Tweedie wrote to expose the DIO
> > races (the testcase issues buffered writes and dio reads).  I'm trying to
> > debug the failure, but I know it will be slow going for me.
> > 
> > I hit the problem when I run multiple instances of the test against
> > the same filesystem (I do specify a unique file for each instance of
> > the test).   I normally run about 6 instances of the test, e.g.,
> > "direct_read_under foo1", "direct_read_under foo2", etc.   The test
> > runs in an infinite loop until a data mis-compare is detected.
> > I have not been able to reproduce the failure when I restrict each
> > instance of the test to its own filesystem.
> > 
> > I've tried running with the combinations below and I eventually
> > get a failure in each case.   I assume all but the last combo includes
> > the critical aio/dio fixes for the associated base.
> > 
> > Combinations tested:
> > 
> >    Daniel's latest:
> >        2.6.0-test9-mm5 +
> >        aio-dio-fallback-bio_count-race.patch +
> >        direct-io-memleak-fix.patch
> > 
> >    Suparna's latest:
> >        2.6.0-test9-mm5 +
> >        Suparna's current patches:
> >            
> > http://marc.theaimsgroup.com/?l=linux-aio&m=106983304420570&w=2  +
> >            
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=106904658121299&w=2  +
> >        direct-io-memleak-fix.patch
> >  
> >     stock linux-2.6.0-test9 plus:
> >       aio-refcnt.patch  +
> >       dio-aio-fixes.patch +
> >       dio-aio-fixes-fixes.patch +
> >       O_DIRECT-race-fixes-rollup.patch 
> > 
> >     stock linux-2.6.0-test11 plus:
> >       O_DIRECT-race-fixes-rollup.patch
> >  
> > Thanks,
> > -Janet
> > 
> > ______________________________________________________________________
> > 
> > #define _XOPEN_SOURCE 600
> > #define _GNU_SOURCE
> > 
> > #include <unistd.h>
> > #include <stdlib.h>
> > #include <stdio.h>
> > #include <string.h>
> > #include <errno.h>
> > #include <sys/fcntl.h>
> > #include <sys/mman.h>
> > #include <sys/wait.h>
> > 
> > #define BIGSIZE 128*1024*1024
> > #define READSIZE 32*1024*1024
> > #define WRITESIZE 32*1024*1024
> > 
> > int pagesize;
> > char *iobuf;
> > 
> > void assert(const char *what, int assertion)
> > {
> > 	if (assertion)
> > 		return;
> > 	perror(what);
> > 	exit(1);
> > }
> > 
> > void do_buffered_writes(int fd, int pattern)
> > {
> > 	int rc;
> > 	int offset;
> > 	
> > 	memset(iobuf, pattern, WRITESIZE);
> > 	for (offset = 0; offset+WRITESIZE <= BIGSIZE; offset += WRITESIZE) {
> > 		rc = pwrite(fd, iobuf, WRITESIZE, offset);
> > 		assert("pwrite", rc >= 0);
> > 		if (rc != WRITESIZE) {
> > 			fprintf(stderr, "short write (%d out of %d)\n",
> > 				rc, WRITESIZE);
> > 			exit(1);
> > 		}
> > 		fsync(fd);
> > 	}
> > }
> > 
> > int do_direct_reads(char *filename)
> > {
> > 	int fd;
> > 	int offset;
> > 	int rc, i;
> > 	int *p;
> > 	
> > 	fd = open(filename, O_DIRECT|O_RDONLY, 0);
> > 	assert("open", fd >= 0);
> > 
> > 	for (offset = 0; offset+READSIZE <= BIGSIZE; offset += READSIZE) {
> > 		rc = pread(fd, iobuf, READSIZE, offset);
> > 		assert("pread", rc >= 0);
> > 		if (rc != READSIZE) {
> > 			fprintf(stderr, "short read (%d out of %d)\n",
> > 				rc, READSIZE);
> > 			exit(1);
> > 		}
> > 		for (i=0, p=(int *)iobuf; i<READSIZE; i+=4) {
> > 			if (*p) {
> > 				fprintf(stderr,
> > 					"Found data (%08x) at offset %d+%d\n",
> > 					*p, offset, i);
> > 				return 1;
> > 			}
> > 			p++;
> > 		}
> > 	}
> > 	return 0;
> > }
> > 
> > int main(int argc, char *argv[])
> > {
> > 	char *filename;
> > 	int fd;
> > 	int pid;
> > 	int err;
> > 	int pass = 0;
> > 	int bufsize;
> > 	
> > 	if (argc != 2) {
> > 		fprintf(stderr, "Needs a filename as an argument.\n");
> > 		exit(1);
> > 	}
> > 	
> > 	filename = argv[1];
> > 	
> > 	pagesize = getpagesize();
> > 	bufsize = READSIZE;
> > 	if (WRITESIZE > READSIZE)
> > 		bufsize = WRITESIZE;
> > 	err = posix_memalign((void**) &iobuf, pagesize, bufsize);
> > 	if (err) {
> > 		fprintf(stderr, "Error allocating %d aligned bytes.\n", bufsize);
> > 		exit(1);
> > 	}
> > 	
> > 	fd = open(filename, O_CREAT|O_TRUNC|O_RDWR, 0666);
> > 	assert("open", fd >= 0);
> > 	
> > 	do {
> > 		printf("Pass %d...\n", ++pass);
> > 		
> > 		assert("ftruncate", ftruncate(fd, BIGSIZE) == 0);
> > 		fsync(fd);
> > 
> > 		pid = fork();
> > 		assert("fork", pid >= 0);
> > 		
> > 		if (!pid) {
> > 			do_buffered_writes(fd, 0);
> > 			exit(0);
> > 		}
> > 		
> > 		err = do_direct_reads(filename);
> > 
> > 		wait4(pid, NULL, WNOHANG, 0);
> > 		
> > 		if (err) 
> > 			break;
> > 
> > 		/* Fill the file with a known pattern so that the blocks
> > 		 * on disk can be detected if they become exposed. */
> > 		do_buffered_writes(fd, 1);
> > 		fsync(fd);
> > 
> > 		assert("ftruncate", ftruncate(fd, 0) == 0);
> > 		fsync(fd);
> > 	} while (1);
> > 	
> > 	return err;
> > }
> > 

