Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbWEMSUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbWEMSUR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 14:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbWEMSUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 14:20:17 -0400
Received: from fmr19.intel.com ([134.134.136.18]:21912 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932486AbWEMSUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 14:20:15 -0400
Date: Sat, 13 May 2006 11:19:46 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ulrich Drepper <drepper@redhat.com>, Blaisorblade <blaisorblade@yahoo.it>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Memory Management <linux-mm@kvack.org>,
       Val Henson <val.henson@intel.com>
Subject: Re: [patch 00/14] remap_file_pages protection support
Message-ID: <20060513181945.GC9612@goober>
References: <20060430172953.409399000@zion.home.lan> <4456D5ED.2040202@yahoo.com.au> <200605030225.54598.blaisorblade@yahoo.it> <445CC949.7050900@redhat.com> <445D75EB.5030909@yahoo.com.au> <4465E981.60302@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4465E981.60302@yahoo.com.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2006 at 12:13:21AM +1000, Nick Piggin wrote:
> 
> OK, I got interested again, but can't get Val's ebizzy to give me
> a find_vma constrained workload yet (though the numbers back up
> my assertion that the vma cache is crap for threaded apps).

Hey Nick,

Glad to see you're using it!  There are (at least) two ways to do what
you want:

1. Increase the number of threads - this gives you two vma's per
   thread, one for stack, one for guard page:

   $ ./ebizzy -t 100

2. Apply the patch at the end of this email and use -p "prevent
   coalescing", -m "always mmap" and appropriate number of chunks,
   size, and records to search - this works for me:

   $ ./ebizzy -p -m -n 10000 -s 4096 -r 100000

The original program mmapped everything with the same permissions and
no alignment restrictions, so all the mmaps were coalesced into one.
This version alternates PROT_WRITE permissions on the mmap'd areas
after they are written, so you get lots of vma's:

val@goober:~/ebizzy$ ./ebizzy -p -m -n 10000 -s 4096 -r 100000

[2]+  Stopped                 ./ebizzy -p -m -n 10000 -s 4096 -r 100000
val@goober:~/ebizzy$ wc -l /proc/`pgrep ebizzy`/maps
10019 /proc/10917/maps

I haven't profiled to see if this brings find_vma to the top, though.

(The patch also moves around some other stuff so that options are in
alphabetical order; apparently I thought 's' came after 'r' and before
'R'...)

-VAL

--- ebizzy.c.old	2006-05-13 10:18:58.000000000 -0700
+++ ebizzy.c	2006-05-13 11:01:42.000000000 -0700
@@ -52,9 +52,10 @@
 static unsigned int always_mmap;
 static unsigned int never_mmap;
 static unsigned int chunks;
+static unsigned int prevent_coalescing;
 static unsigned int records;
-static unsigned int chunk_size;
 static unsigned int random_size;
+static unsigned int chunk_size;
 static unsigned int threads;
 static unsigned int verbose;
 static unsigned int linear;
@@ -76,9 +77,10 @@
 		"-m\t\t Always use mmap instead of malloc\n"
 		"-M\t\t Never use mmap\n"
 		"-n <num>\t Number of memory chunks to allocate\n"
+		"-p \t\t Prevent mmap coalescing\n"
 		"-r <num>\t Total number of records to search for\n"
-		"-s <size>\t Size of memory chunks, in bytes\n"
 		"-R\t\t Randomize size of memory to copy and search\n"
+		"-s <size>\t Size of memory chunks, in bytes\n"
 		"-t <num>\t Number of threads\n"
 		"-v[v[v]]\t Be verbose (more v's for more verbose)\n"
 		"-z\t\t Linear search instead of binary search\n",
@@ -98,7 +100,7 @@
 	cmd = argv[0];
 	opterr = 1;
 
-	while ((c = getopt(argc, argv, "mMn:r:s:Rt:vz")) != -1) {
+	while ((c = getopt(argc, argv, "mMn:pr:Rs:t:vz")) != -1) {
 		switch (c) {
 		case 'm':
 			always_mmap = 1;
@@ -111,19 +113,22 @@
 			if (chunks == 0)
 				usage();
 			break;
+		case 'p':
+			prevent_coalescing = 1;
+			break;
 		case 'r':
 			records = atoi(optarg);
 			if (records == 0)
 				usage();
 			break;
+		case 'R':
+			random_size = 1;
+			break;
 		case 's':
 			chunk_size = atoi(optarg);
 			if (chunk_size == 0)
 				usage();
 			break;
-		case 'R':
-			random_size = 1;
-			break;
 		case 't':
 			threads = atoi(optarg);
 			if (threads == 0)
@@ -141,7 +146,7 @@
 	}
 
 	if (verbose)
-		printf("ebizzy 0.1, Copyright 2006 Intel Corporation\n"
+		printf("ebizzy 0.2, Copyright 2006 Intel Corporation\n"
 		       "Written by Val Henson <val_henson@linux.intel.com\n");
 
 	/*
@@ -173,10 +178,11 @@
 		printf("always_mmap %u\n", always_mmap);
 		printf("never_mmap %u\n", never_mmap);
 		printf("chunks %u\n", chunks);
+		printf("prevent coalescing %u\n", prevent_coalescing);
 		printf("records %u\n", records);
 		printf("records per thread %u\n", records_per_thread);
-		printf("chunk_size %u\n", chunk_size);
 		printf("random_size %u\n", random_size);
+		printf("chunk_size %u\n", chunk_size);
 		printf("threads %u\n", threads);
 		printf("verbose %u\n", verbose);
 		printf("linear %u\n", linear);
@@ -251,9 +257,13 @@
 {
 	int i, j;
 
-	for (i = 0; i < chunks; i++)
+	for (i = 0; i < chunks; i++) {
 		for(j = 0; j < chunk_size / record_size; j++)
 			mem[i][j] = (record_t) j;
+		/* Prevent coalescing by alternating permissions */
+		if (prevent_coalescing && (i % 2) == 0)
+			mprotect(mem[i], chunk_size, PROT_READ);
+	}
 	if (verbose)
 		printf("Wrote memory\n");
 }
