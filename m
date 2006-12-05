Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968139AbWLELVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968139AbWLELVB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 06:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968085AbWLELVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 06:21:01 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34218 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S968139AbWLELU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 06:20:59 -0500
Date: Tue, 5 Dec 2006 12:20:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Honkala Mikko <honkkis@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: in HP nx8220 S3 resume does not work in stock kernels 2.6.15-2.6.19. Ide light stays on.
Message-ID: <20061205112043.GA7026@elf.ucw.cz>
References: <bcfd8020612010936h276a1d04mf2cc574cf62cd242@mail.gmail.com> <bcfd8020612042248l31a7e053n6cf69ef80f0fed0b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcfd8020612042248l31a7e053n6cf69ef80f0fed0b@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> in HP nx8220 S3 resume does not work in stock kernels 2.6.15-2.6.19.
> Ide light stays on.
> 
> The attached patch for ide.c for 2.6.18.2 fixes this for me, but the
> patch does not apply anymore in  2.6.19.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=2039
> http://bugzilla.kernel.org/show_bug.cgi?id=5604

I think I've seen better versions of this patch, already...?

Ask ACPI people.

> --- linux-2.6.18.2-orig/drivers/ide/ide.c	2006-11-04 03:33:58.000000000 +0200
> +++ linux-2.6.18.2/drivers/ide/ide.c	2006-11-11 00:44:44.000000000 +0200
> @@ -1207,6 +1207,237 @@
>  
>  EXPORT_SYMBOL(system_bus_clock);
>  
> +#if 1
> +#include <linux/acpi.h>
> +#define DBG(x...) printk(x)

...this definitely needs to move to some ACPIish place.
										Pavel

