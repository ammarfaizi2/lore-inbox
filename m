Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267661AbSLFXDo>; Fri, 6 Dec 2002 18:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267656AbSLFXDo>; Fri, 6 Dec 2002 18:03:44 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:59633 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S267661AbSLFXDn>;
	Fri, 6 Dec 2002 18:03:43 -0500
Message-ID: <3DF12E04.B682F729@mvista.com>
Date: Fri, 06 Dec 2002 15:08:53 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jim.houston@ccur.com
CC: Linus Torvalds <torvalds@transmeta.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, ralf@gnu.org, willy@debian.org
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
References: <Pine.LNX.4.44.0212061307310.3830-100000@penguin.transmeta.com> <3DF11D16.289456B2@ccur.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Houston wrote:
> 
> Linus Torvalds wrote:
> >
> > On Fri, 6 Dec 2002, george anzinger wrote:
> > >
> > > I have not looked at your code yet, but I am concerned that
> > > the restart may not be able to get to the original
> > > parameters.
> >
> > The way the new system call restarting is done, it never looks at the old
> > parameters. They don't even _exist_ for the restarted call (well, they do,
> > but the restart function can't actually get at them). So it is up to the
> > original interrupted call to save off anything it needs saving off (and it
> > get sthe "restart_block" structure to do that saving in. Right now that's
> > just three words, but we can expand it if necessary).
> >
> 
> Hi Linus,
> 
> I know it would be a few extra lines of assembly code but it would be
> nice if the restart routine had the original arguments.  Would it be too
> ugly to do something like:
> 
> sys_restart_syscall:
>         GET_THREAD_INFO(%eax)
>         jmp     TI_RESTART_BLOCK(%eax)
> 
> I'm having second thoughts about even sending this.  Its just that I hate
> casts more than I hate assembly code and using the restart_block to save
> the arguments implys casts.
> 
I too, think the original parameters are very useful.  I
keep wondering if we could simplify all this by just
restarting the SAME system call.  Keep the restart block to
save stuff in AND let deliver_signal clear a word in it if
it is not restarting the call.  This way the system call
knows it is being restarted, but it has all the parameters
it need PLUS the restart arguments.  The only hole I see
here is making sure the restart block is cleared after use. 
This could be done by bumping it each system call so exactly
1 means this is a restart.  OR, we could trust the users to
always clear it after using (better I think, no code on the
fast path).

Oh, on thinking on this, we can get this behavior with what
we have if we just change the -ERESTARTNOHAND to clear the
first word or the restart block on the handler call.  This
way you can have your cake and eat it too :)
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
