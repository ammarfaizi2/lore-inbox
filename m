Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133096AbRDWNs0>; Mon, 23 Apr 2001 09:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133083AbRDWNsR>; Mon, 23 Apr 2001 09:48:17 -0400
Received: from [212.150.182.35] ([212.150.182.35]:30224 "EHLO
	exchange.guidelet.com") by vger.kernel.org with ESMTP
	id <S133096AbRDWNsI>; Mon, 23 Apr 2001 09:48:08 -0400
Message-ID: <015001c0cc04$748c4860$910201c0@zapper>
From: "Alon Ziv" <alonz@nolaviz.org>
To: <linux-kernel@vger.kernel.org>
Cc: "David Howells" <dhowells@warthog.cambridge.redhat.com>
In-Reply-To: <4411.988031989@warthog.cambridge.redhat.com>
Subject: Re: light weight user level semaphores 
Date: Mon, 23 Apr 2001 16:48:25 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David Howells" <dhowells@warthog.cambridge.redhat.com>
> David Woodhouse <dwmw2@infradead.org> wrote:
> > alonz@nolaviz.org said:
> > >  [BTW, another solution is to truly support opaque "handles" to kernel
> > > objects; I believe David Howells is already working on something like
> > > this for Wine?
>
> Yes. However, it uses a different system call set to use them. They
translate
> to small object structures internally.
>

Obviously... since they're handles, not FDs...
[BTW, are you using Windows' idea of storing the objects in process space,
in a
page that's inaccessible to the app itself, and passing pointers into this
page
as the handles?]

> > > The poll interface can be trivially extended to support
> > > waiting on those...]
>
> No, they aren't files. I did not want to use "files" because this would
incur
> a fairly major penalty for each object:
>
So what if they aren't files?
If you look at (e.g.) AIX's poll(), it allows you to put SysV semaphore IDs
in
pollfd structures. (Actually they do even more--- they have an extended
pollfd
struct; but even without it, just putting a handle instead of FD and a
special
event code in a normal pollfd should suffice...)

> struct file + struct dentry + struct inode
>
> Which would mean that Win32 File objects would require two of each, one
set to
> hold the extra Win32 attributes and one set for the actual Linux file.
>

I'm afraid I'm not following your logic in this; I believe most Win32 attrs
can
be mapped to more generic abstractions which should be able to exist at
'struct
file' level.  (And even if not, a Win32 file handle could just hold two
pointers---
one to the 'struct file', and one to the extra attrs...)

> The way I've chosen uses somewhat less memory and should be faster.
>

And breaks _completely_ with the existing scheme :-/

> > ISTR it wasn't quite trivial to do it that way - it would require the
> > addition of an extra argument to the fops->poll() method.
>
> Yes, the PulseEvent operation demands that all processes currently waiting
on
> the event should be woken, but that no processes attaching immediately
> afterward get triggered.
>

Huh? Where did you get this?
Looking at my copy of MSDN (July '00), the PulseEvent remarks more-or-less
suggest
an implementation like
    SetEvent(e)
    ResetEvent(e)
I don't see any mention of 'currently waiting' vs 'new' waiters. (Besides, I
doubt MS
tries to solve this in the SMP case...)

> Oh... and WaitForMultipleObjects also has a "wait for all" option.

Yes, this is a valid point...  I wonder if it's possible to add _just_ this
to
poll()...

    -az


