Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVBMFBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVBMFBB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 00:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVBMFBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 00:01:01 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:49576 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261244AbVBMFAw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 00:00:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=a76ciF3UcYa+XY9XIUOpncaJqSQL/dlevwW1p78lKyNR8lcL4QHhVPQ220+JWRbFCeiMrWL3gQsa9HEm+mxXxKuCH7TdroaujBmE2RrQgZdt9ZYD1ldv5pTbFcuMSfdTT9GVXgDn2T/7DknUDBRNzD8CG5L6TJJ3HfMYLroNzm8=
Message-ID: <29495f1d05021221003ef31c3e@mail.gmail.com>
Date: Sat, 12 Feb 2005 21:00:52 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC UPDATE PATCH] add wait_event_*_lock() functions and comments
Cc: Sergey Vlasov <vsu@altlinux.ru>, Nishanth Aravamudan <nacc@us.ibm.com>,
       Al Borchers <alborchers@steinerpoint.com>, david-b@pacbell.net,
       greg@kroah.com, linux-kernel@vger.kernel.org
In-Reply-To: <200502130341.07746.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <1108105628.420c599cf3558@my.visi.com>
	 <200502121238.31478.arnd@arndb.de>
	 <20050212162835.4b95d635.vsu@altlinux.ru>
	 <200502130341.07746.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Feb 2005 03:41:01 +0100, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sünnavend 12 Februar 2005 14:28, Sergey Vlasov wrote:
> > On Sat, 12 Feb 2005 12:38:26 +0100 Arnd Bergmann wrote:
> > > #define __wait_event_lock(wq, condition, lock, flags)                  \
> > > do {                                                                   \
> > >        DEFINE_WAIT(__wait);                                            \
> > >                                                                        \
> > >        for (;;) {                                                      \
> > >                prepare_to_wait(&wq, &__wait, TASK_UNINTERRUPTIBLE);    \
> > >                spin_lock_irqsave(lock, flags);                         \
> > >                if (condition)                                          \
> > >                        break;                                          \
> > >                spin_unlock_irqrestore(lock, flags);                    \
> > >                schedule();                                             \
> > >        }                                                               \
> > >        spin_unlock_irqrestore(lock, flags);                            \
> > >        finish_wait(&wq, &__wait);                                      \
> > > } while (0)
> >
> > But in this case the result of testing the condition becomes useless
> > after spin_unlock_irqrestore - someone might grab the lock and change
> > things.   Therefore the calling code would need to add a loop around
> > wait_event_lock - and the wait_event_* macros were added precisely to
> > encapsulate such a loop and avoid the need to code it manually.
> 
> Ok, i understand now what the patch really wants to achieve. However,
> I'm not convinced it's a good idea. In the usb/gadget/serial.c driver,
> this appears to work only because an unconventional locking scheme is
> used, i.e. there is an extra flag (port->port_in_use) that is set to
> tell other functions about the state of the lock in case the lock holder
> wants to sleep.
> 
> Is there any place in the kernel that would benefit of the
> wait_event_lock() macro family while using locks without such
> special magic?

Sorry for replying from a different account, but it's the best I can
do right now. I know while I was scanning the whole kernel for other
wait_event*() replacements, I thought at least a handful of times,
"ugh, I could replace this whole block of code, except for that lock!"
I will try to get you a more concrete example on Monday. Thanks for
the feedback & patience!

-Nish
