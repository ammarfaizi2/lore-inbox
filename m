Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVBORzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVBORzg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 12:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVBORzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 12:55:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:15072 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261799AbVBORyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 12:54:38 -0500
Date: Tue, 15 Feb 2005 17:54:31 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: [patch] add scsi changer driver
Message-ID: <20050215175431.GA2896@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Gerd Knorr <kraxel@bytesex.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-scsi@vger.kernel.org
References: <20050215164245.GA13352@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050215164245.GA13352@bytesex>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[this should go to linux-scsi]

> +#include <linux/version.h>

not needed.

> +#include <asm/system.h>

I doubt you'll need this one.

> +#include <asm/uaccess.h>
> +
> +#include <linux/chio.h>			/* here are all the ioctls */

<linux/*.h> should always go before <asm/*.h>

> +#define MAJOR_NR	SCSI_CHANGER_MAJOR

please kill this one

> +#include "scsi.h"

never use this header but always the <scsi/*.h>

> +MODULE_SUPPORTED_DEVICE("sch");

no needed thsese days

> +static int dt_id[CH_DT_MAX] = { [ 0 ... (CH_DT_MAX-1) ] = -1 };
> +static int dt_lun[CH_DT_MAX];
> +module_param_array(dt_id,  int, NULL, 0444);
> +module_param_array(dt_lun, int, NULL, 0444);
> +
> +/* tell the driver about vendor-specific slots */
> +static int vendor_firsts[CH_TYPES-4];
> +static int vendor_counts[CH_TYPES-4];
> +module_param_array(vendor_firsts, int, NULL, 0444);
> +module_param_array(vendor_counts, int, NULL, 0444);
> +
> +static char *vendor_labels[CH_TYPES-4] = {
> +	"v0", "v1", "v2", "v3"
> +};
> +// module_param_string_array(vendor_labels, NULL, 0444);
> +
> +#define dprintk(fmt, arg...)    if (debug) \
> +        printk(KERN_DEBUG "%s: " fmt, ch->name, ##arg)
> +#define vprintk(fmt, arg...)    if (verbose) \
> +        printk(KERN_INFO "%s: " fmt, ch->name, ##arg)
> +
> +/* ------------------------------------------------------------------- */

> +static int ioctl32_register(void)
> +{
> +	unsigned int i;
> +	int err;
> +
> +	for (i = 0; i < ARRAY_SIZE(ioctl32_cmds); i++) {
> +		err = register_ioctl32_conversion(ioctl32_cmds[i].cmd,NULL);
> +		if (err >= 0)
> +			ioctl32_cmds[i].reg++;
> +	}
> +	return 0;
> +}

please implement ->compat_ioctl instead.

> +	int errno, retries = 0, timeout;
> +	DECLARE_COMPLETION(wait);
> +	Scsi_Request *sr;
> +	
> +	sr = scsi_allocate_request(ch->device, GFP_ATOMIC);

wouldn't a GFP_KERNEL do just fine?

> +	if (NULL == sr)
> +		return -ENOMEM;

normal kernel style would be

	if (!s)
		return -ENOMEM;

> +	list_for_each(item,&ch_devlist) {
> +		tmp = list_entry(item, scsi_changer, list);

list_for_each_entry

> +	list_for_each(item,&ch_devlist) {
> +		tmp = list_entry(item, scsi_changer, list);

dito

