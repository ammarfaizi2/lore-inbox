Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWBEOXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWBEOXr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 09:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWBEOXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 09:23:46 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:10120 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750813AbWBEOXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 09:23:46 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43E60989.5080600@s5r6.in-berlin.de>
Date: Sun, 05 Feb 2006 15:19:53 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [RFC 4/4] firewire: add mem1394
References: <1138919238.3621.12.camel@localhost> <1138920185.3621.24.camel@localhost>
In-Reply-To: <1138920185.3621.24.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.487) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Berg wrote:
> While the previous patches were purely infrastructure, this patch
> actually adds the code using it: mem1394.
> 
> There are some open questions on a few things, maybe someone can help
> out there.
[...]
> +	/* this is a bit icky. I think I'll want to create a
> +	 * "struct hpsb_node_class_interface" that you register
> +	 * with nodemgr.c instead of registering the "struct class_interface"
> +	 * directly. It would wrap around the "struct class_interface"
> +	 * and handle things like this.
> +	 *
> +	 * This means it would call the node_class_interface's
> +	 *  - "add" method whenever the device is fully there, and an
> +	 *  - "update" method when it survived a bus reset, and the
> +	 *  - "remove" method when it went away, also taking care of
> +	 * debouncing, which the mem1394 interface currently doesn't handle.

I currently think so too.

> +	 * But I need advice on this. It'll probably works this way
> +	 * but most likely not once this interface stuff gets more
> +	 * use; I can imagine using it for scanners instead of raw1394
> +	 * so that the kernel can validate that a user can only
> +	 * access a certain scanner and not all 1394 devices on the bus.

Probably not. All devices (except perhaps custom embedded devices) which 
implement one or another high level protocol will always be accessed 
either by a protocol driver in kernelspace (like sbp2, eth1394, 
video1394) on top of a struct unit_directory, or by a driver or library 
in userspace on top of libraw1394/ raw1394. This is because such devices 
and protocols all implement the ISO/IEC 13213 CSR architecture.

> +	 * In other words some 'raw1394intf' instead of 'raw1394' which
> +	 * creates one character device per ieee1394 node for finer
> +	 * grained access control.
> +	 * That would definitely want to have debouncing etc.
> +	 *
> +	 * However, I don't fully understand the states node_entries go
> +	 * through yet, so I'm not sure this should even be here!
> +	 * Maybe it should be in open? But then the device could go
> +	 * into limbo when it is already opened...
> +	 *
> +	 * Similarly, what happens if a node is suspended?
> +	 */
[...]

When a node represented by a node_entry leaves the bus, the node_entry 
is "suspended" and "put into limbo", which is both the same for the 1394 
stack. The node_entry is only "removed" when forced by userspace through 
ieee1394's sysfs interface or when the ieee1394 driver module is 
unloaded. A unit_directory is either "suspended" or "removed", depending 
on what the protocol driver bound to the unit_directory implements. 
This behaviour of ieee1394 is currently not extensively used, but I plan 
to implement capability of sbp2 to survive transient disconnection on 
top of it.

I still haven't tested your driver yet and won't be able to do so during 
the next days...
-- 
Stefan Richter
-=====-=-==- --=- --=-=
http://arcgraph.de/sr/
