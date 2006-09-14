Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWINOFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWINOFF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 10:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWINOFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 10:05:05 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:61361 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750725AbWINOFC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 10:05:02 -0400
Date: Thu, 14 Sep 2006 09:04:59 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 4/11] LTTng-core 0.5.108 : core
Message-ID: <20060914140459.GA23823@sergelap.austin.ibm.com>
References: <20060914034308.GE2194@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060914034308.GE2194@Krystal>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm wondering why this is safe:

Quoting Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca):
...
> +void ltt_transport_register(struct ltt_transport *transport)
> +{
> +	spin_lock(&transport_list_lock);
> +	list_add_tail(&transport->node, &ltt_transport_list);
> +	spin_unlock(&transport_list_lock);
> +}
> +
> +void ltt_transport_unregister(struct ltt_transport *transport)
> +{
> +	spin_lock(&transport_list_lock);
> +	list_del(&transport->node);

You don't have a refcount you check here, and

> +	spin_unlock(&transport_list_lock);
> +}
> +
> +EXPORT_SYMBOL_GPL(ltt_transport_register);
> +EXPORT_SYMBOL_GPL(ltt_transport_unregister);

...

> +static int ltt_trace_create(char *trace_name, char *trace_type,
> +		enum trace_mode mode,
> +		unsigned subbuf_size_low, unsigned n_subbufs_low,
> +		unsigned subbuf_size_med, unsigned n_subbufs_med,
> +		unsigned subbuf_size_high, unsigned n_subbufs_high)
> +{

here:

> +	spin_lock(&transport_list_lock);
> +	list_for_each_entry(tran, &ltt_transport_list, node) {
> +		if (!strcmp(tran->name, trace_type)) {
> +			transport = tran;
> +			break;
> +		}
> +	}
> +	spin_unlock(&transport_list_lock);
> +
> +	if (!transport) {
> +		err = EINVAL;
> +		printk(KERN_ERR	"LTT : Transport %s is not present.\n", trace_type);
> +		goto trace_error;
> +	}
> +
> +	if(!try_module_get(transport->owner)) {
> +		err = ENODEV;
> +		printk(KERN_ERR	"LTT : Can't lock transport module.\n");
> +		goto trace_error;
> +	}
> +
> +	new_trace->transport = transport;
> +	new_trace->ops = &transport->ops;

you grab references to the object which may be deleted after
you drop the transport_list_lock at the top of this block.  Since
a later patch shows the unregister being called right before the
owning module is unloaded, that seems awefuly dangerous.

Is there some other magic going on making this safe?

thanks,
-serge
