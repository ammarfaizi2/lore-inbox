Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262777AbVAKO4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262777AbVAKO4g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 09:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262791AbVAKO4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 09:56:36 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:50106 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262777AbVAKO41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 09:56:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=toD527ySnogtJMEDlZFRdV7xSQOjcq+2GbaYGlpcL+JpxuuIigPNsQlo7+oZAiJck1p5UxIzOj1u6gM/2wvzt8W9JekOBu5DR57/3o6eAi22N6qJc+ojCpjYfnBy/ejTcqXFJxeefjuym1gJJ+KNgnxf3zGOd6tIDyk3FVW8lJk=
Message-ID: <4d6522b90501110656530d6860@mail.gmail.com>
Date: Tue, 11 Jan 2005 16:56:27 +0200
From: Edjard Souza Mota <edjard@gmail.com>
Reply-To: Edjard Souza Mota <edjard@gmail.com>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: User space out of memory approach
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Mauricio Lin <mauriciolin@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
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

Hi,

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

Yeap, that's what we believe and this very tiny contribution is, as
far as I can see,
orthogonal to you work and we are willing to complement it with more
experiments.

> If you've a better API we can discuss it, the above was quite
> non-intrusive, it's simple and it does the trick so I don' dislike it.

Ok. We already started checking that and we will give you a feed back soon.

> Anyway as said in the other email, before discussing this stuff we
> should get the rest fixed. There were more serious problems than the
> task selection algorithm.

Yes, indeed. I agree you and other guys on this respect. It is just
that sometimes
small stones inside our shoes cause greater damage in the long run than
the big ones we've just faced. All othe problems are like the big ones, and
we took the path to remove the small ones first.

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

Ok, I realise this may look too philosophical to other folks in this list but
just for the sake of reality Linux is going to mobility nowadays. No one
denies that. What for? There are certainly better answers then mines, but
we hope to allow the freedom of choosing for the application you want to 
have just on the palm of hand, for affordable prices and fair competition.
This is not new, sorry about that.

Taking this into account, who holds the semantics of the importance of
applications running but the user of a mobile device? Is it the kernel? Who is
the admin? 
 
> The only thing the kernel can do is to take the best decision that will
> prevent more oom killing in the future. The kernel should exclude from
> the untuned selection all tasks that even if they're killed, the box
> would run out of memory again. 

For sure there are certain levels of security that operators and 
manufacturers wnat to have and they warn us what we can and we can't do.
Just like with easy-to-use consumer electronic products. Again, nothing new.

> So the one task that is allocating the memory at the fastest rate, is the 
> best one to kill normally.  The current selection algorithm however is not 
> taking into account the allocation rate at all and in turn I believe the current 
> oom killer is quite far from the ideal oom killer. But this is a different topic, it
> has nothing to do with the current patches, nor with the userland
> tuning.

Yes, your'e absolutely right. The userland tuning is just the part that will
allow, let's say, a user profile-based policy of ranking, and this may have
impact on such patterns of memory consuption, or rate allocation if you like.

br

Edjard

-- 
"In a world without fences ... who needs Gates?"
