Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132262AbRCWAeT>; Thu, 22 Mar 2001 19:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132229AbRCWAeF>; Thu, 22 Mar 2001 19:34:05 -0500
Received: from [195.63.194.11] ([195.63.194.11]:33285 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S132262AbRCWAd0>; Thu, 22 Mar 2001 19:33:26 -0500
Message-ID: <3C9BD87D.D9DECBB6@evision-ventures.com>
Date: Sat, 23 Mar 2002 02:21:01 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Stephen Clouse <stephenc@theiqgroup.com>,
        Guest section DW <dwguest@win.tue.nl>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <Pine.LNX.4.33.0103222052100.24040-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Sat, 23 Mar 2002, Martin Dalecki wrote:
> 
> > Uptime of a process is a much better mesaure for a killing
> > candidate then it's size.
> 
> You'll have fun with your root shell, then  ;)

You mean the remote one? 

> The current OOM code takes things like uptime, used cpu, size
> and a bunch of other things into account.
> 
> If it turns out that the code is not attaching a proper weight
> to some of these factors, you should be sending patches, not
> flames.

Did I say anything insulting? I have just stated what I think
is more important... BTW> it's not quite obvious that
You have to look into oom_kill to find it in the kernel
source where to look at. (Yes I did just find /usr/src/linux -name
"oom*"
becouse I happen to remember but!

OK i will just place - in front of the description lines where I think
that you where mislead:



 * Good in this context means that:
 * 1) we lose the minimum amount of work done
-* 2) we recover a large amount of memory
 * 3) we don't kill anything innocent of eating tons of memory
-* 4) we want to kill the minimum amount of processes (one)
 * 5) we try to kill the process the user expects us to kill, this
 *    algorithm has been meticulously tuned to meet the priniciple
 *    of least surprise ... (be careful when you change it)

The following is a wrong assumtion. You usually nice processes to
the background just to guarantee for example smoot interaction just
in case you won't login in in some time to the machine.

For example let's have an dedicated http server, which does a lot of
embedded perl.
It's quite clever to renice it back, just in case this
remote machine get's overloaded, becouse otherwise your chances
to get a login in case the machine starts to trash,
would be much worser. But this doesn't mean that the
process isn't more important - becouse you do it to make the
machine crowl through high load peaks and still let you in in
case you have something urgent to do on it.

        /*
         * Niced processes are most likely less important, so double
         * their badness points.
         */
        if (p->nice > 0)
                points *= 2;

BTW> Why the hell you don't just use a polynomial approximation for
int_sqrt - the range of values is very closed an you are
working in a finite ring anyway - you could very easly find
a simple approximation which wouldn't need any looping.

This should be reversted:

        points /= int_sqrt(cpu_time);
        points /= int_sqrt(int_sqrt(run_time));
    points = p->mm->total_vm;

        /*
         * CPU time is in seconds and run time is in minutes. There is
no
         * particular reason for this other than that it turned out to
work
         * very well in practice. This is not safe against jiffie wraps
         * but we don't care _that_ much...
         */
        cpu_time = (p->times.tms_utime + p->times.tms_stime) >>
(SHIFT_HZ + 3);
        run_time = (jiffies - p->start_time) >> (SHIFT_HZ + 10);

        points /= int_sqrt(cpu_time);
        points /= int_sqrt(int_sqrt(run_time));


==============================================================

NOW I SEE THE MOST IMPORTANT MISTAKE:

There should be a de-normalization of the units

CPU_time/total_uptime
RUN_time/total_uptime
mem/total_mem.

Otherwise you can't map the intended logics sufficiently safe
on to the calculation you do. You compare bits with seconds - which is
WRONG.

Let:
 m := memmory used by the process 
 M := the total memmory in the system.
 c := cpu time used by the process
 u := uptime of the process.
 U := uptime of the system

Then you calculate points
as 

(m / sqrt(c)) / sqrt(sqrt(r))

Which is just very wired function with a non homogen behaviour.
(Just take the first derivative of it in any dimension to see what I
mean)


You should calculate to represent you intended logics:

 x * (m / M) + y * (U / c) + z * (U / u),

where x y z are constants representing the wighting heuristic
importance one gives to those particular measure points.

A simple *normalized* polynom the only thing people and computers can
realy deal with.

> (the code is full of comments, so it should be easy enough to
> find your way around the code and tweak it until it does the
> right thing in a number of test cases)
> 
> regards,
> 
> Rik
> --
> Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml
> 
> Virtual memory is like a game you can't win;
> However, without VM there's truly nothing to lose...
> 
>                 http://www.surriel.com/
> http://www.conectiva.com/       http://distro.conectiva.com/

-- 
- phone: +49 214 8656 283
- job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort:
ru_RU.KOI8-R
