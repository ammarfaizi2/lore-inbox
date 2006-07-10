Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWGJIkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWGJIkU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 04:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWGJIkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 04:40:19 -0400
Received: from mail.gmx.de ([213.165.64.21]:37840 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751364AbWGJIkT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 04:40:19 -0400
Cc: lcapitulino@mandriva.com.br, vendor-sec@lst.de,
       linux-kernel@vger.kernel.org, akpm@osdl.org, michael.kerrisk@gmx.net
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 10 Jul 2006 10:40:17 +0200
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
In-Reply-To: <20060710082423.GI4141@suse.de>
Message-ID: <20060710084017.109310@gmx.net>
MIME-Version: 1.0
References: <20060707131310.0e382585@doriath.conectiva>
 <20060708064131.GG4188@suse.de> <20060708180926.00b1c0f8@home.brethil>
 <20060709103606.GU4188@suse.de> <20060709111629.GV4188@suse.de>
 <20060709134703.0aa5bc41@home.brethil> <20060709175744.GZ4188@suse.de>
 <20060710062551.307040@gmx.net> <20060710064355.GB4141@suse.de>
 <20060710080917.286970@gmx.net> <20060710082423.GI4141@suse.de>
Subject: Re: splice/tee bugs?
To: Jens Axboe <axboe@suse.de>
X-Authenticated: #24879014
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens,

> > Thanks.  I applied your patch against 2.6.17(.0), and did some
> > testing using my modified version of your test program, using 
> > the same command line: ls *.c | ktee r | wc, and also running 
> > several instances of the program in parallel using the 
> > command line:
> > 
> > find . | ktee r | wc
> > 
> > which in my test directory produces this output:
> > 
> > tee returned 65536
> > splice returned 65536
> > tee returned 65536
> > splice returned 65536
> > tee returned 53248
> > splice returned 53248
> > tee returned 57344
> > splice returned 57344
> > tee returned 7245
> > splice returned 7245
> > tee returned 0
> >    6212    6213  248909
> > 
> > Things look good so far: runs produce the results I expect, and 
> > no OOPSes (which Luiz Fernando reported when running multiple
> > instances in parallel, but I didn't see myself because I didn't
> > try doing that with vanilla 2.6.17) and no command-line hangs.
> 
> So far, so good.
> 
> > > The most notable differences between my program and yours
> > > are:
> > >
> > > * I print some debugging info to stderr.
> > >
> > > * I don't pass SPLICE_F_NONBLOCK to tee().
> > [...]
> > > On different runs I see:
> > >
> > > a) No output from ls through the pipeline:
> > >
> > > tee returned 0
> > >       0       0       0
> > 
> > I am no longer seeing results like this. So am I correct in 
> > understanding that tee() should only return 0 on EOF?
> 
> tee() can still return 0 without SPLICE_F_NONBLOCK being set, if the
> pipes are changed in between the _prep calls and link_pipe(). There's
> really nothing we can do about that. There's no EOF condition for
> link_pipe(), as it purely operates on pipes. A 0 return means that we
> had no data to splice and could not wait for data, either because it
> would be a locking violation or because it simply doesn't make sense to
> wait (eg no writers attached to the pipe). It will only return EAGAIN
> for a non-blocking tee() now though.

Okay.

[...]

> > > c) Occasionally the command line just hangs, producing no output.
> > >    In this case I can't kill it with ^C or ^\.  This is a
> > >    hard-to-reproduce behaviour on my (x86) system, but I have
> > >    seen it several times by now.
> > 
> > I no longer see this behaviour (at least so far, after quite a
> > bit of testing).
> 
> Good, it should be fixed with the blocking removal from link_pipe().
> 
> > One slight strangeness.  Most of the time, the 
> > "find . | ktee r | wc" command line takes about 0.1 seconds to 
> > execute, but about 1 time in 5 on my x86 system, it takes about 
> > 1.5 to 2 seconds to execute.  Any ideas about what's happening 
> > there?
> 
> That is pretty odd. Any chance you can do a quick sysrq-t and see where
> find/ktee/wc is stuck when this happens? You should not be seeing that,
> naturally, I'll see if I can reproduce that here. How much data does
> find . return in your example?