> +static int ide_acpi_find_device(struct device *dev, acpi_handle *handle)
> +{
> +	int i, tmp;
> +	acpi_integer addr;
> +
> +	if (sscanf(dev->bus_id, "%u.%u", &tmp, &i) != 2)
> +		return -ENODEV;
> +
> +	addr = i;
> +	*handle = acpi_get_child(DEVICE_ACPI_HANDLE(dev->parent), addr);
> +	if (!*handle)
> +		return -ENODEV;
> +	return 0;
> +}
> +
> +/* This assumes the ide controller is a PCI device */
> +static int ide_acpi_find_channel(struct device *dev, acpi_handle *handle)
> +{
> +	int num;
> +	int channel;
> +	acpi_integer addr;
> +
> +	num = sscanf(dev->bus_id, "ide%x", &channel);
> +
> +	if (num != 1 || !dev->parent)
> +		return -ENODEV;
> +	addr = channel;
> +	*handle = acpi_get_child(DEVICE_ACPI_HANDLE(dev->parent), addr);
> +	if (!*handle)
> +		return -ENODEV;
> +	return 0;
> +}
> +
> +static struct acpi_bus_type ide_acpi_bus = {
> +	.bus = &ide_bus_type,
> +	.find_device = ide_acpi_find_device,
> +	.find_bridge = ide_acpi_find_channel,
> +};
> +
> +static int __init ide_acpi_init(void)
> +{
> +	return register_acpi_bus_type(&ide_acpi_bus);
> +}
> +
> +#define MAX_DEVICES 10
> +#define GTM_LEN (sizeof(u32) * 5)
> +static struct acpi_ide_stat {
> +	acpi_handle handle; /* channel device"s handle */
> +	u32	gtm[GTM_LEN/sizeof(u32)]; /* info from _GTM */
> +	struct hd_driveid id_buff[2];
> +	int channel_handled;
> +} device_state[MAX_DEVICES];
> +
> +static struct acpi_ide_stat *ide_get_acpi_state(acpi_handle handle)
> +{
> +	int i;
> +	for (i = 0; i < MAX_DEVICES; i ++)
> +		if (device_state[i].handle == handle)
> +			break;
> +	if (i < MAX_DEVICES)
> +		return &device_state[i];
> +	for (i = 0; i < MAX_DEVICES; i ++)
> +		if (device_state[i].handle == NULL)
> +			break;
> +	if (i >= MAX_DEVICES)
> +		return NULL;
> +
> +	memset(&device_state[i], 0, sizeof(struct acpi_ide_stat));
> +	return &device_state[i];
> +}
> +
> +int acpi_ide_suspend(struct device *dev)
> +{
> +	acpi_handle handle, parent_handle;
> +	struct acpi_ide_stat *stat;
> +	acpi_status	status;
> +	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> +	union acpi_object *package;
> +	ide_drive_t *drive = dev->driver_data;
> +	int drive_id = 0;
> +
> +	handle = DEVICE_ACPI_HANDLE(dev);
> +	if (!handle) {
> +		DBG("IDE device ACPI handler is NULL\n");
> +		return -ENODEV;
> +	}
> +	if (ACPI_FAILURE(acpi_get_parent(handle, &parent_handle))) {
> +		printk(KERN_ERR "ACPI get parent handler error\n");
> +		return -ENODEV;
> +	}
> +	stat = ide_get_acpi_state(parent_handle);
> +	if (stat == NULL)
> +		return -ENODEV;
> +	if (stat->channel_handled) {
> +		drive_id = 1;
> +		goto id;
> +	}
> +
> +	status = acpi_evaluate_object(parent_handle, "_GTM", NULL, &buffer);
> +	if (ACPI_FAILURE(status)) {
> +		printk(KERN_ERR "Error evaluating _GTM\n");
> +		return -ENODEV;
> +	}
> +	package = (union acpi_object *) buffer.pointer;
> +	if (package->buffer.length != GTM_LEN) {
> +		printk(KERN_ERR "Buffer length returned by _GTM is wrong\n");
> +		kfree(buffer.pointer);
> +		return -ENODEV;
> +	}
> +	memcpy(stat->gtm, package->buffer.pointer, GTM_LEN);
> +	stat->handle = parent_handle;
> +	stat->channel_handled = 1;
> +	kfree(buffer.pointer);
> +id:
> +	taskfile_lib_get_identify(drive, &stat->id_buff[drive_id]);
> +	DBG("GTM info %x,%x,%x,%x,%x\n", stat->gtm[0],
> +		stat->gtm[1], stat->gtm[2],
> +		stat->gtm[3], stat->gtm[4]);
> +	return 0;
> +}
> +
> +static int acpi_ide_stm(struct acpi_ide_stat *stat)
> +{
> +	struct acpi_object_list input;
> +	union acpi_object params[3];
> +	acpi_status status;
> +
> +	input.count = 3;
> +	input.pointer = params;
> +	params[0].type = ACPI_TYPE_BUFFER;
> +	params[0].buffer.length = sizeof(stat->gtm);
> +	params[0].buffer.pointer = (char*)stat->gtm;
> +
> +	params[1].type = ACPI_TYPE_BUFFER;
> +	params[1].buffer.length = sizeof(stat->id_buff[0]);
> +	params[1].buffer.pointer = (char *)&stat->id_buff[0];
> +
> +	params[2].type = ACPI_TYPE_BUFFER;
> +	params[2].buffer.length = sizeof(stat->id_buff[1]);
> +	params[2].buffer.pointer = (char *)&stat->id_buff[1];
> +
> +	status = acpi_evaluate_object(stat->handle, "_STM", &input, NULL);
> +	if (ACPI_FAILURE(status)) {
> +		printk(KERN_ERR "Evaluating _STM error\n");
> +		return -ENODEV;
> +	}
> +	return 0;
> +}
> +
> +static int acpi_ide_gtf(acpi_handle handle, ide_drive_t *drive)
> +{
> +	struct acpi_buffer	output = {ACPI_ALLOCATE_BUFFER, NULL};
> +	ide_task_t	args;
> +	int index = 0;
> +	unsigned char *data;
> +	union acpi_object	*package = NULL;
> +	acpi_status status;
> +
> +	status = acpi_evaluate_object(handle, "_GTF", NULL, &output);
> +	if (ACPI_FAILURE(status)) {
> +		printk(KERN_ERR "evaluate _GTF error\n");
> +		return -ENODEV;
> +	}
> +	package = (union acpi_object *) output.pointer;
> +	if (package->type != ACPI_TYPE_BUFFER
> +		|| (package->buffer.length % 7) != 0) {
> +		kfree(output.pointer);
> +		printk(KERN_ERR "_GTF returned value is wrong\n");
> +		return -ENODEV;
> +	}
> +	printk("start GTF\n");
> +
> +	data = package->buffer.pointer;
> +	while (index < package->buffer.length) {
> +		memset(&args, 0, sizeof(ide_task_t));
> +		args.tfRegister[IDE_ERROR_OFFSET] = data[index];
> +		args.tfRegister[IDE_NSECTOR_OFFSET] = data[index + 1];
> +		args.tfRegister[IDE_SECTOR_OFFSET] = data[index + 2];
> +		args.tfRegister[IDE_LCYL_OFFSET] = data[index + 3];
> +		args.tfRegister[IDE_HCYL_OFFSET] = data[index + 4];
> +		args.tfRegister[IDE_SELECT_OFFSET] = data[index + 5];
> +		args.tfRegister[IDE_STATUS_OFFSET] = data[index + 6];
> +		args.command_type = IDE_DRIVE_TASK_NO_DATA;
> +		args.handler = &task_no_data_intr;
> +		printk("data %x,%x,%x,%x,%x,%x,%x\n",
> +			data[index], data[index+1], data[index+2],
> +			data[index+3],data[index+4],data[index+5],
> +			data[index+6]);
> +		/* submit command request */
> +//		printk("return value %d\n", ide_raw_taskfile(drive, &args, NULL));
> +		index += 7;
> +	}
> +	kfree(output.pointer);
> +	return 0;
> +}
> +
> +int acpi_ide_resume(struct device *dev)
> +{
> +	acpi_handle handle, parent_handle;
> +	struct acpi_ide_stat *stat;
> +	ide_drive_t *drive = dev->driver_data;
> +
> +	handle = DEVICE_ACPI_HANDLE(dev);
> +	if (!handle) {
> +		DBG("IDE device ACPI handler is NULL\n");
> +		return -ENODEV;
> +	}
> +	if (ACPI_FAILURE(acpi_get_parent(handle, &parent_handle))) {
> +		printk(KERN_ERR "ACPI get parent handler error\n");
> +		return -ENODEV;
> +	}
> +	stat = ide_get_acpi_state(parent_handle);
> +	if (stat == NULL || stat->handle != parent_handle)
> +		return -ENODEV;
> +
> +	if (stat->channel_handled == 0) {
> +		stat->handle = NULL;
> +		goto gtf;
> +	}
> +DBG("Start STM\n");
> +	if (acpi_ide_stm(stat))
> +		return -ENODEV;
> +	stat->channel_handled = 0;
> +gtf:
> +	return acpi_ide_gtf(handle, drive);
> +}
> +#endif
> +
>  static int generic_ide_suspend(struct device *dev, pm_message_t state)
>  {
>  	ide_drive_t *drive = dev->driver_data;
> @@ -1223,6 +1454,7 @@
>  	rqpm.pm_step = ide_pm_state_start_suspend;
>  	rqpm.pm_state = state.event;
>  
> +	acpi_ide_suspend(dev);
>  	return ide_do_drive_cmd(drive, &rq, ide_wait);
>  }
>  
> @@ -1232,7 +1464,7 @@
>  	struct request rq;
>  	struct request_pm_state rqpm;
>  	ide_task_t args;
> -
> +	acpi_ide_resume(dev);
>  	memset(&rq, 0, sizeof(rq));
>  	memset(&rqpm, 0, sizeof(rqpm));
>  	memset(&args, 0, sizeof(args));
> @@ -1994,6 +2226,7 @@
>  	printk(KERN_INFO "Uniform Multi-Platform E-IDE driver " REVISION "\n");
>  	system_bus_speed = ide_system_bus_speed();
>  
> +ide_acpi_init();
>  	bus_register(&ide_bus_type);
>  
>  	init_ide_data();


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
