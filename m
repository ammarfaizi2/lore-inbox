Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVABBCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVABBCa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 20:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVABBC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 20:02:29 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:31201 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261206AbVABA7Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 19:59:16 -0500
Date: Sun, 02 Jan 2005 00:59:12 +0000
From: Willem Riede <osst@riede.org>
Subject: [PATCH 1/3] osst upgrade to 0.99.3
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
X-Mailer: Balsa 2.2.6
Message-Id: <1104627552l.3427l.2l@serve.riede.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In a series of three mails, I'll present changes I'd like to see 
made to the osst driver in the linux-2.6.11 pre-series.

Patch 1 (below) will make style changes that are the equivalent 
of recent changes to st, such as using 'struct osst_tape' where 
we used to have 'OS_Scsi_Tape' as a typedef. Osst behavior is 
not affected by this first patch.

Patch 2 (sent separately) contains important error handling 
improvements that I've made as the result of problem reports.

Patch 3 (again separate) adds sysfs support to osst. This enables
hotplug and udev to manage the osst /dev nodes, which is a real
necessity on installations that use a dynamic /dev, such as
Fedora Core 3.

Thanks, Willem Riede, osst maintainer.

signed-off-by: Willem Riede <osst@riede.org>

--- linux-2.6.10/drivers/scsi/osst.h	2004-12-31 09:47:38.000000000 -0500
+++ osst-patches/osst.h	2005-01-01 19:05:27.000000000 -0500
@@ -1,5 +1,5 @@
 /*
- *	$Header: /cvsroot/osst/Driver/osst.h,v 1.14 2003/12/14 14:34:38 wriede Exp $
+ *	$Header: /cvsroot/osst/Driver/osst.h,v 1.16 2005/01/01 21:13:35 wriede Exp $
  */
 
 #include <asm/byteorder.h>
@@ -508,7 +508,7 @@
 //#define OSST_MAX_SG      2
 
 /* The OnStream tape buffer descriptor. */
-typedef struct {
+struct osst_buffer {
   unsigned char in_use;
   unsigned char dma;	/* DMA-able buffer */
   int buffer_size;
@@ -525,16 +525,16 @@
   unsigned short sg_segs;      /* number of segments in s/g list                  */
   unsigned short orig_sg_segs; /* number of segments allocated at first try       */
   struct scatterlist sg[1];    /* MUST BE last item                               */
-} OSST_buffer;
+} ;
 
 /* The OnStream tape drive descriptor */
-typedef struct {
+struct osst_tape {
   struct scsi_driver *driver;
   unsigned capacity;
   Scsi_Device* device;
   struct semaphore lock;       /* for serialization */
   struct completion wait;      /* for SCSI commands */
-  OSST_buffer * buffer;
+  struct osst_buffer * buffer;
 
   /* Drive characteristics */
   unsigned char omit_blklims;
@@ -623,7 +623,7 @@
   unsigned char last_sense[16];
 #endif
   struct gendisk *drive;
-} OS_Scsi_Tape;
+} ;
 
 /* Values of write_type */
 #define OS_WRITE_DATA      0
--- linux-2.6.10/drivers/scsi/osst.c	2004-12-31 09:47:38.000000000 -0500
+++ osst-patches/osst.c	2005-01-01 19:11:25.000000000 -0500
@@ -46,6 +46,7 @@
 #include <linux/spinlock.h>
 #include <linux/vmalloc.h>
 #include <linux/blkdev.h>
+#include <linux/moduleparam.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/delay.h>
 #include <asm/uaccess.h>
@@ -82,13 +83,13 @@
 MODULE_DESCRIPTION("OnStream {DI-|FW-|SC-|USB}{30|50} Tape Driver");
 MODULE_LICENSE("GPL");
 
-module_param(max_dev, int, 0);
+module_param(max_dev, int, 0444);
 MODULE_PARM_DESC(max_dev, "Maximum number of OnStream Tape Drives to attach (4)");
 
-module_param(write_threshold_kbs, int, 0);
+module_param(write_threshold_kbs, int, 0644);
 MODULE_PARM_DESC(write_threshold_kbs, "Asynchronous write threshold (KB; 32)");
 
-module_param(max_sg_segs, int, 0);
+module_param(max_sg_segs, int, 0644);
 MODULE_PARM_DESC(max_sg_segs, "Maximum number of scatter/gather segments to use (9)");
 #else
 static struct osst_dev_parm {
@@ -147,19 +148,19 @@
 static int osst_max_dev           = OSST_MAX_TAPES;
 static int osst_nr_dev;
 
-static OS_Scsi_Tape **os_scsi_tapes = NULL;
-static rwlock_t  os_scsi_tapes_lock = RW_LOCK_UNLOCKED;
+static struct osst_tape **os_scsi_tapes = NULL;
+static rwlock_t os_scsi_tapes_lock = RW_LOCK_UNLOCKED;
 
 static int modes_defined = FALSE;
 
-static OSST_buffer *new_tape_buffer(int, int, int);
-static int enlarge_buffer(OSST_buffer *, int);
-static void normalize_buffer(OSST_buffer *);
-static int append_to_buffer(const char __user *, OSST_buffer *, int);
-static int from_buffer(OSST_buffer *, char __user *, int);
-static int osst_zero_buffer_tail(OSST_buffer *);
-static int osst_copy_to_buffer(OSST_buffer *, unsigned char *);
-static int osst_copy_from_buffer(OSST_buffer *, unsigned char *);
+static struct osst_buffer *new_tape_buffer(int, int, int);
+static int enlarge_buffer(struct osst_buffer *, int);
+static void normalize_buffer(struct osst_buffer *);
+static int append_to_buffer(const char __user *, struct osst_buffer *, int);
+static int from_buffer(struct osst_buffer *, char __user *, int);
+static int osst_zero_buffer_tail(struct osst_buffer *);
+static int osst_copy_to_buffer(struct osst_buffer *, unsigned char *);
+static int osst_copy_from_buffer(struct osst_buffer *, unsigned char *);
 
 static int osst_probe(struct device *);
 static int osst_remove(struct device *);
@@ -173,17 +174,18 @@
 	}
 };
 
-static int osst_int_ioctl(OS_Scsi_Tape *STp, Scsi_Request ** aSRpnt, unsigned int cmd_in,unsigned long arg);
+static int osst_int_ioctl(struct osst_tape *STp, struct scsi_request ** aSRpnt,
+			    unsigned int cmd_in, unsigned long arg);
 
