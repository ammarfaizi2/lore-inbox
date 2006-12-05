Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937209AbWLEATc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937209AbWLEATc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 19:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937190AbWLEATc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 19:19:32 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:33114 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937175AbWLEATa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 19:19:30 -0500
Date: Mon, 4 Dec 2006 16:18:42 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Ivo van Doorn <ivdoorn@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Dmitry Torokhov <dtor@insightbb.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, John Linville <linville@tuxdriver.com>,
       Jiri Benc <jbenc@suse.cz>, Lennart Poettering <lennart@poettering.net>,
       Johannes Berg <johannes@sipsolutions.net>,
       Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [RFC] rfkill - Add support for input key to control wireless
 radio
Message-Id: <20061204161842.a8673e6e.randy.dunlap@oracle.com>
In-Reply-To: <200612032328.12093.IvDoorn@gmail.com>
References: <200612031936.34343.IvDoorn@gmail.com>
	<1165173618.3233.243.camel@laptopd505.fenrus.org>
	<200612032328.12093.IvDoorn@gmail.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Dec 2006 23:28:11 +0100 Ivo van Doorn wrote:

> rfkill with the fixes as suggested by Arjan.
>  - instead of a semaphore a mutex is now being used.
>  - open_count changing is now locked by the mutex.
> 
> ---
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index ba0e88c..6986d59 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -79,4 +79,19 @@ config HP_SDC_RTC
>  	  Say Y here if you want to support the built-in real time clock
>  	  of the HP SDC controller.
>  
> +config RFKILL
> +	tristate "RF button support"

	depends on SYSFS

> +	help
> +	  If you say yes here, the rfkill driver will be build

s/build/built/

> +	  which allowed network devices to register their hardware

s/allowed/allows/

> +	  RF button which controls the radio state. This driver
> +	  will then create an input device for it.
> +
> +	  When the input device is not used, the rfkill driver
> +	  will make sure that when the RF button is pressed the radio
> +	  is enabled or disabled accordingly. When the input device
> +	  has been opened by the user this radio control will be left
> +	  to the user, and rfkill will only send the RF button status
> +	  change to userspace.
> +
>  endif
> diff --git a/drivers/input/misc/rfkill.c b/drivers/input/misc/rfkill.c
> new file mode 100644
> index 0000000..4777d73
> --- /dev/null
> +++ b/drivers/input/misc/rfkill.c
> @@ -0,0 +1,887 @@

[snip]

> +/*
> + * Function called by the key driver to report the new status
> + * of the key.
> + */
> +void rfkill_report_event(struct rfkill *rfkill, int new_status)
> +{
> +	mutex_lock(&master->mutex);
> +
> +	if (rfkill_check_key(rfkill->key, new_status))
> +		schedule_work(&master->toggle_work);
> +
> +	mutex_unlock(&master->mutex);
> +}
> +EXPORT_SYMBOL_GPL(rfkill_report_event);

Please use kernel-doc notation for non-static functions.
See Documentation/kernel-doc-nano-HOWTO.txt for more info.

> +/*
> + * Function called by the key driver when the rfkill structure
> + * needs to be registered.
> + */

kernel-doc please.

> +int rfkill_register_key(struct rfkill *rfkill, int init_status)
> +{
> +	struct rfkill_type *type = &master->type[rfkill->key_type];
> +	struct rfkill_key *key;
> +	int status;
> +
> +	if (!rfkill)
> +		return -EINVAL;	
> +
> +	if (rfkill->key_type >= KEY_TYPE_MAX)
> +		return -EINVAL;
> +
> +	/*
> +	 * Increase module use count to prevent this
> +	 * module to be unloaded while there are still
> +	 * registered keys.
> +	 */
> +	if (!try_module_get(THIS_MODULE))
> +		return -EBUSY;
> +
> +	mutex_lock(&master->mutex);
> +
> +	/*
> +	 * Initialize key, and if required the type.
> +	 */
> +	status = rfkill_add_type_key(type);
> +	if (status)
> +		goto exit;
> +
> +	key = rfkill_key_init(rfkill, init_status);
> +	if (!key) {
> +		status = -ENOMEM;
> +		goto exit_type;
> +	}
> +
> +	/*
> +	 * Add key to our list.
> +	 */
> +	list_add(&key->entry, &master->key_list);
> +
> +	/*
> +	 * Check if we need polling, and if we do
> +	 * increase the poll required counter and check
> +	 * if we weren't polling yet.
> +	 */
> +	if (rfkill->poll && !master->poll_required++)
> +		schedule_delayed_work(&master->poll_work, RFKILL_POLL_DELAY);
> +
> +	mutex_unlock(&master->mutex);
> +
> +	return 0;
> +
> +exit_type:
> +	rfkill_del_type_key(type);
> +
> +exit:
> +	mutex_unlock(&master->mutex);
> +	module_put(THIS_MODULE);
> +
> +	return status;
> +}
> +EXPORT_SYMBOL_GPL(rfkill_register_key);
> +
> +/*
> + * Function called by the key driver when the rfkill structure
> + * needs to be deregistered.
> + */

kernel-doc

