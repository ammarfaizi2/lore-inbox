Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264362AbTFVPxt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 11:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbTFVPxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 11:53:49 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:6925 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264362AbTFVPxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 11:53:47 -0400
Subject: O(1) scheduler & interactivity improvements
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1056298069.601.18.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 22 Jun 2003 18:07:50 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I must say I'm a little bit disappointed with the interactive feeling of
latest kernels. From what I have read, it seems the scheduler decides on
the "interactive" behavior of a process based on its CPU usage and
sleeping times. I am no kernel expert, so I will assume this is how it
works, more or less, behind the scenes.

I think that marking a process as "interactive" based on the previous
premise is quite unreal. Let's take, for example, a real application
like a word processor which performs background spell checking. The word
processor should be considered interactive, even when it may be hogging
the CPU a lot to perform the background spell check and the rest of its
threads are sleeping waiting for user input.

As someone said before in the list, a process should be marked
"interactive" based on the fact that it's receiving user input, for
example, key strokes, mouse movements or any events received from any
input device, not based on its CPU usage. I think applications like XMMS
or mplayer shouldn't be considered interactive (at least, not until they
start interacting with user), and they have a constant usage of CPU.
However, interactive applications have peaks, requiring shots of CPU for
very short times. However, that's not necessarily true, as I said before
with the example of the word processor: it could well be wasting 100% of
CPU to perform spellchecking but it should still be considered an
interactive application: a single user keystroke should take preference
over the background spellchecking.

For terminal based, interactive applications (like pine, vi, and
company), which are connected to tty devices, a user input event could
make the scheduler boost the process priority for a brief time (and
then, reduce the priority in a nearly quadratic fashion until reaching
it's original, or a lower, priority) to give it a better response time
and increase the interactive feeling.

However, for X11 based applications it seems a lot more difficult since
all user-based input events are received by the X server itself (and not
the process for which the event is intended). Based on the previous
thoughts, the X11 server would be marked interactive, but not the
application (like the word processor). This is not the desired effect.

So the question is, how can we detect the ultimate process for which the
user input event is intended? Should the X11 server help the scheduler
by increasing the target process priority (it normally runs as root)?
Should the window manager increase the priority of the process which
owns the current foreground, active window? Solaris seems to work this
way: when the user changes the focus to a new window, the window owner
is brought into the interactive scheduling class. When the user chooses
a new window, the window which loses the focus forces its owner to
return to the time-shared scheduling class.

What do you think about all of this? Should we use behavior-based
against CPU-usage behavior to decide process interactivity?

Thanks for listening.

