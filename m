Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263903AbTLJTf0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 14:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263909AbTLJTf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 14:35:26 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:12271 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S263903AbTLJTfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 14:35:14 -0500
Message-ID: <3FD77766.4060305@pacbell.net>
Date: Wed, 10 Dec 2003 11:43:34 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Duncan Sands <baldrick@free.fr>
CC: linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
References: <Pine.LNX.4.44L0.0312081754480.2034-100000@ida.rowland.org> <200312101749.17173.baldrick@free.fr> <3FD7591A.8020100@pacbell.net> <200312101854.44636.baldrick@free.fr>
In-Reply-To: <200312101854.44636.baldrick@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands wrote:
> On Wednesday 10 December 2003 18:34, David Brownell wrote:
> 
>>>Unfortunately, usb_physical_reset_device calls usb_set_configuration
>>>which takes dev->serialize.
>>
>>Not since late August it doesn't ...
> 
> 
> In current 2.5 bitkeeper it does.

usb_physical_reset_device() does not call usb_set_configuration()
except in the known-broken (for other reasons too!) "firmware changed"
path.  Known-broken, but not yet removed since nobody has reported
running into that or the other deadlock; the real fix is force
re-enumeration of the device.

The main path uses usb_control_msg(), because usb_reset_device()
currently guarantees it preserves (restore) altsettings as well
as driver bindings.  It couldn't even use usb_reset_configuration(),
since that gives altsettings their initial values (zero).

- Dave



> Duncan.
> 
> int usb_set_configuration(struct usb_device *dev, int configuration)
> {
>         int i, ret;
>         struct usb_host_config *cp = NULL;
> 
>         /* dev->serialize guards all config changes */
>         down(&dev->serialize);
> 


