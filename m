Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264674AbSIQWrf>; Tue, 17 Sep 2002 18:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264689AbSIQWrb>; Tue, 17 Sep 2002 18:47:31 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:9913 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264674AbSIQWpv>;
	Tue, 17 Sep 2002 18:45:51 -0400
Date: Tue, 17 Sep 2002 15:50:41 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [RFC] [PATCH] 2/7 2.5.35 SCSI multi-path
Message-ID: <20020917155041.B18424@eng2.beaverton.ibm.com>
References: <20020917154940.A18401@eng2.beaverton.ibm.com> <20020917155018.A18424@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020917155018.A18424@eng2.beaverton.ibm.com>; from patman on Tue, Sep 17, 2002 at 03:50:18PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 2 of 3 to add mid-layer scsi changes to simplify and enable the
addition of scsi multi-path IO support.

This does not add multi-path support, it adds changes that simplify the
addition of the actual scsi multi-path code.

 scsi.h       |  201 +++++++++++++++++++++++++-
 scsi_ioctl.c |   85 ++++++-----
 scsi_lib.c   |  444 +++++++++++++++++++++++++++++++++++++++++++++--------------
 3 files changed, 585 insertions(+), 145 deletions(-)

diff -Nru a/drivers/scsi/scsi.h b/drivers/scsi/scsi.h
--- a/drivers/scsi/scsi.h	Mon Sep 16 15:29:45 2002
+++ b/drivers/scsi/scsi.h	Mon Sep 16 15:29:45 2002
@@ -133,12 +133,14 @@
 #define sense_error(sense)  ((sense) & 0xf)
 #define sense_valid(sense)  ((sense) & 0x80);
 
+#define	UNKNOWN_ERROR	0x0000
 #define NEEDS_RETRY     0x2001
 #define SUCCESS         0x2002
 #define FAILED          0x2003
 #define QUEUED          0x2004
 #define SOFT_ERROR      0x2005
 #define ADD_TO_MLQUEUE  0x2006
+#define REQUEUE  	0x2007
 
 /*
  * These are the values that scsi_cmd->state can take.
@@ -387,6 +389,13 @@
 #define SYNC_RESET      0x40
 
 /*
+ * Prefix values for the SCSI id's. These are stored in the first byte of the
+ * driverfs name field, see scsi_scan.c.
+ */
+#define SCSI_UID_SER_NUM 'S'
+#define SCSI_UID_UNKNOWN 'Z'
+
+/*
  * This is the crap from the old error handling code.  We have it in a special
  * place so that we can more easily delete it later on.
  */
@@ -398,6 +407,7 @@
 typedef struct scsi_device Scsi_Device;
 typedef struct scsi_cmnd Scsi_Cmnd;
 typedef struct scsi_request Scsi_Request;
+struct scsi_path_id;
 
 #define SCSI_CMND_MAGIC 0xE25C23A5
 #define SCSI_REQ_MAGIC  0x75F6D354
@@ -428,6 +438,7 @@
 			   void (*complete) (Scsi_Cmnd *));
 extern int scsi_delete_timer(Scsi_Cmnd * SCset);
 extern void scsi_error_handler(void *host);
+extern int scsi_check_sense(Scsi_Cmnd * SCpnt);
 extern int scsi_decide_disposition(Scsi_Cmnd * SCpnt);
 extern int scsi_block_when_processing_errors(Scsi_Device *);
 extern void scsi_sleep(int);
@@ -458,6 +469,7 @@
  */
 extern void scsi_initialize_merge_fn(Scsi_Device *SDpnt);
 extern int scsi_init_io(Scsi_Cmnd *SCpnt);
+extern void scsi_cleanup_io(Scsi_Cmnd *SCpnt);
 
 /*
  * Prototypes for functions in scsi_queue.c
@@ -467,6 +479,7 @@
 /*
  * Prototypes for functions in scsi_lib.c
  */
+struct Scsi_Host;
 extern int scsi_maybe_unblock_host(Scsi_Device * SDpnt);
 extern Scsi_Cmnd *scsi_end_request(Scsi_Cmnd * SCpnt, int uptodate,
 				   int sectors);
@@ -475,9 +488,12 @@
 extern int scsi_insert_special_cmd(Scsi_Cmnd * SCpnt, int);
 extern void scsi_io_completion(Scsi_Cmnd * SCpnt, int good_sectors,
 			       int block_sectors);
-extern void scsi_queue_next_request(request_queue_t * q, Scsi_Cmnd * SCpnt);
+extern void scsi_queue_next_request(request_queue_t * q, Scsi_Cmnd * SCpnt,
+				    struct Scsi_Host * SHpnt);
 extern void scsi_request_fn(request_queue_t * q);
 extern int scsi_starvation_completion(Scsi_Device * SDpnt);
+extern void scsi_add_scsi_device(Scsi_Device *SDpnt, struct Scsi_Host *SHpnt);
+extern void scsi_remove_scsi_device(Scsi_Device *SDpnt);
 
 /*
  * Prototypes for functions in scsi.c
@@ -489,7 +505,8 @@
 extern void scsi_done(Scsi_Cmnd * SCpnt);
 extern void scsi_finish_command(Scsi_Cmnd *);
 extern int scsi_retry_command(Scsi_Cmnd *);
-extern Scsi_Cmnd *scsi_allocate_device(Scsi_Device *, int, int);
+extern Scsi_Cmnd *scsi_allocate_device(Scsi_Device *, int, int,
+				       struct scsi_path_id *);
 extern void __scsi_release_command(Scsi_Cmnd *);
 extern void scsi_release_command(Scsi_Cmnd *);
 extern void scsi_do_cmd(Scsi_Cmnd *, const void *cmnd,
@@ -498,6 +515,9 @@
 			int timeout, int retries);
 extern int scsi_dev_init(void);
 
+extern int scsi_paths_proc_print_paths(Scsi_Device *SDpnt, char *buffer,
+				       char *format);
+
 /*
  * Newer request-based interfaces.
  */
@@ -542,6 +562,17 @@
 extern const char *scsi_extd_sense_format(unsigned char, unsigned char);
 
 /*
+ * The scsi_path_id struct contains the basic description of a path. IO to any
+ * logical LUN must use all four of these elements.
+ */
+struct scsi_path_id {
+	struct Scsi_Host *spi_shpnt;	/* Host adapter to use */
+	unsigned int spi_channel;	/* channel on the host */
+	unsigned int spi_id;		/* target id on the channel */
+	unsigned int spi_lun;		/* LUN on the target */
+};
+
+/*
  *  The scsi_device struct contains what we know about each given scsi
  *  device.
  *
@@ -558,19 +589,25 @@
 	/*
 	 * This information is private to the scsi mid-layer.
 	 */
