Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751547AbWFJQQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbWFJQQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 12:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbWFJQQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 12:16:58 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:8648 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751546AbWFJQQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 12:16:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HEa6XQjRNdMyNNxZdinleMqSW3033dep+ZUeg1DMJZi4lfobEmbfUJ7gQi+4xz4/aeZaFF1wAed7+uJMvwrdh988jGU9ka3h65dmvq1O2vVRGghOetl29TbNQ+e2QpCShS9uO9Nhyll7eCAqyqG2GLUclTffaPsdbjWTNjZke4k=
Message-ID: <9e4733910606100916r74615af8i34d37f323414034c@mail.gmail.com>
Date: Sat, 10 Jun 2006 12:16:56 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 5/5] VT binding: Add new doc file describing the feature
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>,
       "Greg KH" <greg@kroah.com>
In-Reply-To: <448AC8BE.7090202@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44893407.4020507@gmail.com>
	 <9e4733910606092253n7fe4e074xe54eaec0fe4149f3@mail.gmail.com>
	 <448AC8BE.7090202@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> Jon Smirl wrote:
> > On 6/9/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> >> - Describe the characteristics of 2 general types of console drivers
> >> - How to use the sysfs to unbind and bind console drivers
> >> - Uses for this feature
> >
> > I like this new binding feature and that for doing the work to make it
> > happen. It is definitely something I will use in the future.
> >
> >> From the docs I see a distinction between system consoles and modular
> > consoles, can't all consoles be created equally?  The only rule would
> > be, that if there is only a single console registered it can't be
> > unbound or unregistered. It shouldn't matter which console is the last
> > one left.
>
> Yes, it can be made that way. I just made it like that because
> system consoles, since they are initialized very, very early, have to
> be compiled statically. Therefore, they have can never be unloaded. So
> why give them the prerogative to directly unbind, when they can never
> be unloaded? One can unbind them anyway by binding a modular driver.
>
> It would also make binding/unbinding a more complicated process.

I may be looking at the problem a little differently. I see the
drivers like fb, vga, etc as registering with the console and saying
they are capable of providing console services. I then see the console
system as opening one of the registered devices. A driver is free to
register/unregister whenever it wants to as long as it isn't open by
the console system. Console can only open one driver at a time.
Opening another driver automatically closes the previous driver and
one driver always has to be open.

> I was thinking of changing it to something like this, after GregKH's
> suggestion:
>
> /sys/class/vtconsole --- vgacon - bind
>                      :
>                      --- fbcon - bind
>                      :
>                      --- dummycon - bind
>
> ... with the 'bind' as a r/w attribute, 0 for unbound/unbind, 1 for
> bound/bind.

This model implies that more than one driver can be open which isn't
true.  Since there is one attribute per driver this also implies that
binding(registering) is a driver attribute, not a console one.

If you move binding(registering) over to be a driver property it
doesn't need to be an explicit attribute. When a driver first loads it
will always register with console. When it unloads it will always
unregister and we know that the unregister will succeed because if
console has you open you won't be able to unload and get to the
unregister code.

The problem with the previous system was that bind(register) and open
were combined into a single operation when they should be separate. I
should be able to load four console drivers and then pick the one I
want to switch to without automatically having the console jump to
each device as the drivers are loaded.

> > We have these console systems: dummy, serial, vga, mda, prom, sti,
> > newport, sisusb, fb, network (isn't there some way to use the net for
> > console?)
>
> network is different.  It's a different class of console itself.  We
> have different console classes BTW. We have netconsole, serial console,
> vt consoles etc. fbcon, vgacon, promcon, etc all fall under the vt
> console class.

Over time it would nice if these all merged to a single
interchangeable interface. I would really like to be able to
dynamically switch to serial/net while debugging a video driver. Is
there some fundamental reason why these can't be merged?

> > All of these console system could follow the same protocol for
> > registering/binding as the modular consoles so we would end up with a
> > single class of console, not modular vs system.
>
> That was the plan before, the problem here is that we won't have any
> output during the early part of the boot process. That's why I
> differentiated them into system and modular consoles.

The current way of doing this still works. If a console driver is
compiled in use the CONFIG flags to statically initialize it's
registration(bind) state with console. Console will then just open the
first one it finds. Registering just says, here's a pointer I'm able
to be a console. Unregistering takes the pointer away. I agree that
there has to be a protocol exception in this case since the console
drivers don't get initialized until after we want console output.

> What do you think?

Am I making more sense now?

-- 
Jon Smirl
jonsmirl@gmail.com
