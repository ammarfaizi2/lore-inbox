Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267344AbTBKIX1>; Tue, 11 Feb 2003 03:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267347AbTBKIX1>; Tue, 11 Feb 2003 03:23:27 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:54258 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267344AbTBKIXZ>; Tue, 11 Feb 2003 03:23:25 -0500
Date: Tue, 11 Feb 2003 00:34:53 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: "Randy.Dunlap" <randy.dunlap@verizon.net>
Cc: linux-kernel@vger.kernel.org, james.bottomley@steeleye.com,
       campbell@torque.net
Subject: Re: [PATCH] scsi/imm.c compile errors in 2.5.60
Message-ID: <20030211083453.GA6787@beaverton.ibm.com>
Mail-Followup-To: "Randy.Dunlap" <randy.dunlap@verizon.net>,
	linux-kernel@vger.kernel.org, james.bottomley@steeleye.com,
	campbell@torque.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E48932F.67DB9E55@verizon.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy,

It looks good. I cc'd David Campbell the listed maintainer
of the driver just to let him know of the update.

Randy.Dunlap [randy.dunlap@verizon.net] wrote:
> Hi,
> 
> I think this patch takes care of scsi/imm.c build errors
> in 2.5.60.
> 
> Please review and apply if correct.
> 
> For kernel bugzilla #330.
> 
> Thanks,
> ~Randy
> patch_name:	scsi-imm-2560.patch
> patch_version:	2003-02-10.22:00:51
> author:		Randy.Dunlap <rddunlap@osdl.org>
> description:	fix compile errors in scsi/imm.c
> product:	Linux
> product_versions: linux-2560
> changelog:	_
> URL:		_
> requires:	_
> conflicts:	_
> diffstat:	=
>  imm.c |   24 ++++++++++++------------
>  1 files changed, 12 insertions(+), 12 deletions(-)
> 
> 
> diff -Naur ./drivers/scsi/imm.c%BUILD ./drivers/scsi/imm.c
> --- ./drivers/scsi/imm.c%BUILD	Mon Feb 10 10:39:00 2003
> +++ ./drivers/scsi/imm.c	Mon Feb 10 21:58:34 2003
> @@ -733,7 +733,7 @@
>  
>  static inline int imm_send_command(Scsi_Cmnd * cmd)
>  {
> -    int host_no = cmd->host->unique_id;
> +    int host_no = cmd->device->host->unique_id;
>      int k;
>  
>      /* NOTE: IMM uses byte pairs */
> @@ -758,7 +758,7 @@
>       *  0     Told to schedule
>       *  1     Finished data transfer
>       */
> -    int host_no = cmd->host->unique_id;
> +    int host_no = cmd->device->host->unique_id;
>      unsigned short ppb = IMM_BASE(host_no);
>      unsigned long start_jiffies = jiffies;
>  
> @@ -845,7 +845,7 @@
>  int imm_command(Scsi_Cmnd * cmd)
>  {
>      static int first_pass = 1;
> -    int host_no = cmd->host->unique_id;
> +    int host_no = cmd->device->host->unique_id;
>  
>      if (first_pass) {
>  	printk("imm: using non-queuing interface\n");
> @@ -867,7 +867,7 @@
>  	schedule();
>  
>      if (cmd->SCp.phase)		/* Only disconnect if we have connected */
> -	imm_disconnect(cmd->host->unique_id);
> +	imm_disconnect(cmd->device->host->unique_id);
>  
>      imm_pb_release(host_no);
>      imm_hosts[host_no].cur_cmd = 0;
> @@ -883,7 +883,7 @@
>  {
>      imm_struct *tmp = (imm_struct *) data;
>      Scsi_Cmnd *cmd = tmp->cur_cmd;
> -    struct Scsi_Host *host = cmd->host;
> +    struct Scsi_Host *host = cmd->device->host;
>      unsigned long flags;
>  
>      if (!cmd) {
> @@ -930,9 +930,9 @@
>  #endif
>  
>      if (cmd->SCp.phase > 1)
> -	imm_disconnect(cmd->host->unique_id);
> +	imm_disconnect(cmd->device->host->unique_id);
>      if (cmd->SCp.phase > 0)
> -	imm_pb_release(cmd->host->unique_id);
> +	imm_pb_release(cmd->device->host->unique_id);
>  
>      spin_lock_irqsave(host->host_lock, flags);
>      tmp->cur_cmd = 0;
> @@ -943,7 +943,7 @@
>  
>  static int imm_engine(imm_struct * tmp, Scsi_Cmnd * cmd)
>  {
> -    int host_no = cmd->host->unique_id;
> +    int host_no = cmd->device->host->unique_id;
>      unsigned short ppb = IMM_BASE(host_no);
>      unsigned char l = 0, h = 0;
>      int retv, x;
> @@ -972,7 +972,7 @@
>  
>  	/* Phase 2 - We are now talking to the scsi bus */
>      case 2:
> -	if (!imm_select(host_no, cmd->target)) {
> +	if (!imm_select(host_no, cmd->device->id)) {
>  	    imm_fail(host_no, DID_NO_CONNECT);
>  	    return 0;
>  	}
> @@ -1082,7 +1082,7 @@
>  
>  int imm_queuecommand(Scsi_Cmnd * cmd, void (*done) (Scsi_Cmnd *))
>  {
> -    int host_no = cmd->host->unique_id;
> +    int host_no = cmd->device->host->unique_id;
>  
>      if (imm_hosts[host_no].cur_cmd) {
>  	printk("IMM: bug in imm_queuecommand\n");
> @@ -1125,7 +1125,7 @@
>  
>  int imm_abort(Scsi_Cmnd * cmd)
>  {
> -    int host_no = cmd->host->unique_id;
> +    int host_no = cmd->device->host->unique_id;
>      /*
>       * There is no method for aborting commands since Iomega
>       * have tied the SCSI_MESSAGE line high in the interface
> @@ -1157,7 +1157,7 @@
>  
>  int imm_reset(Scsi_Cmnd * cmd)
>  {
> -    int host_no = cmd->host->unique_id;
> +    int host_no = cmd->device->host->unique_id;
>  
>      if (cmd->SCp.phase)
>  	imm_disconnect(host_no);

-andmike
--
Michael Anderson
andmike@us.ibm.com

