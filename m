Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760043AbWLCTnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760043AbWLCTnQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 14:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760040AbWLCTnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 14:43:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21394 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1760043AbWLCTnN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 14:43:13 -0500
Subject: Re: [RFC] rfkill - Add support for input key to control wireless
	radio
From: Dan Williams <dcbw@redhat.com>
To: Ivo van Doorn <ivdoorn@gmail.com>
Cc: Dmitry Torokhov <dtor@insightbb.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, John Linville <linville@tuxdriver.com>,
       Jiri Benc <jbenc@suse.cz>, Lennart Poettering <lennart@poettering.net>,
       Johannes Berg <johannes@sipsolutions.net>,
       Larry Finger <Larry.Finger@lwfinger.net>, davidz@redhat.com,
       Bastien Nocera <bnocera@redhat.com>
In-Reply-To: <200612031936.34343.IvDoorn@gmail.com>
References: <200612031936.34343.IvDoorn@gmail.com>
Content-Type: text/plain
Date: Sun, 03 Dec 2006 14:44:25 -0500
Message-Id: <1165175065.3178.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-12-03 at 19:36 +0100, Ivo van Doorn wrote:
> Hi,
> 
> This patch is a resend of a patch I has been send to the linux kernel
> and netdev list earlier. The most recent version of a few weeks back
> didn't compile since I missed 1 line in my patch that changed
> include/linux/input.h.
> 
> This patch will offer the handling of radiokeys on a laptop.
> Such keys often control the wireless devices on the radio
> like the wifi, bluetooth and irda.

Ok, what was the conclusion on the following issues?

1) What about rfkill keys that aren't routed via software?  There are
two modes here: (a) the key is not hardwired to the module and the
driver is responsible for disabling the radio, (b) the key is hardwired
to the module and firmware or some other mechanism disables the radio
without driver interaction.  I thought I'd heard of some (b) hardware,
mostly on older laptops, but does anyone know how prevalent (b) hardware
is?  If there isn't any, do we care about it for now?

2) Is there hardware that has separate keys for separate radios?  i.e.,
one key for Bluetooth, and one key for WiFi?  I know Bastien has a
laptop where the same rfkill key handles _both_ ipw2200 and the BT
module, but in different ways: it actually removes the BT USB device
from the USB bus, but uses the normal ipw rfkill mechanism.

3) How does this interact with HAL?  What's the userspace interface that
HAL will listen to to receive the signals?  NetworkManager will need to
listen to HAL for these, as rfkill switches are one big thing that NM
does not handle now due to lack of a standard mechanism.

In any case, any movement on rfkill interface/handling standardization
is quite welcome :)

Cheers,
Dan

