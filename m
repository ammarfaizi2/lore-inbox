Return-Path: <linux-kernel-owner+w=401wt.eu-S1755246AbXABEEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755246AbXABEEA (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 23:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755254AbXABEEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 23:04:00 -0500
Received: from gate.crashing.org ([63.228.1.57]:34407 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755246AbXABEEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 23:04:00 -0500
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Kahn <dmk@flex.com>
Cc: David Miller <davem@davemloft.net>, hch@infradead.org, wmb@firmworks.com,
       devel@laptop.org, linux-kernel@vger.kernel.org, jg@laptop.org
In-Reply-To: <45988210.7070300@flex.com>
References: <45978CE9.7090700@flex.com>
	 <20061231.024917.59652177.davem@davemloft.net>
	 <20061231154103.GA7409@infradead.org>
	 <20061231.124612.21926488.davem@davemloft.net>  <45988210.7070300@flex.com>
Content-Type: text/plain
Date: Tue, 02 Jan 2007 15:02:17 +1100
Message-Id: <1167710537.6165.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-12-31 at 19:37 -0800, David Kahn wrote:
> Folks,
> 
> If we reused the current code in fs/proc/proc_devtree.c
> and re-wrote the underlying of_* routines for i386 only,
> (in the hope of removing the complexity not needed for
> this implementation) would that be an acceptable
> implementation?
> 
> In other words, the of_* routines continue to define the
> interface between kernel and the firmware/OS
> layer. Although that code in proc_devtree.c defining
> the functions duplicate_name() and fixup_name() is still
> troubling to me.

The main problem with the current powerpc interface to the device-tree
(though as I said earlier, it's very handy for drivers) is that
get_property() doesn't take a buffer pointer. Thus, it's not very
suitable for an interface that involves calling into OF to retreive the
properties. It's really an interface designed around the idea that the
tree is in kernel memory, and the lifetime of the properties is tied to
the lifetime of the node.
 
> IMHO, the directory entries in the filesystem
> should be in the form "node-name@unit-address" (eg: /pci@1f,0,
> "pci" is the node name, "@" is the separator character defined
> by IEEE 1275, and "1f,0" is the unit-address,
> which are always guaranteed to be unique.

They should be. The problem is buggy OF implementations. For example,
both IBM and Apple OFs have the nasty habit of having under the CPU
nodes an "l2-cache" node with no unit-address -and- a property with the
same name (which contains just a phandle to that l2-cache node btw). 
There are other examples too (some pmacs have a duplicate i2c bus with
some one of the copies containing only a subset of the devices)

In general, we don't fabricate the @unit-address part, we use OF's own
package-to-path (unlike sparc which I think doesn't always have that
method), and thus we have to deal with implementations that return no
unit-address or duplicate names.

> It's
> not possible to have two ambiguously fully qualified nodes in the OFW
> device tree, otherwise you would never be able to select
> a specific one by name.

Well, it happens to be the case though. The code is to work around that.
A normal bug-free tree should never trigger the workarounds.

Ben.


