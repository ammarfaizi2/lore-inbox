Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbULMVz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbULMVz2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 16:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbULMVz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 16:55:28 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:17368 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261176AbULMVzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 16:55:13 -0500
Date: Mon, 13 Dec 2004 13:54:34 -0800
From: Greg KH <greg@kroah.com>
To: Ed L Cashin <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.9 (with changes)
Message-ID: <20041213215434.GA22215@kroah.com>
References: <87k6rmuqu4.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k6rmuqu4.fsf@coraid.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 11:04:51AM -0500, Ed L Cashin wrote:
> +USING DEVICE NODES
> +
> +  "cat /dev/etherd/stat" shows the status of discovered AoE devices on
> +  your LAN:
> +
> +	root@nai root# cat /dev/etherd/stat
> +	/dev/etherd/e15.3       eth0    up
> +	/dev/etherd/e6.2        eth3    up
> +	/dev/etherd/e6.4        eth3    up
> +	/dev/etherd/e6.3        eth3    up
> +	/dev/etherd/e6.9        eth3    up
> +	/dev/etherd/e6.5        eth3    up
> +	/dev/etherd/e6.7        eth3    up
> +	/dev/etherd/e6.6        eth3    up
> +	/dev/etherd/e6.8        eth3    up
> +	/dev/etherd/e6.0        eth3    up
> +	/dev/etherd/e6.1        eth3    up

Again, can't you move this out into sysfs in the block directory for the
different partitions?  Or do you have userspace programs that are
expecting the stat device node to be present and export this
information?

> +  "cat /dev/etherd/err" blocks, waiting for error diagnostic output,
> +  like any retransmitted packets.
> +
> +  "echo interfaces eth2 eth4 > /dev/etherd/ctl" tells the aoe driver
> +  to limit ATA over Ethernet traffic to eth2 and eth4.  AoE traffic
> +  from untrusted networks should be ignored as a matter of security.
> +
> +  "echo discover > /dev/etherd/ctl" tells the driver to find out what
> +  AoE devices are available.

Can't you split the ctl device node up into 2 different ones?  One for
the interface command, and one for the discover command?  Any future
commands would use additional device nodes, you have a whole major
reserved, might as well take advantage of it :)

That way, you can reduce the ammount of parsing logic you have to do in
your driver.

> diff -urNp linux-2.6.9/drivers/block/aoe/aoe.h linux-2.6.9-aoe/drivers/block/aoe/aoe.h
> --- linux-2.6.9/drivers/block/aoe/aoe.h	1969-12-31 19:00:00.000000000 -0500
> +++ linux-2.6.9-aoe/drivers/block/aoe/aoe.h	2004-12-13 10:53:19.000000000 -0500
> @@ -0,0 +1,164 @@
> +#define VER 3

This should be used in a MODULE_VERSION() declaration, instead of a
printk() line.

> +#define AOE_MAJOR 152
> +#define MAX_ARGS 16

This is not used anywhere.

> +#define DEVICE_NAME "aoe"
> +#define DEVICE_NO_RANDOM

This is not used anywhere.

> +struct Aoehdr {

Ah, so close.  You dropped all of the typedefs, thank you.  But what's
with the capital letter in the structure name?  Just make it "aoehdr" or
"aoe_header" or something that doesn't have capital letters in it.

Same thing for all of your structure names.  A simple sed script should
fix them all up for you :)

> +enum {
> +	DEVFL_UP = 1,	/* device is installed in system and ready for AoE->ATA commands */
> +	DEVFL_TKILL = (1<<1),	/* flag for timer to know when to kill self */
> +	DEVFL_EXT = (1<<2),	/* device accepts lba48 commands */
> +	DEVFL_CLOSEWAIT = (1<<3), /* device is waiting for all closes to revalidate */
> +	DEVFL_WC_UPDATE = (1<<4), /* this device needs to update write cache status */
> +	DEVFL_WORKON = (1<<4),
> +
> +	BUFFL_FAIL = 1,
> +};

Any reason why BUFFL_FAIL and DEVFL_UP are the same value?  It looks
like they can be used in the same variable right?


The class_simple stuff looked sane, nice job.

thanks,

greg k-h
