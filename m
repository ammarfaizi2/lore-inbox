Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263067AbVCEQgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263067AbVCEQgu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 11:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbVCEQcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 11:32:04 -0500
Received: from 64-85-47-3.ip.van.radiant.net ([64.85.47.3]:17169 "EHLO
	vlinkmail") by vger.kernel.org with ESMTP id S262008AbVCEQ0a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 11:26:30 -0500
Date: Fri, 4 Mar 2005 22:44:45 -0800
From: Greg KH <greg@kroah.com>
To: Wen Xiong <wendyx@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ patch 6/7] drivers/serial/jsm: new serial device driver
Message-ID: <20050305064445.GA8447@kroah.com>
References: <42225A64.6070904@us.ltcfwd.linux.ibm.com> <20050228065534.GC23595@kroah.com> <4228CE5C.9010207@us.ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4228CE5C.9010207@us.ltcfwd.linux.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 04:08:44PM -0500, Wen Xiong wrote:
> +/************************************************************************
> + * Structure used with ioctl commands for DIGI parameters.
> + ************************************************************************/
> +struct digi_t {
> +	unsigned short	digi_flags;		/* Flags (see above)	*/
> +	unsigned short	digi_maxcps;		/* Max printer CPS	*/
> +	unsigned short	digi_maxchar;		/* Max chars in print queue */
> +	unsigned short	digi_bufsize;		/* Buffer size		*/
> +	unsigned char	digi_onlen;		/* Length of ON string	*/
> +	unsigned char	digi_offlen;		/* Length of OFF string	*/
> +	char		digi_onstr[DIGI_PLEN];	/* Printer on string	*/
> +	char		digi_offstr[DIGI_PLEN];	/* Printer off string	*/
> +	char		digi_term[DIGI_TSIZ];	/* terminal string	*/
> +};

Oops, don't use _t for a structure name please.

> +#ifndef __JSM_DRIVER_H
> +#define __JSM_DRIVER_H
> +
> +#include <linux/kernel.h>
> +#include <linux/version.h>
> +#include <linux/types.h>	/* To pick up the varions Linux types */
> +#include <linux/tty.h>		
> +#include <linux/serial_core.h>
> +#include <linux/serial_reg.h>
> +#include <linux/interrupt.h>	/* For irqreturn_t type */
> +#include <linux/module.h>	
> +#include <linux/moduleparam.h>	
> +#include <linux/kdev_t.h>	
> +#include <linux/pci.h>
> +#include <linux/pci_ids.h>
> +#include <linux/device.h>
> +#include <linux/config.h>

Don't put header files in header files if you can help it.  It really
isn't needed here, and odds are, you are including files you don't
really need for each of the different driver .c files.  The build will
go faster if you don't do that.

Also, check your ordering, some of those .h files already included the
ones above it.

> +#include "digi.h"		/* Digi specific ioctl header */

Why do you have your own ioctls?  Please do not add any new ones to the
kernel.

> +#define DRVSTR	"jsm"		/* Driver name string */

What is this for?

> +#define DPRINTK(nlevel, klevel, fmt, args...) \
> +	(void)((DBG_##nlevel & debug) && \
> +	printk(KERN_##klevel "%s: " fmt, \
> +		__FUNCTION__, ## args)); 

Please use dev_dbg() or at least dev_printk() for this.  It provides
consistancy with the rest of the kernel, and it helps identify your
device much better.

> +#define JSM_MAJOR(x)	(imajor(x))
> +#define JSM_MINOR(x)	(iminor(x))

Not needed, please don't use.

> +#ifndef _POSIX_VDISABLE
> +#define	_POSIX_VDISABLE '\0'
> +#endif

What would have defined that before?

> +/*
> + * Our Global Variables.
> + */
> +extern struct	uart_driver jsm_uart_driver;
> +extern struct	board_ops jsm_neo_ops;
> +extern int	debug;
> +extern int	rawreadok;

Both of these are bad global variable names.

> +extern int	jsm_driver_state;	/* The state of the driver	*/
> +extern char	*jsm_driver_state_text[];/* Array of driver state text */
> +
> +extern spinlock_t jsm_board_head_lock;
> +static LIST_HEAD(jsm_board_head);

Hm, static variable in a header file?  bad...

> +/*************************************************************************
> + *
> + * Prototypes for non-static functions used in more than one module
> + *
> + *************************************************************************/
> +extern char *jsm_ioctl_name(int cmd);
> +extern int get_jsm_board_number(void);

Bad name for a global function, put the "jsm" at the front please.

thanks,

greg k-h
