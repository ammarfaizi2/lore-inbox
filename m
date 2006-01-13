Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161603AbWAMA1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161603AbWAMA1R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 19:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161604AbWAMA1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 19:27:16 -0500
Received: from xenotime.net ([66.160.160.81]:46260 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161603AbWAMA1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 19:27:16 -0500
Date: Thu, 12 Jan 2006 16:27:13 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: linux-kernel@vger.kernel.org
cc: erich@areca.com.tw, akpm@osdl.org
Subject: Re: + areca-raid-driver-arcmsr-update2.patch added to -mm tree
In-Reply-To: <200601120312.k0C3Cw80026379@shell0.pdx.osdl.net>
Message-ID: <Pine.LNX.4.58.0601111917570.21722@shark.he.net>
References: <200601120312.k0C3Cw80026379@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2006 akpm@osdl.org wrote:

> The patch titled
>      Areca RAID driver (arcmsr) update2
> has been added to the -mm tree.  Its filename is
>      areca-raid-driver-arcmsr-update2.patch
>
> From: "erich" <erich@areca.com.tw>
>
> The arcmsr patch file update2 works for:
>
> 1. use printk levels
> 2. change pPCI_DEV bad naming into pci_device
> 3. delete some unreadable comments
> 4. try to fit source files into 80 columns (lots fixed, lots to go)
> 5. Tab size in Linux kernel is 8 (not less).
> 6. Put changelog comments in Documentation/scsi/ChangeLog.arcmsr
>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
>
>  drivers/scsi/arcmsr/arcmsr.c        | 2827 +++++++-------
>  drivers/scsi/arcmsr/arcmsr.h        | 5043 ++++----------------------
>  4 files changed, 2289 insertions(+), 5775 deletions(-)
>
> diff -puN drivers/scsi/arcmsr/arcmsr.c~areca-raid-driver-arcmsr-update2 drivers/scsi/arcmsr/arcmsr.c
> --- devel/drivers/scsi/arcmsr/arcmsr.c~areca-raid-driver-arcmsr-update2	2006-01-11 19:05:35.000000000 -0800
> +++ devel-akpm/drivers/scsi/arcmsr/arcmsr.c	2006-01-11 19:05:35.000000000 -0800
> @@ -99,7 +52,6 @@
>  #include <linux/errno.h>
>  #include <linux/types.h>
>  #include <linux/delay.h>
> -#include <linux/dma-mapping.h>

Why delete this include?  Some constants from it are used in arcmsr.c.

>  #include <linux/timer.h>
>  #include <linux/pci.h>
>  #include <asm/dma.h>
> +*******************************************************************************
>  */
> -static uint8_t arcmsr_adapterCnt = 0;
> +static uint8_t arcmsr_adapterCnt=0;

The first way (with spaces around the '=') is preferred AFAIK.
(in MANY places)
However, static data does not need to be init to 0.

> +static int arcmsr_initialize(struct ACB *pACB,struct pci_dev *pci_device);
> +static int arcmsr_iop_ioctlcmd(struct ACB *pACB,int ioctl_cmd,void *arg);

Please use spaces after ','.

>  static int arcmsr_release(struct Scsi_Host *);
> -static int arcmsr_queue_command(struct scsi_cmnd *cmd,
> -				void (*done) (struct scsi_cmnd *));
>  static int arcmsr_cmd_abort(struct scsi_cmnd *);
>  static int arcmsr_bus_reset(struct scsi_cmnd *);
> -static int arcmsr_ioctl(struct scsi_device *dev, int ioctl_cmd, void __user *arg);
> -static int __devinit arcmsr_device_probe(struct pci_dev *pPCI_DEV,
> -					 const struct pci_device_id *id);
> -static void arcmsr_device_remove(struct pci_dev *pPCI_DEV);
> +static int arcmsr_ioctl(struct scsi_device * dev, int ioctl_cmd, void *arg);

Argh, what happened to the __user addition that makes sparse happy?
Did you run sparse on it yet?

> @@ -155,131 +108,167 @@ static irqreturn_t arcmsr_interrupt(stru
>  static uint8_t arcmsr_wait_msgint_ready(struct ACB *pACB);
> +*/
> +*/
> +static struct class_device_attribute arcmsr_firmware_info_attr=
> +{
> +	.attr={
> +		.name="firmware_info",
> +		.mode=S_IRUGO,
> +	},
> +	.show=arcmsr_show_firmware_info,

Would be much more readable with spaces around the '=' sign.
(in MANY places)

> +*/
>  */
> +*/
>  	}
> -	/* allocate scsi host information (includes our adapter)
> -	 * scsi_host_alloc==scsi_register */
> -	if ((host = scsi_host_alloc(&arcmsr_scsi_host_template,
> -			     sizeof(struct ACB))) == NULL) {
> -		printk("arcmsr%d: adapter probe: scsi_host_alloc error \n",
> -		       arcmsr_adapterCnt);
> +	if ((host=scsi_host_alloc(&arcmsr_scsi_host_template,
> +		sizeof(struct ACB)))==0) {

s/0/NULL/ for sparse

>  static int arcmsr_fops_open(struct inode *inode, struct file *filep)
>  {
> -	int i, minor;
> -	struct HCBARC *pHCBARC = &arcmsr_host_control_block;
> +	int i,minor;
> +	struct HCBARC *pHCBARC= &arcmsr_host_control_block;
>  	struct ACB *pACB;
>
> -	minor = MINOR(inode->i_rdev);
> -	if (minor >= pHCBARC->adapterCnt)
> -		return -ENXIO;
> -	for (i = 0; i < ARCMSR_MAX_ADAPTER; i++) {
> -		if ((pACB = pHCBARC->pACB[i]))
> -			if (pACB->adapter_index == minor)
> +	minor=MINOR(inode->i_rdev);
> +	if (minor >=pHCBARC->adapterCnt)
> +		return ENXIO;
> +	for(i=0;i<ARCMSR_MAX_ADAPTER;i++) {

Add some spaces, please.

> +		pACB=pHCBARC->pACB[i];
> +		if (pACB) {
> +			if (pACB->adapter_index==minor)
>  				break;
> +		}
>  	}
> -	if (i >= ARCMSR_MAX_ADAPTER)
> -		return -ENXIO;
> -	return 0;		/* success */
> +	if (i>=ARCMSR_MAX_ADAPTER)
> +		return ENXIO;
> +	return 0;/* success */
>  }
> -
>  static int arcmsr_fops_close(struct inode *inode, struct file *filep)
>  {
> -	int i, minor;
> -	struct HCBARC *pHCBARC = &arcmsr_host_control_block;
> +	int i,minor;
> +	struct HCBARC *pHCBARC= &arcmsr_host_control_block;
>  	struct ACB *pACB;
>
> -	minor = MINOR(inode->i_rdev);
> -	if (minor >= pHCBARC->adapterCnt)
> -		return -ENXIO;
> -	for (i = 0; i < ARCMSR_MAX_ADAPTER; i++) {
> -		if ((pACB = pHCBARC->pACB[i]))
> -			if (pACB->adapter_index == minor)
> +	minor=MINOR(inode->i_rdev);
> +	if (minor >=pHCBARC->adapterCnt)
> +		return ENXIO;
> +	for(i=0;i<ARCMSR_MAX_ADAPTER;i++) {

Needs spaces.

> +		pACB=pHCBARC->pACB[i];
> +		if (pACB) {
> +			if (pACB->adapter_index==minor)
>  				break;
> +		}
>  	}
> -	if (i >= ARCMSR_MAX_ADAPTER)
> -		return -ENXIO;
> +	if (i>=ARCMSR_MAX_ADAPTER)
> +		return ENXIO;
>  	return 0;
>  }
> -
>  static int arcmsr_fops_ioctl(struct inode *inode, struct file *filep,
> -			     unsigned int ioctl_cmd, unsigned long arg)
> +	unsigned int ioctl_cmd, unsigned long arg)
>  {
> -	int i, minor;
> -	struct HCBARC *pHCBARC = &arcmsr_host_control_block;
> +	int i,minor;
> +	struct HCBARC *pHCBARC= &arcmsr_host_control_block;
>  	struct ACB *pACB;
>
> -	minor = MINOR(inode->i_rdev);
> -	if (minor >= pHCBARC->adapterCnt)
> -		return -ENXIO;
> -	for (i = 0; i < ARCMSR_MAX_ADAPTER; i++) {
> -		if ((pACB = pHCBARC->pACB[i]))
> -			if (pACB->adapter_index == minor)
> +	minor=MINOR(inode->i_rdev);
> +	if (minor >=pHCBARC->adapterCnt)
> +		return ENXIO;
> +	for(i=0;i<ARCMSR_MAX_ADAPTER;i++) {

Spaces.

> +		pACB=pHCBARC->pACB[i];
> +		if (pACB) {
> +			if (pACB->adapter_index==minor)
>  				break;
> +		}
>  	}
> -	if (i >= ARCMSR_MAX_ADAPTER)
> -		return -ENXIO;
> -	/*
> -	 ************************************************************
> -	 ** We do not allow multi ioctls to the driver at the same time.
> -	 ************************************************************
> -	 */
> -	return arcmsr_iop_ioctlcmd(pACB, ioctl_cmd, (void __user *)arg);
> +	if (i>=ARCMSR_MAX_ADAPTER)
> +		return ENXIO;
> +	return arcmsr_iop_ioctlcmd(pACB,ioctl_cmd,(void *)arg);
>  }
> -
>  static void arcmsr_report_sense_info(struct CCB *pCCB)
>  {
> -	struct scsi_cmnd *pcmd = pCCB->pcmd;
> -	struct SENSE_DATA *psenseBuffer =
> -	    (struct SENSE_DATA *)pcmd->sense_buffer;
> +	struct scsi_cmnd *pcmd=pCCB->pcmd;
> +	struct SENSE_DATA *psenseBuffer=(struct SENSE_DATA *)pcmd->sense_buffer;
>
> -	pcmd->result = DID_OK << 16;
> +	pcmd->result=DID_OK << 16;
>  	if (psenseBuffer) {
> -		int sense_data_length =
> -		    sizeof(struct SENSE_DATA) <
> -		    sizeof(pcmd->
> -			   sense_buffer) ? sizeof(struct SENSE_DATA) :
> -		    sizeof(pcmd->sense_buffer);
> +		int sense_data_length=
> +			sizeof(struct SENSE_DATA) < sizeof(pcmd->sense_buffer)
> +			? sizeof(struct SENSE_DATA) : sizeof(pcmd->sense_buffer);
>  		memset(psenseBuffer, 0, sizeof(pcmd->sense_buffer));
> -		memcpy(psenseBuffer, pCCB->arcmsr_cdb.SenseData,
> -		       sense_data_length);
> -		psenseBuffer->ErrorCode = 0x70;
> -		psenseBuffer->Valid = 1;
> +		memcpy(psenseBuffer,pCCB->arcmsr_cdb.SenseData,sense_data_length);
> +		psenseBuffer->ErrorCode=0x70;

Better to use some named constant or define instead of magic numbers
like 0x70.

> +		psenseBuffer->Valid=1;
>  	}
>  }
> @@ -1141,240 +1120,214 @@ static void arcmsr_iop_parking(struct AC
> +*/
> +static int arcmsr_ioctl(struct scsi_device *dev,int ioctl_cmd,void *arg)
>  {
>  	struct ACB *pACB;
> -	struct HCBARC *pHCBARC = &arcmsr_host_control_block;
> -	int32_t match = 0x55AA, i;
> +	struct HCBARC *pHCBARC= &arcmsr_host_control_block;
> +	int32_t match=0x55AA,i;
>
> -	for (i = 0; i < ARCMSR_MAX_ADAPTER; i++) {
> -		if ((pACB = pHCBARC->pACB[i])) {
> -			if (pACB->host == dev->host) {
> -				match = i;
> +	for(i=0;i<ARCMSR_MAX_ADAPTER;i++) {

Spaces.

> +		pACB=pHCBARC->pACB[i];
> +		if (pACB) {
> +			if (pACB->host==dev->host) {
> +				match=i;
>  				break;
>  			}
>  		}
>  	}
> -	if (match == 0x55AA)
> -		return -ENXIO;
> +	if (match==0x55AA)
> +		return ENXIO;
>  	if (!arg)
>  		return -EINVAL;
> -
> -	return arcmsr_iop_ioctlcmd(pACB, ioctl_cmd, arg);
> +	return(arcmsr_iop_ioctlcmd(pACB,ioctl_cmd,arg));

Ugh.  I guess that there was some reason that this patch
reverts a lot of previous changes...?
and also makes some good changes.

> @@ -1431,145 +1386,150 @@ static struct CCB *arcmsr_get_freeccb(st
> +*/
>  static int arcmsr_seek_cmd2abort(struct scsi_cmnd *abortcmd)
>  {
> -	struct ACB *pACB = (struct ACB *)abortcmd->device->host->hostdata;
> +	struct ACB *pACB=(struct ACB *) abortcmd->device->host->hostdata;
>  	struct CCB *pCCB;
> -	uint32_t intmask_org, mask;
> -	int i = 0, pendingcount;
> +	uint32_t intmask_org,mask;
> +	int i=0,pendingcount;
>
>  	pACB->num_aborts++;
>  	/*
> -	 ******************************************************************
> -	 ** It is the upper layer do abort command this lock just prior to
> -	 ** calling us.
> -	 ** First determine if we currently own this command.
> -	 ** Start by searching the device queue. If not found
> -	 ** at all, and the system wanted us to just abort the
> -	 ** command return success.
> -	 ******************************************************************
> -	 */
> -	if (atomic_read(&pACB->ccboutstandingcount) != 0) {
> -		for (i = 0; i < ARCMSR_MAX_FREECCB_NUM; i++) {
> -			pCCB = pACB->pccb_pool[i];
> -			if (pCCB->startdone == ARCMSR_CCB_START) {
> -				if (pCCB->pcmd == abortcmd) {
> -					pCCB->startdone = ARCMSR_CCB_ABORTED;
> -					printk
> -					    ("arcmsr%d: scsi id=%d lun=%d abort ccb '0x%p' outstanding command \n",
> -					     pACB->adapter_index,
> -					     abortcmd->device->id,
> -					     abortcmd->device->lun, pCCB);
> +	*****************************************************************
> +	** It is the upper layer do abort command this lock just prior
> +	** to calling us.
> +	** First determine if we currently own this command.
> +	** Start by searching the device queue. If not found
> +	** at all,and the system wanted us to just abort the
> +	** command return success.
> +	*****************************************************************
> +	*/
> +	if (atomic_read(&pACB->ccboutstandingcount)!=0) {
> +		for(i=0;i<ARCMSR_MAX_FREECCB_NUM;i++) {

Spaces.

> +			pCCB=pACB->pccb_pool[i];
> +			if (pCCB->startdone==ARCMSR_CCB_START) {
> +				if (pCCB->pcmd==abortcmd) {
> +					pCCB->startdone=ARCMSR_CCB_ABORTED;
> +					printk(KERN_NOTICE
> +					"arcmsr%d: scsi id=%d lun=%d"
> +					" abort ccb '0x%p' outstanding command\n"
> +					,pACB->adapter_index
> +					,abortcmd->device->id
> +					,abortcmd->device->lun
> +					,pCCB);
>  					goto abort_outstanding_cmd;
>  				}
>  			}
>  		}
>  	}
>  	/*
> -	 **********************************************************
> -	 ** seek this command at our command list
> -	 ** if command found then remove, abort it and free this CCB
> -	 **********************************************************
> -	 */
> -	pendingcount = atomic_read(&pACB->ccbpendingcount);
> -	if (pendingcount > 0) {
> +	**********************************************************
> +	** seek this command at our command list
> +	** if command found then remove,abort it and free this CCB
> +	**********************************************************
> +	*/
> +	pendingcount=atomic_read(&pACB->ccbpendingcount);
> +	if (pendingcount>0) {
>  		do {
> -			pCCB = arcmsr_get_pendingccb(pACB);
> -			if (!pCCB)
> +			pCCB=arcmsr_get_pendingccb(pACB);
> +			if (pCCB==NULL)
>  				break;
> -			if (pCCB->pcmd == abortcmd) {
> -				printk
> -				    ("arcmsr%d: scsi id=%d lun=%d abort ccb '0x%p' pending command \n",
> -				     pACB->adapter_index, abortcmd->device->id,
> -				     abortcmd->device->lun, pCCB);
> -				pCCB->startdone = ARCMSR_CCB_ABORTED;
> -				pCCB->pcmd->result = DID_ABORT << 16;
> -				arcmsr_ccb_complete(pCCB, 0);
> +			if (pCCB->pcmd==abortcmd) {
> +				printk(KERN_NOTICE
> +					"arcmsr%d: scsi id=%d lun=%d"
> +					" abort ccb '0x%p' pending command \n"
> +					,pACB->adapter_index
> +					,abortcmd->device->id
> +					,abortcmd->device->lun
> +					,pCCB);
> +				pCCB->startdone=ARCMSR_CCB_ABORTED;
> +				pCCB->pcmd->result=DID_ABORT << 16;
> +				arcmsr_ccb_complete(pCCB,0);
>  				return SUCCESS;
>  			} else
> -				arcmsr_queue_pendingccb(pACB, pCCB);
> +				arcmsr_queue_pendingccb(pACB,pCCB);
>  		} while (pendingcount--);
>  	}
>  	return SUCCESS;
> -
>  abort_outstanding_cmd:
> -	msleep_interruptible(3000);	/* wait for 3 sec for all command done */
> +	/*wait for 3 sec for all command done*/
> +	msleep_interruptible(3000);
>  	/* disable all outbound interrupt */
> -	intmask_org = readl(&pACB->pmu->outbound_intmask);
> -	writel(intmask_org | ARCMSR_MU_OUTBOUND_ALL_INTMASKENABLE,
> -	       &pACB->pmu->outbound_intmask);
> -	arcmsr_polling_ccbdone(pACB, pCCB);
> +	intmask_org=readl(&pACB->pmu->outbound_intmask);
> +	writel(intmask_org|ARCMSR_MU_OUTBOUND_ALL_INTMASKENABLE
> +		,&pACB->pmu->outbound_intmask);
> +	arcmsr_polling_ccbdone(pACB,pCCB);
>  	/* enable all outbound interrupt */
> -	mask = ~(ARCMSR_MU_OUTBOUND_POSTQUEUE_INTMASKENABLE |
> -		ARCMSR_MU_OUTBOUND_DOORBELL_INTMASKENABLE);
> -	writel(intmask_org & mask, &pACB->pmu->outbound_intmask);
> +	mask=~(ARCMSR_MU_OUTBOUND_POSTQUEUE_INTMASKENABLE
> +			|ARCMSR_MU_OUTBOUND_DOORBELL_INTMASKENABLE);
> +	writel(intmask_org & mask,&pACB->pmu->outbound_intmask);
>  	return SUCCESS;
>  }
> +*/
> +*/
>  static int arcmsr_release(struct Scsi_Host *host)
>  {
>  	struct ACB *pACB;
> -	struct HCBARC *pHCBARC = &arcmsr_host_control_block;
> -	uint8_t match = 0xff, i;
> +	struct HCBARC *pHCBARC= &arcmsr_host_control_block;
> +	uint8_t match=0xff,i;
>
> -	if (!host)
> -		return -ENXIO;
> -	pACB = (struct ACB *)host->hostdata;
> +	if (host==NULL)
> +		return ENXIO;

Like this reversion.  Why?

> +	pACB=(struct ACB *)host->hostdata;
>  	if (!pACB)
> -		return -ENXIO;
> -
> -	for (i = 0; i < ARCMSR_MAX_ADAPTER; i++) {
> -		if (pHCBARC->pACB[i] == pACB)
> -			match = i;
> +		return ENXIO;
> +	for(i=0;i<ARCMSR_MAX_ADAPTER;i++) {
> +		if (pHCBARC->pACB[i]==pACB)
> +			match=i;
>  	}
> -	if (match == 0xff)
> -		return -ENXIO;
> -
> +	if (match==0xff)
> +		return ENXIO;
>  	arcmsr_pcidev_disattach(pACB);
> -	for (i = 0; i < ARCMSR_MAX_ADAPTER; i++) {
> +	for(i=0;i<ARCMSR_MAX_ADAPTER;i++) {

Spaces.

>  		if (pHCBARC->pACB[i])
>  			return 0;
>  	}
> diff -puN drivers/scsi/arcmsr/arcmsr.h~areca-raid-driver-arcmsr-update2 drivers/scsi/arcmsr/arcmsr.h
> --- devel/drivers/scsi/arcmsr/arcmsr.h~areca-raid-driver-arcmsr-update2	2006-01-11 19:05:35.000000000 -0800
> +++ devel-akpm/drivers/scsi/arcmsr/arcmsr.h	2006-01-11 19:05:35.000000000 -0800
> @@ -1,11 +1,11 @@
>  /*
>  ** modification, are permitted provided that the following conditions
>  ** are met:
> @@ -34,105 +34,127 @@
>  ** IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
>  ** OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
>  ** IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
> -** INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES(INCLUDING, BUT
> -** NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> +** INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES(INCLUDING,BUT
> +** NOT LIMITED TO,PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,

I still prefer a Space after comma.

>  ** DATA, OR PROFITS; OR BUSINESS INTERRUPTION)HOWEVER CAUSED AND ON ANY
>  ** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
>  **(INCLUDING NEGLIGENCE OR OTHERWISE)ARISING IN ANY WAY OUT OF THE USE OF
>  ** THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>  */
> -
> -#define dma_addr_hi32(addr)     (uint32_t) ((addr>>16)>>16)
> -#define dma_addr_lo32(addr)     (uint32_t) (addr & 0xffffffff)
> -
> +#include <linux/config.h>

The make (build) procedure now includes linux/config.h for every
build, so this #include isn't needed.

> +#define dma_addr_lo32(addr)               (uint32_t) (addr & 0xffffffff)
> +
> +#ifndef DMA_64BIT_MASK
> +	#define DMA_64BIT_MASK              0xffffffffffffffffULL
> +	#define DMA_32BIT_MASK              0x00000000ffffffffULL
> +#endif

Is the above for some back-version kernel compatibility?
Otherwise all that is needed is to #include <linux/dma-mapping.h>.


I also saw 2 cases of "unknow" which should be "unknown".

-- 
~Randy
