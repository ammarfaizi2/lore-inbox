Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291314AbSBMClU>; Tue, 12 Feb 2002 21:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291312AbSBMClL>; Tue, 12 Feb 2002 21:41:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45066 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291314AbSBMCkv>;
	Tue, 12 Feb 2002 21:40:51 -0500
Message-ID: <3C69D1FC.195CD36@zip.com.au>
Date: Tue, 12 Feb 2002 18:39:56 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: What is a livelock? (was: [patch] sys_sync livelock fix)
In-Reply-To: <3C69A18A.501BAD42@zip.com.au> <3C69A18A.501BAD42@zip.com.au>
		<87y9hyw4b6.fsf@tigram.bogus.local> <3C69C7E9.E01C3532@zip.com.au> <87pu3aw1ue.fsf@tigram.bogus.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Dietsche wrote:
> 
> Andrew Morton <akpm@zip.com.au> writes:
> 
> > http://www.huis.hiroshima-u.ac.jp/jargon/LexiconEntries/Livelock.html
> >
> > livelock
> >
> > /li:v'lok/ n. A situation in which some critical stage of a task is
> > unable to finish because its clients perpetually create more work
> > for it to do after they have been serviced but before it can clear its
> > queue. Differs from {deadlock} in that the process is not blocked or
> > waiting for anything, but has a virtually infinite amount of work to
> > do and can never catch up.
> 
> I still don't get it :-(. When there is more work, this more work
> needs to be done. So, how could livelock be considered a bug? It's
> just overload. Or is this about the work, which must be done _after_
> the queue is empty?
> 

Yes, it's just overload.  Clearly, the CPU can dirty memory
faster than a disk can clean it.

The bug is the expectation in the design of sync() that
it'll ever be able to make all buffers clean.

We can either:

a) spin madly until the thing which is writing stuff stops.
   This has some merit, but is of course racy.

b) give up when we see it's not working out or

c) acquire sufficient locking to prevent all new dirtyings,
   while we proceed to flush everything to disk.  This is
   pointless, because as soon as we drop those locks, the
   dirtyings start again.

The only reliable way we can do all this is to offline the device
while we flush everything.  That happens on the unmount and
remount-ro path.  We definitely need that to work.

-
