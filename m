Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262795AbVAKP1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbVAKP1d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 10:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbVAKP1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 10:27:33 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:29079 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262795AbVAKP1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 10:27:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=LwpiECLbkc1QmZ3kno6pzJchFW8PErNg8exAXBQp/JdFnUY0y6TIldPUAKwYA0sPpir+MAoSbx+KhcJHTVW+N+Ywpi8CdO08P+7AYxsd2lBEMRjOnQB3VtAOqEwqlw9C4CHFzfjIkOFDKCmk+xEDkk21LlLwRogKJMAIaU0sess=
Message-ID: <4e1a70d10501110727168c0d54@mail.gmail.com>
Date: Tue, 11 Jan 2005 11:27:21 -0400
From: Ilias Biris <xyz.biris@gmail.com>
Reply-To: Ilias Biris <xyz.biris@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: User space out of memory approach
In-Reply-To: <20050111104439.GJ26799@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050110192012.GA18531@logos.cnet>
	 <20050110200514.GA18796@logos.cnet>
	 <1105403747.17853.48.camel@tglx.tec.linutronix.de>
	 <4d6522b90501101803523eea79@mail.gmail.com>
	 <1105433093.17853.78.camel@tglx.tec.linutronix.de>
	 <4d6522b905011101202918f361@mail.gmail.com>
	 <1105435846.17853.85.camel@tglx.tec.linutronix.de>
	 <20050111095616.GH26799@dualathlon.random>
	 <4d6522b905011102052e16092e@mail.gmail.com>
	 <20050111104439.GJ26799@dualathlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

i believe the OOM has been a matter of frequent discussion for some
time now. The initial implementation was considered good enough for
some, ugly and inefficient in selecting the right task to kill for
others and downright unecessary for yet more of linux users. I belong
to somewhere in between the 1st and the second group.

I personally believe that heuristics never work 100% of the time, even
 when carefully thought of, as Andrea conceded. Nevertheless the
kernel needs some guidance upon which to base a decision. This
guidance can be a default, or a user-based solution  using whatever
possible algorithm to do the ranking. One thing is for sure, the
kernel should be the one to do the kill ...

I believe that we need to test some more and see what should be the
default ranking approach. Certainly Andrea's implementation looks
promising, but as a user I would like to opt if I feel capable to
implement my own ranking algorithm, in a way that is controlled by
myself.

my 2 cents

--
Ilias Biris


On Tue, 11 Jan 2005 11:44:39 +0100, Andrea Arcangeli <andrea@suse.de> wrote:
> On Tue, Jan 11, 2005 at 12:05:40PM +0200, Edjard Souza Mota wrote:
> > Deamon just started at user space, and does only calculation. It doesn't
> > take decision at all. That OOM killer at kernel level who get the list
> > and chooses
> > who to shoot dead.
> 
> Then this is exactly what the oomkilladj patch from Kurt is doing. You
> tune it with this:
> 
> andrea@dualathlon:~> cat /proc/self/oom_adj
> 0
> andrea@dualathlon:~> cat /proc/self/oom_score
> 627
> andrea@dualathlon:~>
> 
> (the second one is the score)
> 
> With this script I can tell exactly which is going to be the next killed
> task if the box were to run oom:
> 
> ls /proc/*/oom_score| grep -v self | sed 's/\(.*\)\/\(.*\)/echo -n "\1 "; cat \1\/\2/'|sh | sort -nr +1| head -n 1
> 
> In this case it would be pid 4175:
> 
> /proc/4175 32923
> andrea@dualathlon:~> ps 4175
>   PID TTY      STAT   TIME COMMAND
>  4175 ?        Ss     0:03 kdeinit: Running...
> andrea@dualathlon:~>
> 
> > Could be. Interesting idea. We shall keep thinking about it. Have you done
> > some experiment like that?
> 
> We ship it in production, it worked so far. Though I don't know if it's
> flexible as much as you need. Sure it's not going to make the oom killer
> worse to have some way of tuning it ;).
> 
> If you've a better API we can discuss it, the above was quite
> non-intrusive, it's simple and it does the trick so I don' dislike it.
> 
> Anyway as said in the other email, before discussing this stuff we
> should get the rest fixed. There were more serious problems than the
> task selection algorithm.
> 
> > Yes, agreed. Our point was just to re-organize current OOM killer to release the
> > kernel from doing rating, which is not its task any way.
> 
> I believe the kernel can have an huristic that gets right 99% of cases.
> But for sure the kernel *can't* always get it right, since only the
> admin knows the semantics and the importance of the stuff being
> computed, and the oomkilladj is there exactly to let the kernel learn
> about it too. The kernel has no clue that it's going to kill the
> database to leave a buggy videogame running, for the kernel all
> processes are important the same unless it's being tuned by userspace
> somehow.
> 
> The only thing the kernel can do is to take the best decision that will
> prevent more oom killing in the future. The kernel should exclude from
> the untuned selection all tasks that even if they're killed, the box
> would run out of memory again. So the one task that is allocating the
> memory at the fastest rate, is the best one to kill normally.  The
> current selection algorithm however is not taking into account the
> allocation rate at all and in turn I believe the current oom killer is
> quite far from the ideal oom killer. But this is a different topic, it
> has nothing to do with the current patches, nor with the userland
> tuning.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
