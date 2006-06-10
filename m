Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161011AbWFJV0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161011AbWFJV0Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 17:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161012AbWFJV0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 17:26:24 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:15593 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161011AbWFJV0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 17:26:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=qW+qh6HeXpJt1v6L+pAKFBdRUS2DLOmfbO+MRcKUU3NcqwuYfDn9+QkCmdXN2lK0f1Aboj5Qiicfx2lRK36oXm3HUF70GG62wCGjBNThDJyC1Q29ezmbtslRxRlZ4zyf3P4Lz+Uk2WhTsAZoUfc1ssnLf9N8gTvs574YYIObdeU=
Message-ID: <448B38F8.2000402@gmail.com>
Date: Sun, 11 Jun 2006 05:26:16 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH 5/5] VT binding: Add new doc file describing the feature
References: <44893407.4020507@gmail.com>	 <9e4733910606092253n7fe4e074xe54eaec0fe4149f3@mail.gmail.com>	 <448AC8BE.7090202@gmail.com> <9e4733910606100916r74615af8i34d37f323414034c@mail.gmail.com>
In-Reply-To: <9e4733910606100916r74615af8i34d37f323414034c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 6/10/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> Jon Smirl wrote:
>> > On 6/9/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> >> - Describe the characteristics of 2 general types of console drivers
>> >> - How to use the sysfs to unbind and bind console drivers
>> >> - Uses for this feature
>> >
>> > I like this new binding feature and that for doing the work to make it
>> > happen. It is definitely something I will use in the future.
>> >
>> >> From the docs I see a distinction between system consoles and modular
>> > consoles, can't all consoles be created equally?  The only rule would
>> > be, that if there is only a single console registered it can't be
>> > unbound or unregistered. It shouldn't matter which console is the last
>> > one left.
>>
>> Yes, it can be made that way. I just made it like that because
>> system consoles, since they are initialized very, very early, have to
>> be compiled statically. Therefore, they have can never be unloaded. So
>> why give them the prerogative to directly unbind, when they can never
>> be unloaded? One can unbind them anyway by binding a modular driver.
>>
>> It would also make binding/unbinding a more complicated process.
> 
> I may be looking at the problem a little differently. I see the
> drivers like fb, vga, etc as registering with the console and saying
> they are capable of providing console services. I then see the console
> system as opening one of the registered devices. A driver is free to
> register/unregister whenever it wants to as long as it isn't open by
> the console system. Console can only open one driver at a time.

No, this isn't true.  You can have multiple console drivers active,
that's why you have a first and last parameter in take_over_console().
Thus at boot time, the system driver will take consoles 0 - 63.
Later on when a driver loads, it can take over consoles 0 - 7, leaving
consoles 8 - 63 to the system driver.

To put it another way, console drivers can register for consoles 0 - 63,
but the user may choose to use it only for consoles 0 - 7.

This is another reason for the system driver, it makes the unbinding
behavior predictable.  Without a system driver, guessing which driver
replaces the just unbound one may become just a tad bit confusing for
the typical user.

> Opening another driver automatically closes the previous driver and
> one driver always has to be open.
> 
>> I was thinking of changing it to something like this, after GregKH's
>> suggestion:
>>
>> /sys/class/vtconsole --- vgacon - bind
>>                      :
>>                      --- fbcon - bind
>>                      :
>>                      --- dummycon - bind
>>

Just tried the above, but it's a mouthful, as the name is based
on the description. So I already changed it to this:

/sys/class/vtconsole --- vtcon0
                      :
                     --- vtcon1

Each class device file has 2 attributes:

bind - r/w attribute
name - description of the current backend

>> ... with the 'bind' as a r/w attribute, 0 for unbound/unbind, 1 for
>> bound/bind.
> 
> This model implies that more than one driver can be open which isn't
> true.

Yes it implies that and no, it is true. So that is a model compatible
with the current implementation. What's lacking still is fine-grained
control, ie, for the user to bind/unbind only a specific range of
consoles. It's possible to add this fine-grained control in:

/sys/class/tty/tty[n] 

...but that will be for the future.

> Since there is one attribute per driver this also implies that
> binding(registering) is a driver attribute, not a console one.

The revised model should fix this.

> 
> If you move binding(registering) over to be a driver property it
> doesn't need to be an explicit attribute. When a driver first loads it
> will always register with console. When it unloads it will always
> unregister and we know that the unregister will succeed because if
> console has you open you won't be able to unload and get to the
> unregister code.
> 
> The problem with the previous system was that bind(register) and open
> were combined into a single operation when they should be separate. I
> should be able to load four console drivers and then pick the one I
> want to switch to without automatically having the console jump to
> each device as the drivers are loaded.
> 
>> > We have these console systems: dummy, serial, vga, mda, prom, sti,
>> > newport, sisusb, fb, network (isn't there some way to use the net for
>> > console?)
>>
>> network is different.  It's a different class of console itself.  We
>> have different console classes BTW. We have netconsole, serial console,
>> vt consoles etc. fbcon, vgacon, promcon, etc all fall under the vt
>> console class.
> 
> Over time it would nice if these all merged to a single
> interchangeable interface. I would really like to be able to
> dynamically switch to serial/net while debugging a video driver. Is
> there some fundamental reason why these can't be merged?

It's already possible to redirect the system messages to two different
console classes, ie with the boot parameter:

console=tty0,ttyS0 /* direct output to VT and serial console */

And you can already choose the console you want by adjusting /etc/inittab.

Tony
