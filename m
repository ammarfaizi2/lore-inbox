Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVBOBGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVBOBGc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 20:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVBOBFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 20:05:51 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:38638 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261562AbVBOBEk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 20:04:40 -0500
Date: Mon, 14 Feb 2005 17:04:35 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Sergey Vlasov <vsu@altlinux.ru>,
       Al Borchers <alborchers@steinerpoint.com>, david-b@pacbell.net,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC UPDATE PATCH] add wait_event_*_lock() functions and comments
Message-ID: <20050215010435.GD2403@us.ibm.com>
References: <1108105628.420c599cf3558@my.visi.com> <200502121238.31478.arnd@arndb.de> <20050212162835.4b95d635.vsu@altlinux.ru> <200502130341.07746.arnd@arndb.de> <29495f1d05021221003ef31c3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29495f1d05021221003ef31c3e@mail.gmail.com>
X-Operating-System: Linux 2.6.11-rc3 (i686)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2005 at 09:00:52PM -0800, Nish Aravamudan wrote:
> On Sun, 13 Feb 2005 03:41:01 +0100, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Sünnavend 12 Februar 2005 14:28, Sergey Vlasov wrote:
> > > On Sat, 12 Feb 2005 12:38:26 +0100 Arnd Bergmann wrote:
> > > > #define __wait_event_lock(wq, condition, lock, flags)                  \
> > > > do {                                                                   \
> > > >        DEFINE_WAIT(__wait);                                            \
> > > >                                                                        \
> > > >        for (;;) {                                                      \
> > > >                prepare_to_wait(&wq, &__wait, TASK_UNINTERRUPTIBLE);    \
> > > >                spin_lock_irqsave(lock, flags);                         \
> > > >                if (condition)                                          \
> > > >                        break;                                          \
> > > >                spin_unlock_irqrestore(lock, flags);                    \
> > > >                schedule();                                             \
> > > >        }                                                               \
> > > >        spin_unlock_irqrestore(lock, flags);                            \
> > > >        finish_wait(&wq, &__wait);                                      \
> > > > } while (0)
> > >
> > > But in this case the result of testing the condition becomes useless
> > > after spin_unlock_irqrestore - someone might grab the lock and change
> > > things.   Therefore the calling code would need to add a loop around
> > > wait_event_lock - and the wait_event_* macros were added precisely to
> > > encapsulate such a loop and avoid the need to code it manually.
> > 
> > Ok, i understand now what the patch really wants to achieve. However,
> > I'm not convinced it's a good idea. In the usb/gadget/serial.c driver,
> > this appears to work only because an unconventional locking scheme is
> > used, i.e. there is an extra flag (port->port_in_use) that is set to
> > tell other functions about the state of the lock in case the lock holder
> > wants to sleep.
> > 
> > Is there any place in the kernel that would benefit of the
> > wait_event_lock() macro family while using locks without such
> > special magic?
> 
> Sorry for replying from a different account, but it's the best I can
> do right now. I know while I was scanning the whole kernel for other
> wait_event*() replacements, I thought at least a handful of times,
> "ugh, I could replace this whole block of code, except for that lock!"
> I will try to get you a more concrete example on Monday. Thanks for
> the feedback & patience!

Here's at least one example:

drivers/ieee1394/video1394.c:__video1394_ioctl()

I'm having trouble finding more (maybe I already fixed some of them via
the existing macros in different ways -- or maybe my memory is just
acting up...).

I think this patch/macro can be useful for wait-queues where the same
lock is used to protect the sleeper and the sleeper's data?

Any further feedback would be appreciated, or any recommendations for
better ways of doing things. I really would just like to have one
consistent interface for all wait-queue usage :) The fact that was is
nearly (but not quite) done by wait_event*() has to be defined somewhere
else just to get that functionality, when it costs little to add it to a
common header, makes this a pretty small change to me.

But, Arnd, I understand your concern. It would not be good if we had a
bunch of lock-holding sleepers pop up now! I will try to think of a
better solution.

Thanks,
Nish
