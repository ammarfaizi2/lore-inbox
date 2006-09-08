Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWIHWvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWIHWvX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 18:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWIHWvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 18:51:23 -0400
Received: from nef2.ens.fr ([129.199.96.40]:21261 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S1751171AbWIHWvW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 18:51:22 -0400
Date: Sat, 9 Sep 2006 00:51:18 +0200
From: David Madore <david.madore@ens.fr>
To: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Message-ID: <20060908225118.GB877@clipper.ens.fr>
References: <20060907003210.GA5503@clipper.ens.fr> <20060907010127.9028.qmail@web36603.mail.mud.yahoo.com> <20060907173449.GA24013@clipper.ens.fr> <20060907225429.GA30916@elf.ucw.cz> <20060908041034.GB24135@clipper.ens.fr> <20060908105238.GB920@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060908105238.GB920@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Sat, 09 Sep 2006 00:51:18 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2006 at 12:52:39PM +0200, Pavel Machek wrote:
> Well, you claim it is as safe as possible, and it is not quite. 

I claim "safe enough". :-)

> I can bet someone will get the fork() case wrong:
> 
> f = fork();
> kill(f);
> 
> fork will return -1, and kill will kill _all_ the processes.

Someone who writes code like that deserves to get all his processes
killed. :-p fork() can fail for a million reasons, some of which, on
most systems, can be provoked by a malicious attacker (such as filling
all available process slots).

> If you can find another uid to hijack, that other uid has bad
> problems. And I do not think you'll commonly find another uid to
> hijack.

How about another gid, then?  Should we reset all caps on sgid exec?

Ultimately a compromise is to be reached between security and
flexibility...  The problem is, I don't know who should make the
decision.

> And there are easier ways to get out of jail with your proposed
> capabilities: you do not restrict ptrace, so you can just ptrace any
> other process with same uid, and hijack it.

That's true.  The restrictions on process killing (which Serge
introduced) should probably be applied to ptrace() also.

> (You probably want to introduce CAP_REG_PTRACE).

Good idea.  I did, in version 0.4.2.

> Or just remove CAP_REG_XUID_EXEC when removing any other CAP_REG...?

Doable, but ugly (or so I think): there are many paths that set
caps...  A simpler solution would be to remove the test on
CAP_REG_SXID and instead test on all regular caps simultaneously.
Still, I really don't like the idea.

> It is not too bad; you'll usually not want restricted programs to exec
> anything setuid... (Do you have example where
> restricted-but-should-be-able-to-setuid-exec makes sense?)

Well, I could imagine that a paranoid sysadmin might want some users'
processes to run without this or that capability (perhaps
CAP_REG_PTRACE or some other yet-to-be-defined capability).  This
doesn't mean that they shouldn't be able to run a game which runs sgid
in order to write the score file.

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
