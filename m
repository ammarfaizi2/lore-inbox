Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275086AbTHRVLs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 17:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275083AbTHRVLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 17:11:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:62136 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275086AbTHRVLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 17:11:31 -0400
Date: Mon, 18 Aug 2003 14:07:29 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: davej@redhat.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Debug: sleeping function called from invalid context
Message-Id: <20030818140729.2e3b02f2.rddunlap@osdl.org>
In-Reply-To: <20030816070652.GG325@waste.org>
References: <20030815101856.3eb1e15a.rddunlap@osdl.org>
	<20030815173246.GB9681@redhat.com>
	<20030815123053.2f81ec0a.rddunlap@osdl.org>
	<20030816070652.GG325@waste.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Aug 2003 02:06:52 -0500 Matt Mackall <mpm@selenic.com> wrote:

| On Fri, Aug 15, 2003 at 12:30:53PM -0700, Randy.Dunlap wrote:
| > On Fri, 15 Aug 2003 18:32:47 +0100 Dave Jones <davej@redhat.com> wrote:
| > 
| > | On Fri, Aug 15, 2003 at 10:18:56AM -0700, Randy.Dunlap wrote:
| > | 
| > |  > Debug: sleeping function called from invalid context at include/asm/uaccess.h:473
| > |  > Call Trace:
| > |  >  [<c0120d94>] __might_sleep+0x54/0x5b
| > |  >  [<c010d001>] save_v86_state+0x71/0x1f0
| > |  >  [<c010dbd5>] handle_vm86_fault+0xc5/0xa90
| > |  >  [<c019cab8>] ext3_file_write+0x28/0xc0
| > |  >  [<c011cd96>] __change_page_attr+0x26/0x220
| > |  >  [<c010b310>] do_general_protection+0x0/0x90
| > |  >  [<c010a69d>] error_code+0x2d/0x40
| > |  >  [<c0109657>] syscall_call+0x7/0xb
| > | 
| > | That's one really wierd looking backtrace. What else was that
| > | machine up to at the time ?
| > 
| > Some parts of it are explainable (to me), some not.
| > I don't know what caused a GP fault or why ext3 shows up.
| > 
| > But I can follow from do_general_protection() to handle_vm86_fault()
| > to [inline] return_to_32bit() to save_v86_state() to __might_sleep().
| > 
| > And __might_sleep() is correct if change_page_attr() was called,
| > since it takes a spinlock.  I just can't connect quite all of the dots.
| 
| Ok, there's some stack noise here with the ext3_file_write and
| __change_page_attr.
| 
| Here's what I've figured out so far. You probably have something like
| X running with a driver that calls an image of its own 16-bit BIOS to
| get something done (I think Matrox does this) via sys_vm86. One of the
| arguments to sys_vm86 is a pointer to a vm86plus_struct in userspace
| that gets stashed away in tsk->thread.vm86_info.
| 
| When, for whatever reason, a fixup is needed in vm86 mode, we find
| ourselves in handle_vm86_fault and save_v86_state copied various junk
| out to this userspace struct we've kept a pointer to. Now as far as I
| can tell, there's nothing guaranteeing this struct is pinned down or
| in any way guaranteed to be around when the fault occurs. If the page
| with the struct _does_ get swapped out, we can be in trouble when we
| hit this fault.
| 
| If this is actually a valid analysis, we should probably just pin the
| page for the duration of vm86 as it's already bordering on magical.
| 
| If there's some reason this whole thing is safe, let me know and I'll
| try to get might_sleep to stop complaining about these.
| 
| I suppose we could test it by hacking a program guaranteed to fault in
| vm86 mode and hacking the syscall to force the page out before calling
| do_sys_vm86.

I had another occurrence of this yesterday.  It doesn't seem to be
an error condition AFAICT.

--
~Randy
"Everything is relative."
