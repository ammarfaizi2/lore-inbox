Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932670AbVLGAL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932670AbVLGAL3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 19:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932671AbVLGAL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 19:11:29 -0500
Received: from xenotime.net ([66.160.160.81]:37101 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932670AbVLGAL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 19:11:28 -0500
Date: Tue, 6 Dec 2005 16:11:23 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Shaohua Li <shaohua.li@intel.com>
cc: linux-ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
       pavel <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>, akpm <akpm@osdl.org>
Subject: Re: [RFC]add ACPI hooks for IDE suspend/resume
In-Reply-To: <1133849404.3026.10.camel@sli10-mobl.sh.intel.com>
Message-ID: <Pine.LNX.4.58.0512061557420.5519@shark.he.net>
References: <1133849404.3026.10.camel@sli10-mobl.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Dec 2005, Shaohua Li wrote:

> Hi,
> Adding ACPI IDE hook in IDE suspend/resume. The ACPI spec
> explicitly says we must call some ACPI methods to restore IDE drives.
> The sequences defined by ACPI spec are:
> suspend:
> 1. Get the DMA and PIO info from IDE channel's _GTM method.
>
> resume:
> 1. Calling IDE channel's _STM to set the transfer timing setting.
> 2. For each drive on the IDE channel, running drive's _GTF to get the
> ATA commands required to reinitialize each drive.
> 3. Sending the ATA commands gotton from step 2 to drives.
>
> TODO: invoking ATA commands.
>
> Though we didn't invoke ATA commands, this patch fixes the bug at
> http://bugzilla.kernel.org/show_bug.cgi?id=5604. And Matthew said this
> actually fixes a lot of systems in his test.
> I'm not familiar with IDE, so comments/suggestions are welcome.
>
> ---
>
>  linux-2.6.15-rc5-root/drivers/ide/ide.c |  282 ++++++++++++++++++++++++++++++++
>  1 files changed, 282 insertions(+)
>
> diff -puN drivers/ide/ide.c~acpi-ide drivers/ide/ide.c
> --- linux-2.6.15-rc5/drivers/ide/ide.c~acpi-ide	2005-12-07 03:01:36.000000000 +0800
> +++ linux-2.6.15-rc5-root/drivers/ide/ide.c	2005-12-07 03:01:36.000000000 +0800
> @@ -155,6 +155,10 @@
>  #include <linux/device.h>
>  #include <linux/bitops.h>
>
> +#ifdef CONFIG_ACPI
> +#include <linux/acpi.h>
> +#endif

Shouldn't need or use ifdef/endif for #includes.

>  #include <asm/byteorder.h>
>  #include <asm/irq.h>
>  #include <asm/uaccess.h>
> @@ -1214,6 +1218,279 @@ int system_bus_clock (void)
>
>  EXPORT_SYMBOL(system_bus_clock);
>
> +#ifdef CONFIG_ACPI
> +static int ide_acpi_find_device(struct device *dev, acpi_handle *handle)
> +{
> +	int i, tmp;
> +	acpi_integer addr;
> +
> +	if (sscanf(dev->bus_id, "%u.%u", &tmp, &i) != 2)
> +		return -ENODEV;
> +
> +	addr = (acpi_integer)i;
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
> +	addr = (acpi_integer)channel;
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
> +/* The _GTM return package length is 5 dwords */
> +#define GTM_LEN (sizeof(u32) * 5)
> +struct acpi_ide_state {
> +	acpi_handle handle; /* channel device's handle */
> +	u32 gtm[GTM_LEN/sizeof(u32)]; /* info from _GTM */
> +	struct hd_driveid id_buff[2]; /* one chanel has two drives */

s/2/MAX_DRIVES/
s/chanel/channel/

> +	int suspend_drives;
> +	int resume_drives;
> +};
> +
> +static void acpi_ide_data_handler(acpi_handle handle,
> +	u32 function, void *context)
> +{
> +	/* nothing to do */
> +}
> +
> +/* acpi data for a chanel */

s/chanel/channel/

> +static struct acpi_ide_state *ide_alloc_acpi_state(acpi_handle handle)
> +{
> +	struct acpi_ide_state * state;
> +	acpi_status status;
> +
> +	state = kzalloc(sizeof(struct acpi_ide_state), GFP_KERNEL);
> +	if (!state)
> +		return NULL;
> +	status = acpi_attach_data(handle, acpi_ide_data_handler, state);
> +	if (ACPI_FAILURE(status))
> +		return NULL;
> +	return state;
> +}
> +
> +static struct acpi_ide_state *ide_get_acpi_state(acpi_handle handle)
> +{
> +	struct acpi_ide_state * state;
> +	acpi_status status;
> +
> +	status = acpi_get_data(handle, acpi_ide_data_handler, (void **)&state);
> +	if (ACPI_FAILURE(status))
> +		return NULL;
> +	return state;
> +}
> +
> +static void ide_free_acpi_state(acpi_handle handle)
> +{
> +	struct acpi_ide_state *state;
> +
> +	state = ide_get_acpi_state(handle);
> +	acpi_detach_data(handle, acpi_ide_data_handler);
> +	kfree(state);
> +}
> +
> +static int acpi_ide_suspend(struct device *dev)
> +{
> +	acpi_handle handle, parent_handle;
> +	struct acpi_ide_state *state;
> +	acpi_status status;
> +	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> +	union acpi_object *package;
> +	ide_drive_t *drive = dev->driver_data;
> +	int drive_id = 0;
> +
> +	handle = DEVICE_ACPI_HANDLE(dev);
> +	if (!handle) {
> +		printk(KERN_DEBUG "IDE device's ACPI handler is NULL\n");

s/handler/handle/ ??

> +		return -ENODEV;
> +	}
> +	if (ACPI_FAILURE(acpi_get_parent(handle, &parent_handle))) {
> +		printk(KERN_ERR "ACPI get parent handler error\n");

s/handler/handle/ ??

> +		return -ENODEV;
> +	}
> +	state = ide_get_acpi_state(parent_handle);
> +	if (!state) {
> +		state = ide_alloc_acpi_state(parent_handle);
> +		if (!state)
> +			return -ENODEV;
> +	}
> +
> +	/* invoke _GTM only once */
> +	state->suspend_drives++;
> +	if (state->suspend_drives > 1) {
> +		drive_id = 1;
> +		goto id;
> +	}
> +
> +	status = acpi_evaluate_object(parent_handle, "_GTM", NULL, &buffer);
> +	if (ACPI_FAILURE(status)) {
> +		printk(KERN_ERR "Error evaluating _GTM\n");

I don't read the ACPI spec. as saying that _GTM is required, (?)
so I would make this a KERN_DEBUG instead of KERN_ERR.

> +		return -ENODEV;
> +	}
> +	package = (union acpi_object *) buffer.pointer;
> +	if (package->buffer.length != GTM_LEN) {
> +		printk(KERN_ERR "Buffer length returned by _GTM is wrong\n");
> +		acpi_os_free(buffer.pointer);
> +		return -ENODEV;
> +	}
> +	memcpy(state->gtm, package->buffer.pointer, GTM_LEN);
> +	state->handle = parent_handle;
> +	acpi_os_free(buffer.pointer);
> +id:
> +	taskfile_lib_get_identify(drive, (u8*)&state->id_buff[drive_id]);
> +	return 0;
> +}
> +
> +static int acpi_ide_invoke_stm(struct acpi_ide_state *state)
> +{
> +	struct acpi_object_list input;
> +	union acpi_object params[3];
> +	acpi_status status;
> +
> +	input.count = 3;
> +	input.pointer = params;
> +	params[0].type = ACPI_TYPE_BUFFER;
> +	params[0].buffer.length = sizeof(state->gtm);
> +	params[0].buffer.pointer = (char*)state->gtm;
> +
> +	params[1].type = ACPI_TYPE_BUFFER;
> +	params[1].buffer.length = sizeof(state->id_buff[0]);
> +	params[1].buffer.pointer = (char *)&state->id_buff[0];
> +
> +	params[2].type = ACPI_TYPE_BUFFER;
> +	params[2].buffer.length = sizeof(state->id_buff[1]);
> +	params[2].buffer.pointer = (char *)&state->id_buff[1];
> +
> +	status = acpi_evaluate_object(state->handle, "_STM", &input, NULL);
> +	if (ACPI_FAILURE(status)) {
> +		printk(KERN_ERR "Evaluating _STM error\n");

Same as for _GTM, KERN_DEBUG instead of KERN_ERR.

> +		return -ENODEV;
> +	}
> +	return 0;
> +}
> +
> +static int acpi_ide_invoke_gtf(acpi_handle handle, ide_drive_t *drive)
> +{
> +	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
> +#if 0
> +	ide_task_t args;
> +	int index = 0;
> +	unsigned char *data;
> +#endif
> +	union acpi_object *package;
> +	acpi_status status;
> +
> +	status = acpi_evaluate_object(handle, "_GTF", NULL, &output);
> +	if (ACPI_FAILURE(status)) {
> +		printk(KERN_ERR "evaluate _GTF error\n");

KERN_DEBUG if not present since it's not required AFAIK.

> +		return -ENODEV;
> +	}
> +
> +	package = (union acpi_object *) output.pointer;
> +	if (package->type != ACPI_TYPE_BUFFER
> +			|| (package->buffer.length % 7) != 0) {
> +		acpi_os_free(output.pointer);
> +		printk(KERN_ERR "_GTF returned value is wrong\n");
> +		return -ENODEV;
> +	}
> +#if 0
> +	printk(KERN_DEBUG "Start invoking _GTF commands\n");
> +
> +	data = package->buffer.pointer;
> +	/* sumbit ATA commands */
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
> +		/* submit command */
> +		index += 7;
> +	}
> +#endif
> +	acpi_os_free(output.pointer);
> +	return 0;
> +}
> +
> +static int acpi_ide_resume(struct device *dev)
> +{
> +	acpi_handle handle, parent_handle;
> +	struct acpi_ide_state *state;
> +	ide_drive_t *drive = dev->driver_data;
> +
> +	handle = DEVICE_ACPI_HANDLE(dev);
> +	if (!handle) {
> +		printk(KERN_DEBUG "IDE device's ACPI handler is NULL\n");

s/handler/handle/ ??

> +		return -ENODEV;
> +	}
> +	if (ACPI_FAILURE(acpi_get_parent(handle, &parent_handle))) {
> +		printk(KERN_ERR "ACPI get parent handler error\n");

s/handler/handle/ ??

> +		return -ENODEV;
> +	}
> +	state = ide_get_acpi_state(parent_handle);
> +	if (state == NULL)
> +		return -ENODEV;
> +
> +	/* invoke _STM only once */
> +	state->resume_drives++;
> +	if (state->resume_drives == 1) {
> +		printk(KERN_DEBUG "Start invoking _STM\n");
> +		if (acpi_ide_invoke_stm(state))
> +			return -ENODEV;
> +	}
> +
> +	if (state->resume_drives == state->suspend_drives)
> +		ide_free_acpi_state(parent_handle);
> +	return acpi_ide_invoke_gtf(handle, drive);
> +}
> +
> +#else
> +static int __init ide_acpi_init(void)
> +{
> +	return 0;
> +}
> +
> +static int acpi_ide_suspend(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int acpi_ide_resume(struct device *dev)
> +{
> +	return 0;
> +}
> +#endif
> +
>  static int generic_ide_suspend(struct device *dev, pm_message_t state)
>  {
>  	ide_drive_t *drive = dev->driver_data;
> @@ -1221,6 +1498,8 @@ static int generic_ide_suspend(struct de
>  	struct request_pm_state rqpm;
>  	ide_task_t args;
>
> +	acpi_ide_suspend(dev);
> +
>  	memset(&rq, 0, sizeof(rq));
>  	memset(&rqpm, 0, sizeof(rqpm));
>  	memset(&args, 0, sizeof(args));
> @@ -1240,6 +1519,8 @@ static int generic_ide_resume(struct dev
>  	struct request_pm_state rqpm;
>  	ide_task_t args;
>
> +	acpi_ide_resume(dev);
> +
>  	memset(&rq, 0, sizeof(rq));
>  	memset(&rqpm, 0, sizeof(rqpm));
>  	memset(&args, 0, sizeof(args));
> @@ -1923,6 +2204,7 @@ static int __init ide_init(void)
>  	system_bus_speed = ide_system_bus_speed();
>
>  	bus_register(&ide_bus_type);
> +	ide_acpi_init();
>
>  	init_ide_data();
>
> _

-- 
~Randy
