Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbTFWHun (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 03:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264759AbTFWHum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 03:50:42 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:10510 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264479AbTFWHuQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 03:50:16 -0400
Message-ID: <3EF6B5D4.10501@aitel.hist.no>
Date: Mon, 23 Jun 2003 10:09:56 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: O(1) scheduler & interactivity improvements
References: <1056298069.601.18.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana wrote:
> Hi all,
> 
> I must say I'm a little bit disappointed with the interactive feeling of
> latest kernels. From what I have read, it seems the scheduler decides on
> the "interactive" behavior of a process based on its CPU usage and
> sleeping times. I am no kernel expert, so I will assume this is how it
> works, more or less, behind the scenes.
> 
> I think that marking a process as "interactive" based on the previous
> premise is quite unreal. Let's take, for example, a real application
> like a word processor which performs background spell checking. The word
> processor should be considered interactive, even when it may be hogging
> the CPU a lot to perform the background spell check and the rest of its
> threads are sleeping waiting for user input.
> 
I thought this worked perfectly, like this:

The background spellchecking thread hogs the cpu and is
quite correct marked non-interactive.

The other thread that mostly sleeps waiting for keystrokes
is marked interactive because of all that sleeping.

So the spellchecker might stall now ant then, and the interactive
thread gets priority when it occationally have work to do.

Don't get confused by the fact that this word processor of
yours is two (or more) threads, with separate priorities.
The kernel don't prioritize tasks like "word processor" or
"mail daemon", it deals with separate threads.

> As someone said before in the list, a process should be marked
> "interactive" based on the fact that it's receiving user input, 

This is almost impossible to get right, except for a few very special
cases like a single user working at the console.  Unix is supposed to
do much better than that - the user logging in via a serial port,
(or more commonly these days, via the network) should get exactly
the same responsiveness as that console user.

Further, we may (sometimes) know that some devices is connected
to a human.  But how about that script reading one disk file
and writing to another?  Is it some cron job, did it start
from some GUI menu with a user eagerly waiting for it to finish?
Or did the user switch to the workd processor because he
knows the script will take "forever"?


> for example, key strokes, mouse movements or any events received from any
> input device, not based on its CPU usage. I think applications like XMMS
> or mplayer shouldn't be considered interactive (at least, not until they
> start interacting with user), 
The're interactive if the user is staring at / listening to the output.

> and they have a constant usage of CPU.
> However, interactive applications have peaks, requiring shots of CPU for
> very short times. However, that's not necessarily true, as I said before
> with the example of the word processor: it could well be wasting 100% of
> CPU to perform spellchecking but it should still be considered an
> interactive application: a single user keystroke should take preference
> over the background spellchecking.

Use a multithreaded word processor and you'll get exactly this behaviour,
with the current system.  See above.

> 
> For terminal based, interactive applications (like pine, vi, and
> company), which are connected to tty devices, a user input event could
> make the scheduler boost the process priority for a brief time (and
> then, reduce the priority in a nearly quadratic fashion until reaching
> it's original, or a lower, priority) to give it a better response time
> and increase the interactive feeling.
> 
This works already, because the app slept waiting for that keystroke.


> However, for X11 based applications it seems a lot more difficult since
> all user-based input events are received by the X server itself (and not
> the process for which the event is intended). Based on the previous
> thoughts, the X11 server would be marked interactive, but not the
> application (like the word processor). This is not the desired effect.
> 
This usually works fine:  The part of X handling keystrokes
sleep - and get interactivity bonus when you press keys.

The apps waiting for X io sleeps, and get interactivity bonus
when they get something to do.  The sleep-based interactivity
estimate works here.

> So the question is, how can we detect the ultimate process for which the
> user input event is intended? Should the X11 server help the scheduler

That is _hard_, perhaps so hard that it isn't worth it.  Making it work
with X means a change to the X protocol (because the user might
wery well sit at some other pc/xterminal).  Unfortunately, the
other end might run something else than linux.


> by increasing the target process priority (it normally runs as root)?
> Should the window manager increase the priority of the process which
> owns the current foreground, active window? Solaris seems to work this

It can't without that X protocol change, for the "foreground process",
the "window manager" and the "X server" may all be running on three
different machines.

I do this all the time at home:
I sit at a pc that is configured as a X terminal.  It runs the X server
only.  My window manager and ordinary shells runs at another machine
with much better cpus.  (Why?  Because my girlfriend use the big machine
for reading mail and playing games) Then I log into my office pc
and runs some X apps from there.  Will your scheme work with
this - and work right?

If you only solves for the common case of one
user running all apps on the same machine, then my x-terminal
apps will wait too much for my girfriends games.  Even if
the office pc has plenty of free cpu time, because the big
machine won't give ssh priority enough to transfer the X output
to my xterminal.

This case works well today.

> way: when the user changes the focus to a new window, the window owner
> is brought into the interactive scheduling class. When the user chooses
> a new window, the window which loses the focus forces its owner to
> return to the time-shared scheduling class.
> 
> What do you think about all of this? Should we use behavior-based
> against CPU-usage behavior to decide process interactivity?
> 
I don't think you can make it work in all the cases where
today's system works well.  If you overload the machine something
has to wait - it is that simple.  Letting those that wait more than
they have to (i.e. io waiting) get extra priority seems to work
quite well.

Helge Hafting

