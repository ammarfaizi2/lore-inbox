Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264279AbTEOWsg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 18:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264283AbTEOWsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 18:48:36 -0400
Received: from smtp1.server.rpi.edu ([128.113.2.1]:1932 "EHLO
	smtp1.server.rpi.edu") by vger.kernel.org with ESMTP
	id S264279AbTEOWsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 18:48:22 -0400
Mime-Version: 1.0
Message-Id: <p0521061fbae9b312fc7a@[128.113.24.47]>
In-Reply-To: <Pine.LNX.4.44.0305141904340.28093-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0305141904340.28093-100000@home.transmeta.com>
Date: Thu, 15 May 2003 19:00:58 -0400
To: Linus Torvalds <torvalds@transmeta.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
From: Garance A Drosihn <drosih@rpi.edu>
Subject: Re: [OpenAFS-devel] Re: [PATCH] PAG support, try #2
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, David Howells <dhowells@redhat.com>,
       <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
       <openafs-devel@openafs.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Advance disclaimer: I have no idea what you do or do not know
about how AFS works, so this may explain some things that you
don't really need explained.  Apologies if that's true...


At 7:30 PM -0700 5/14/03, Linus Torvalds wrote:
>On 15 May 2003, Trond Myklebust wrote:
>>
>  > The interesting thing about a PAG is that it is a handle
>  > that is shared between userland and the kernel, and carries
>  > information about which collection of authentication
>  > tokens/credentials a process holds.
>
>I agree. However, I think that the PAG namespace should be
>bigger than the uid namespace, so that you can have a mapping
>from uid to the PAG.

Actually, it is perfectly fine for the pag name space to be
smaller than the uid name space.  In fact, by definition that
is true.  A single pag can hold the tokens of users for multiple
cells at the same time, so I can be both drosehn@rpi.edu and
gad@umich.edu at the very same moment.  It's just that I can not
be drosehn@rpi.edu and drosehn_a@rpi.edu (my "super AFS account")
at the same moment.

So, technically, my userid space is the space of all userids
from all AFS cells.  There is nothing that says I have to
authenticate as gad@rpi.edu -- and in fact I don't.  There
is no "gad@rpi.edu", even though I use 'gad' as my unix userid
on my own workstation.  I log in as gad, which gives me a PAG
with no credentials, and later on I authenticate to userid
drosehn@rpi.edu.  I could just as well authenticate to userid
gad@umich.edu (well, I could if I still had a userid there...).

The range of PAG id's only has to be as large as the range
of simultaneous processes on any given machine.  (So that
each process could have it's own pag, if it wanted to).  This
does mean that it is true you might very well want different
ranges for a PAG on different machines.

On the other hand, I should note that I don't really care what
range is used for PAG values, just as long as PAGs work the
right way.  If someone wants 64-bit pag's, well, that probably
should not hurt too much.  Hopefully the guys who do the real
work on openafs won't kill me for saying that!

>Also, I _know_ there are situations where you want to share
>credentials _without_ sharing "everything". That's why the
>unix notion of "group" exists, after all. And there is a good
>reason why people can be members of  multiple groups at once.

AFS also has groups.  When it comes to permitting files, AFS has
a much more flexible idea of groups than the standard unix group.
You can a specific directory, and set explicit access to a variety
of explicitly-specified groups.

Eg:
    (20) fs listacl ~/cis
    Access list for /home/37/drosehn/cis is
    Normal rights:
      drosehn:itsmisc rl
      its:etgroup rl
      its:unixprogs rl
      system:backup l
      its:operators rl
      its:wsg rl
      its rl
      system:administrators rl
      drosehn rlidwka

Everything in that list is a group, except for that last entry.
Note that the "group" value as listed for that directory is
totally irrelevant to that access.  In AFS, you do not "set
the one-and-only group" for the file.

As you say, any single AFS user can be a member of any number
of AFS groups.  That issue is handled quite well by AFS.

>  > RPCSEC can be made to use it to communicate which bag of
>  > creds the userland daemon may use when it attempts to
>  > negotiate a new security context for an NFS user.
>
>Absolutely. I just think it should be taken a step further.
>
>Right now the limited PAG namespace as implemented by the
>current patch means that a PAG ID number _has_ to be
>throw-away: the namespace is too small to give users
>permanent PAG ID's.

If you make PAG id's permanent, then you have to make them
visible (*1).  You have to manage them.  You have to be able
to look them up (ie, "give me pag #5").  You have to have
them unique across multiple machines, where those machines
will also span multiple administrative domains.  You have to
add passwords to them.  You will make them much much heavier
weight, and I really don't see all that much advantage from
that adding that extra weight and complexity.

Right now, the creation of a PAG should be an almost zero-cost
option.  The implementation-work is just that PAGS have to be
kept track of separately from processes and userids.  You can
change pags without changing your process or userid, and you
can change userids and processes without losing the pag you
are in.  Both of those need to be true.

*1 = While we talk about PAG values here, I should note that
as a user I have never had any idea of the exact value of
any PAG I have had.  Not once.  I don't even know how to get
the value if I did want it.  All I care about is what tokens
are in my PAG, and when those tokens will expire.

>That's fine per se: you can always create a mapping layer in
>some outside-of-the-kernel way (ie a database of
>"user -> currently used PAG space"),

There is no mapping that goes from a userid to a currently-used
pag space.  At least, I do not know of one.  Somehow we've used
AFS for more than ten years without ever needing that information.

I'm sure it could be done, I just haven't had a need for it.

>So the PAG namespace thing is really just a detail, but one
>which I think is indicative of how this thing would be used
>in practice.

All I can try to do is explain how openafs does in fact use
PAG's, and that in practice it has been a very useful concept.

>But especially if the keys are based off some private user
>knowledge (ie a master session password required to initiate
>the first session), you most likely _do_ want a "join"
>operation that is able to take advantage of the fact that
>the user has already logged in once, and now just wants to
>create a new session - without having to keep the password
>around on the client.

Note that if you did have join-able PAG's, it would not be
based on the userid who first authenticated to it.  We have
people who use a shared account for access to local (unix)
files, and then klog to separate AFS user accounts.  Personally
I don't like that, but I either accept it or get a new job.

More plausibly, different people might log in as one user in
the RPI cell, and then also authenticate as other userids in
any number of other AFS cells.  As far as RPI is concerned,
that pag is still origuser@rpi.edu, but that does not mean
that anyone who knows the password to origuser@rpi.edu will
also have rights to all those AFS userids from other sites.

So, if you're going to have joinable PAG's, then you need to
attach some password/authentication method which is specific
to that PAG, and not related to any of the tokens which have
been used in that PAG.

>In other words, I think of the credentials of equivalent to
>the private keys that something like "ssh-agent" keeps around.
>But different connectors may want to have different disjoint
>sets of keys. Which is again why I think we want to have
>multiple PAG ID's per process.
>
>And the reason I'd like to have the "uid -> default PAG"
>mapping is that that one ends up being somewhat similar to
>the "SSH_AGENT_PID" environment variable for that user. You
>can have multiple PAG's (or none), but I envision one being
>set up for you by default. And you need _some_ key to access
>that default PAG. And the obvious key to use is, to me, the
>already existsing "uid".
>
>Do I make sense?

Well, I seem to agree with so much of what you're thinking,
and then you bring up an analogy that just loses me.  I keep
thinking that we would completely agree, if I can just bring
the PAG situation into focus with the right analogy.

I can see that the idea of a joinable PAG could be of use in
some circumstances, but I really think the overhead of doing
a truly-accurate implementation of that would be too expensive
for too little benefit.  And I also think that in practice
there would be very little need and very little use of
joinable PAGs.  I don't see the point in adding a lot of
expense for something that would rarely be useful.

In your ssh-agent analogy, note that any given process will
have only one ssh-agent.  That agent may have any number of
ssh keys, but you're either using ssh-agent #3 or #4, you
can never be using both #3 and #4.  I would argue that PAG's
are much closer to that ssh-agent process.

In fact, you could think of a PAG as just being an automatic
way to have an ssh-agent -- and an ssh-agent which did not
depend on keeping those environment variables set correctly.
When using ssh, I start up an ssh-agent in one window, and
then copy the environment variable-settings to all my other
unix windows.  That's because they have separate environments
(and because I'm too lazy to do something more intelligent
in my .bashrc file).  I also have to hope that if I run
process X, and process X runs process Y, that the ssh-agent
variables are correctly passed through to process Y.

But as far as AFS is concerned, I just 'klog drosehn' in one
window, and all my session-related processes immediately have
that access.  No need to track them down and change
environment variables in them.  No need to start the ssh-agent
before starting the GUI-ish applications.  No worries about
processes not-passing along environment variables to other
processes that they start.  This all works fairly well, in
my experience.  In fact, I honestly wish I could get the
ssh-userids tied to a PAG, instead of an environment variable.

Well, anyway, has this long rambling explanation been of any
help?

-- 
Garance Alistair Drosehn            =   gad@gilead.netel.rpi.edu
Senior Systems Programmer           or  gad@freebsd.org
Rensselaer Polytechnic Institute    or  drosih@rpi.edu
