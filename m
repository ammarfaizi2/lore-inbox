Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267850AbUG3WCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267850AbUG3WCt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 18:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267726AbUG3WCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 18:02:49 -0400
Received: from mail.inter-page.com ([12.5.23.93]:59401 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S267850AbUG3WCo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 18:02:44 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "'David S. Miller'" <davem@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: tcp_push_pending_frames() without TCP_CORK or TCP_NODELAY
Date: Fri, 30 Jul 2004 15:02:33 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAto7TSbyGCEOKEjP4Tiu9VgEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <20040729193637.36d018a5.davem@redhat.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought about turning cork on an off.  While it does essentially burp the transfer
into larger frames it is still flawed for my usage for several reasons.

Omitting the uninteresting parts and giving a real-but-partial example...

In one of the applications I am stuck with I have a USB device on one machine that I
am tunneling onto another.  The reasons I can't just plug the USB device into the
other machine are tedious.  The USB device "bursts" 32 characters at a time maximum.
I also send monitoring information "on the side band" (on the same socket in sequence
with the data but marked as control information) on occasion, which is where my
application-level framing comes into play.  Normally it is fine to just use TCP as-is
and let things Nagle normally and live with the induced delay.

Now consider running PPP on that device over that tunnel.  Again it is uninteresting
why I can't run pppd on the computer local to the USB device.  If the TCP stream is
flushed when any 32-or-less byte burst ends with the PPP framing character, the data
throughput on ppp interface abstracted across the tunnel rises considerably.

In the current implementation, the only flush available in TCP is to turn nagle off
and then back on, which over the course of a tunnel lifespan adds a significant
number of syscalls.

1) I am not really interested in delaying the front of the frames as much as I am
interested in expediting the end of the frames.  So I don't actually want to cork the
stream, I just want to flush it under easily detectable conditions.

2) There are times when the frames can be larger than the Ethernet MTU so corking
starts getting counter-productive.

3) There are times when the right moment to release a cork isn't determinable (as I
don't want the tunnel in the business of guessing whether the overlying user is or
isn't in ppp mode).

4) Cork-then-uncork would still end up with two syscalls instead of one.

5) Just turning Nagle off completely begins to scale rather poorly as device count
increases because of the large number of 32 byte payloads.

I can imagine other protocols and applications (near-real-time signaling or games?)
that could benefit from a flush operation on the TCP stack; and indeed I have another
one in force that is less easy to explain (without getting really boring 8-) than the
above.


Rob White,
Casabyte, Inc.

-----Original Message-----
From: David S. Miller [mailto:davem@redhat.com] 
Sent: Thursday, July 29, 2004 7:37 PM
To: Robert White
Cc: linux-kernel@vger.kernel.org
Subject: Re: tcp_push_pending_frames() without TCP_CORK or TCP_NODELAY


Turn off NAGLE, and flip TCP_CORK on and off around the sequences.


