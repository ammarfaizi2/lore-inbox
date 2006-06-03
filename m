Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932617AbWFCLb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617AbWFCLb3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 07:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbWFCLb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 07:31:29 -0400
Received: from verein.lst.de ([213.95.11.210]:59095 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932612AbWFCLb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 07:31:27 -0400
Date: Sat, 3 Jun 2006 13:31:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: jejb@steeleye.com
Cc: fischer@norbit.de, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH, RFC] hide EH backup data outside the scsi_cmnd
Message-ID: <20060603113119.GA17213@lst.de>
References: <20060603112610.GB17018@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060603112610.GB17018@lst.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -0.6 () BAYES_01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should have gone to linux-scsi of course.  Fup'to to -scsi instead
of -kernel please.

On Sat, Jun 03, 2006 at 01:26:10PM +0200, Christoph Hellwig wrote:
> Currently struct scsi_cmnd has various fields that are used to backup
> original data after the corresponding fields have been overridden for
> EH commands.  This means drivers can easily get at it and misuse it.
> Due to the old_ naming this doesn't happen for most of them, but two
> that have different names have been used wrong a lot (see previous
> patch).  Another downside is that they unessecarily bloat the scsi_cmnd
> size.
> 
> This patch moves them onstack in scsi_send_eh_cmnd to fix those two
> issues above.
> 
> Note that this breaks the aha152x and 53x700 drivers because they're
> plaing with those fields internally.
> 
> J"urgen and James, could you take a look at whether it's feasible to
> fix those drivers?
> 
> Otherwise any comments on the general approach?
> 
> (Note:  you probably want the patch to remove the wrong buffer and
>  bufflen patches applied before this, else lots of drivers will stop
>  compiling)
> 
> Index: scsi-misc-2.6/drivers/scsi/scsi_error.c
> ===================================================================
> --- scsi-misc-2.6.orig/drivers/scsi/scsi_error.c	2006-06-02 18:20:23.000000000 +0200
> +++ scsi-misc-2.6/drivers/scsi/scsi_error.c	2006-06-03 12:31:05.000000000 +0200
> @@ -438,19 +438,67 @@
>   * Return value:
>   *    SUCCESS or FAILED or NEEDS_RETRY
>   **/
> -static int scsi_send_eh_cmnd(struct scsi_cmnd *scmd, int timeout)
> +static int scsi_send_eh_cmnd(struct scsi_cmnd *scmd, int timeout, int copy_sense)
>  {
>  	struct scsi_device *sdev = scmd->device;
>  	struct Scsi_Host *shost = sdev->host;
> +	int old_result = scmd->result;
>  	DECLARE_COMPLETION(done);
>  	unsigned long timeleft;
>  	unsigned long flags;
> +	unsigned char old_cmnd[MAX_COMMAND_SIZE];
> +	enum dma_data_direction old_data_direction;
> +	unsigned short old_use_sg;
> +	unsigned char old_cmd_len;
> +	unsigned old_bufflen;
> +	void *old_buffer;
>  	int rtn;
>  
> +	/*
> +	 * We need saved copies of a number of fields - this is because
> +	 * error handling may need to overwrite these with different values
> +	 * to run different commands, and once error handling is complete,
> +	 * we will need to restore these values prior to running the actual
> +	 * command.
> +	 */
> +	old_buffer = scmd->request_buffer;
> +	old_bufflen = scmd->request_bufflen;
> +	memcpy(old_cmnd, scmd->cmnd, sizeof(scmd->cmnd));
> +	old_data_direction = scmd->sc_data_direction;
> +	old_cmd_len = scmd->cmd_len;
> +	old_use_sg = scmd->use_sg;
> +
> +	if (copy_sense) {
> +		int gfp_mask = GFP_ATOMIC;
> +
> +		if (shost->hostt->unchecked_isa_dma)
> +			gfp_mask |= __GFP_DMA;
> +
> +		scmd->sc_data_direction = DMA_FROM_DEVICE;
> +		scmd->request_bufflen = 252;
> +		scmd->request_buffer = kzalloc(scmd->request_bufflen, gfp_mask);
> +		if (!scmd->request_buffer)
> +			return FAILED;
> +	} else {
> +		scmd->request_buffer = NULL;
> +		scmd->request_bufflen = 0;
> +		scmd->sc_data_direction = DMA_NONE;
> +	}
> +
> +	scmd->underflow = 0;
> +	scmd->use_sg = 0;
> +	scmd->cmd_len = COMMAND_SIZE(scmd->cmnd[0]);
> +
>  	if (sdev->scsi_level <= SCSI_2)
>  		scmd->cmnd[1] = (scmd->cmnd[1] & 0x1f) |
>  			(sdev->lun << 5 & 0xe0);
>  
> +	/*
> +	 * Zero the sense buffer.  The scsi spec mandates that any
> +	 * untransferred sense data should be interpreted as being zero.
> +	 */
> +	memset(scmd->sense_buffer, 0, sizeof(scmd->sense_buffer));
> +
>  	shost->eh_action = &done;
>  	scmd->request->rq_status = RQ_SCSI_BUSY;
>  
> @@ -502,6 +550,27 @@
>  		rtn = FAILED;
>  	}
>  
> +
> +	/*
> +	 * Last chance to have valid sense data.
> +	 */
> +	if (copy_sense && !SCSI_SENSE_VALID(scmd)) {
> +		memcpy(scmd->sense_buffer, scmd->request_buffer,
> +		       sizeof(scmd->sense_buffer));
> +		kfree(scmd->request_buffer);
> +	}
> +
> +
> +	/*
> +	 * Restore original data
> +	 */
> +	scmd->request_buffer = old_buffer;
> +	scmd->request_bufflen = old_bufflen;
> +	memcpy(scmd->cmnd, old_cmnd, sizeof(scmd->cmnd));
> +	scmd->sc_data_direction = old_data_direction;
> +	scmd->cmd_len = old_cmd_len;
> +	scmd->use_sg = old_use_sg;
> +	scmd->result = old_result;
>  	return rtn;
>  }
>  
> @@ -517,56 +586,10 @@
>  static int scsi_request_sense(struct scsi_cmnd *scmd)
>  {
>  	static unsigned char generic_sense[6] =
> -	{REQUEST_SENSE, 0, 0, 0, 252, 0};
> -	unsigned char *scsi_result;
> -	int saved_result;
> -	int rtn;
> +		{REQUEST_SENSE, 0, 0, 0, 252, 0};
>  
>  	memcpy(scmd->cmnd, generic_sense, sizeof(generic_sense));
> -
> -	scsi_result = kmalloc(252, GFP_ATOMIC | ((scmd->device->host->hostt->unchecked_isa_dma) ? __GFP_DMA : 0));
> -
> -
> -	if (unlikely(!scsi_result)) {
> -		printk(KERN_ERR "%s: cannot allocate scsi_result.\n",
> -		       __FUNCTION__);
> -		return FAILED;
> -	}
> -
> -	/*
> -	 * zero the sense buffer.  some host adapters automatically always
> -	 * request sense, so it is not a good idea that
> -	 * scmd->request_buffer and scmd->sense_buffer point to the same
> -	 * address (db).  0 is not a valid sense code. 
> -	 */
> -	memset(scmd->sense_buffer, 0, sizeof(scmd->sense_buffer));
> -	memset(scsi_result, 0, 252);
> -
> -	saved_result = scmd->result;
> -	scmd->request_buffer = scsi_result;
> -	scmd->request_bufflen = 252;
> -	scmd->use_sg = 0;
> -	scmd->cmd_len = COMMAND_SIZE(scmd->cmnd[0]);
> -	scmd->sc_data_direction = DMA_FROM_DEVICE;
> -	scmd->underflow = 0;
> -
> -	rtn = scsi_send_eh_cmnd(scmd, SENSE_TIMEOUT);
> -
> -	/* last chance to have valid sense data */
> -	if(!SCSI_SENSE_VALID(scmd)) {
> -		memcpy(scmd->sense_buffer, scmd->request_buffer,
> -		       sizeof(scmd->sense_buffer));
> -	}
> -
> -	kfree(scsi_result);
> -
> -	/*
> -	 * when we eventually call scsi_finish, we really wish to complete
> -	 * the original request, so let's restore the original data. (db)
> -	 */
> -	scsi_setup_cmd_retry(scmd);
> -	scmd->result = saved_result;
> -	return rtn;
> +	return scsi_send_eh_cmnd(scmd, SENSE_TIMEOUT, 1);
>  }
>  
>  /**
> @@ -585,12 +608,6 @@
>  {
>  	scmd->device->host->host_failed--;
>  	scmd->eh_eflags = 0;
> -
> -	/*
> -	 * set this back so that the upper level can correctly free up
> -	 * things.
> -	 */
> -	scsi_setup_cmd_retry(scmd);
>  	list_move_tail(&scmd->eh_entry, done_q);
>  }
>  EXPORT_SYMBOL(scsi_eh_finish_cmd);
> @@ -695,47 +712,26 @@
>  {
>  	static unsigned char tur_command[6] = {TEST_UNIT_READY, 0, 0, 0, 0, 0};
>  	int retry_cnt = 1, rtn;
> -	int saved_result;
>  
>  retry_tur:
>  	memcpy(scmd->cmnd, tur_command, sizeof(tur_command));
>  
> -	/*
> -	 * zero the sense buffer.  the scsi spec mandates that any
> -	 * untransferred sense data should be interpreted as being zero.
> -	 */
> -	memset(scmd->sense_buffer, 0, sizeof(scmd->sense_buffer));
>  
> -	saved_result = scmd->result;
> -	scmd->request_buffer = NULL;
> -	scmd->request_bufflen = 0;
> -	scmd->use_sg = 0;
> -	scmd->cmd_len = COMMAND_SIZE(scmd->cmnd[0]);
> -	scmd->underflow = 0;
> -	scmd->sc_data_direction = DMA_NONE;
> +	rtn = scsi_send_eh_cmnd(scmd, SENSE_TIMEOUT, 0);
>  
> -	rtn = scsi_send_eh_cmnd(scmd, SENSE_TIMEOUT);
> -
> -	/*
> -	 * when we eventually call scsi_finish, we really wish to complete
> -	 * the original request, so let's restore the original data. (db)
> -	 */
> -	scsi_setup_cmd_retry(scmd);
> -	scmd->result = saved_result;
> -
> -	/*
> -	 * hey, we are done.  let's look to see what happened.
> -	 */
>  	SCSI_LOG_ERROR_RECOVERY(3, printk("%s: scmd %p rtn %x\n",
>  		__FUNCTION__, scmd, rtn));
> -	if (rtn == SUCCESS)
> -		return 0;
> -	else if (rtn == NEEDS_RETRY) {
> +
> +	switch (rtn) {
> +	case NEEDS_RETRY:
>  		if (retry_cnt--)
>  			goto retry_tur;
> +		/*FALLTHRU*/
> +	case SUCCESS:
>  		return 0;
> +	default:
> +		return 1;
>  	}
> -	return 1;
>  }
>  
>  /**
> @@ -817,44 +813,16 @@
>  static int scsi_eh_try_stu(struct scsi_cmnd *scmd)
>  {
>  	static unsigned char stu_command[6] = {START_STOP, 0, 0, 0, 1, 0};
> -	int rtn;
> -	int saved_result;
> -
> -	if (!scmd->device->allow_restart)
> -		return 1;
> -
> -	memcpy(scmd->cmnd, stu_command, sizeof(stu_command));
> -
> -	/*
> -	 * zero the sense buffer.  the scsi spec mandates that any
> -	 * untransferred sense data should be interpreted as being zero.
> -	 */
> -	memset(scmd->sense_buffer, 0, sizeof(scmd->sense_buffer));
>  
> -	saved_result = scmd->result;
> -	scmd->request_buffer = NULL;
> -	scmd->request_bufflen = 0;
> -	scmd->use_sg = 0;
> -	scmd->cmd_len = COMMAND_SIZE(scmd->cmnd[0]);
> -	scmd->underflow = 0;
> -	scmd->sc_data_direction = DMA_NONE;
> +	if (scmd->device->allow_restart) {
> +		int rtn;
>  
> -	rtn = scsi_send_eh_cmnd(scmd, START_UNIT_TIMEOUT);
> -
> -	/*
> -	 * when we eventually call scsi_finish, we really wish to complete
> -	 * the original request, so let's restore the original data. (db)
> -	 */
> -	scsi_setup_cmd_retry(scmd);
> -	scmd->result = saved_result;
> +		memcpy(scmd->cmnd, stu_command, sizeof(stu_command));
> +		rtn = scsi_send_eh_cmnd(scmd, START_UNIT_TIMEOUT, 0);
> +		if (rtn == SUCCESS)
> +			return 0;
> +	}
>  
> -	/*
> -	 * hey, we are done.  let's look to see what happened.
> -	 */
> -	SCSI_LOG_ERROR_RECOVERY(3, printk("%s: scmd %p rtn %x\n",
> -		__FUNCTION__, scmd, rtn));
> -	if (rtn == SUCCESS)
> -		return 0;
>  	return 1;
>  }
>  
> @@ -1663,8 +1631,6 @@
>      
>  	scmd->scsi_done		= scsi_reset_provider_done_command;
>  	scmd->done			= NULL;
> -	scmd->buffer			= NULL;
> -	scmd->bufflen			= 0;
>  	scmd->request_buffer		= NULL;
>  	scmd->request_bufflen		= 0;
>  
> Index: scsi-misc-2.6/drivers/scsi/scsi_lib.c
> ===================================================================
> --- scsi-misc-2.6.orig/drivers/scsi/scsi_lib.c	2006-06-02 18:20:23.000000000 +0200
> +++ scsi-misc-2.6/drivers/scsi/scsi_lib.c	2006-06-03 12:31:05.000000000 +0200
> @@ -502,60 +502,16 @@
>   *
>   * Arguments:   cmd	- command that is ready to be queued.
>   *
> - * Returns:     Nothing
> - *
>   * Notes:       This function has the job of initializing a number of
>   *              fields related to error handling.   Typically this will
>   *              be called once for each command, as required.
>   */
> -static int scsi_init_cmd_errh(struct scsi_cmnd *cmd)
> +static void scsi_init_cmd_errh(struct scsi_cmnd *cmd)
>  {
>  	cmd->serial_number = 0;
> -
>  	memset(cmd->sense_buffer, 0, sizeof cmd->sense_buffer);
> -
>  	if (cmd->cmd_len == 0)
>  		cmd->cmd_len = COMMAND_SIZE(cmd->cmnd[0]);
> -
> -	/*
> -	 * We need saved copies of a number of fields - this is because
> -	 * error handling may need to overwrite these with different values
> -	 * to run different commands, and once error handling is complete,
> -	 * we will need to restore these values prior to running the actual
> -	 * command.
> -	 */
> -	cmd->old_use_sg = cmd->use_sg;
> -	cmd->old_cmd_len = cmd->cmd_len;
> -	cmd->sc_old_data_direction = cmd->sc_data_direction;
> -	cmd->old_underflow = cmd->underflow;
> -	memcpy(cmd->data_cmnd, cmd->cmnd, sizeof(cmd->cmnd));
> -	cmd->buffer = cmd->request_buffer;
> -	cmd->bufflen = cmd->request_bufflen;
> -
> -	return 1;
> -}
> -
> -/*
> - * Function:   scsi_setup_cmd_retry()
> - *
> - * Purpose:    Restore the command state for a retry
> - *
> - * Arguments:  cmd	- command to be restored
> - *
> - * Returns:    Nothing
> - *
> - * Notes:      Immediately prior to retrying a command, we need
> - *             to restore certain fields that we saved above.
> - */
> -void scsi_setup_cmd_retry(struct scsi_cmnd *cmd)
> -{
> -	memcpy(cmd->cmnd, cmd->data_cmnd, sizeof(cmd->data_cmnd));
> -	cmd->request_buffer = cmd->buffer;
> -	cmd->request_bufflen = cmd->bufflen;
> -	cmd->use_sg = cmd->old_use_sg;
> -	cmd->cmd_len = cmd->old_cmd_len;
> -	cmd->sc_data_direction = cmd->sc_old_data_direction;
> -	cmd->underflow = cmd->old_underflow;
>  }
>  
>  void scsi_device_unbusy(struct scsi_device *sdev)
> @@ -873,22 +829,13 @@
>   */
>  static void scsi_release_buffers(struct scsi_cmnd *cmd)
>  {
> -	struct request *req = cmd->request;
> -
> -	/*
> -	 * Free up any indirection buffers we allocated for DMA purposes. 
> -	 */
>  	if (cmd->use_sg)
>  		scsi_free_sgtable(cmd->request_buffer, cmd->sglist_len);
> -	else if (cmd->request_buffer != req->buffer)
> -		kfree(cmd->request_buffer);
>  
>  	/*
>  	 * Zero these out.  They now point to freed memory, and it is
>  	 * dangerous to hang onto the pointers.
>  	 */
> -	cmd->buffer  = NULL;
> -	cmd->bufflen = 0;
>  	cmd->request_buffer = NULL;
>  	cmd->request_bufflen = 0;
>  }
> @@ -925,7 +872,7 @@
>  			unsigned int block_bytes)
>  {
>  	int result = cmd->result;
> -	int this_count = cmd->bufflen;
> +	int this_count = cmd->request_bufflen;
>  	request_queue_t *q = cmd->device->request_queue;
>  	struct request *req = cmd->request;
>  	int clear_errors = 1;
> @@ -933,28 +880,14 @@
>  	int sense_valid = 0;
>  	int sense_deferred = 0;
>  
> -	/*
> -	 * Free up any indirection buffers we allocated for DMA purposes. 
> -	 * For the case of a READ, we need to copy the data out of the
> -	 * bounce buffer and into the real buffer.
> -	 */
> -	if (cmd->use_sg)
> -		scsi_free_sgtable(cmd->buffer, cmd->sglist_len);
> -	else if (cmd->buffer != req->buffer) {
> -		if (rq_data_dir(req) == READ) {
> -			unsigned long flags;
> -			char *to = bio_kmap_irq(req->bio, &flags);
> -			memcpy(to, cmd->buffer, cmd->bufflen);
> -			bio_kunmap_irq(to, &flags);
> -		}
> -		kfree(cmd->buffer);
> -	}
> +	scsi_release_buffers(cmd);
>  
>  	if (result) {
>  		sense_valid = scsi_command_normalize_sense(cmd, &sshdr);
>  		if (sense_valid)
>  			sense_deferred = scsi_sense_is_deferred(&sshdr);
>  	}
> +
>  	if (blk_pc_request(req)) { /* SG_IO ioctl from block level */
>  		req->errors = result;
>  		if (result) {
> @@ -975,15 +908,6 @@
>  	}
>  
>  	/*
> -	 * Zero these out.  They now point to freed memory, and it is
> -	 * dangerous to hang onto the pointers.
> -	 */
> -	cmd->buffer  = NULL;
> -	cmd->bufflen = 0;
> -	cmd->request_buffer = NULL;
> -	cmd->request_bufflen = 0;
> -
> -	/*
>  	 * Next deal with any sectors which we were able to correctly
>  	 * handle.
>  	 */
> @@ -1083,7 +1007,7 @@
>  			if (!(req->flags & REQ_QUIET)) {
>  				scmd_printk(KERN_INFO, cmd,
>  					   "Volume overflow, CDB: ");
> -				__scsi_print_command(cmd->data_cmnd);
> +				__scsi_print_command(cmd->cmnd);
>  				scsi_print_sense("", cmd);
>  			}
>  			scsi_end_request(cmd, 0, block_bytes, 1);
> @@ -1222,7 +1146,7 @@
>  	 * successfully. Since this is a REQ_BLOCK_PC command the
>  	 * caller should check the request's errors value
>  	 */
> -	scsi_io_completion(cmd, cmd->bufflen, 0);
> +	scsi_io_completion(cmd, cmd->request_bufflen, 0);
>  }
>  
>  static void scsi_setup_blk_pc_cmnd(struct scsi_cmnd *cmd)
> Index: scsi-misc-2.6/drivers/scsi/scsi.c
> ===================================================================
> --- scsi-misc-2.6.orig/drivers/scsi/scsi.c	2006-06-02 18:20:23.000000000 +0200
> +++ scsi-misc-2.6/drivers/scsi/scsi.c	2006-06-03 12:31:05.000000000 +0200
> @@ -420,7 +420,7 @@
>  			if (level > 3) {
>  				printk(KERN_INFO "buffer = 0x%p, bufflen = %d,"
>  				       " done = 0x%p, queuecommand 0x%p\n",
> -					cmd->buffer, cmd->bufflen,
> +					cmd->request_buffer, cmd->request_bufflen,
>  					cmd->done,
>  					sdev->host->hostt->queuecommand);
>  
> @@ -678,10 +678,7 @@
>  	cmd->use_sg = sreq->sr_use_sg;
>  
>  	cmd->request = sreq->sr_request;
> -	memcpy(cmd->data_cmnd, sreq->sr_cmnd, sizeof(cmd->data_cmnd));
>  	cmd->serial_number = 0;
> -	cmd->bufflen = sreq->sr_bufflen;
> -	cmd->buffer = sreq->sr_buffer;
>  	cmd->retries = 0;
>  	cmd->allowed = sreq->sr_allowed;
>  	cmd->done = sreq->sr_done;
> @@ -699,12 +696,8 @@
>  	memset(cmd->sense_buffer, 0, sizeof(sreq->sr_sense_buffer));
>  	cmd->request_buffer = sreq->sr_buffer;
>  	cmd->request_bufflen = sreq->sr_bufflen;
> -	cmd->old_use_sg = cmd->use_sg;
>  	if (cmd->cmd_len == 0)
>  		cmd->cmd_len = COMMAND_SIZE(cmd->cmnd[0]);
> -	cmd->old_cmd_len = cmd->cmd_len;
> -	cmd->sc_old_data_direction = cmd->sc_data_direction;
> -	cmd->old_underflow = cmd->underflow;
>  
>  	/*
>  	 * Start the timer ticking.
> @@ -784,11 +777,6 @@
>   */
>  int scsi_retry_command(struct scsi_cmnd *cmd)
>  {
> -	/*
> -	 * Restore the SCSI command state.
> -	 */
> -	scsi_setup_cmd_retry(cmd);
> -
>          /*
>           * Zero the sense information from the last time we tried
>           * this command.
> @@ -836,11 +824,6 @@
>  				"(result %x)\n", cmd->result));
>  
>  	/*
> -	 * We can get here with use_sg=0, causing a panic in the upper level
> -	 */
> -	cmd->use_sg = cmd->old_use_sg;
> -
> -	/*
>  	 * If there is an associated request structure, copy the data over
>  	 * before we call the completion function.
>  	 */
> Index: scsi-misc-2.6/include/scsi/scsi_cmnd.h
> ===================================================================
> --- scsi-misc-2.6.orig/include/scsi/scsi_cmnd.h	2006-06-03 12:07:51.000000000 +0200
> +++ scsi-misc-2.6/include/scsi/scsi_cmnd.h	2006-06-03 12:31:05.000000000 +0200
> @@ -64,9 +64,7 @@
>  	int timeout_per_command;
>  
>  	unsigned char cmd_len;
> -	unsigned char old_cmd_len;
>  	enum dma_data_direction sc_data_direction;
> -	enum dma_data_direction sc_old_data_direction;
>  
>  	/* These elements define the operation we are about to perform */
>  #define MAX_COMMAND_SIZE	16
> @@ -77,18 +75,11 @@
>  	void *request_buffer;		/* Actual requested buffer */
>  
>  	/* These elements define the operation we ultimately want to perform */
> -	unsigned char data_cmnd[MAX_COMMAND_SIZE];
> -	unsigned short old_use_sg;	/* We save  use_sg here when requesting
> -					 * sense info */
>  	unsigned short use_sg;	/* Number of pieces of scatter-gather */
>  	unsigned short sglist_len;	/* size of malloc'd scatter-gather list */
> -	unsigned bufflen;	/* Size of data buffer */
> -	void *buffer;		/* Data buffer */
>  
>  	unsigned underflow;	/* Return error if less than
>  				   this amount is transferred */
> -	unsigned old_underflow;	/* save underflow here when reusing the
> -				 * command for error handling */
>  
>  	unsigned transfersize;	/* How much we are guaranteed to
>  				   transfer with each SCSI transfer
> Index: scsi-misc-2.6/drivers/scsi/scsi_priv.h
> ===================================================================
> --- scsi-misc-2.6.orig/drivers/scsi/scsi_priv.h	2006-06-02 18:20:23.000000000 +0200
> +++ scsi-misc-2.6/drivers/scsi/scsi_priv.h	2006-06-03 12:31:05.000000000 +0200
> @@ -68,7 +68,6 @@
>  
>  /* scsi_lib.c */
>  extern int scsi_maybe_unblock_host(struct scsi_device *sdev);
> -extern void scsi_setup_cmd_retry(struct scsi_cmnd *cmd);
>  extern void scsi_device_unbusy(struct scsi_device *sdev);
>  extern int scsi_queue_insert(struct scsi_cmnd *cmd, int reason);
>  extern void scsi_next_command(struct scsi_cmnd *cmd);
> Index: scsi-misc-2.6/drivers/scsi/sd.c
> ===================================================================
> --- scsi-misc-2.6.orig/drivers/scsi/sd.c	2006-06-03 12:25:32.000000000 +0200
> +++ scsi-misc-2.6/drivers/scsi/sd.c	2006-06-03 12:31:05.000000000 +0200
> @@ -477,8 +477,7 @@
>  		SCpnt->cmnd[4] = (unsigned char) this_count;
>  		SCpnt->cmnd[5] = 0;
>  	}
> -	SCpnt->request_bufflen = SCpnt->bufflen =
> -			this_count * sdp->sector_size;
> +	SCpnt->request_bufflen = this_count * sdp->sector_size;
>  
>  	/*
>  	 * We shouldn't disconnect in the middle of a sector, so with a dumb
> Index: scsi-misc-2.6/drivers/scsi/sr.c
> ===================================================================
> --- scsi-misc-2.6.orig/drivers/scsi/sr.c	2006-06-03 12:25:32.000000000 +0200
> +++ scsi-misc-2.6/drivers/scsi/sr.c	2006-06-03 12:31:05.000000000 +0200
> @@ -360,7 +360,7 @@
>  				"mismatch count %d, bytes %d\n",
>  				size, SCpnt->request_bufflen);
>  			if (SCpnt->request_bufflen > size)
> -				SCpnt->request_bufflen = SCpnt->bufflen = size;
> +				SCpnt->request_bufflen = size;
>  		}
>  	}
>  
> @@ -387,8 +387,7 @@
>  
>  	if (this_count > 0xffff) {
>  		this_count = 0xffff;
> -		SCpnt->request_bufflen = SCpnt->bufflen =
> -				this_count * s_size;
> +		SCpnt->request_bufflen = this_count * s_size;
>  	}
>  
>  	SCpnt->cmnd[2] = (unsigned char) (block >> 24) & 0xff;
> Index: scsi-misc-2.6/drivers/scsi/aha152x.c
> ===================================================================
> --- scsi-misc-2.6.orig/drivers/scsi/aha152x.c	2006-06-02 18:20:22.000000000 +0200
> +++ scsi-misc-2.6/drivers/scsi/aha152x.c	2006-06-03 12:39:30.000000000 +0200
> @@ -1165,6 +1165,10 @@
>  	DECLARE_MUTEX_LOCKED(sem);
>  	struct timer_list timer;
>  	int ret, issued, disconnected;
> +	unsigned char old_cmd_len = SCpnt->cmd_len;
> +	unsigned short old_use_sg = SCpnt->use_sg;
> +	void *old_buffer = SCpnt->request_buffer;
> +	unsigned old_bufflen = SCpnt->request_bufflen;
>  	unsigned long flags;
>  
>  #if defined(AHA152X_DEBUG)
> @@ -1198,11 +1202,11 @@
>  	add_timer(&timer);
>  	down(&sem);
>  	del_timer(&timer);
> -	
> -	SCpnt->cmd_len         = SCpnt->old_cmd_len;
> -	SCpnt->use_sg          = SCpnt->old_use_sg;
> -  	SCpnt->request_buffer  = SCpnt->buffer;
> -       	SCpnt->request_bufflen = SCpnt->bufflen;
> +
> +	SCpnt->cmd_len         = old_cmd_len;
> +	SCpnt->use_sg          = old_use_sg;
> +  	SCpnt->request_buffer  = old_buffer;
> +       	SCpnt->request_bufflen = old_bufflen;
>  
>  	DO_LOCK(flags);
>  
---end quoted text---
