Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161169AbVIPQDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161169AbVIPQDE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 12:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161170AbVIPQDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 12:03:04 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:11532 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1161169AbVIPQDC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 12:03:02 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <87irx1ujc0.fsf@amaterasu.srvr.nix>
References: <a5986103050915004846d05841@mail.gmail.com><1e62d137050915010361d10139@mail.gmail.com><a598610305091505184a8aa8fd@mail.gmail.com><1e62d13705091508391832f897@mail.gmail.com><87mzmduq1h.fsf@amaterasu.srvr.nix><1126879660.3103.6.camel@localhost.localdomain> <87irx1ujc0.fsf@amaterasu.srvr.nix>
X-OriginalArrivalTime: 16 Sep 2005 16:03:00.0574 (UTC) FILETIME=[1C9DE7E0:01C5BAD8]
Content-class: urn:content-classes:message
Subject: Re: best way to access device driver functions
Date: Fri, 16 Sep 2005 12:02:59 -0400
Message-ID: <Pine.LNX.4.61.0509161133410.2041@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: best way to access device driver functions
Thread-Index: AcW62BypDYg8eJHlQFeyOqODUiwsHQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Nix" <nix@esperi.org.uk>
Cc: <arjanv@redhat.com>, <linux-kernel@vger.kernel.org>,
       <ivan.korzakow@gmail.com>, <fawadlateef@gmail.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Sep 2005, Nix wrote:

> On 16 Sep 2005, Arjan van de Ven noted:
>>
>>> New *system calls* are generally avoided (especially if they might be
>>> useful to non-privileged code) because they come with a *very* high
>>> backward compatibility burden
>>
>> ioctls come with the same burden though.
>
> Well, sort of. A lot of ioctl()s are widely-known and surely can't be
> changed, just like syscalls (e.g. the terminal control stuff) --- but
> in the past even things like the HD geometry ioctls have changed,
> and ioctl()s specific to, say, a single obscure block device could
> probably change without requiring recompilation of more than one or
> two userspace programs (and this has happened).
>
> Indeed, one of the problems with ioctl()s is that there is no clear
> delineation: some ioctl()s are heavily used and some are totally
> unused, and it's never clear which is which in all cases.
>
> (I suppose this is sort of true of syscalls too --- how many people call
> sys_uselib()? --- but to a much lesser extent, because there's no such
> thing as an `obscure device-specific syscall'.)
>
> --
> `One cannot, after all, be expected to read every single word
> of a book whose author one wishes to insult.' --- Richard Dawkins
> -

But an ioctl is supposed to be specific to your device. After all,
you access it with a fd obtained by opening your device. To keep
`strace` from "interpreting" your ioctl function-code, it was
common to start device-specific ioctl function values higher than
the ones used by common kernel devices.

Using another interface to provide device-specific control is
more "Sun-like", "BSD-like", or "Linux-like", not necessarily
bad or good. The defacto "Unix" way is to use ioctl(). That's
what it was provided for; "The ioctl() function manipilates the
underlying device parameters of special files." -- from the
AT&T System-V release 2 programmer's reference manual.

Somebody reported to me that there was some special "optimization"
in Linux that interpreted ioctl() function calls without regard
to the specific device that was open (gawd I hope not), and that
if you used "already-used" function numbers for your device-specific
ioctl(), then strange things would occur. If true, then that is
a bug. Code inspection of fs/ioctl.c doesn't show this to be
the case. However, the kernel is now LOCKED during an ioctl()
call. Older Linux versions didn't lock the kernel. The upshot
of this is that if you have some ioctl() function that takes
some time, like testing the memory in your board, you will
find the system unresponsive during that test! You can unlock
the kernel in your ioctl() if this is a problem.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.53 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
