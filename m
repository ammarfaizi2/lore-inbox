Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265978AbUHWVCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265978AbUHWVCl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 17:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267747AbUHWU7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:59:30 -0400
Received: from the-village.bc.nu ([81.2.110.252]:47506 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267304AbUHWURU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 16:17:20 -0400
Subject: Re: 2.6.8.1-mm4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: zdzichu@irc.pl, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040823124013.19ceb34f.akpm@osdl.org>
References: <20040822013402.5917b991.akpm@osdl.org>
	 <20040823182113.GA30882@irc.pl>
	 <1093285874.29822.19.camel@localhost.localdomain>
	 <20040823124013.19ceb34f.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093288507.29850.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 23 Aug 2004 20:15:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-23 at 20:40, Andrew Morton wrote:
> Noooo.  copy_*_user() returns zero on success and "number of bytes
> remaining to be copied" on fault.  The number of places in the kernel which
> actually care about the precision of the "number remaining to be copied"
> thing is very small.  Most places just test for non-zeroness.

Sorry thats what I meant to say but got it backwards. There are a lot of
users of the value actually - all the serial drivers for example use it
to get the right results. Networking too gets fun because you can send a
packet and want to report that you did something before the fault
occurred. True POSIX doesn't seem to require this behaviour (I guess it
wants to define passing bogus addresses as undefined because of MMUless
systems and library emulation of calls).

> The problem is that the current semantics are hard to implement on several
> architectures.  To get it right, sparc64 has to go back and copy one byte
> at a time just to work out the address at which the fault really occurred.

Who cares? Faults are not fast paths. Also if I understand sparc64
correctly it doesn't have to go back and copy one at a time because a
fault can only occur on a page boundary. That means for the normal case
you already know where the fault occurred and for the unusual case its
one probe per page, all non fast-path.

Alan

