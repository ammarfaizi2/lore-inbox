Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282893AbRLLXj5>; Wed, 12 Dec 2001 18:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282890AbRLLXjs>; Wed, 12 Dec 2001 18:39:48 -0500
Received: from jhuml4.jhu.edu ([128.220.2.67]:32920 "EHLO jhuml4.jhu.edu")
	by vger.kernel.org with ESMTP id <S282896AbRLLXje>;
	Wed, 12 Dec 2001 18:39:34 -0500
Date: Wed, 12 Dec 2001 18:40:26 -0500
From: Thomas Hood <jdthood@mail.com>
Subject: Re: USB not processing APM suspend event properly?
To: linux-kernel@vger.kernel.org
Message-id: <1008200427.1134.29.camel@thanatos>
MIME-version: 1.0
X-Mailer: Evolution/1.0 (Preview Release)
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This was caused by the PCMCIA network interface being
> off, and the apmd scripts trying to fuser -k and
> unmount an in-use NFS partition, which in turn wanted
> to generate NFS traffic to the server over the shut
> down PCMCIA network interface...

So your problem was that PCMCIA got shut down too early.

> Basically, I've changed the order that things happen on
> suspend, such that we always pass the event to apmd, and
> any other listeners on /dev/apm_bios.  Once everyone has
> replied (subject to the rules of course), it then sends
> the PM_SUSPEND to the devices.

I suppose that the reason why it is presently coded as
it is is that the drivers can veto the suspend whereas
the "listeners" can't, and the apm driver wants to tell
the listeners about the event only if it isn't vetoed.
With your change, the apm driver really should ignore
a veto from the drivers since it has already told the
listeners about the event.  Therefore, while your patch
is an improvement, it still isn't the whole solution.

One possible solution is for the apm driver first to _ask_
the device drivers whether a suspend is allowed; then
to tell the listeners; then to tell the device drivers
to suspend.  This solution could be implemented by adding
the "ask" function to each driver with pm support.  The
driver's opportunity to veto the suspend would be when
it is asked, not when it is told to suspend.

> The original code sent PM_SUSPEND on receiving the original
> request, and then multiple times each time a listener on
> /dev/apm_bios replied.  Not good if apmd wants to unmount
> NFS, and your NFS mounts require traffic over your PCMCIA
> ether card!

Actually, it's not true that the original code sends PM_SUSPEND
each time a listener on /dev/apm_bios replies.  The code 
fragment is:
                if (as->suspends_read > 0) {
                        as->suspends_read--;
                        as->suspends_pending--;
                        suspends_pending--;
                } else if (!send_event(APM_USER_SUSPEND))
                        return -EAGAIN;
                else
                        queue_event(APM_USER_SUSPEND, as);
This only calls send_event() if the ioctl(suspend) is NOT a
reply to a notification that was earlier read from the queue.