-	struct scsi_device *next;	/* Used for linked list */
-	struct scsi_device *prev;	/* Used for linked list */
+	/*
+	 * Only the SCSI mid-layer routines should access sdev_next and 
+	 * sdev_prev. If you need to traverse through scsi_device's, use
+	 * one of the scsi traverse functions - adapter drivers probably want
+	 * to use scsi_for_each_host_sdev.
+	 */
+	struct scsi_device *sdev_next;	/* Used for linked list */
+	struct scsi_device *sdev_prev;	/* Used for linked list */
 	wait_queue_head_t   scpnt_wait;	/* Used to wait if
 					   device is busy */
-	struct Scsi_Host *host;
 	request_queue_t request_queue;
         atomic_t                device_active; /* commands checked out for device */
 	volatile unsigned short device_busy;	/* commands actually active on low-level */
 	Scsi_Cmnd *device_queue;	/* queue of SCSI Command structures */
         Scsi_Cmnd *current_cmnd;	/* currently active command */
-
-	unsigned int id, lun, channel;
-
+	struct Scsi_Host *host;
+	unsigned int channel;
+	unsigned int id;
+	unsigned int lun;
 	unsigned int manufacturer;	/* Manufacturer of device, for using 
 					 * vendor-specific cmd's */
 	unsigned sector_size;	/* size in bytes */
@@ -621,6 +658,7 @@
 	unsigned remap:1;	/* support remapping  */
 	unsigned starved:1;	/* unable to process commands because
 				   host busy */
+	unsigned scanning:1;	/* set while scanning */
 
 	// Flag to allow revalidate to succeed in sd_open
 	int allow_revalidate;
@@ -664,7 +702,6 @@
 						 * received on original command 
 						 * (auto-sense) */
 
-	struct Scsi_Host *sr_host;
 	Scsi_Device *sr_device;
 	Scsi_Cmnd *sr_command;
 	struct request *sr_request;	/* A copy of the command we are
@@ -738,6 +775,10 @@
 	struct scsi_cmnd *bh_next;	/* To enumerate the commands waiting 
 					   to be processed. */
 
+	/*
+	 * XXX a scsi_path_id should eventually replace the following,
+	 * including the *host.
+	 */
 	unsigned int target;
 	unsigned int lun;
 	unsigned int channel;
@@ -832,6 +873,7 @@
  */
 #define SCSI_MLQUEUE_HOST_BUSY   0x1055
 #define SCSI_MLQUEUE_DEVICE_BUSY 0x1056
+#define SCSI_MLQUEUE_RETRY       0x1057
 
 #define SCSI_SLEEP(QUEUE, CONDITION) {		    \
     if (CONDITION) {			            \
@@ -852,6 +894,90 @@
 	current->state = TASK_RUNNING;	\
     }; }
 
