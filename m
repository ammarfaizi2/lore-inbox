Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVB0U2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVB0U2d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 15:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVB0U2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 15:28:33 -0500
Received: from [195.23.16.24] ([195.23.16.24]:2730 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261210AbVB0U2Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 15:28:25 -0500
Message-ID: <1109535904.42222ca0b0b78@webmail.grupopie.com>
Date: Sun, 27 Feb 2005 20:25:04 +0000
From: "" <pmarques@grupopie.com>
To: "" <linux-kernel@vger.kernel.org>
Cc: "" <perex@suse.cz>, "" <mdharm-usb@one-eyed-alien.net>
Subject: sizeof(ptr) or sizeof(*ptr)?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 82.154.89.181
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Last week a bug was detected in n_tty.c where an array of char was replaced by a
char pointer making a "(len > sizeof(buf))" condition test for len > 4 (or 8)
bytes, instead of the original array size.

I decided to tweak sparse to give warnings on sizeof(pointer), so that I could
check for other cases like this. The tweak was a very crude hack that I'm not
proud of, and I am still trying to make it more reliable.

So far I found 2 interesting cases (in 2.6.11-rc5). I'm not sure they are bugs,
but they sure look suspicious.

1: drivers/usb/storage/usb.c:788

	/*
	 * Since this is a new device, we need to register a SCSI
	 * host definition with the higher SCSI layers.
	 */
	us->host = scsi_host_alloc(&usb_stor_host_template, sizeof(us));
	if (!us->host) {
		printk(KERN_WARNING USB_STORAGE
			"Unable to allocate the scsi host\n");
		return -EBUSY;
	}

"us" is a "struct us_data *". It seems pretty weird that we're allocating
something the size of a pointer, and then waste a pointer to keep the address
where it is allocated. So maybe this should be:

	us->host = scsi_host_alloc(&usb_stor_host_template, sizeof(*us));


2: sound/core/control.c:936

	ue = kcalloc(1, sizeof(struct user_element) + private_size + extra_size,
GFP_KERNEL);
	if (ue == NULL)
		return -ENOMEM;
	ue->info = info;
	ue->elem_data = (char *)ue + sizeof(ue);
	ue->elem_data_size = private_size;
	if (extra_size) {
		ue->priv_data = (char *)ue + sizeof(ue) + private_size;
		ue->priv_data_size = extra_size;
		if (ue->info.type == SNDRV_CTL_ELEM_TYPE_ENUMERATED) {
			if (copy_from_user(ue->priv_data, *(char __user
**)info.value.enumerated.name, extra_size))
				return -EFAULT;
		}
	}

If we're allocating "sizeof(struct user_element) + private_size + extra_size" it
seems that in the instructions below we would be wanting to use that space, so
both "sizeof(ue)" there should in fact be "sizeof(*ue)"

I'm not *really* sure that these are bugs, but they look suspicious. I'm CC'ing
the maintainers of both these files so that they can check these out.

I'll probably bring more examples in the future, as the tool improves. Right now
it gives about 550 false positives, so I think it is better to improve it
before checking every case :)

--
Paulo Marques - www.grupopie.com
 
All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)

