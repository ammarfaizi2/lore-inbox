Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270670AbRHJWeA>; Fri, 10 Aug 2001 18:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270664AbRHJWds>; Fri, 10 Aug 2001 18:33:48 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:63492 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270663AbRHJWdb>; Fri, 10 Aug 2001 18:33:31 -0400
Subject: Re: [PATCH] Adaptec I2O RAID driver (kernel 2.4.7)
To: Deanna_Bonds@adaptec.com (Bonds, Deanna)
Date: Fri, 10 Aug 2001 23:35:44 +0100 (BST)
Cc: linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org'),
        torvalds@transmeta.com ('torvalds@transmeta.com'),
        alan@lxorguk.ukuu.org.uk ('alan@lxorguk.ukuu.org.uk')
In-Reply-To: <no.id> from "Bonds, Deanna" at Aug 10, 2001 04:45:30 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15VKsa-0001m6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok comments below. 

Summary suggestion:

Can you fix up the
	-	use of u32 for timeouts
	-	partition stuff for i386 (which really can just go)
	-	pci_resource_len usage
	-	multiply overflow
	-	EFAULT
	-	kmalloc check oddments

Don't bother with the static, header file oddments or the i2o core bugs
you inherited. Just let me know which you use and I'll figure out how to
make them shared.

At that point I think its fine to go in. 

Linus btw it might seem odd to add a driver for a specific i2o adapter but
the DPT's speak what is to say the least a very odd dialect of i2o, so it
does make sense.

> +#include <linux/autoconf.h>
> +#if defined(CONFIG_MODVERSIONS) && !defined(MODVERSIONS)
> +#	define MODVERSIONS
> +#endif
> +
> +#if defined MODVERSIONS && defined MODULE
> +#	include <linux/modversions.h>
> +#endif
> +

These will be automatic so should go - ok I can do that

> +MODULE_AUTHOR("Deanna Bonds, with _lots_ of help from Mark Salyzyn");
> +MODULE_DESCRIPTION("Adaptec I2O RAID Driver");
> +char kernel_version[] = UTS_RELEASE;

should be static char [otherwise it clashes built in]

> +static struct file_operations adpt_fops = {
> +	ioctl: adpt_ioctl,
> +	open: adpt_open,
> +	release: adpt_close
> +};
> +
> +
> +u8 adpt_read_blink_led(adpt_hba* host)

static - again not a big item, that can be done later anyway

> +#endif
> +	sht->use_new_eh_code = 1;

Excellent.  old_eh will go in 2.5 so its great you are using the new_eh

