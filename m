Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbUCOIHi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 03:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUCOIHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 03:07:38 -0500
Received: from holomorphy.com ([207.189.100.168]:14098 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262027AbUCOIFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 03:05:32 -0500
Date: Mon, 15 Mar 2004 00:05:20 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-aio@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: aio tiobench
Message-ID: <20040315080520.GC655@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-aio@kvack.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So I farted around for a hour or two seeing if I could get tiobench
to do aio for the general purpose of exercising codepaths, benchmarking,
etc. in simple ways. Hopefully this answers the need for regular,
simple, and easily-available methods of exercising and/or benchmarking
the aio code in some way.

What I have, vs. debian's tiobench-0.3.3, follows. It works here (TM),
for some value of "works" that bears no relation to how meaningful the
numbers the thing spews are. Someone might want to rearrange how the
timing bits work in order to make it line up with what they think would
be meaningful. At the moment it just treats setting up IO requests like
ordinary IO operations and has waiting for the batches to go through
interspersed in all that.

Would rewriting tiobench from scratch instead be more valuable?


-- wli

$ diffstat tiobench.patch
 Makefile  |   16 +-
 aio.c     |   36 ++++
 tiotest.c |  456 ++++++++++++++++++++++++++++++++++++++++++++++----------------
 tiotest.h |   10 +
 4 files changed, 398 insertions(+), 120 deletions(-)


diff -prauN tiobench-0.3.3/Makefile tiobench-0.3.3-wli/Makefile
--- tiobench-0.3.3/Makefile	2004-03-14 21:15:06.099084000 -0800
+++ tiobench-0.3.3-wli/Makefile	2004-03-14 23:17:44.181486000 -0800
@@ -2,16 +2,13 @@
 
 CC=gcc
 #CFLAGS=-O3 -fomit-frame-pointer -Wall
-CFLAGS = -Wall -g
+CFLAGS += -Wall -g
 ifneq (,$(findstring noopt,$(DEB_BUILD_OPTIONS)))
 CFLAGS += -O0
 else
 CFLAGS += -O2
 endif
 
-#DEFINES=-DUSE_MMAP 
-#-DUSE_MADVISE
-
 # This enables support for 64bit file offsets, allowing
 # possibility to test with files larger than (2^31) bytes.
 
@@ -21,6 +18,7 @@ endif
 
 LINK=gcc
 EXE=tiotest
+OBJ:=tiotest.o crc32.o aio.o
 PROJECT=tiobench
 # do it once instead of each time referenced
 VERSION=$(shell egrep "tiotest v[0-9]+.[0-9]+" tiotest.c | cut -d " " -f 7 | sed "s/v//g")
@@ -32,20 +30,23 @@ DOCDIR=/usr/local/doc/$(DISTNAME)
 
 all: $(EXE)
 
+aio.o:
+	$(CC) -c $(CFLAGS) $(DEFINES) aio.c -o aio.o
+
 crc32.o: crc32.c crc32.h
 	$(CC) -c $(CFLAGS) $(DEFINES) crc32.c -o crc32.o
 
 tiotest.o: tiotest.c tiotest.h crc32.h crc32.c Makefile
 	$(CC) -c $(CFLAGS) $(DEFINES) tiotest.c -o tiotest.o
 
-$(EXE): tiotest.o crc32.o
-	$(LINK) -o $(EXE) tiotest.o crc32.o -lpthread
+$(EXE): $(OBJ)
+	$(LINK) -o $@ $^ -lpthread
 	@echo
 	@echo "./tiobench.pl --help for usage options"
 	@echo
 
 clean:
-	rm -f tiotest.o crc32.o $(EXE) core
+	$(RM) $(OBJ) $(EXE) core
 
 dist:
 	ln -s . $(DISTNAME)
@@ -73,4 +74,3 @@ uninstall:
 	rm -f $(BINDIR)/tiobench.pl
 	rm -f $(BINDIR)/tiosum.pl
 	rm -rf $(DOCDIR)
-
diff -prauN tiobench-0.3.3/aio.c tiobench-0.3.3-wli/aio.c
--- tiobench-0.3.3/aio.c	1969-12-31 16:00:00.000000000 -0800
+++ tiobench-0.3.3-wli/aio.c	2004-03-14 21:02:29.112164000 -0800
@@ -0,0 +1,36 @@
+#define __KERNEL_SYSCALLS__
+extern int errno;
+
+#include <linux/aio_abi.h>
+#include <linux/types.h>
+#include <asm/unistd.h>
+
+#ifndef __NR_io_setup
+#define __NR_io_setup           268
+#endif
+
+#ifndef __NR_io_destroy
+#define __NR_io_destroy         269
+#endif
+
+#ifndef __NR_io_submit
+#define __NR_io_submit          270
+#endif
+
+#ifndef __NR_io_cancel
+#define __NR_io_cancel          271
+#endif
+
+#ifdef __NR_io_getevents
+#error shit
+#endif
+
+#ifndef __NR_io_getevents
+#define __NR_io_getevents       272
+#endif
+
+_syscall2(long,io_setup,unsigned,nr_events,aio_context_t *,context);
+_syscall1(long,io_destroy,aio_context_t,context);
+_syscall3(long,io_submit,aio_context_t,context,long,nr,struct iocb **,iocbs);
+_syscall3(long,io_cancel,aio_context_t,context,struct iocb *,iocb,struct io_event *,results);
+_syscall5(long,io_getevents,aio_context_t,context,long,min_nr,long,nr,struct io_event *,events,struct timespec *,timeout);
diff -prauN tiobench-0.3.3/tiotest.c tiobench-0.3.3-wli/tiotest.c
--- tiobench-0.3.3/tiotest.c	2001-03-04 18:34:00.000000000 -0800
+++ tiobench-0.3.3-wli/tiotest.c	2004-03-14 23:41:40.010207000 -0800
@@ -23,6 +23,14 @@
 #include "tiotest.h"
 #include "crc32.h"
 
+#include <linux/aio_abi.h>
+
+long io_setup(unsigned, aio_context_t *);
+long io_destroy(aio_context_t);
+long io_submit(aio_context_t, long, struct iocb **);
+long io_getevents(aio_context_t, long, long, struct io_event *, struct timespec *);
+long io_cancel(aio_context_t, struct iocb *, struct io_event *);
+
 static const char* versionStr = "tiotest v0.3.3 (C) 1999-2000 Mika Kuoppala <miku@iki.fi>";
 
 /* 
@@ -70,7 +78,8 @@ int main(int argc, char *argv[])
 	for(i = 0; i < TESTS_COUNT; i++)
 		args.testsToRun[i] = 1;
 	
-#if (LARGEFILES && USE_MMAP)
+#if LARGEFILES
+	if (args.style == MmapIO)
 	printf("warning: LARGEFILES with MMAP needs mmap64 support which is not working yet in tiotest!\n");
 #endif
 
@@ -114,13 +123,22 @@ void parse_args( ArgumentOptions* args, 
 
 	while (1)
 	{
-		c = getopt( argc, argv, "f:b:d:t:r:D:k:o:hLRTWSOc");
+		c = getopt( argc, argv, "f:b:d:t:r:D:k:o:hLRTWSOcamw");
 
 		if (c == -1)
 			break;
 	
 		switch (c)
 		{
+		case 'a':
+			args->style = AsyncIO;
+			break;
+		case 'm':
+			args->style = MmapIO;
+			break;
+		case 'w':
+			args->mapflag = 1;
+			break;
 		case 'f':
 			args->fileSizeInMBytes = atoi(optarg);
 			checkIntZero(args->fileSizeInMBytes, "Wrong file size\n");
@@ -869,12 +887,8 @@ void report_seek_error(toff_t offset, un
 {
 	char buf[1024];
 	sprintf(buf, 
-#ifdef LARGEFILES			
 		"Error in seek, offset= %Ld, seeks = %ld: ", 
-#else				
-		"Error in seek, offset = %ld, seeks = %ld:",
-#endif				
-		offset, wr );
+		(unsigned long long)offset, wr );
 	perror(buf);
 }
 
@@ -882,12 +896,8 @@ void report_random_write_error(toff_t of
 {
 	char buf[1024];
 	sprintf(buf, 
-#ifdef LARGEFILES
-		"Error in randomwrite, off=%Ld, read=%d, seeks=%ld : ", 
-#else
-		"Error in randomwrite, off=%ld, read=%d, seeks=%ld : ",
-#endif
-		offset, bytesWritten, wr );
+		"Error in randomwrite, off=%Ld, read=%ld, seeks=%ld : ", 
+		(unsigned long long)offset, (long)bytesWritten, wr );
 		    
 		perror(buf);
 }
@@ -896,28 +906,116 @@ void report_read_error(toff_t offset, ss
 {
 	char buf[1024];
 	sprintf(buf, 
-#ifdef LARGEFILES
-		"Error in seek/read, off=%Ld, read=%d, seeks=%ld : ", 
-#else
-		"Error in seek/read, off=%ld, read=%d, seeks=%ld : ",
-#endif
-		offset, bytesRead, rd );
+		"Error in seek/read, off=%Ld, read=%ld, seeks=%ld : ", 
+		(unsigned long long)offset, (long)bytesRead, rd );
 		    
 	perror(buf);
 }
 
+#define MAX_AIO_DELAY	1
+#define MIN_AIO_EVENTS	16
+#define NR_AIO_OPS	1024
+
+static int aio_wait(const char *func,
+		    aio_context_t context,
+		    int fd,
+		    struct iocb **iocb_ptr_array,
+		    struct iocb *iocbs,
+		    struct io_event *events,
+		    int n)
+{
+	int pending = n;
+	struct timespec time;
+	time.tv_nsec = 0;
+	time.tv_sec = MAX_AIO_DELAY;
+	do {
+		int k, done;
+
+		if (args.debugLevel > 1)
+			fprintf(stderr, "waiting for %d events\n", pending);
+		done = io_getevents(context, MIN_AIO_EVENTS, pending, events, &time);
+		if (args.debugLevel > 1)
+			fprintf(stderr, "got %d events\n", done);
+		for (k = 0; k < done; ++k) {
+			if ((int)events[k].res < 0) {
+				struct iocb *err_iocb;
+				perror("io request failed");
+				err_iocb = (struct iocb *)(unsigned long)events[k].obj;
+				fprintf(stderr, "func = %s, "
+						"result = %Ld, "
+						"opcode = %d, "
+						"offset = 0x%Lx, "
+						"buf = 0x%p, "
+						"len = 0x%Lx\n",
+						func,
+						(unsigned long long)events[k].res,
+						err_iocb->aio_lio_opcode,
+						(unsigned long long)
+							err_iocb->aio_offset,
+						(void *)(unsigned long)
+							err_iocb->aio_buf,
+						(unsigned long long)
+							err_iocb->aio_nbytes);
+				free(events);
+				free(iocb_ptr_array);
+				free(iocbs);
+				io_destroy(context);
+				close(fd);
+				return events[k].res;
+			}
+		}
+		pending -= done;
+	} while (pending);
+	return 0;
+}
+
+static int aio_setup(int fd, aio_context_t *context, struct iocb ***iocb_ptr_array, struct iocb **iocbs, struct io_event **events)
+{
+	if (io_setup(NR_AIO_OPS, context)) {
+		perror("error setting up io context");
+		goto closefd;
+	}
+	if (!(*iocbs = calloc(NR_AIO_OPS, sizeof(struct iocb)))) {
+		perror("error allocating iocbs");
+		goto destroy;
+	}
+	if (!(*iocb_ptr_array = calloc(NR_AIO_OPS, sizeof(struct iocb *)))) {
+		perror("error allocating iocb pointer array");
+		goto free_iocbs;
+	} else {
+		int k;
+		for (k = 0; k < NR_AIO_OPS; ++k)
+			(*iocb_ptr_array)[k] = &((*iocbs)[k]);
+	}
+	if (!(*events = calloc(NR_AIO_OPS, sizeof(struct io_event)))) {
+		perror("error allocation io_event array");
+		goto free_iocb_ptrs;
+	}
+	return 0;
+free_iocb_ptrs:
+	free(iocb_ptr_array);
+free_iocbs:
+	free(iocbs);
+destroy:
+	io_destroy(*context);
+closefd:
+	close(fd);
+	return -ENOMEM;
+}
+
 void* do_write_test( ThreadData *d )
 {
 	int     fd;
 	char    *buf = d->buffer;
 	toff_t  blocks=(d->fileSizeInMBytes*MBYTE)/d->blockSize;
 	toff_t  i;
-	int     openFlags;
-	
-#ifdef USE_MMAP
+	int     openFlags, iocb_idx = 0;
 	toff_t  bytesize=blocks*d->blockSize; /* truncates down to BS multiple */
-	void *file_loc;
-#endif
+	void *file_loc = NULL;
+	aio_context_t context;
+	struct iocb **iocb_ptr_array = NULL;
+	struct iocb *iocbs = NULL;
+	struct io_event *events = NULL;
 
 	if (args.rawDrives) 
 		openFlags = O_RDWR;
@@ -944,29 +1042,30 @@ void* do_write_test( ThreadData *d )
 		fflush(stderr);
 	}
 	
