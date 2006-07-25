Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbWGYVdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWGYVdE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 17:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWGYVdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 17:33:04 -0400
Received: from terminus.zytor.com ([192.83.249.54]:28044 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964862AbWGYVdC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 17:33:02 -0400
Message-ID: <44C68CAE.6090108@zytor.com>
Date: Tue, 25 Jul 2006 14:27:10 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [RFC PATCH] Multi-threaded device probing
References: <20060725203028.GA1270@kroah.com>
In-Reply-To: <20060725203028.GA1270@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> During the kernel summit, I was reminded by the wish by some people to
> do device probing in parallel, so I created the following patch.  It
> offers up the ability for the driver core to create a new thread for
> every driver<->device probe call.  To enable this, the driver needs to
> have the multithread_probe flag set to 1, otherwise the "traditional"
> sequencial probe happens.
> 
> Note that this patch does not actually enable the threaded probe for any
> busses, as that's very dangerous at this point in time, without the
> different bus authors trying it out and verifying that it does work
> properly.
> 
> I did enable this for both USB and PCI and shaved .4 seconds off of the
> boot time of my tiny little single processor laptop.  The savings of my
> 4-way workstation is much greater, but things start to happen so fast we
> miss the root disk, as init starts before the disks are finished being
> initialized.  I have some hacks to work around this right now, but I'll
> hold off on posting them before I make sure they work properly (breaking
> booting of people's machines isn't the best way to get them to accept
> new features...)
> 
> Anyway, have fun playing around with this if you want, I'll be adding
> this to the next -mm, but you will have to enable the bit on your own if
> you want to see any speedups.
> 

This is very interesting in the context of a few discussions I had at 
OLS about klibc; there are people who would like initramfs to be 
accessible *before* device probing is done, so that drivers can access 
firmware and possible hotplug from the initramfs during the driver 
initialization.  We could even invoke (k)init at this point; this would 
require a) having a system call or device that would allow kinit to 
block until device probing was complete, and b) a way to handle 
/dev/console -- there are several different ways to deal with it; it's 
mostly a matter of picking a good one.

Note that we don't need device drivers for userspace -- we only need VM, 
VFS and scheduler initialization.

Multithreaded device initialization is a great idea, especially since 
many devices require delays during initialization, sometimes on the 
order of seconds.

	-hpa


