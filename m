Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262303AbVDFT4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbVDFT4H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 15:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262304AbVDFT4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 15:56:07 -0400
Received: from peabody.ximian.com ([130.57.169.10]:42217 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262303AbVDFTz7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 15:55:59 -0400
Subject: Re: [linux-pm] Re: [RFC] Driver States
From: Adam Belay <abelay@novell.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Patrick Mochel <mochel@digitalimplant.org>, Greg KH <greg@kroah.com>,
       linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050405092423.GA7254@elf.ucw.cz>
References: <1111963367.3503.152.camel@localhost.localdomain>
	 <Pine.LNX.4.50.0503292155120.26543-100000@monsoon.he.net>
	 <1112222717.3503.213.camel@localhost.localdomain>
	 <20050405092423.GA7254@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 06 Apr 2005 15:51:12 -0400
Message-Id: <1112817072.8517.15.camel@linux.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-05 at 11:24 +0200, Pavel Machek wrote:
> Hi!
> 
> > > You have a few things here that can easily conflict, and that will be
> > > developed at different paces. I like the direction that it's going, but
> > > how do you intend to do it gradually. I.e. what to do first?
> > 
> > I think the first step would be for us to all agree on a design, whether
> > it be this one or another, so we can began planning for long term
> > changes.
> > 
> > My arguments for these changes are as follows:
> 
> 0. I do not see how to gradually roll this in.
> 
> >      4. Having responsibilities at each driver level encourages a
> >         layered and object based design, reducing code duplication and
> >         complexity.
> 
> Unfortunately, you'll be retrofiting this to existing drivers. AFAICS,
> trying to force existing driver to "layered and object based design"
> can only result in mess.
> 								Pavel

Fair enough.  How does this sound?  I'd like to add "*attach" and
"*detach" to "struct device_driver".  These functions would act as one
time initializers and decontructors.  Then we could rename "*probe" to
"*start", and "*remove" to "*stop", which should be rather trivial to
fix up.  From there drivers could slowly be converted to use "*attach"
and "*detach", but will not be broken along the way.

So the basic flow would be like this:

1.) a driver is bound to a device
2.) *attach is called to allocate data structures
3.) *start when it's time to probe the device
4.) *stop when the user disables the device
5.) repeat steps 3 and 4 any number of times
6.) *detach is called when unbinding the driver

The driver layering stuff could come later, but just implementing these
specific components would have immediate benefits.

In this early stage in development, I'd like to at least be able to
start and stop drivers for reasons outside of power management (ex. user
preference or resource re-balancing).  If a "*resume" function can also
utilize this functionality, then all the better.

Thanks,
Adam


