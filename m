Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966698AbWKOIof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966698AbWKOIof (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 03:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966699AbWKOIof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 03:44:35 -0500
Received: from wx-out-0506.google.com ([66.249.82.229]:15536 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S966698AbWKOIoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 03:44:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=KY7t91aFQU5xknS9op5HkjBggMbfvaPrkFg/ynvzfAmTiQlp9xTV1bNLVi0he8887KgvTQm7E9AqhrbgkxpYYpX1XE2xZ+QgpxOtRQbga9kSTauA6vf9klQQ7rtifEQ4N/nux4o0tSSJFUXZxwHB6uffX4CZrKN5OP8UwcnK3E4=
Message-ID: <3ae72650611150044y8e0b57k681c478dca5c6cbf@mail.gmail.com>
Date: Wed, 15 Nov 2006 09:44:33 +0100
From: "Kay Sievers" <kay.sievers@vrfy.org>
To: "Cornelia Huck" <cornelia.huck@de.ibm.com>
Subject: Re: [Patch -mm 2/5] driver core: Introduce device_move(): move a device to a new parent.
Cc: "Greg KH" <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>,
       "Martin Schwidefsky" <schwidefsky@de.ibm.com>
In-Reply-To: <20061115082856.195ca0ab@gondolin.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061114113208.74ec12c4@gondolin.boeblingen.de.ibm.com>
	 <20061115065052.GC23810@kroah.com>
	 <20061115082856.195ca0ab@gondolin.boeblingen.de.ibm.com>
X-Google-Sender-Auth: 6b7f26a09d1cdfe7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/06, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> On Tue, 14 Nov 2006 22:50:52 -0800,
> Greg KH <greg@kroah.com> wrote:
>
> > On Tue, Nov 14, 2006 at 11:32:08AM +0100, Cornelia Huck wrote:
> > > From: Cornelia Huck <cornelia.huck@de.ibm.com>
> > >
> > > Provide a function device_move() to move a device to a new parent device. Add
> > > auxilliary functions kobject_move() and sysfs_move_dir().
> >
> > At first glance, this looks sane, but for the kobject_move function, we
> > are not notifying userspace that something has changed here.
> >
> > Is that ok?
> >
> > How will udev and HAL handle something like this without being told
> > about it?  When the device eventually goes away, I think they will be
> > very confused.

Yes, userspace will get confused, if we we don't get proper
notification. We require to update the udev and HAL database with the
new devpath, to find the current device context on device events, or
for "remove".

> Hm. I don't think we want to trigger udev with some remove/add events
> (especially since it is still the same device, it just has been moved
> around). A change event doesn't sound quite right either. But I guess
> we need to do something, at least to make HAL happy since it remembers
> the path in sysfs (although I seem to remember a HAL patch that got rid
> of it?)

Udev and HAL, both will need an event for the moving, with the old
DEVPATH value in the environment. We want something like a "rename" or
"move" event. Without that, weird things will happen in userspace,
because the devpath is used as the key to the device during the whole
device lifetime. The only weird exception today is the netif rename
case, which is already handled by special code in udev.

Thanks,
Kay
