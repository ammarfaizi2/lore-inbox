Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262478AbRENUXm>; Mon, 14 May 2001 16:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262476AbRENUXd>; Mon, 14 May 2001 16:23:33 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:65111
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S262475AbRENUXQ>; Mon, 14 May 2001 16:23:16 -0400
Date: Mon, 14 May 2001 22:23:06 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [NEW SCSI DRIVER] for 53c700 chip and NCR_D700 card against 2.4.4
Message-ID: <20010514222306.B840@jaquet.dk>
In-Reply-To: <200105121643.LAA01160@jet.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200105121643.LAA01160@jet.il.steeleye.com>; from James.Bottomley@HansenPartnership.com on Sat, May 12, 2001 at 11:43:04AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Disclaimer: I know nothing of this device/hw, the scsi protocol or
anything remotely applicable the functioning of this driver. The
stuff below is just nit-picking and PITA-ing :) Pro-active kernel
janitoring, if you like.

On Sat, May 12, 2001 at 11:43:04AM -0500, James Bottomley wrote:
[...]
> +struct Scsi_Host * __init
> +NCR_700_detect(Scsi_Host_Template *tpnt,
> +	       struct NCR_700_Host_Parameters *hostdata)
> +{
> +	__u32 *script = kmalloc(sizeof(SCRIPT), GFP_KERNEL);
> +	__u32 pScript;
> +	struct Scsi_Host *host;
> +	static int banner = 0;
> +	int j;
> +
[...]
> +
> +	host = scsi_register(tpnt, 4);
> +	if(script == NULL) {
> +		printk(KERN_ERR "53c700: Failed to allocate script, detatching\n");
> +		scsi_unregister(host);
> +		return NULL;
> +	}

You are not checking if the scsi_register went ok or not.

[...] 
> +STATIC void 
> +free_slot(struct NCR_700_command_slot *slot,
> +	  struct NCR_700_Host_Parameters *hostdata)
> +{
> +	int hash;
> +	struct NCR_700_command_slot **forw, **back;
> +
> +
> +	if((slot->state & NCR_700_SLOT_MASK) != NCR_700_SLOT_MAGIC) {
> +		printk(" SLOT %p is not MAGIC!!!\n", slot);
> +	}
> +	if(slot->state == NCR_700_SLOT_FREE) {
> +		printk(" SLOT %p is FREE!!!\n", slot);
> +	}

Could you be persuaded to add KERN_SOMETHING to the printks above?

[...]
> +STATIC __u32
> +process_extended_message(struct Scsi_Host *host, 
> +			 struct NCR_700_Host_Parameters *hostdata,
> +			 Scsi_Cmnd *SCp, __u32 dsp, __u32 dsps)
> +{
> +	__u32 resume_offset = dsp, temp = dsp + 8;
> +	__u8 pun = 0xff, lun = 0xff;
> +
> +	if(SCp != NULL) {
> +		pun = SCp->target;
> +		lun = SCp->lun;
> +	}
> +
> +	switch(hostdata->msgin[2]) {
[...]
> +
> +	default:
> +		printk(KERN_INFO "scsi%d (%d:%d): Unexpected message %s: ",
> +		       host->host_no, pun, lun,
> +		       NCR_700_phase[(dsps & 0xf00) >> 8]);
> +		print_msg(hostdata->msgin);
> +		printk("\n");

It would be nice with a KERN_XX before "\n" (yes, I recognize that
print_msg does not do this :( )

[...]
> +STATIC __u32
> +process_script_interrupt(__u32 dsps, __u32 dsp, Scsi_Cmnd *SCp,
> +			 struct Scsi_Host *host,
> +			 struct NCR_700_Host_Parameters *hostdata)
> +{

[...]
> +	} else if((dsps & 0xfffff0f0) == A_UNEXPECTED_PHASE) {
> +		__u8 i = (dsps & 0xf00) >> 8;
> +
> +		printk(KERN_ERR "scsi%d: (%d:%d), UNEXPECTED PHASE %s (%s)\n",
> +		       host->host_no, pun, lun,
> +		       NCR_700_phase[i],
> +		       sbcl_to_string(inb(host->base + SBCL_REG)));
> +		printk("         len = %d, cmd =", SCp->cmd_len);

A KERN_ERR prefix?

[...]
> +	retry:
> +		if(slot == NULL) {
> +			struct NCR_700_command_slot *s = find_ITL_Nexus(hostdata, reselection_id, lun);
> +			printk(KERN_ERR "scsi%d: (%d:%d) RESELECTED but no saved command (MSG = %02x %02x %02x)!!\n",
> +			       host->host_no, reselection_id, lun,
> +			       hostdata->msgin[0], hostdata->msgin[1],
> +			       hostdata->msgin[2]);
> +			printk(KERN_ERR " OUTSTANDING TAGS:");
> +			while(s != NULL) {
> +				if(s->cmnd->target == reselection_id &&
> +				   s->cmnd->lun == lun) {
> +					printk("%d ", s->tag);

KERN_ERR?

> +					if(s->tag == hostdata->msgin[2]) {
> +						printk(" ***FOUND*** \n");

As above.

> +						slot = s;
> +						goto retry;
> +					}
> +						
> +				}
> +				s = s->ITL_back;
> +			}
> +			printk("\n");

KERN_ERR?

[...]
> +void
> +NCR_700_intr(int irq, void *dev_id, struct pt_regs *regs)
> +{
[...]
> +			if(dsp == Ent_SendMessage + 8 + hostdata->pScript) {
> +				/* It wants to reply to some part of
> +				 * our message */
> +				__u32 temp = inl(host->base + TEMP_REG);
> +
> +				int count = (hostdata->script[Ent_SendMessage/4] & 0xffffff) - ((inl(host->base + DBC_REG) & 0xffffff) + NCR_700_data_residual(host));
> +				printk("scsi%d (%d:%d) PHASE MISMATCH IN SEND MESSAGE %d remain, return %p[%04x], phase %s\n", host->host_no, pun, lun, count, (void *)temp, temp - hostdata->pScript, sbcl_to_string(inb(host->base + SBCL_REG)));

KERN_ERR?

Also, some places you have KERN_ERR on debug output and some places
not. If you could be persuaded to put KERN_XX on the debug output too,
it would be nice (but not crucial).

[...]
> +
> +STATIC int
> +NCR_700_abort(Scsi_Cmnd * SCp)
> +{
> +	struct NCR_700_command_slot *slot;
> +	struct NCR_700_Host_Parameters *hostdata = 
> +		(struct NCR_700_Host_Parameters *)SCp->host->hostdata[0];
> +
> +	printk("scsi%d (%d:%d) New error handler wants to abort command\n\t",
> +	       SCp->host->host_no, SCp->target, SCp->lun);

KERN_XX?

[...]
> +
> +STATIC int
> +NCR_700_bus_reset(Scsi_Cmnd * SCp)
> +{
> +	printk("scsi%d (%d:%d) New error handler wants BUS reset, cmd %p\n\t",
> +	       SCp->host->host_no, SCp->target, SCp->lun, SCp);

KERN_XX?

> +	print_command(SCp->cmnd);
> +	NCR_700_internal_bus_reset(SCp->host);
> +	return SUCCESS;
> +}
> +
> +STATIC int
> +NCR_700_dev_reset(Scsi_Cmnd * SCp)
> +{
> +	printk("scsi%d (%d:%d) New error handler wants device reset\n\t",
> +	       SCp->host->host_no, SCp->target, SCp->lun);

KERN_XX?

> +	print_command(SCp->cmnd);
> +	
> +	return FAILED;
> +}
> +
> +STATIC int
> +NCR_700_host_reset(Scsi_Cmnd * SCp)
> +{
> +	printk("scsi%d (%d:%d) New error handler wants HOST reset\n\t",
> +	       SCp->host->host_no, SCp->target, SCp->lun);

KERN_XX?

> +	print_command(SCp->cmnd);
> +
> +	NCR_700_internal_bus_reset(SCp->host);
> +	NCR_700_chip_reset(SCp->host);
> +	return SUCCESS;
> +}

[...]
+STATIC int __init
+D700_detect(Scsi_Host_Template *tpnt)
+{
+       int slot = 0;
+       int found = 0;
+       int differential;
+       int banner = 1;
[...]
+                       if(hostdata == NULL) {
+                               printk(KERN_ERR "NCR D700: Failed to allocate
+host data for channel %d, detatching\n", i);
+                               continue;
+                       }
+                       memset(hostdata, 0, sizeof(struct
+NCR_700_Host_Parameters));
+                       request_region(region, 64, "NCR_D700");

Would you be kind enough to check the return code of the request_region?

+                       /* Fill in the three required pieces of hostdata */
+                       hostdata->base = region;
+                       hostdata->differential = (((1<<i) & differential) != 0);+                       hostdata->clock = NCR_D700_CLOCK_MHZ;
+                       /* and register the chip */
+                       if((host = NCR_700_detect(tpnt, hostdata)) == NULL) {
+                               kfree(hostdata);
+                               continue;
+                       }

...and to release it in your error paths?

+                       host->irq = irq;
+                       /* FIXME: Read this from SUS */
+                       host->this_id = id_array[slot * 2 + i];
+                       printk(KERN_NOTICE "NCR D700: SIOP%d, SCSI id is %d\n",
+                              i, host->this_id);
+                       if(request_irq(irq, NCR_700_intr, SA_SHIRQ, "NCR_D700",
+host)) {
+                               printk(KERN_ERR "NCR D700, channel %d: irq
+problem, detatching\n", i);
+                               NCR_700_release(host);
+                               release_region(host->base, 64);
+                               continue;
+                       }

You need to kfree(hostdata) here. I would also recommend putting
a scsi_unregister into NCR_700_release since you need to balance
the scsi_register done in NCR_700_detect.

I recommend using forward gotos in your error paths for sanity.
There can be used with loops&continues as well and will help you
not have these resource leaks (across local scope anyway) since
you have two function exit points: The normal one and the error
one (you can collapse these to one exit path if you care strongly
about this).

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

Which is worse: Ignorance or Apathy?
Who knows? Who cares?
