Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267587AbUH2K30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267587AbUH2K30 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 06:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267605AbUH2K30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 06:29:26 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:3598 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S267587AbUH2K3R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 06:29:17 -0400
Date: Sun, 29 Aug 2004 12:29:17 +0200 (CEST)
From: Robert Milkowski <milek@rudy.mif.pg.gda.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Tomasz =?iso-8859-2?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       Julien Oster <usenet-20040502@usenet.frodoid.org>,
       Miles Lane <miles.lane@comcast.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: DTrace-like analysis possible with future Linux kernels?
In-Reply-To: <1093354658.2810.31.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.60L.0408291127530.15457@rudy.mif.pg.gda.pl>
References: <200408191822.48297.miles.lane@comcast.net> 
 <87hdqyogp4.fsf@killer.ninja.frodoid.org>  <Pine.LNX.4.60L.0408210520380.3003@rudy.mif.pg.gda.pl>
  <1093174557.24319.55.camel@localhost.localdomain> 
 <Pine.LNX.4.60L.0408232107270.13955@rudy.mif.pg.gda.pl>
 <1093354658.2810.31.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Aug 2004, Alan Cox wrote:

> On Llu, 2004-08-23 at 20:48, Robert Milkowski wrote:
>> Solaris runs on x86 platform, and runs quite well.
>> And guess what - DTrace runs on x86 like a charm.
>
> Larger x86 boxes. I can't seem to find PDA's with Solaris or phones
> with Solaris or $70 wireless routers with Solaris.

Yeah, I can agree with you that tools like DTrace aren't very usefull on 
PDA or on phone. :)

>> I must admit I don't know OProfile.
>> But can you profile already running application without interuption
>
> Yes
>
>> What about getting structure contents, function arguments and returns,
>> etc... all on the fly.
>
> ptrace. Actually there are folks who want to take ptrace a bit further
> for some things - at least one vendor posted some proposals which when
> recast into ptrace extensions look good.
>
>> I think you missed the point.
>
> Nope
>
>> Sure, you can make your own module on Linux, load it and trace whatever
>> you want. But:
>
> Why do that, why not use the existing functionality that the kernel
> provides built on the stuff Intel AMD and friends stuck in the CPU. I'm
> not claiming our debugging tools are as good as dtrace but most of it
> (especially with kprobes patches installed) is essentially a UI design
> issue.

ok, so maybe real example.

Let's say you want aggregate by user stack if given thread number of 
specified process is taken off cpu by scheduler and is in SLEEP state and 
is off cpu for more then one second. You want output evey 10s. With DTrace 
it's relly simple. Ususally if I want quick answer I'm gonna write like 
this:

bash-2.05b# dtrace -n sched:::off-cpu'/curlwpsinfo->pr_state == SSLEEP &&
                       pid == 18819 && tid == 3/{self->t1 = timestamp;}'
                    -n sched:::on-cpu'/self->t1 && (timestamp - self->t1)
                       > 1000000000/{@[ustack()]=count();self->t1=0;}'
                    -n tick-10s'{printa(@);}'

But this is not so readable so let put it in a more readable form (script)

#!/usr/sbin/dtace -s

sched:::off-cpu
/curlwpsinfo->pr_state == SSLEEP &&  pid == 18819 && tid == 3/
{
   {self->t1 = timestamp;
}

sched:::on-cpu
/self->t1 && (timestamp - self->t1) > 1000000000/
{
   @[ustack()]=count();
   self->t1 = 0;
}

tick-10s
{
   printa(@);
}


Here is what you get:

  25  34812                        :tick-10s

               libc.so.1`__pollsys+0x4
               libc.so.1`poll+0x88
               wpserver`wpio_loop_pool+0x9c
               libc.so.1`_lwp_start
                26


Which means you get 26 times the same stack.



Or maybe another example which shows how one can easly learn something 
about apps behaviour and about system.

Let's say you see a lot of fspgin's in vmstat and want to know which 
applications are cousing it. And to complicate things you have some 
applications running from inted like daemon (so fork() + exec() every 
request) and of course you want aggregate as a whole for such application.

So, with DTrace:

bash-2.05b# dtrace -n vminfo:::fspgin'{@[execname]=sum(arg0);}'
dtrace: description 'vminfo:::fspgin' matched 1 probe
^C

   Application-A                                                   282
   Application-B                                                   304
   Application-C                                                   335
   zsched                                                         1200
bash-2.05b#

Well, now yo can go further and see Application-C in more detail.
But instead let's say you don't know why zsched is cousing fspgins.
So lets' learn why.

bash-2.05b# dtrace -n vminfo:::fspgin'/execname == "zsched"/{@[stack()]=count();}'
dtrace: description 'vminfo:::fspgin' matched 1 probe
^C


               genunix`pageio_setup+0x1f8
               nfs`nfs3_readahead+0xc0
               nfs`nfs_async_start+0x2c8
               unix`thread_start+0x4
               405
bash-2.05b#


Well, it's doing nfs3 read aheads.
You can disable read aheads for nfs3 and see if it disappears - and it 
does. And all in a production without stopping anything.

Simple, easy and safe.

Now how much work and knowledge would it be needed to get the same results 
with KProbes, oprofile, ... and how much time will it take?

And how easy would it be with KProbes to panick kernel?
All examples above I've just did on a production server.

DTrace lets you correlate data from kernel level and application level 
which is really usuefull. It gives sys admins the power to answer to see
what is really happening in system and why.

And these are simple cases which do not show all DTrace features.
Real fun starts with more complicated examples :)

Of course you can do SOME things with DProbes or Oprofile that you 
could with DTrace but usually it 
will take MUCH more time with them then with DTrace. And there are things 
you can do 
with DTrace which you can't with DProbes and others in a reasonable time 
period.

btw: about UI - it's really important. DTrace agreagations for example
      save a lot of time in analyzing data. Especially when usually you
      get huge amount of data to analyze from a production systems. With
     'D' language you get most of data aggregation done during
     collectioning data. I know there's Perl, Awk, etc. but it takes time.

btw2: you mention ptrace, AFAIK it would have more performance impact then
       DTrace/KProbes technologies. Second, I'm not sure if it's still the
       case, but there were (are?) some problems using ptrace on threaded
       applications. And still all you see is application level - no
       correlation between kernel and app (for example you want to see
       if given code path in application is cousing fspgins or xcalls or
       something else...)

btw3: and Oprofile, Kprobes, ptrace are separate tools and you have
       then corelate data which will often be not possible.


-- 
 						Robert Milkowski
 						milek@rudy.mif.pg.gda.pl