> The rfkill works as follows, when the user presses the hardware key
> to control the wireless (wifi, bluetooth or irda) radio a signal will
> go to rfkill. This happens by the hardware driver sending a signal
> to rfkill, or rfkill polling for the button status.
> The key signal will then be processed by rfkill, each key will have
> its own input device, if this input device has not been openened
> by the user, rfkill will keep the signal and either turn the radio
> on or off based on the key status.
> If the input device has been opened, rfkill will send the signal to
> userspace and do nothing further. The user is in charge of controlling
> the radio.
> 
> This driver (if accepted and applied) will be usefull for the rt2x00 drivers
> (rt2400pci, rt2500pci, rt2500usb, rt61pci and rt73usb) in the wireless-dev
> tree and the MSI laptop driver from Lennart Poettering in the main
> linux kernel tree.
> 
> Before this patch can be applied to any tree, I first wish to hear
> if the patch is acceptable. Since the previous time it was send I have made
> several fixes based on the feedback like adding the sysfs entries for
> reading the status.
> 
> Signed-off-by Ivo van Doorn <IvDoorn@gmail.com>
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
> +	help
> +	  If you say yes here, the rfkill driver will be build
> +	  which allowed network devices to register their hardware
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
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 415c491..e788a1b 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -11,3 +11,4 @@ obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
>  obj-$(CONFIG_INPUT_WISTRON_BTNS)	+= wistron_btns.o
>  obj-$(CONFIG_HP_SDC_RTC)		+= hp_sdc_rtc.o
>  obj-$(CONFIG_INPUT_IXP4XX_BEEPER)	+= ixp4xx-beeper.o
> +obj-$(CONFIG_RFKILL)			+= rfkill.o
> diff --git a/drivers/input/misc/rfkill.c b/drivers/input/misc/rfkill.c
> new file mode 100644
> index 0000000..2a896db
> --- /dev/null
> +++ b/drivers/input/misc/rfkill.c
> @@ -0,0 +1,880 @@
> +/*
> +	Copyright (C) 2006 Ivo van Doorn
> +
> +	This program is free software; you can redistribute it and/or modify
> +	it under the terms of the GNU General Public License as published by
> +	the Free Software Foundation; either version 2 of the License, or
> +	(at your option) any later version.
> +
> +	This program is distributed in the hope that it will be useful,
> +	but WITHOUT ANY WARRANTY; without even the implied warranty of
> +	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> +	GNU General Public License for more details.
> +
> +	You should have received a copy of the GNU General Public License
> +	along with this program; if not, write to the
> +	Free Software Foundation, Inc.,
> +	59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/workqueue.h>
> +#include <linux/list.h>
> +#include <linux/input.h>
> +#include <linux/rfkill.h>
> +
> +#include <asm/semaphore.h>
> +
> +MODULE_AUTHOR("Ivo van Doorn <IvDoorn@gmail.com>");
> +MODULE_VERSION("1.0");
> +MODULE_DESCRIPTION("RF key support");
> +MODULE_LICENSE("GPL");
> +
> +/*
> + * rfkill key structure.
> + */
> +struct rfkill_key {
> +	/*
> +	 * For sysfs representation.
> +	 */
> +	struct class_device *cdev;
> +
> +	/*
> +	 * Pointer to rfkill structure
> +	 * that was filled in by key driver.
> +	 */
> +	struct rfkill *rfkill;
> +
> +	/*
> +	 * Pointer to type structure that this key belongs to.
> +	 */
> +	struct rfkill_type *type;
> +
> +	/*
> +	 * Once key status change has been detected, the toggled
> +	 * field should be set to indicate a notification to
> +	 * user or driver should be performed.
> +	 */
> +	int toggled;
> +
> +	/*
> +	 * Current state of the device radio, this state will
> +	 * change after the radio has actually been toggled since
> +	 * receiving the radio key event.
> +	 */
> +	int radio_status;
> +
> +	/*
> +	 * Current status of the key which controls the radio,
> +	 * this value will change after the key state has changed
> +	 * after polling, or the key driver has send the new state
> +	 * manually.
> +	 */
> +	int key_status;
> +
> +	/*
> +	 * Input device for this key,
> +	 * we also keep track of the number of
> +	 * times this input device is open. This
> +	 * is important for determining to whom we
> +	 * should report key events.
> +	 */
> +	struct input_dev *input;
> +	unsigned int open_count;
> +
> +	/*
> +	 * Key index number.
> +	 */
> +	unsigned int key_index;
> +
> +	/*
> +	 * List head structure to be used
> +	 * to add this structure to the list.
> +	 */
> +	struct list_head entry;
> +};
> +
> +/*
> + * rfkill key type structure.
> + */
> +struct rfkill_type {
> +	/*
> +	 * For sysfs representation.
> +	 */
> +	struct class_device *cdev;
> +
> +	/*
> +	 * Name of this radio type.
> +	 */
> +	char *name;
> +
> +	/*
> +	 * Key type identification. Value must be any
> +	 * in the key_type enum.
> +	 */
> +	unsigned int key_type;
> +
> +	/*
> +	 * Number of registered keys of this type.
> +	 */
> +	unsigned int key_count;
> +};
> +
> +/*
> + * rfkill master structure.
> + */
> +struct rfkill_master {
> +	/*
> +	 * For sysfs representation.
> +	 */
> +	struct class *class;
> +
> +	/*
> +	 * All access to the master structure
> +	 * and its children (the keys) are protected
> +	 * by this key lock.
> +	 */
> +	struct semaphore key_sem;
> +
> +	/*
> +	 * List of available key types.
> +	 */
> +	struct rfkill_type type[KEY_TYPE_MAX];
> +
> +	/*
> +	 * Total number of registered keys.
> +	 */
> +	unsigned int key_count;
> +
> +	/*
> +	 * Number of keys that require polling
> +	 */
> +	unsigned int poll_required;
> +
> +	/*
> +	 * List of rfkill_key structures.
> +	 */
> +	struct list_head key_list;
> +
> +	/*
> +	 * Work structures for periodic polling,
> +	 * as well as the scheduled radio toggling.
> +	 */
> +	struct work_struct toggle_work;
> +	struct work_struct poll_work;
> +};
> +
> +/*
> + * We only need 1 single master interface,
> + * make this a global variable since we always need it.
> + */
> +static struct rfkill_master *master;
> +
> +/*
> + * Send toggle event to key driver.
> + */
> +static void rfkill_toggle_radio_driver(struct rfkill_key *key)
> +{
> +	struct rfkill *rfkill = key->rfkill;
> +
> +	/*
> +	 * check what the current radio status is, and perform
> +	 * the correct action to toggle the radio. This will make
> +	 * sure the correct event happens when either the key driver
> +	 * of the user has requested to toggle this radio.
> +	 */
> +	if (!key->radio_status && rfkill->enable_radio)
> +		rfkill->enable_radio(rfkill->data);
> +	else if (key->radio_status && rfkill->disable_radio)
> +		rfkill->disable_radio(rfkill->data);
> +
> +	/*
> +	 * Independent of the presence of the enable_radio and
> +	 * disable_radio handler update the radio_status field.
> +	 * Note that this is valid, since if the key driver did
> +	 * not provide the 2 radio handlers, the driver is in
> +	 * charge of correctly setting the radio. This is usually
> +	 * done because the hardware will toggle the radio itself.
> +	 */
> +	key->radio_status = key->key_status;
> +}
> +
> +/*
> + * Send toggle event to userspace through the input device.
> + */
> +static void rfkill_toggle_radio_input(struct rfkill_key *key)
> +{
> +	input_report_key(key->input, KEY_RFKILL, key->key_status);
> +	input_sync(key->input);
> +}
> +
> +/*
> + * Loop through the list of registered keys and
> + * check if key if it has been toggled.
> + */
> +static void rfkill_toggle_radio(void *data)
> +{
> +	struct rfkill_key *key;
> +
> +	down(&master->key_sem);
> +
> +	list_for_each_entry(key, &master->key_list, entry) {
> +
> +		/*
> +		 * If this key hasn't been toggled by either
> +		 * the key driver or the user we can skip this key.
> +		 */
> +		if (!key->toggled)
> +			continue;
> +
> +		/*
> +		 * If the input device has been opened, all events
> +		 * should be send to userspace otherwise the key driver
> +		 * is supposed to handle the event.
> +		 */
> +		if (key->open_count)
> +			rfkill_toggle_radio_input(key);
> +		else
> +			rfkill_toggle_radio_driver(key);
> +
> +		/*
> +		 * Reset the toggled field to allow new toggle events.
> +		 */
> +		key->toggled = 0;
> +	}
> +
> +	up(&master->key_sem);
> +}
> +
> +/*
> + * Check the new status of the key, and determine if the key has been toggled.
> + * This function can be called upon request by the device driver or userspace.
> + */
> +static int rfkill_check_status(struct rfkill_key *key, int status)
> +{
> +	/*
> +	 * A key should be toggled if the current radio status does not
> +	 * match the requested status. This check is required instead of
> +	 * comparing it to the current key status since this function can
> +	 * be called on request of the user as well. The user is able to
> +	 * request a radio toggle to make sure the radio status will match
> +	 * the key status if the new key status has been reported to
> +	 * userspace only.
> +	 * As a safety measure, we won't toggle a key twice.
> +	 */
> +	if (key->radio_status != !!status && !key->toggled) {
> +		key->toggled = 1;
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Wrapper around the rfkill_check_status function, this may only
> + * be called from the device driver status events. Besides calling
> + * rfkill_check_status it will also update the key_status field.
> + */
> +static int rfkill_check_key(struct rfkill_key *key, int status)
> +{
> +	/*
> +	 * Store the new key status value.
> +	 */
> +	key->key_status = !!status;
> +
> +	/*
> +	 * The rest of the work should be done by rfkill_check_status.
> +	 */
> +	return rfkill_check_status(key->rfkill->key, status);
> +}
> +
> +/*
> + * Handler that is run frequently to determine the current status
> + * of all registered keys that require polling.
> + */
> +static void rfkill_list_poll(void *data)
> +{
> +	struct rfkill_key *key;
> +	struct rfkill *rfkill;
> +	int status = 0;
> +
> +	down(&master->key_sem);
> +
> +	list_for_each_entry(key, &master->key_list, entry) {
> +		rfkill = key->rfkill;
> +
> +		/*
> +		 * If the poll handler has not been given
> +		 * the key driver should report events,
> +		 * so we can ignore this key now.
> +		 */
> +		if (!rfkill->poll)
> +			continue;
> +
> +		/*
> +		 * Poll radio state and check if a radio toggle
> +		 * has been requested by the key.
> +		 */
> +		if (rfkill_check_key(key, rfkill->poll(rfkill->data)))
> +			status = 1;
> +	}
> +
> +	up(&master->key_sem);
> +
> +	/*
> +	 * A radio toggle has been requested, schedule the toggle work thread.
> +	 */
> +	if (status)
> +		schedule_work(&master->toggle_work);
> +
> +	/*
> +	 * Check if we need to rearm ourselves.
> +	 */
> +	if (master->poll_required)
> +		schedule_delayed_work(&master->poll_work, RFKILL_POLL_DELAY);
> +}
> +
> +/*
> + * Function called by the key driver to report the new status
> + * of the key.
> + */
> +void rfkill_report_event(struct rfkill *rfkill, int new_status)
> +{
> +	down(&master->key_sem);
> +
> +	if (rfkill_check_key(rfkill->key, new_status))
> +		schedule_work(&master->toggle_work);
> +
> +	up(&master->key_sem);
> +}
> +EXPORT_SYMBOL_GPL(rfkill_report_event);
> +
> +/*
> + * Sysfs handler to release the data when sysfs is cleaning
> + * up all the garbage. This is done in a late state since the
> + * user could still be reading some of the files at the moment
> + * this key was removed.
> + * This method is being used for both rfkill_key as rfkill_type
> + * class devices. So be careful not to do anything structure
> + * specific.
> + */
> +static void rfkill_class_device_release(struct class_device *cdev)
> +{
> +	kfree(class_get_devdata(cdev));
> +}
> +
> +/*
> + * rfkill master sysfs creation.
> + */
> +static int rfkill_master_sysfs_create(struct rfkill_master *master)
> +{
> +	master->class = class_create(THIS_MODULE, "rfkill");
> +	if (unlikely(!master->class || IS_ERR(master->class)))
> +		return PTR_ERR(master->class);
> +
> +	master->class->release = rfkill_class_device_release;
> +
> +	return 0;
> +}
> +
> +/*
> + * rfkill master sysfs destroy.
> + */
> +static void rfkill_master_sysfs_release(struct rfkill_master *master)
> +{
> +	class_destroy(master->class);
> +}
> +
> +/*
> + * rfkill type sysfs creation.
> + */
> +static int rfkill_type_sysfs_create(struct rfkill_master *master,
> +				    struct rfkill_type *type)
> +{
> +	type->cdev = class_device_create(master->class, NULL, type->key_type,
> +					 NULL, type->name);
> +	if (unlikely(!type->cdev || IS_ERR(type->cdev)))
> +		return PTR_ERR(type->cdev);
> +
> +	return 0;
> +}
> +
> +static void rfkill_type_sysfs_release(struct rfkill_type *type)
> +{
> +	class_device_destroy(type->cdev->class, type->key_type);
> +}
> +
> +/*
> + * rfkill key attribute to display the current key status.
> + */
> +static ssize_t rfkill_key_status_show(struct class_device *cdev, char *buf)
> +{
> +	struct rfkill_key *key = class_get_devdata(cdev);
> +
> +	if (!capable(CAP_NET_ADMIN))
> +		return -EPERM;
> +
> +	return sprintf(buf, "%d", key->key_status);
> +}
> +
> +/*
> + * rfkill key attribute to change the current radio status.
> + */
> +static ssize_t rfkill_key_status_store(struct class_device *cdev,
> +				      const char *buf, size_t count)
> +{
> +	struct rfkill_key *key = class_get_devdata(cdev);
> +	int status = simple_strtoul(buf, NULL, 0);
> +
> +	if (!capable(CAP_NET_ADMIN))
> +		return -EPERM;
> +
> +	down(&master->key_sem);
> +
> +	/*
> +	 * Check if this new status implies that the radio
> +	 * should be toggled to the correct state.
> +	 */
> +	if (rfkill_check_status(key, status))
> +		schedule_work(&master->toggle_work);
> +
> +	up(&master->key_sem);
> +
> +	return count;
> +}
> +
> +static struct class_device_attribute cdev_attr_key_status =
> +	__ATTR(status, S_IRUGO | S_IWUGO,
> +	       rfkill_key_status_show, rfkill_key_status_store);
> +
> +/*
> + * rfkill key sysfs creation.
> + */
> +static int rfkill_key_sysfs_create(struct rfkill_master *master,
> +				    struct rfkill_key *key)
> +{
> +	int status;
> +
> +	key->cdev = class_device_create(master->class, key->type->cdev,
> +					KEY_TYPE_MAX + key->key_index,
> +					key->rfkill->dev,
> +					"key%d", key->key_index);
> +	if (unlikely(!key->cdev || IS_ERR(key->cdev)))
> +		return PTR_ERR(key->cdev);
> +
> +	/*
> +	 * Create the sysfs files.
> +	 */
> +	status = class_device_create_file(key->cdev, &cdev_attr_key_status);
> +	if (unlikely(status))
> +		goto exit;
> +
> +	/*
> +	 * The key belongs to the device structure the key driver
> +	 * has given us a reference to. But besides that device
> +	 * this key also belongs to the input device that has been
> +	 * created. We should create the link to that entry manually.
> +	 */
> +	status = sysfs_create_link(&key->cdev->kobj, &key->input->cdev.kobj,
> +				   "idev");
> +	if (unlikely(status))
> +		goto exit_file;
> +
> +	return 0;
> +
> +exit_file:
> +	class_device_remove_file(key->cdev, &cdev_attr_key_status);
> +
> +exit:
> +	class_device_destroy(master->class, KEY_TYPE_MAX + key->key_index);
> +
> +	return status;
> +}
> +
> +static void rfkill_key_sysfs_release(struct rfkill_key *key)
> +{
> +	sysfs_remove_link(&key->cdev->kobj, "idev");
> +	class_device_remove_file(key->cdev, &cdev_attr_key_status);
> +	class_device_destroy(master->class, KEY_TYPE_MAX + key->key_index);
> +}
> +
> +/*
> + * Handlers to enable or close the input device.
> + * These handlers only have to increase or decrease the open_count,
> + * this counter will automatically make sure key events will be
> + * send to the correct location (userspace or key driver).
> + */
> +static int rfkill_open(struct input_dev *dev)
> +{
> +	((struct rfkill_key*)(dev->private))->open_count++;
> +	return 0;
> +}
> +	
> +static void rfkill_close(struct input_dev *dev)
> +{
> +	((struct rfkill_key*)(dev->private))->open_count--;
> +}
> +
> +/*
> + * Input device initialization handler.
> + */
> +static struct input_dev* rfkill_register_input(struct rfkill_key *key)
> +{
> +	struct input_dev *input;
> +	int status;
> +	char *name;
> +	char *phys;
> +
> +	input = input_allocate_device();
> +	if (unlikely(!input))
> +		return NULL;
> +
> +	/*
> +	 * Link the private data to rfkill structure.
> +	 */
> +	input->private = key;
> +
> +	/*
> +	 * Allocate the strings for the input device names.
> +	 */
> +	name = kasprintf(GFP_KERNEL, "rfkill key%d: %s",
> +			 key->key_index, key->rfkill->dev_name);
> +	phys = kasprintf(GFP_KERNEL, "rfkill/%s/key%d",
> +			 key->type->name, key->key_index);
> +
> +	if (!name || !phys)
> +		goto exit;
> +
> +	input->name = name;
> +	input->phys = phys;
> +
> +	/*
> +	 * Initialize the input_id structure.
> +	 */
> +	input->id.bustype = BUS_HOST;
> +	input->id.vendor = 0x0001;
> +	input->id.product = 0x0001;
> +	input->id.version = 0x0001;
> +
> +	input->evbit[0] = BIT(EV_KEY);
> +	set_bit(KEY_RFKILL, input->keybit);
> +
> +	input->open = rfkill_open;
> +	input->close = rfkill_close;
> +
> +	status = input_register_device(input);
> +	if (status)
> +		goto exit;
> +
> +	return input;
> +
> +exit:
> +	input_free_device(input);
> +
> +	kfree(name);
> +	kfree(phys);
> +
> +	return NULL;
> +}
> +
> +/*
> + * Input device deinitialization handler.
> + */
> +static void rfkill_deregister_input(struct rfkill_key *key)
> +{
> +	const char *name;
> +	const char *phys;
> +
> +	/*
> +	 * The name and phys fields have been allocated
> +	 * using kasprintf, this means they have to be
> +	 * freed seperately.
> +	 */
> +	name = key->input->name;
> +	phys = key->input->phys;
> +
> +	input_unregister_device(key->input);
> +	kfree(name);
> +	kfree(phys);
> +}
> +
> +/*
> + * Rfkill key initialization/deinitialization.
> + * These methods should only be called with the key_sem held.
> + */
> +static struct rfkill_key* rfkill_key_init(struct rfkill *rfkill, int status)
> +{
> +	struct rfkill_key *key;
> +
> +	key = kzalloc(sizeof(struct rfkill_key), GFP_KERNEL);
> +	if (unlikely(!key))
> +		return NULL;
> +
> +	/*
> +	 * Initialize all variables.
> +	 */
> +	key->rfkill = rfkill;
> +	rfkill->key = key;
> +	key->type = &master->type[rfkill->key_type];
> +	key->toggled = 0;
> +	key->radio_status = status;
> +	key->key_status = status;
> +	key->key_index = master->key_count++;
> +	INIT_LIST_HEAD(&key->entry);
> +
> +	/*
> +	 * Create input device.
> +	 */
> +	key->input = rfkill_register_input(key);
> +	if (!key->input)
> +		goto exit;
> +
> +	/*
> +	 * Create sysfs entry.
> +	 */
> +	if (rfkill_key_sysfs_create(master, key))
> +		goto exit;
> +
> +	return key;
> +
> +exit:
> +	rfkill_deregister_input(key);
> +	rfkill->key = NULL;
> +	kfree(key);
> +	return NULL;
> +}
> +
> +static void rfkill_key_deinit(struct rfkill_key *key)
> +{
> +	if (key) {
> +		rfkill_key_sysfs_release(key);
> +		rfkill_deregister_input(key);
> +	}
> +}
> +
> +/*
> + * Rfkill type handler to check if the sysfs entries should
> + * be created or removed based on the number of registered keys.
> + */
> +static int rfkill_add_type_key(struct rfkill_type *type)
> +{
> +	int status;
> +
> +	if (type->key_count) {
> +		type->key_count++;
> +		return 0;
> +	}
> +
> +	status = rfkill_type_sysfs_create(master, type);
> +	if (status)
> +		return status;
> +
> +	type->key_count = 1;
> +	return 0;
> +}
> +
> +static void rfkill_del_type_key(struct rfkill_type *type)
> +{
> +	if (!--type->key_count)
> +		rfkill_type_sysfs_release(type);
> +}
> +
> +/*
> + * Function called by the key driver when the rfkill structure
> + * needs to be registered.
> + */
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
> +	down(&master->key_sem);
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
> +	up(&master->key_sem);
> +
> +	return 0;
> +
> +exit_type:
> +	rfkill_del_type_key(type);
> +
> +exit:
> +	up(&master->key_sem);
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
> +int rfkill_deregister_key(struct rfkill *rfkill)
> +{
> +	struct rfkill_type *type;
> +
> +	if (!rfkill || !rfkill->key)
> +		return -EINVAL;
> +
> +	down(&master->key_sem);
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
> +	up(&master->key_sem);
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
> +
> +/*
> + * Rfkill type initialization.
> + */
> +static void rfkill_type_init(unsigned int key_type, char *name)
> +{
> +	struct rfkill_type *type = &master->type[key_type];
> +
> +	/*
> +	 * Initialize all variables.
> +	 */
> +	type->name = name;
> +	type->key_type = key_type;
> +	type->key_count = 0;
> +}
> +
> +/*
> + * Rfkill master initialization/deinitialization.
> + */
> +static int rfkill_master_init(void)
> +{
> +	int status;
> +
> +	master = kzalloc(sizeof(struct rfkill_master), GFP_KERNEL);
> +	if (unlikely(!master))
> +		return -ENOMEM;
> +
> +	/*
> +	 * Initialize all variables.
> +	 */
> +	init_MUTEX(&master->key_sem);
> +	INIT_LIST_HEAD(&master->key_list);
> +	INIT_WORK(&master->toggle_work, &rfkill_toggle_radio, NULL);
> +	INIT_WORK(&master->poll_work, &rfkill_list_poll, NULL);
> +
> +	/*
> +	 * Initialize all type structures.
> +	 */
> +	rfkill_type_init(KEY_TYPE_WIFI, "wifi");
> +	rfkill_type_init(KEY_TYPE_BlUETOOTH, "bluetooth");
> +	rfkill_type_init(KEY_TYPE_IRDA, "irda");
> +
> +	/*
> +	 * Create sysfs entry.
> +	 */
> +	status = rfkill_master_sysfs_create(master);
> +	if (status) {
> +		kfree(master);
> +		master = NULL;
> +		return status;
> +	}
> +
> +	return 0;
> +}
> +
> +static void rfkill_master_deinit(void)
> +{
> +	if (master) {
> +		rfkill_master_sysfs_release(master);
> +		kfree(master);
> +		master = NULL;
> +	}
> +}
> +
> +/*
> + * Module initialization/deinitialization.
> + */
> +static int __init rfkill_init(void)
> +{
> +	printk(KERN_INFO "Loading rfkill driver.\n");
> +
> +	return rfkill_master_init();
> +}
> +
> +static void __exit rfkill_exit(void)
> +{
> +	rfkill_master_deinit();
> +
> +	printk(KERN_INFO "Unloading rfkill driver.\n");
> +}
> +
> +module_init(rfkill_init);
> +module_exit(rfkill_exit);
> diff --git a/include/linux/input.h b/include/linux/input.h
> index c38507b..1b44108 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -491,6 +491,7 @@ struct input_absinfo {
>  #define KEY_DIGITS		0x19d
>  #define KEY_TEEN		0x19e
>  #define KEY_TWEN		0x19f
> +#define KEY_RFKILL		0x1a0
>  
>  #define KEY_DEL_EOL		0x1c0
>  #define KEY_DEL_EOS		0x1c1
> diff --git a/include/linux/rfkill.h b/include/linux/rfkill.h
> new file mode 100644
> index 0000000..a455548
> --- /dev/null
> +++ b/include/linux/rfkill.h
> @@ -0,0 +1,140 @@
> +/*
> +	Copyright (C) 2006 Ivo van Doorn
> +
> +	This program is free software; you can redistribute it and/or modify
> +	it under the terms of the GNU General Public License as published by
> +	the Free Software Foundation; either version 2 of the License, or
> +	(at your option) any later version.
> +
> +	This program is distributed in the hope that it will be useful,
> +	but WITHOUT ANY WARRANTY; without even the implied warranty of
> +	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> +	GNU General Public License for more details.
> +
> +	You should have received a copy of the GNU General Public License
> +	along with this program; if not, write to the
> +	Free Software Foundation, Inc.,
> +	59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
> + */
> +
> +/*
> +	RF button support
> +	Laptops are quite often equiped with a RF key to enable or
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
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

