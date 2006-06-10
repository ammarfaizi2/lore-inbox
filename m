Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751665AbWFJRWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbWFJRWv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 13:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbWFJRWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 13:22:51 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:10619 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751663AbWFJRWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 13:22:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=czcVUNTpoAuxzSVHvtCKKIpBycxhcXzcH6DsUypBWMUcFgmG+oKydf3cSWdLHPjdr6jhzlu4xvrj2sddwbt1JeYnS1dfwzajuZwJSBZ03PBrzoiYomG7CfOy2rjSiOc+Twa/UfNlR5Mni50cySZ7oGAJQRF9NRgZCYGJETpoNmQ=
Message-ID: <9e4733910606101022l331ebb11na4c379d88601b674@mail.gmail.com>
Date: Sat, 10 Jun 2006 13:22:50 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 5/5] VT binding: Add new doc file describing the feature
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>,
       "Greg KH" <greg@kroah.com>
In-Reply-To: <9e4733910606100916r74615af8i34d37f323414034c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44893407.4020507@gmail.com>
	 <9e4733910606092253n7fe4e074xe54eaec0fe4149f3@mail.gmail.com>
	 <448AC8BE.7090202@gmail.com>
	 <9e4733910606100916r74615af8i34d37f323414034c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> I may be looking at the problem a little differently. I see the
> drivers like fb, vga, etc as registering with the console and saying
> they are capable of providing console services. I then see the console
> system as opening one of the registered devices. A driver is free to
> register/unregister whenever it wants to as long as it isn't open by
> the console system. Console can only open one driver at a time.
> Opening another driver automatically closes the previous driver and
> one driver always has to be open.

An example might help clarify this.

Imagine that you have three console drivers (vga, serial, fb) and one
console system all implemented as modules. I'm not saying make console
a module, just pretend like it is one.

First you would modprobe in the console system.
Next modprobe in the three console drivers which automatically
register with the console system.

At this point the console system would have a ref count of 3. It can
not be unloaded until the three console drivers have unregistered.

Now console opens the vga console driver, that will increment the ref
count on that driver.

Now switch to the serial driver, ref count will go to zero on vga and
one one serial.

At this point vga and fb could be unloaded if they were modules.

If console contains the rule that it always has to keep a console
open, it will be bound into memory since it will never be possible to
get its ref count to zero.

In the old model take_over_console() effectively combined these refs
counts so that it was impossible to unload anything once it was
loaded. There was no mechanism to decrement the ref count on the
console drivers.


-- 
Jon Smirl
jonsmirl@gmail.com
