Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130362AbQLJNPh>; Sun, 10 Dec 2000 08:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130783AbQLJNP1>; Sun, 10 Dec 2000 08:15:27 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:7431 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S130362AbQLJNPM>; Sun, 10 Dec 2000 08:15:12 -0500
Date: Sun, 10 Dec 2000 12:44:32 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <andrewm@uow.edu.au>
cc: lkml <linux-kernel@vger.kernel.org>,
        <linux-usb-devel@lists.sourceforge.net>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] hotplug fixes
In-Reply-To: <3A337727.FDED61E3@uow.edu.au>
Message-ID: <Pine.LNX.4.30.0012101238120.25294-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2000, Andrew Morton wrote:

> - PCMCIA layer calls call_usermodehelper from within keventd.  But
>   call_usermodehelper blocks until keventd has run the helper! Duh.
>
>   This patch special-cases the situation where keventd is calling
>   call_usermodehelper().

+       if (current_is_keventd()) {
+               /* We can't wait on keventd! */
+               __call_usermodehelper(&sub_info);
+       } else {
+               schedule_task(&tqs);
+               down(&sem);             /* Wait until keventd has started the subprocess */
+       }


That's sick. Do we have to? The PCMCIA coded obviously wants an async
call_usermodehelper() or it wouldn't have been using schedule_task()
for it in the first place, would it? Can't we pass an 'int async' arg to
call_usermodehelper() instead of doing it this way?

-- 
dwmw2




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
