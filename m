Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbWJ3OLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWJ3OLZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 09:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWJ3OLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 09:11:24 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:43604 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932429AbWJ3OLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 09:11:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LFxv5BeRHvtmPuKIjnirZMGyqVdSctVdORgYesnCeNyqJRNBEYHdCyZzHFg3Iow1YOIDLXN2QnpbbayVyRyo6kgl9d9MXIwPm5mye5piUxhlG0IFxbNsnglHIB5DsjmIedkkRKy/V69MKaT1Z0IAhpkDvG4hRawAGb8v8+XXh/A=
Message-ID: <653402b90610300611ucdc46d9y88f016800b498538@mail.gmail.com>
Date: Mon, 30 Oct 2006 15:11:21 +0100
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Paulo Marques" <pmarques@grupopie.com>
Subject: Re: [PATCH 2.6.19-rc1 full] drivers: add LCD support
Cc: Franck <vagabon.xyz@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <4545FCB1.8030900@grupopie.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061013023218.31362830.maxextreme@gmail.com>
	 <653402b90610230556y56ef2f1blc923887f049094d4@mail.gmail.com>
	 <453CE85B.2080702@innova-card.com>
	 <653402b90610230908y2be5007dga050c78ee3993d81@mail.gmail.com>
	 <cda58cb80610231015i4b59a571kaea5711ae1659f0d@mail.gmail.com>
	 <653402b90610260755t75b3a539rb5f54bad0688c3c1@mail.gmail.com>
	 <cda58cb80610271303p29f6f1a2vc3ebd895ab36eb53@mail.gmail.com>
	 <653402b90610271325l1effa77eq179ca1bda135445@mail.gmail.com>
	 <4545C52A.5010105@innova-card.com> <4545FCB1.8030900@grupopie.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/06, Paulo Marques <pmarques@grupopie.com> wrote:
> It is not *that* bad. If nothing has changed, the driver only pays the
> cost of a 1024 bytes memcmp. Even more, there are no current users for
> anything other than a PC, so I think we shouldn't overdesign at this point.
>

I really can't imagine a smartphone with a PC parallel port ;-)

> >   - All accesses to the device depend on the previous behaviour whereas
> >     write(), read() syscall could be synchrone and easier to use for
> >     fast writing of image sets. Actually the refresh stuff is really
> >     needed only if you mmap the device. And it seems not really used
> >     for now since it was broken on your last patch.
>
> That is not entirely true. If a user-space application misbehaves and
> starts writing faster than what can actually be seen, not having a fixed
> refresh rate means that your CPU will be *very* busy writing garbage
> that the user won't be able to see.
>
> A fixed refresh rate is a maximum CPU usage tunable that prevents
> applications (that are not aware that this is an external slow device)
> to write more than what they should.
>
> This can be improved, however.
>
> We could have the concept of a "dirty" buffer. Any write or nopage call
> would set the dirty flag and set a timer to refresh the display in one
> refresh period from now.
>
> When doing the actual refresh, the "dirty" flag would be cleared and the
> buffer unmapped.
>
> In this case, if nothing was ever written to the display, the CPU usage
> would be _zero_ (as it should), and it would work nicely with dynticks
> and such.
>

Hum, interesting. But what happens if...

1. For example, the userspace app maps the fb (nopage is called, dirty
flag set, timer created), and then the app doesn't use the fb. The
timer will refresh the LCD, without anything new to refresh, so we are
wasting CPU time. After refreshing, the driver clears the dirty flag
and unmap the buffer.

2. After some seconds, the userspace app decides to write the buffer.
As it is not mmaped anymore, it will simply get a segmentation fault,
right? AFAIK nopage() is not called again because we have destroyed
the mmapping information, and Linux can't know what are the nopage()
ops to call to.

3. We mmap the device, timer is created, we start writing to the
buffer, the timer calls our refreshing function but we didn't finish
filling the buffer with our information: The LCD will have only some
of the screen.

And so on, am I right?

Thanks,
       Miguel Ojeda
