Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131323AbRDWGAn>; Mon, 23 Apr 2001 02:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131344AbRDWGAX>; Mon, 23 Apr 2001 02:00:23 -0400
Received: from leng.mclure.org ([64.81.48.142]:22536 "EHLO
	leng.internal.mclure.org") by vger.kernel.org with ESMTP
	id <S131323AbRDWGAQ>; Mon, 23 Apr 2001 02:00:16 -0400
Date: Sun, 22 Apr 2001 23:00:14 -0700
From: Manuel McLure <manuel@mclure.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel hang on multi-threaded X process crash
Message-ID: <20010422230014.A979@ulthar.internal.mclure.org>
In-Reply-To: <20010422185514.A981@ulthar.internal.mclure.org> <20010422192704.C3618@ulthar.internal.mclure.org> <20010422201701.A970@ulthar.internal.mclure.org> <20010422202339.G970@ulthar.internal.mclure.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010422202339.G970@ulthar.internal.mclure.org>; from manuel@mclure.org on Sun, Apr 22, 2001 at 20:23:39 -0700
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.04.22 20:23 Manuel McLure wrote:
> 
> On 2001.04.22 20:17 Manuel McLure wrote:
> > 
> > On 2001.04.22 19:27 Manuel McLure wrote:
> > > 
> > > On 2001.04.22 18:55 Manuel McLure wrote:
> > > 
> > > > The machine is an Athlon Thunderbird 900MHz with 256M of PC133 DRAM
> > on
> > > an
> > > > MSI K7T Turbo R motherboard. I am running 2.4.3-ac12 currently,
> > > > 2.4.3-ac11
> > > > and 2.4.3-ac5 hung the same way at least once each before I started
> > > > tracking this down. I am running Red Hat 7.1, and am using the
> > > > XFree86-4.0.3 RPMs that come with RH71 with the CVS DRI trunk
> > installed
> > > > over it. The kernel was built with kgcc, a gcc-2.96 built kernel
> has
> > > the
> > > > same problem.
> > > 
> > > Following up on myself, I replaced the contents of /usr/X11R6 server
> > with
> > > the standard 4.0.3 RPMs that come with RH 7.1 and it made no
> > difference.
> > > Also, if it's important my video card is a Voodoo 5 5500.
> > 
> > To follow up on my followup, I can now reproduce this 100% and get the
> > "Trying to vfree()..." message on the console. To do this I start
> > Mozilla,
> > switch to a text console, and do a "killall -QUIT mozilla". A couple of
>                                                     ^^^^^^^
> 
> Make that "killall -QUIT mozilla-bin"...
> 
> 
> > "Trying to vfree()..." messages later, it's big red switch time.
> > 
> > I'm going to try this with standard 2.4.3 as well as the 2.4.2 that
> comes
> > with RH71 - hopefully my filesystem will handle all the fscks :-(

At Andrew Morton's suggestion, I added a BUG() to mm/vmalloc.c:vfree() and
copied down the stack trace. According to gdb on vmlinux, the symbols are:

vfree
release_segments+50
exit_mmap+17
elf_core_dump
elf_core_dump
mmput+38
do_exit+157
do_invalid_op
die+79
do_invalid_op+127
vfree+110
__call_console_drivers+59
_call_console_drivers+87
call_console_drivers+228
release_console_sem+21
error_code+52
elf_core_dump
vfree+110
release_segments+50
exit_mmap+17
elf_core_dump
elf_core_dump
mmput+38
do_coredump+556
collect_signal+168
elf_core_dump
do_signal+418
do_general_protection
force_sig_info+121
do_general_protection
force_sig+17
do_general_protection+53
error_code+52
signal_return+20

(at least one more BUG() output scrolled off the console).

I also tested this on the 2.4.2-2 kernel that comes with RH 7.1 and I did
not see the problem. Also, if with 2.4.3-ac12 I used Alt-Sysrq-s and
Alt-Sysrq-u to sync and mount my filesystems read-only before doing the
killall, the problem did not occur either. Could the core dumping code be
causing the problem?

I'll now try with the base 2.4.3 to see what happens.

-- 
Manuel A. McLure KE6TAW | ...for in Ulthar, according to an ancient
<manuel@mclure.org>     | and significant law, no man may kill a cat.
<http://www.mclure.org> |             -- H.P. Lovecraft

