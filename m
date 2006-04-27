Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751809AbWD0WDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbWD0WDj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 18:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbWD0WDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 18:03:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38095 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751809AbWD0WDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 18:03:37 -0400
Date: Thu, 27 Apr 2006 15:00:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: David Woodhouse <dwmw2@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Simple header cleanups
In-Reply-To: <20060427213754.GU3570@stusta.de>
Message-ID: <Pine.LNX.4.64.0604271439100.3701@g5.osdl.org>
References: <1146104023.2885.15.camel@hades.cambridge.redhat.com>
 <Pine.LNX.4.64.0604261917270.3701@g5.osdl.org> <1146105458.2885.37.camel@hades.cambridge.redhat.com>
 <Pine.LNX.4.64.0604261954480.3701@g5.osdl.org> <1146107871.2885.60.camel@hades.cambridge.redhat.com>
 <Pine.LNX.4.64.0604262028130.3701@g5.osdl.org> <20060427213754.GU3570@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 27 Apr 2006, Adrian Bunk wrote:
> 
> A definition of the kernel <-> userspace ABI is required.

Well, we can get certain hints by just looking at every single type that 
is used as a __user pointer. That should give us a lot of the type 
information.

The other big piece ends up being argument values passed in to system 
calls, most notably ioctl numbers, but there are certainly others too.

And then there are the system call numbers themselves, and their calling 
conventions (fairly small part).

> Create an include/kabi/linux/ with the following properties:

I do hate your naming.

Why is that "linux" there? We're not going to have FreeBSD kabi files. And 
what about the (pretty common) architecture-specific ones?

The dependency chain is also quite often nontrivial. The ABI's all end up 
depending on the basic types, and often on each other (eg the ioctl 
numbers depend on the sizes of all the structures, which in turn depend on 
the architecture-specific structure layout and low-level types).

So it's _not_ usually possible to just do one file that does one thing, 
because they do actually have linkages.

And the linkages can be nasty, because they can easily be linkages that 
POSIX - and other standards - forbid them from being visible (you cannot 
expose certain typenames if they weren't _explicitly_ included, regardless 
of whether you need the type defines).

This is one reason why we shouldn't even _plan_ on having header files 
that can just be _directly_ used by the C libraries etc, even if it's just 
a "small" kernel ABI header.

Selling it as that kind of idea will inevitably mean that we then get 
blamed for not knowing magic rule #579 for SuS v2.1.6 subsection 8(a).

And if we say "you can use these headers unmodified", that _is_ what we're 
going to get blamed for. I'm so _not_ interested in having to care or 
worry.

So I seriously think we should aim for making it _easier_ for system 
libraries to get the information, but we should at the same time make it 
clear that we make it easier for them to get the basic info, BUT WE DO NOT 
CARE ABOUT THE RANDOM USER STANDARD OF THE DAY.

Have you looked in /usr/include lately? Have you _looked_ at the "expose 
BSD names" vs "GNU extended source" vs "strict POSIX" vs 
"_XOPEN_SOURCE==600" bs "_USE_MISC" vs a million random and strange 
things?

The day I see somebody adding crap like that to the kernel headers is the 
day I pull the plug on any "KABI" interfaces. 

And don't tell me this has got nothing to do with the kernel constants. Go 
look in something like /usr/include/bits/fcntl.h, and cry. See how it's 
using _exactly_ the kernel constants, but it has added all the random 
standard-of-the-day #ifdef (whether real standards, or the "GNU standards" 
or just "legacy BSD-like" etc).

And THAT is why I don't think the simplistic "kabi" directory approach 
that people have brought up many times over many years is actually 
realistic. People don't realize that glibcs makes "struct flock" actually 
look different in user space depending on whether "__USE_FILE_OFFSET64" is 
defined or not.

You just haven't seen just how NASTY those user-space headers are. They 
can't use _any_ kernel headers directly, because even when they want a 
_raw_ kernel data structure, they actually end up doing things differently 
in the _middle_ of that data structure. 

Really.

So we should try to help those system libc people perhaps _find_ the 
values and structures they need, but no, I will _never_ allow the kernel 
headers to be used directly. And it doesn't _matter_ if they've been moved 
to a "kabi" subdirectory. That's not the issue. The issue is that user 
space does insane things that aren't acceptable in kernel space.

			Linus
