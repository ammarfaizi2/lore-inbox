Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbVKWEcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbVKWEcd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 23:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbVKWEcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 23:32:33 -0500
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:44700 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S932510AbVKWEcc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 23:32:32 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: termios VMIN and VTIME behavior
Date: Tue, 22 Nov 2005 20:32:29 -0800
Message-ID: <64F9B87B6B770947A9F8391472E0321603A075B1@ehost011-8.exch011.intermedia.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: termios VMIN and VTIME behavior
Thread-Index: AcXv1CUVdwX9eEWSSTycbyk0/tHVpQAEAhXw
From: "Mike Voytovich" <mike@zermattsystems.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 23 Nov 2005 04:32:32.0126 (UTC) FILETIME=[EB6D69E0:01C5EFE6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please disregard - the user app was reading less than VMIN in the read()
call, so I suppose the current behavior in that case would be correct
(returning immediately with the number of bytes passed into read()
rather than waiting for VMIN or VTIME to be met before returning).

It doesn't appear that the behavior in this case is explicitly defined
by POSIX, but it seems like a reasonable thing to do.

thanks,
-mike

-----Original Message-----
From: Mike Voytovich 
Sent: Tuesday, November 22, 2005 6:18 PM
To: 'linux-kernel@vger.kernel.org'
Subject: termios VMIN and VTIME behavior

Hi,

I have a question regarding the implementation of the termios VMIN and
VTIME.

For the case where VMIN>0, VTIME>0, Linux does not obey VMIN - when a
single character is received by the device, it is immediately returned,
instead of waiting for either the timer to expire or VMIN bytes.


In n_tty.c, if VTIME is set, tty->minimum_to_wake is always set to 1:

        if (!tty->icanon) {
                time = (HZ / 10) * TIME_CHAR(tty);
                minimum = MIN_CHAR(tty);
                if (minimum) {
                        if (time)
                                tty->minimum_to_wake = 1;
                        else if (!waitqueue_active(&tty->read_wait) ||
                                 (tty->minimum_to_wake > minimum))
                                tty->minimum_to_wake = minimum;


The POSIX spec describes different behavior:


[snip]
 11.1.7 Non-Canonical Mode Input Processing

In non-canonical mode input processing, input bytes are not assembled
into lines, and erase and kill processing shall not occur. The values of
the MIN and TIME members of the c_cc array are used to determine how to
process the bytes received. IEEE Std 1003.1-2001 does not specify
whether the setting of O_NONBLOCK takes precedence over MIN or TIME
settings. Therefore, if O_NONBLOCK is set, read() may return
immediately, regardless of the setting of MIN or TIME. Also, if no data
is available, read() may either return 0, or return -1 with errno set to
[EAGAIN].

MIN represents the minimum number of bytes that should be received when
the read() function returns successfully. TIME is a timer of 0.1 second
granularity that is used to time out bursty and short-term data
transmissions. If MIN is greater than {MAX_INPUT}, the response to the
request is undefined. The four possible values for MIN and TIME and
their interactions are described below.

Case A: MIN>0, TIME>0

In case A, TIME serves as an inter-byte timer which shall be activated
after the first byte is received. Since it is an inter-byte timer, it
shall be reset after a byte is received. The interaction between MIN and
TIME is as follows. As soon as one byte is received, the inter-byte
timer shall be started. If MIN bytes are received before the inter-byte
timer expires (remember that the timer is reset upon receipt of each
byte), the read shall be satisfied. If the timer expires before MIN
bytes are received, the characters received to that point shall be
returned to the user. Note that if TIME expires at least one byte shall
be returned because the timer would not have been enabled unless a byte
was received. In this case (MIN>0, TIME>0) the read shall block until
the MIN and TIME mechanisms are activated by the receipt of the first
byte, or a signal is received. If data is in the buffer at the time of
the read(), the result shall be as if data has been received immediately
after the read().

[snip]




Note that I did read a thread on LKML regarding termios behavior back
from 2002:

http://www.uwsg.indiana.edu/hypermail/linux/kernel/0206.2/0355.html

However this seems to address the behavior of termios in general, rather
than this particular case of MIN>0, TIME>0.



Does anyone have an opinion regarding whether or not the Linux
implementation for this particular case (MIN>0, TIME>0) should be
changed to match POSIX?  Can I submit a patch?


thanks,
-mike
