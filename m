Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbVHWMHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbVHWMHX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 08:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbVHWMHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 08:07:23 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:60544 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S932140AbVHWMHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 08:07:22 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>,
       "Robert Hancock" <hancockr@shaw.ca>
Subject: Re: sched_yield() makes OpenLDAP slow
Date: Tue, 23 Aug 2005 15:07:02 +0300
User-Agent: KMail/1.5.4
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
References: <4D8eT-4rg-31@gated-at.bofh.it> <4309E07F.8010304@shaw.ca> <Pine.LNX.4.61.0508230714180.22122@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0508230714180.22122@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508231507.02252.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 August 2005 14:17, linux-os \(Dick Johnson\) wrote:
> 
> On Mon, 22 Aug 2005, Robert Hancock wrote:
> 
> > linux-os (Dick Johnson) wrote:
> >> I reported thet sched_yield() wasn't working (at least as expected)
> >> back in March of 2004.
> >>
> >>  		for(;;)
> >>                      sched_yield();
> >>
> >> ... takes 100% CPU time as reported by `top`. It should take
> >> practically 0. Somebody said that this was because `top` was
> >> broken, others said that it was because I didn't know how to
> >> code. Nevertheless, the problem was not fixed, even after
> >> schedular changes were made for the current version.
> >
> > This is what I would expect if run on an otherwise idle machine.
> > sched_yield just puts you at the back of the line for runnable
> > processes, it doesn't magically cause you to go to sleep somehow.
> >
> 
> When a kernel build is occurring??? Plus `top` itself.... It damn
> well sleep while giving up the CPU. If it doesn't it's broken.

top doesn't run all the time:

# strace -o top.strace -tt top

14:52:19.407958 write(1, "  758 root      16   0   104   2"..., 79) = 79
14:52:19.408318 write(1, "  759 root      16   0   100   1"..., 79) = 79
14:52:19.408659 write(1, "  760 root      16   0   100   1"..., 79) = 79
14:52:19.409001 write(1, "  761 root      18   0  2604  39"..., 74) = 74
14:52:19.409342 write(1, "  763 daemon    17   0   108   1"..., 78) = 78
14:52:19.409672 write(1, "  773 root      16   0   104   2"..., 79) = 79
14:52:19.410010 write(1, "  774 root      16   0   104   2"..., 79) = 79
14:52:19.410362 write(1, "  775 root      16   0   100   1"..., 79) = 79
14:52:19.410692 write(1, "  776 root      16   0   104   2"..., 79) = 79
14:52:19.411136 write(1, "  777 daemon    17   0   108   1"..., 86) = 86
14:52:19.411505 select(1, [0], NULL, NULL, {5, 0}) = 0 (Timeout)
	hrrr..... psssss.......
14:52:24.411744 time([1124797944])      = 1124797944
14:52:24.411883 lseek(4, 0, SEEK_SET)   = 0
14:52:24.411957 read(4, "24822.01 18801.28\n", 1023) = 18
14:52:24.412082 access("/var/run/utmpx", F_OK) = -1 ENOENT (No such file or directory)
14:52:24.412224 open("/var/run/utmp", O_RDWR) = 8
14:52:24.412328 fcntl64(8, F_GETFD)     = 0
14:52:24.412399 fcntl64(8, F_SETFD, FD_CLOEXEC) = 0
14:52:24.412467 _llseek(8, 0, [0], SEEK_SET) = 0
14:52:24.412556 alarm(0)                = 0
14:52:24.412643 rt_sigaction(SIGALRM, {0x4015a57c, [], SA_RESTORER, 0x40094ae8}, {SIG_DFL}, 8) = 0
14:52:24.412747 alarm(1)                = 0

However, kernel compile shouldn't.

I suggest stracing with -tt "for(;;) yield();" test proggy with and without
kernel compile in parallel, and comparing the output...

Hmm... actually, knowing that you will argue to death instead...

# cat t.c
#include <sched.h>

int main() {
    for(;;) sched_yield();
    return 0;
}
# gcc t.c
# strace -tt ./a.out
...
15:03:41.211324 sched_yield()           = 0
15:03:41.211673 sched_yield()           = 0
15:03:41.212034 sched_yield()           = 0
15:03:41.212400 sched_yield()           = 0
15:03:41.212749 sched_yield()           = 0
15:03:41.213126 sched_yield()           = 0
15:03:41.213486 sched_yield()           = 0
15:03:41.213835 sched_yield()           = 0
15:03:41.214220 sched_yield()           = 0
15:03:41.214577 sched_yield()           = 0
15:03:41.214939 sched_yield()           = 0
    I start "while true; do true; done" on another console...
15:03:43.314645 sched_yield()           = 0
15:03:43.847644 sched_yield()           = 0
15:03:43.954635 sched_yield()           = 0
15:03:44.063798 sched_yield()           = 0
15:03:44.171596 sched_yield()           = 0
15:03:44.282624 sched_yield()           = 0
15:03:44.391632 sched_yield()           = 0
15:03:44.498609 sched_yield()           = 0
15:03:44.605584 sched_yield()           = 0
15:03:44.712538 sched_yield()           = 0
15:03:44.819557 sched_yield()           = 0
15:03:44.928594 sched_yield()           = 0
15:03:45.040603 sched_yield()           = 0
15:03:45.148545 sched_yield()           = 0
15:03:45.259311 sched_yield()           = 0
15:03:45.368563 sched_yield()           = 0
15:03:45.476482 sched_yield()           = 0
15:03:45.583568 sched_yield()           = 0
15:03:45.690491 sched_yield()           = 0
15:03:45.797512 sched_yield()           = 0
15:03:45.906534 sched_yield()           = 0
15:03:46.013545 sched_yield()           = 0
15:03:46.120505 sched_yield()           = 0
Ctrl-C

# uname -a
Linux firebird 2.6.12-r4 #1 SMP Sun Jul 17 13:51:47 EEST 2005 i686 unknown unknown GNU/Linux
--
vda

