Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264148AbTEORLx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 13:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbTEORLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 13:11:53 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18696 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264142AbTEORLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 13:11:49 -0400
Date: Thu, 15 May 2003 10:23:30 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Howells <dhowells@warthog.cambridge.redhat.com>
cc: Dean Anderson <dean@av8.com>, Trond Myklebust <trond.myklebust@fys.uio.no>,
       Garance A Drosihn <drosih@rpi.edu>, Jan Harkes <jaharkes@cs.cmu.edu>,
       David Howells <dhowells@redhat.com>, <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>
Subject: Re: [OpenAFS-devel] Re: [PATCH] PAG support, try #2 
In-Reply-To: <7736.1053016861@warthog.warthog>
Message-ID: <Pine.LNX.4.44.0305150959230.4512-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 May 2003, David Howells wrote:
> > 
> > No it isn't. You can't do independent joins, since as it is, the code has
> > an "all or nothing" approach.
> 
> Independent joins aren't necessarily good either. They add lots of complexity
> and consume lots of kernel resources.

Independent joins are a _requirement_.

My take on this is that I'm personally totally uninterested in AFS and 
Kerberos. 

What I _am_ interested in is things like per-user VPN keys, and things
like keeping my local harddisk encrypted.

So myt background is that unless the credentials are useful for something 
like that, then they aren't useful AT ALL.

With a local encryption, what I'm perfectly willing to do is to go through
a "strong authentication" once, but once I've done that, I don't want to
do it again every time I log in to that machine. I use ssh all the time,
and I have a few machines I trust, so when I come in from such a trusted
machine, and the strong authentication session is already in progress, I
don't want to see a password or anything like that. It should "just work".

And most importantly, it should "just work" _without_ having to have some 
central service have to know about it. I'm a big believer in _not_ having 
deamons that keep track of something and having to connect to them. I'm ok 
with a "ssh-agent", but I absolutely _abhor_ linkages, and if that ssh 
agent has to know about some "super-agent", and that "super-agent" has to 
talk to my "disk-agent", then you have a total disaster on your hands. 

[ It's a total disaster that a lot of CS'y people like, with indirect 
  servers keeping track of other servers that actually do the keys, but I
  think it's all complete crap. Once the kernel knows about the keys, you 
  shouldn't need that kind of indirection on the local machine. ]

So I think I should be able to write a small PAM agent that automatically 
joins me with the right keys when I log in. This is my requirement. And 
part of that requirement is that my PAM agent should _not_ have to know 
about _other_ agents that may also be adding and removing keys. There 
should be no "linkages" between different key spaces, yet they should be 
able to use the same basic kernel infrastructure to maintain them.

And this is where naming becomes important. Because there should be no 
linkages, I think the ad-hoc naming is a bug.  My PAM module shouldn't 
have to ask somebody else what key ID's to use. It knows who I am, it 
should know where to add my keys. And it should be able to add my keys 
_without_ being in the way of somebody else adding keys.

And when I add a key in one window, I want that key to be available in the 
other windows that were opened with independent SSH sessions. Again, 
without having to go through some super-agent to figure things out. The 
kernel _is_ the agent, and if we're adding key knowledge, we should do it 
right.

If I want just _one_ session to get some special powers (let's say that I 
do the equivalent of "su", except I do it by adding the proper credentials 
to my session instead of by changign to root user), then I should be able 
to just do

	new-session	/* creates a new local keyring at the top of the 
			   credentials stack */
	add-key xxxx	/* adds a new key to the top keyring - and because
			   the top keyring now isn't my default one, other
			   ssh sessions won't be seeing this key */

but if I do _just_ the

	add-key xxxx

then I want that key to show up in all my other sessions too, because now 
I'll be adding a key to my "default session". And it also shows up in the 
window where I have even _more_ capabilities - the "new-session" didn't 
drop my old capabilities, it just created a space to hold even more 
(independent) keys.

If your thing can't do this, then I'm not interested. And the patch I've 
seen so far can't do it.

			Linus

