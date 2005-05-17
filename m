Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVEQDfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVEQDfZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 23:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVEQDfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 23:35:25 -0400
Received: from fire.osdl.org ([65.172.181.4]:57774 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261233AbVEQDfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 23:35:12 -0400
Date: Mon, 16 May 2005 20:37:04 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Lameter <christoph@lameter.com>
cc: randy_dunlap <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, shai@scalex86.org, ak@suse.de
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt.
In-Reply-To: <Pine.LNX.4.62.0505161954470.25647@graphe.net>
Message-ID: <Pine.LNX.4.58.0505162029240.18337@ppc970.osdl.org>
References: <Pine.LNX.4.62.0505161243580.13692@ScMPusgw>
 <20050516150907.6fde04d3.akpm@osdl.org> <Pine.LNX.4.62.0505161934220.25315@graphe.net>
 <20050516194651.1debabfd.rdunlap@xenotime.net> <Pine.LNX.4.62.0505161954470.25647@graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 16 May 2005, Christoph Lameter wrote:
> 
> That would not allow to set the value of CONFIG_HZ to a numeric value.
> I would have CONFIG_HZ_100 CONFIG_HZ_250 etc. Gets a bit complicated
> to handle.

I don't think it gets any more complex to handle than the stuff you need 
to do now (#ifdef's, and the #define HZ CONFIG_HZ games).

Also, I think you can do it in the Kconfig file, which at least makes it a 
fairly localized thing:

	choice
		prompt "Timer frequency"
		default HZ_250

	config HZ_100
		bool "100 Hz"

	confic HZ_250
		bool "250 Hz"

	config HZ_1000
		bool "1000 Hz"

	endchoice

	config HZ
		int
		default 100 if HZ_100
		default 250 if HZ_250
		default 1000 if HZ_1000

and now you can just do

	#define HZ CONFIG_HZ

or something. You can even maje the Kconfig parts be a separate Kconfig.HZ
file, and have both the x86 and x86-64 Kconfig files just include the
common part (since it's a generic issue, not even PC-related: we might
want to allow things like 60Hz frequencies for CONFIG_EMBEDDED etc, and
these choices are really valid on any system that allows for the timer to
be reprogrammed)

The above is obviously totally untested, but it doesn't look any more
complex than having a fairly ugly (and much less user-friendly) check at
compile-time.

		Linus