-#ifdef USE_MMAP
-	if (!args.rawDrives) 
-		ftruncate(fd,bytesize); /* pre-allocate space */
-	file_loc=mmap(NULL,bytesize,PROT_READ|PROT_WRITE,MAP_SHARED,fd,
-		d->fileOffset);
-	if(file_loc == MAP_FAILED) 
-	{
-		perror("Error mmap()ing file");
-		close(fd);
-		return 0;
-	}
-#  ifdef USE_MADVISE
-	/* madvise(file_loc,bytesize,MADV_DONTNEED); */
-	madvise(file_loc,bytesize,MADV_RANDOM);
-#  endif
-#else
-	if( tlseek( fd, d->fileOffset, SEEK_SET ) != d->fileOffset )
-	{
-		report_seek_error(d->fileOffset, d->blocksRandomWritten);
-		close(fd);
-		return 0;
+	if (args.style == MmapIO) {
+		if (!args.rawDrives) 
+			ftruncate(fd,bytesize); /* pre-allocate space */
+		file_loc=mmap(NULL,bytesize,PROT_READ|PROT_WRITE,MAP_SHARED,fd,
+			d->fileOffset);
+		if(file_loc == MAP_FAILED) 
+		{
+			perror("Error mmap()ing file");
+			close(fd);
+			return 0;
+		}
+	} else if (args.style == AsyncIO) {
+		if (aio_setup(fd, &context, &iocb_ptr_array, &iocbs, &events))
+			return 0;
+	} else {
+		if (args.mapflag)
+			madvise(file_loc, bytesize, MADV_RANDOM);
+		if( tlseek( fd, d->fileOffset, SEEK_SET ) != d->fileOffset )
+		{
+			report_seek_error(d->fileOffset, d->blocksRandomWritten);
+			close(fd);
+			return 0;
+		}
 	}
-#endif
 
 	timer_start( &(d->writeTimings) );
 	
@@ -975,15 +1074,32 @@ void* do_write_test( ThreadData *d )
 		struct timeval tv_start, tv_stop;
 		double value;
 		gettimeofday(&tv_start, NULL);
-#ifdef USE_MMAP
-		memcpy(file_loc + i * d->blockSize,buf,d->blockSize);
-#else
-		if( write( fd, buf, d->blockSize ) != d->blockSize )
-		{
-			perror("Error writing to file");
-			break;
+		if (args.style == MmapIO)
+			memcpy(file_loc + i * d->blockSize,buf,d->blockSize);
+		else if (args.style == AsyncIO) {
+			if (iocb_idx >= NR_AIO_OPS) {
+				iocb_idx = 0;
+				if (io_submit(context, NR_AIO_OPS, iocb_ptr_array) == NR_AIO_OPS) {
+					if (aio_wait(__FUNCTION__, context, fd, iocb_ptr_array, iocbs, events, NR_AIO_OPS))
+						return 0;
+				} else {
+					perror("do_write_test: error submitting io requests");
+					break;
+				}
+			}
+			iocbs[iocb_idx].aio_lio_opcode =IOCB_CMD_PWRITE;
+			iocbs[iocb_idx].aio_fildes = fd;
+			iocbs[iocb_idx].aio_buf = (u_int64_t)(unsigned long)buf;
+			iocbs[iocb_idx].aio_nbytes = d->blockSize;
+			iocbs[iocb_idx].aio_offset = i*d->blockSize;
+			iocb_idx++;
+		} else {
+			if( write( fd, buf, d->blockSize ) != d->blockSize )
+			{
+				perror("Error writing to file");
+				break;
+			}
 		}
-#endif
 		d->blocksWritten++;
 		
 		gettimeofday(&tv_stop, NULL);
@@ -997,11 +1113,22 @@ void* do_write_test( ThreadData *d )
 			d->writeLatency.count1++;
 		if (value > (double)LATENCY_STAT2)
 			d->writeLatency.count2++;
-	} 
+	}
     
