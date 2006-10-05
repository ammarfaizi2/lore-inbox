Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWJEFMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWJEFMV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 01:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWJEFMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 01:12:21 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:29895 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751120AbWJEFMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 01:12:20 -0400
Subject: [RFC] The New and Improved Logdev (now with kprobes!)
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Karim Yaghmour <karim@opersys.com>, Andrew Morton <akpm@osdl.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Chris Wright <chrisw@sous-sol.org>, fche@redhat.com,
       Tom Zanussi <zanussi@us.ibm.com>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 01:11:44 -0400
Message-Id: <1160025104.6504.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is my annual post to LKML advertising my beloved logdev
logger/tracer/debugger tool.  OK, it's not as fancy as LTT and
SystemTrap, but it's mine so I hold it dear to my heart :-)

This has been used mainly for debugging. Although it has tracing
abilities, there's much better tools out there for that.  What this has,
that the others don't is the output on a lockup or crash.  That's what I
mainly use this tool for.

I'm currently 5732 messages behind on LKML and I'm trying desperately to
catch up.  But yesterday I read a nice little friendly thread between
some of my dear colleagues about static vs dynamic trace points. (I'm
friends with those on both sides of that fence so I will keep my
opinions and comments far from that fire).

Anyway, it made me think.  Logdev is solely dependent on static trace
points.  I wanted to change that.  So looking into how kprobes works, I
added it to logdev.  So tglx can't say anymore that it's just another
trivial logger that anyone and everyone and their grandmother has
written up!

Well, as luck may have it, the cable to my Internet access had a loose
connection at the top of the telephone pole.  This loose connection
allowed water to seep in and it made it all the way down to the splice.
I still had cable TV, but it killed the reception to the cable modem. So
while I was waiting for Road Runner to appear and replace the cable I
did a hack fest on Logdev.

So now, when logdev is compiled into the kernel, and you have
CONFIG_KPROBES turned on, you will have the ability to log using the
logger dynamically from user space.

I currently have four methods, but the potential is so much more.

1. break point and a watch address

This simply allows you to set a break point at some address (or pass in
a function name if it exists in kallsyms).

example:

logprobe -f hrtimer_start  -v jiffies_64

produces (either on serial console on crash, or user utility):

  [ 7167.692815] cpu:0 emacs:4358 func: hrtimer_start (0xc0137aab) var: jiffies_64 (0xc0428400) = 001a3e1a
  [ 7167.760701] cpu:0 emacs:3960 func: hrtimer_start (0xc0137aab) var: jiffies_64 (0xc0428400) = 001a3e2b
  [ 7167.760700] cpu:1 emacs:4362 func: hrtimer_start (0xc0137aab) var: jiffies_64 (0xc0428400) = 001a3e2b
  [ 7167.791281] cpu:1 Xorg:3714 func: hrtimer_start (0xc0137aab) var: jiffies_64 (0xc0428400) = 001a3e33
  [ 7167.800631] cpu:0 emacs:4358 func: hrtimer_start (0xc0137aab) var: jiffies_64 (0xc0428400) = 001a3e35
  [ 7167.839553] cpu:0 Xorg:3714 func: hrtimer_start (0xc0137aab) var: jiffies_64 (0xc0428400) = 001a3e3f
  [ 7167.868523] cpu:1 emacs:4362 func: hrtimer_start (0xc0137aab) var: jiffies_64 (0xc0428400) = 001a3e46
  [ 7167.872506] cpu:1 emacs:3960 func: hrtimer_start (0xc0137aab) var: jiffies_64 (0xc0428400) = 001a3e47


2. break point and watch from current

This allows a user to see something on the current task_struct. You need
to know the offset exactly. In the below example, I know that 20 (dec)
is the offset in the task_struct to lock_depth.

example:

logprobe -f schedule -c 20 "lock_depth"

produces:

  [ 8757.854029] cpu:1 sawfish:3862 func: schedule (0xc02f8320) lock_depth index:20 = 0xffffffff


3. break point and watch fixed type

This is a catch all for me. I currently only implement preempt_count.


 logprobe -t pc -f _spin_lock

produces:

   [ 9442.215693] cpu:0 logread:6398 func: _spin_lock (0xc02fab9d)  preempt_count:0x0


4. function break, and parameters.


This one was a fun little hack!  It seems to work on x86 though (haven't
tried it on x86_64 or others yet).

Here we can see the function parameters using a printf type format.

example:

  logprobe -f try_to_wake_up "task=%p state=%x sync=%d"

produces:

  [ 7837.656037] cpu:0 Xorg:3714 func: try_to_wake_up (0xc01197d3) task=c19bdf30 state=c0318e49 sync=0


Logdev still uses my own custom made ring buffer, but I'm working with
Tom Zanussi to get it working with relayfs.  It sorta works, but is
currently in a "broken" state.  So don't select it, unless you don't
mind my code eating your Doritos!


Anyway, like I said, this is my annual push of Logdev (more of a tap
than a push), just to let other kernel hackers know what I have a
debugging aid, and if it can be of use to anyone else out there.  That
alone would make me happy (doesn't take much ;-)

All tools and everything is under GPLv2, and can currently be found at
http://rostedt.homelinux.com/logdev  when water isn't ruining my
connection.

Have fun!

-- Steve



