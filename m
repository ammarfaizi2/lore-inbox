Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTIBAqj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 20:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbTIBAqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 20:46:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:57813 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263375AbTIBAqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 20:46:24 -0400
Date: Mon, 1 Sep 2003 17:52:35 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@suse.cz>
cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix up power managment in 2.6
In-Reply-To: <20030901233833.GD470@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0309011740340.5614-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I've been reviewing your code, see your mailbox. Unfortunately due to
> you renaming functions and moving files around, it is very hard to review.

I've tried to make each changeset do one conceptual item. And, each patch
that I posted, besides obviously the cumulative one, represents one
changeset.

> [Attached is patch "not changing core functionality". How did you
> expect me to verify that? And it was you who protested on killing 3
> printks.]

What is the problem with it? Why is it not better than what was there 
before? 

> And managed to call sleeping functions with interrupts disabled and
> break x86-64 somewhere in the process. 

The first is unintentional and not something I see here. Will investigate 
further. 

Have you confirmed that x86-64 is broken, or are you simply trying to 
raise more accusations? If it is broken, please tell exactly what the 
problem is and I will fix it. 

> Hmm, and because you killed
> BUG_ON(in_atomic()), you did not realize that you were breaking
> that. 

That was in software_suspend() itself, which was completely bogus. For 
one, you should review how you're getting called and realize that neither 
places were atomic contexts. So, it was useless. 

Now, you did export software_suspend() for some unknown reason, and that 
is simply bogus. Why would a module call you? 

Finally, you BUG()'d when you could simply return an error. That's 
completely unfriendly to the user. Just return an error, like every other 
sane code path. 

> And I do not think you actually tested those "panic" codepaths
> to make sure you are not corrupting data, right?

panic() is not a valid replacement for sane error handling. Every single 
panic() in swsusp can be replaced by proper error handling. You should 
have done that a long time ago. Calling panic() is just lazy.

> > I will also restore swsusp to whatever state you like - either -test1,
> > -test3 or -test4 state, or keep it the way it currently is in my patches.  
> > But note that doing so will result in a large amount of duplicated code
> > which you will be responsible for either merging or removing.
> 
> Good, please return it to -test3 state. If you can leave your split-up
> patches on some public ftp site, that would be good; when dm is back
> working so I can actually test it, I'll do some cherry-picking.

They will remain at the URL I posted the other day. As will the patches 
to convert it back to the state you please. I will patch against the 
current tree and continue to work from there. Note that this involves the 
contents of kernel/swsusp.c only. 

And, the driver model is working fine. I don't know what you're 
complaining about now, but a sane bug report would be helpful. So would 
some patches -- you've been maintaining swsusp for two years now, and 
you've not help convert one driver to the new model (even before it 
changed). 


Thanks,



	Pat

