Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265946AbSKBMPi>; Sat, 2 Nov 2002 07:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265949AbSKBMPi>; Sat, 2 Nov 2002 07:15:38 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:23101 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S265946AbSKBMPh>; Sat, 2 Nov 2002 07:15:37 -0500
To: root@chaos.analogic.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>,
       Dave Jones <davej@codemonkey.org.uk>, boissiere@adiglobal.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [STATUS 2.5]  October 30, 2002
References: <Pine.LNX.3.95.1021101115139.1318A-100000@chaos.analogic.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 02 Nov 2002 05:19:49 -0700
In-Reply-To: <Pine.LNX.3.95.1021101115139.1318A-100000@chaos.analogic.com>
Message-ID: <m1adksgo4a.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

> On 1 Nov 2002, Alan Cox wrote:
> 
> > On Fri, 2002-11-01 at 14:05, Eric W. Biederman wrote:
> > > When you have a correctable ECC error on a page you need to rewrite the
> > > memory to remove the error.  This prevents the correctable error from
> becoming
> 
> > > an uncorrectable error if another bit goes bad.  Also if you have a
> > > working software memory scrub routine you can be certain multiple
> > > errors from the same address are actually distinct.  As opposed to
> > > multiple reports of the same error.
> > 
> > Note that this area has some extremely "interesting" properties. For one
> > you have to be very careful what operation you use to scrub and its
> > platform specific. On x86 for example you want to do something like lock
> > addl $0, mem. A simple read/write isnt safe because if the memory area
> > is a DMA target your read then write just corrupted data and made the
> > problem worse not better!

yep lock addl $0, mem  with the appropriate kmaps so it will work on any system
I use.  It isn't rocket science but since it is using kmap_atomic that function
at least should probably get in the kernel.

> The correctable ECC is supposed to be just that (correctable). It's
> supposed to be entirely transparent to the CPU/Software. An additional
> read of the affected error produces the same correction so the CPU
> will never even know. The x86 CPU/Software is only notified on an
> uncorrectable error. I don't know of any SDRAM controller that
> generates an interrupt upon a correctable error. Some store "logging"
> information internally, very difficult to get at on a running system.

Polling the memory controller periodically isn't hard, and you can usually
get an interrupt as well.  Though I have not explored the whole interrupt
territory.  Finding out when you have a corrected error is extremely useful
as it gives a warning that your memory is going bad.  Just like with a disk
getting a bunch of errors means it is time to be replaced, but you still
have a little time left.

> Given that, "scrubbing" RAM seems to be somewhat useless on a
> running system. The next write to the affected area will fix the
> ECC bits, that't what is supposed to clear up the condition.

If it is your kernel text space that is getting the error there will
be no next write.

Beyond that if you are trying to see if the multiple correctable errors
you have are a single error, or an actual problem software scrubbing helps.
Because then you know the second report was because the problem reoccured.
Making it likely you have a bad bit in your DIMM.

Eric
