Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbVGaS73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbVGaS73 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 14:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVGaS7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 14:59:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58554 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261919AbVGaS7S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 14:59:18 -0400
Date: Sun, 31 Jul 2005 11:59:06 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Manuel Lauss <mano@roarinelk.homelinux.net>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stelian Pop <stelian@popies.net>
Subject: Re: 2.6.13-rc3-mm3
In-Reply-To: <42ED1B6F.9090005@roarinelk.homelinux.net>
Message-ID: <Pine.LNX.4.58.0507311149160.29650@g5.osdl.org>
References: <20050728025840.0596b9cb.akpm@osdl.org> <42EC9410.8080107@roarinelk.homelinux.net>
 <Pine.LNX.4.58.0507311054320.29650@g5.osdl.org> <42ED1B6F.9090005@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 31 Jul 2005, Manuel Lauss wrote:
>
> Linus Torvalds wrote:
> 
>  >
>  >  - The SonyPI driver just allocates IO regions in random areas. It's got a
>  >    list of places to try allocating in, and the 1080 area just happens to
>  >    be the first on the list, and since it's not used by anything else, it
>  >    succeeds (never mind that it's on totally the wrong bus).
> 
> On three different intel-vaios, I've seen the sonypi device always
> located at ioport 0x1080. Even the windows driver on these models
> always allocates the 0x1080-0x109f io-range for it.

I think that's how the Linux driver IO list was gathered - looking at 
where it tends to sit by default.

And the thing is, that would actually be ok too (as I sent in a separate 
email to Stelian later) - if the BIOS actually sets it up at 1080, we 
could easily just make a PCI quirk that marks that region _early_ in the 
bootup sequence as being reserved for SonyPI. That would make any later 
PCI allocation requests know to avoid it.

The problem with the current setup is that the SonyPI driver is a
perfectly regular driver, and thus obviously loads _after_ a number of
other drivers, and the PCI setup code in particular. So what has happened
is that we've set up other PCI IO regious without knowing - or caring -
about the SonyPI driver, and then the SonyPI driver comes along and says
"oh, btw, I want that region".

And _that_ cannot work reliably. If you have a specific pre-allocated
region that you want (or must have - some regions are fixed because of 
things like ACPI tables or SMM etc that depend on them), then you need to 
tell the world about it _before_ it starts allocating anything else, 
because otherwise the allocation routines obviously cannot know about that 
fixed thing.

So what the sonypi driver does now is wrong, but there are two choices to
do it right: tell the PCI subsystem early (traditionally done as a PCI
quirk in drivers/pci/quirks.c, but you could possibly also make it as a
driver-specific "subsys_initcall()" - but only if your driver is always
compiled in, which sonypi isn't), or then allocate it nicely later.

It's the combination of the two that is bad: "just tell somebody later"  
doesn't work. They may say that it's easier to get forgiveness than ask
for permission, but that's not true in kernels. Because if you do
something wrong, the device simply won't _work_, which is exactly what 
happened here ;).

		Linus
