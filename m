Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262014AbVHEXGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbVHEXGg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 19:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbVHEXGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 19:06:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61598 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262014AbVHEXG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 19:06:27 -0400
Date: Fri, 5 Aug 2005 16:06:06 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <gregkh@suse.de>
cc: yhlu <yhlu.kernel@gmail.com>, Roland Dreier <rolandd@cisco.com>,
       linville@tuxdriver.com, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org
Subject: Re: mthca and LinuxBIOS
In-Reply-To: <20050805220015.GA3524@suse.de>
Message-ID: <Pine.LNX.4.58.0508051602350.3258@g5.osdl.org>
References: <86802c440508041230143354c2@mail.gmail.com> <52slxp6o5b.fsf@cisco.com>
 <86802c440508051103500f6942@mail.gmail.com> <86802c4405080511079d01532@mail.gmail.com>
 <52psss5k1x.fsf@cisco.com> <86802c44050805112661d889aa@mail.gmail.com>
 <86802c4405080512254b9cd496@mail.gmail.com> <86802c4405080512451cdcae48@mail.gmail.com>
 <86802c44050805132853070f1@mail.gmail.com> <Pine.LNX.4.58.0508051335440.3258@g5.osdl.org>
 <20050805220015.GA3524@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Aug 2005, Greg KH wrote:
> On Fri, Aug 05, 2005 at 01:38:37PM -0700, Linus Torvalds wrote:
> 
> But what's the real problem we are trying to fix here?

We're screwing up the top 32 bits of the BAR when you resume it. Look at
the patch, you'll see the fix (the other part of the patch looks fine, but
then in order to not overwrite the upper bits with zero again when doing
the _next_ - nonexistent - BAR update, we need to have something that 
avoids writing the next BAR).

Remember: a 64-bit BAR puts the upper 32 bits in what would otherwise be 
the low 32 bits of the next BAR. Which is why we need to mark the next BAR 
resource as _not_ being valid some way - so that we don't try to 
(incorrectly) "restore" it and overwrite the high bits of the previous 
BAR.

Of course, this only hits the (very few) people who not only have 64-bit 
PCI devices, but literally have them mapped in the 4GB+ region. Quite 
uncommon.

		Linus
