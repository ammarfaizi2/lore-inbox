Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWFOFiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWFOFiD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 01:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWFOFiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 01:38:03 -0400
Received: from mail-03.jhb.wbs.co.za ([196.2.97.2]:46213 "EHLO
	mail-03.jhb.wbs.co.za") by vger.kernel.org with ESMTP
	id S932435AbWFOFiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 01:38:01 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAAqMkESJaQcOKg
From: Bongani Hlope <bhlope@mweb.co.za>
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [UBUNTU:acpi/ec] Use semaphore instead of spinlock
Date: Thu, 15 Jun 2006 07:38:18 +0200
User-Agent: KMail/1.9.3
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       len.brown@intel.com
References: <44909A32.3010304@oracle.com>
In-Reply-To: <44909A32.3010304@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606150738.18724.bhlope@mweb.co.za>
X-Original-Subject: Re: [UBUNTU:acpi/ec] Use semaphore instead of spinlock
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 June 2006 01:22, Randy Dunlap wrote:
> From: Ben Collins <bcollins@ubuntu.com>
>
> [UBUNTU:acpi/ec] Use semaphore instead of spinlock to get rid of missed
> interrupts on ACPI EC (embedded controller)
>
> Reference: https://launchpad.net/bugs/39315
> http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=
>commitdiff;h=c484728a760fcfcbad2319ed5364414bc86c3d38
>
> Signed-off-by: Ben Collins <bcollins@ubuntu.com>
> ---
>
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -53,8 +53,8 @@ ACPI_MODULE_NAME("acpi_ec")
>  #define ACPI_EC_EVENT_IBE	0x02	/* Input buffer empty */
>  #define ACPI_EC_DELAY		50	/* Wait 50ms max. during EC ops */
>  #define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get global lock */
> -#define ACPI_EC_UDELAY         100	/* Poll @ 100us increments */
> -#define ACPI_EC_UDELAY_COUNT   1000	/* Wait 10ms max. during EC ops */
> +#define ACPI_EC_MSLEEP		1	/* Poll @ 1ms increments */
> +#define ACPI_EC_MSLEEP_COUNT	10	/* Wait 10ms max. during EC ops */
>  #define ACPI_EC_COMMAND_READ	0x80
>  #define ACPI_EC_COMMAND_WRITE	0x81
>  #define ACPI_EC_BURST_ENABLE	0x82
> @@ -116,7 +116,7 @@ union acpi_ec {
>  		struct acpi_generic_address command_addr;
>  		struct acpi_generic_address data_addr;
>  		unsigned long global_lock;
> -		spinlock_t lock;
> +		struct semaphore sem;
>  	} poll;
>  };
>
> @@ -172,7 +172,7 @@ static int acpi_ec_wait(union acpi_ec *e
>  static int acpi_ec_poll_wait(union acpi_ec *ec, u8 event)
>  {
>  	u32 acpi_ec_status = 0;
> -	u32 i = ACPI_EC_UDELAY_COUNT;
> +	u32 i = ACPI_EC_MSLEEP_COUNT;
>
>  	if (!ec)
>  		return -EINVAL;
> @@ -185,7 +185,7 @@ static int acpi_ec_poll_wait(union acpi_
>  					       &ec->common.status_addr);
>  			if (acpi_ec_status & ACPI_EC_FLAG_OBF)
>  				return 0;
> -			udelay(ACPI_EC_UDELAY);
> +			msleep(ACPI_EC_MSLEEP);
>  		} while (--i > 0);
>  		break;
>  	case ACPI_EC_EVENT_IBE:
> @@ -194,7 +194,7 @@ static int acpi_ec_poll_wait(union acpi_
>  					       &ec->common.status_addr);
>  			if (!(acpi_ec_status & ACPI_EC_FLAG_IBF))
>  				return 0;
> -			udelay(ACPI_EC_UDELAY);
> +			msleep(ACPI_EC_MSLEEP);
>  		} while (--i > 0);
>  		break;
>  	default:
> @@ -326,7 +326,6 @@ static int acpi_ec_poll_read(union acpi_
>  {
>  	acpi_status status = AE_OK;
>  	int result = 0;
> -	unsigned long flags = 0;
>  	u32 glk = 0;
>
>  	ACPI_FUNCTION_TRACE("acpi_ec_read");
> @@ -342,7 +341,10 @@ static int acpi_ec_poll_read(union acpi_
>  			return_VALUE(-ENODEV);
>  	}
>
> -	spin_lock_irqsave(&ec->poll.lock, flags);
> +	if (down_interruptible(&ec->polling.sem)) {
                                                     ^^^^
isn't this suppose to be: &ec->poll.sem

> +		result = -ERESTARTSYS;
> +		goto end_nosem;
> +	}
>
>  	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_READ,
>  				&ec->common.command_addr);
> @@ -361,7 +363,8 @@ static int acpi_ec_poll_read(union acpi_
>  			  *data, address));
>
>        end:
> -	spin_unlock_irqrestore(&ec->poll.lock, flags);
> +	up(&ec->polling.sem);
                     ^^^^