+typedef struct scsi_traverse_hndl {
+	Scsi_Device *last_scsi_device_p;
+	struct Scsi_Host *last_scsi_host_p;
+} scsi_traverse_hndl_t;
+
+extern Scsi_Device *scsi_traverse_sdevs(scsi_traverse_hndl_t *handle,
+					uint host_no, uint channel, uint id, uint lun);
+/*
+ * Values used for scsi_find_lun_start()
+ */
+#define SCSI_FIND_ALL_HOST_NO	0xffffffff
+#define SCSI_FIND_ALL_CHANNEL	0xffffffff
+#define SCSI_FIND_ALL_ID	0xffffffff
+#define SCSI_FIND_ALL_LUN	0xffffffff
+
+#define __INIT_TRAVERSE_HNDL(name)		\
+	(name)->last_scsi_device_p = NULL, 	\
+	(name)->last_scsi_host_p = NULL
+
+#define SCSI_TRAVERSE_ALL_SDEVS(hndl)			\
+	scsi_traverse_sdevs(hndl,			\
+			    SCSI_FIND_ALL_HOST_NO,	\
+			    SCSI_FIND_ALL_CHANNEL,	\
+			    SCSI_FIND_ALL_ID,		\
+			    SCSI_FIND_ALL_LUN)
+
+#define scsi_for_all_sdevs(hndl, sdev)			\
+	for (__INIT_TRAVERSE_HNDL(hndl), 		\
+	     sdev = SCSI_TRAVERSE_ALL_SDEVS(hndl); 	\
+	     sdev != NULL; 				\
+	     sdev = SCSI_TRAVERSE_ALL_SDEVS(hndl))
+
+#define SCSI_TRAVERSE_HOST_SDEVS(hndl, host)		\
+	scsi_traverse_sdevs(hndl,			\
+			    host,			\
+			    SCSI_FIND_ALL_CHANNEL,	\
+			    SCSI_FIND_ALL_ID,		\
+			    SCSI_FIND_ALL_LUN)
+
+#define scsi_for_each_host_sdev(hndl, sdev, host)			\
+	for (__INIT_TRAVERSE_HNDL(hndl), 			\
+	     sdev = SCSI_TRAVERSE_HOST_SDEVS(hndl, host); 	\
+	     sdev != NULL; 					\
+	     sdev = SCSI_TRAVERSE_HOST_SDEVS(hndl, host))
+
+#define SCSI_TRAVERSE_HOST_CHAN_SDEVS(hndl, host, chan)	\
+	scsi_traverse_sdevs(hndl,			\
+			    host,			\
+			    chan,			\
+			    SCSI_FIND_ALL_ID,		\
+			    SCSI_FIND_ALL_LUN)
+
+#define scsi_for_each_host_chan_sdev(hndl, sdev, host, chan)		\
+	for (__INIT_TRAVERSE_HNDL(hndl), 				\
+	     sdev = SCSI_TRAVERSE_HOST_CHAN_SDEVS(hndl, host, chan); 	\
+	     sdev != NULL; 						\
+	     sdev = SCSI_TRAVERSE_HOST_CHAN_SDEVS(hndl, host, chan))
+
+#define SCSI_TRAVERSE_SDEV_LUNS(hndl, host, chan, id)	\
+	scsi_traverse_sdevs(hndl,			\
+			    host,			\
+			    chan,			\
+			    id,				\
+			    SCSI_FIND_ALL_LUN)
+
+#define scsi_for_each_sdev_lun(hndl, sdev, host, chan, id)			\
+	for (__INIT_TRAVERSE_HNDL(hndl), 				\
+	     sdev = SCSI_TRAVERSE_SDEV_LUNS(hndl, host, chan, id); 	\
+	     sdev != NULL; 						\
+	     sdev = SCSI_TRAVERSE_SDEV_LUNS(hndl, host, chan, id))
+
+
+#define scsi_for_each_sdev(hndl, sdev, host, chan, id, lun)			\
+	for (__INIT_TRAVERSE_HNDL(hndl), 				\
+	     sdev = scsi_traverse_sdevs(hndl, host, chan, id, lun); 	\
+	     sdev != NULL; 						\
+	     sdev = scsi_traverse_sdevs(hndl, host, chan, id, lun))
+
+#define scsi_locate_sdev(host, chan, id, lun)			\
+	scsi_traverse_sdevs((scsi_traverse_hndl_t *) NULL,	\
+			    host,				\
+			    chan,				\
+			    id,					\
+			    lun)
 /*
  * old style reset request from external source
  * (private to sg.c and scsi_error.c, supplied by scsi_obsolete.c)
@@ -944,6 +1070,63 @@
 
         return (Scsi_Cmnd *)req->special;
 }
+
+static inline Scsi_Device *scsi_lookup_id(char *id, Scsi_Device *sdev)
+{
+	return(NULL);
+}
+
+static inline struct Scsi_Host *scsi_get_host(Scsi_Device *SDpnt)
+{
+	return (SDpnt->host);
+}
+
+static inline int scsi_add_path(Scsi_Device *SDpnt, struct Scsi_Host *shpnt,
+				unsigned int channel, unsigned int dev,
+				unsigned int lun)
+{
+	SDpnt->host = shpnt;
+	SDpnt->channel = channel;
+	SDpnt->lun = lun;
+	SDpnt->id = dev;
+	return 0;
+}
+
+static inline void scsi_remove_path(Scsi_Device *SDpnt, unsigned int host_no,
+				    unsigned int channel, unsigned int dev,
+				    unsigned int lun)
+{
+}
+
+static inline void scsi_replace_path(Scsi_Device *sdev, struct Scsi_Host *shost,
+	unsigned int channel, unsigned int id, unsigned int lun)
+{
+	sdev->host = shost;
+	sdev->channel = channel;
+	sdev->id = id;
+	sdev->lun = lun;
+}
+
+static inline int scsi_get_path(Scsi_Device *SDpnt, struct scsi_path_id *pathp)
+{
+	pathp->spi_shpnt = SDpnt->host;
+	pathp->spi_id = SDpnt->id;
+	pathp->spi_lun = SDpnt->lun;
+	pathp->spi_channel = SDpnt->channel;
+	return 0;
+}
+
+static inline int scsi_path_decide_disposition(Scsi_Cmnd * SCpnt)
+{
+	return UNKNOWN_ERROR;
+}
+
+extern void scsi_paths_printk(Scsi_Device *SDpnt, char *prefix, char *format);
+#define scsi_path_set_scmnd_ids(scp, pathp) do {		 	\
+	scp->host = pathp->spi_shpnt;			\
+	scp->target = pathp->spi_id;			\
+	scp->lun = pathp->spi_lun; 				\
+	scp->channel = pathp->spi_channel; } while(0)
 
 #define scsi_eh_eflags_chk(scp, flags) (scp->eh_eflags & flags)
 
diff -Nru a/drivers/scsi/scsi_ioctl.c b/drivers/scsi/scsi_ioctl.c
--- a/drivers/scsi/scsi_ioctl.c	Mon Sep 16 15:29:45 2002
+++ b/drivers/scsi/scsi_ioctl.c	Mon Sep 16 15:29:45 2002
@@ -129,10 +129,15 @@
 				break;
 			}
 		default:	/* Fall through for non-removable media */
