Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbVCOTR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVCOTR4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 14:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbVCOTOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 14:14:16 -0500
Received: from isilmar.linta.de ([213.239.214.66]:18395 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261803AbVCOTIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 14:08:54 -0500
Date: Tue, 15 Mar 2005 20:08:47 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Changes to the driver model class code.
Message-ID: <20050315190847.GA1870@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net,
	Kay Sievers <kay.sievers@vrfy.org>
References: <20050315170834.GA25475@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315170834.GA25475@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 09:08:34AM -0800, Greg KH wrote:
> Then I moved the USB host controller code to use this new interface.
> That was a bit more complex as it used the struct class and struct
> class_device code directly.  As you can see by the patch, the result is
> pretty much identical, and actually a bit smaller in the end.
> 
> So I'll be slowly converting the kernel over to using this new
> interface, and when finished, I can get rid of the old class apis (or
> actually, just make them static) so that no one can implement them
> improperly again...
> 
> Comments?

The "old" class api _forced_ you to think of reference counting of
dynamically allocated objects, while it gets easier to get reference
counting wrong using this "simple"/"new" interface: while struct class will 
always have fine reference counting, the "parent" struct [with struct class
no longer being embedded] needs to be thought of individually; and the 
reference count cannot be shared any longer.

Also, it seems to me that you view the class subsystem to be too closely
related to /dev entries -- and for these /dev entries class_simple was
introduced, IIRC. However, /dev is not the reason the class subsystem was 
introduced for -- instead, it describes _types_ of devices which want to
share (userspace and in-kernel) interfaces. For example pcmcia sockets which
can reside on different buses, but can be handled (mostly) the same way by
kernel- and userspace. For example, temperature sensors could be exported
using /sys/class/temp_sensors/... -- then userspace wouldn't need to know
whether the temperature was determined using an ACPI BIOS call or by
accessing an i2c device. Such "abstractions", and other kernel code whcih
uses these "abstractions" (a.k.a. class interfaces) are a great feature to
have, and one too less used by now.


	Dominik
