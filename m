Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284903AbRLKGFn>; Tue, 11 Dec 2001 01:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284905AbRLKGFd>; Tue, 11 Dec 2001 01:05:33 -0500
Received: from zero.tech9.net ([209.61.188.187]:14343 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S284903AbRLKGFS>;
	Tue, 11 Dec 2001 01:05:18 -0500
Subject: Re: [PATCH] console close race fix resend
From: Robert Love <rml@tech9.net>
To: gordo@pincoya.com
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <20011210191630.A13679@furble>
In-Reply-To: <1008035512.4287.1.camel@phantasy> 
	<20011210191630.A13679@furble>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.06.08.57 (Preview Release)
Date: 11 Dec 2001 01:05:18 -0500
Message-Id: <1008050718.4287.11.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-12-10 at 22:16, Gordon Oliver wrote:

> and (c) appears to still have a race... You should extract
> the value from the structure inside the lock, otherwise you
> will still race with con_close (though perhaps a smaller race)
> but since the call to acquire_console_sem() can sleep, the
> vt handle you have may be stale.

Ehh, I don't think so.  Here is the whole patched function:

static void con_flush_chars(struct tty_struct *tty)
{
	struct vt_struct *vt = (struct vt_struct *)tty->driver_data;
	if (in_interrupt())	/* from flush_to_ldisc */
		return;
	pm_access(pm_con);
	acquire_console_sem();
	if (vt)
		set_cursor(vt->vc_num);
	release_console_sem();
}

When we check vt, it isn't stale.  vt is a _pointer_ to the data so that
first reference against it is guaranteed to grab the correct value.  The
only possible race is between the if and the set_cursor, but that isn't
an issue because we acquired the console semaphore.  There is no race
here.

> > Please, for all that is righteous, apply.
> 
> please fix it better first...
> (unless I am mistaken).

Thus, unless I am mistaken, it is fine.  Please, apply.

	Robert Love

