Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312134AbSCXX0K>; Sun, 24 Mar 2002 18:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312136AbSCXX0A>; Sun, 24 Mar 2002 18:26:00 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:14340 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S312134AbSCXXZy>; Sun, 24 Mar 2002 18:25:54 -0500
Message-ID: <3C9E6014.BB3DE865@zip.com.au>
Date: Sun, 24 Mar 2002 15:24:05 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Paul Clements <Paul.Clements@SteelEye.com>, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.18 raid1 - fix SMP locking/interrupt errors, fix resync 
 counter errors
In-Reply-To: message from Paul Clements on Friday March 22 <15518.22081.287786.88466@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> 
> ...
> The save/restore versions are only needed if the code might be called
> from interrupt context.

Or if the caller may wish to keep interrupts disabled.

> However the routines where you made this
> change: raid1_grow_buffers, raid1_shrink_buffers, close_sync,
> are only ever called from process context, with interrupts enabled.
> Or am I missing something?

If those functions are always called with interrupts enabled then
no, you're not missing anything ;)

However a bare spin_unlock_irq() in a function means that
callers which wish to keep interrupts disabled are subtly
subverted.   We've had bugs from this before.

So the irqrestore functions are much more robust.  I believe
that they should be the default choice.  The non-restore
versions should be viewed as a micro-optimised version,
to be used with caution.  The additional expense of the save/restore
is quite tiny - 20-30 cycles, perhaps.

-
