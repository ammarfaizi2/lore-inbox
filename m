Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030979AbWKUPJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030979AbWKUPJG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 10:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030847AbWKUPJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 10:09:06 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:14327 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030979AbWKUPJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 10:09:04 -0500
Date: Tue, 21 Nov 2006 16:09:39 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Greg KH <gregkh@suse.de>, Jiri Slaby <jirislaby@gmail.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] driver core: delete virtual directory on
 class_unregister()
Message-ID: <20061121160939.7a9a1f7d@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20061121095853.GA16279@APFDCB5C>
References: <4561E290.7060100@gmail.com>
	<20061120182312.GA16006@APFDCB5C>
	<4561FA6F.4030400@gmail.com>
	<20061120195318.GB18077@APFDCB5C>
	<20061120203440.GA5458@suse.de>
	<20061121095853.GA16279@APFDCB5C>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2006 18:58:53 +0900,
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> On Mon, Nov 20, 2006 at 12:34:40PM -0800, Greg KH wrote:
> >
> > Hm, why is this not reproducable for me then without this patch?
> >
> 
> I can reproduce it by reloading raw.ko on 2.6.19-rc5-mm2.
> not happened on 2.6.19-rc6.

I can reproduce this on 2.9.19-rc5-mm2 with CONFIG_SYSFS_DEPRECATED as
well.

> After unloading raw.ko, /sys/devices/virtual/raw is still exist.
> So next loading raw.ko will fail.

And as virtual_device_parent() fails to do much error checking, we end
up with /sys/devices/rawctl instead of /sys/devices/virtual/raw/rawctl.
raw_init() won't notice anything has gone wrong...

Perhaps it would make sense to create /sys/device/virtual/<class>/
already in class_register() (regardless of whether there will be any
devices for this class) and unconditionally remove it in
class_unregister()? Removing something in _unregister() which was not
created by _register() but by some unrelated action seems a bit
lopsided to me...

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
