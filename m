Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267283AbUHXFmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267283AbUHXFmM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 01:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266758AbUHXFmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 01:42:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:18893 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266548AbUHXFlq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 01:41:46 -0400
Date: Mon, 23 Aug 2004 22:41:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [RFC&PATCH 1/2] PCI Error Recovery (readX_check)
In-Reply-To: <412AD123.8050605@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.58.0408232231070.17766@ppc970.osdl.org>
References: <412AD123.8050605@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 Aug 2004, Hidetoshi Seto wrote:
> 
> The basic design of new-found functions are:
> 
> $1. clear_pci_errors(DEVICE)
>    - find the highest(host or top PCI-to-PCI) bridge of DEVICE
>    - check the status of the highest bridge, and if it indicates error(s):
>      - write_lock
>      - update each err_status of all devices registered to the working_device
>        list of the highest bridge, by "|=" the value of the bridge status
>      - clear the bridge status
>      - write_unlock
>    - clear the err_status of DEVICE
>    - register DEVICE to the highest bridge
> 
> $2. readX_check(DEVICE, ADDR)
>    - read_lock
>    - I/O (read)
>    - read_unlock
> 
> $3. read_pci_errors(DEVICE)
>    - find the highest bridge of DEVICE
>    - store the status of the highest bridge as STATUS
>    - check ( STATUS | DEVICE->err_status )
>    - return 1 if error (ex. Master/Target Abort, Party Error), else return 0

I'd suggest changing the locking a bit.

Just make "clear_pci_errors()" take a spinlock on the bridge, and 
"read_pci_errors()" unlock it. We need to make sure that if multiple 
devices on the same bridge try to be careful, they can do so without 
seeing each others errors.

readX_check() itself would do no locking at all, since it is already 
called with the assumption that the bridge has been locked.

I'd also suggest that you make "clear_pci_errors()" return a cookie for 
read_pci_errors() to use. 

Also, I assume that the thing would support (and please make the
documentation clear on it) multiple IO operations between a
"clear_pci_errors()" and it's ending "read_pci_errors()" pair. I can well
imagine that a driver might do

	int get_data_buffer(struct pci_dev *dev, u32 *buf, int words)
	{
		int i;
		pci_error_t cookie;
		unsigned long offset = pci_resource_start(dev, 0) + DATA_OFFSET;

		cookie = clear_pci_errors(dev);

		/* Get the whole packet of data.. */
		for (i = 0; i < words; i++)
			*buf++ = readl_check(dev, offset);

		/* Did we have any trouble? */
		if (read_pci_errors(dev, cookie))
			return -EIO;

		/* All systems go.. */
		return 0;
	}

to read a "packet" of data from a device. Whatever.

		Linus