-			printk("SCSI error: host %d id %d lun %d return code = %x\n",
-			       dev->host->host_no,
-			       dev->id,
-			       dev->lun,
+			/*
+			 * This is a bit klugey, since we rely on SRpnt
+			 * to contain the scsi_cmnd for the IO.
+			 */
+			printk("SCSI error: host %d channel %d id %d lun %d return code = %x\n",
+			       SRpnt->sr_command->host->host_no,
+			       SRpnt->sr_command->channel,
+			       SRpnt->sr_command->target,
+			       SRpnt->sr_command->lun,
 			       SRpnt->sr_result);
 			printk("\tSense class %x, sense error %x, extended sense %x\n",
 			       sense_class(SRpnt->sr_sense_buffer[0]),
@@ -191,6 +196,7 @@
 	char *cmd_in;
 	Scsi_Request *SRpnt;
 	Scsi_Device *SDpnt;
+	struct Scsi_Host *SHpnt;
 	unsigned char opcode;
 	unsigned int inlen, outlen, cmdlen;
 	unsigned int needed, buf_needed;
@@ -200,7 +206,9 @@
 	if (!sic)
 		return -EINVAL;
 
-	if (dev->host->unchecked_isa_dma)
+	if ((SHpnt = scsi_get_host(dev)) == NULL)
+		return -ENODEV;
+	if (SHpnt->unchecked_isa_dma)
 		gfp_mask |= GFP_DMA;
 
 	/*
@@ -275,11 +283,9 @@
 		goto error;
 
 	/*
-	 * Set the lun field to the correct value.
+	 * The lun field in cmd[1] is conditionally set in the mid-layer
+	 * before sending cmd.
 	 */
-	if (dev->scsi_level <= SCSI_2)
-		cmd[1] = (cmd[1] & 0x1f) | (dev->lun << 5);
-
 	switch (opcode) {
 	case FORMAT_UNIT:
 		timeout = FORMAT_UNIT_TIMEOUT;
@@ -378,10 +384,16 @@
 static int
 scsi_ioctl_get_pci(Scsi_Device * dev, void *arg)
 {
+	struct Scsi_Host *SHpnt;
 
-        if (!dev->host->pci_dev) return -ENXIO;
-        return copy_to_user(arg, dev->host->pci_dev->slot_name,
-                            sizeof(dev->host->pci_dev->slot_name));
+	/*
+	 * XXX this ioctl should be replaced by a host specific interface
+	 */ 
+	if ((SHpnt = scsi_get_host(dev)) == NULL)
+		return -ENODEV;
+        if (!SHpnt->pci_dev) return -ENXIO;
+        return copy_to_user(arg, SHpnt->pci_dev->slot_name,
+                            sizeof(SHpnt->pci_dev->slot_name));
 }
 
 
@@ -393,7 +405,8 @@
 int scsi_ioctl(Scsi_Device * dev, int cmd, void *arg)
 {
 	char scsi_cmd[MAX_COMMAND_SIZE];
-	char cmd_byte1;
+	struct scsi_path_id scsi_path;
+	struct Scsi_Host *SHpnt;
 
 	/* No idea how this happens.... */
 	if (!dev)
@@ -408,22 +421,29 @@
 	if (!scsi_block_when_processing_errors(dev)) {
 		return -ENODEV;
 	}
-	cmd_byte1 = (dev->scsi_level <= SCSI_2) ? (dev->lun << 5) : 0;
 
 	switch (cmd) {
 	case SCSI_IOCTL_GET_IDLUN:
 		if (verify_area(VERIFY_WRITE, arg, sizeof(Scsi_Idlun)))
 			return -EFAULT;
 
-		__put_user((dev->id & 0xff)
-			 + ((dev->lun & 0xff) << 8)
-			 + ((dev->channel & 0xff) << 16)
-			 + ((dev->host->host_no & 0xff) << 24),
+		/*
+		 * Just get first path, and use its
+		 * id/lun/channel/host_no. This is fine for single path
+		 * devices, or when no multi-path IO.
+		 */
+		scsi_get_path(dev, &scsi_path);
+		__put_user((scsi_path.spi_id & 0xff)
+			 + ((scsi_path.spi_lun & 0xff) << 8)
+			 + ((scsi_path.spi_channel & 0xff) << 16)
+			 + ((scsi_path.spi_shpnt->host_no & 0xff) << 24),
 			 &((Scsi_Idlun *) arg)->dev_id);
-		__put_user(dev->host->unique_id, &((Scsi_Idlun *) arg)->host_unique_id);
+		__put_user(scsi_path.spi_shpnt->unique_id, &((Scsi_Idlun *) arg)->host_unique_id);
 		return 0;
 	case SCSI_IOCTL_GET_BUS_NUMBER:
-		return put_user(dev->host->host_no, (int *) arg);
+		if ((SHpnt = scsi_get_host(dev)) == NULL)
+			return -ENODEV;
+		return put_user(SHpnt->host_no, (int *) arg);
 	case SCSI_IOCTL_TAGGED_ENABLE:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
@@ -441,7 +461,9 @@
 		dev->current_tag = 0;
 		return 0;
 	case SCSI_IOCTL_PROBE_HOST:
-		return ioctl_probe(dev->host, arg);
+		if ((SHpnt = scsi_get_host(dev)) == NULL)
+			return -ENODEV;
+		return ioctl_probe(SHpnt, arg);
 	case SCSI_IOCTL_SEND_COMMAND:
 		if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 			return -EACCES;
@@ -451,8 +473,7 @@
 		if (!dev->removable || !dev->lockable)
 			return 0;
 		scsi_cmd[0] = ALLOW_MEDIUM_REMOVAL;
-		scsi_cmd[1] = cmd_byte1;
-		scsi_cmd[2] = scsi_cmd[3] = scsi_cmd[5] = 0;
+		scsi_cmd[1] = scsi_cmd[2] = scsi_cmd[3] = scsi_cmd[5] = 0;
 		scsi_cmd[4] = SCSI_REMOVAL_PREVENT;
 		return ioctl_internal_command((Scsi_Device *) dev, scsi_cmd,
 				   IOCTL_NORMAL_TIMEOUT, NORMAL_RETRIES);
@@ -461,31 +482,27 @@
 		if (!dev->removable || !dev->lockable)
 			return 0;
 		scsi_cmd[0] = ALLOW_MEDIUM_REMOVAL;
-		scsi_cmd[1] = cmd_byte1;
-		scsi_cmd[2] = scsi_cmd[3] = scsi_cmd[5] = 0;
+		scsi_cmd[1] = scsi_cmd[2] = scsi_cmd[3] = scsi_cmd[5] = 0;
 		scsi_cmd[4] = SCSI_REMOVAL_ALLOW;
 		return ioctl_internal_command((Scsi_Device *) dev, scsi_cmd,
 				   IOCTL_NORMAL_TIMEOUT, NORMAL_RETRIES);
 	case SCSI_IOCTL_TEST_UNIT_READY:
 		scsi_cmd[0] = TEST_UNIT_READY;
-		scsi_cmd[1] = cmd_byte1;
-		scsi_cmd[2] = scsi_cmd[3] = scsi_cmd[5] = 0;
+		scsi_cmd[1] = scsi_cmd[2] = scsi_cmd[3] = scsi_cmd[5] = 0;
 		scsi_cmd[4] = 0;
 		return ioctl_internal_command((Scsi_Device *) dev, scsi_cmd,
 				   IOCTL_NORMAL_TIMEOUT, NORMAL_RETRIES);
 		break;
 	case SCSI_IOCTL_START_UNIT:
 		scsi_cmd[0] = START_STOP;
-		scsi_cmd[1] = cmd_byte1;
-		scsi_cmd[2] = scsi_cmd[3] = scsi_cmd[5] = 0;
+		scsi_cmd[1] = scsi_cmd[2] = scsi_cmd[3] = scsi_cmd[5] = 0;
 		scsi_cmd[4] = 1;
 		return ioctl_internal_command((Scsi_Device *) dev, scsi_cmd,
 				     START_STOP_TIMEOUT, NORMAL_RETRIES);
 		break;
 	case SCSI_IOCTL_STOP_UNIT:
 		scsi_cmd[0] = START_STOP;
-		scsi_cmd[1] = cmd_byte1;
-		scsi_cmd[2] = scsi_cmd[3] = scsi_cmd[5] = 0;
+		scsi_cmd[1] = scsi_cmd[2] = scsi_cmd[3] = scsi_cmd[5] = 0;
 		scsi_cmd[4] = 0;
 		return ioctl_internal_command((Scsi_Device *) dev, scsi_cmd,
 				     START_STOP_TIMEOUT, NORMAL_RETRIES);
@@ -494,8 +511,10 @@
                 return scsi_ioctl_get_pci(dev, arg);
                 break;
 	default:
-		if (dev->host->hostt->ioctl)
-			return dev->host->hostt->ioctl(dev, cmd, arg);
+		if ((SHpnt = scsi_get_host(dev)) == NULL)
+			return -ENODEV;
+		if (SHpnt->hostt->ioctl)
+			return SHpnt->hostt->ioctl(dev, cmd, arg);
 		return -EINVAL;
 	}
 	return -EINVAL;
diff -Nru a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
--- a/drivers/scsi/scsi_lib.c	Mon Sep 16 15:29:45 2002
+++ b/drivers/scsi/scsi_lib.c	Mon Sep 16 15:29:45 2002
@@ -37,6 +37,7 @@
 #define __KERNEL_SYSCALLS__
 
 #include <linux/unistd.h>
+#include <linux/slab.h>
 
 #include <asm/system.h>
 #include <asm/irq.h>
@@ -195,12 +196,14 @@
  *		permutations grows as 2**N, and if too many more special cases
  *		get added, we start to get screwed.
  */
-void scsi_queue_next_request(request_queue_t * q, Scsi_Cmnd * SCpnt)
+void scsi_queue_next_request(request_queue_t * q, Scsi_Cmnd * SCpnt,
+			     struct Scsi_Host * SHpnt)
 {
-	int all_clear;
 	unsigned long flags;
 	Scsi_Device *SDpnt;
-	struct Scsi_Host *SHpnt;
+	/* see comment further below */
+	int all_clear;
+	scsi_traverse_hndl_t STrav_hndl;
 
 	ASSERT_LOCK(q->queue_lock, 0);
 
@@ -225,7 +228,6 @@
 	q->request_fn(q);
 
 	SDpnt = (Scsi_Device *) q->queuedata;
-	SHpnt = SDpnt->host;
 
 	/*
 	 * If this is a single-lun device, and we are currently finished
@@ -237,7 +239,7 @@
 	if (SDpnt->single_lun && blk_queue_empty(q) && SDpnt->device_busy ==0) {
 		request_queue_t *q;
 
-		for (SDpnt = SHpnt->host_queue; SDpnt; SDpnt = SDpnt->next) {
+		scsi_for_each_host_sdev(&STrav_hndl, SDpnt, SHpnt->host_no) {
 			if (((SHpnt->can_queue > 0)
 			     && (SHpnt->host_busy >= SHpnt->can_queue))
 			    || (SHpnt->host_blocked)
@@ -261,7 +263,7 @@
 	 */
 	all_clear = 1;
 	if (SHpnt->some_device_starved) {
-		for (SDpnt = SHpnt->host_queue; SDpnt; SDpnt = SDpnt->next) {
+		scsi_for_each_host_sdev(&STrav_hndl, SDpnt, SHpnt->host_no) {
 			request_queue_t *q;
 			if ((SHpnt->can_queue > 0 && (SHpnt->host_busy >= SHpnt->can_queue))
 			    || (SHpnt->host_blocked) 
@@ -314,6 +316,7 @@
 	request_queue_t *q = &SCpnt->device->request_queue;
 	struct request *req = SCpnt->request;
 	unsigned long flags;
+	struct Scsi_Host * SHpnt = SCpnt->host;
 
 	ASSERT_LOCK(q->queue_lock, 0);
 
@@ -331,7 +334,7 @@
 		 * Bleah.  Leftovers again.  Stick the leftovers in
 		 * the front of the queue, and goose the queue again.
 		 */
-		scsi_queue_next_request(q, SCpnt);
+		scsi_queue_next_request(q, SCpnt, SHpnt);
 		return SCpnt;
 	}
 
@@ -351,7 +354,7 @@
 	__scsi_release_command(SCpnt);
 
 	if (frequeue)
-		scsi_queue_next_request(q, NULL);
+		scsi_queue_next_request(q, NULL, SHpnt);
 
 	return NULL;
 }
@@ -467,38 +470,7 @@
 	 */
 	ASSERT_LOCK(q->queue_lock, 0);
 
-	/*
-	 * Free up any indirection buffers we allocated for DMA purposes. 
-	 * For the case of a READ, we need to copy the data out of the
-	 * bounce buffer and into the real buffer.
-	 */
-	if (SCpnt->use_sg) {
-		struct scatterlist *sgpnt;
-
-		sgpnt = (struct scatterlist *) SCpnt->buffer;
-		scsi_free_sgtable(SCpnt->buffer, SCpnt->sglist_len);
-	} else {
-		if (SCpnt->buffer != req->buffer) {
-			if (rq_data_dir(req) == READ) {
-				unsigned long flags;
-				char *to = bio_kmap_irq(req->bio, &flags);
-
-				memcpy(to, SCpnt->buffer, SCpnt->bufflen);
-				bio_kunmap_irq(to, &flags);
-			}
-			kfree(SCpnt->buffer);
-		}
-	}
-
-	/*
-	 * Zero these out.  They now point to freed memory, and it is
-	 * dangerous to hang onto the pointers.
-	 */
-	SCpnt->buffer  = NULL;
-	SCpnt->bufflen = 0;
-	SCpnt->request_buffer = NULL;
-	SCpnt->request_bufflen = 0;
-
+	scsi_cleanup_io(SCpnt);
 	/*
 	 * Next deal with any sectors which we were able to correctly
 	 * handle.
@@ -558,7 +530,7 @@
 			 */
 			if (SCpnt->sense_buffer[12] == 0x04 &&
 			    SCpnt->sense_buffer[13] == 0x01) {
-				scsi_queue_next_request(q, SCpnt);
+				scsi_queue_next_request(q, SCpnt, SCpnt->host);
 				return;
 			}
 			if ((SCpnt->sense_buffer[2] & 0xf) == UNIT_ATTENTION) {
@@ -576,7 +548,8 @@
 				 	* media change, so we just retry the
 				 	* request and see what happens.  
 				 	*/
-					scsi_queue_next_request(q, SCpnt);
+					scsi_queue_next_request(q, SCpnt,
+								SCpnt->host);
 					return;
 				}
 			}
@@ -596,7 +569,7 @@
 				 * This will cause a retry with a 6-byte
 				 * command.
 				 */
-				scsi_queue_next_request(q, SCpnt);
+				scsi_queue_next_request(q, SCpnt, SCpnt->host);
 				result = 0;
 			} else {
 				SCpnt = scsi_end_request(SCpnt, 0, this_count);
@@ -628,7 +601,7 @@
 		 * recovery reasons.  Just retry the request
 		 * and see what happens.  
 		 */
-		scsi_queue_next_request(q, SCpnt);
+		scsi_queue_next_request(q, SCpnt, SCpnt->host);
 		return;
 	}
 	if (result) {
@@ -637,10 +610,10 @@
 		STpnt = scsi_get_request_dev(SCpnt->request);
 		printk("SCSI %s error : host %d channel %d id %d lun %d return code = %x\n",
 		       (STpnt ? STpnt->name : "device"),
-		       SCpnt->device->host->host_no,
-		       SCpnt->device->channel,
-		       SCpnt->device->id,
-		       SCpnt->device->lun, result);
+		       SCpnt->host->host_no,
+		       SCpnt->channel,
+		       SCpnt->target,
+		       SCpnt->lun, result);
 
 		if (driver_byte(result) & DRIVER_SENSE)
 			print_sense("sd", SCpnt);
@@ -706,6 +679,74 @@
 }
 
 /*
+ * Function:    scsi_dec_check_host_busy
+ *
+ * Purpose:     Decrement host_busy, and see if any action should be taken.
+ *
+ * Arguments:   SHpnt and request q.
+ *
+ * Lock status: Assumes that queue_lock is held when called.
+ *
+ * Returns:     Nothing
+ *
+ * Notes: 	The q arg and local flags are only needed for the locking hack.
+ */
+void scsi_dec_check_host_busy (struct Scsi_Host *SHpnt, request_queue_t * q)
+{
+	unsigned long flags;
+
+	/* XXX gross lock hack */
+	if (SHpnt->host_lock != q->queue_lock)
+		spin_lock_irqsave(SHpnt->host_lock, flags);
+	SHpnt->host_busy--;
+	/*
+	 * XXX check to see if the change in host_busy should kick off
+	 * error handling. This is really only needed if we drop and then
+	 * later lock queue_lock, but it is OK to always check it.
+	 */
+	if (SHpnt->host_lock != q->queue_lock)
+		spin_unlock_irqrestore(SHpnt->host_lock, flags);
+}
+
+/*
+ * Function:    scsi_get_best_path, not-multi-path IO version.
+ *
+ * Purpose:     Get and then check pathpnt to see if we can send IO.
+ *
+ * Arguments:   Scsi_Device pointer SDpnt, and struct scsi_path_id
+ * 		*pathpnt.
+ *
+ * Returns:     0 if it's OK to send IO, else 1.
+ *
+ * Notes:       This is not with the other not-multi-path-io functions,
+ * 		because it is not extern, and it is inlined; it is not in
+ * 		scsi.h because it needs Scsi_Host (in hosts.h) and
+ * 		Scsi_Device (in scsi.h).
+ */
+static int inline scsi_get_best_path(Scsi_Device *SDpnt, struct scsi_path_id
+				     *pathpnt, struct request *req)
+{
+	scsi_get_path(SDpnt, pathpnt);
+	if (pathpnt->spi_shpnt->in_recovery)
+		return 1;
+	if (SDpnt->device_blocked)
+		return 1;
+	if ((pathpnt->spi_shpnt->can_queue > 0 &&
+	     (pathpnt->spi_shpnt->host_busy >= pathpnt->spi_shpnt->can_queue))
+	    || (pathpnt->spi_shpnt->host_blocked) ||
+	    (pathpnt->spi_shpnt->host_self_blocked)) {
+		if (SDpnt->device_busy == 0) {
+			SDpnt->starved = 1;
+			pathpnt->spi_shpnt->some_device_starved = 1;
+		}
+		return 1;
+	} else
+		SDpnt->starved = 0;
+	pathpnt->spi_shpnt->host_busy++;
+	return 0;
+}
+
+/*
  * Function:    scsi_request_fn()
  *
  * Purpose:     Generic version of request function for SCSI hosts.
@@ -730,8 +771,9 @@
 	Scsi_Cmnd *SCpnt;
 	Scsi_Request *SRpnt;
 	Scsi_Device *SDpnt;
-	struct Scsi_Host *SHpnt;
 	struct Scsi_Device_Template *STpnt;
+	struct scsi_path_id path;
+	int res;
 
 	ASSERT_LOCK(q->queue_lock, 1);
 
@@ -739,7 +781,6 @@
 	if (!SDpnt) {
 		panic("Missing device");
 	}
-	SHpnt = SDpnt->host;
 
 	/*
 	 * To start with, we keep looping until the queue is empty, or until
@@ -747,12 +788,18 @@
 	 */
 	while (1 == 1) {
 		/*
-		 * Check this again - each time we loop through we will have
-		 * released the lock and grabbed it again, so each time
-		 * we need to check to see if the queue is plugged or not.
+		 * Each time we loop through we will have released the
+		 * lock and grabbed it again, so each time we need to
+		 * check to see if the queue is plugged or not.
 		 */
-		if (SHpnt->in_recovery || blk_queue_plugged(q))
+		if (blk_queue_plugged(q))
 			return;
+		/*
+		 * If we couldn't find a request that could be queued, then we
+		 * can also quit.
+		 */
+		if (blk_queue_empty(q))
+			break;
 
 		/*
 		 * If the device cannot accept another request, then quit.
@@ -760,24 +807,28 @@
 		if (SDpnt->device_blocked) {
 			break;
 		}
-		if ((SHpnt->can_queue > 0 && (SHpnt->host_busy >= SHpnt->can_queue))
-		    || (SHpnt->host_blocked) 
-		    || (SHpnt->host_self_blocked)) {
+
+		/*
+		 * get next queueable request.
+		 */
+		req = elv_next_request(q);
+
+		res = scsi_get_best_path(SDpnt, &path, req);
+		if (res == 1) {
 			/*
-			 * If we are unable to process any commands at all for
-			 * this device, then we consider it to be starved.
-			 * What this means is that there are no outstanding
-			 * commands for this device and hence we need a
-			 * little help getting it started again
-			 * once the host isn't quite so busy.
+			 * IO is blocked.
 			 */
-			if (SDpnt->device_busy == 0) {
-				SDpnt->starved = 1;
-				SHpnt->some_device_starved = 1;
-			}
-			break;
-		} else {
-			SDpnt->starved = 0;
+			req->flags &= ~REQ_STARTED;
+			return;
+		} else if (res == 2) {
+			/*
+			 * No active paths available.
+			 */
+			blkdev_dequeue_request(req);
+			if (end_that_request_first(req, 0, req->nr_sectors))
+				BUG();
+			end_that_request_last(req);
+			return;
 		}
 
  		/*
@@ -803,23 +854,13 @@
 				spin_unlock_irq(q->queue_lock);
 				scsi_ioctl(SDpnt, SCSI_IOCTL_DOORLOCK, 0);
 				spin_lock_irq(q->queue_lock);
+				scsi_host_busy_dec_and_test(path.spi_shpnt,
+							    SDpnt);
 				continue;
 			}
 		}
 
 		/*
-		 * If we couldn't find a request that could be queued, then we
-		 * can also quit.
-		 */
-		if (blk_queue_empty(q))
-			break;
-
-		/*
-		 * get next queueable request.
-		 */
-		req = elv_next_request(q);
-
-		/*
 		 * Find the actual device driver associated with this command.
 		 * The SPECIAL requests are things like character device or
 		 * ioctls, which did not originate from ll_rw_blk.  Note that
@@ -834,15 +875,38 @@
 			SCpnt = (Scsi_Cmnd *) req->special;
 			SRpnt = (Scsi_Request *) req->special;
 
+			/*
+			 * A scsi_do_cmd() or scsi_do_req().
+			 *
+			 * XXX modify Scsi_Request to include a path, if a
+			 * path is set in Scsi_Request, use it here.
+			 */
 			if( SRpnt->sr_magic == SCSI_REQ_MAGIC ) {
 				SCpnt = scsi_allocate_device(SRpnt->sr_device, 
-							     FALSE, FALSE);
-				if (!SCpnt)
+							     FALSE, FALSE, &path);
+				if (!SCpnt) {
+					scsi_host_busy_dec_and_test(path.spi_shpnt, SDpnt);
+					req->flags &= ~REQ_STARTED;
 					break;
+				}
 				scsi_init_cmd_from_req(SCpnt, SRpnt);
+			} else {
+				/* 
+				 * Either a scsi_do_cmd() or a retry of
+				 * scsi_do_req() or scsi_do_cmd().
+				 *
+				 * set SCpnt host/id/lun/channel
+				 */
+				SCpnt->host = path.spi_shpnt;
+				SCpnt->target = path.spi_id;
+				SCpnt->lun = path.spi_lun;
+				SCpnt->channel = path.spi_channel;
 			}
 
 		} else if (req->flags & REQ_CMD) {
+			/*
+			 * Block driver.
+			 */
 			SRpnt = NULL;
 			STpnt = scsi_get_request_dev(req);
 			if (!STpnt) {
@@ -852,30 +916,37 @@
 			 * Now try and find a command block that we can use.
 			 */
 			if (req->special) {
+				/*
+				 * Retry.
+				 */
 				SCpnt = (Scsi_Cmnd *) req->special;
+				SCpnt->host = path.spi_shpnt;
+				SCpnt->target = path.spi_id;
+				SCpnt->lun = path.spi_lun;
+				SCpnt->channel = path.spi_channel;
 			} else {
-				SCpnt = scsi_allocate_device(SDpnt, FALSE, FALSE);
+				SCpnt = scsi_allocate_device(SDpnt, FALSE, FALSE, &path);
 			}
 			/*
 			 * If so, we are ready to do something.  Bump the count
 			 * while the queue is locked and then break out of the
 			 * loop. Otherwise loop around and try another request.
 			 */
-			if (!SCpnt)
+			if (!SCpnt) {
+				scsi_host_busy_dec_and_test(path.spi_shpnt, SDpnt);
+				req->flags &= ~REQ_STARTED;
 				break;
+			}
 
 			/* pull a tag out of the request if we have one */
 			SCpnt->tag = req->tag;
 		} else {
 			blk_dump_rq_flags(req, "SCSI bad req");
+			scsi_host_busy_dec_and_test(path.spi_shpnt, SDpnt);
+			req->flags &= ~REQ_STARTED;
 			break;
 		}
 
-		/*
-		 * Now bump the usage count for both the host and the
-		 * device.
-		 */
-		SHpnt->host_busy++;
 		SDpnt->device_busy++;
 
 		/*
@@ -926,11 +997,11 @@
 			 */
 			if (!scsi_init_io(SCpnt)) {
 				spin_lock_irq(q->queue_lock);
-				SHpnt->host_busy--;
-				SDpnt->device_busy--;
+				scsi_host_busy_dec_and_test(path.spi_shpnt, SDpnt);
+				SDpnt->device_busy--;	/* XXX race */
 				if (SDpnt->device_busy == 0) {
 					SDpnt->starved = 1;
-					SHpnt->some_device_starved = 1;
+					path.spi_shpnt->some_device_starved = 1;
 				}
 				SCpnt->request->special = SCpnt;
 				SCpnt->request->flags |= REQ_SPECIAL;
@@ -952,12 +1023,19 @@
 					panic("Should not have leftover blocks\n");
 				}
 				spin_lock_irq(q->queue_lock);
-				SHpnt->host_busy--;
-				SDpnt->device_busy--;
+				scsi_host_busy_dec_and_test(path.spi_shpnt, SDpnt);
+				SDpnt->device_busy--;	/* XXX race */
 				continue;
 			}
 		}
 		/*
+		 * If SCSI-2 or lower, store the LUN value in cmnd.
+		 */
+		if (SDpnt->scsi_level <= SCSI_2)
+			SCpnt->cmnd[1] = (SCpnt->cmnd[1] & 0x1f) |
+				(SCpnt->lun << 5 & 0xe0);
+
+		/*
 		 * Finally, initialize any error handling parameters, and set up
 		 * the timers for timeouts.
 		 */
@@ -1020,11 +1098,13 @@
 void scsi_unblock_requests(struct Scsi_Host * SHpnt)
 {
 	Scsi_Device *SDloop;
+	scsi_traverse_hndl_t STrav_hndl;
 
 	SHpnt->host_self_blocked = FALSE;
 	/* Now that we are unblocked, try to start the queues. */
-	for (SDloop = SHpnt->host_queue; SDloop; SDloop = SDloop->next)
-		scsi_queue_next_request(&SDloop->request_queue, NULL);
+	scsi_for_each_host_sdev(&STrav_hndl, SDloop, SHpnt->host_no) {
+		scsi_queue_next_request(&SDloop->request_queue, NULL, SHpnt);
+	}
 }
 
 /*
@@ -1051,11 +1131,11 @@
 void scsi_report_bus_reset(struct Scsi_Host * SHpnt, int channel)
 {
 	Scsi_Device *SDloop;
-	for (SDloop = SHpnt->host_queue; SDloop; SDloop = SDloop->next) {
-		if (channel == SDloop->channel) {
-			SDloop->was_reset = 1;
-			SDloop->expecting_cc_ua = 1;
-		}
+	scsi_traverse_hndl_t STrav_hndl;
+
+	scsi_for_each_host_sdev(&STrav_hndl, SDloop, SHpnt->host_no) {
+		SDloop->was_reset = 1;
+		SDloop->expecting_cc_ua = 1;
 	}
 }
 
@@ -1075,3 +1155,161 @@
 void scsi_deregister_blocked_host(struct Scsi_Host * SHpnt)
 {
 }
+
+/*
+ * Function:    scsi_add_scsi_device
+ *
+ * Purpose:     Add a SDpnt to the list of Scsi_Devices, add it to the
+ *		"tail" of the list. If needed, add it to the list for
+ *		shostpnt.
+ *
+ * Arguments:   Scsi_Device pointer SDpnt.
+ *
+ * Notes:       Doesn't do anything other than link in SDpnt, we should add
+ *		other code that is common to the addition of all Scsi_Devices.
+ */
+void scsi_add_scsi_device(Scsi_Device *SDpnt, struct Scsi_Host *shostpnt)
+{
+	Scsi_Device *sdtailpnt;
+
+	SDpnt->sdev_prev = NULL;
+	SDpnt->sdev_next = NULL;
+
+	if (shostpnt->host_queue != NULL) {
+		sdtailpnt = shostpnt->host_queue;
+		while (sdtailpnt->sdev_next != NULL)
+			sdtailpnt = sdtailpnt->sdev_next;
+
+		sdtailpnt->sdev_next = SDpnt;
+		SDpnt->sdev_prev = sdtailpnt;
+	} else {
+		shostpnt->host_queue = SDpnt;
+	}
+}
+
+/*
+ * Function:    scsi_remove_scsi_device
+ *
+ * Purpose:     Remove SDpnt from the list of Scsi_Devices.
+ *
+ * Arguments:   Scsi_Device pointer SDpnt.
+ *
+ * Notes:       unlink and kfree SDpnt, we should add other code that is common
+ * 		to removal of all Scsi_Devices.
+ */
+void scsi_remove_scsi_device(Scsi_Device *SDpnt)
+{
+	struct Scsi_Host *hbapnt;
+
+	if (SDpnt == NULL)
+		return;
+	if (SDpnt->sdev_next != NULL)
+		SDpnt->sdev_next->sdev_prev = SDpnt->sdev_prev;
+	if (SDpnt->sdev_prev != NULL)
+		SDpnt->sdev_prev->sdev_next = SDpnt->sdev_next;
+
+	hbapnt = SDpnt->host;
+	if ((hbapnt != NULL) && (hbapnt->host_queue == SDpnt))
+		hbapnt->host_queue = SDpnt->sdev_next;
+	if (SDpnt->inquiry != NULL)
+		kfree(SDpnt->inquiry);
+	kfree((char *) SDpnt);
+}
+
+/*
+ * scsi_traverse_sdevs - Return the next Scsi_Device matching the search
+ * requested, non-multi-path version
+ *
+ * @handle: Handle used to bookmark location of search thus far.
+ * @host_no: Host to search for.
+ * @channel: Channel to search for.
+ * @id:	Id to search for.
+ * @lun: Lun to search for.
+ *
+ * Description:
+ * 	Returns - A pointer to Scsi_Device, NULL when the list is complete.
+ * 	Notes -  Assumes that we do not remove a device between calls.
+ *
+ */
+Scsi_Device *scsi_traverse_sdevs(scsi_traverse_hndl_t *handle, uint host_no, uint channel,
+				 uint id, uint lun)
+{
+	Scsi_Device	*SDpnt;
+	struct Scsi_Host	*shostpnt;
+
+	if (handle == NULL) {
+		shostpnt = NULL;
+		SDpnt = NULL;
+	} else {
+		shostpnt = handle->last_scsi_host_p;
+		SDpnt = handle->last_scsi_device_p;
+	}
+
+	
+	if (shostpnt == NULL) {
+		/*
+		 * New search starts with handles NULL.
+		 * Set shostpnt here and let SDpnt get set
+		 * in the for loop below.
+		 */
+		shostpnt = scsi_hostlist;
+		SDpnt = shostpnt->host_queue;
+	} else
+		SDpnt = SDpnt->sdev_next;
+
+	while (shostpnt) {
+		if (shostpnt->host_no == host_no ||
+		    host_no == SCSI_FIND_ALL_HOST_NO) {
+			for(; SDpnt; SDpnt = SDpnt->sdev_next) {
+				if ((channel == SCSI_FIND_ALL_CHANNEL ||
+				   channel == SDpnt->channel) &&
+				   (id == SCSI_FIND_ALL_ID ||
+				   id == SDpnt->id) &&
+				   (lun == SCSI_FIND_ALL_LUN ||
+				   lun == SDpnt->lun))
+					goto done;
+
+			}
+
+		}
+		if (shostpnt->host_no == host_no)
+			goto done;
+
+		shostpnt = shostpnt->next;
+		if (shostpnt)
+			SDpnt = shostpnt->host_queue;
+	}
+
+done:
+	if (handle) {
+		handle->last_scsi_device_p = SDpnt;
+		handle->last_scsi_host_p = shostpnt;
+	}
+	return SDpnt;
+}
+
+/*
+ * Function:    scsi_paths_printk, not-multi-path IO version.
+ *
+ * Purpose:     For the path in SDpnt, printk the host/channel/id/lun
+ * 		using the specified format.
+ *
+ * Arguments:   Scsi_Device pointer SDpnt, *prefix the string to print first.
+ *
+ * Notes:       This is not inlined because of circular dependencies (Scsi_Host
+ * 		is in hosts.h, Scsi_Device in scsi.h).
+ */
+void scsi_paths_printk(Scsi_Device *SDpnt, char *prefix,
+	char *format)
+{
+	printk(format, SDpnt->host->host_no, SDpnt->channel, SDpnt->id,
+	       SDpnt->lun);
+}
+
+#ifdef CONFIG_PROC_FS
+int scsi_paths_proc_print_paths(Scsi_Device *SDpnt, char *buffer, char *format)
+{
+	return(sprintf(buffer, format, SDpnt->host->host_no,
+		      SDpnt->channel, SDpnt->id, SDpnt->lun));
+}
+#endif