&ec->poll.sem

> +end_nosem:
>
>  	if (ec->common.global_lock)
>  		acpi_release_global_lock(glk);
> @@ -387,7 +390,10 @@ static int acpi_ec_poll_write(union acpi
>  			return_VALUE(-ENODEV);
>  	}
>
> -	spin_lock_irqsave(&ec->poll.lock, flags);
> +	if (down_interruptible(&ec->polling.sem)) {
                     ^^^^
&ec->poll.sem

> +		result = -ERESTARTSYS;
> +		goto end_nosem;
> +	}
>
>  	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_WRITE,
>  				&ec->common.command_addr);
> @@ -409,7 +415,8 @@ static int acpi_ec_poll_write(union acpi
>  			  data, address));
>
>        end:
> -	spin_unlock_irqrestore(&ec->poll.lock, flags);
> +	up(&ec->polling.sem);
                     ^^^^
&ec->poll.sem

> +end_nosem:
>
>  	if (ec->common.global_lock)
>  		acpi_release_global_lock(glk);
> @@ -592,7 +599,10 @@ static int acpi_ec_poll_query(union acpi
>  	 * Note that successful completion of the query causes the ACPI_EC_SCI
>  	 * bit to be cleared (and thus clearing the interrupt source).
>  	 */
> -	spin_lock_irqsave(&ec->poll.lock, flags);
> +	if (down_interruptible(&ec->polling.sem)) {
                                                    ^^^^
&ec->poll.sem

> +		result = -ERESTARTSYS;
> +		goto end_nosem;
> +	}
>
>  	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_QUERY,
>  				&ec->common.command_addr);
> @@ -605,7 +615,8 @@ static int acpi_ec_poll_query(union acpi
>  		result = -ENODATA;
>
>        end:
> -	spin_unlock_irqrestore(&ec->poll.lock, flags);
> +	up(&ec->polling.sem);
                     ^^^^
&ec->poll.sem

> +end_nosem:
>
>  	if (ec->common.global_lock)
>  		acpi_release_global_lock(glk);
> @@ -694,9 +705,10 @@ static void acpi_ec_gpe_poll_query(void
>  	if (!ec_cxt)
>  		goto end;
>
> -	spin_lock_irqsave(&ec->poll.lock, flags);
> +	if (down_interruptible (&ec->polling.sem))
                                                  ^^^^
&ec->poll.sem

> +		return_VOID;
>  	acpi_hw_low_level_read(8, &value, &ec->common.command_addr);
> -	spin_unlock_irqrestore(&ec->poll.lock, flags);
> +	up(&ec->polling.sem);
                     ^^^^
&ec->poll.sem

>
>  	/* TBD: Implement asynch events!
>  	 * NOTE: All we care about are EC-SCI's.  Other EC events are
> @@ -1008,7 +1020,7 @@ static int acpi_ec_poll_add(struct acpi_
>
>  	ec->common.handle = device->handle;
>  	ec->common.uid = -1;
> -	spin_lock_init(&ec->poll.lock);
> +	init_MUTEX(&ec->polling.sem);
                                    ^^^^
&ec->poll.sem

>  	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
>  	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
>  	acpi_driver_data(device) = ec;
> @@ -1303,7 +1315,7 @@ acpi_fake_ecdt_poll_callback(acpi_handle
>  				  &ec_ecdt->common.gpe_bit);
>  	if (ACPI_FAILURE(status))
>  		return status;
> -	spin_lock_init(&ec_ecdt->poll.lock);
> +	init_MUTEX(&ec_ecdt->polling.sem);
                     ^^^^
&ec->poll.sem

>  	ec_ecdt->common.global_lock = TRUE;
>  	ec_ecdt->common.handle = handle;
>
> @@ -1419,7 +1431,7 @@ static int __init acpi_ec_poll_get_real_
>  	ec_ecdt->common.status_addr = ecdt_ptr->ec_control;
>  	ec_ecdt->common.data_addr = ecdt_ptr->ec_data;
>  	ec_ecdt->common.gpe_bit = ecdt_ptr->gpe_bit;
> -	spin_lock_init(&ec_ecdt->poll.lock);
> +	init_MUTEX(&ec_ecdt->polling.sem);
                                         ^^^^
&ec->poll.sem

>  	/* use the GL just to be safe */
>  	ec_ecdt->common.global_lock = TRUE;
>  	ec_ecdt->common.uid = ecdt_ptr->uid;
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