> +	printk("dpti: If you have a lot of devices this could take a few
> minutes.\n");

	       ^KERN_INFO


> +	for (pHba = hba_chain; pHba; pHba = pHba->next) {
> +		printk("%s: Reading the hardware resource table.\n",
                       KERN_DEBUG

> +int adpt_queue(Scsi_Cmnd * cmd, void (*done) (Scsi_Cmnd *))
> +{
> +	adpt_hba* pHba = NULL;
> +	struct adpt_device* pDev = NULL;	/* dpt per device
> information */
> +	u32 timeout = jiffies + (TMOUT_SCSI*HZ);
        ^unsigned long

> +	// TODO(defer) dmb - use marks algorythm
> +	if( disk->has_part_table == 1){
> +
> +
> +	}

Linux will trust partition tables for you.

> +		 * Read data from buffer (writing to us) - NOT SUPPORTED
> +		 */
> +		return -ENOSYS;

		-EINVAL

	[-ENOSYS would imply the write() syscall didnt exist]

> +	pci_read_config_dword(pDev,
> PCI_BASE_ADDRESS_0,(u32*)&base_addr0_phys);

No no no.. Dont do this, bad crap will happen on some setups. The length
is pci_resource_len(pDev, 0) 

> +	pci_read_config_word (pDev, PCI_SUBSYSTEM_ID, &subdevice);
> +


> +		//Use BAR1 in this config
> +		pci_read_config_dword(pDev,PCI_BASE_ADDRESS_1,
> (u32*)&base_addr1_phys);
> +		pci_write_config_dword(pDev,PCI_BASE_ADDRESS_1, 0xffffffff);
> +		pci_read_config_dword(pDev,PCI_BASE_ADDRESS_1,
> &hba_map1_area_size);

Again dont do this - use pci_resource_len

> +	base_addr_virt = (ulong)ioremap(base_addr0_phys,hba_map0_area_size);
> +	if(base_addr_virt == 0) {
> +		PERROR("dpti: adpt_config_hba: io remap failed\n");
> +		return -EINVAL;
> +	}
> +
> +        if(raptorFlag == TRUE) {
> +		msg_addr_virt = (ulong)ioremap(base_addr1_phys,
> hba_map1_area_size );
> +		if(msg_addr_virt == 0) {
> +			PERROR("dpti: adpt_config_hba: io remap failed on
> BAR1\n");


You need to unmap the base_addr_virt here or it leaks on error

> +	// Allocate and zero the data structure
> +	if( (pHba = kmalloc(sizeof(adpt_hba), GFP_KERNEL)) == NULL) {
> +		iounmap((void*)base_addr_virt);
	
		msg_addr_virt ??

> +/* Structures and definitions for synchronous message posting.
> + * See adpt_i2o_post_wait() for description
> + * */

Ah you borrowed the i2o post wait code before it was properly debugged. So
that..

> +	spin_unlock_irqrestore(&adpt_post_wait_lock, flags);
> +	kfree(wait_data);

Now in the timeout case this will cause the failed reply data to scribble
somewhere random, if the reply does turn up after the timeout. You actually
can't clean the buffer up until you know the event completed or you shut
down the controller.

> +	u32 timeout = jiffies + 30*HZ;
unsigned long for timers..
> +	do {
> +		rmb();
> +		m = readl(pHba->post_port);
> +		if (m != EMPTY_QUEUE) {

> + */		    	
> +int adpt_i2o_query_scalar(adpt_hba* pHba, int tid, 
> +			int group, int field, void *buf, int buflen)
> +{
> +	u16 opblk[] = { 1, 0, I2O_PARAMS_FIELD_GET, group, 1, field };

If you borrowed the i2o_query_scalar code from the older i2o code thats
also buggy (sorry Im human too 8)).

Can you give me a list of the i2o_ core routines that your driver uses
unchanged and I will do the magic so that we can share them (say an
i2o_lib module)

> +	// get user msg size in u32s 
> +	get_user(size, &user_msg[0]);

	if(get_user(...))
		return -EFAULT;

(so it reports errors nicely

> +	user_reply = &user_msg[size];
> +	size *= 4; // Convert to bytes
> +	if(size > MAX_MESSAGE_SIZE){
> +		return -EFAULT;

Check the size is ok for 1/4, then multiply - it might overflow, same on 
the reply

> +	get_user(reply_size, &user_reply[0]);
		-EFAULT...

> +#if defined __i386__
> +
> +#include <linux/mc146818rtc.h>
> +
> +	/* Get drive type for 1st drive*/
> +	i = CMOS_READ(0x12) >> 4;
> +	j = i >> 4;
> +	if (i == 0x0f) {
> +		j = CMOS_READ(0x19);
> +	}
> +	si->drive0CMOS = j;

Don't do this. You've no idea if there is even CMOS present, if the format
is what you expect of if it is talking to you

> +	/* Get number of drives sys bios found */
> +	si->numDrives = *((char *) phys_to_virt(0x475));

BIOS - again an assumption. Basically flush this code. Geom isnt a big
deal to the kernel, not all drivers even bother to set it, scsi is logical
block based so really doesnt care a bit.

> +	u32 timeout = jiffies + TMOUT_INITOUTBOUND*HZ;

unsigned long - that seems to be everywhere. Its kind of bad to get it wrong
as it means alphas mysteriously dont work after about 50 days 8)

> +/*
> + * dpti2oscsi2.c contains a table of scsi commands that is used to
> determine
> + * the data direction of the command.  It is used in dpt_scsi_to_i2o to
> speed
> + * up the building of the scsi message.

You don't need that in 2.4. The kernel tells you

> +				if( pDev == NULL){
> +					pDev =  kmalloc(sizeof(struct
> adpt_device),GFP_KERNEL);

Missing check for if this one fails..

> +
> +  /* Define the mutually exclusive semaphore type */
> +#define		SEMAPHORE_T	unsigned int *
> +  /* Define a handle to a DLL */
> +#define		DLL_HANDLE_T	unsigned int *
> +
> +#endif
> --- /dev/null	Sat Apr 14 07:06:21 2001
> +++ linux/drivers/scsi/dpti_i2o-dev.h	Fri Aug 10 14:49:34 2001
> @@ -0,0 +1,395 @@
> +/*
> + * I2O user space accessible structures/APIs

Some of these seem to be duplicates of existing includes so could be shared

