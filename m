Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbVKJEfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbVKJEfU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 23:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbVKJEfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 23:35:20 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:62461 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751194AbVKJEfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 23:35:18 -0500
Subject: Re: Update on Timer Frequencies
From: Steven Rostedt <rostedt@goodmis.org>
To: AndyLiebman@aol.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1131422329.14381.157.camel@localhost.localdomain>
References: <206.db80c15.30a174f6@aol.com>
	 <1131422329.14381.157.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 09 Nov 2005 23:35:13 -0500
Message-Id: <1131597313.14381.234.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-07 at 22:58 -0500, Steven Rostedt wrote:
> On Mon, 2005-11-07 at 22:26 -0500, AndyLiebman@aol.com wrote:
> >
> 
> >  
> > Still, the results are interesting. That plus the fact that our "user  
> > management applications" open and run excruciatingly slowly when the timer  
> > frequency is 100 versus 1000 (3 x longer to open the application) is making us  stick 
> > with a timer frequency of 1000 for now. 
> 
> Are there other services running when you open these applications?  If
> not, then this would not make sense.  But if other services where not
> active when these applications are being opened, I'd be surprised at
> these numbers.
> 
> The time slice algorithm in the scheduler is pretty complex. Not the
> implementation, but the assigning of time slices and the dynamic nature
> of them.  I wonder if a lower HZ would cause more schedules?  I'll have
> to test this out tomorrow and see what I get in scheduling frequencies
> between the two.

Hi Andy,

I did a few tests and couldn't see 100HZ being slower than 1000HZ for
server type work*.  I ran the following script, which kicks off 10
processes doing 'find /' so it should hit the hard drive a bit.  Grant
it, each process will probably read off another's buffer cache.  But if
you have a better test to try on a not so big machine. Feel free to pass
it on :-)

(*) well maybe not really server type work!

testme:
#!/bin/sh

date
echo 1 > /proc/logdev/switch
for i in `seq 1 10`; do
  find / &> /dev/null &
done
wait `jobs -p`
echo 0 > /proc/logdev/switch
date


I ran this on 2.6.14 with my logdev patch (that is like relayfs, but I
wrote this before relayfs was available so I still use it ;-) and it
does nice recording of context switches.

http://www.kihontech.com/logdev/patch-2.6.14-logdev1.patch

The /proc/logdev/switch turns on recording of context switches. 

I ran this test once on the following machine:

# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 368.002
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 737.16

The test was run like:

# time testme

At 100HZ I got:

----
Wed Nov  9 11:30:24 EST 2005
Wed Nov  9 11:37:55 EST 2005

real    7m31.789s
user    0m45.320s
sys     4m36.930s
----

At 1000HZ I got:

----
Wed Nov  9 11:54:05 EST 2005
Wed Nov  9 12:01:54 EST 2005

real    7m49.644s
user    0m46.430s
sys     4m41.145s
----

Running my logdev tools from:
http://www.kihontech.com/logdev/logdev_tools_0.3.0.tar.bz2

./logread /dev/logdev > 1000HZ.out  # with 1000HZ
./logread /dev/logdev > 100HZ.out # with 100HZ

These files can be found at:
http://www.kihontech.com/tests/hz_times/

These show all the times that a context switch took place. This is a
ring buffer, so it only captured the last 30 some seconds of the test.
But that should be good enough.

with my analyze.pl script (also supplied at the website) I ran:

./analyze.pl 1000HZ.out > 1000HZ.txt
and again for 100HZ.

This calculates the times between the context switches and at the end
produces an average.

(all times are in seconds)

For 100HZ:

[54543.530810] CPU:0 (testme:2539) -->> (find:2550)
  diff: 0.000213
[54543.546730] CPU:0 (find:2550) -->> (testme:2539)
  diff: 0.015920
count: 28974  total: 38.384180
average: 0.001325


For 1000HZ:

[  629.034303] CPU:0 (testme:2090) -->> (find:2097)
  diff: 0.000126
[  629.035776] CPU:0 (find:2097) -->> (testme:2090)
  diff: 0.001473
count: 28887  total: 35.322831
average: 0.001223


Conclusion:

It works as I would expect it to.  The 1000HZ actually doesn't let
processes run for as long as the 100HZ does, and 100HZ seems to be
faster (for just the test).

Oh I did have preemption on.  I guess I should turn it off and run it
again.  Tomorrow I'll give that a try and I'll only report back if I
find something interesting.

The config of the 100HZ is also on the site and the only change between
the two runs was changing 1000HZ to 100HZ.

Do what you want with this info. ;-)

-- Steve