> +int rfkill_deregister_key(struct rfkill *rfkill)
> +{
> +	struct rfkill_type *type;
> +
> +	if (!rfkill || !rfkill->key)
> +		return -EINVAL;
> +
> +	mutex_lock(&master->mutex);
> +
> +	/*
> +	 * Cancel delayed work if this is the last key
> +	 * that requires polling. It is not bad if
> +	 * if the workqueue is still running,
> +	 * the workqueue won't rearm itself since the
> +	 * poll_required variable has been set.
> +	 * and we have protected the list with a semaphore.
> +	 */
> +	if (rfkill->poll && !--master->poll_required)
> +		cancel_delayed_work(&master->poll_work);
> +
> +	/*
> +	 * Delete the rfkill structure to the list.
> +	 */
> +	list_del(&rfkill->key->entry);
> +
> +	/*
> +	 * Deinitialize key.
> +	 */
> +	type = rfkill->key->type;
> +	rfkill_key_deinit(rfkill->key);
> +	rfkill_del_type_key(type);
> +
> +	mutex_unlock(&master->mutex);
> +
> +	/*
> +	 * rfkill entry has been removed,
> +	 * decrease module use count.
> +	 */
> +	module_put(THIS_MODULE);
> +	
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(rfkill_deregister_key);

> diff --git a/include/linux/rfkill.h b/include/linux/rfkill.h
> new file mode 100644
> index 0000000..a455548
> --- /dev/null
> +++ b/include/linux/rfkill.h
> @@ -0,0 +1,140 @@
> +/*
> +	RF button support
> +	Laptops are quite often equiped with a RF key to enable or

                                equipped with an RF key

> +	disable the radio of the wireless device attached to that key.
> +	This wireless device usually is an integrated wireless network device,
> +	infrared or bluetooth device.
> +	Some of these devices will disable the radio automatically when the
> +	RF key has been pressed, while other devices need to be polled
> +	for the RF key status, and leave the action to be taken up to the
> +	driver for that particular device.
> +	But in all cases the only interface that will have its radio disabled
> +	will be the device that has the RF key attached to it. It could however
> +	be desired that userspace performs this disabling of the radios in case
> +	more things than just disabling a single radio is desired.
> +
> +	The rfkill driver will contain a list of all devices with a RF button,

                                                             with an RF button,

> +	and hardware drivers need to register their hardware to the rfkill
> +	interface. Rfkill will then take care of everything. If the RF key
> +	requires polling to obtain the status this will be handled by rfkill.
> +	If the RF key does not require polling but sends for example interrupts,
> +	the hardware driver can report the change of status to rfkill, without
> +	having to do any other action.
> +	Once the status of the key has changed and the hardware does not
> +	automatically enable or disable the radio rfkill provides the
> +	interface to do this correctly.
> +
> +	For each registered hardware button an input device will be created.
> +	If this input device has been opened by the user, rfkill will send a
> +	signal to userspace instead of the hardware about the new button
> +	status. This will allow userpace to perform the correct steps
> +	in order to bring down all interfaces.
> + */
> +
> +#ifndef RFKILL_H
> +#define RFKILL_H
> +
> +#include <linux/device.h>
> +
> +#define RFKILL_POLL_DELAY	( HZ / 10 )
> +
> +enum key_type {
> +	KEY_TYPE_WIFI = 0,
> +	KEY_TYPE_BlUETOOTH = 1,
> +	KEY_TYPE_IRDA = 2,
> +	KEY_TYPE_MAX = 3,
> +};
> +
> +/**
> + * struct rfkill - rfkill button control structure.
> + *

No "blank line" between the struct name and its parameters.

> + * @dev_name: Name of the interface. This will become the name
> + * 	of the input device which will be created for this button.
> + * @dev: Pointer to the device structure to which this button belongs to.
> + * @data: Pointer to the RF button drivers private data which will be
> + * 	passed along with the radio and polling handlers.
> + * @poll(void *data): Optional handler which will frequently be
> + * 	called to determine the current status of the RF button.
> + * @enable_radio(void *data): Optional handler to enable the radio
> + * 	once the RF button has been pressed and the hardware does enable
> + * 	the radio automaticly.
> + * @disable_radio(void *data): Optional handler to disable the radio
> + * 	once the RF button has been pressed and the hardware does disable
> + * 	the radio automaticly.
> + * @key_type: Radio type which the button controls, the value stored
> + * 	here should be a value from enum key_type.
> + * @key: Internal pointer that should not be touched by key driver.
> + *
> + * This structure can be used by a key driver to register the key
> + * to the rfkill driver in order to take control of the reporting
> + * to userspace or handling of radio status.
> + */
> +struct rfkill {
> +	const char *dev_name;
> +
> +	struct device *dev;
> +
> +	void *data;
> +	int (*poll)(void *data);
> +	void (*enable_radio)(void *data);
> +	void (*disable_radio)(void *data);
> +
> +	unsigned int key_type;
> +
> +	struct rfkill_key *key;
> +};
> +
> +/**
> + * rfkill_register_key - Deregister a previously registered rfkill structre.

                                                                     structure.

> + * @rfkill: rfkill structure to be deregistered
> + * @init_status: initial status of the key at the time this function is called
> + *
> + * This function should be called by the key driver when the rfkill structure
> + * needs to be registered. Immediately from registration the key driver
> + * should be able to receive calls through the poll, enable_radio and
> + * disable_radio handlers if those were registered.
> + */
> +int rfkill_register_key(struct rfkill *rfkill, int init_status);
> +
> +/**
> + * rfkill_deregister_key - Deregister a previously registered rfkill structre.

"structure"

> + * @rfkill: rfkill structure to be deregistered
> + *
> + * This function should be called by the key driver when the rfkill structure
> + * needs to be deregistered. This function may only be called if it was
> + * previously registered with rfkill_register_key.
> + */
> +int rfkill_deregister_key(struct rfkill *rfkill);
> +
> +/**
> + * rfkill_report_event - Report change in key status to rfkill handler.
> + * @rfkill: rfkill structure registered by key driver
> + * @new_status: new key status
> + *
> + * This function should be called by the key driver if it has not provided
> + * a poll handler with rfkill. As soon as the key driver has determined
> + * the status of the key has changed it should report the new status
> + * through this function.
> + */
> +void rfkill_report_event(struct rfkill *rfkill, int new_status);
> +
> +#endif /* RFKILL_H */

---
~Randy
