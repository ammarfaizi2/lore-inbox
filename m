Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWGGM03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWGGM03 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 08:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWGGM03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 08:26:29 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:7431 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932106AbWGGM03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 08:26:29 -0400
Date: Fri, 7 Jul 2006 14:28:50 +0200
From: Jens Axboe <axboe@suse.de>
To: Michael Kerrisk <mtk-manpages@gmx.net>
Cc: Andrew Morton <akpm@osdl.org>, michael.kerrisk@gmx.net,
       linux-kernel@vger.kernel.org
Subject: Re: splice/tee bugs?
Message-ID: <20060707122850.GU4188@suse.de>
References: <20060707070703.165520@gmx.net> <20060707040749.97f8c1fc.akpm@osdl.org> <20060707114235.243260@gmx.net> <20060707120333.GR4188@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060707120333.GR4188@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07 2006, Jens Axboe wrote:
> On Fri, Jul 07 2006, Michael Kerrisk wrote:
> > > > c) Occasionally the command line just hangs, producing no output.
> > > >    In this case I can't kill it with ^C or ^\.  This is a 
> > > >    hard-to-reproduce behaviour on my (x86) system, but I have 
> > > >    seen it several times by now.
> > > 
> > > aka local DoS.  Please capture sysrq-T output next time.
> > 
> > I don't have sysrq configured in the kernel that I'm testing at 
> > the moment (I'll build again with sysrq), but have just got 
> > the error again.  For what it's worth, "ps l" says:
> > 
> > F   UID   PID  PPID PRI  NI    VSZ   RSS WCHAN  STAT TTY        TIME COMMAND
> > 0  1000  7099   630  16   0      0     0 -      D+   pts/30     0:00 [ktee]
> 
> Try ps -eo cmd,wchan, it should give you a little more at least. But
> sysrq-t is the best, of course.
> 
> I'll see about reproducing locally.

With your modified ktee, I can reproduce it here. Here's the ktee and wc
output:

ktee2         D 00000002     0 10027   3182         10028       (L-TLB)
       f5cd7da0 00000002 f5cd7d8c 00000002 f5cd7d48 c0148c1e f5cd7d58
c18a5914 
       c03edc80 c19a9f50 00000007 00000000 c1ff1ab0 b5d39d0a 0000003a
067a9ddd 
       c1ff1bc0 c19aa720 00000000 00000000 06d4480b 00000000 c0474880
c0474880 
Call Trace:
 [<c0389114>] __mutex_lock_slowpath+0x95/0x236
 [<c03892d1>] mutex_lock+0x1c/0x1f
 [<c016cff7>] pipe_read_fasync+0x24/0x57
 [<c016d2d4>] pipe_read_release+0x12/0x23
 [<c01623c7>] __fput+0x53/0x141
 [<c016250e>] fput+0x19/0x1c
 [<c015fc84>] filp_close+0x41/0x67
 [<c0121c1a>] put_files_struct+0xa6/0xb8
 [<c0122d06>] do_exit+0x124/0x8dd
 [<c01045a7>] do_trap+0x0/0x9e
 [<c01179d9>] do_page_fault+0x274/0x586
 [<c0103b6d>] error_code+0x39/0x40
 [<c0103039>] sysenter_past_esp+0x56/0x79

wc            D C1DB7F74     0 10028   3182               10027 (NOTLB)
       c1db7ec8 00000002 c1db7eb4 c1db7f74 00000246 00000101 00000001
00000000 
       00000003 c1db7f68 00000007 00000001 f6351ab0 af26d8c3 0000003a
0011c727 
       f6351bc0 c19b2720 00000002 00000044 001ce734 00000000 c0474880
c0474880 
Call Trace:
 [<c0389114>] __mutex_lock_slowpath+0x95/0x236
 [<c03892d1>] mutex_lock+0x1c/0x1f
 [<c016d910>] pipe_readv+0x54/0x3a9
 [<c016dc84>] pipe_read+0x1f/0x21
 [<c0161bbf>] vfs_read+0x85/0xf6
 [<c0162048>] sys_read+0x3d/0x64
 [<c0103039>] sysenter_past_esp+0x56/0x79

I'll dig around.

-- 
Jens Axboe

