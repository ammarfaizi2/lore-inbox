Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262383AbVCPBBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbVCPBBu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 20:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVCPBBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 20:01:50 -0500
Received: from isilmar.linta.de ([213.239.214.66]:50656 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S262384AbVCPBBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 20:01:17 -0500
Date: Wed, 16 Mar 2005 02:01:14 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Greg KH <greg@kroah.com>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Changes to the driver model class code.
Message-ID: <20050316010114.GA9263@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Greg KH <greg@kroah.com>, dtor_core@ameritech.net,
	linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
	Kay Sievers <kay.sievers@vrfy.org>
References: <20050315170834.GA25475@kroah.com> <d120d500050315094724938ffc@mail.gmail.com> <20050315193415.GA26299@kroah.com> <20050315201503.GA3591@isilmar.linta.de> <20050315221431.GC28880@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315221431.GC28880@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 02:14:31PM -0800, Greg KH wrote:
> > So this means every device will have yet another reference count, and you
> > need to be aware of _each_ lifetime to write correct code. And the 
> > _reference counting_ is the hard thing to get right, so we should make 
> > _that_ easier. The existing class API was a step towards this direction, and
> > with the changes you're suggesting here we'd do two jumps backwards.
> 
> You are correct, it was a step forward in this direction.
> 
> But we now have a kref to handle the reference counting for the device,
> which make things a whole lot easier than ever before.

Is it really easier if you have to be aware of _both_ the class reference
possibly having reached zero yet and the kref device reference
possibly having reached zero yet? Using your approach, you need to take 
_two_ lifetimes into account instead of one. Think of class device
attributes being opened / still being accessed when kref device reference 
reaching zero... you need to check for that in code now, AFAICS, while you 
could rely on "we still have a reference to the _device_" in "historic" 
class device attribute access paths.

> But the both of you are correct, there is a real need for the class code
> to support trees of devices that are presented to userspace (which is
> what the class code is for).  I'm not taking that away, just trying to
> make the interface to that code simpler.

The interface may get simpler, but we lose the advantages. And I prefer a
interface which reduces the chances of doing things wrongly; and at least
the existing warnings on empty release functions force you to _think_ about
what you do.

> I'm also not saying that I'm going to go off and delete those functions
> from the kernel today, or tomorrow. 
...
> Anyway, don't worry, the code isn't going away anytime soon,

That's totally besides the point. If the decision was made to indeed do this
transition, I'd be all for doing this fast. If the "old" code was gone
within two weeks, I wouldn't care because of the short period, but because
of the functionality being lost:

> I will not be removing any functionality, don't worry :)

the "functionality" of the device core to teach, encourage, and forcing to 
think of reference counting is being lost by this approach. Independent of
the question whether the transition will take two weeks or two years.

> It will not make the reference counting logic easier to get wrong, or
> easier to get right.  It totally takes it away from the user, and makes
> them implement it themselves if they so wish (like the USB HCD patch
> does.).

Keeping the chance to do the "new"/class_simple way is a good thing -- so
that anybody who _knows_ _exactly_ what he does can shoot himself in his
foot^W^W^W^W^W do what is best for the affected code.

> we just
> need to make it easier to use.  Any suggestions that any of you have to
> make this that way (as you are the ones who had to use it to start with)
> would be greatly appreciated.

	drivers/base/class_simple.c:

	....
	printk("are you really sure you don't want not to have reference counting for free by using struct class instead of struct class_simple *?\n");
	....

:)

Thanks,
	Dominik