See the start of this message.

One sysrq-t output output below.

Cheers,

Michael


find          D B9099C00     0 14170   4167         14171       (NOTLB)
   ca279d04 00118054 00000008 b9099c00 003d0ca2 e7b0b9f8 00000009 d307f688
   d307f580 c0459dc0 c1507620 b9099c00 003d0ca2 00000000 00000000 00118054
   00000001 00001000 c015010e e647f5ac e647f5b8 00000046 00000000 00000000
Call Trace:
 <c015010e> __getblk+0x1d/0x225
 <c03e1e7c> io_schedule+0x26/0x30
 <c0150874> sync_buffer+0x37/0x3a
 <c03e25fd> __wait_on_bit+0x33/0x59
 <c015083d> sync_buffer+0x0/0x3a
 <c03e2695> out_of_line_wait_on_bit+0x72/0x7a
 <c015083d> sync_buffer+0x0/0x3a
 <c0127dd5> wake_bit_function+0x0/0x34
 <c019e39b> search_by_key+0x133/0xd91
 <c0110a1c> do_page_fault+0x0/0x532
 <c0189e2d> search_by_entry_key+0x20/0x22f
 <c015dc76> filldir64+0x8e/0xc3
 <c019e214> pathrelse+0x1b/0x2f
 <c019388c> reiserfs_readdir+0x3e3/0x3fb
 <c0193895> reiserfs_readdir+0x3ec/0x3fb
 <c018d6e5> reiserfs_update_sd_size+0x67/0x24c
 <c01a55c9> journal_begin+0x9c/0xdc
 <c0196cb0> reiserfs_dirty_inode+0x5a/0x76
 <c016bacc> __mark_inode_dirty+0x2d/0x15e
 <c015dd9a> vfs_readdir+0x58/0x6f
 <c015de14> sys_getdents64+0x63/0xa8
 <c015dbe8> filldir64+0x0/0xc3
 <c010287f> syscall_call+0x7/0xb
ktee          S FCFCA100     0 14171   4167         14172 14170 (NOTLB)
   ccad7f40 d4a13668 d4a13668 fcfca100 003d0ca2 e75553a0 00000009 d0fd8648
   d0fd8540 e7a9c030 c1507620 fcfca100 003d0ca2 00000000 00000000 cde230cc
   e75552dc 00000000 00000202 ccad7f68 00000000 e4930a00 00000000 ccad7f68
Call Trace:
 <c0158a0d> pipe_wait+0x6b/0x8c
 <c0132e9d> audit_syscall_entry+0x104/0x12b
 <c0127d9b> autoremove_wake_function+0x0/0x3a
 <c017026b> sys_tee+0x149/0x3af
 <c010287f> syscall_call+0x7/0xb
wc            S B8CC9300     0 14172   4167               14171 (NOTLB)
   d012dec0 e70be2ac e70be304 b8cc9300 003d0ca2 0000011b 00000009 d07d6178
   d07d6070 d4bbea50 c1507620 b8cc9300 003d0ca2 00000000 00000000 c045f800
   00000000 00000246 00000202 d012dee8 00000000 d1f5ca00 bfa2a386 d012dee8
Call Trace:
 <c0158a0d> pipe_wait+0x6b/0x8c
 <c0127d9b> autoremove_wake_function+0x0/0x3a
 <c01590fb> pipe_readv+0x2c9/0x339
 <c013f60a> __handle_mm_fault+0x27c/0x73c
 <c013f771> __handle_mm_fault+0x3e3/0x73c
 <c0159191> pipe_read+0x26/0x2a
 <c014ea2b> vfs_read+0x87/0x11b
 <c014ee76> sys_read+0x3b/0x64
 <c010287f> syscall_call+0x7/0xb



-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  
Grab the latest tarball at
ftp://ftp.win.tue.nl/pub/linux-local/manpages/, 
read the HOWTOHELP file and grep the source 
files for 'FIXME'.
