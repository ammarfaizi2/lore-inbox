Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262189AbVCOXtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbVCOXtw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 18:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262167AbVCOXqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 18:46:36 -0500
Received: from mailfe10.tele2.se ([212.247.155.33]:20958 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262126AbVCOXmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 18:42:01 -0500
X-T2-Posting-ID: icQHdNe7aEavrnKIz+aKnQ==
Subject: Re: Capabilities across execve
From: Alexander Nyberg <alexn@dsv.su.se>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, rmk+lkml@arm.linux.org.uk
In-Reply-To: <20050315224219.GA5389@shell0.pdx.osdl.net>
References: <1110627748.2376.6.camel@boxen>
	 <20050313032117.GA28536@shell0.pdx.osdl.net>
	 <20050315215719.A12283@flint.arm.linux.org.uk>
	 <20050315224219.GA5389@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Wed, 16 Mar 2005 00:41:52 +0100
Message-Id: <1110930112.1210.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tis 2005-03-15 klockan 14:42 -0800 skrev Chris Wright:
> * Russell King (rmk+lkml@arm.linux.org.uk) wrote:
> > At some point, I decided I'd like to run a certain program non-root
> > with certain capabilities only.  I looked at the above two programs
> > and stupidly thought they'd actually allow me to do this.
> > 
> > However, the way the kernel is setup today, this seems impossible to
> > achieve, which tends to make the whole idea of capabilities completely
> > and utterly useless.
> 
> Yes, the only value of capabilities right now is for a single program
> that starts off as root with full caps to drop uid and caps.
> 
> > How is this stuff supposed to work?  Are my ideas of what's supposed
> > to be achievable completely wrong, although they look completely
> > reasonable to me.
> 
> It was meant to work with capabilities in the filesystem like setuid bits.
> So the patches that have floated around from myself, Andy Lutomirski
> and Alex Nyberg are attempts to make something half-way sane out of the
> mess.  The trouble is then convincing yourself that it's not some way to
> leak capabilities (esp. since some programs use the interface already,
> like bind9).

Anyone who uses the current interfaces should not play with the
inheritable flag, the text I looked at said it was specifically for
execve. Thus if the application doesn't modify the inheritable mask
things will look like it has always done. And it really should not mess
with inheritable mask if it doesn't intend to, that would be a security
bug.
We really should be safe doing this.

> > Don't get me wrong - the capability system seems great at permanently
> > revoking capabilities via /proc/sys/kernel/cap-bound, and dropping
> > them within an application provided it remains UID0.  Apart from that,
> > capabilities seem completely useless.
> 
> It doesn't have to remain uid0.  That's what the prctl PR_SET_KEEPCAPS does.
> But it's not a nice interface, nor simple to use (for example, it'll
> drop the effective set, so you have to reinstate them).
>
>
> > Don't get me wrong - the current behaviour is secure.  But it's so
> > secure that it gets in the way of things which should appear to work.
> > 
> > I forget precisely what I wanted to achieve with this, and why I
> > couldn't just make the program do it itself...  It may have been a
> > script running from cron periodically which needed just one or two
> > capabilities in order to operate, rather than the whole truck load
> > you get by running it as root.  What I do remember is that my goal
> > of running the script with minimal capabilities was completely
> > *impossible* to achieve.
> 
> All I can say is work is underway.  There's 3 different patches that
> will get you to your goal.  I understand that it's a real pain right now.
> One of the authors of the withdrawn draft has told me that the notion of
> capabilities w/out filesystem support was considered effectively useless.
> So, we're in uncharted territory.  BTW, thanks for reminding me of
> scripts, I had been testing just C programs.

I wouldn't call it useless, retaining capabilities across execve +
pam_cap is a very useful thing, on my machine I can give myself a few
capabilities that have always annoyed me (iirc the database that wanted
mlock as regular user would have been solved aswell).

Regarding fs attributes:
http://www.ussg.iu.edu/hypermail/linux/kernel/0211.0/0171.html

I can see useful scenarios of having the possiblity of capabilities per
inode (it appears the xattr way wins somewhat in the previous
discussion).

Chris, have you seen any capabilities+xattr patches around?

