Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422735AbWJLP7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422735AbWJLP7w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 11:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422736AbWJLP7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 11:59:52 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:52632 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422735AbWJLP7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 11:59:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=POdGyd56blpaveloNK/tilIh4hksRmdiqHbxw6BH4W5qXeeNE1wAIsQ3KINj696JvGv/Rd9mmjrWuEQxP6DehduAgQz+/quS374KnnUQHCXtOHqIwOhLQsVlWodL33GaQHLqx/udsJome9QkwuZVHE2WOtotJW5hIsxiodJOFSk=
Message-ID: <653402b90610120859l24d6606ey4dcc185cebdd42db@mail.gmail.com>
Date: Thu, 12 Oct 2006 15:59:41 +0000
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Paulo Marques" <pmarques@grupopie.com>
Subject: Re: [PATCH 2.6.19-rc1 update 2] drivers: add LCD support
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <452E4D1A.9000409@grupopie.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061012140422.93e7330c.maxextreme@gmail.com>
	 <452E4D1A.9000409@grupopie.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/06, Paulo Marques <pmarques@grupopie.com> wrote:
> Miguel Ojeda Sandonis wrote:
> > Andrew, here it is the patch for converting the cfag12864b driver
> > to a framebuffer driver as Pavel requested and as I promised :)
>
> Very nice :)
>
> Just a few comments, see below.
>

Thanks!

> > Pavel, yep, now I can login in my tiny 128x64 LCD.
> > It is pretty amazing to run vi on it... ;)
> >
> > Tested and working fine.
> > ---
> [...]
> > +static void cfag12864b_update(void *arg)
> [...]
> > +     for (i = 0; i < CFAG12864B_CONTROLLERS; i++) {
> > +             cfag12864b_controller(i);
> > +             cfag12864b_nop();
> > +             for (j = 0; j < CFAG12864B_PAGES; j++) {
> > +                     cfag12864b_page(j);
> > +                     cfag12864b_nop();
> > +                     for (k = 0; k < CFAG12864B_ADDRESSES; k++) {
> > +                             cfag12864b_address(k);
> > +                             cfag12864b_nop();
> > +                             cfag12864b_nop();
>
> Doesn't the LCD controller automatically advance the address when
> writing data?
>

Yes, it _should_ (and the specs say the same). The point is that only
1 controller works fine (I don't know exactly why). Yep, it is
annoying and I was mad trying to get it to work. I couldn't. I thought
that maybe my LCD is broken, so I told a friend to test it with his
LCD. The same happened. I had 2 ways:

1. Call address only for the "bad" controller. But I didn't know if it
will work for everyone (because the LCD of my friend was bought on the
same time, so they can have the same bug or not).

2. Call address everytime. Safer, and it will bypass any bugs. Still,
it is fast. I decided to do it.

I'm glad you are the first one to see that ;)

>
> If it does, the address should only be needed before this loop and you
> could write 64 bytes in a row without any "nop"'s. This should really
> improve the time it takes to refresh the display.
>

Yep, that is the theory :)

> Also, keeping a "low level cache" of the physical display state and only
> sending bytes that have actually changed might be a good improvement too.
>
> Remember, the host CPU is probably much much faster than your interface
> to the LCD, so if it takes a few cycles to check the cache and decide
> not to send a byte, it's already a big win. A simple memcmp might be
> used skip full pages.
>
Hum, it could work. I will check if I can improve it. Anyway, the LCD
won't read any op until bit "e" change, so the "extra" work is done at
the parport on the computer. However, it can save some time at the CPU
computer, I think you are right.

>
> Also, what do these "nop"'s do? Isn't there a way to read the "busy"
> status from the controller and just write as fast as possible?
>

Well, I found another
> > [...]
> > +       The LCD framebuffer driver can be attached to a console.
> > +       It will work fine. However, you can't attach it to the fbdev driver
> > +       of the xorg server.
>
> This is probably because your driver can't be mmapped, no?
>

No, the device can't be mmapped, but the framebuffer is standard. The
problem isn't the framebuffer (it works like all the others): I read
xorg doesn't let you to use framebuffer of less than X requeriments
(xorg tells you: "what? this LCD is so small!!" :) Anyway, I haven't
tried it and it is a mad idea to run xorg on the 128x64 LCD.

> Although the controller is only accessible through the parallel port, it
> might be possible to mmap it. I vaguely remember that when I was reading
> LDD3, I thought that this should be doable in a sequence like:
>
>   - accept the mmap as if you had the memory for the device available
>   - at "nopage" time, mark the buffer as "dirty" and map it to user space
>   - using a timer at the actual refresh rate, check the dirty flag. If
> it is dirty, unmap the buffer and refresh the display
>
> I'm not describing the locking details (and a lot of other details,
> too), but it should work in principle.
>
> It will probably make things easier if your buffer size is PAGE_SIZE,
> and your "internal" operations (fillrect, copyarea, imageblit) also work
> over the same buffer and just mark the buffer as dirty.
>
> I don't know if X will be able to run in 128x64, but it is easier to
> make applications mmap the buffer and use it directly.
>

Hum, I think it is make the code dirtier, and IMO it won't be useful
at all, it is so small (just the console is hard to manage ;).

Applications can use the standard framebuffer device (/dev/fbX), or
mmap the memory of the driver... I mean, /dev/fbX is the same as the
memory used at the driver (the cfag12864b driver takes that memory and
send it to the LCD) so you can mmap it without special problems,
right?

Thanks again,
      Miguel Ojeda
