Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbVDOUYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbVDOUYn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 16:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVDOUYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 16:24:43 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:15064 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261957AbVDOUX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 16:23:58 -0400
Date: Fri, 15 Apr 2005 15:23:36 -0500 (CDT)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@dyn95395164
To: Nishanth Aravamudan <nacc@us.ibm.com>
cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char/tpm: use msleep(), clean-up timers, fix typo
In-Reply-To: <20050311181816.GC2595@us.ibm.com>
Message-ID: <Pine.LNX.4.61.0504151522210.24192@dyn95395164>
References: <20050310004115.GA32583@kroah.com> <1110415321526@kroah.com>
 <20050311181816.GC2595@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tested this patch and agree that using msleep is the right.  Please 
apply this patch to the tpm driver.  One hunk might fail b/c the 
typo has been fixed already.

Thanks,
Kylie Hall

On Fri, 11 Mar 2005, Nishanth Aravamudan wrote:

> Not sure what happened to the original mail, but I'm not seeing it
> yet...
> 
> On Wed, Mar 09, 2005 at 04:42:01PM -0800, Greg KH wrote:
> > ChangeSet 1.2035, 2005/03/09 10:12:19-08:00, kjhall@us.ibm.com
> > 
> > [PATCH] Add TPM hardware enablement driver
> > 
> > This patch is a device driver to enable new hardware.  The new hardware is
> > the TPM chip as described by specifications at
> > <http://www.trustedcomputinggroup.org>.  The TPM chip will enable you to
> > use hardware to securely store and protect your keys and personal data.
> > To use the chip according to the specification, you will need the Trusted
> > Software Stack (TSS) of which an implementation for Linux is available at:
> > <http://sourceforge.net/projects/trousers>.
> 
> Here is a patch that removes all callers of schedule_timeout() as I
> previously mentioned:
> 
> Description: The TPM driver unnecessarily uses timers when it simply
> needs to maintain a maximum delay via time_before(). msleep() is used
> instead of schedule_timeout() to guarantee the task delays as expected.
> While compile-testing, I found a typo in the driver, using tpm_chp
> instead of tpm_chip. Remove the now unused timer callback function and
> change TPM_TIMEOUT's units to milliseconds. Patch is compile-tested.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> 
> diff -urpN 2.6.11-v/drivers/char/tpm/tpm.c 2.6.11/drivers/char/tpm/tpm.c
> --- 2.6.11-v/drivers/char/tpm/tpm.c	2005-03-10 10:50:00.000000000 -0800
> +++ 2.6.11/drivers/char/tpm/tpm.c	2005-03-10 11:00:50.000000000 -0800
> @@ -19,7 +19,7 @@
>   * 
>   * Note, the TPM chip is not interrupt driven (only polling)
>   * and can have very long timeouts (minutes!). Hence the unusual
> - * calls to schedule_timeout.
> + * calls to msleep.
>   *
>   */
>  
> @@ -52,14 +52,6 @@ static void user_reader_timeout(unsigned
>  	up(&chip->buffer_mutex);
>  }
>  
> -void tpm_time_expired(unsigned long ptr)
> -{
> -	int *exp = (int *) ptr;
> -	*exp = 1;
> -}
> -
> -EXPORT_SYMBOL_GPL(tpm_time_expired);
> -
>  /*
>   * Initialize the LPC bus and enable the TPM ports
>   */
> @@ -135,6 +127,7 @@ static ssize_t tpm_transmit(struct tpm_c
>  	ssize_t len;
>  	u32 count;
>  	__be32 *native_size;
> +	unsigned long stop;
>  
>  	native_size = (__force __be32 *) (buf + 2);
>  	count = be32_to_cpu(*native_size);
> @@ -155,28 +148,16 @@ static ssize_t tpm_transmit(struct tpm_c
>  		return len;
>  	}
>  
> -	down(&chip->timer_manipulation_mutex);
> -	chip->time_expired = 0;
> -	init_timer(&chip->device_timer);
> -	chip->device_timer.function = tpm_time_expired;
> -	chip->device_timer.expires = jiffies + 2 * 60 * HZ;
> -	chip->device_timer.data = (unsigned long) &chip->time_expired;
> -	add_timer(&chip->device_timer);
> -	up(&chip->timer_manipulation_mutex);
> -
> +	stop = jiffies + 2 * 60 * HZ;
>  	do {
>  		u8 status = inb(chip->vendor->base + 1);
>  		if ((status & chip->vendor->req_complete_mask) ==
>  		    chip->vendor->req_complete_val) {
> -			down(&chip->timer_manipulation_mutex);
> -			del_singleshot_timer_sync(&chip->device_timer);
> -			up(&chip->timer_manipulation_mutex);
>  			goto out_recv;
>  		}
> -		set_current_state(TASK_UNINTERRUPTIBLE);
> -		schedule_timeout(TPM_TIMEOUT);
> +		msleep(TPM_TIMEOUT); /* CHECK */
>  		rmb();
> -	} while (!chip->time_expired);
> +	} while (time_before(jiffies, stop));
>  
>  
>  	chip->vendor->cancel(chip);
> @@ -219,7 +200,7 @@ static ssize_t show_pcrs(struct device *
>  	int i, j, index, num_pcrs;
>  	char *str = buf;
>  
> -	struct tpm_chp *chip =
> +	struct tpm_chip *chip =
>  	    pci_get_drvdata(container_of(dev, struct pci_dev, dev));
>  	if (chip == NULL)
>  		return -ENODEV;
> @@ -450,10 +431,8 @@ ssize_t tpm_write(struct file * file, co
>  
>  	/* cannot perform a write until the read has cleared
>  	   either via tpm_read or a user_read_timer timeout */
> -	while (atomic_read(&chip->data_pending) != 0) {
> -		set_current_state(TASK_UNINTERRUPTIBLE);
> -		schedule_timeout(TPM_TIMEOUT);
> -	}
> +	while (atomic_read(&chip->data_pending) != 0)
> +		msleep(TPM_TIMEOUT);
>  
>  	down(&chip->buffer_mutex);
>  
> diff -urpN 2.6.11-v/drivers/char/tpm/tpm.h 2.6.11/drivers/char/tpm/tpm.h
> --- 2.6.11-v/drivers/char/tpm/tpm.h	2005-03-10 10:50:00.000000000 -0800
> +++ 2.6.11/drivers/char/tpm/tpm.h	2005-03-10 10:58:12.000000000 -0800
> @@ -24,7 +24,7 @@
>  #include <linux/delay.h>
>  #include <linux/miscdevice.h>
>  
> -#define TPM_TIMEOUT msecs_to_jiffies(5)
> +#define TPM_TIMEOUT	5	/* msecs */
>  
>  /* TPM addresses */
>  #define	TPM_ADDR			0x4E
> @@ -77,7 +77,6 @@ static inline void tpm_write_index(int i
>  	outb(value & 0xFF, TPM_DATA);
>  }
>  
> -extern void tpm_time_expired(unsigned long);
>  extern int tpm_lpc_bus_init(struct pci_dev *, u16);
>  
>  extern int tpm_register_hardware(struct pci_dev *,
> diff -urpN 2.6.11-v/drivers/char/tpm/tpm_nsc.c 2.6.11/drivers/char/tpm/tpm_nsc.c
> --- 2.6.11-v/drivers/char/tpm/tpm_nsc.c	2005-03-10 10:50:00.000000000 -0800
> +++ 2.6.11/drivers/char/tpm/tpm_nsc.c	2005-03-10 10:56:54.000000000 -0800
> @@ -55,10 +55,7 @@
>   */
>  static int wait_for_stat(struct tpm_chip *chip, u8 mask, u8 val, u8 * data)
>  {
> -	int expired = 0;
> -	struct timer_list status_timer =
> -	    TIMER_INITIALIZER(tpm_time_expired, jiffies + 10 * HZ,
> -			      (unsigned long) &expired);
> +	unsigned long stop;
>  
>  	/* status immediately available check */
>  	*data = inb(chip->vendor->base + NSC_STATUS);
> @@ -66,17 +63,14 @@ static int wait_for_stat(struct tpm_chip
>  		return 0;
>  
>  	/* wait for status */
> -	add_timer(&status_timer);
> +	stop = jiffies + 10 * HZ;
>  	do {
> -		set_current_state(TASK_UNINTERRUPTIBLE);
> -		schedule_timeout(TPM_TIMEOUT);
> +		msleep(TPM_TIMEOUT);
>  		*data = inb(chip->vendor->base + 1);
> -		if ((*data & mask) == val) {
> -			del_singleshot_timer_sync(&status_timer);
> +		if ((*data & mask) == val)
>  			return 0;
> -		}
>  	}
> -	while (!expired);
> +	while (time_before(jiffies, stop));
>  
>  	return -EBUSY;
>  }
> @@ -84,10 +78,7 @@ static int wait_for_stat(struct tpm_chip
>  static int nsc_wait_for_ready(struct tpm_chip *chip)
>  {
>  	int status;
> -	int expired = 0;
> -	struct timer_list status_timer =
> -	    TIMER_INITIALIZER(tpm_time_expired, jiffies + 100,
> -			      (unsigned long) &expired);
> +	unsigned long stop;
>  
>  	/* status immediately available check */
>  	status = inb(chip->vendor->base + NSC_STATUS);
> @@ -97,19 +88,16 @@ static int nsc_wait_for_ready(struct tpm
>  		return 0;
>  
>  	/* wait for status */
> -	add_timer(&status_timer);
> +	stop = jiffies + 100;
>  	do {
> -		set_current_state(TASK_UNINTERRUPTIBLE);
> -		schedule_timeout(TPM_TIMEOUT);
> +		msleep(TPM_TIMEOUT);
>  		status = inb(chip->vendor->base + NSC_STATUS);
>  		if (status & NSC_STATUS_OBF)
>  			status = inb(chip->vendor->base + NSC_DATA);
> -		if (status & NSC_STATUS_RDY) {
> -			del_singleshot_timer_sync(&status_timer);
> +		if (status & NSC_STATUS_RDY)
>  			return 0;
> -		}
>  	}
> -	while (!expired);
> +	while (time_before(jiffies, stop));
>  
>  	dev_info(&chip->pci_dev->dev, "wait for ready failed\n");
>  	return -EBUSY;
> 
> 
