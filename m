Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263686AbRFGX3u>; Thu, 7 Jun 2001 19:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263693AbRFGX3k>; Thu, 7 Jun 2001 19:29:40 -0400
Received: from laxmls04.socal.rr.com ([24.30.163.18]:19344 "EHLO
	laxmls04.socal.rr.com") by vger.kernel.org with ESMTP
	id <S263686AbRFGX3f>; Thu, 7 Jun 2001 19:29:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Shane Nay <shane@minirl.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: VM Report was:Re: Break 2.4 VM in five easy steps
Date: Thu, 7 Jun 2001 16:29:17 -0700
X-Mailer: KMail [version 1.2]
Cc: "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>,
        Sean Hunter <sean@dev.sportingbet.com>,
        Xavier Bestel <xavier.bestel@free.fr>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.21.0106071722450.1156-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0106071722450.1156-100000@freak.distro.conectiva>
MIME-Version: 1.0
Message-Id: <0106071629171E.32519@compiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(VM report at Marcelo Tosatti's request.  He has mentioned that rather than 
complaining about the VM that people mention what there experiences were.  I 
have tried to do so in the way that he asked.)

> 1) Describe what you're running. (your workload)

A lot of daemons, all on a private network so there is no throughput load on 
them.  About 13 rxvt's, freeamp actively playing music at all times, xemacs 
with 25 active buffers, a few instances of vi, opera, no "desktop env", just 
windowmaker.  (Though I have a few KDE2 apps open, and one or two GTK based 
apps open, so lots of library code swapping in and out I imagine)  Now what 
I've noticed lately is this, with 2.4.2 my machine would lock quite 
frequently when I was compiling code and had other apps that were allocing 
memory.  With 2.4.5 I haven't had that behaviour, but I've been much lighter 
on my machine.  (I was doing full toolchain builds with 2.4.2 when I had the 
real problems)  But processes were still running when the machine would 
lock..., like the mp3 player was still playing I noticed one time.  With 
2.4.5 (not -ac) I haven't had any deadlocks, but the system seems very 
sluggish at acute moments .  While doing absolutely nothing processor 
intensive (I've been loading up top and ps'ing with regularity when this 
happens, looking for kswapd going crazy), when I switch between workspaces 
the refresh is much more sluggish on occasion, like I can watch windows 
appear.  Almost like a micro freeze really.
(AMD T-Bird 1.333Mhz 256MB-DDR)

> 2) Describe what you're feeling. (eg "interactivity is crap when I run
> this or that thing", etc)

Freeing memory takes *forever*, but I think that's a function of how I'm 
allocing in this polygon rendering routine I'm working on.  Like literally 
sucks up vast numbers of cycles and makes picogui totally unusable.  But I 
think this is unrelated to the kernel..., I think that's just because I 
haven't implemented re-use in memory structures for the polygon routine.  
(It's malloc/freeing massive numbers of small chunks of memory rather than 
doing it's own memory management, probably related to glibc memory 
organization)

Here's a vmstat line after a 8 days of uptime and before contrived mem tests:
   procs                      memory    swap          io     system         
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  
id
 1  0  0      0   3056   7856 121872   0   0     7     4   37    16   1   0  
40


> If we need more info than that I'll request in private.
>
> Also send this reports to the linux-mm list, so other VM hackers can also
> get those reports and we avoid traffic on lk.

> By performance you mean interactivity or throughput?

Interactivity.  I don't have any throughput needs to speak of.

I just ran a barage of tests on my machine, and the smallest it would ever 
make the cache was 16M, it would prefer to kill processes rather than make 
the cache smaller than that.

Contrived stressor program: (pseudo code)
fork(); fork(); fork(); fork();  //16 total processes
for (i=0;i<n;i++) {
  ptr=malloc(1M)
  while(++m<ptrsize) ptr[m]='b';
  sleep(2);
}
I would change n such that the total amount of memory was less than the 
amount of cache plus free memory.  Running this put the entire system into 
chaos in short order.  After it had killed off only one of the contrived 
memory hungry processes and at least two others (MP3 player and opera), the 
machine was slugish..., very slow to respond to any key input.  It stayed in 
this near freeze state for about 20 seconds, after that it started to speed 
up to user input gradually.  (Probably swapping code from disk into cache or 
something like that)  It took about 5-10 minutes to come back "up to speed".

> Just do what I described above.

Done :).

Thanks,
Shane Nay.
