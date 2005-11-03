Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030548AbVKCXw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030548AbVKCXw2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 18:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030549AbVKCXw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 18:52:28 -0500
Received: from imo-d21.mx.aol.com ([205.188.144.207]:18892 "EHLO
	imo-d21.mx.aol.com") by vger.kernel.org with ESMTP id S1030550AbVKCXw1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 18:52:27 -0500
From: AndyLiebman@aol.com
Message-ID: <208.d6307e5.309bfcb2@aol.com>
Date: Thu, 3 Nov 2005 18:52:18 EST
Subject: Re: Premptible Kernels and Timer Frequencies
To: rostedt@goodmis.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: 9.0 Security Edition for Windows sub 2340
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Steve, 

I'm going to add my message  at the top of this post, because it's not a 
direct response to your post.  

Thanks for the good start at explaining some of the new kernel compiling  
options. I really appreciate the time and effort you made at explaining some of  
these new choices. And I took your suggestion and tried out the 2.6.14-rt1  
kernel with total success (at least getting it to run). 

However,  ultimately you don't really answer my fundamental question about 
what options  are best for what kind of application. Maybe someone like Linus or 
Andrew Morton  could chime in here. Put a little write up on the kernel.org 
site??? 

You  guys must have a good idea about WHY one would choose a timer frequenzy 
of 100  versus 1000 -- YOU put these options in the kernel. Please give us 
some examples  about where the different sets of options are appropriate -- what 
options should  be used together and which one could contradict each other. 

To recap MY  particular case, I have a file server that is sending out -- and 
taking in --  video and audio files from 5 to 30 workstations. The data rates 
typically range  form 3.8 MB/sec per workstation up to 60 MB/sec per 
workstation. All of the  transactions are handled by TCP/IP. In some cases, we are 
using a Chelsio 10  Gigabit Ethernet card with TCP/IP offload. But generally, we 
have a bunch of  Intel Pro 1000 MT server adapters feeding one or more 
workstations each. Or we  are bonding a group of NICS and sending all the data to a 
managed switch.  

So, we have:

a lot of TCP/IP transactions
NIC drivers  running
3ware Hardware RAID -5 drivers running
Sometimes Linux Software  RAID -0 striping two 3ware cards together
Samba
Netatalk
Occasional use  of a Twisted Web Server
Occasional use of TightVNC
A mostly inactive KDE  session
A UPS program

That's pretty much what's running. Only rarely  do any applications "run" on 
the server (once in a while, an administrator will  do something to "manage" 
the system -- but that's maybe 1 or 2 minutes out of  every 24 hours. We are 
running on both 32-bit and 64-bit systems. 

So, my  question was, what kernel compiling options are appropriate for the 
best  performance?  (for ME, best performance = lowest latency in delivering  
random data to -- and taking data from -- a group of video editing 
workstations,  AND best throughput -- goals which may be mutually exclusive). For MY  
application, how should I set: 

Preemptible Kernel  Model
No Preemption
Voluntary  Preemption
Premptible Kernel

Prempt The Big Kernel  Lock (Y/N)

Timer Frequency
100  hz
250 hz
1000 hz

While my  case might be different from sombody else's case, I'm sure it would 
be useful to  give three or four examples of different server uses that at 
least "in theory"  would benefit from a particular group of settings. I'm not 
sure that "desktop"  versus "server" is the most helpful distinction. Are ALL 
servers (including  mine) best off with: 
No premption
Saying No to Preempt The Big Kernel Lock
Timer Frequence  of 100hz

Somehow, I doubt it. 

Yeah, I'm ready to experiment. I've  been doing that with Linux for three 
years and getting great results. But I'd  love to hear the theory of what SHOULD 
be best. It's about seeing the forest  through the trees, getting the "big 
picture" after looking at all the minute  details. 

Thanks in advance for more information... Linux rocks!  

Andy  Liebman

-------------------------------------------------------


In  a message dated 10/28/2005 7:06:50 P.M. Eastern Standard Time,  
rostedt@goodmis.org writes:
On Fri, 2005-10-28 at 12:36 -0400,  AndyLiebman@aol.com wrote:
> Thanks to all responsible for getting the  2.6.14  kernel out quickly. 
There 
> are many important bugfixes and  features in this  kernel that are relevant 
to 
> my work. I look  forward to using it starting today!  
> 
> I have a request.  Would it be possible for a knowledgeable person to  
write 
> up a  little description of some of the following kernel options and what  
they  
> REALLY mean and how to use them? I think it would be great to put a  brief  
> "white paper" on the kernel.org site. 

I'll respond  a little here, but this is far from being a white paper.
Although, if I have  time, I'll write one.  My involvement with Linux
today is mostly with  Ingo's RT patch that really brings down the
latencies of the  kernel.

> 
> In specific, I am referring to the  following:  
> 
> Premptible Kernel Model
> No   Premption

Simple.  If a process is in the kernel (via a system call)  it will not
be preempted by another process.  There are points in the  kernel where a
process will need to wait for an event (like memory swapping  in) and
will call schedule to let other processes run, instead of a busy  loop.

The problem with this is that when an interrupt comes in and wakes  up a
higher priority process. That high priority process needs to wait  till
the lower priority process either explicitly calls schedule or  returns
to user land.

> Voluntary Premption

There are  several points in the kernel that "might schedule".  Like
allocating  more memory, the kernel may need to swap out memory to get
more available  memory, so this may or may not schedule.

With Voluntary Preemption, these  points always check to see if it should
schedule because another higher  process is waiting to run.  So
basically, if a higher priority process  wants to run on a CPU that is
currently running a lower priority process that  happens to be in the
kernel. The "need_resched" flag is set on the lower  priority process and
when one of these "voluntary preemption" points are hit,  it will call
schedule.  The high priority process still needs to wait  till one of
these points are hit, or the process actually calls schedule, or  it goes
back to user space.

> Premptible Kernel (Low-latency  Desktop)

This is currently the lowest latency selection in the vanilla  kernel.
When this is turned on, a high priority process that is woken up,  will
preempt the currently running lower priority process even if it is  in
the kernel.

The trick here, is that there are SMP protected areas  in the kernel
protected by spin_locks.  These usually are only for  multiprocessor
machines, but when you have a fully preemptible kernel, these  areas must
also be protected.  So, on a uni-processor machine without  "Preempt
Kernel", these spin_locks are optimized out (no-ops).  But with  "Preempt
Kernel", these areas prevent preemption from occurring. So now the  high
priority process can preempt the lower priority process anytime it  is
not in one of theses areas protected by a spin_lock.  If the  lower
priority process is in one of these areas, the higher priority  process
only needs to wait for that process to leave this area, which is  usually
a very short time, since on SMP this would cause a CPU to spin in a  busy
loop, and Linux tries to make these areas small.

This explanation  is a little simple but gets the gist of what is
happening.

As for  which one is best for you.  It matters what type of latencies  you
want.  That is, do you want better reaction times for higher  priority
processes.  Without the user caring about priorities, this  usually means
the most interactive tasks, where servers that serve web pages  and such
probably don't care about one process over the other. But a gamer  might
be more interested in his game having higher priority than  some
background job, and having a lower latency in shooting the  monster.

> 
> Prempt The Big Kernel  Lock

The Big  Kernel Lock is an old relic that I wish would go away.   Before
spin_locks, everything was protected with this behemoth.  One  lock to
rule them all!  So basically, any time you needed to protect  some data,
you would grab this lock.  So on SMP machines, CPUs were  waiting around
a lot to handle some data because some other CPU was working  on some
totally separate data.  This obviously was very  inefficient.  Well,
fortunately, the kernel developers implemented a  fine grain locking
(spin_locks) and got rid of most of the Big Kernel  Lock.  But
unfortunately, it is still used in some pretty scary parts of  the
kernel.  Scary, because it will be difficult to remove this lock for  in
favor of smaller variants.

This lock is different than the  spin_locks by the fact that you can call
schedule holding this lock.   Schedule will simply let go of this lock
for the scheduling process.   When the process is scheduled again, it
will try to retake the lock.   Also, a process may grab this lock as many
times as it wants while holding  it, as long as it releases it the same
amount of times.

To preempt  while this lock is held, takes some special care, since you
don't want to let  go of this lock when it is being preempted.  So work
is done to prevent  the scheduler from releasing this lock when it calls
schedule because of  preemption and not because of the process
voluntarily scheduling.  Also  care is taken when retaking the lock when
woken up in the scheduler since the  process might not get it because a
process it just preempted has  it.

So this is more complex, and the developers decided to let people  turn
it off if they are nervous about the complexity on critical  servers.

> 
> Timer Frequency
> 100 Hz
> 250  Hz
> 1000 Hz

Again, this has to do with response times and  latencies.  Processes are
given time slices that they can run in. These  are broken up into
"jiffies".  A jiffy is defined in the kernel as 1/HZ  second.  So at
100Hz, a jiffy is 10ms, 250Hz 4ms and 1000Hz  1ms.

Also the resolution of sleeps and timers are done at the jiffy  level
(with current vanilla Linux).  So at 100Hz a timer set to go off  in
100ms is most likely to go off in 110ms where as with the 1000Hz it  has
a better probability of going off in 101ms.  Note, this is not a  good
example, because latencies usually cause timers and such to not  be
predictable in how close to the actual time it goes off.  It only  needs
to guarantee that it doesn't go off early.

Also note, the better  the latency, the higher the over head.  This is
pretty much true in all  cases.  For HZ = 1000, the timer interrupt needs
to go off 1000 times a  second, which will cause 900 more interrupts to
go off in that second than  for HZ = 100.

> 
> 
> I think it would be helpful  for  the whole Linux community to get better 
> hints about the  theoretical optimal  settings for various types of 
systems. Saying 
>  that one option is good for  "desktops" and another is good for "servers"  
is 
> a start, but I'm sure that with  just a few more words, you  could be much 
more 
> helpful to users who are trying to  decide what  options to select for 
> compiling. 

I'm not a server maintainer or  much of a gamer, so someone else can
explain what is best for them.  I'm  more of the embedded or special
purpose tool guy.  But I do understand  what these things actually mean.

> 
> For instance, I have  a  number of file servers that send video files out 
> simultaneously  to multiple  video editing systems. Each of 10-20 video 
editing 
>  systems could be reading  files from the server (or writing files to the  
server) 
> at data rates ranging  from 3.5 MB/sec up to 30,40 or 50  MB/sec. 
> 
> The server ITSELF is rarely  running any  applications other than Samba, 
> Netatalk, Software RAID 0, NIC   drivers, and fairly low-CPU usage things 
like the 
> UPS monitor, 3ware  Drivers for  Hardware RAID 5, and KDE (which is hardly 
ever 
>  getting any input from users).  
> 
> We get really great  performance with the 2.6.12 and 2.6.10 kernels. And  
> typically,  CPU usage ranges from 10-20 perecent with many client systems 
going.   
> However, we are wondering if it is worth it to try the Preemptible  Kernels 
for  
> greater responsiveness and perhaps support for more  simultaneous streams, 
> which  MUST arrive at the video editing  system on time or we get "dropped 
> frames".  

Have you taken  a look at Ingo Molnar's  PREEMPT_RT?

http://people.redhat.com/mingo/realtime-preempt/

This  has the best in low latency than any of the above options.  But I
must  also warn you that the lower the latency, the performance will
usually take a  slight hit as well. But we try to keep that at a minimum.

> 
>  I'm sure it's a similar situtation to Video On Demand servers only our   
data 
> rates are much higher per client, so we can't support that many  clients as 
 a 
> VOD system. 
> 
> We have tested  compiling the 2.6.12 kernel with both  voluntary preemption 
> and  low-latency preemption. Both seem to work fine, but we  haven't 
>  stress-tested them yet because we were waiting for the 2.6.14 kernel to   
come out. 
> 
> Could we get into any danger with the preemptible  kernels if  the system 
load 
> gets heavy? 

Preemptible  kernels are suppose to work _better_ on higher load.
Performance goes  slightly down, but predictability goes way up.

> 
> And now that  the Timer frequency option has  been added, what would be 
> optimal  for such a video server that is not itself  running any taxing  
applications? 

I'm not sure if that would effect it. If it is interrupt  driven, the
timer frequency is of no use. If the application is setting up  its own
frequency, then that would be a different story.

> 
>  Hope to hear from one of the "big guys"  on this. 

I'm not a "big  guy" ;-) but I'm pretty active with Ingo's RT patch.  I
just submit bug  fixes for the vanilla guys.

> 
> Thanks again for all your great  work. 

Hope this explains things a bit better.  I've been meaning to  write up
something about Ingo's patch to explain things in his kernel  options
just like this.  When I get some time, maybe I'll do that  too.

-- Steve  