-#ifdef USE_MMAP
-	munmap(file_loc,bytesize);
-#endif
+	if (args.style == MmapIO)
+		munmap(file_loc,bytesize);
+	else if (args.style == AsyncIO) {
+		if (io_submit(context, iocb_idx, iocb_ptr_array) == iocb_idx) {
+			if (aio_wait(__FUNCTION__, context, fd, iocb_ptr_array, iocbs, events, iocb_idx))
+				return 0;
+		} else {
+			perror("do_write_test: error submitting io requests");
+			return 0;
+		}
+		free(iocb_ptr_array);
+		free(iocbs);
+		free(events);
+	}
 
 	fsync(fd);
 
@@ -1020,9 +1147,13 @@ void* do_random_write_test( ThreadData *
 	int      fd;
 	toff_t   offset;
 	ssize_t  bytesWritten;
-	int      openFlags = O_WRONLY;
+	int      openFlags = O_WRONLY, iocb_idx = 0;
 	
 	unsigned int seed = get_random_seed();
+	aio_context_t context;
+	struct iocb **iocb_ptr_array = NULL;
+	struct iocb *iocbs = NULL;
+	struct io_event *events = NULL;
 	
 	if( args.syncWriting )
 		openFlags |= O_SYNC;
@@ -1037,6 +1168,11 @@ void* do_random_write_test( ThreadData *
 		fprintf(stderr, "%s: %s\n", strerror(errno), d->fileName);
 		return 0;
 	}
+
+	if (args.style == AsyncIO) {
+		if (aio_setup(fd, &context, &iocb_ptr_array, &iocbs, &events))
+			return 0;
+	}
 	
 	if (args.debugLevel > 1)
 	{
@@ -1075,11 +1211,30 @@ void* do_random_write_test( ThreadData *
 		
 		gettimeofday(&tv_start, NULL);
 
-		if( (bytesWritten = write( fd, buf, d->blockSize )) != d->blockSize )
-		{
-			report_random_write_error(offset, bytesWritten, 
-				d->blocksRandomWritten);
-			break;
+		if (args.style == AsyncIO) {
+			if (iocb_idx >= NR_AIO_OPS) {
+				iocb_idx = 0;
+				if (io_submit(context, NR_AIO_OPS, iocb_ptr_array) == NR_AIO_OPS) {
+					if (aio_wait(__FUNCTION__, context, fd, iocb_ptr_array, iocbs, events, NR_AIO_OPS))
+						return 0;
+				} else {
+					perror("do_random_write_test: error submitting io requests");
+					break;
+				}
+			}
+			iocbs[iocb_idx].aio_lio_opcode =IOCB_CMD_PWRITE;
+			iocbs[iocb_idx].aio_fildes = fd;
+			iocbs[iocb_idx].aio_buf = (u_int64_t)(unsigned long)buf;
+			iocbs[iocb_idx].aio_nbytes = d->blockSize;
+			iocbs[iocb_idx].aio_offset = offset;
+			iocb_idx++;
+		} else {
+			if( (bytesWritten = write( fd, buf, d->blockSize )) != d->blockSize )
+			{
+				report_random_write_error(offset, bytesWritten, 
+					d->blocksRandomWritten);
+				break;
+			}
 		}
 	
 		d->blocksRandomWritten++;
@@ -1095,8 +1250,20 @@ void* do_random_write_test( ThreadData *
 			d->randomWriteLatency.count1++;
 		if (value > (double)LATENCY_STAT2)
 			d->randomWriteLatency.count2++;
-	} 
+	}
 
+	if (args.style == AsyncIO) {
+		if (io_submit(context, iocb_idx, iocb_ptr_array) == iocb_idx) {
+			if (aio_wait(__FUNCTION__, context, fd, iocb_ptr_array, iocbs, events, iocb_idx))
+				return 0;
+		} else {
+			perror("do_write_test: error submitting io requests");
+			return 0;
+		}
+		free(iocb_ptr_array);
+		free(iocbs);
+		free(events);
+	}
 	fsync(fd);
 
 	close(fd);
@@ -1112,12 +1279,14 @@ void* do_read_test( ThreadData *d )
 	int     fd;
 	toff_t  blocks=(d->fileSizeInMBytes*MBYTE)/d->blockSize;
 	toff_t  i;
-	int     openFlags = O_RDONLY;
+	int     openFlags = O_RDONLY, iocb_idx = 0;
  
-#ifdef USE_MMAP
 	toff_t  bytesize=blocks*d->blockSize; /* truncates down to BS multiple */
-	void *file_loc;
-#endif
+	void *file_loc = NULL;
+	aio_context_t context;
+	struct iocb **iocb_ptr_array = NULL;
+	struct iocb *iocbs = NULL;
+	struct io_event *events = NULL;
 
 #ifdef LARGEFILES
 	openFlags |= O_LARGEFILE;
@@ -1136,27 +1305,28 @@ void* do_read_test( ThreadData *d )
 		fflush(stderr);
 	}
 
-#ifdef USE_MMAP
-	file_loc=mmap(NULL,bytesize,PROT_READ,MAP_SHARED,fd,d->fileOffset);
-	if(file_loc == MAP_FAILED) 
-	{
-		perror("Error mmap()ing file");
-		close(fd);
-		return 0;
-	}
-#  ifdef USE_MADVISE
-	/* madvise(file_loc,bytesize,MADV_DONTNEED); */
-	madvise(file_loc,bytesize,MADV_RANDOM);
-#  endif
-#else
-	if( tlseek( fd, d->fileOffset, SEEK_SET ) != d->fileOffset )
-	{
-		report_seek_error(d->fileOffset, 
-			d->blocksRandomWritten);
-		close(fd);
-		return 0;
+	if (args.style == MmapIO) {
+		file_loc=mmap(NULL,bytesize,PROT_READ,MAP_SHARED,fd,d->fileOffset);
+		if(file_loc == MAP_FAILED) 
+		{
+			perror("Error mmap()ing file");
+			close(fd);
+			return 0;
+		}
+		if (args.mapflag)
+			madvise(file_loc, bytesize, MADV_RANDOM);
+	} else if (args.style == AsyncIO) {
+		if (aio_setup(fd, &context, &iocb_ptr_array, &iocbs, &events))
+			return 0;
+	} else {
+		if( tlseek( fd, d->fileOffset, SEEK_SET ) != d->fileOffset )
+		{
+			report_seek_error(d->fileOffset, 
+				d->blocksRandomWritten);
+			close(fd);
+			return 0;
+		}
 	}
-#endif
 
 	timer_start( &(d->readTimings) );
 
@@ -1165,15 +1335,32 @@ void* do_read_test( ThreadData *d )
 		struct timeval tv_start, tv_stop;
 		double value;
 		gettimeofday(&tv_start, NULL);
-#ifdef USE_MMAP
-		memcpy(buf,file_loc + i * d->blockSize,d->blockSize);
-#else
-		if( read( fd, buf, d->blockSize ) != d->blockSize )
-		{
-			perror("Error read from file");
-			break;
+		if (args.style == MmapIO)
+			memcpy(buf,file_loc + i * d->blockSize,d->blockSize);
+		else if (args.style == AsyncIO) {
+			if (iocb_idx >= NR_AIO_OPS) {
+				iocb_idx = 0;
+				if (io_submit(context, NR_AIO_OPS, iocb_ptr_array) == NR_AIO_OPS) {
+					if (aio_wait(__FUNCTION__, context, fd, iocb_ptr_array, iocbs, events, NR_AIO_OPS))
+						return 0;
+				} else {
+					perror("do_read_test: error submitting io requests");
+					break;
+				}
+			}
+			iocbs[iocb_idx].aio_lio_opcode =IOCB_CMD_PREAD;
+			iocbs[iocb_idx].aio_fildes = fd;
+			iocbs[iocb_idx].aio_buf = (u_int64_t)(unsigned long)buf;
+			iocbs[iocb_idx].aio_nbytes = d->blockSize;
+			iocbs[iocb_idx].aio_offset = i*d->blockSize;
+			iocb_idx++;
+		} else {
+			if( read( fd, buf, d->blockSize ) != d->blockSize )
+			{
+				perror("Error read from file");
+				break;
+			}
 		}
-#endif
 		gettimeofday(&tv_stop, NULL);
 		value = tv_stop.tv_sec - tv_start.tv_sec;
 		value += (tv_stop.tv_usec - tv_start.tv_usec)/1000000.0;
@@ -1204,11 +1391,21 @@ void* do_read_test( ThreadData *d )
     
 	timer_stop( &(d->readTimings) );
 
-#ifdef MMAP
-	munmap(file_loc,bytesize);
-#endif
+	if (args.style == MmapIO)
+		munmap(file_loc,bytesize);
+	else if (args.style == AsyncIO) {
+		if (io_submit(context, iocb_idx, iocb_ptr_array) == iocb_idx) {
+			if (aio_wait(__FUNCTION__, context, fd, iocb_ptr_array, iocbs, events, iocb_idx))
+				return 0;
+		} else {
+			perror("do_write_test: error submitting io requests");
+			return 0;
+		}
+		free(iocb_ptr_array);
+		free(iocbs);
+		free(events);
+	}
 	close(fd);
-
 	return 0;
 }
 
@@ -1220,9 +1417,13 @@ void* do_random_read_test( ThreadData *d
 	int      fd;
 	toff_t   offset;
 	ssize_t  bytesRead;
-	int      openFlags = O_RDONLY;
+	int      openFlags = O_RDONLY, iocb_idx = 0;
 
 	unsigned int seed = get_random_seed();
+	aio_context_t context;
+	struct iocb **iocb_ptr_array = NULL;
+	struct iocb *iocbs = NULL;
+	struct io_event *events = NULL;
 
 #ifdef LARGEFILES
 	openFlags |= O_LARGEFILE;
@@ -1234,7 +1435,12 @@ void* do_random_read_test( ThreadData *d
 		fprintf(stderr, "%s: %s\n", strerror(errno), d->fileName);
 		return 0;
 	}
-	
+
+	if (args.style == AsyncIO) {
+		if (aio_setup(fd, &context, &iocb_ptr_array, &iocbs, &events))
+			return 0;
+	}
+
 	if (args.debugLevel > 1)
 	{
 		fprintf(stderr, "do_random_read_test: initial seek %lu\n", d->fileOffset);
@@ -1273,11 +1479,30 @@ void* do_random_read_test( ThreadData *d
 
 		gettimeofday(&tv_start, NULL);
 
-		if( (bytesRead = read( fd, buf, d->blockSize )) != d->blockSize )
-		{
-			report_read_error(offset, bytesRead, 
-				d->blocksRandomRead);
-			break;
+		if (args.style == AsyncIO) {
+			if (iocb_idx >= NR_AIO_OPS) {
+				iocb_idx = 0;
+				if (io_submit(context, NR_AIO_OPS, iocb_ptr_array) == NR_AIO_OPS) {
+					if (aio_wait(__FUNCTION__, context, fd, iocb_ptr_array, iocbs, events, NR_AIO_OPS))
+						return 0;
+				} else {
+					perror("do_random_read_test: error submitting io requests");
+					break;
+				}
+			}
+			iocbs[iocb_idx].aio_lio_opcode =IOCB_CMD_PREAD;
+			iocbs[iocb_idx].aio_fildes = fd;
+			iocbs[iocb_idx].aio_buf = (u_int64_t)(unsigned long)buf;
+			iocbs[iocb_idx].aio_nbytes = d->blockSize;
+			iocbs[iocb_idx].aio_offset = offset;
+			iocb_idx++;
+		} else {
+			if( (bytesRead = read( fd, buf, d->blockSize )) != d->blockSize )
+			{
+				report_read_error(offset, bytesRead, 
+					d->blocksRandomRead);
+				break;
+			}
 		}
 		
 		gettimeofday(&tv_stop, NULL);
@@ -1307,11 +1532,20 @@ void* do_random_read_test( ThreadData *d
 
 		d->blocksRandomRead++;
 	} 
-	
 	timer_stop( &(d->randomReadTimings) );
-
+	if (args.style == AsyncIO) {
+		if (io_submit(context, iocb_idx, iocb_ptr_array) == iocb_idx) {
+			if (aio_wait(__FUNCTION__, context, fd, iocb_ptr_array, iocbs, events, iocb_idx))
+				return 0;
+		} else {
+			perror("do_write_test: error submitting io requests");
+			return 0;
+		}
+		free(iocb_ptr_array);
+		free(iocbs);
+		free(events);
+	}
 	close(fd);
-
 	return 0;
 }
 
diff -prauN tiobench-0.3.3/tiotest.h tiobench-0.3.3-wli/tiotest.h
--- tiobench-0.3.3/tiotest.h	2001-02-14 08:15:04.000000000 -0800
+++ tiobench-0.3.3-wli/tiotest.h	2004-03-14 20:00:45.091261000 -0800
@@ -53,7 +53,7 @@
 #endif
 #endif
 
-#if (LARGEFILES && USE_MMAP)
+#if LARGEFILES
 #warning "LARGEFILES and USE_MMAP might not work on 32bit architectures!"
 #endif
 
@@ -153,6 +153,12 @@ typedef struct {
 
 } ThreadTest;
 
+enum ioStyle {
+	NormalIO,
+	AsyncIO,
+	MmapIO,
+};
+
 typedef struct {
 	
 	char     path[MAX_PATHS][KBYTE];
@@ -181,6 +187,8 @@ typedef struct {
 	  This should be from 0 - 10
 	*/
 	int      debugLevel;
+	enum ioStyle style;
+	int      mapflag;
 
 } ArgumentOptions;
 
