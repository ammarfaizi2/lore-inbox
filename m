Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265816AbUFIPfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265816AbUFIPfW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 11:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266176AbUFIPeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 11:34:04 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:59777 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266166AbUFIPcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 11:32:13 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] DM 5/5: Documentation
Date: Wed, 9 Jun 2004 10:32:51 +0000
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406091032.51590.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Device-Mapper documentation.

Signed-off-by: Kevin Corry <kevcorry@us.ibm.com>

--- diff/Documentation/device-mapper/dm-io.txt	1970-01-01 00:00:00.000000000 +0000
+++ source/Documentation/device-mapper/dm-io.txt	2004-06-09 08:52:22.738803464 +0000
@@ -0,0 +1,75 @@
+dm-io
+=====
+
+Dm-io provides synchronous and asynchronous I/O services. There are three
+types of I/O services available, and each type has a sync and an async
+version.
+
+The user must set up an io_region structure to describe the desired location 
+of the I/O. Each io_region indicates a block-device along with the starting
+sector and size of the region.
+
+   struct io_region {
+      struct block_device *bdev;
+      sector_t sector;
+      sector_t count;
+   };
+
+Dm-io can read from one io_region or write to one or more io_regions. Writes
+to multiple regions are specified by an array of io_region structures.
+
+The first I/O service type takes a list of memory pages as the data buffer for
+the I/O, along with an offset into the first page.
+
+   struct page_list {
+      struct page_list *next;
+      struct page *page;
+   };
+
+   int dm_io_sync(unsigned int num_regions, struct io_region *where, int rw,
+                  struct page_list *pl, unsigned int offset,
+                  unsigned long *error_bits);
+   int dm_io_async(unsigned int num_regions, struct io_region *where, int rw,
+                   struct page_list *pl, unsigned int offset,
+                   io_notify_fn fn, void *context);
+
+The second I/O service type takes an array of bio vectors as the data buffer
+for the I/O. This service can be handy if the caller has a pre-assembled bio,
+but wants to direct different portions of the bio to different devices.
+
+   int dm_io_sync_bvec(unsigned int num_regions, struct io_region *where,
+                       int rw, struct bio_vec *bvec,
+                       unsigned long *error_bits);
+   int dm_io_async_bvec(unsigned int num_regions, struct io_region *where,
+                        int rw, struct bio_vec *bvec,
+                        io_notify_fn fn, void *context);
+
+The third I/O service type takes a pointer to a vmalloc'd memory buffer as the
+data buffer for the I/O. This service can be handy if the caller needs to do
+I/O to a large region but doesn't want to allocate a large number of individual
+memory pages.
+
+   int dm_io_sync_vm(unsigned int num_regions, struct io_region *where, int rw,
+                     void *data, unsigned long *error_bits);
+   int dm_io_async_vm(unsigned int num_regions, struct io_region *where, int rw,
+                      void *data, io_notify_fn fn, void *context);
+
+Callers of the asynchronous I/O services must include the name of a completion
+callback routine and a pointer to some context data for the I/O.
+
+   typedef void (*io_notify_fn)(unsigned long error, void *context);
+
+The "error" parameter in this callback, as well as the "*error" parameter in
+all of the synchronous versions, is a bitset (instead of a simple error value).
+In the case of an write-I/O to multiple regions, this bitset allows dm-io to
+indicate success or failure on each individual region.
+
+Before using any of the dm-io services, the user should call dm_io_get()
+and specify the number of pages they expect to perform I/O on concurrently.
+Dm-io will attempt to resize its mempool to make sure enough pages are
+always available in order to avoid unnecessary waiting while performing I/O.
+
+When the user is finished using the dm-io services, they should call
+dm_io_put() and specify the same number of pages that were given on the
+dm_io_get() call.
+
--- diff/Documentation/device-mapper/kcopyd.txt	1970-01-01 00:00:00.000000000 +0000
+++ source/Documentation/device-mapper/kcopyd.txt	2004-06-09 08:52:22.739803312 +0000
@@ -0,0 +1,47 @@
+kcopyd
+======
+
+Kcopyd provides the ability to copy a range of sectors from one block-device
+to one or more other block-devices, with an asynchronous completion
+notification. It is used by dm-snapshot and dm-mirror.
+
+Users of kcopyd must first create a client and indicate how many memory pages
+to set aside for their copy jobs. This is done with a call to
+kcopyd_client_create().
+
+   int kcopyd_client_create(unsigned int num_pages,
+                            struct kcopyd_client **result);
+
+To start a copy job, the user must set up io_region structures to describe
+the source and destinations of the copy. Each io_region indicates a
+block-device along with the starting sector and size of the region. The source
+of the copy is given as one io_region structure, and the destinations of the
+copy are given as an array of io_region structures.
+
+   struct io_region {
+      struct block_device *bdev;
+      sector_t sector;
+      sector_t count;
+   };
+
+To start the copy, the user calls kcopyd_copy(), passing in the client
+pointer, pointers to the source and destination io_regions, the name of a
+completion callback routine, and a pointer to some context data for the copy.
+
+   int kcopyd_copy(struct kcopyd_client *kc, struct io_region *from,
+                   unsigned int num_dests, struct io_region *dests,
+                   unsigned int flags, kcopyd_notify_fn fn, void *context);
+
+   typedef void (*kcopyd_notify_fn)(int read_err, unsigned int write_err,
+				    void *context);
+
+When the copy completes, kcopyd will call the user's completion routine,
+passing back the user's context pointer. It will also indicate if a read or
+write error occurred during the copy.
+
+When a user is done with all their copy jobs, they should call
+kcopyd_client_destroy() to delete the kcopyd client, which will release the
+associated memory pages.
+
+   void kcopyd_client_destroy(struct kcopyd_client *kc);
+
--- diff/Documentation/device-mapper/linear.txt	1970-01-01 00:00:00.000000000 +0000
+++ source/Documentation/device-mapper/linear.txt	2004-06-09 08:52:22.740803160 +0000
@@ -0,0 +1,61 @@
+dm-linear
+=========
+
+Device-Mapper's "linear" target maps a linear range of the Device-Mapper
+device onto a linear range of another device.  This is the basic building
+block of logical volume managers.
+
+Parameters: <dev path> <offset>
+    <dev path>: Full pathname to the underlying block-device, or a
+                "major:minor" device-number.
+    <offset>: Starting sector within the device.
+
+
+Example scripts
+===============
+[[
+#!/bin/sh
+# Create an identity mapping for a device
+echo "0 `blockdev --getsize $1` linear $1 0" | dmsetup create identity
+]]
+
+
+[[
+#!/bin/sh
+# Join 2 devices together
+size1=`blockdev --getsize $1`
+size2=`blockdev --getsize $2`
+echo "0 $size1 linear $1 0
+$size1 $size2 linear $2 0" | dmsetup create joined
+]]
+
+
+[[
+#!/usr/bin/perl -w
+# Split a device into 4M chunks and then join them together in reverse order.
+
+my $name = "reverse";
+my $extent_size = 4 * 1024 * 2;
+my $dev = $ARGV[0];
+my $table = "";
+my $count = 0;
+
+if (!defined($dev)) {
+        die("Please specify a device.\n");
+}
+
+my $dev_size = `blockdev --getsize $dev`;
+my $extents = int($dev_size / $extent_size) -
+              (($dev_size % $extent_size) ? 1 : 0);
+
+while ($extents > 0) {
+        my $this_start = $count * $extent_size;
+        $extents--;
+        $count++;
+        my $this_offset = $extents * $extent_size;
+
+        $table .= "$this_start $extent_size linear $dev $this_offset\n";
+}
+
+`echo \"$table\" | dmsetup create $name`;
+]]
--- diff/Documentation/device-mapper/striped.txt	1970-01-01 00:00:00.000000000 +0000
+++ source/Documentation/device-mapper/striped.txt	2004-06-09 08:52:22.741803008 +0000
@@ -0,0 +1,58 @@
+dm-stripe
+=========
+
+Device-Mapper's "striped" target is used to create a striped (i.e. RAID-0)
+device across one or more underlying devices. Data is written in "chunks",
+with consecutive chunks rotating among the underlying devices. This can
+potentially provide improved I/O throughput by utilizing several physical
+devices in parallel.
+
+Parameters: <num devs> <chunk size> [<dev path> <offset>]+
+    <num devs>: Number of underlying devices.
+    <chunk size>: Size of each chunk of data. Must be a power-of-2 and at
+                  least as large as the system's PAGE_SIZE.
+    <dev path>: Full pathname to the underlying block-device, or a
+                "major:minor" device-number.
+    <offset>: Starting sector within the device.
+
+One or more underlying devices can be specified. The striped device size must
+be a multiple of the chunk size and a multiple of the number of underlying
+devices.
+
+
+Example scripts
+===============
+
+[[
+#!/usr/bin/perl -w
+# Create a striped device across any number of underlying devices. The device
+# will be called "stripe_dev" and have a chunk-size of 128k.
+
+my $chunk_size = 128 * 2;
+my $dev_name = "stripe_dev";
+my $num_devs = @ARGV;
+my @devs = @ARGV;
+my ($min_dev_size, $stripe_dev_size, $i);
+
+if (!$num_devs) {
+        die("Specify at least one device\n");
+}
+
+$min_dev_size = `blockdev --getsize $devs[0]`;
+for ($i = 1; $i < $num_devs; $i++) {
+        my $this_size = `blockdev --getsize $devs[$i]`;
+        $min_dev_size = ($min_dev_size < $this_size) ?
+                        $min_dev_size : $this_size;
+}
+
+$stripe_dev_size = $min_dev_size * $num_devs;
+$stripe_dev_size -= $stripe_dev_size % ($chunk_size * $num_devs);
+
+$table = "0 $stripe_dev_size striped $num_devs $chunk_size";
+for ($i = 0; $i < $num_devs; $i++) {
+        $table .= " $devs[$i] 0";
+}
+
+`echo $table | dmsetup create $dev_name`;
+]]
+
--- diff/Documentation/device-mapper/zero.txt	1970-01-01 00:00:00.000000000 +0000
+++ source/Documentation/device-mapper/zero.txt	2004-06-09 08:52:22.743802704 +0000
@@ -0,0 +1,37 @@
+dm-zero
+=======
+
+Device-Mapper's "zero" target provides a block-device that always returns
+zero'd data on reads and silently drops writes. This is similar behavior to
+/dev/zero, but as a block-device instead of a character-device.
+
+Dm-zero has no target-specific parameters.
+
+One very interesting use of dm-zero is for creating "sparse" devices in
+conjunction with dm-snapshot. A sparse device reports a device-size larger
+than the amount of actual storage space available for that device. A user can
+write data anywhere within the sparse device and read it back like a normal
+device. Reads to previously unwritten areas will return a zero'd buffer. When
+enough data has been written to fill up the actual storage space, the sparse
+device is deactivated. This can be very useful for testing device and
+filesystem limitations.
+
+To create a sparse device, start by creating a dm-zero device that's the
+desired size of the sparse device. For this example, we'll assume a 10TB
+sparse device.
+
+TEN_TERABYTES=`expr 10 \* 1024 \* 1024 \* 1024 \* 2`   # 10 TB in sectors
+echo "0 $TEN_TERABYTES zero" | dmsetup create zero1
+
+Then create a snapshot of the zero device, using any available block-device as
+the COW device. The size of the COW device will determine the amount of real
+space available to the sparse device. For this example, we'll assume /dev/sdb1
+is an available 10GB partition.
+
+echo "0 $TEN_TERABYTES snapshot /dev/mapper/zero1 /dev/sdb1 p 128" | \
+   dmsetup create sparse1
+
+This will create a 10TB sparse device called /dev/mapper/sparse1 that has
+10GB of actual storage space available. If more than 10GB of data is written
+to this device, it will start returning I/O errors.
+
