Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbVLTXQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbVLTXQc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 18:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbVLTXQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 18:16:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20678 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932200AbVLTXQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 18:16:31 -0500
Date: Tue, 20 Dec 2005 15:16:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: greg@kroah.com, mbligh@google.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, apw@shadowen.org
Subject: Re: [PATCH] pci device sysdata may be null check in pcibus_to_node
Message-Id: <20051220151609.565160d9.akpm@osdl.org>
In-Reply-To: <20051220210338.GA20681@shadowen.org>
References: <20051216231752.GA2731@kroah.com>
	<20051220210338.GA20681@shadowen.org>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft <apw@shadowen.org> wrote:
>
> pci device sysdata may be null, check in pcibus_to_node
> 
> We have been seeing panic's on NUMA systems in pci_call_probe() in
> 2.6.15-rc5-mm2 and -mm3.  It seems that some changes have occured
> to the meaning of the 'sysdata' for a device such that it is no
> longer just an integer containing the node, it is now a structure
> containing the node and other data.  However, it seems that we do not
> always initialise this sysdata before we probe the device.
> 
> Below are three examples from a boot with this checked for.  It is
> not clear to me whether it is reasonable to attempt to probe this
> device without the bus sysdata being initialised.  The attached
> patch adds a safety check to pcibus_to_node() to avoid the panic,
> this restores the 'call anytime' semantic for this function.
> 
> ...
>  
> -#define pcibus_to_node(bus) ((struct pci_sysdata *)((bus)->sysdata))->node
> +#define pcibus_to_node(bus) (((bus)->sysdata)? ((struct pci_sysdata *)((bus)->sysdata))->node : -1)
>  #define pcibus_to_cpumask(bus) node_to_cpumask(pcibus_to_node(bus))
>  

It would be neater and faster to simply require that the platform always
put something sane bus->sysdata, even if that's a pointer to some
statically allocated struct.  IOW:

static struct pci_sysdata dummy_sysdata = { .node = -1 };

somewhere_in_initialisation()
{
	...
	if (bus->sysdata == NULL)
		bus->sysdata = dummy_sysdata;
}
