Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbWGVTyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWGVTyE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 15:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbWGVTyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 15:54:04 -0400
Received: from outbound-mail-50.bluehost.com ([70.96.188.19]:61668 "HELO
	outbound-mail-50.bluehost.com") by vger.kernel.org with SMTP
	id S1751034AbWGVTyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 15:54:02 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Dave Airlie <airlied@linux.ie>
Subject: Re: [PATCH] gpu: Initial GPU layer addition. (03/07)
Date: Sat, 22 Jul 2006 12:54:06 -0700
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <11535827134076-git-send-email-airlied@linux.ie> <11535827131612-git-send-email-airlied@linux.ie> <11535827132905-git-send-email-airlied@linux.ie>
In-Reply-To: <11535827132905-git-send-email-airlied@linux.ie>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607221254.06817.jbarnes@virtuousgeek.org>
X-Identified-User: {642:box128.bluehost.com:virtuous:virtuousgeek.org} {sentby:smtp auth 70.54.194.129 authed with jbarnes@virtuousgeek.org}
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, July 22, 2006 8:38 am, Dave Airlie wrote:
> +config GPU
> +	bool
> +	default n
> +

Does this change existing userspace ABI or just add a new one (via new 
files in sysfs)?  If the latter, can this config option just be enabled 
by default or killed entirely, making the build dependent on the higher 
level CONFIG_DRM option?

> +/* GPUs we manage */
> +LIST_HEAD(gpu_bus_list);
> +
> +/* used when allocating bus numbers */
> +#define GPU_MAXBUS		16
> +struct gpu_busmap {
> +	unsigned long busmap [GPU_MAXBUS / (8*sizeof (unsigned long))];
> +};
> +static struct gpu_busmap busmap;
> +
> +/* used when updating list of gpus */
> +DEFINE_MUTEX(gpu_bus_list_lock);

Why 16?  Isn't there only one logical 'GPU bus' on the system containing 
all the graphics devices?  Or is this a limit on how many devices can 
be registered?  Or is each device considered a GPU bus in itself?

> + * This registers a GPU bus with the GPU layer,
> + * it fills in a default bus match function, and adds the device to
> the list + */
> +int gpu_register_bus(struct gpu_bus *bus)
> +{
> +	int busnum;
> +
> +	mutex_lock(&gpu_bus_list_lock);
> +
> +	busnum = find_next_zero_bit(busmap.busmap, GPU_MAXBUS, 1);
> +	if (busnum < GPU_MAXBUS) {
> +		set_bit(busnum, busmap.busmap);
> +		bus->busnum = busnum;
> +	} else {
> +		printk(KERN_ERR "%s: to many buses\n", "gpu");
> +		mutex_unlock(&gpu_bus_list_lock);
> +		return -E2BIG;

Is this the right return value or should it be -ENOSPC?  Also, I think 
you mean "too" on the previous line (figured I'd metion it before the 
spelling nazis get to you :).

Overall, seems like a nice layer to help with fb/drm coordination and 
possibly power management & suspend/resume.

Thanks,
Jesse
