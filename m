Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135427AbRDWPlN>; Mon, 23 Apr 2001 11:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135397AbRDWPlG>; Mon, 23 Apr 2001 11:41:06 -0400
Received: from t2.redhat.com ([199.183.24.243]:20210 "EHLO
	warthog.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S135427AbRDWPkT>; Mon, 23 Apr 2001 11:40:19 -0400
To: "Alon Ziv" <alonz@nolaviz.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: light weight user level semaphores 
In-Reply-To: Your message of "Mon, 23 Apr 2001 16:48:25 +0200."
             <015001c0cc04$748c4860$910201c0@zapper> 
Date: Mon, 23 Apr 2001 16:40:04 +0100
Message-ID: <4586.988040404@warthog.cambridge.redhat.com>
From: David Howells <dhowells@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alon Ziv <alonz@nolaviz.org> wrote:
> Obviously... since they're handles, not FDs...
> [BTW, are you using Windows' idea of storing the objects in process space,
> in a page that's inaccessible to the app itself, and passing pointers into
> this page as the handles?]

No... I grab a page in kernel space and use it as an array. One problem is
that if an exit occurs, I have to be able to discard all attached objects
after the process's VM has been cleaned up (ie: what if it gets swapped
out?). Plus, mmap can clobber existing mappings, MapViewOfFile can't.

> So what if they aren't files?

Small structures private to my Win32 module.

> I'm afraid I'm not following your logic in this; I believe most Win32 attrs
> can be mapped to more generic abstractions which should be able to exist at
> 'struct file' level.

"Most"...

It'd mean adding extra fields into struct file (and possibly struct inode)
just for the use of this module (which probably wouldn't be accepted).

> (And even if not, a Win32 file handle could just hold two pointers---

No. the extra data has to be accessible from CreateFile (potentially running
in other processes), and this'd mean it'd have to go speculatively searching
all Win32 handle tables currently in use.

> And breaks _completely_ with the existing scheme :-/

So what? This is for a WINE accelerator/Win32 module only. There's already
been an argument over making the whole lot available as general Linux
functionality, but most people said that it'd be a bad idea because it'd not
be portable.

> Huh? Where did you get this?
> Looking at my copy of MSDN (July '00), the PulseEvent remarks more-or-less
> suggest an implementation like
>     SetEvent(e)
>     ResetEvent(e)

Consider the following:

	WAITER 1	WAITER 2	WAITER 3	WAKER
	wait-on-event	wait-on-event	wait-on-event
	sleep		sleep		sleep
							PulseEvent
							set-event
							wake(WAITER 1)
							wake(WAITER 2)
							wake(WAITER 3)
							reset-event
	wake		wake		wake
	what-happened?	what-happened?	what-happened?
	nothing!	nothing!	nothing!
	sleep		sleep		sleep

All three waiters should wake up with a note that the event triggered, but
they don't. Plus a fourth waiter who begins to wait on the event after the
set-event is issue probably shouldn't wake up.

> I wonder if it's possible to add _just_ this to poll()...

No... there's no way to pass this to poll (or select).

Better to add a WaitForMultipleObjects() syscall and have that call
do_select() with a flag.

David
