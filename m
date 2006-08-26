Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422991AbWHZSQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422991AbWHZSQp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 14:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422992AbWHZSQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 14:16:45 -0400
Received: from science.horizon.com ([192.35.100.1]:12076 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1422991AbWHZSQp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 14:16:45 -0400
Date: 26 Aug 2006 14:16:39 -0400
Message-ID: <20060826181639.6545.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: Serial custom speed deprecated?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Or we could just add a standardised extra set of speed ioctls, but then
> we need to decide what occurs if I set the speed and then issue a
> termios call - does it override or not.

Actually, we're not QUITE out of bits.  CBAUDEX | B0 is not taken.
That would make a reasonable encoding for a custom speed.
(But I haven't checked glibc... ah, yes, it should work!
See glibc-2.4/sysdeps/unix/sysv/linux/speed.c; browse at
http://sources.redhat.com/cgi-bin/cvsweb.cgi/libc/sysdeps/unix/sysv/linux/?cvsroot=glibc
if you don't have a local copy source handy.)

What I'd do is, when converting to the old-style for tcgetattr, if the
current baud rate is not representable, cache it somewhere and return that
(or some other magic value).  If a tcsetatt call comes in that specifies
that magic value, use the cached baud rate.

If you make the cache just the current baud rate setting (the magic
value on set means "don't alter"), that will handle a lot of programs
that just want to play with handshaking.

If you make the cache separate, you can also survive an
old-interface-using program switching to a different baud rate and then
switching back.


Also note that if you truly want to support all baud rates in historical
use, you'll need to include at least one fractional bit for 134.5 baud.
(Unless you're sure that IBM 2741 terminals are truly dead. :-))

Alternatively, you could observe that asynchronous communications only
requires agreement withing 5% between sender and receiver, so specifying
a baud rate to much better than 1% is not too important.

Half-precision floating point would be ideal for the job. :-)
