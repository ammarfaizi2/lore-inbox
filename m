Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbVASOab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbVASOab (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 09:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVASOaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 09:30:30 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:25926 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261668AbVASOaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 09:30:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=D6GUppP/elfCNnQjzpnb94GMt0+1d3nyF41RsPVD52Ha+nVjJVfD0StcfWm+NNiwp/jVd6ZbX4yYlYBBaqWBJ8cJbYSQVWdYyYBMwJxLySKyTmWYdHUR+4u8rEjourKRoNljHAfZPn2plavGaa21Lkba2JLVHnZZZENIazM8X+0=
Message-ID: <d120d500050119063040de00a7@mail.gmail.com>
Date: Wed, 19 Jan 2005 09:30:14 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 0/2] Remove input_call_hotplug
Cc: Greg KH <greg@kroah.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Vojtech Pawlik <vojtech@suse.cz>
In-Reply-To: <41EE4AE0.9030308@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41ED23A3.5020404@suse.de> <20050118213002.GA17004@kroah.com>
	 <d120d50005011813495b49907c@mail.gmail.com>
	 <20050118215820.GA17371@kroah.com>
	 <d120d500050118142068157a78@mail.gmail.com>
	 <20050119013133.GD23296@kroah.com> <41EE4AE0.9030308@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2005 12:56:16 +0100, Hannes Reinecke <hare@suse.de> wrote:
> Greg KH wrote:
> > On Tue, Jan 18, 2005 at 05:20:40PM -0500, Dmitry Torokhov wrote:
> >
> >>I was mostly talking about the need of 2 separate classes and this
> >>patch lays groundwork for it althou lifetime rules in input system
> >>need to be cleaned up before we can go all the way.
> >
> >
> > I agree.  But I think only 1 class is needed, that way we don't break
> > userspace, which is a pretty important thing.
> > 
> Well, if you could show me how to do this with the class_interface thing
> I'd be happy to comply.
> 
> The input layer design is like this:
> - Physical devices present one (or several) abstract input devices
> (which correspond to struct input_dev)
> - Each input device can be linked to one or several input handlers
> (which correspond to struct input_handle)
> - Each handler is represented to userspace with a device node.
> 
> The problem with the current input layer is that each 'struct
> input_handle' is associated with a class_simple device.
> This class is named 'input', so we're getting 'input' events from it.
> But each instantiation of struct input_dev is also sending 'input'
> events as it is doing the call_usermodehelper call directly.
> 

Yes, this is the problem and needs to be resolved. Thankfully most
people have keyboard support compiled in so it's not fatal but we
probably waht hotplug package be updated first before we commit this
change.

> 
> But if we were going to implement this with device_interface, we'd be
> having a /sys/class structure like:
> 
> class
> |- isa0060-serio0-input0
> |  |- event0
> |  |  `dev
> |  |- key
> |  |- ...
> |- ..
> 
> So we'd be moving the 'dev' attribute one directory down, again
> incurring a userland breakage.
> Plus it would be far more coding involved as the entire input layer
> structure would have to be redone.
> 

If I understand correctly we do not have subclasses so it will look like
class
|- input_device
|  |- input0
|  |- input1
|
|- input
|  |-event0
|  |-event1
|  |-mouse0

So breakage is really minimal.

-- 
Dmitry
