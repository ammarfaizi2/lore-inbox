Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267670AbRGRBiS>; Tue, 17 Jul 2001 21:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267708AbRGRBiJ>; Tue, 17 Jul 2001 21:38:09 -0400
Received: from 209-6-16-34.c3-0.frm-ubr1.sbo-frm.ma.cable.rcn.net ([209.6.16.34]:43991
	"EHLO newyork.psind.com") by vger.kernel.org with ESMTP
	id <S267670AbRGRBh7>; Tue, 17 Jul 2001 21:37:59 -0400
Message-ID: <3B54E85E.6E917925@psind.com>
Date: Tue, 17 Jul 2001 21:37:34 -0400
From: "David J. Picard" <dave@psind.com>
Reply-To: dpicard@rcn.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: axboe@suse.de
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: PATCH for Corrupted IO on all block devices
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Basically, what is happening is the read requests are being pushed to
the front of the IO queue - before the preceding write for the same
sector. This is VERY BAD in that applications that perform repeated IO
to the same sector sequentially - like databases - are not guaranteed
the IO will be performed in the order the operations were requested.

The patch follows, then a test utility for the presence of the defect,
and last some background, detail regarding suspected impact of the patch
and next steps.

/* ---- START OVERLAPPING_IO_CORRUPTION PATCH --- */
--- linux/drivers/block/elevator.c	Tue Jul 17 20:56:09 2001
+++ linux-2.4.6-unchanged/drivers/block/elevator.c	Tue Jul 17 20:55:41
2001
@@ -18,6 +18,11 @@
  * Removed tests for max-bomb-segments, which was breaking elvtune
  *  when run without -bN
  *
+ * 17072001 Dave Picard <dave@psind.com> :
+ * Modified the default merge function to stop pushing an IO request
towards
+ *  the front of the queue when it bumps up against an overlapping IO
+ *  request. This was corrupting apps with high IO to the same file,
like
+ *  high traffic databases.
  */
 
 #include <linux/fs.h>
@@ -74,6 +79,39 @@
 	return 0;
 }
 
+/**
+ * bh and rq may be for overlapping regions on the disk. If this is the
case,
+ * it's imperative the order of the io operations be maintained in
order to
+ * guarantee the results be consistent with the order of the requests.
+ */
+inline int bh_rq_in_block(struct buffer_head *bh, unsigned int count,
+			  struct request *rq, struct list_head *head)
+{
+	struct list_head *next;
+	struct request *next_rq;
+
+	/*
+	 * if the io overlaps with this request, consider it overlapping
+	 */
+	if ( ((rq->sector + rq->nr_sectors) > bh->b_rsector) &&
+	     (rq->sector < (bh->b_rsector + count)) )
+	        return 1;
+
+	next = rq->queue.next;
+	if (next == head)
+		return 0;
+
+	/*
+	 * if the io overlaps with the next request, consider it overlapping
+	 */
+	next_rq = blkdev_entry_to_request(next);
+	if ( ((next_rq->sector + next_rq->nr_sectors) > bh->b_rsector) &&
+	     (next_rq->sector < (bh->b_rsector + count)) )
+	        return 1;
+
+	return 0;
+}
+
 
 int elevator_linus_merge(request_queue_t *q, struct request **req,
 			 struct list_head * head,
@@ -98,6 +136,10 @@
 			continue;
 		if (!*req && bh_rq_in_between(bh, __rq, &q->queue_head))
 			*req = __rq;
+		if (bh_rq_in_block(bh, count, __rq, &q->queue_head)) {
+			*req = __rq;
+			break;
+		}
 		if (__rq->cmd != rw)
 			continue;
 		if (__rq->nr_sectors + count > max_sectors)
/* ---- END OVERLAPPING_IO_CORRUPTION PATCH --- */

The following code for a small test application demonstrates the data
corruption with the IO for block devices in the 2.4.6 kernel. Test code
follows, then more detail on next steps:

/* START TEST APPLICATION to validate defect is present or repaired */

#include <stdio.h>
#include <assert.h>

#define TEST_SZ 25000000
#define RD_BUFF_SZ 5000
int main(int argc, const char **argv, const char **env)
{
    FILE* fp;

    if(argc > 1) fp = fopen(argv[1], "r+");
    else fp =tmpfile();
    if(NULL != fp) {
        int j = -1;
	off_t o;
        while(1) {
            if(++j != TEST_SZ) {
	        if (j == (TEST_SZ - RD_BUFF_SZ) ) o = ftello(fp);
                fwrite(&j, sizeof(int), 1, fp);
            } else {
                int i, buffer[RD_BUFF_SZ];
		fflush(fp);
                fseek(fp, o, SEEK_SET);
                fread(buffer, sizeof(int), sizeof(buffer), fp);
                printf("Validating end of file writes\n");
                for(i = (RD_BUFF_SZ - 1); i >= 0; i--) {
                    assert(buffer[i] == --j) ;
                }
                rewind(fp);
		j = -1;
            }
        }
        return 1;
    }
    return 0;
}
/* END TEST APPLICATION */


This defect appeared to come about in an attempt to optimize Linux as a
web / file server by pushing all the read requests to the front of the
pending IO queue. I suspect this patch will have a slightly adverse
impact on that performance, but I believe the impact will be limited to
only those occurences where the IO is overlapping. This will force all
IO operations for the same overlapping sector to occur concurrently. 

There is now an opportunity for further optimization by checking for the
next request before a write operation is actually executed from the
queue and performing the next operation against the pending write buffer
if it is for one or many overlapping segment(s). This of course may
require the extension of the pending write buffer. This will minimize
the thrashing of the disk to update concurrent sections, but I am unsure
of the latencies involved with the execution of the queue.

Another question is whether or not sound devices (or any other devices
not related to storage) are considered to be block devices, in which
case this optimization would likely lose the intervening writes
resulting in some very poor sound quality. 

This optimization should not be performed at the cost of stability.

-- 
David J. Picard
  dave@psind.com
