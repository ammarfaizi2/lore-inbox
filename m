Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129091AbQK1Tux>; Tue, 28 Nov 2000 14:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129183AbQK1Tuo>; Tue, 28 Nov 2000 14:50:44 -0500
Received: from mx2.eskimo.com ([204.122.16.49]:62738 "EHLO mx2.eskimo.com")
        by vger.kernel.org with ESMTP id <S129091AbQK1Tuc>;
        Tue, 28 Nov 2000 14:50:32 -0500
Date: Tue, 28 Nov 2000 11:19:42 -0800 (PST)
From: Clayton Weaver <cgweav@eskimo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: reproducible 2.2.1x nethangs
Message-ID: <Pine.SUN.3.96.1001128102439.6304A-100000@eskimo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I retract the comment about "accept() 2nd argument scribbled over
in the child". That was a misinterpretation of the strace log.
strace shows the struct sockaddr * scribble in the parent after a restart
of the accept() call. Also, the firewalling code is eliminated from
consideration. I compiled it and ppp out, and the only difference was that
the hang happened sooner, in about a dozen http connects instead of
around 30.

What happens, according to strace, is that accept() gets interrupted when
the SIGCHLD signal is delivered after the child that handled the previous
connect exits, and accept() sets ERESTARTSYS.

For the first N connects, this is not problematic. accept() is called
again, it returns normally, the fork() happens, everything is
copascetic. But eventually the restarted accept() call shows nul bytes in
the struct sockaddr *addr arg value in the strace output after
restarting accept, and a few connects later the kernel hangs.

If the socket itself is truly ozoned when strace says the accept() struct
sockaddr * argument has changed in between interrupt and restart, the
subsequent forked child shouldn't be able to send at all, but that is not
what happens. That html document gets there.

Yet the kernel always hangs within a few connects of seeing that, so I'd
be suspicious of the internal kernel data associated with that socket
when it comes time to deallocate it. The accept() code in the context of
interrupts that cause it to be stopped and restarted is at least worth a
look for possible races.

Regards,

Clayton Weaver
<mailto:cgweav@eskimo.com>
(Seattle)

"Everybody's ignorant, just in different subjects."  Will Rogers



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
