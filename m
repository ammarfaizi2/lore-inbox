Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269057AbUJKREc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269057AbUJKREc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 13:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268957AbUJKRDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 13:03:13 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:10949 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S269070AbUJKQrO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 12:47:14 -0400
From: David Brownell <david-b@pacbell.net>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Totally broken PCI PM calls
Date: Mon, 11 Oct 2004 09:47:38 -0700
User-Agent: KMail/1.6.2
Cc: Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
References: <1097455528.25489.9.camel@gaston> <Pine.LNX.4.58.0410102102140.3897@ppc970.osdl.org> <16746.2820.352047.970214@cargo.ozlabs.ibm.com>
In-Reply-To: <16746.2820.352047.970214@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410110947.38730.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 October 2004 9:24 pm, Paul Mackerras wrote:
> Linus Torvalds writes:
> 
> > And they are unbroken again (well, at least they work for me again).  
> > Partly by the PM_ renumbering under discussion.
> 
> Interesting.  I find that with suspend-to-ram, USB keyboards don't
> work after resume, and that the system will hang on resume if you
> remove a USB device during sleep.

A "hang" sounds like the pmcore bug I reported about a year ago...

It's rather foolish of the PM core to use the same semaphore to
protect system-wide suspend/resume operations that it uses to
for mutual exclusion on the device add/remove (which suspend
and resume callbacks did happily in 2.4) ... since it's routine to
unplug peripherals on suspended systems!

Alternatively, if you're combininging USB_SUSPEND with any
system-wide suspend operation, you're asking for trouble;
the PM core is just not ready for that.  (In fact I've wondered
if maybe 2.6.9 shouldn't discourage that combination more
actively...)

But a keyboard-specific issue might be improved with the
HID patch I posted last week, teaching that driver how to
handle suspend() and resume() callbacks.

- Dave

