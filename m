Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbTLQBZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 20:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbTLQBZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 20:25:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:37607 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262925AbTLQBZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 20:25:49 -0500
Subject: Re: [PATCH linux-2.6.0-test10-mm1] filemap_fdatawait.patch
From: Daniel McNeil <daniel@osdl.org>
To: Janet Morgan <janetmor@us.ibm.com>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1071190292.1937.13.camel@ibm-c.pdx.osdl.net>
References: <3FCD4B66.8090905@us.ibm.com>
	 <1070674185.1929.9.camel@ibm-c.pdx.osdl.net>
	 <1070907814.707.2.camel@ibm-c.pdx.osdl.net>
	 <1071190292.1937.13.camel@ibm-c.pdx.osdl.net>
Content-Type: multipart/mixed; boundary="=-fsY063Z7Raqhaa2KkoLS"
Organization: 
Message-Id: <1071624314.1826.12.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Dec 2003 17:25:14 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fsY063Z7Raqhaa2KkoLS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I have found something else that might be causing the problem.
filemap_fdatawait() skips pages that are not marked PG_writeback.
However, when a page is going to be written, PG_dirty is cleared
before PG_writeback is set (while the PG_locked is set).  So it
looks like filemap_fdatawait() can see a page just before it is
going to be written and not wait for it.  Here is a patch that
makes filemap_fdatawait() wait for locked pages as well to make
sure it does not missed any pages.

I'm running the test on kernel with this patch over night to see
if it fixes the problem.

Thoughts?

Daniel

