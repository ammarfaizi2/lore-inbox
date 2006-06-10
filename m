Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbWFJN1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWFJN1i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 09:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbWFJN1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 09:27:38 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:48289 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751466AbWFJN1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 09:27:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ISukfJOeOyFJGnsnXuSf3mNHc+HUC6co+bRImmMfpr8/Hv5kzpMRChb+UVxQeeOW/abuOtrrXfYXvmc0aEbPAcuq6inj/M5oyE9gzdiqXL1E2MWr1pa2oeX4qwEZEl1HySGk4wv0IZ4gm4TKUVajJLhmfzNhvLW8r/TnVC/kf/U=
Message-ID: <448AC8BE.7090202@gmail.com>
Date: Sat, 10 Jun 2006 21:27:26 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] VT binding: Add new doc file describing the feature
References: <44893407.4020507@gmail.com> <9e4733910606092253n7fe4e074xe54eaec0fe4149f3@mail.gmail.com>
In-Reply-To: <9e4733910606092253n7fe4e074xe54eaec0fe4149f3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 6/9/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> - Describe the characteristics of 2 general types of console drivers
>> - How to use the sysfs to unbind and bind console drivers
>> - Uses for this feature
> 
> I like this new binding feature and that for doing the work to make it
> happen. It is definitely something I will use in the future.
> 
>> From the docs I see a distinction between system consoles and modular
> consoles, can't all consoles be created equally?  The only rule would
> be, that if there is only a single console registered it can't be
> unbound or unregistered. It shouldn't matter which console is the last
> one left.

Yes, it can be made that way. I just made it like that because
system consoles, since they are initialized very, very early, have to
be compiled statically. Therefore, they have can never be unloaded. So
why give them the prerogative to directly unbind, when they can never
be unloaded? One can unbind them anyway by binding a modular driver.

It would also make binding/unbinding a more complicated process.

> 
> We have these console systems: dummy, serial, vga, mda, prom, sti,
> newport, sisusb, fb, network (isn't there some way to use the net for
> console?)

network is different.  It's a different class of console itself.  We
have different console classes BTW. We have netconsole, serial console,
vt consoles etc. fbcon, vgacon, promcon, etc all fall under the vt
console class.

> 
> All of these console system could follow the same protocol for
> registering/binding as the modular consoles so we would end up with a
> single class of console, not modular vs system.

That was the plan before, the problem here is that we won't have any
output during the early part of the boot process. That's why I
differentiated them into system and modular consoles.

> Of course some of these consoles are built in and are never going to
> unregister themselves, but that doesn't meant that their binding
> sequence has to be different from the modular systems.
> 
> For example I can easily see VGA being converted from built-in to
> modular. There have also been times when I was working on video
> drivers that I wanted to switch to a serial console. For symmetry
> dummycon should be built into all systems.

As mentioned above, making vgacon (and other system drivers) take this
pathway means we lose output during the early part.  

> 
> As for the way the sysfs attribute works, in a similar situation in fb
> I used two attributes. Maybe 'backends' which is a read only list of
> available console systems. And 'backend' which is read/write. Copy one
> of the names from 'backends' to 'backend' to swtich the active/bound
> console. Cat 'backend' to see the active console. Any idea on a better
> name than 'backend'?
> 
> cat /sys/class/tty/console/backends
> vga
> serial
> dummy
> fb
> 
> cat /sys/class/tty/console/backend
> vga
> 
> echo fb >/sys/class/tty/console/backend
> 
> cat /sys/class/tty/console/backend
> fb
> 

I was thinking of changing it to something like this, after GregKH's
suggestion:

/sys/class/vtconsole --- vgacon - bind
                     : 
                     --- fbcon - bind
                     : 
                     --- dummycon - bind

... with the 'bind' as a r/w attribute, 0 for unbound/unbind, 1 for
bound/bind. 

What do you think?

Tony
