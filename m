Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262489AbULOU7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbULOU7Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 15:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbULOU7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 15:59:23 -0500
Received: from gw.goop.org ([64.81.55.164]:48282 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S262489AbULOU6G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 15:58:06 -0500
Subject: Re: 32-bit syscalls from 64-bit process on x86-64?
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Andi Kleen <ak@suse.de>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041215105510.GF27225@wotan.suse.de>
References: <380350F3EC1@vcnet.vc.cvut.cz>
	 <20041215042704.GE27225@wotan.suse.de>
	 <1103107807.24540.23.camel@localhost>
	 <20041215105510.GF27225@wotan.suse.de>
Content-Type: text/plain
Date: Wed, 15 Dec 2004 12:58:05 -0800
Message-Id: <1103144285.13338.30.camel@minilith.goop.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-15 at 11:55 +0100, Andi Kleen wrote:
> Hmm, in theory you could handle a 64bit signal frame from 32bit code
> (just may need an assembly stub if you want the arguments). But it 
> would be quite ugly agreed.

Yes.  I've tried this out, and it works OK, but it isn't pleasing.  One
of the main problems is that the stack is likely to be above 4G, so %esp
has no useful value, and when you switch to 64-bit mode, the top 32-bits
of %rsp become undefined.

> Perhaps it should force __USER_CS yes in this case, agreed.
> 
> There is a small risk of breaking someone, but it's very small.

Well, if they've got code which is already switching between 32 and 64
bit segments, then they need to cope with either cs being current at
delivery time.

> I can do that change if you want.
> 
> BTW the long term plan is to get rid of the special cases to make
> it easierto use the 32bit kernel ABI from a 64bit program.
> This means signal handling will likely just check the code segment
> at some  point to decide if it should set up 32bit or 64bit frames
> and we'll probably do similar things with the other cases 
> (except exec which needs to stay this way) 

At syscall time, rather than delivery time, I assume.  Hm, I'd prefer it
if it didn't look at the current segment, but at the syscall path.  Ie,
installing a handler with __NR_rt_sigaction via int 0x80 (or 32-bit
syscall/sysenter) should set up a 32-bit frame on delivery, but if the
handler was installed with the 64-bit syscall, it should be called with
a 64-bit frame.

> If you're interested in this I guess that could be done sooner
> with some patch submissions (hint hint ;)

I'll take a look.

	J

