Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270405AbTGMVHY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 17:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270406AbTGMVHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 17:07:24 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:22151 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S270405AbTGMVHQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 17:07:16 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 13 Jul 2003 14:14:33 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: David Schwartz <davids@webmaster.com>
cc: Eric Varsanyi <e0206@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [Patch][RFC] epoll and half closed TCP connections
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKIEEPEFAA.davids@webmaster.com>
Message-ID: <Pine.LNX.4.55.0307131334380.15022@bigblue.dev.mcafeelabs.com>
References: <MDEHLPKNGKAHNMBLJOLKIEEPEFAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jul 2003, David Schwartz wrote:

> 	For most real-world loads, M is some fraction of N. The fraction
> asymptotically approaches 1 as load increases because under load it takes
> you longer to get back to polling, so a higher fraction of the descriptors
> will be ready when you do.
>
> 	Even if you argue that most real-world loads consists of a few very busy
> file descriptors and a lot of idle file descriptors, why would you think
> that this ratio changes as the number of connections increase? Say a group
> of two servers is handling a bunch of connections. Some of those connections
> will be very active and some will be very idle. But surely the *percentage*
> of active connections won't change just becase the connections are split
> over the servers 50/50 rather than 10/90.
>
> 	If a particular protocol and usage sees 10 idle connections for every
> active one, then N will be ten times M, and O(M) will be the same as O(N).
> It's only if a higher percentage of connections are idle when there are more
> connections (which seems an extreme rarity to me) that O(M) is better than
> O(N).

Apoligize, I abused of O(*) (hopefully noone of my math profs are on lkml :).
Yes, N/M has little/none fluctuation in the N domain. So, using O(*)
correctly, they both scale O(N). But, we can trivially say that if we call
CP the cost of poll() in CPU cycles, and CE the cost of epoll :

CP(N, M) = KP * N
EP(N, M) = KE * M

Where KP and KE are constant that depends on the code architecture of the
two systems. If we fix KA (active coefficent ) :

KA = M / N

we can write the scalability coefficent like :

         KP * N          KP
KS = ------------- = ---------
      KE * KA * N     KE * KA

The scalability coefficent is clearly inv. proportional to KA. Let's look
at what the poll code does :

1) It has to allocate the kernel buffer for events

2) It has to copy it from userspace

3) It has to allocate wait queue buffer calling get_free_page (possibly
	multiple times when we talk about decent fds numbers)

4) It has to loop calling N times f_op->poll() that in turn will add into
	the wait queue getting/releasing IRQ locks

5) Loop another M loop to copy events to userspace

6) Call kfree() for all blocks allocated

7) Call poll_freewait() that will go with another N loop to unregister
	poll waits, that in turn will do another N IRQ locks

The epoll code does remember/cache things so that KE is largely lower that
KP, and this together with a pretty low KA explain results about poll
scalability against epoll.



> 	Is there any actual evidence to suggest that epoll scales better than poll
> for "real loads"? Tests with increasing numbers of idle file descriptors as
> the active count stays constant are not real loads.

Yes, of course. The time spent inside poll/select becomes a PITA when you
start dealing with huge number of fds. And this is kernel time. This does
not obviously mean that if epoll is 10 times faster than poll under load,
and you switch your app on epoll, it'll be ten times faster. It means that
the kernel time spent inside poll will be 1/10. And many of the operations
done by poll require IRQ locks and this increase the time the kernel
spend with disabled IRQs, that is never a good thing.



- Davide