-static int osst_set_frame_position(OS_Scsi_Tape *STp, Scsi_Request ** aSRpnt, int frame, int skip);
+static int osst_set_frame_position(struct osst_tape *STp, struct scsi_request ** aSRpnt, int frame, int skip);
 
-static int osst_get_frame_position(OS_Scsi_Tape *STp, Scsi_Request ** aSRpnt);
+static int osst_get_frame_position(struct osst_tape *STp, struct scsi_request ** aSRpnt);
 
-static int osst_flush_write_buffer(OS_Scsi_Tape *STp, Scsi_Request ** aSRpnt);
+static int osst_flush_write_buffer(struct osst_tape *STp, struct scsi_request ** aSRpnt);
 
-static int osst_write_error_recovery(OS_Scsi_Tape * STp, Scsi_Request ** aSRpnt, int pending);
+static int osst_write_error_recovery(struct osst_tape * STp, struct scsi_request ** aSRpnt, int pending);
 
-static inline char *tape_name(OS_Scsi_Tape *tape)
+static inline char *tape_name(struct osst_tape *tape)
 {
 	return tape->drive->disk_name;
 }
@@ -191,7 +193,7 @@
 /* Routines that handle the interaction with mid-layer SCSI routines */
 
 /* Convert the result to success code */
-static int osst_chk_result(OS_Scsi_Tape * STp, Scsi_Request * SRpnt)
+static int osst_chk_result(struct osst_tape * STp, struct scsi_request * SRpnt)
 {
 	char *name = tape_name(STp);
 	int result = SRpnt->sr_result;
@@ -281,7 +283,7 @@
 /* Wakeup from interrupt */
 static void osst_sleep_done (Scsi_Cmnd * SCpnt)
 {
-	OS_Scsi_Tape * STp = container_of(SCpnt->request->rq_disk->private_data, OS_Scsi_Tape, driver);
+	struct osst_tape * STp = container_of(SCpnt->request->rq_disk->private_data, struct osst_tape, driver);
 
 	if ((STp->buffer)->writing &&
 	    (SCpnt->sense_buffer[0] & 0x70) == 0x70 &&
@@ -307,7 +309,7 @@
 /* Do the scsi command. Waits until command performed if do_wait is true.
    Otherwise osst_write_behind_check() is used to check that the command
    has finished. */
-static	Scsi_Request * osst_do_scsi(Scsi_Request *SRpnt, OS_Scsi_Tape *STp, 
+static	struct scsi_request * osst_do_scsi(struct scsi_request *SRpnt, struct osst_tape *STp, 
 	unsigned char *cmd, int bytes, int direction, int timeout, int retries, int do_wait)
 {
 	unsigned char *bp;
@@ -366,9 +368,9 @@
 
 
 /* Handle the write-behind checking (downs the semaphore) */
-static void osst_write_behind_check(OS_Scsi_Tape *STp)
+static void osst_write_behind_check(struct osst_tape *STp)
 {
-	OSST_buffer * STbuffer;
+	struct osst_buffer * STbuffer;
 
 	STbuffer = STp->buffer;
 
@@ -406,7 +408,7 @@
 /*
  * Initialize the OnStream AUX
  */
-static void osst_init_aux(OS_Scsi_Tape * STp, int frame_type, int frame_seq_number,
+static void osst_init_aux(struct osst_tape * STp, int frame_type, int frame_seq_number,
 					 int logical_blk_num, int blk_sz, int blk_cnt)
 {
 	os_aux_t       *aux = STp->buffer->aux;
@@ -468,13 +470,13 @@
 /*
  * Verify that we have the correct tape frame
  */
-static int osst_verify_frame(OS_Scsi_Tape * STp, int frame_seq_number, int quiet)
+static int osst_verify_frame(struct osst_tape * STp, int frame_seq_number, int quiet)
 {
-	char           * name = tape_name(STp);
-	os_aux_t       * aux  = STp->buffer->aux;
-	os_partition_t * par  = &(aux->partition);
-	struct st_partstat    * STps = &(STp->ps[STp->partition]);
-	int		 blk_cnt, blk_sz, i;
+	char               * name = tape_name(STp);
+	os_aux_t           * aux  = STp->buffer->aux;
+	os_partition_t     * par  = &(aux->partition);
+	struct st_partstat * STps = &(STp->ps[STp->partition]);
+	int		     blk_cnt, blk_sz, i;
 
 	if (STp->raw) {
 		if (STp->buffer->syscall_result) {
@@ -602,14 +604,15 @@
 /*
  * Wait for the unit to become Ready
  */
-static int osst_wait_ready(OS_Scsi_Tape * STp, Scsi_Request ** aSRpnt, unsigned timeout, int initial_delay)
+static int osst_wait_ready(struct osst_tape * STp, struct scsi_request ** aSRpnt,
+				 unsigned timeout, int initial_delay)
 {
-	unsigned char	cmd[MAX_COMMAND_SIZE];
-	Scsi_Request  * SRpnt;
-	unsigned long	startwait = jiffies;
+	unsigned char		cmd[MAX_COMMAND_SIZE];
+	struct scsi_request   * SRpnt;
+	unsigned long		startwait = jiffies;
 #if DEBUG
-	int		dbg  = debugging;
-	char          * name = tape_name(STp);
+	int			dbg  = debugging;
+	char    	      * name = tape_name(STp);
 
 	printk(OSST_DEB_MSG "%s:D: Reached onstream wait ready\n", name);
 #endif
@@ -666,14 +669,14 @@
 /*
  * Wait for a tape to be inserted in the unit
  */
-static int osst_wait_for_medium(OS_Scsi_Tape * STp, Scsi_Request ** aSRpnt, unsigned timeout)
+static int osst_wait_for_medium(struct osst_tape * STp, struct scsi_request ** aSRpnt, unsigned timeout)
 {
-	unsigned char	cmd[MAX_COMMAND_SIZE];
-	Scsi_Request  * SRpnt;
-	unsigned long	startwait = jiffies;
+	unsigned char		cmd[MAX_COMMAND_SIZE];
+	struct scsi_request   * SRpnt;
+	unsigned long		startwait = jiffies;
 #if DEBUG
-	int		dbg = debugging;
-	char          * name = tape_name(STp);
+	int			dbg = debugging;
+	char    	      * name = tape_name(STp);
 
 	printk(OSST_DEB_MSG "%s:D: Reached onstream wait for medium\n", name);
 #endif
@@ -722,7 +725,7 @@
 	return 1;
 }
 
-static int osst_position_tape_and_confirm(OS_Scsi_Tape * STp, Scsi_Request ** aSRpnt, int frame)
+static int osst_position_tape_and_confirm(struct osst_tape * STp, struct scsi_request ** aSRpnt, int frame)
 {
 	int	retval;
 
@@ -736,15 +739,14 @@
 /*
  * Wait for write(s) to complete
  */
-static int osst_flush_drive_buffer(OS_Scsi_Tape * STp, Scsi_Request ** aSRpnt)
+static int osst_flush_drive_buffer(struct osst_tape * STp, struct scsi_request ** aSRpnt)
 {
-	unsigned char	cmd[MAX_COMMAND_SIZE];
-	Scsi_Request  * SRpnt;
-
-	int             result = 0;
-	int		delay  = OSST_WAIT_WRITE_COMPLETE;
+	unsigned char		cmd[MAX_COMMAND_SIZE];
+	struct scsi_request   * SRpnt;
+	int			result = 0;
+	int			delay  = OSST_WAIT_WRITE_COMPLETE;
 #if DEBUG
-	char          * name = tape_name(STp);
+	char		      * name = tape_name(STp);
 
 	printk(OSST_DEB_MSG "%s:D: Reached onstream flush drive buffer (write filemark)\n", name);
 #endif
@@ -771,12 +773,12 @@
 }
 
 #define OSST_POLL_PER_SEC 10
-static int osst_wait_frame(OS_Scsi_Tape * STp, Scsi_Request ** aSRpnt, int curr, int minlast, int to)
+static int osst_wait_frame(struct osst_tape * STp, struct scsi_request ** aSRpnt, int curr, int minlast, int to)
 {
-	unsigned long	startwait     = jiffies;
-	char	      * name          = tape_name(STp);
+	unsigned long	startwait = jiffies;
+	char	      * name      = tape_name(STp);
 #if DEBUG
-	char	notyetprinted = 1;
+	char	   notyetprinted  = 1;
 #endif
 	if (minlast >= 0 && STp->ps[STp->partition].rw != ST_READING)
 		printk(KERN_ERR "%s:A: Waiting for frame without having initialized read!\n", name);
@@ -784,7 +786,7 @@
 	while (time_before (jiffies, startwait + to*HZ))
 	{ 
 		int result;
-		result = osst_get_frame_position (STp, aSRpnt);
+		result = osst_get_frame_position(STp, aSRpnt);
 		if (result == -EIO)
 			if ((result = osst_write_error_recovery(STp, aSRpnt, 0)) == 0)
 				return 0;	/* successful recovery leaves drive ready for frame */
@@ -829,14 +831,14 @@
 /*
  * Read the next OnStream tape frame at the current location
  */
-static int osst_read_frame(OS_Scsi_Tape * STp, Scsi_Request ** aSRpnt, int timeout)
+static int osst_read_frame(struct osst_tape * STp, struct scsi_request ** aSRpnt, int timeout)
 {
-	unsigned char	cmd[MAX_COMMAND_SIZE];
-	Scsi_Request  * SRpnt;
-	int		retval = 0;
+	unsigned char		cmd[MAX_COMMAND_SIZE];
+	struct scsi_request   * SRpnt;
+	int			retval = 0;
 #if DEBUG
-	os_aux_t      * aux    = STp->buffer->aux;
-	char          * name = tape_name(STp);
+	os_aux_t	      * aux    = STp->buffer->aux;
+	char		      * name   = tape_name(STp);
 #endif
 
 	/* TODO: Error handling */
@@ -900,15 +902,13 @@
 	return (retval);
 }
 
-static int osst_initiate_read(OS_Scsi_Tape * STp, Scsi_Request ** aSRpnt)
+static int osst_initiate_read(struct osst_tape * STp, struct scsi_request ** aSRpnt)
 {
-	struct st_partstat   * STps   = &(STp->ps[STp->partition]);
-	Scsi_Request  * SRpnt  ;
-	unsigned char	cmd[MAX_COMMAND_SIZE];
-	int		retval = 0;
-#if DEBUG
-	char          * name = tape_name(STp);
-#endif
+	struct st_partstat    * STps   = &(STp->ps[STp->partition]);
+	struct scsi_request   * SRpnt  ;
+	unsigned char		cmd[MAX_COMMAND_SIZE];
+	int			retval = 0;
+	char		      * name   = tape_name(STp);
 
 	if (STps->rw != ST_READING) {         /* Initialize read operation */
 		if (STps->rw == ST_WRITING || STp->dirty) {
@@ -938,15 +938,16 @@
 	return retval;
 }
 
-static int osst_get_logical_frame(OS_Scsi_Tape * STp, Scsi_Request ** aSRpnt, int frame_seq_number, int quiet)
+static int osst_get_logical_frame(struct osst_tape * STp, struct scsi_request ** aSRpnt,
+						int frame_seq_number, int quiet)
 {
 	struct st_partstat * STps  = &(STp->ps[STp->partition]);
-	char        * name  = tape_name(STp);
-	int           cnt   = 0,
-		      bad   = 0,
-		      past  = 0,
-		      x,
-		      position;
+	char		   * name  = tape_name(STp);
+	int		     cnt   = 0,
+			     bad   = 0,
+			     past  = 0,
+			     x,
+			     position;
 
 	/*
 	 * If we want just any frame (-1) and there is a frame in the buffer, return it
@@ -1064,10 +1065,10 @@
 	return (STps->eof);
 }
 
-static int osst_seek_logical_blk(OS_Scsi_Tape * STp, Scsi_Request ** aSRpnt, int logical_blk_num)
+static int osst_seek_logical_blk(struct osst_tape * STp, struct scsi_request ** aSRpnt, int logical_blk_num)
 {
         struct st_partstat * STps = &(STp->ps[STp->partition]);
-	char        * name = tape_name(STp);
+	char		   * name = tape_name(STp);
 	int	retries    = 0;
 	int	frame_seq_estimate, ppos_estimate, move;
 	
@@ -1173,7 +1174,7 @@
 #define OSST_SECTOR_SHIFT 9
 #define OSST_SECTOR_MASK  0x03F
 
-static int osst_get_sector(OS_Scsi_Tape * STp, Scsi_Request ** aSRpnt)
+static int osst_get_sector(struct osst_tape * STp, struct scsi_request ** aSRpnt)
 {
 	int	sector;
 #if DEBUG
@@ -1203,12 +1204,12 @@
 	return sector;
 }
 
-static int osst_seek_sector(OS_Scsi_Tape * STp, Scsi_Request ** aSRpnt, int sector)
+static int osst_seek_sector(struct osst_tape * STp, struct scsi_request ** aSRpnt, int sector)
 {
-        struct st_partstat   * STps   = &(STp->ps[STp->partition]);
-	int		frame  = sector >> OSST_FRAME_SHIFT,
-			offset = (sector & OSST_SECTOR_MASK) << OSST_SECTOR_SHIFT, 
-			r;
+        struct st_partstat * STps   = &(STp->ps[STp->partition]);
+	int		     frame  = sector >> OSST_FRAME_SHIFT,
+			     offset = (sector & OSST_SECTOR_MASK) << OSST_SECTOR_SHIFT, 
+			     r;
 #if DEBUG
 	char          * name = tape_name(STp);
 
@@ -1266,23 +1267,23 @@
  * Precondition for this function to work: all frames in the
  * drive's buffer must be of one type (DATA, MARK or EOD)!
  */
-static int osst_read_back_buffer_and_rewrite(OS_Scsi_Tape * STp, Scsi_Request ** aSRpnt,
-					unsigned int frame, unsigned int skip, int pending)
+static int osst_read_back_buffer_and_rewrite(struct osst_tape * STp, struct scsi_request ** aSRpnt,
+						unsigned int frame, unsigned int skip, int pending)
 {
-	Scsi_Request  * SRpnt = * aSRpnt;
-	unsigned char * buffer, * p;
-	unsigned char	cmd[MAX_COMMAND_SIZE];
-	int		flag, new_frame, i;
-	int		nframes          = STp->cur_frames;
-	int		blks_per_frame   = ntohs(STp->buffer->aux->dat.dat_list[0].blk_cnt);
-	int		frame_seq_number = ntohl(STp->buffer->aux->frame_seq_num)
+	struct scsi_request   * SRpnt = * aSRpnt;
+	unsigned char	      * buffer, * p;
+	unsigned char		cmd[MAX_COMMAND_SIZE];
+	int			flag, new_frame, i;
+	int			nframes          = STp->cur_frames;
+	int			blks_per_frame   = ntohs(STp->buffer->aux->dat.dat_list[0].blk_cnt);
+	int			frame_seq_number = ntohl(STp->buffer->aux->frame_seq_num)
 						- (nframes + pending - 1);
-	int		logical_blk_num  = ntohl(STp->buffer->aux->logical_blk_num) 
+	int			logical_blk_num  = ntohl(STp->buffer->aux->logical_blk_num) 
 						- (nframes + pending - 1) * blks_per_frame;
-	char	      * name             = tape_name(STp);
-	unsigned long	startwait        = jiffies;
+	char		      * name             = tape_name(STp);
+	unsigned long		startwait        = jiffies;
 #if DEBUG
-	int		dbg              = debugging;
+	int			dbg              = debugging;
 #endif
 
 	if ((buffer = (unsigned char *)vmalloc((nframes + 1) * OS_DATA_SIZE)) == NULL)
@@ -1459,18 +1460,18 @@
 	return 0;
 }
 
-static int osst_reposition_and_retry(OS_Scsi_Tape * STp, Scsi_Request ** aSRpnt,
+static int osst_reposition_and_retry(struct osst_tape * STp, struct scsi_request ** aSRpnt,
 					unsigned int frame, unsigned int skip, int pending)
 {
-	unsigned char	cmd[MAX_COMMAND_SIZE];
-	Scsi_Request  * SRpnt;
-	char	      * name      = tape_name(STp);
-	int		expected  = 0;
-	int		attempts  = 1000 / skip;
-	int		flag      = 1;
-	unsigned long	startwait = jiffies;
+	unsigned char		cmd[MAX_COMMAND_SIZE];
+	struct scsi_request   * SRpnt;
+	char		      * name      = tape_name(STp);
+	int			expected  = 0;
+	int			attempts  = 1000 / skip;
+	int			flag      = 1;
+	unsigned long		startwait = jiffies;
 #if DEBUG
-	int		dbg       = debugging;
+	int			dbg       = debugging;
 #endif
 
 	while (attempts && time_before(jiffies, startwait + 60*HZ)) {
@@ -1563,14 +1564,14 @@
  * Error recovery algorithm for the OnStream tape.
  */
 
-static int osst_write_error_recovery(OS_Scsi_Tape * STp, Scsi_Request ** aSRpnt, int pending)
+static int osst_write_error_recovery(struct osst_tape * STp, struct scsi_request ** aSRpnt, int pending)
 {
-	Scsi_Request * SRpnt  = * aSRpnt;
+	struct scsi_request * SRpnt  = * aSRpnt;
 	struct st_partstat  * STps   = & STp->ps[STp->partition];
-	char         * name   = tape_name(STp);
-	int            retval = 0;
-	int            rw_state;
-	unsigned int  frame, skip;
+	char		    * name   = tape_name(STp);
+	int		      retval = 0;
+	int		      rw_state;
+	unsigned int	      frame, skip;
 
 	rw_state = STps->rw;
 
@@ -1640,7 +1641,7 @@
 	return retval;
 }
 
-static int osst_space_over_filemarks_backward(OS_Scsi_Tape * STp, Scsi_Request ** aSRpnt,
+static int osst_space_over_filemarks_backward(struct osst_tape * STp, struct scsi_request ** aSRpnt,
 								 int mt_op, int mt_count)
 {
 	char  * name = tape_name(STp);
@@ -1739,7 +1740,7 @@
  *
  * Just scans for the filemark sequentially.
  */
-static int osst_space_over_filemarks_forward_slow(OS_Scsi_Tape * STp, Scsi_Request ** aSRpnt,
+static int osst_space_over_filemarks_forward_slow(struct osst_tape * STp, struct scsi_request ** aSRpnt,
 								     int mt_op, int mt_count)
 {
 	int	cnt = 0;
@@ -1793,7 +1794,7 @@
 /*
  * Fast linux specific version of OnStream FSF
  */
-static int osst_space_over_filemarks_forward_fast(OS_Scsi_Tape * STp, Scsi_Request ** aSRpnt,
+static int osst_space_over_filemarks_forward_fast(struct osst_tape * STp, struct scsi_request ** aSRpnt,
 								     int mt_op, int mt_count)
 {
 	char  * name = tape_name(STp);
@@ -1944,11 +1945,11 @@
  * to test the error recovery mechanism.
  */
 #if DEBUG
-static void osst_set_retries(OS_Scsi_Tape * STp, Scsi_Request ** aSRpnt, int retries)
+static void osst_set_retries(struct osst_tape * STp, struct scsi_request ** aSRpnt, int retries)
 {
-	unsigned char	cmd[MAX_COMMAND_SIZE];
-	Scsi_Request  * SRpnt  = * aSRpnt;
-	char          * name   = tape_name(STp);
+	unsigned char		cmd[MAX_COMMAND_SIZE];
+	struct scsi_request   * SRpnt  = * aSRpnt;
+	char		      * name   = tape_name(STp);
 
 	memset(cmd, 0, MAX_COMMAND_SIZE);
 	cmd[0] = MODE_SELECT;
@@ -1976,7 +1977,7 @@
 #endif
 
 
-static int osst_write_filemark(OS_Scsi_Tape * STp, Scsi_Request ** aSRpnt)
+static int osst_write_filemark(struct osst_tape * STp, struct scsi_request ** aSRpnt)
 {
 	int	result;
 	int	this_mark_ppos = STp->first_frame_position;
@@ -2004,7 +2005,7 @@
 	return result;
 }
 
-static int osst_write_eod(OS_Scsi_Tape * STp, Scsi_Request ** aSRpnt)
+static int osst_write_eod(struct osst_tape * STp, struct scsi_request ** aSRpnt)
 {
 	int	result;
 #if DEBUG
@@ -2027,7 +2028,7 @@
 	return result;
 }
 
-static int osst_write_filler(OS_Scsi_Tape * STp, Scsi_Request ** aSRpnt, int where, int count)
+static int osst_write_filler(struct osst_tape * STp, struct scsi_request ** aSRpnt, int where, int count)
 {
 	char * name = tape_name(STp);
 
@@ -2052,7 +2053,7 @@
 	return osst_flush_drive_buffer(STp, aSRpnt);
 }
 
-static int __osst_write_header(OS_Scsi_Tape * STp, Scsi_Request ** aSRpnt, int where, int count)
+static int __osst_write_header(struct osst_tape * STp, struct scsi_request ** aSRpnt, int where, int count)
 {
 	char * name = tape_name(STp);
 	int     result;
@@ -2079,7 +2080,7 @@
 	return result;
 }
 
-static int osst_write_header(OS_Scsi_Tape * STp, Scsi_Request ** aSRpnt, int locate_eod)
+static int osst_write_header(struct osst_tape * STp, struct scsi_request ** aSRpnt, int locate_eod)
 {
 	os_header_t * header;
 	int	      result;
@@ -2153,7 +2154,7 @@
 	return result;
 }
 
-static int osst_reset_header(OS_Scsi_Tape * STp, Scsi_Request ** aSRpnt)
+static int osst_reset_header(struct osst_tape * STp, struct scsi_request ** aSRpnt)
 {
 	if (STp->header_cache != NULL)
 		memset(STp->header_cache, 0, sizeof(os_header_t));
@@ -2166,7 +2167,7 @@
 	return osst_write_header(STp, aSRpnt, 1);
 }
 
-static int __osst_analyze_headers(OS_Scsi_Tape * STp, Scsi_Request ** aSRpnt, int ppos)
+static int __osst_analyze_headers(struct osst_tape * STp, struct scsi_request ** aSRpnt, int ppos)
 {
 	char        * name = tape_name(STp);
 	os_header_t * header;
@@ -2343,7 +2344,7 @@
 	return 1;
 }
 
-static int osst_analyze_headers(OS_Scsi_Tape * STp, Scsi_Request ** aSRpnt)
+static int osst_analyze_headers(struct osst_tape * STp, struct scsi_request ** aSRpnt)
 {
 	int	position, ppos;
 	int	first, last;
@@ -2398,7 +2399,7 @@
 	return 1;
 }
 
-static int osst_verify_position(OS_Scsi_Tape * STp, Scsi_Request ** aSRpnt)
+static int osst_verify_position(struct osst_tape * STp, struct scsi_request ** aSRpnt)
 {
 	int	frame_position  = STp->first_frame_position;
 	int	frame_seq_numbr = STp->frame_seq_number;
@@ -2474,11 +2475,11 @@
 /*
  * Configure the OnStream SCII tape drive for default operation
  */
-static int osst_configure_onstream(OS_Scsi_Tape *STp, Scsi_Request ** aSRpnt)
+static int osst_configure_onstream(struct osst_tape *STp, struct scsi_request ** aSRpnt)
 {
 	unsigned char                  cmd[MAX_COMMAND_SIZE];
 	char                         * name = tape_name(STp);
-	Scsi_Request                 * SRpnt = * aSRpnt;
+	struct scsi_request                 * SRpnt = * aSRpnt;
 	osst_mode_parameter_header_t * header;
 	osst_block_size_page_t       * bs;
 	osst_capabilities_page_t     * cp;
@@ -2645,7 +2646,7 @@
 
 /* Step over EOF if it has been inadvertently crossed (ioctl not used because
    it messes up the block number). */
-static int cross_eof(OS_Scsi_Tape *STp, Scsi_Request ** aSRpnt, int forward)
+static int cross_eof(struct osst_tape *STp, struct scsi_request ** aSRpnt, int forward)
 {
 	int	result;
 	char  * name = tape_name(STp);
@@ -2674,18 +2675,18 @@
 
 /* Get the tape position. */
 
-static int osst_get_frame_position(OS_Scsi_Tape *STp, Scsi_Request ** aSRpnt)
+static int osst_get_frame_position(struct osst_tape *STp, struct scsi_request ** aSRpnt)
 {
-	unsigned char	scmd[MAX_COMMAND_SIZE];
-	Scsi_Request  * SRpnt;
-	int		result = 0;
+	unsigned char		scmd[MAX_COMMAND_SIZE];
+	struct scsi_request   * SRpnt;
+	int			result = 0;
+	char    	      * name   = tape_name(STp);
 
 	/* KG: We want to be able to use it for checking Write Buffer availability
 	 *  and thus don't want to risk to overwrite anything. Exchange buffers ... */
 	char		mybuf[24];
 	char	      * olddata = STp->buffer->b_data;
 	int		oldsize = STp->buffer->buffer_size;
-	char          * name    = tape_name(STp);
 
 	if (STp->ready != ST_READY) return (-EIO);
 
@@ -2752,14 +2753,14 @@
 
 
 /* Set the tape block */
-static int osst_set_frame_position(OS_Scsi_Tape *STp, Scsi_Request ** aSRpnt, int ppos, int skip)
+static int osst_set_frame_position(struct osst_tape *STp, struct scsi_request ** aSRpnt, int ppos, int skip)
 {
-	unsigned char	scmd[MAX_COMMAND_SIZE];
-	Scsi_Request  * SRpnt;
-	struct st_partstat   * STps;
-	int		result = 0;
-	int		pp     = (ppos == 3000 && !skip)? 0 : ppos;
-	char          * name   = tape_name(STp);
+	unsigned char		scmd[MAX_COMMAND_SIZE];
+	struct scsi_request   * SRpnt;
+	struct st_partstat    * STps;
+	int			result = 0;
+	int			pp     = (ppos == 3000 && !skip)? 0 : ppos;
+	char		      * name   = tape_name(STp);
 
 	if (STp->ready != ST_READY) return (-EIO);
 
@@ -2810,7 +2811,7 @@
 	return result;
 }
 
-static int osst_write_trailer(OS_Scsi_Tape *STp, Scsi_Request ** aSRpnt, int leave_at_EOT)
+static int osst_write_trailer(struct osst_tape *STp, struct scsi_request ** aSRpnt, int leave_at_EOT)
 {
 	struct st_partstat * STps = &(STp->ps[STp->partition]);
 	int result = 0;
@@ -2837,26 +2838,26 @@
 /* osst versions of st functions - augmented and stripped to suit OnStream only */
 
 /* Flush the write buffer (never need to write if variable blocksize). */
-static int osst_flush_write_buffer(OS_Scsi_Tape *STp, Scsi_Request ** aSRpnt)
+static int osst_flush_write_buffer(struct osst_tape *STp, struct scsi_request ** aSRpnt)
 {
-	int            offset, transfer, blks = 0;
-	int            result = 0;
-	unsigned char  cmd[MAX_COMMAND_SIZE];
-	Scsi_Request * SRpnt = *aSRpnt;
-	struct st_partstat  * STps;
-	char         * name = tape_name(STp);
+	int			offset, transfer, blks = 0;
+	int			result = 0;
+	unsigned char		cmd[MAX_COMMAND_SIZE];
+	struct scsi_request   * SRpnt = *aSRpnt;
+	struct st_partstat    * STps;
+	char		      * name = tape_name(STp);
 
 	if ((STp->buffer)->writing) {
 		if (SRpnt == (STp->buffer)->last_SRpnt)
 #if DEBUG
 			{ printk(OSST_DEB_MSG
-	 "%s:D: aSRpnt points to Scsi_Request that write_behind_check will release -- cleared\n", name);
+	 "%s:D: aSRpnt points to scsi_request that write_behind_check will release -- cleared\n", name);
 #endif
 			*aSRpnt = SRpnt = NULL;
 #if DEBUG
 			} else if (SRpnt)
 				printk(OSST_DEB_MSG
-	 "%s:D: aSRpnt does not point to Scsi_Request that write_behind_check will release -- strange\n", name);
+	 "%s:D: aSRpnt does not point to scsi_request that write_behind_check will release -- strange\n", name);
 #endif	
 		osst_write_behind_check(STp);
 		if ((STp->buffer)->syscall_result) {
@@ -2967,12 +2968,12 @@
 
 /* Flush the tape buffer. The tape will be positioned correctly unless
    seek_next is true. */
-static int osst_flush_buffer(OS_Scsi_Tape * STp, Scsi_Request ** aSRpnt, int seek_next)
+static int osst_flush_buffer(struct osst_tape * STp, struct scsi_request ** aSRpnt, int seek_next)
 {
 	struct st_partstat * STps;
-	int           backspace = 0, result = 0;
+	int    backspace = 0, result = 0;
 #if DEBUG
-	char        * name = tape_name(STp);
+	char * name = tape_name(STp);
 #endif
 
 	/*
@@ -3029,13 +3030,13 @@
 	return result;
 }
 
-static int osst_write_frame(OS_Scsi_Tape * STp, Scsi_Request ** aSRpnt, int synchronous)
+static int osst_write_frame(struct osst_tape * STp, struct scsi_request ** aSRpnt, int synchronous)
 {
-	unsigned char	cmd[MAX_COMMAND_SIZE];
-	Scsi_Request  * SRpnt;
-	int		blks;
+	unsigned char		cmd[MAX_COMMAND_SIZE];
+	struct scsi_request   * SRpnt;
+	int			blks;
 #if DEBUG
-	char          * name = tape_name(STp);
+	char		      * name = tape_name(STp);
 #endif
 
 	if ((!STp-> raw) && (STp->first_frame_position == 0xbae)) { /* _must_ preserve buffer! */
@@ -3111,8 +3112,8 @@
 	return 0;
 }
 
-/* Lock or unlock the drive door. Don't use when Scsi_Request allocated. */
-static int do_door_lock(OS_Scsi_Tape * STp, int do_lock)
+/* Lock or unlock the drive door. Don't use when struct scsi_request allocated. */
+static int do_door_lock(struct osst_tape * STp, int do_lock)
 {
 	int retval, cmd;
 
@@ -3131,7 +3132,7 @@
 }
 
 /* Set the internal state after reset */
-static void reset_state(OS_Scsi_Tape *STp)
+static void reset_state(struct osst_tape *STp)
 {
 	int i;
 	struct st_partstat *STps;
@@ -3154,16 +3155,16 @@
 /* Write command */
 static ssize_t osst_write(struct file * filp, const char __user * buf, size_t count, loff_t *ppos)
 {
-	ssize_t        total, retval = 0;
-	ssize_t        i, do_count, blks, transfer;
-	int            write_threshold;
-	int            doing_write = 0;
+	ssize_t		      total, retval = 0;
+	ssize_t		      i, do_count, blks, transfer;
+	int		      write_threshold;
+	int		      doing_write = 0;
 	const char   __user * b_point;
-	Scsi_Request * SRpnt = NULL;
+	struct scsi_request * SRpnt = NULL;
 	struct st_modedef   * STm;
 	struct st_partstat  * STps;
-	OS_Scsi_Tape * STp  = filp->private_data;
-	char         * name = tape_name(STp);
+	struct osst_tape    * STp  = filp->private_data;
+	char		    * name = tape_name(STp);
 
 
 	if (down_interruptible(&STp->lock))
@@ -3477,14 +3478,14 @@
 /* Read command */
 static ssize_t osst_read(struct file * filp, char __user * buf, size_t count, loff_t *ppos)
 {
-	ssize_t        total, retval = 0;
-	ssize_t        i, transfer;
-	int            special;
-	struct st_modedef      * STm;
+	ssize_t		      total, retval = 0;
+	ssize_t		      i, transfer;
+	int		      special;
+	struct st_modedef   * STm;
 	struct st_partstat  * STps;
-	Scsi_Request * SRpnt = NULL;
-	OS_Scsi_Tape * STp   = filp->private_data;
-	char         * name  = tape_name(STp);
+	struct scsi_request * SRpnt = NULL;
+	struct osst_tape    * STp   = filp->private_data;
+	char		    * name  = tape_name(STp);
 
 
 	if (down_interruptible(&STp->lock))
@@ -3660,8 +3661,7 @@
 
 
 /* Set the driver options */
-static void osst_log_options(OS_Scsi_Tape *STp, struct st_modedef *STm,
-			     char *name)
+static void osst_log_options(struct osst_tape *STp, struct st_modedef *STm, char *name)
 {
   printk(KERN_INFO
 "%s:I: Mode %d options: buffer writes: %d, async writes: %d, read ahead: %d\n",
@@ -3684,12 +3684,12 @@
 }
 
 
-static int osst_set_options(OS_Scsi_Tape *STp, long options)
+static int osst_set_options(struct osst_tape *STp, long options)
 {
-	int       value;
-	long      code;
+	int		    value;
+	long		    code;
 	struct st_modedef * STm;
-	char    * name = tape_name(STp);
+	char		  * name = tape_name(STp);
 
 	STm = &(STp->modes[STp->current_mode]);
 	if (!STm->defined) {
@@ -3840,18 +3840,19 @@
 
 
 /* Internal ioctl function */
-static int osst_int_ioctl(OS_Scsi_Tape * STp, Scsi_Request ** aSRpnt, unsigned int cmd_in, unsigned long arg)
+static int osst_int_ioctl(struct osst_tape * STp, struct scsi_request ** aSRpnt,
+			     unsigned int cmd_in, unsigned long arg)
 {
-	int            timeout;
-	long           ltmp;
-	int            i, ioctl_result;
-	int            chg_eof = TRUE;
-	unsigned char  cmd[MAX_COMMAND_SIZE];
-	Scsi_Request * SRpnt = * aSRpnt;
-	struct st_partstat  * STps;
-	int            fileno, blkno, at_sm, frame_seq_numbr, logical_blk_num;
-	int            datalen = 0, direction = SCSI_DATA_NONE;
-	char         * name = tape_name(STp);
+	int			timeout;
+	long			ltmp;
+	int			i, ioctl_result;
+	int			chg_eof = TRUE;
+	unsigned char		cmd[MAX_COMMAND_SIZE];
+	struct scsi_request   * SRpnt = * aSRpnt;
+	struct st_partstat    * STps;
+	int			fileno, blkno, at_sm, frame_seq_numbr, logical_blk_num;
+	int			datalen = 0, direction = SCSI_DATA_NONE;
+	char		      * name = tape_name(STp);
 
 	if (STp->ready != ST_READY && cmd_in != MTLOAD) {
 		if (STp->ready == ST_NO_TAPE)
@@ -4227,16 +4228,16 @@
 /* Open the device */
 static int os_scsi_tape_open(struct inode * inode, struct file * filp)
 {
-	unsigned short flags;
-	int            i, b_size, new_session = FALSE, retval = 0;
-	unsigned char  cmd[MAX_COMMAND_SIZE];
-	Scsi_Request * SRpnt = NULL;
-	OS_Scsi_Tape * STp;
-	struct st_modedef      * STm;
+	unsigned short	      flags;
+	int		      i, b_size, new_session = FALSE, retval = 0;
+	unsigned char	      cmd[MAX_COMMAND_SIZE];
+	struct scsi_request * SRpnt = NULL;
+	struct osst_tape    * STp;
+	struct st_modedef   * STm;
 	struct st_partstat  * STps;
-	char         * name;
-	int            dev  = TAPE_NR(inode);
-	int            mode = TAPE_MODE(inode);
+	char		    * name;
+	int		      dev  = TAPE_NR(inode);
+	int		      mode = TAPE_MODE(inode);
 
 	nonseekable_open(inode, filp);
 	write_lock(&os_scsi_tapes_lock);
@@ -4588,12 +4589,12 @@
 /* Flush the tape buffer before close */
 static int os_scsi_tape_flush(struct file * filp)
 {
-	int            result = 0, result2;
-	OS_Scsi_Tape * STp  = filp->private_data;
-	struct st_modedef      * STm  = &(STp->modes[STp->current_mode]);
-	struct st_partstat  * STps = &(STp->ps[STp->partition]);
-	Scsi_Request * SRpnt = NULL;
-	char         * name = tape_name(STp);
+	int		      result = 0, result2;
+	struct osst_tape    * STp    = filp->private_data;
+	struct st_modedef   * STm    = &(STp->modes[STp->current_mode]);
+	struct st_partstat  * STps   = &(STp->ps[STp->partition]);
+	struct scsi_request * SRpnt  = NULL;
+	char		    * name   = tape_name(STp);
 
 	if (file_count(filp) > 1)
 		return 0;
@@ -4676,9 +4677,9 @@
 /* Close the device and release it */
 static int os_scsi_tape_close(struct inode * inode, struct file * filp)
 {
-	int result = 0;
-	OS_Scsi_Tape * STp = filp->private_data;
-	Scsi_Request * SRpnt = NULL;
+	int		      result = 0;
+	struct osst_tape    * STp    = filp->private_data;
+	struct scsi_request * SRpnt  = NULL;
 
 	if (SRpnt) scsi_release_request(SRpnt);
 
@@ -4703,14 +4704,14 @@
 static int osst_ioctl(struct inode * inode,struct file * file,
 	 unsigned int cmd_in, unsigned long arg)
 {
-	int            i, cmd_nr, cmd_type, retval = 0;
-	unsigned int   blk;
-	struct st_modedef      * STm;
+	int		      i, cmd_nr, cmd_type, retval = 0;
+	unsigned int	      blk;
+	struct st_modedef   * STm;
 	struct st_partstat  * STps;
-	Scsi_Request * SRpnt = NULL;
-	OS_Scsi_Tape * STp   = file->private_data;
-	char         * name  = tape_name(STp);
-	void __user *p = (void __user *)arg;
+	struct scsi_request * SRpnt = NULL;
+	struct osst_tape    * STp   = file->private_data;
+	char		    * name  = tape_name(STp);
+	void	    __user  * p     = (void __user *)arg;
 
 	if (down_interruptible(&STp->lock))
 		return -ERESTARTSYS;
@@ -5039,18 +5040,18 @@
 /* Memory handling routines */
 
 /* Try to allocate a new tape buffer skeleton. Caller must not hold os_scsi_tapes_lock */
-static OSST_buffer * new_tape_buffer( int from_initialization, int need_dma, int max_sg )
+static struct osst_buffer * new_tape_buffer( int from_initialization, int need_dma, int max_sg )
 {
 	int i, priority;
-	OSST_buffer *tb;
+	struct osst_buffer *tb;
 
 	if (from_initialization)
 		priority = GFP_ATOMIC;
 	else
 		priority = GFP_KERNEL;
 
-	i = sizeof(OSST_buffer) + (osst_max_sg_segs - 1) * sizeof(struct scatterlist);
-	tb = (OSST_buffer *)kmalloc(i, priority);
+	i = sizeof(struct osst_buffer) + (osst_max_sg_segs - 1) * sizeof(struct scatterlist);
+	tb = (struct osst_buffer *)kmalloc(i, priority);
 	if (!tb) {
 		printk(KERN_NOTICE "osst :I: Can't allocate new tape buffer.\n");
 		return NULL;
@@ -5071,7 +5072,7 @@
 }
 
 /* Try to allocate a temporary (while a user has the device open) enlarged tape buffer */
-static int enlarge_buffer(OSST_buffer *STbuffer, int need_dma)
+static int enlarge_buffer(struct osst_buffer *STbuffer, int need_dma)
 {
 	int segs, nbr, max_segs, b_size, priority, order, got;
 
@@ -5150,7 +5151,7 @@
 
 
 /* Release the segments */
-static void normalize_buffer(OSST_buffer *STbuffer)
+static void normalize_buffer(struct osst_buffer *STbuffer)
 {
   int i, order, b_size;
 
@@ -5174,7 +5175,7 @@
 
 /* Move data from the user buffer to the tape buffer. Returns zero (success) or
    negative error code. */
-static int append_to_buffer(const char __user *ubp, OSST_buffer *st_bp, int do_count)
+static int append_to_buffer(const char __user *ubp, struct osst_buffer *st_bp, int do_count)
 {
 	int i, cnt, res, offset;
 
@@ -5207,7 +5208,7 @@
 
 /* Move data from the tape buffer to the user buffer. Returns zero (success) or
    negative error code. */
-static int from_buffer(OSST_buffer *st_bp, char __user *ubp, int do_count)
+static int from_buffer(struct osst_buffer *st_bp, char __user *ubp, int do_count)
 {
 	int i, cnt, res, offset;
 
@@ -5239,7 +5240,7 @@
 
 /* Sets the tail of the buffer after fill point to zero.
    Returns zero (success) or negative error code.        */
-static int osst_zero_buffer_tail(OSST_buffer *st_bp)
+static int osst_zero_buffer_tail(struct osst_buffer *st_bp)
 {
 	int	i, offset, do_count, cnt;
 
@@ -5267,7 +5268,7 @@
 
 /* Copy a osst 32K chunk of memory into the buffer.
    Returns zero (success) or negative error code.  */
-static int osst_copy_to_buffer(OSST_buffer *st_bp, unsigned char *ptr)
+static int osst_copy_to_buffer(struct osst_buffer *st_bp, unsigned char *ptr)
 {
 	int	i, cnt, do_count = OS_DATA_SIZE;
 
@@ -5288,7 +5289,7 @@
 
 /* Copy a osst 32K chunk of memory from the buffer.
    Returns zero (success) or negative error code.  */
-static int osst_copy_from_buffer(OSST_buffer *st_bp, unsigned char *ptr)
+static int osst_copy_from_buffer(struct osst_buffer *st_bp, unsigned char *ptr)
 {
 	int	i, cnt, do_count = OS_DATA_SIZE;
 
@@ -5411,13 +5412,13 @@
 
 static int osst_probe(struct device *dev)
 {
-	Scsi_Device    * SDp = to_scsi_device(dev);
-	OS_Scsi_Tape   * tpnt;
-	struct st_modedef        * STm;
-	struct st_partstat    * STps;
-	OSST_buffer    * buffer;
-	struct gendisk * drive;
-	int              i, mode, dev_num;
+	Scsi_Device	   * SDp = to_scsi_device(dev);
+	struct osst_tape   * tpnt;
+	struct st_modedef  * STm;
+	struct st_partstat * STps;
+	struct osst_buffer * buffer;
+	struct gendisk	   * drive;
+	int		     i, mode, dev_num;
 
 	if (SDp->type != TYPE_TAPE || !osst_supports(SDp))
 		return -ENODEV;
@@ -5432,7 +5433,7 @@
 	write_lock(&os_scsi_tapes_lock);
 	if (os_scsi_tapes == NULL) {
 		os_scsi_tapes =
-			(OS_Scsi_Tape **)kmalloc(osst_max_dev * sizeof(OS_Scsi_Tape *),
+			(struct osst_tape **)kmalloc(osst_max_dev * sizeof(struct osst_tape *),
 				   GFP_ATOMIC);
 		if (os_scsi_tapes == NULL) {
 			write_unlock(&os_scsi_tapes_lock);
@@ -5453,14 +5454,14 @@
 	if(i >= osst_max_dev) panic ("Scsi_devices corrupt (osst)");
 	dev_num = i;
 
-	/* allocate a OS_Scsi_Tape for this device */
-	tpnt = (OS_Scsi_Tape *)kmalloc(sizeof(OS_Scsi_Tape), GFP_ATOMIC);
+	/* allocate a struct osst_tape for this device */
+	tpnt = (struct osst_tape *)kmalloc(sizeof(struct osst_tape), GFP_ATOMIC);
 	if (tpnt == NULL) {
 		write_unlock(&os_scsi_tapes_lock);
 		printk(KERN_ERR "osst :E: Can't allocate device descriptor, device not attached.\n");
 		goto out_put_disk;
 	}
-	memset(tpnt, 0, sizeof(OS_Scsi_Tape));
+	memset(tpnt, 0, sizeof(struct osst_tape));
 
 	/* allocate a buffer for this device */
 	i = SDp->host->sg_tablesize;
@@ -5572,8 +5573,8 @@
 
 static int osst_remove(struct device *dev)
 {
-	Scsi_Device  * SDp = to_scsi_device(dev);
-	OS_Scsi_Tape * tpnt;
+	Scsi_Device	 * SDp = to_scsi_device(dev);
+	struct osst_tape * tpnt;
 	int i, mode;
 
 	if ((SDp->type != TYPE_TAPE) || (osst_nr_dev <= 0))
@@ -5622,7 +5623,7 @@
 static void __exit exit_osst (void)
 {
 	int i;
-	OS_Scsi_Tape * STp;
+	struct osst_tape * STp;
 
 	scsi_unregister_driver(&osst_template.gendrv);
 	unregister_chrdev(OSST_MAJOR, "osst");


