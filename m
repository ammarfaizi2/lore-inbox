Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261309AbREYRzq>; Fri, 25 May 2001 13:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261316AbREYRz1>; Fri, 25 May 2001 13:55:27 -0400
Received: from ip167-113.fli-ykh.psinet.ne.jp ([210.129.167.113]:34501 "EHLO
	standard.erephon") by vger.kernel.org with ESMTP id <S261309AbREYRzS>;
	Fri, 25 May 2001 13:55:18 -0400
Message-ID: <3B0E9C80.14617333@yk.rim.or.jp>
Date: Sat, 26 May 2001 02:55:13 +0900
From: Ishikawa <ishikawa@yk.rim.or.jp>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: OOM process killer: strange X11 server crash...
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Question:
Is there still an issue of OOM process killer to
pickup undesirable process, and/or
that the amount of free system be properly updated
after one such victim process is killed
and a new and/or pending memory request comes in from a different
process
BEFORE the second victim process is picked up and killed?

I am using stock 2.4.4 kernel.

Background:

For the last several weeks,
I reported strange X11 server crash and thought it might have
something to do with the X11 server and/or linux kernel VM management.

I thought linux VM might have something to do because
it was hard to believe that X11 server still had a bug
in bitblt code when I use 16 bit pixel value.
(And I could see no problem in the reported code location after
I looked at the register dump recorded by X server wrapper
and fully debugger-enabled code under gdb, as well as the
output of memory-related system call traces.
[Well, I am not an expert of mmap/munmap and so
the last judgement of mine may not be quite reliable.]

Anyway, in order to figure out exactly what is going on, I re-compiled
the X11 server with debug symbol as I mentioned
(after downloading all the X86free source code) and
I see the same X11 server crash if I follow a certain steps
using netscape 4.77. (It has something to do with a visiting a page
and do a search on the same string and find the successive occurrence.)

Alan suggested that there still may be a genuin X11 bug still,
so I began using free memory bug checkers to see if I could
find the real cause. (Too bad, I can't shell out money for Purify.)

Problem with these memory checkers is the much overhead
of memory allocation. Hesenberg effect kicked in.
Now I see crashes at different spots.
I tried three tools before I found the possibly NEW problem with
OOM process killer: I tried electric fence, memprof, and debauch in
these sequence .

With electric fennce, the X11 server even refused to start completely.
Considering that electric fence uses up a memory page for one single
allocation atempt no matter how small, this is understanble.
I have 256MB of memory and 80MB swap.
   (This has given me enough clue to the problem I was facing, but
    I falied to notice it the first time it happened, and continued
testing
    with other tools.)

So I gave up on electric fence although if I did have memory allocation
problem with X11 server, it was my best bet.

With memprof, it was not clear if the profiling function could detect
problems that I was facing. Lucily, I could reproduce the crash, but
could not find much useful information. (Given the original
purpose of memprof, this again is reasonable. It was meant to
detect memory leaks. For this, it worked great!
I was rather surprised to find a lot of left over memory allocation
chunks.
Great tool if you are worried about these sort of problems.).

   http://people.redhat.com/otaylor/memprof/

So I finally tested X11 server with debauch next and hit upon a possible

issue with OOM:

    http://quorum.tamu.edu/jon/gnu/

Now with debauch, I could run netscape, and
during the operation sequence which
would have caused the X11 server to crash in my original
setting, the netscape
and X11 seemed to get hung.: it seems to be allocating much
memory and mouse won't be responding any time soon.
(I heard occasional disk access which is caused by
the writing of debauch message to the xdm.log file.)
But, I could switch to virtual console one to look at ps output.
So after a while,  I gave up and I tried to kill xdm when I noticed
interesting console messages (part of which was lost
since it scrolled way too fast and disappeared)
I have no idea why I have not seen this before.
But, it seems that over-the-memory condition occurred due to
the added overhead of debauch PLUS the original
condition caused by the particular operation of netscape.
(Yes, I suspected some virtual memory-related problem, but
my original question was why netscape was not crashing,
and X11 server?
It may be that OOM process killer was picking up X11 server
as well as netscape and I had no way of knowing, ...
Oh well, this is NOT probalby what happened in my
original problem cases because I didn't see
OOM process killer messages when X11 servers crashed in the
original steps. More testing and investigaton necessary.)

Anyway, this time, here is what was printed on the screen (the tail end
of it).
--- begin quote ---
    ... could not record the above. they scrolled up and disapper...
Out of Memory: Killed process 4550 (XF8_SVGA.ati12).
__alloc_pages: 0-order allocation failed.
VM: killing process XF86_SVGA.ati12
--- end quote

And before the message disappeared, I think I saw the
netscape process was killed, too.
I checked the log message and looked for "Memory"
Sure enough I foundnetscapewas killed, too, in this case.

May 25 09:16:46 duron kernel: Memory: 255280k/262080k available (978k
kernel cod
e, 6412k reserved, 378k data, 224k init, 0k highmem)
    ...
May 25 10:45:31 duron kernel: Out of Memory: Killed process 5562
(netscape).
May 25 10:45:31 duron kernel: Out of Memory: Killed process 5450
(XF86_SVGA.ati1
2).
     ...


This is a stock kerne 2.4.4 .
ishikawa@duron$ uname -a
Linux duron 2.4.4 #20 Tue May 1 13:45:38 JST 2001 i686 unknown
ishikawa@duron$

My question again: Can OOM process killer be taught NOT to kill X11
server
(and kill its client first) ?
Well, having X11 run continously is a preferable situation for many
users.

Also, I am a little surprised that AFTER netscape which, in my test
cases,
eats up about 120MB memory or more, is killed,
the system still figured it needed to kill X11 server, too.
Killing netscape would have freed 120MB or more
(and my system is 256MB + 80MB swap), and I feel that probably
the system as a whole can run problem-free after the
netscape freed all its memory. (Probably. Indeed
X11 may be in a very tangled position due to debauch...)
This is why I ask if the meory freed by the process killed first is
properly calculated or restored in such a manner so that
it can be dispensed to future and/or pending memory request
BEFORE the second process is picked up for killing.

I know that VM code is undergoing rapid change, and so
this may be a moot question when 2.4.5 comes out.

PS: any tips regarding the oriignal problem, i.e.,
X11 server crashing due to mysterious seg fault
will be appreciated. Also, any other memory checker
with less memory overhead will be welcome.
I tried
    elecric fence
    memprof
    debauch
but, as I mentioned, my best hope, namely electric fence,
had too much overhead and X11 server failed to start
with 256MB and 80MB swap.

I have a grave doubht if my 80MB swap works, and ran a VERY
simple test, and swap seemed to work.
(Is it possible that swap code has a strange bug in that
the pages allocated into swap, if access NOT near  the start,
NOR near the end of the alloced range, may show
unmapped page error or something?
I am running out of ideas why X11 server crashes.)



