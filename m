Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbUK2Vds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbUK2Vds (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 16:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbUK2Vds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 16:33:48 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:33171 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261809AbUK2Vd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 16:33:26 -0500
Date: Mon, 29 Nov 2004 13:33:10 -0800
From: Greg KH <greg@kroah.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [PATCH] CKRM 1/10: Base CKRM Events
Message-ID: <20041129213310.GA19892@kroah.com>
References: <E1CYqXA-00056l-00@w-gerrit.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CYqXA-00056l-00@w-gerrit.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 10:46:00AM -0800, Gerrit Huizenga wrote:
> +++ linux-2.6.10-rc2/include/linux/ckrm_events.h	2004-11-19 20:40:52.517303823 -0800
> @@ -0,0 +1,190 @@
> +/*
> + * ckrm_events.h - Class-based Kernel Resource Management (CKRM)
> + *                 event handling
> + *
> + * Copyright (C) Hubertus Franke, IBM Corp. 2003,2004
> + *           (C) Shailabh Nagar,  IBM Corp. 2003
> + *           (C) Chandra Seetharaman, IBM Corp. 2003
> + * 
> + * 
> + * Provides a base header file including macros and basic data structures.
> + *
> + * Latest version, more details at http://ckrm.sf.net
> + * 
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2.1 of the GNU Lesser General Public License
> + * as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + */
> +
> +/*
> + * Changes
> + *
> + * 28 Aug 2003
> + *        Created.
> + * 06 Nov 2003
> + *        Made modifications to suit the new RBCE module.
> + * 10 Nov 2003
> + *        Added callbacks_active and surrounding logic. Added task paramter
> + *        for all CE callbacks.
> + * 19 Nov 2004
> + *        New Event callback structure
> + */
> +
> +#ifndef _LINUX_CKRM_EVENTS_H
> +#define _LINUX_CKRM_EVENTS_H
> +
> +#ifdef CONFIG_CKRM

This ifdef is not needed.

> +/*
> + * Data structure and function to get the list of registered 
> + * resource controllers.
> + */
> +
> +/*
> + * CKRM defines a set of events at particular points in the kernel
> + * at which callbacks registered by various class types are called
> + */
> +
> +enum ckrm_event {

Please use a __bitwise marker for your enum so that sparse will check
for improper usage of it.

> +#ifdef __KERNEL__

Not needed (see the recent thread on lkml for why).

> +#ifdef CONFIG_CKRM
> +
> +/*
> + * CKRM event callback specification for the classtypes or resource controllers 
> + *   typically an array is specified using CKRM_EVENT_SPEC terminated with 
> + *   CKRM_EVENT_SPEC_LAST and then that array is registered using
> + *   ckrm_register_event_set.
> + *   Individual registration of event_cb is also possible
> + */
> +
> +typedef void (*ckrm_event_cb) (void *arg);
> +
> +struct ckrm_hook_cb {
> +	ckrm_event_cb fct;
> +	struct ckrm_hook_cb *next;

Why not use the kernel list structures here instead?

> +#else /* !CONFIG_CKRM */

Why have 2 different sections in the same header file for this check?
Please put them all together.

> +#ifdef CONFIG_CKRM
> +void ckrm_cb_newtask(struct task_struct *);
> +void ckrm_cb_exit(struct task_struct *);
> +#else
> +#define ckrm_cb_newtask(x)	do { } while (0)
> +#define ckrm_cb_exit(x)		do { } while (0)

Make these static inlines to get the compiler to check the arguments
properly.

> +extern int get_exe_path_name(struct task_struct *, char *, int);

Should this really be here?

> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.10-rc2/kernel/ckrm/ckrm_events.c	2004-11-19 20:40:52.526302397 -0800
> @@ -0,0 +1,97 @@
> +/* ckrm_events.c - Class-based Kernel Resource Management (CKRM)
> + *               - event handling routines
> + *
> + * Copyright (C) Hubertus Franke, IBM Corp. 2003, 2004
> + *           (C) Chandra Seetharaman,  IBM Corp. 2003
> + * 
> + * 
> + * Provides API for event registration and handling for different
> + * classtypes.
> + *
> + * Latest version, more details at http://ckrm.sf.net
> + * 
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + */
> +
> +/* Changes
> + *
> + * 29 Sep 2004
> + *        Separated from ckrm.c
> + *  
> + */

No changelogs in files please.

> +#define ECC_PRINTK(fmt, args...) \
> +// printk("%s: " fmt, __FUNCTION__ , ## args)

Looks like it's unused to me :)

Use pr_debug() if you want debugging stuff, don't make up your own...

thanks,

greg k-h
