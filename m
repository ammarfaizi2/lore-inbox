Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266022AbUAEXe0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 18:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266020AbUAEXeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 18:34:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:62444 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266008AbUAEXcP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 18:32:15 -0500
Date: Mon, 5 Jan 2004 15:32:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Daniel Jacobowitz <dan@debian.org>, Rob Love <rml@ximian.com>,
       rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
In-Reply-To: <20040106001326.A1128@pclin040.win.tue.nl>
Message-ID: <Pine.LNX.4.58.0401051522390.5737@home.osdl.org>
References: <20040104142111.A11279@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401041302080.2162@home.osdl.org> <20040104230104.A11439@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401041847370.2162@home.osdl.org> <20040105030737.GA29964@nevyn.them.org>
 <Pine.LNX.4.58.0401041918260.2162@home.osdl.org> <20040105132756.A975@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401050749490.21265@home.osdl.org> <20040105205228.A1092@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401051224480.2153@home.osdl.org> <20040106001326.A1128@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Jan 2004, Andries Brouwer wrote:
> 
> Now compare our setups:
> 
> dev_t lbt_devno(void) { return random(); }

Actually, I'd have something like

	int nr;

	initialize()
	{
	#ifdef CONFIG_DEBUG_BAD_USERS
		nr = random();
	#endif
	}

	dev_t lbt_devno()
	{
		return nr++;
	}

since the numbers do have to be unique "per boot". They just shouldn't be 
considered "stable" _nor_ "meaningful".

> dev_t aeb_devno(char *s) { dev_t d = hash(s); while (inuse(d)) d++; return d; }
> 
> An earlier fragment of the discussion was concerned with the fact
> that random(); is a bad idea. Something reproducible is better.

And I've told you why reproducibility is a BAD THING, and why I disagree.

Basically, if you cannot 100% guarantee reproducibility (and nobody can,
not your hashes, not anything else), then the _appearance_ of 
reproducibility is literally a mistake. Because it ends up being a bug 
waiting to happen - and one that is very very hard to reproduce on a 
developer machine.

You seem to continually ignore this issue.

I'm  not going to bother arguign this for another week. I'm just going to 
state once and for all:

 - total device number reproducability is fundamentally impossible. It's 
   not just impossible in theory, it is impossible in practice too.
 - with that in mind, anything that depends on stable device numbers is a 
   BUG.
 - Thus all your arguments boil down to: "I want to encourage bugs".

My argument is that we should find and fix the bugs. And we should do so 
by making the lack of meaning of the device numbers as well-known as 
possible. And that shouldn't just be due to long and boring threads on the 
kernel mailing list, but by actually actively trying to trigger the bad 
cases.

Bugs are good at hiding, and then showing up at the most inopportune 
times when you can't debug them. It's much better to try to trigger them 
where a developer can see them, and you do that by doing strange things.

		Linus
