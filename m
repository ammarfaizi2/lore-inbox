Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVF1IRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVF1IRO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 04:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVF1IQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 04:16:33 -0400
Received: from isilmar.linta.de ([213.239.214.66]:33239 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261734AbVF1GOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 02:14:04 -0400
Date: Tue, 28 Jun 2005 08:14:00 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pcmcia@lists.infradead.org
Subject: Re: pcmcia: release_class patch concern
Message-ID: <20050628061400.GA9019@isilmar.linta.de>
Mail-Followup-To: Dmitry Torokhov <dtor_core@ameritech.net>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-pcmcia@lists.infradead.org
References: <200506272356.50029.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506272356.50029.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Mon, Jun 27, 2005 at 11:56:49PM -0500, Dmitry Torokhov wrote:
> Hi Dominik,
> 
> I noticed that Linus committed the patch from you that introduces waiting
> for completion in module's exit routine. I believe it is a big no-no

Is it really? Any PCI driver which calls pci_unregister_driver() waits for
completion (-> driver_unregister() -> wait_for_completion(&drv->unloaded) ).


> as something like this will wedge the kernel:
> 
> 	rmmod <module> < /sys/path/to/devices/attribute

Why would anybody issue such a command? But it even wouldn't succeed, as
the module usage count would be >0 if there are attributes below
/sys/class/pcmcia_socket/

> Have you considered using Greg's class_create()/class_destroy()

Oh, don't get me started... they're for class_device_create() -- and we
don't register char devices here -- and this interface has some severe 
limitations and shortcomings:
http://marc.theaimsgroup.com/?l=linux-usb-devel&m=111193575527911&w=2
and follow the thread...

> or maybe
> bumping up module's refrerence count when registering class devices so
> rmmod would fail if there are users of this module?

In fact, this is done already, even though indirectly: socket drivers will
always increase the reference count as they use exports from pcmcia_core.ko,
and their call to pcmcia_unregister_socket in the device's ->remove()
function only succeeds if the class device is actually freed. So I could
have left the other wait_for_completion out, as it should never actually
_wait_. Nonethteless, I consider it to be a safeguard.

Thanks,
	Dominik
