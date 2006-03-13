Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbWCMCWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbWCMCWE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 21:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWCMCWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 21:22:03 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:16344
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1750986AbWCMCWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 21:22:02 -0500
Message-ID: <4414D742.4090007@microgate.com>
Date: Sun, 12 Mar 2006 20:21:54 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bob Copeland <email@bobcopeland.com>
CC: paulus@samba.org, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.16-rc5 pppd oops on disconnects
References: <b6c5339f0603100625k3410897fy3515d93fa1918c9@mail.gmail.com>	 <1142011340.3220.4.camel@amdx2.microgate.com>	 <b6c5339f0603101048l1c362582xc4d2570bc9d569b@mail.gmail.com>	 <1142018709.26063.5.camel@amdx2.microgate.com>	 <20060311150908.GA4872@hash.localnet>	 <1142099765.3241.3.camel@x2.pipehead.org>	 <b6c5339f0603111221k2d0afce5hcfd485713ba17338@mail.gmail.com>	 <1142180789.4360.2.camel@x2.pipehead.org> <b6c5339f0603120958y7ebc2051q51e24835456d9fcd@mail.gmail.com>
In-Reply-To: <b6c5339f0603120958y7ebc2051q51e24835456d9fcd@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Copeland wrote:
> On 3/12/06, Paul Fulghum <paulkf@microgate.com> wrote:
> 
>>--- linux-2.6.16-rc5/drivers/usb/class/cdc-acm.c        2006-02-27 09:24:29.000000000 -0600
>>+++ b/drivers/usb/class/cdc-acm.c       2006-03-12 10:22:21.000000000 -0600
>>@@ -980,7 +980,7 @@ skip_normal_probe:
>>        usb_driver_claim_interface(&acm_driver, data_interface, acm);
>>
>>        usb_get_intf(control_interface);
>>-       tty_register_device(acm_tty_driver, minor, &control_interface->dev);
>>+       tty_register_device(acm_tty_driver, minor, NULL);
>>
>>        acm_table[minor] = acm;
>>        usb_set_intfdata (intf, acm);
>>
> 
> 
> Paul,
> 
> No oops with the above patch.
> 
> thanks!
> -Bob

I think what is happening is that control_interface->dev is used
to back 2 sysfs entries (one usb, and one tty). When the usb
device is disconnected, the usb sysfs entries are removed and
the backing device is released. But the tty sysfs entry is
not removed until later after the tty is closed. This removal oops
because the backing device (or some sysfs entity associated with
the backing device) has already been freed. The slab poisoning
is needed to catch this. That's my theory, but I'm no expert
on USB or sysfs.

The above change does not associate the device
with the tty object, and no tty sysfs entry is made that
references the device. No function is lost, but some info
is not exported to userland.

I guess a more thorough approach would be to somehow not release
the usb device until the tty close completes. But that sounds
kind of messy, as the usb code would need to know about any
other class sysfs entries besides usb. (tty, maybe storage, etc)

Greg or the USB folks are more qualified to decide the details.

Thanks for your help Bob.

--
Paul


