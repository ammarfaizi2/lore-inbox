Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282102AbRK1JoS>; Wed, 28 Nov 2001 04:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282104AbRK1JoI>; Wed, 28 Nov 2001 04:44:08 -0500
Received: from mail.spylog.com ([194.67.35.220]:14821 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S282103AbRK1Jny>;
	Wed, 28 Nov 2001 04:43:54 -0500
Date: Wed, 28 Nov 2001 12:44:43 +0300
From: Peter Zaitsev <pz@spylog.ru>
X-Mailer: The Bat! (v1.53d)
Reply-To: Peter Zaitsev <pz@spylog.ru>
Organization: SpyLOG
X-Priority: 3 (Normal)
Message-ID: <82783014345.20011128124443@spylog.ru>
To: Jeff Epler <jepler@unpythonic.dhs.org>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re[2]: MMAP issues
In-Reply-To: <20011127163650.B15307@unpythonic.dhs.org>
In-Reply-To: <183721898675.20011127194607@spylog.ru>
 <3C03D108.E3FADE95@zip.com.au> <149725995035.20011127205424@spylog.ru>
 <20011127163650.B15307@unpythonic.dhs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jeff,

Wednesday, November 28, 2001, 1:36:51 AM, you wrote:

JE> The difference in runtime between successive runs of your program
JE> doesn't look terribly significant.

Yes. The interesting thing it's  Quite stable  - I've repeated it
several times over reboot and the time always grows over runs.
But then I waited couple of hours and then repeated the test it showed
good results again (all of this time machine was completely idle) so
it looks like VM does clean itself up over time.


JE> You open 'fd' each time, and never close it.  I die about 1000 mmap()s
JE> into the process (-EMFILE returned by sys_open).  You may be testing
JE> Linux' performance with huge fd sets in your test as well.
Yes. I'm testing the same test as my application does - many mmaped
fd, the only difference is it uses different files. I've set  ulimit
and /proc/sys/fs/file-max to be able to open 500.000 of files and
this is quite fast - it takes only couple of seconds to open. So
large fd sets is not the issue for linux.


JE> Moving the open() outside the loop, and running on a 512M, kernel 2.2
JE> machine that's also running a full gnome desktop I get really intense
JE> kernel CPU usage, and the following output:
JE>  10000  Time: 12
JE>  20000  Time: 45
JE>  30000  Time: 79
JE>  40000  Time: 113
JE> [and I got too bored to watch it go on]

Yes.  This is quite expected but does not explain anything therefore
becomes even more interesting - as MAP ammoniums is quite fast even
with large number of mmaps  the finding the hole in address space to
map does not take much time, so what does it ?


JE> Unmapping the page after each map yields much better results:

JE>  10000  Time: 4
JE>  20000  Time: 4
JE>  30000  Time: 4
JE>  40000  Time: 5
JE>  50000  Time: 4
JE>  60000  Time: 4
JE>  70000  Time: 5
JE>  80000  Time: 5
JE>  90000  Time: 5
JE>  100000  Time: 4
JE> [etc]

Yes. This shows what the speed degrades over increasing number of
mmaped segment not mmap calls

JE> Interestingly, forcing the test to allocate at successively lower
JE> addresses gives fast results until mmap fails (collided with a shared
JE> library?):
JE>  10000  Time: 4
JE>  20000  Time: 4
JE>  30000  Time: 4
JE>  40000  Time: 4
JE>  50000  Time: 4
JE>  60000  Time: 4
JE> Failed 0x60007000 12

You mean you self calculated free address and called mmap with it ?
If so this is quite strange as with mmap ammoniums  mmap is able to
find free block quite fast.


JE> So in kernel 2.2, it looks like some sort of linked list ordered by user
JE> address is being traversed in order to complete the mmap() operation.
JE> If so, then the O(N^2)-like behavior you saw in your original report is
JE> explained as the expected performance of linux' mmap for a given # of
JE> mappings.

Well but why it's different for mmaping file and ammoniums MMAP.

Also I should show the same looking distribution for Solaris 8/x86 (the
CPU is different so I can't compare real numbers)

testserv:~ # ./a.out
 10000  Time: 16
 20000  Time: 53
 30000  Time: 87
 40000  Time: 120
 50000  Time: 155
Failed 12

It's even able to allocate less number of chunks :)

Bad thing is - noone has explained 64K limit yet...


-- 
Best regards,
 Peter                            mailto:pz@spylog.ru

