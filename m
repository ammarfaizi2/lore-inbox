Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265533AbTLHRM6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 12:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265534AbTLHRM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 12:12:58 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:54522 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S265533AbTLHRMt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 12:12:49 -0500
Message-ID: <3FD4B2F9.2040607@pacbell.net>
Date: Mon, 08 Dec 2003 09:20:57 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>, Duncan Sands <baldrick@free.fr>
CC: Vince <fuzzy77@free.fr>, "Randy.Dunlap" <rddunlap@osdl.org>,
       mfedyk@matchmail.com, zwane@holomorphy.com,
       linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
References: <Pine.LNX.4.44L0.0312081127080.1043-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0312081127080.1043-100000@ida.rowland.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>...  hold
>>>>a reference to the usb_device maybe long after the device has
>>>>been disconnected.  This is supposed to be OK, but from your
>>>
>>>... no, that's not supposed to be OK.  Returning from disconnect()
>>>means that a device driver is no longer referencing the interface
>>>the driver bound to, or ep0.
>>
>>Well, I thought Greg wanted it to be OK :)  Anyway, I don't use
>>the device after disconnect except to take the semaphore
>>(dev->serialize), check for disconnection (dev->state), and
>>of course to execute a usb_put_dev.  Surely this usage should
>>be OK?

Why do you even need that much though?  You're not allowed to
be USING the device any more; that's the sense in which I
was using "reference".   Refcounting is orthogonal, except
in the sense that to use without owning/borrowing a refcount
will likely cause oopsing someday.


> As long as your disconnect routine doesn't do usb_put_dev, so that it

There's an implicit usb_get_dev() associated with probe(),
and an implicit usb_put_dev() associated with disconnect().
If you're going to add an explicit put(), you need to also
add an explicit get().  Few drivers do; most rely on the
implicit refcounts.

But if you keep an extra reference to the device, you'd
need some way to get rid of it.

Yes, "usbfs" is wierd in lots of ways ... it's got references
associated with several distinct roles, including implicitly
associated with device creation, and so I'd suspect it doesn't
keep them all straight.

Plus, using the claim/release binding model (in its current
state) opens it up to a different family of bugs ... since
that doesn't hook up properly to the driver model yet, and
making it do so is non-trivial.


> maintains its reference, I don't see a problem.  But why do you want to
> check dev->state later on?  Once your disconnect routine has returned, you
> should be totally through with the device.  You should no longer care
> whether it's attached or not.
> 
> And of course, remember that there are valid reasons for your disconnect 
> routine to be called even when the device remains attached.  (rmmod is a 
> good example.)

And adding special case logic for rmmod paths isn't a good thing;
better just to implement disconnect() as I described.

- Dave



