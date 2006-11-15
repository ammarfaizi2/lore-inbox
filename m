Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965864AbWKOHb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965864AbWKOHb6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965889AbWKOHb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:31:58 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:19334 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP id S965864AbWKOHb5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:31:57 -0500
Subject: Re: Patch to fixe Data Acess error in dup_fd
From: Sharyathi Nagesh <sharyath@in.ibm.com>
Reply-To: sharyath@in.ibm.com
To: Sergey Vlasov <vsu@altlinux.ru>, Vadim Lobanov <vlobanov@speakeasy.net>
Cc: Pavel Emelianov <xemul@sw.ru>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1163540156.5412.9.camel@impinj-lt-0046>
References: <1163151121.3539.15.camel@legolas.in.ibm.com>
	 <20061114181656.6328e51a.vsu@altlinux.ru>
	 <1163530154.4871.14.camel@impinj-lt-0046>
	 <20061114204236.GA10840@procyon.home>
	 <1163540156.5412.9.camel@impinj-lt-0046>
Content-Type: text/plain
Organization: IBM
Date: Wed, 15 Nov 2006 13:08:20 +0530
Message-Id: <1163576300.8208.14.camel@legolas.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lobanov/Sergey
On Tue, 2006-11-14 at 13:35 -0800, Vadim Lobanov wrote:
> On Tue, 2006-11-14 at 23:42 +0300, Sergey Vlasov wrote:
> > Yes, very interesting (although if the problem appeared only after 72
> > hours of testing, it is hard to be sure that the bug is really fixed).
> 
> Yep. Could be random memory corruption from some other piece of the
> code.
> 
> > > [...] The open_files value that
> > > count_open_files() returns will always be a multiple of BITS_PER_LONG,
> > > so no extraneous bits will ever be copied. It's a tad confusing since
> > > count_open_files() does something a bit different than what its name
> > > suggests.
> > 
> > Yes, then the logic looks fine.  (The comment in count_open_files()
> > says "Find the last open fd", which is _almost_ what it does.)
> 
> It's always the details that getcha. :) There's other implicit tricks
> that the code pulls, such as implicit requirements for minimum size
> granularity of certain data structures. It basically comes down to
> trying to read and understand all the surrounding code.
> 
> > There is also some unused code and slightly incorrect comment in
> > dup_fd():
> > 
> > 	size = old_fdt->max_fdset;
> > 
> > ... here "size" is not used ....
> > 
> > 	/* if the old fdset gets grown now, we'll only copy up to "size" fds */
> > 
> > ... here "size" is not used either ....
> > 
> > 	size = (new_fdt->max_fds - open_files) * sizeof(struct file *);
> > 
> > The result of the first assignment to "size" is not used anywhere,
> > even if it is mentioned in the comment.  However, the intent to keep
> > the old size of fdset is noted again.
> 
> I read that comment in my mind like this: s/"size"/"open_files"/g. The
> wording can definitely be improved, though. Any takers?
> 
> I also already sent a patch to Andrew a while ago to clean up that
> unused assignment to "size", as part of a bigger fdtable-rework
> patchset. This code is currently getting its testing in -mm for the time
> being.
> 
> > > 0:mon> e
> > > cpu 0x0: Vector: 300 (Data Access) at [c00000007ce2f7f0]
> > >     pc: c000000000060d90: .dup_fd+0x240/0x39c
> > >     lr: c000000000060d6c: .dup_fd+0x21c/0x39c
> > >     sp: c00000007ce2fa70
> > >    msr: 800000000000b032
> > >    dar: ffffffff00000028
> > >  dsisr: 40000000
> > >   current = 0xc000000074950980
> > >   paca    = 0xc000000000454500
> > >     pid   = 27330, comm = bash
> > > 
> > > 0:mon> t
> > > [c00000007ce2fa70] c000000000060d28 .dup_fd+0x1d8/0x39c (unreliable)
> > > [c00000007ce2fb30] c000000000060f48 .copy_files+0x5c/0x88
> > > [c00000007ce2fbd0] c000000000061f5c .copy_process+0x574/0x1520
> > > [c00000007ce2fcd0] c000000000062f88 .do_fork+0x80/0x1c4
> > > [c00000007ce2fdc0] c000000000011790 .sys_clone+0x5c/0x74
> > > [c00000007ce2fe30] c000000000008950 .ppc_clone+0x8/0xc
> > > 
> > > The PC translates to:
> > >         for (i = open_files; i != 0; i--) {
> > >                 struct file *f = *old_fds++;
> > >                 if (f) {
> > >                         get_file(f);       <-- Data access error
> > 
> > So we probably got a bogus "struct file" pointer...
> > 
> > >                 } else {
> > > 
> > > And more info still:
> > >         0:mon> r
> > > R00 = ffffffff00000028   R16 = 00000000100e0000
> > > R01 = c00000007ce2fa70   R17 = 000000000fff1d38
> > > R02 = c00000000056cd20   R18 = 0000000000000000
> > > R03 = c000000029f40a58   R19 = 0000000001200011
> > > R04 = c000000029f442d8   R20 = c0000000a544a2a0
> > > R05 = 0000000000000001   R21 = 0000000000000000
> > > R06 = 0000000000000024   R22 = 0000000000000100
> > > R07 = 0000001000000000   R23 = c00000008635f5e8
> > > R08 = 0000000000000000   R24 = c0000000919c5448
> > > R09 = 0000000000000024   R25 = 0000000000000100
> > > R10 = 00000000000000dc   R26 = c000000086359c30
> > > R11 = ffffffff00000000   R27 = c000000089e5e230
> > > R12 = 0000000006bbd9e9   R28 = c00000000c8d3d80
> > > R13 = c000000000454500   R29 = 0000000000000020
> > > R14 = c00000007ce2fea0   R30 = c000000000491fc8
> > > R15 = 00000000fcb2e770   R31 = c0000000b8369b08
> > > pc  = c000000000060d90 .dup_fd+0x240/0x39c
> > > lr  = c000000000060d6c .dup_fd+0x21c/0x39c
> > > msr = 800000000000b032   cr  = 24242428
> > > ctr = 0000000000000000   xer = 0000000000000000   trap =  300
> > > dar = ffffffff00000028   dsisr = 40000000
> > > -----------------------
> > > 0:mon> di c000000000060d90 <==PC
> > > c000000000060d90  7d200028      lwarx   r9,r0,r0
> > > c000000000060d94  31290001      addic   r9,r9,1
> > > c000000000060d98  7d20012d      stwcx.  r9,r0,r0
> > > c000000000060d9c  40a2fff4      bne     c000000000060d90        # .dup_fd+0x240/0x39c
> > 
> >  From what little I know about PowerPC, this looks like an atomic
> > increment of the memory word pointed to by r0, which contains
> > 0xffffffff00000028 - definitely looks like a bogus address.  The
> > offset of file->f_count should be 0x28 on a 64-bit architecture, so
> > apparently we got f == 0xffffffff00000000 from *old_fds.  Something
> > scribbled over that memory?

   This is very interesting: after reading through I am feeling there is high chance this 
could as well be a memory corruption issue. But if the issue is memory getting corrupted 
what could be the possible reasons.
   I had observed random slab corruption issues in the machine, could
that may have resulted in corruption, we may be opening up larger issues
here about which I am not much aware of, 

> Looks very likely. It would be ironic if the fdsets somehow scribbled
> there -- a series of all ones in the open_fds. :)
> 
> I sent a request asking which version of the kernel did this. 2.6.19-mm1
> without hotfixes could crash like this, due to a bug in the new fdtable
> code. Aside from that, and if noone can recognize some sort of magical
> constant value in those registers above, it might be bisection time.
> 
Lobanov
   Excuse me for the late response.
   The kernel version on which it is tested is: 2.6.18-1 (Distro   
   variant)
   Test suite:
   TCP/IO stress are from ltp test suite: you can find about them  
   here:           http://ltp.sourceforge.net/testPlan.php#6.0 

   


