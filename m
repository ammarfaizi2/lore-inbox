Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVCNSZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVCNSZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 13:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVCNSZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 13:25:28 -0500
Received: from host-212-158-219-180.bulldogdsl.com ([212.158.219.180]:3020
	"EHLO aeryn.fluff.org.uk") by vger.kernel.org with ESMTP
	id S261719AbVCNSYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 13:24:47 -0500
Date: Mon, 14 Mar 2005 18:24:44 +0000
From: Ben Dooks <ben-linux@fluff.org>
To: Stefan Roas <sroas@roath.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Fix compiler warning in drivers/scsi/dpt_i2o.c
Message-ID: <20050314182444.GA6903@home.fluff.org>
References: <20050313224351.GA1731@roath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050313224351.GA1731@roath.org>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 13, 2005 at 11:43:51PM +0100, Stefan Roas wrote:
> Hi there!
> 
> The attachted patch fixes a compiler warning in drivers/scsi/dpt_i2o.c.
> 
> If you reply to this post, please CC me as I'm not suscribed to the
> list.

This patch looks suspiciously like it is sweeping the problem
`under the carpet`. Does bus_to_virt() return an `void __iomem *`?

reply should really be an `void __iomem *` 
 
> Best Regards
> 
> -- 
> Stefan Roas
> sroas@roath.org

> diff -rNu a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
> --- a/drivers/scsi/dpt_i2o.c	2005-03-02 14:01:26.910737000 +0100
> +++ b/drivers/scsi/dpt_i2o.c	2005-03-04 11:28:57.339003000 +0100
> @@ -2027,8 +2027,8 @@
>  		}
>  		reply = (ulong)bus_to_virt(m);
>  
> -		if (readl(reply) & MSG_FAIL) {
> -			u32 old_m = readl(reply+28); 
> +		if (readl((void *)reply) & MSG_FAIL) {
> +			u32 old_m = readl((void *)reply+28); 
>  			ulong msg;
>  			u32 old_context;
>  			PDEBUG("%s: Failed message\n",pHba->name);
> @@ -2039,34 +2039,34 @@
>  			}
>  			// Transaction context is 0 in failed reply frame
>  			msg = (ulong)(pHba->msg_addr_virt + old_m);
> -			old_context = readl(msg+12);
> +			old_context = readl((void *)msg+12);
>  			writel(old_context, reply+12);
>  			adpt_send_nop(pHba, old_m);
>  		} 
> -		context = readl(reply+8);
> +		context = readl((void *)reply+8);
>  		if(context & 0x40000000){ // IOCTL
> -			ulong p = (ulong)(readl(reply+12));
> +			ulong p = (ulong)(readl((void *)reply+12));
>  			if( p != 0) {
>  				memcpy((void*)p, (void*)reply, REPLY_FRAME_SIZE * 4);
>  			}
>  			// All IOCTLs will also be post wait
>  		}
>  		if(context & 0x80000000){ // Post wait message
> -			status = readl(reply+16);
> +			status = readl((void *)reply+16);
>  			if(status  >> 24){
>  				status &=  0xffff; /* Get detail status */
>  			} else {
>  				status = I2O_POST_WAIT_OK;
>  			}
>  			if(!(context & 0x40000000)) {
> -				cmd = (struct scsi_cmnd*) readl(reply+12); 
> +				cmd = (struct scsi_cmnd*) readl((void *)reply+12); 
>  				if(cmd != NULL) {
>  					printk(KERN_WARNING"%s: Apparent SCSI cmd in Post Wait Context - cmd=%p context=%x\n", pHba->name, cmd, context);
>  				}
>  			}
>  			adpt_i2o_post_wait_complete(context, status);
>  		} else { // SCSI message
> -			cmd = (struct scsi_cmnd*) readl(reply+12); 
> +			cmd = (struct scsi_cmnd*) readl((void *)reply+12); 
>  			if(cmd != NULL){
>  				if(cmd->serial_number != 0) { // If not timedout
>  					adpt_i2o_to_scsi(reply, cmd);
> @@ -2236,16 +2236,16 @@
>  	adpt_hba* pHba;
>  	u32 hba_status;
>  	u32 dev_status;
> -	u32 reply_flags = readl(reply) & 0xff00; // Leave it shifted up 8 bits 
> +	u32 reply_flags = readl((void *)reply) & 0xff00; // Leave it shifted up 8 bits 
>  	// I know this would look cleaner if I just read bytes
>  	// but the model I have been using for all the rest of the
>  	// io is in 4 byte words - so I keep that model
> -	u16 detailed_status = readl(reply+16) &0xffff;
> +	u16 detailed_status = readl((void *)reply+16) &0xffff;
>  	dev_status = (detailed_status & 0xff);
>  	hba_status = detailed_status >> 8;
>  
>  	// calculate resid for sg 
> -	cmd->resid = cmd->request_bufflen - readl(reply+5);
> +	cmd->resid = cmd->request_bufflen - readl((void *)reply+5);
>  
>  	pHba = (adpt_hba*) cmd->device->host->hostdata[0];
>  
> @@ -2256,7 +2256,7 @@
>  		case I2O_SCSI_DSC_SUCCESS:
>  			cmd->result = (DID_OK << 16);
>  			// handle underflow
> -			if(readl(reply+5) < cmd->underflow ) {
> +			if(readl((void *)reply+5) < cmd->underflow ) {
>  				cmd->result = (DID_ERROR <<16);
>  				printk(KERN_WARNING"%s: SCSI CMD underflow\n",pHba->name);
>  			}




-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
