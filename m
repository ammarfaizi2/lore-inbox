Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVENTqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVENTqj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 15:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVENTqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 15:46:36 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:35544 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261468AbVENTqc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 15:46:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iG0fW8PMCSsl6Kmmj67oEUaIrEADnQROuOMcrWsdF28OiquCyqaUR98+BhDI5ZzRq2wIXg8Q7xXzWPm8y346dJ241tAmvlqnHlTNH16zI7O8r9hWP4ADDlaoHGk8cccWIlCe3VeFZoWMig0ZioHPZ396ULKA21zuRKNb1iTLb+o=
Message-ID: <2538186705051412462d6db2d2@mail.gmail.com>
Date: Sat, 14 May 2005 15:46:31 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Yani Ioannou <yani.ioannou@gmail.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc4 1/12] (dynamic sysfs callbacks) update device attribute callbacks
In-Reply-To: <20050514112242.A24975@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2538186705051402237a79225@mail.gmail.com>
	 <20050514112242.A24975@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

> I missed commenting on this first time round.  What is the purpose behind
> this idea?

My first post to LKML on the patch:
http://lkml.org/lkml/2005/5/7/60

The idea originated in the lm_sensors mailing list, so you might want
to take a look at the lm_sensors archive is you are interested, in
particular the following thread:

http://archives.andrew.net.au/lm-sensors/msg31162.html

> Currently, sysfs attributes are generally static structures which don't
> require allocation, and are shared between all objects.  I'm unable to
> see what advantage adding this void pointer is supposed to give us,
> other than having to dynamically allocate these structures if we want
> to use them.

This isn't changing, although there are cases where it is
necessary/preferable to dynamically create the attributes (again see
previous discussion). This patch helps both static and dynamically
created attributes. The adm1026 example I posted to the mailing list
earlier uses entirely static attributes still (and hence the need for
the new macros my latest patch adds), and I expect most attributes
will remain static.

> What's more, I don't really see what adding this buys us - we already
> have the pointer which is supposed to identify the object passed in.

Using device_attribute as an example (most other derived sysfs
attributes have near identical callbacks):

struct device_attribute {
        struct attribute        attr;
        ssize_t (*show)(struct device * dev, char * buf);
        ssize_t (*store)(struct device * dev, const char * buf, size_t count);
};

The only pointer passed in the present callbacks is the device
structure, this doesn't help at all identify what attribute the
callback is for when a device can have many attributes.

> There's another question - how is the lifetime of the object pointed
> to by this void pointer managed?

Think of the pointer like the the driver_data pointer in struct device
(http://lxr.linux.no/source/include/linux/device.h#L270), except
instead of driver specific data pointer, this is attribute specific
data pointer, and might not even be used (i.e. NULL). What the pointer
points to should managed by whatever created that entity... I kind of
like Greg's renaming of the void * to private for reasons along those
lines. Your question about lifetime seems to imply that that entity
must be dynamically allocated, but that is not necessarily so.

Thanks,
Yani
