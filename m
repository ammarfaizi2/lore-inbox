Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266497AbSLJAFy>; Mon, 9 Dec 2002 19:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266507AbSLJAFy>; Mon, 9 Dec 2002 19:05:54 -0500
Received: from dp.samba.org ([66.70.73.150]:17046 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266497AbSLJAFu>;
	Mon, 9 Dec 2002 19:05:50 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15861.12698.361774.252071@argo.ozlabs.ibm.com>
Date: Tue, 10 Dec 2002 11:13:14 +1100
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Mikael Starvik <mikael.starvik@axis.com>,
       "'Daniel Jacobowitz'" <dan@debian.org>,
       "'george anzinger'" <george@mvista.com>,
       "'Jim Houston'" <jim.houston@ccur.com>,
       "'LKML'" <linux-kernel@vger.kernel.org>,
       "'anton@samba.org'" <anton@samba.org>,
       "'David S. Miller'" <davem@redhat.com>, "'ak@muc.de'" <ak@muc.de>,
       "'davidm@hpl.hp.com'" <davidm@hpl.hp.com>,
       "'schwidefsky@de.ibm.com'" <schwidefsky@de.ibm.com>,
       "'ralf@gnu.org'" <ralf@gnu.org>,
       "'willy@debian.org'" <willy@debian.org>
Subject: RE: [PATCH] compatibility syscall layer (lets try again)
In-Reply-To: <Pine.LNX.4.44.0212090906340.3410-100000@home.transmeta.com>
References: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE4E9@mailse01.axis.se>
	<Pine.LNX.4.44.0212090906340.3410-100000@home.transmeta.com>
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> Note that I've not committed the patch to my tree at all, and as far as I
> am concerned this is in somebody elses court (ie somebody that cares about
> restarting). I don't have any strong feelings either way about how
> restarting should work - and I'd like to have somebody take it up and
> testing it as well as having architecture maintainers largely sign off on
> this approach.

There is a simpler way to solve the nanosleep problem which doesn't
involve any more restart magic than we have been using for years.
That is to define a new sys_new_nanosleep system call which takes one
argument which is a pointer to the time to sleep.  If the sleep gets
interrupted by a pending signal, the kernel sys_new_nanosleep will
write back the remaining time (overwriting the requested time) and
return -ERESTARTNOHAND.  The glibc nanosleep() then looks like this:

int nanosleep(const struct timespec *req, struct timespec *rem)
{
	*rem = *req;
	return new_nanosleep(rem);
}

Any reason why this can't work?

(BTW this is Rusty's idea. :)

Regards,
Paul.
