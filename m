Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283556AbRK3IYx>; Fri, 30 Nov 2001 03:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283562AbRK3IYo>; Fri, 30 Nov 2001 03:24:44 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16132 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283556AbRK3IYS>;
	Fri, 30 Nov 2001 03:24:18 -0500
Date: Fri, 30 Nov 2001 09:23:47 +0100
From: Jens Axboe <axboe@suse.de>
To: "Martin A. Brooks" <martin@jtrix.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre4 compile error - pd.c
Message-ID: <20011130092347.L16796@suse.de>
In-Reply-To: <3758.10.119.8.1.1007107604.squirrel@extranet.jtrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3758.10.119.8.1.1007107604.squirrel@extranet.jtrix.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30 2001, Martin A. Brooks wrote:
> gcc -D__KERNEL__ -I/home/martin/kernel-a-day-club/linux/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=i686    -c -o pd.o pd.c
> pd.c: In function `do_pd_request':
> pd.c:856: structure has no member named `bh'
> pd.c: In function `pd_next_buf':
> pd.c:881: `io_request_lock' undeclared (first use in this function)
> pd.c:881: (Each undeclared identifier is reported only once
> pd.c:881: for each function it appears in.)
> pd.c: In function `do_pd_read_start':

Please try this diff.

diff -ur /opt/kernel/linux-2.5.1-pre4/drivers/block/paride/pd.c linux/drivers/block/paride/pd.c
--- /opt/kernel/linux-2.5.1-pre4/drivers/block/paride/pd.c	Fri Nov 30 01:59:45 2001
+++ linux/drivers/block/paride/pd.c	Fri Nov 30 03:17:33 2001
@@ -838,8 +838,7 @@
 }
 
 static void do_pd_request (request_queue_t * q)
-
-{       struct buffer_head * bh;
+{
 	int	unit;
 
         if (pd_busy) return;
@@ -853,8 +852,6 @@
         pd_run = CURRENT->nr_sectors;
         pd_count = CURRENT->current_nr_sectors;
 
-	bh = CURRENT->bh;
-
         if ((pd_dev >= PD_DEVS) || 
 	    ((pd_block+pd_count) > pd_hd[pd_dev].nr_sects)) {
                 end_request(0);
@@ -878,9 +875,9 @@
 
 {	long	saved_flags;
 
-	spin_lock_irqsave(&io_request_lock,saved_flags);
+	spin_lock_irqsave(&QUEUE->queue_lock,saved_flags);
 	end_request(1);
-	if (!pd_run) {  spin_unlock_irqrestore(&io_request_lock,saved_flags);
+	if (!pd_run) {  spin_unlock_irqrestore(&QUEUE->queue_lock,saved_flags);
 			return; 
 	}
 	
@@ -896,7 +893,7 @@
 
 	pd_count = CURRENT->current_nr_sectors;
 	pd_buf = CURRENT->buffer;
-	spin_unlock_irqrestore(&io_request_lock,saved_flags);
+	spin_unlock_irqrestore(&QUEUE->queue_lock,saved_flags);
 }
 
 static void do_pd_read( void )
@@ -919,11 +916,11 @@
                         pi_do_claimed(PI,do_pd_read_start);
 			return;
                 }
-		spin_lock_irqsave(&io_request_lock,saved_flags);
+		spin_lock_irqsave(&QUEUE->queue_lock,saved_flags);
                 end_request(0);
                 pd_busy = 0;
 		do_pd_request(NULL);
-		spin_unlock_irqrestore(&io_request_lock,saved_flags);
+		spin_unlock_irqrestore(&QUEUE->queue_lock,saved_flags);
                 return;
         }
         pd_ide_command(unit,IDE_READ,pd_block,pd_run);
@@ -943,11 +940,11 @@
                         pi_do_claimed(PI,do_pd_read_start);
                         return;
                 }
-		spin_lock_irqsave(&io_request_lock,saved_flags);
+		spin_lock_irqsave(&QUEUE->queue_lock,saved_flags);
                 end_request(0);
                 pd_busy = 0;
 		do_pd_request(NULL);
-		spin_unlock_irqrestore(&io_request_lock,saved_flags);
+		spin_unlock_irqrestore(&QUEUE->queue_lock,saved_flags);
                 return;
             }
             pi_read_block(PI,pd_buf,512);
@@ -958,11 +955,11 @@
 	    if (!pd_count) pd_next_buf(unit);
         }
         pi_disconnect(PI);
-	spin_lock_irqsave(&io_request_lock,saved_flags);
+	spin_lock_irqsave(&QUEUE->queue_lock,saved_flags);
         end_request(1);
         pd_busy = 0;
 	do_pd_request(NULL);
-	spin_unlock_irqrestore(&io_request_lock,saved_flags);
+	spin_unlock_irqrestore(&QUEUE->queue_lock,saved_flags);
 }
 
 static void do_pd_write( void )
@@ -985,11 +982,11 @@
 			pi_do_claimed(PI,do_pd_write_start);
                         return;
                 }
-		spin_lock_irqsave(&io_request_lock,saved_flags);
+		spin_lock_irqsave(&QUEUE->queue_lock,saved_flags);
                 end_request(0);
                 pd_busy = 0;
 		do_pd_request(NULL);
-		spin_unlock_irqrestore(&io_request_lock,saved_flags);
+		spin_unlock_irqrestore(&QUEUE->queue_lock,saved_flags);
                 return;
         }
         pd_ide_command(unit,IDE_WRITE,pd_block,pd_run);
@@ -1001,11 +998,11 @@
                         pi_do_claimed(PI,do_pd_write_start);
                         return;
                 }
-		spin_lock_irqsave(&io_request_lock,saved_flags);
+		spin_lock_irqsave(&QUEUE->queue_lock,saved_flags);
                 end_request(0);
                 pd_busy = 0;
 		do_pd_request(NULL);
-                spin_unlock_irqrestore(&io_request_lock,saved_flags);
+                spin_unlock_irqrestore(&QUEUE->queue_lock,saved_flags);
 		return;
             }
             pi_write_block(PI,pd_buf,512);
@@ -1030,19 +1027,19 @@
                         pi_do_claimed(PI,do_pd_write_start);
                         return;
                 }
-		spin_lock_irqsave(&io_request_lock,saved_flags);
+		spin_lock_irqsave(&QUEUE->queue_lock,saved_flags);
                 end_request(0);
                 pd_busy = 0;
 		do_pd_request(NULL);
-		spin_unlock_irqrestore(&io_request_lock,saved_flags);
+		spin_unlock_irqrestore(&QUEUE->queue_lock,saved_flags);
                 return;
         }
         pi_disconnect(PI);
-	spin_lock_irqsave(&io_request_lock,saved_flags);
+	spin_lock_irqsave(&QUEUE->queue_lock,saved_flags);
         end_request(1);
         pd_busy = 0;
 	do_pd_request(NULL);
-	spin_unlock_irqrestore(&io_request_lock,saved_flags);
+	spin_unlock_irqrestore(&QUEUE->queue_lock,saved_flags);
 }
 
 /* end of pd.c */
diff -ur /opt/kernel/linux-2.5.1-pre4/drivers/block/paride/pf.c linux/drivers/block/paride/pf.c
--- /opt/kernel/linux-2.5.1-pre4/drivers/block/paride/pf.c	Fri Nov 30 01:59:45 2001
+++ linux/drivers/block/paride/pf.c	Fri Nov 30 03:20:16 2001
@@ -340,56 +340,6 @@
         }
 } 
 
-static inline int pf_new_segment(request_queue_t *q, struct request *req, int max_segments)
-{
-	if (max_segments > cluster)
-		max_segments = cluster;
-
-	if (req->nr_segments < max_segments) {
-		req->nr_segments++;
-		return 1;
-	}
-	return 0;
-}
-
-static int pf_back_merge_fn(request_queue_t *q, struct request *req, 
-			    struct buffer_head *bh, int max_segments)
-{
-	if (req->bhtail->b_data + req->bhtail->b_size == bh->b_data)
-		return 1;
-	return pf_new_segment(q, req, max_segments);
-}
-
-static int pf_front_merge_fn(request_queue_t *q, struct request *req, 
-			     struct buffer_head *bh, int max_segments)
-{
-	if (bh->b_data + bh->b_size == req->bh->b_data)
-		return 1;
-	return pf_new_segment(q, req, max_segments);
-}
-
-static int pf_merge_requests_fn(request_queue_t *q, struct request *req,
-				struct request *next, int max_segments)
-{
-	int total_segments = req->nr_segments + next->nr_segments;
-	int same_segment;
-
-	if (max_segments > cluster)
-		max_segments = cluster;
-
-	same_segment = 0;
-	if (req->bhtail->b_data + req->bhtail->b_size == next->bh->b_data) {
-		total_segments--;
-		same_segment = 1;
-	}
-    
-	if (total_segments > max_segments)
-		return 0;
-
-	req->nr_segments = total_segments;
-	return 1;
-}
-
 int pf_init (void)      /* preliminary initialisation */
 
 {       int i;
@@ -409,9 +359,7 @@
         }
 	q = BLK_DEFAULT_QUEUE(MAJOR_NR);
 	blk_init_queue(q, DEVICE_REQUEST);
-	q->back_merge_fn = pf_back_merge_fn;
-	q->front_merge_fn = pf_front_merge_fn;
-	q->merge_requests_fn = pf_merge_requests_fn;
+	blk_queue_max_segments(q, cluster);
         read_ahead[MAJOR_NR] = 8;       /* 8 sector (4kB) read ahead */
         
 	for (i=0;i<PF_UNITS;i++) pf_blocksizes[i] = 1024;
@@ -893,8 +841,7 @@
 }
 
 static void do_pf_request (request_queue_t * q)
-
-{       struct buffer_head * bh;
+{
 	int unit;
 
         if (pf_busy) return;
@@ -907,8 +854,6 @@
         pf_run = CURRENT->nr_sectors;
         pf_count = CURRENT->current_nr_sectors;
 
-	bh = CURRENT->bh;
-
         if ((pf_unit >= PF_UNITS) || (pf_block+pf_count > PF.capacity)) {
                 end_request(0);
                 goto repeat;
@@ -931,9 +876,9 @@
 
 {	long	saved_flags;
 
-	spin_lock_irqsave(&io_request_lock,saved_flags);
+	spin_lock_irqsave(&QUEUE->queue_lock,saved_flags);
 	end_request(1);
-	if (!pf_run) { spin_unlock_irqrestore(&io_request_lock,saved_flags);
+	if (!pf_run) { spin_unlock_irqrestore(&QUEUE->queue_lock,saved_flags);
 		       return; 
 	}
 	
@@ -949,7 +894,7 @@
 
 	pf_count = CURRENT->current_nr_sectors;
 	pf_buf = CURRENT->buffer;
-	spin_unlock_irqrestore(&io_request_lock,saved_flags);
+	spin_unlock_irqrestore(&QUEUE->queue_lock,saved_flags);
 }
 
 static void do_pf_read( void )
@@ -973,11 +918,11 @@
                         pi_do_claimed(PI,do_pf_read_start);
 			return;
                 }
-		spin_lock_irqsave(&io_request_lock,saved_flags);
+		spin_lock_irqsave(&QUEUE->queue_lock,saved_flags);
                 end_request(0);
                 pf_busy = 0;
 		do_pf_request(NULL);
-		spin_unlock_irqrestore(&io_request_lock,saved_flags);
+		spin_unlock_irqrestore(&QUEUE->queue_lock,saved_flags);
                 return;
         }
 	pf_mask = STAT_DRQ;
@@ -999,11 +944,11 @@
                         pi_do_claimed(PI,do_pf_read_start);
                         return;
                 }
-		spin_lock_irqsave(&io_request_lock,saved_flags);
+		spin_lock_irqsave(&QUEUE->queue_lock,saved_flags);
                 end_request(0);
                 pf_busy = 0;
 		do_pf_request(NULL);
-		spin_unlock_irqrestore(&io_request_lock,saved_flags);
+		spin_unlock_irqrestore(&QUEUE->queue_lock,saved_flags);
                 return;
             }
             pi_read_block(PI,pf_buf,512);
@@ -1014,11 +959,11 @@
 	    if (!pf_count) pf_next_buf(unit);
         }
         pi_disconnect(PI);
-	spin_lock_irqsave(&io_request_lock,saved_flags); 
+	spin_lock_irqsave(&QUEUE->queue_lock,saved_flags); 
         end_request(1);
         pf_busy = 0;
 	do_pf_request(NULL);
-	spin_unlock_irqrestore(&io_request_lock,saved_flags);
+	spin_unlock_irqrestore(&QUEUE->queue_lock,saved_flags);
 }
 
 static void do_pf_write( void )
@@ -1040,11 +985,11 @@
                         pi_do_claimed(PI,do_pf_write_start);
 			return;
                 }
-		spin_lock_irqsave(&io_request_lock,saved_flags);
+		spin_lock_irqsave(&QUEUE->queue_lock,saved_flags);
                 end_request(0);
                 pf_busy = 0;
 		do_pf_request(NULL);
-		spin_unlock_irqrestore(&io_request_lock,saved_flags);
+		spin_unlock_irqrestore(&QUEUE->queue_lock,saved_flags);
                 return;
         }
 
@@ -1057,11 +1002,11 @@
                         pi_do_claimed(PI,do_pf_write_start);
                         return;
                 }
-		spin_lock_irqsave(&io_request_lock,saved_flags);
+		spin_lock_irqsave(&QUEUE->queue_lock,saved_flags);
                 end_request(0);
                 pf_busy = 0;
 		do_pf_request(NULL);
-		spin_unlock_irqrestore(&io_request_lock,saved_flags);
+		spin_unlock_irqrestore(&QUEUE->queue_lock,saved_flags);
                 return;
             }
             pi_write_block(PI,pf_buf,512);
@@ -1087,19 +1032,19 @@
 			pi_do_claimed(PI,do_pf_write_start);
                         return;
                 }
-		spin_lock_irqsave(&io_request_lock,saved_flags);
+		spin_lock_irqsave(&QUEUE->queue_lock,saved_flags);
                 end_request(0);
                 pf_busy = 0;
 		do_pf_request(NULL);
-		spin_unlock_irqrestore(&io_request_lock,saved_flags);
+		spin_unlock_irqrestore(&QUEUE->queue_lock,saved_flags);
                 return;
         }
         pi_disconnect(PI);
-	spin_lock_irqsave(&io_request_lock,saved_flags);
+	spin_lock_irqsave(&QUEUE->queue_lock,saved_flags);
         end_request(1);
         pf_busy = 0;
 	do_pf_request(NULL);
-	spin_unlock_irqrestore(&io_request_lock,saved_flags);
+	spin_unlock_irqrestore(&QUEUE->queue_lock,saved_flags);
 }
 
 /* end of pf.c */

-- 
Jens Axboe, breaking drivers much faster than fixing them

