Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265755AbUBPSfe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 13:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265775AbUBPSfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 13:35:34 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:44043 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265755AbUBPSfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 13:35:18 -0500
Date: Mon, 16 Feb 2004 18:35:14 +0000
From: Christoph Hellwig <hch@infradead.org>
To: John Rose <johnrose@austin.ibm.com>
Cc: Rusty Russell <rusty@au1.ibm.com>, linux-kernel@vger.kernel.org,
       gregkh@us.ibm.com, Mike Wortman <wortman@us.ibm.com>
Subject: Re: [PATCH] PPC64 PCI Hotplug Driver for RPA
Message-ID: <20040216183514.A19426@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	John Rose <johnrose@austin.ibm.com>,
	Rusty Russell <rusty@au1.ibm.com>, linux-kernel@vger.kernel.org,
	gregkh@us.ibm.com, Mike Wortman <wortman@us.ibm.com>
References: <20040215222211.4F99817DE7@ozlabs.au.ibm.com> <1076955716.10484.21.camel@verve.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1076955716.10484.21.camel@verve.austin.ibm.com>; from johnrose@austin.ibm.com on Mon, Feb 16, 2004 at 12:21:56PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 16, 2004 at 12:21:56PM -0600, John Rose wrote:
> +#if !defined(CONFIG_HOTPLUG_PCI_MODULE)
> +	#define MY_NAME "rpaphp"
> +#else
> +	#define MY_NAME THIS_MODULE->name
> +#endif

Umm, what's this?  Checking CONFIG_FOO_MODULE is basically always wrong
and especially in this case.  Just use "rpaphp" always.

> +static int num_slots = 0;

No need to initialized variables to 0

> +static int enable_slot		(struct hotplug_slot *slot);
> +static int disable_slot		(struct hotplug_slot *slot);
> +static int set_attention_status (struct hotplug_slot *slot, u8 value);
> +static int get_power_status	(struct hotplug_slot *slot, u8 *value);
> +static int get_attention_status	(struct hotplug_slot *slot, u8 *value);
> +static int get_adapter_status	(struct hotplug_slot *slot, u8 *value);
> +static int get_max_bus_speed	(struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value);
> +static int get_cur_bus_speed	(struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value);

The larger whitespace before the opening brace aren't exatly linux
codingstyle..

> +static struct pci_dev *rpaphp_find_bridge_pdev(struct slot *slot)
> +{
> +	struct pci_dev		*retval_dev = NULL;
> +
> +	retval_dev = rpaphp_find_pci_dev(slot->dn);
> +
> +	return retval_dev;
> +}

This is horribly verbose.  Why not simply

static struct pci_dev *rpaphp_find_bridge_pdev(struct slot *slot)
{
	return rpaphp_find_pci_dev(slot->dn);
}

dito for rpaphp_find_adapter_pdev

In fact this is only used once so the wrapper looks rather useless.

> +/* Inline functions to check the sanity of a pointer that is passed to us */
> +static inline int slot_paranoia_check(struct slot *slot, const char *function)
> +{
> +	if (!slot) {
> +		dbg("%s - slot == NULL\n", function);
> +		return -1;
> +	}
> +
> +	if (!slot->hotplug_slot) {
> +		dbg("%s - slot->hotplug_slot == NULL!\n", function);
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +static inline struct slot *get_slot(struct hotplug_slot *hotplug_slot, const char *function)
> +{
> +	struct slot *slot;
> +
> +	if (!hotplug_slot) {
> +		dbg("%s - hotplug_slot == NULL\n", function);
> +		return NULL;
> +	}

If you have a method that per specification doesn't get a NULL pointer adding
these kinds of checks is bad.  Getting a NULL pointer would be against the
codified guaranteeds and your system already is bad trouble - better panic
ASAP by dereferencing the NULL pointer than waiting longer and possibly
corrupting data.

> +static int init_slots (void)
> +{
> +	int 			retval = 0;
> +
> +	retval = rpaphp_add_slot(NULL);
> +
> +	return retval;
> +}

Same strange verbosity as above.

> +static int __init rpaphp_init(void)
> +{
> +	int retval = 0;
> +
> +	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
> +
> +	rpaphp_debug = debug;
> +
> +	/* read all the PRA info from the system */
> +	retval = init_rpa();
> +
> +	return retval;

Again..  Btw, why do you have rpaphp_debug and debug?  Just using one is
much less confusing.

> +static void __exit rpaphp_exit(void)
> +{
> +	cleanup_slots();
> +}

Why the wrapping?

> +	}
> +	else {

linux coding style says this is

	} else {

