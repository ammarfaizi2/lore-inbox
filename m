Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284926AbRLKIvJ>; Tue, 11 Dec 2001 03:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284935AbRLKIu7>; Tue, 11 Dec 2001 03:50:59 -0500
Received: from adsl-63-195-80-148.dsl.snfc21.pacbell.net ([63.195.80.148]:14979
	"EHLO pincoya.com") by vger.kernel.org with ESMTP
	id <S284926AbRLKIus> convert rfc822-to-8bit; Tue, 11 Dec 2001 03:50:48 -0500
Date: Tue, 11 Dec 2001 00:54:11 -0800
From: Gordon Oliver <gordo@pincoya.com>
To: Robert Love <rml@tech9.net>
Cc: gordo@pincoya.com, marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] console close race fix resend
Message-ID: <20011211005411.C14728@furble>
Reply-To: gordo@pincoya.com
In-Reply-To: <1008035512.4287.1.camel@phantasy> <20011210191630.A13679@furble> <1008050718.4287.11.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1008050718.4287.11.camel@phantasy>; from rml@tech9.net on Mon, Dec 10, 2001 at 22:05:18 -0800
X-Mailer: Balsa 1.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2001.12.10 22:05 Robert Love wrote:
> Ehh, I don't think so.  Here is the whole patched function:
> 
> static void con_flush_chars(struct tty_struct *tty)
> {
> 	struct vt_struct *vt = (struct vt_struct *)tty->driver_data;
> 	if (in_interrupt())	/* from flush_to_ldisc */
> 		return;
> 	pm_access(pm_con);
> 	acquire_console_sem();
> 	if (vt)
> 		set_cursor(vt->vc_num);
> 	release_console_sem();
> }
> 
> When we check vt, it isn't stale.  vt is a _pointer_ to the data so that
> first reference against it is guaranteed to grab the correct value.  The
> only possible race is between the if and the set_cursor, but that isn't
> an issue because we acquired the console semaphore.  There is no race
> here.

I like the patch that Andrew Morton sent in reply to this better.
Note that in the event that the above code does the following sequence
it will cause a stale pointer to be used:

	con_flush_chars    con_close
	vt = <>
	                   tty->driver_data = NULL
	acquire_console_sem()
	set_cursor()
	release_console_sem()

Now it _might_ be ok to act on a stale vt pointer, but it sure
feels like thin ice. I'm not sure that there is any danger of
the vt data being modified in a way that would break this, but
since the tty no longer has a reference it is bad practice.

What the earlier patch did is created some very subtle semantics
for a small window of a race. It fixed the blaring bug (the OOPS)
but left a possible one that would be harder to find....
	-gordo
