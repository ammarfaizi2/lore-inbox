Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266427AbUFZUeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266427AbUFZUeb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 16:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266431AbUFZUeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 16:34:31 -0400
Received: from mail1.kontent.de ([81.88.34.36]:57224 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S266427AbUFZUeP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 16:34:15 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: drivers/block/ub.c
Date: Sat, 26 Jun 2004 22:35:15 +0200
User-Agent: KMail/1.6.2
Cc: greg@kroah.com, arjanv@redhat.com, jgarzik@redhat.com, tburke@redhat.com,
       linux-kernel@vger.kernel.org, <stern@rowland.harvard.edu>,
       <mdharm-usb@one-eyed-alien.net>, <david-b@pacbell.net>
References: <20040626130645.55be13ce@lembas.zaitcev.lan>
In-Reply-To: <20040626130645.55be13ce@lembas.zaitcev.lan>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200406262235.15688.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +/* command block wrapper */
> +struct bulk_cb_wrap {
> +	u32	Signature;		/* contains 'USBC' */
> +	u32	Tag;			/* unique per command id */
> +	u32	DataTransferLength;	/* size of data */
> +	u8	Flags;			/* direction in bit 0 */
> +	u8	Lun;			/* LUN normally 0 */
> +	u8	Length;			/* of of the CDB */
> +	u8	CDB[MAX_CDB_SIZE];	/* max command */
> +};

should be packed attributed

> +#define US_BULK_CB_WRAP_LEN	31
> +#define US_BULK_CB_SIGN		0x43425355	/*spells out USBC */
> +#define US_BULK_FLAG_IN		1
> +#define US_BULK_FLAG_OUT	0
> +
> +/* command status wrapper */
> +struct bulk_cs_wrap {
> +	u32	Signature;		/* should = 'USBS' */
> +	u32	Tag;			/* same as original command */
> +	u32	Residue;		/* amount not transferred */
> +	u8	Status;			/* see below */
> +};

should be packed attributed

> +#define US_BULK_CS_WRAP_LEN	13
> +#define US_BULK_CS_SIGN		0x53425355	/* spells out 'USBS' */
> +/* This is for Olympus Camedia digital cameras */
> +#define US_BULK_CS_OLYMPUS_SIGN	0x55425355	/* spells out 'USBU' */
> +#define US_BULK_STAT_OK		0
> +#define US_BULK_STAT_FAIL	1
> +#define US_BULK_STAT_PHASE	2
> +
> +/* bulk-only class specific requests */
> +#define US_BULK_RESET_REQUEST	0xff
> +#define US_BULK_GET_MAX_LUN	0xfe
> +
> +/*
> + */
> +struct ub_dev;
> +
> +#define UB_MAX_REQ_SG	1
> +
> +/*
> + * An instance of a SCSI command in transit.
> + */
> +#define UB_DIR_NONE	0
> +#define UB_DIR_READ	1
> +#define UB_DIR_ILLEGAL2	2
> +#define UB_DIR_WRITE	3
> +
> +enum ub_scsi_cmd_state {
> +	UB_CMDST_INIT,			/* Initial state */
> +	UB_CMDST_CMD,			/* Command submitted */
> +	UB_CMDST_DATA,			/* Data phase */
> +	UB_CMDST_CLR2STS,		/* Clearing before requesting status */
> +	UB_CMDST_STAT,			/* Status phase */
> +	UB_CMDST_CLEAR,			/* Clearing a stall (halt, actually) */
> +	UB_CMDST_SENSE,			/* Sending Request Sense */
> +	UB_CMDST_DONE			/* Final state */
> +};
> +
> +struct ub_scsi_cmd {
> +	unsigned char cdb[MAX_CDB_SIZE];
> +	unsigned char cdb_len;
> +
> +	unsigned char dir;		/* 0 - none, 1 - read, 3 - write. */
> +	enum ub_scsi_cmd_state state;
> +	unsigned int tag;
> +
> +	int error;			/* Return code - valid upon done */
> +	int act_len;			/* Return size */
> +
> +	int stat_count;			/* Retries getting status. */
> +
> +	/*
> +	 * We do not support transfers from highmem pages
> +	 * because the underlying USB framework does not.
> +	 *
> +	 * XXX Actually, there is a (very fresh and buggy) support
> +	 * for transfers under control of struct scatterlist, usb_map_sg()
> +	 * in 2.6.6, but it seems to have issues with highmem.
> +	 */
> +	char *data;			/* Requested buffer */
> +	unsigned int len;		/* Requested length */
> +	// struct scatterlist sgv[UB_MAX_REQ_SG];
> +
> +	void (*done)(struct ub_dev *, struct ub_scsi_cmd *);
> +	void *back;
> +};
> +
> +/*
> + */
> +struct ub_capacity {
> +	unsigned long nsec;		/* Linux size - 512 byte sectors */
> +	unsigned int bsize;		/* Linux hardsect_size */
> +	unsigned int bshift;		/* Shift between 512 and hard sects */
> +};
> +
> +/*
> + * The SCSI command tracing structure.
> + */
> +
> +#define SCMD_ST_HIST_SZ   8
> +#define SCMD_TRACE_SZ     5
> +
> +struct ub_scsi_cmd_trace {
> +	unsigned int tag;
> +	unsigned char op;
> +	unsigned char dir;
> +	unsigned int req_size, act_size;
> +	int hcur;
> +	enum ub_scsi_cmd_state st_hst[SCMD_ST_HIST_SZ];		/* u8? */
> +};
> +
> +struct ub_scsi_trace {
> +	int cur;
> +	struct ub_scsi_cmd_trace vec[SCMD_TRACE_SZ];
> +};
> +
> +/*
> + * The UB device instance.
> + */
> +struct ub_dev {
> +	spinlock_t lock;
> +	unsigned int id;		/* Number among ub's */
> +
> +	unsigned int tagcnt;
> +	int poison;
> +	char name[8];
> +	struct usb_device *dev;
> +	struct usb_interface *intf;
> +
> +	struct ub_capacity capacity; 
> +	struct gendisk *disk;
> +
> +	unsigned int send_bulk_pipe;  /* cached pipe values */
> +	unsigned int recv_bulk_pipe;
> +	unsigned int send_ctrl_pipe;
> +	unsigned int recv_ctrl_pipe;
> +
> +	struct tasklet_struct urb_tasklet;
> +
> +	/* XXX Use Ingo's mempool (once we have more than one) */
> +	int cmda[1];
> +	struct ub_scsi_cmd cmdv[1];
> +
> +	int busy;
> +	struct ub_scsi_cmd *top_cmd;	/* XXX Under ->busy until we have a queue */
> +	struct ub_scsi_cmd top_rqs_cmd;	/* REQUEST SENSE */
> +	unsigned char top_sense[SENSE_SIZE];
> +
> +	struct urb work_urb;
> +	int last_pipe;			/* What might need clearing */
> +	struct bulk_cb_wrap work_bcb;
> +	struct bulk_cs_wrap work_bcs;
> +	struct usb_ctrlrequest work_cr;
> +
> +	struct ub_scsi_trace tr;
> +};
> +
> +/*
> + */
> +static void ub_rw_cmd_done(struct ub_dev *sc, struct ub_scsi_cmd *cmd);
> +static void ub_end_rq(struct request *rq, int uptodate);
> +static int ub_submit_scsi(struct ub_dev *sc, struct ub_scsi_cmd *cmd);
> +static void ub_scsi_urb_complete(struct urb *urb, struct pt_regs *pt);
> +static void ub_scsi_urb_action(unsigned long _dev);
> +static void ub_scsi_urb_compl(struct ub_dev *sc, struct ub_scsi_cmd *cmd);
> +static void ub_state_stat(struct ub_dev *sc, struct ub_scsi_cmd *cmd);
> +static int ub_submit_clear_stall(struct ub_dev *sc, struct ub_scsi_cmd *cmd,
> +    int stalled_pipe);
> +static int ub_submit_top_sense(struct ub_dev *sc, struct ub_scsi_cmd *cmd);
> +
> +/*
> + */
> +static struct usb_device_id ub_usb_ids[] = {
> +	{ USB_DEVICE_VER(0x0781, 0x0002, 0x0009, 0x0009) },	/* SDDR-31 */
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(usb, ub_usb_ids);
> +
> +static unsigned int ub_host_id;
> +
> +/*
> + * The SCSI command tracing procedures.
> + */
> +
> +static void ub_cmdtr_new(struct ub_dev *sc, struct ub_scsi_cmd *cmd)
> +{
> +	int n;
> +	struct ub_scsi_cmd_trace *t;
> +
> +	if ((n = sc->tr.cur + 1) == SCMD_TRACE_SZ) n = 0;
> +	t = &sc->tr.vec[n];
> +
> +	memset(t, 0, sizeof(struct ub_scsi_cmd_trace));
> +	t->tag = cmd->tag;
> +	t->op = cmd->cdb[0];
> +	t->dir = cmd->dir;
> +	t->req_size = cmd->len;
> +	t->st_hst[0] = cmd->state;
> +
> +	sc->tr.cur = n;
> +}
> +
> +static void ub_cmdtr_state(struct ub_dev *sc, struct ub_scsi_cmd *cmd)
> +{
> +	int n;
> +	struct ub_scsi_cmd_trace *t;
> +
> +	t = &sc->tr.vec[sc->tr.cur];
> +	if ((n = t->hcur + 1) == SCMD_ST_HIST_SZ) n = 0;
> +	t->st_hst[n] = cmd->state;
> +	t->hcur = n;
> +}
> +
> +static void ub_cmdtr_act_len(struct ub_dev *sc, struct ub_scsi_cmd *cmd)
> +{
> +	struct ub_scsi_cmd_trace *t;
> +
> +	t = &sc->tr.vec[sc->tr.cur];
> +	t->act_size = cmd->act_len;
> +}
> +
> +/* The struct disk_attribute must match drivers/block/genhd.c */
> +struct disk_attribute {
> +	struct attribute attr;
> +	ssize_t (*show)(struct gendisk *, char *);
> +};
> +
> +static ssize_t ub_sysdiag_show(struct gendisk *disk, char *page)
> +{
> +	struct ub_dev *sc = disk->private_data;
> +	int cnt = 0;
> +	unsigned long flags;
> +	int nc, nh;
> +	int i, j;
> +	struct ub_scsi_cmd_trace *t;
> +
> +	spin_lock_irqsave(&sc->lock, flags);
> +	if ((nc = sc->tr.cur + 1) == SCMD_TRACE_SZ) nc = 0;
> +	for (j = 0; j < SCMD_TRACE_SZ; j++) {
> +		t = &sc->tr.vec[nc];
> +
> +		cnt += sprintf(page + cnt, "%08x %02x", t->tag, t->op);
> +		cnt += sprintf(page + cnt, " %d", t->dir);
> +		cnt += sprintf(page + cnt, " [%5d %5d]", t->req_size, t->act_size);
> +		if ((nh = t->hcur + 1) == SCMD_ST_HIST_SZ) nh = 0;
> +		for (i = 0; i < SCMD_ST_HIST_SZ; i++) {
> +			cnt += sprintf(page + cnt, " %d", t->st_hst[nh]);
> +			if (++nh == SCMD_ST_HIST_SZ) nh = 0;
> +		}
> +		cnt += sprintf(page + cnt, "\n");
> +
> +		if (++nc == SCMD_TRACE_SZ) nc = 0;
> +	}
> +	spin_unlock_irqrestore(&sc->lock, flags);
> +	return cnt;
> +}
> +
> +static struct disk_attribute ub_sysdiag_attr = {
> +        .attr = {.name = "diag", .mode = S_IRUGO },
> +	.show = ub_sysdiag_show
> +};
> +
> +static int ub_sysdiag_create(struct ub_dev *sc)
> +{
> +	return sysfs_create_file(&sc->disk->kobj, &ub_sysdiag_attr.attr);
> +}
> +
> +/*
> + * The "command allocator".
> + */
> +static struct ub_scsi_cmd *ub_get_cmd(struct ub_dev *sc)
> +{
> +	struct ub_scsi_cmd *ret;
> +
> +	if (sc->cmda[0])
> +		return NULL;
> +	ret = &sc->cmdv[0];
> +	sc->cmda[0] = 1;
> +	return ret;
> +}
> +
> +static void ub_put_cmd(struct ub_dev *sc, struct ub_scsi_cmd *cmd)
> +{
> +	if (cmd != &sc->cmdv[0]) {
> +		printk(KERN_WARNING DRV_NAME ": "
> +		    "releasing a foreign cmd %p\n", cmd);
> +		return;
> +	}
> +	if (!sc->cmda[0]) {
> +		printk(KERN_WARNING DRV_NAME ": "
> +		    "releasing a free cmd\n");
> +		return;
> +	}
> +	sc->cmda[0] = 0;
> +}
> +
> +/*
> + * The request function is our main entry point
> + */
> +
> +static inline int ub_bd_rq_fn_1(request_queue_t *q)
> +{
> +#if 0
> +	int writing = 0, pci_dir, i, n_elem;
> +	u32 tmp;
> +	unsigned int msg_size;
> +#endif
> +	struct ub_dev *sc = q->queuedata;
> +	struct request *rq;
> +#if 0 /* We use rq->buffer for now */
> +	struct scatterlist *sg;
> +	int n_elem;
> +#endif
> +	struct ub_scsi_cmd *cmd;
> +	int ub_dir;
> +	unsigned int block, nblks;
> +	int rc;
> +
> +	if ((rq = elv_next_request(q)) == NULL)
> +		return 1;
> +
> +	if ((cmd = ub_get_cmd(sc)) == NULL) {
> +		blk_stop_queue(q);
> +		return 1;
> +	}
> +
> +	blkdev_dequeue_request(rq);
> +
> +	if (rq_data_dir(rq) == WRITE)
> +		ub_dir = UB_DIR_WRITE;
> +	else
> +		ub_dir = UB_DIR_READ;
> +
> +	/*
> +	 * get scatterlist from block layer
> +	 */
> +#if 0 /* We use rq->buffer for now */
> +	sg = &cmd->sgv[0];
> +	n_elem = blk_rq_map_sg(q, rq, sg);
> +	if (n_elem <= 0) {
> +		ub_put_cmd(sc, cmd);
> +		ub_end_rq(rq, 0);
> +		blk_start_queue(q);
> +		return 0;		/* request with no s/g entries? */
> +	}
> +
> +	if (n_elem != 1) {		/* Paranoia */
> +		printk(KERN_WARNING DRV_NAME ": request with %d segments\n",
> +		    n_elem);
> +		ub_put_cmd(sc, cmd);
> +		ub_end_rq(rq, 0);
> +		blk_start_queue(q);
> +		return 0;
> +	}
> +#endif
> +	/*
> +	 * XXX Unfortunately, this check does not work. It is quite possible
> +	 * to get bogus non-null rq->buffer if you allow sg by mistake.
> +	 */
> +	if (rq->buffer == NULL) {
> +		/*
> +		 * This must not happen if we set the queue right.
> +		 * The block level must create bounce buffers for us.
> +		 */
> +		static int do_print = 1;
> +		if (do_print) {
> +			printk(KERN_WARNING DRV_NAME ": unmapped request\n");
> +			do_print = 0;
> +		}
> +		ub_put_cmd(sc, cmd);
> +		ub_end_rq(rq, 0);
> +		blk_start_queue(q);
> +		return 0;
> +	}
> +
> +#if 0 /* Just to show what carmel does in this place... We won't need this. */
> +	/* map scatterlist to PCI bus addresses */
> +	n_elem = pci_map_sg(host->pdev, sg, n_elem, pci_dir);
> +	if (n_elem <= 0) {
> +		carm_end_rq(host, crq, 0);
> +		return 1;		/* request with no s/g entries? */
> +	}
> +	crq->n_elem = n_elem;
> +	crq->port = port;
> +	host->hw_sg_used += n_elem;
> +#endif
> +
> +	/*
> +	 * build the command
> +	 */
> +	block = rq->sector;
> +	nblks = rq->nr_sectors;
> +
> +	memset(cmd, 0, sizeof(struct ub_scsi_cmd));
> +	cmd->cdb[0] = (ub_dir == UB_DIR_READ)? READ_10: WRITE_10;
> +	/* 10-byte uses 4 bytes of LBA: 2147483648KB, 2097152MB, 2048GB */
> +	cmd->cdb[2] = block >> 24;
> +	cmd->cdb[3] = block >> 16;
> +	cmd->cdb[4] = block >> 8;
> +	cmd->cdb[5] = block;

we have macros for that.

> +	cmd->cdb[7] = nblks >> 8;
> +	cmd->cdb[8] = nblks;

dito

	Regards
		Oliver
