Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVCMVLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVCMVLp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 16:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVCMVLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 16:11:44 -0500
Received: from fire.osdl.org ([65.172.181.4]:7068 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261460AbVCMVLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 16:11:37 -0500
Date: Sun, 13 Mar 2005 13:13:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Stas Sergeev <stsp@aknet.ru>
cc: Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@redhat.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: [patch] x86: fix ESP corruption CPU bug
In-Reply-To: <4234A8DD.9080305@aknet.ru>
Message-ID: <Pine.LNX.4.58.0503131306450.2822@ppc970.osdl.org>
References: <42348474.7040808@aknet.ru> <20050313201020.GB8231@elf.ucw.cz>
 <4234A8DD.9080305@aknet.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 13 Mar 2005, Stas Sergeev wrote:
>
> Such an optimization will cost three more
> instructions, one of which is a "taken"
> jump.

I think Pavel missed the fact that you have to check the VM86 bit in
eflags before you check SS, since otherwise SS doesn't mean anything
special at all (ie checking for just the normal SS isn't correct: you
could have a 16-bit SS that looks normal, but is actually a vm86 segment).

Pavel: for the same reason you have to check the low two bits of CS too, 
since if they are zero, then SS hasn't been saved on the stack at all, so 
comparing it against some normal value is meaningless.

That said, the "ldt_ss" case should be moved _after_ the conditional
tests, since most CPU's out there will do static prediction based on
forward/backwards direction if the branch predictor isn't primed. And so
since it's an unusual case, the branch should be a forward branch, which
is usually the not-taken one (this depends on the core, of course, and you
could also add the prefix byte to mark it explicitly predict-not-taken for 
the newer cores that support it).

			Linus