On Thu, 2003-12-11 at 16:51, Daniel McNeil wrote:
> I've done more testing with added debug code.
> 
> It looks like the filemap_write_and_wait() call is returning
> with data that has not made it disk.
> 
> I added code to filemap_write_and_wait() to check if
> mapping->dirty_pages is not empty after calling filemap_fdatawrite()
> and filemap_fdatawait() and retry.  Even with the retry, the test still
> sees uninitialized data when running tests overnight (I added a printk
> so I know the retry is happening).  There are pages left on the
> dirty_pages list even after the write and wait.   
> 
> I've added a bunch more debug code and am currently running the test
> again to see if I can find out what is going on.
> 
> I'll send more email when I know more.
> 
> Daniel
> 
> 
> 
> On Mon, 2003-12-08 at 10:23, Daniel McNeil wrote:
> > My patch did not fix the problem. :(
> > 
> > The tests over the weekend reported bad data.
> > 
> > The sampling of the i_size after dropping i_sem still looks wrong
> > to me.  I will keep looking and see if I can find another problem.
> > 
> > 
> > Daniel
> > 
> > On Fri, 2003-12-05 at 17:29, Daniel McNeil wrote:
> > > Janet,
> > > 
> > > I think I found the problem that is causing the dio reads to get
> > > unintialized data with buffer writes.  i_size is sampled after
> > > i_sem is dropped and after the i/o have completed.  i_size could
> > > have changed in the mean time.  This patch samples i_size before
> > > dropping i_sem.  I'll leave the test running over the weekend to
> > > verify.
> > > 
> > > Daniel
> > > 
> > > On Tue, 2003-12-02 at 18:33, Janet Morgan wrote:
> > > > Hi Suparna, Daniel,
> > > > 
> > > > Just wanted to let you know that I seem to be hitting a failure when I
> > > > run the testcase (attached) that Stephen Tweedie wrote to expose the DIO
> > > > races (the testcase issues buffered writes and dio reads).  I'm trying to
> > > > debug the failure, but I know it will be slow going for me.
> > > > 
> > > > I hit the problem when I run multiple instances of the test against
> > > > the same filesystem (I do specify a unique file for each instance of
> > > > the test).   I normally run about 6 instances of the test, e.g.,
> > > > "direct_read_under foo1", "direct_read_under foo2", etc.   The test
> > > > runs in an infinite loop until a data mis-compare is detected.
> > > > I have not been able to reproduce the failure when I restrict each
> > > > instance of the test to its own filesystem.
> > > > 
> > > > I've tried running with the combinations below and I eventually
> > > > get a failure in each case.   I assume all but the last combo includes
> > > > the critical aio/dio fixes for the associated base.
> > > > 
> > > > Combinations tested:
> > > > 
> > > >    Daniel's latest:
> > > >        2.6.0-test9-mm5 +
> > > >        aio-dio-fallback-bio_count-race.patch +
> > > >        direct-io-memleak-fix.patch
> > > > 
> > > >    Suparna's latest:
> > > >        2.6.0-test9-mm5 +
> > > >        Suparna's current patches:
> > > >            
> > > > http://marc.theaimsgroup.com/?l=linux-aio&m=106983304420570&w=2  +
> > > >            
> > > > http://marc.theaimsgroup.com/?l=linux-kernel&m=106904658121299&w=2  +
> > > >        direct-io-memleak-fix.patch
> > > >  
> > > >     stock linux-2.6.0-test9 plus:
> > > >       aio-refcnt.patch  +
> > > >       dio-aio-fixes.patch +
> > > >       dio-aio-fixes-fixes.patch +
> > > >       O_DIRECT-race-fixes-rollup.patch 
> > > > 
> > > >     stock linux-2.6.0-test11 plus:
> > > >       O_DIRECT-race-fixes-rollup.patch
> > > >  
> > > > Thanks,
> > > > -Janet
> > > > 
> > > > ______________________________________________________________________
> > > > 
> > > > #define _XOPEN_SOURCE 600
> > > > #define _GNU_SOURCE
> > > > 
> > > > #include <unistd.h>
> > > > #include <stdlib.h>
> > > > #include <stdio.h>
> > > > #include <string.h>
> > > > #include <errno.h>
> > > > #include <sys/fcntl.h>
> > > > #include <sys/mman.h>
> > > > #include <sys/wait.h>
> > > > 
> > > > #define BIGSIZE 128*1024*1024
> > > > #define READSIZE 32*1024*1024
> > > > #define WRITESIZE 32*1024*1024
> > > > 
> > > > int pagesize;
> > > > char *iobuf;
> > > > 
> > > > void assert(const char *what, int assertion)
> > > > {
> > > > 	if (assertion)
> > > > 		return;
> > > > 	perror(what);
> > > > 	exit(1);
> > > > }
> > > > 
> > > > void do_buffered_writes(int fd, int pattern)
> > > > {
> > > > 	int rc;
> > > > 	int offset;
> > > > 	
> > > > 	memset(iobuf, pattern, WRITESIZE);
> > > > 	for (offset = 0; offset+WRITESIZE <= BIGSIZE; offset += WRITESIZE) {
> > > > 		rc = pwrite(fd, iobuf, WRITESIZE, offset);
> > > > 		assert("pwrite", rc >= 0);
> > > > 		if (rc != WRITESIZE) {
> > > > 			fprintf(stderr, "short write (%d out of %d)\n",
> > > > 				rc, WRITESIZE);
> > > > 			exit(1);
> > > > 		}
> > > > 		fsync(fd);
> > > > 	}
> > > > }
> > > > 
> > > > int do_direct_reads(char *filename)
> > > > {
> > > > 	int fd;
> > > > 	int offset;
> > > > 	int rc, i;
> > > > 	int *p;
> > > > 	
> > > > 	fd = open(filename, O_DIRECT|O_RDONLY, 0);
> > > > 	assert("open", fd >= 0);
> > > > 
> > > > 	for (offset = 0; offset+READSIZE <= BIGSIZE; offset += READSIZE) {
> > > > 		rc = pread(fd, iobuf, READSIZE, offset);
> > > > 		assert("pread", rc >= 0);
> > > > 		if (rc != READSIZE) {
> > > > 			fprintf(stderr, "short read (%d out of %d)\n",
> > > > 				rc, READSIZE);
> > > > 			exit(1);
> > > > 		}
> > > > 		for (i=0, p=(int *)iobuf; i<READSIZE; i+=4) {
> > > > 			if (*p) {
> > > > 				fprintf(stderr,
> > > > 					"Found data (%08x) at offset %d+%d\n",
> > > > 					*p, offset, i);
> > > > 				return 1;
> > > > 			}
> > > > 			p++;
> > > > 		}
> > > > 	}
> > > > 	return 0;
> > > > }
> > > > 
> > > > int main(int argc, char *argv[])
> > > > {
> > > > 	char *filename;
> > > > 	int fd;
> > > > 	int pid;
> > > > 	int err;
> > > > 	int pass = 0;
> > > > 	int bufsize;
> > > > 	
> > > > 	if (argc != 2) {
> > > > 		fprintf(stderr, "Needs a filename as an argument.\n");
> > > > 		exit(1);
> > > > 	}
> > > > 	
> > > > 	filename = argv[1];
> > > > 	
> > > > 	pagesize = getpagesize();
> > > > 	bufsize = READSIZE;
> > > > 	if (WRITESIZE > READSIZE)
> > > > 		bufsize = WRITESIZE;
> > > > 	err = posix_memalign((void**) &iobuf, pagesize, bufsize);
> > > > 	if (err) {
> > > > 		fprintf(stderr, "Error allocating %d aligned bytes.\n", bufsize);
> > > > 		exit(1);
> > > > 	}
> > > > 	
> > > > 	fd = open(filename, O_CREAT|O_TRUNC|O_RDWR, 0666);
> > > > 	assert("open", fd >= 0);
> > > > 	
> > > > 	do {
> > > > 		printf("Pass %d...\n", ++pass);
> > > > 		
> > > > 		assert("ftruncate", ftruncate(fd, BIGSIZE) == 0);
> > > > 		fsync(fd);
> > > > 
> > > > 		pid = fork();
> > > > 		assert("fork", pid >= 0);
> > > > 		
> > > > 		if (!pid) {
> > > > 			do_buffered_writes(fd, 0);
> > > > 			exit(0);
> > > > 		}
> > > > 		
> > > > 		err = do_direct_reads(filename);
> > > > 
> > > > 		wait4(pid, NULL, WNOHANG, 0);
> > > > 		
> > > > 		if (err) 
> > > > 			break;
> > > > 
> > > > 		/* Fill the file with a known pattern so that the blocks
> > > > 		 * on disk can be detected if they become exposed. */
> > > > 		do_buffered_writes(fd, 1);
> > > > 		fsync(fd);
> > > > 
> > > > 		assert("ftruncate", ftruncate(fd, 0) == 0);
> > > > 		fsync(fd);
> > > > 	} while (1);
> > > > 	
> > > > 	return err;
> > > > }
> > > > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=-fsY063Z7Raqhaa2KkoLS
Content-Disposition: attachment; filename=linux-2.6.0-test10-mm1.fdatawait.patch
Content-Type: text/plain; name=linux-2.6.0-test10-mm1.fdatawait.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.0-test10-mm1.ddm/mm/filemap.c	2003-12-05 17:14:57.000000000 -0800
+++ linux-2.6.0-test10-mm1.ddm.DIO/mm/filemap.c	2003-12-16 17:03:02.801786218 -0800
@@ -188,6 +188,20 @@ restart:
 		struct page *page;
 
 		page = list_entry(mapping->locked_pages.next,struct page,list);
+		/*
+		 * If the page is locked, it might be in process of being 
+		 * setup for writeback but without PG_writeback set 
+		 * and with PG_dirty cleared.
+		 * (PG_dirty is cleared BEFORE PG_writeback is set)
+		 * So, wait for the PG_locked to clear, then start over.
+		 */
+		if (PageLocked(page)) {
+			page_cache_get(page);
+			spin_unlock(&mapping->page_lock);
+			wait_on_page_locked(page);
+			page_cache_release(page);
+			goto restart;
+		}
 		list_del(&page->list);
 		if (PageDirty(page))
 			list_add(&page->list, &mapping->dirty_pages);

--=-fsY063Z7Raqhaa2KkoLS--

