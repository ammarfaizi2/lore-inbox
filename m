Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264278AbUFRATy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbUFRATy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 20:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264610AbUFRATx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 20:19:53 -0400
Received: from chaos.analogic.com ([204.178.40.224]:41856 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264278AbUFRATv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 20:19:51 -0400
Date: Thu, 17 Jun 2004 20:19:41 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Ben Greear <greearb@candelatech.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: poll
In-Reply-To: <40D21C8E.4040500@candelatech.com>
Message-ID: <Pine.LNX.4.53.0406171958570.3414@chaos>
References: <Pine.LNX.4.53.0406170954190.702@chaos> <40D21C8E.4040500@candelatech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2004, Ben Greear wrote:

> Richard B. Johnson wrote:
> > Hello,
> > Is it okay to use the 'extra' bits in the poll return value for
> > something? In other words, is the kernel going to allow a user-space
> > program to define some poll-bits that it waits for, these bits
> > having been used in the driver?
>
> Can't you just do a read and determine from the results of the read
> what you actually got?  If not, add framing to your message so that
> you *CAN* determine one message type from another...
>
> Ben
>

The mailbox read(s) is/are 32-bit int(s). There is no way to identify
it as being "new" or something that was written two weeks ago.
That's why we use poll. Poll says 'I got something new for you'.

If I can't use 'spare' bits in poll to identify what I want to
go get I would need to make a separate system-call ioctl() to
find out what it is. This is wasteful of time that is very scarce.

If I returned that information in some kind of structure (descriptor),
then the process that gets the information, including the mailbox
content, will probably not be the process that needs that mailbox
content so another task would need to get something that has already
been read and the resulting poll bits already cleared. The driver
has no way of knowing which of the open file-descriptors needs
such-and-such information. Only the user-mode code knows that.

Currently, everybody who is sleeping in poll() gets awakened when
a new mail-box message is available. They all check to see if the
bit is one they are waiting for. If so, they execute an ioctl() that
gets the specific mailbox content and resets the poll-flag bit.

This all works fine-and-dandy with kernel 2.4.26. However, Linux
has a history of removing availability of undefined things. If
it is not intended that the extra bits be used, my bet is that
somebody will immediately patch the kernel to AND the poll-flag
with 0x3ff, probably for spite, and future kernels won't
have the existing capability. So I need to know soon if this
is going to be done. If so, I probably need to find some other
way (maybe some other OS --no not that one, that's not an OS...,
but the Bee one may be more suitable for embedded stuff considering
that Linux has exploded).

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


