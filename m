Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262689AbVAKKob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbVAKKob (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 05:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbVAKKob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 05:44:31 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:10070
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262689AbVAKKoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 05:44:24 -0500
Date: Tue, 11 Jan 2005 11:44:39 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Edjard Souza Mota <edjard@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Mauricio Lin <mauriciolin@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: User space out of memory approach
Message-ID: <20050111104439.GJ26799@dualathlon.random>
References: <20050110192012.GA18531@logos.cnet> <4d6522b9050110144017d0c075@mail.gmail.com> <20050110200514.GA18796@logos.cnet> <1105403747.17853.48.camel@tglx.tec.linutronix.de> <4d6522b90501101803523eea79@mail.gmail.com> <1105433093.17853.78.camel@tglx.tec.linutronix.de> <4d6522b905011101202918f361@mail.gmail.com> <1105435846.17853.85.camel@tglx.tec.linutronix.de> <20050111095616.GH26799@dualathlon.random> <4d6522b905011102052e16092e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d6522b905011102052e16092e@mail.gmail.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 12:05:40PM +0200, Edjard Souza Mota wrote:
> Deamon just started at user space, and does only calculation. It doesn't
> take decision at all. That OOM killer at kernel level who get the list
> and chooses
> who to shoot dead.

Then this is exactly what the oomkilladj patch from Kurt is doing. You
tune it with this:

andrea@dualathlon:~> cat /proc/self/oom_adj 
0
andrea@dualathlon:~> cat /proc/self/oom_score 
627
andrea@dualathlon:~> 

(the second one is the score)

With this script I can tell exactly which is going to be the next killed
task if the box were to run oom:

ls /proc/*/oom_score| grep -v self | sed 's/\(.*\)\/\(.*\)/echo -n "\1 "; cat \1\/\2/'|sh | sort -nr +1| head -n 1

In this case it would be pid 4175:

/proc/4175 32923
andrea@dualathlon:~> ps 4175
  PID TTY      STAT   TIME COMMAND
 4175 ?        Ss     0:03 kdeinit: Running...      
andrea@dualathlon:~> 

> Could be. Interesting idea. We shall keep thinking about it. Have you done
> some experiment like that?

We ship it in production, it worked so far. Though I don't know if it's
flexible as much as you need. Sure it's not going to make the oom killer
worse to have some way of tuning it ;).

If you've a better API we can discuss it, the above was quite
non-intrusive, it's simple and it does the trick so I don' dislike it.

Anyway as said in the other email, before discussing this stuff we
should get the rest fixed. There were more serious problems than the
task selection algorithm.

> Yes, agreed. Our point was just to re-organize current OOM killer to release the
> kernel from doing rating, which is not its task any way.

I believe the kernel can have an huristic that gets right 99% of cases.
But for sure the kernel *can't* always get it right, since only the
admin knows the semantics and the importance of the stuff being
computed, and the oomkilladj is there exactly to let the kernel learn
about it too. The kernel has no clue that it's going to kill the
database to leave a buggy videogame running, for the kernel all
processes are important the same unless it's being tuned by userspace
somehow.

The only thing the kernel can do is to take the best decision that will
prevent more oom killing in the future. The kernel should exclude from
the untuned selection all tasks that even if they're killed, the box
would run out of memory again. So the one task that is allocating the
memory at the fastest rate, is the best one to kill normally.  The
current selection algorithm however is not taking into account the
allocation rate at all and in turn I believe the current oom killer is
quite far from the ideal oom killer. But this is a different topic, it
has nothing to do with the current patches, nor with the userland
tuning.
