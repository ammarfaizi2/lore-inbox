Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264883AbUEQDhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264883AbUEQDhG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 23:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbUEQDhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 23:37:06 -0400
Received: from taco.zianet.com ([216.234.192.159]:7184 "HELO taco.zianet.com")
	by vger.kernel.org with SMTP id S264883AbUEQDgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 23:36:55 -0400
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s && s->tree' failed: The saga continues.)
Date: Sun, 16 May 2004 21:36:23 -0600
User-Agent: KMail/1.6.1
Cc: Larry McVoy <lm@bitmover.com>, Andrew Morton <akpm@osdl.org>,
       adi@bitmover.com, scole@lanl.gov, support@bitmover.com,
       linux-kernel@vger.kernel.org
References: <200405132232.01484.elenstev@mesatop.com> <20040517022816.GA14939@work.bitmover.com> <Pine.LNX.4.58.0405161936490.25502@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405161936490.25502@ppc970.osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405162136.24441.elenstev@mesatop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 May 2004 08:42 pm, Linus Torvalds wrote:
> 
> On Sun, 16 May 2004, Larry McVoy wrote:
> > 
> > Be aware that how BK does I/O is with write() on the way out but with 
> > mmap on the way in.  The process which forked renumber has just written
> > the file and the renumber process is reading it with mmap.
> > 
> > If there are still any problems with mixing read/write and mmap then that
> > may be a prolem but I would have expected to see things start going 
> > wrong on a page boundary and the one core dump I saw was page aligned 
> > at the tail but not at the head, it started in the middle of the page.
> 
> The kernel should have no problems with mixed read/write and mmap usage, 
> although user space obviously needs to synchronize the accesses on its own 
> some way. There is no implicit synchronization otherwise, and the mmap 
> user can see a partial write at any stage of the write.
> 
> Some architectures may have cache coherency issues that makes this
> "interesting", but that's not the case on x86 (or indeed anything else
> remotely sane - virtual caches are just stupid in this day and age).
> 
> > I've told my team to drop this unless someone can show that it happens
> > on other kernels, this smells like a kernel bug to me, if it were a BK
> > bug we should have been getting hundreds of complaints by now.  We can
> > jump back on it if need be, let us know if you think it is a BK problem
> > after all.
> 
> Yeah, I agree. The only other possibility I see is that BK just doesn't
> synchronize, and expects writes to be atomically visible to other
> processes. They aren't. Preemption might just make this a whole lot more 
> visible, but on the other hand, so should SMP, so this sounds unlikely.
> 
> 		Linus
> 
> 
Larry, Linus,

I beat on this for last day without PREEMPT and no failures at all.
Several kernels, rock solid all.
Rebooted with an current (as of a couple hours ago) kernel and PREEMPT=y,
and after about the third pull into a repository (I have several), splaaat!

Here are the symptoms.  Same message from bk as usual:
---------------------------------------------------------------------------
takepatch: saved entire patch in PENDING/2004-05-16.01
---------------------------------------------------------------------------
Applying  15 revisions to ChangeSet renumber: can't read SCCS info in "RESYNC/SCCS/s.ChangeSet".
bk: takepatch.c:1343: applyCsetPatch: Assertion `s && s->tree' failed.
10586 bytes uncompressed to 52074, 4.92X expansion

One of Larry's guys, Rick Smith, sent me a little program (the source
is earlier in this thread) to check for null.  I called its executable
saga (see subject line).

[steven@spc SCCS]$ saga <s.ChangeSet
Found null start 0x1550b01 end 0x1551000 len 0x4ff line 535587
Found null start 0x2030b01 end 0x2031000 len 0x4ff line 639039
Found null start 0x2330b01 end 0x2331000 len 0x4ff line 663611

That was in the testing-2.6/RESYNC/SCCS directory of course.

OK, no more CONFIG_PREEMPT for me.  And, ppp failed earlier with:
serial8250: too much work for irq10.  That did not happen without
CONFIG_PREEMPT.

I reconnected to my ISP, bk pulled into my main testing repository, 
and that's when I got the splaaat.

Steven
