Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbTKOAVp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 19:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbTKOAVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 19:21:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:34524 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261176AbTKOAVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 19:21:44 -0500
Date: Fri, 14 Nov 2003 16:21:38 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: trini@kernel.crashing.org, <benh@kernel.crashing.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PPC32: cancel syscall restart on signal delivery
In-Reply-To: <16309.28037.896731.19038@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.44.0311141612220.2214-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 15 Nov 2003, Paul Mackerras wrote:
> 
> BTW, do we have a test program that triggers the bug that this fixes?

No. In fact, it's an _incredibly_ tiny race, because the old code that 
only handled it at the return path of the system call that got interrupted 
would catch the thing in all cases _except_ if the system

 (a) decided to restart the system call
 (b) got an interrupt _after_ the return to user mode but _before_ the 
     system call instruction itself actually did the restart
 (c) this interrupt caused a new signal with a handler (different from the
     one that caused the restart, since that one by definition had no
     handler) to the same program.

On x86, for the old calling conventions (ie "int 0x80"), that meant that 
the interrupt window was literally a single instruction. For the new one 
("sysenter") it was two instructions.  So you literally need a minimum of 
two different signals, and a incredibly tight window.

To make it even worse, even if the above incredibly unlikely thing
actually _happens_, most of the time it wouldn't really matter. The worst
case schenario is that the signal handler itself does a system call that
needs restarting, in which case on signal handler return we now restart
the _wrong_ system call once we return. But a more likely schenario is
that we restart the right system call after the signal handler has run,
rather than returning EINTR.

Quite frankly, the only reason I even thought about it was due to the 
clock_nanosleep() patch to fix the posix timer restart code. Which just 
made me trace the sequence again in my head.

			Linus

