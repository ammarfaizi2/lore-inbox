Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTFBUlQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 16:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbTFBUlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 16:41:16 -0400
Received: from users.eiwaz.com ([216.243.209.216]:31715 "EHLO users.eiwaz.com")
	by vger.kernel.org with ESMTP id S262373AbTFBUlM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 16:41:12 -0400
Subject: Re: Strange load issues with 2.5.69/70 in both -mm and -bk trees.
From: Andreas Boman <aboman@nerdfest.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@digeo.com>, Tom Sightler <ttsig@tuxyturvy.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0306020927420.2970-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0306020927420.2970-100000@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1054587227.7683.92.camel@asgaard.midgaard.us>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 02 Jun 2003 16:53:48 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-02 at 03:36, Ingo Molnar wrote:
> On Sat, 31 May 2003, Andrew Morton wrote:
> 
> > >                               [...] Upon looking a little further it
> > >  seemed that the kernel was dynamically boosting the priority of the
> > >  process much higher than it probably should be, in the end, not leaving
> > >  enough CPU for playing the sounds without skipping.
> > 
> > Yes, it seems that too many real-world applications are accidentally
> > triggering this problem.

Not sure if what I'm seeing is the same thing, Without using wine, weird
mozilla plugins, or a userspace mixer/sound server (audigy with hardware
mixing).

During the first few seconds of playing a song in xmms sound will skip
if even just loading or refreshing a page in mozilla, though after the
song has been playing a few seconds it will stop skipping for the
duration of that song, until the next song in the playlist starts
playing. renicing -5 <pid of xmms>, or 5 <pid of mozilla> 'solves' the
issue. Ofcourse, if mozilla is the reniced process, xmms may still skip
when switching desktops, again that is much more likely to occur during
the first few seconds of playtime than later in the song. I cant recall
xmms ever skipping after it has been reniced to -5, even if I also have
a real cpu hog running (oggenc or similar).

Also, if nothing has been reniced and I swith desktops around like mad
for a while xmms will stop skipping even when switching to the next song
in the playlist, i suppose X/the wm/mozilla/etc has all been scheduled
off as cpu hogs by the exessive desktop switching..

I cant remember when this became really noticable, but it was probably
in the 2.5.68 timeframe. I am running 2.5.69-mm8+schedB0 at the moment
(software raid1 keeps me from going to 2.5.70-*)

a strace of mozilla shows that even when it is just sitting there
without a page loaded this stuff is just looping:

15:37:35.808520 ioctl(3, FIONREAD, [0]) = 0
15:37:35.808584 poll([{fd=3, events=POLLIN}, {fd=4, events=POLLIN,
revents=POLLIN}], 2, -1) = 1
15:37:36.308127 gettimeofday({1054582656, 308165}, NULL) = 0
15:37:36.308311 read(4, "\372", 1)      = 1
15:37:36.308396 write(3,
"F\4\5\0l\0\240\1\332\0\240\1\355\0)\0\1\0\20\0", 20) = 20

The below `vmstat 1` was started just before xmms -p. I then switched
desktops for a while until xmms stopped skipping.:

   procs                      memory      swap          io    
system      cpu
r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us
sy id
2  0  0  10416  47560  18728 230860    2    1    68     1   66    58  6 
2 11
0  0  0  10416  47424  18728 230860    0    0     0     0 1371  1185 12
11 77
0  0  0  10416  47424  18728 230860    0    0     0    33 1372   906  5 
6 89
1  0  0  10416  47352  18728 230860    0    0     0     0 1413  1984 21 
9 70
1  0  0  10416  47464  18728 230860    0    0     0     0 1927  1925 55
12 33
2  0  0  10416  47168  18728 230860    0    0     0     0 1185  1011 74
11 15
3  0  0  10416  44416  18728 230860    0    0     0     0 1182  1516 33 
6 61
1  0  0  10416  47348  18728 230860    0    0     0     0 1171  1041 80
16  4
3  0  0  10416  45044  18728 230860    0    0     0     0 1195  1327 44
13 44
3  0  0  10416  47348  18728 230860    0    0     0     0 1173  1049 54
10 36
2  0  0  10416  46712  18728 230860    0    0     0     0 1186  1206 65
11 24
2  0  0  10416  30264  18728 230860    0    0     0     0 1190  1152 46
10 44
1  0  0  10416  47212  18728 230860    0    0     0     0 1168  1058 75
10 15
2  0  0  10416  47212  18728 230860    0    0     0     0 1184  1463  3 
5 92
3  0  0  10416  36900  18728 231020    0    0     0     0 1183  1114 65
11 24
1  0  0  10416  47268  18728 230860    0    0     0     0 1176  1370 23 
5 72
2  0  0  10416  24360  18728 230860    0    0     0     0 1192  1467 30 
7 63
1  0  0  10416  47220  18728 230860    0    0     0     0 1189  1163 63
11 26
1  0  0  10416  47220  18728 230860    0    0     0     0 1184  1624  2 
5 93
4  0  0  10416  43828  18728 230860    0    0     0     0 1193  1202 31 
5 64
1  0  0  10416  47224  18728 230860    0    0     0     0 1173  1190 57
11 32
   procs                      memory      swap          io    
system      cpu
r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us
sy id
3  0  0  10416  47224  18728 230860    0    0     0     0 1184  1513  1 
1 98
3  0  0  10416  17620  18728 244360    0    0     0     0 1195   893 66
11 23
3  0  0  10416  37304  18728 230860    0    0     0     0 1194  1277 45
10 45
2  0  0  10416  47224  18728 230860    0    0     0     0 1189  1147 84
16  0
2  0  0  10416  42552  18728 230860    0    0     0     0 1194  1867 84
15  1
2  0  0  10416  47224  18728 230860    0    0     0     0 1485  2230 20 
5 75
1  0  0  10416  47232  18728 230860    0    0     0     0 1325  1629  1 
2 97
0  0  0  10416  47232  18728 230860    0    0     0     0 1373  1168 13 
8 79
1  0  0  10416  47232  18728 230860    0    0     0     0 1163   551  1 
2 97


> no, the problem is exactly the opposite. Here's the key observation:
> 
> > the problem seemed to be caused by the fact that the pluginserver (wine)  
> > was using 100% of the CPU. I simply reniced this process to -10 and
> > everything started working fine.
> 
> the kernel has detected this process to be a CPU-hog - and indeed the
> traces and the above description all say that it really is a CPU hog.

What I am seeing happens if the box has a load avg of 0.1 or 2.0, in a
pretty much identical fasion. 

	Andreas

