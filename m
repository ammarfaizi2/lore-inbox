Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264284AbTEPAk7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 20:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264311AbTEPAk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 20:40:59 -0400
Received: from mailsrv.rollanet.org ([192.55.114.7]:21393 "HELO
	mx.rollanet.org") by vger.kernel.org with SMTP id S264284AbTEPAky
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 20:40:54 -0400
Subject: Re: [OpenAFS-devel] Re: [PATCH] PAG support, try #2
From: Nathan Neulinger <nneul@umr.edu>
To: Garance A Drosihn <drosih@rpi.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jan Harkes <jaharkes@cs.cmu.edu>, David Howells <dhowells@redhat.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       openafs-devel@openafs.org
In-Reply-To: <p0521061fbae9b312fc7a@[128.113.24.47]>
References: <Pine.LNX.4.44.0305141904340.28093-100000@home.transmeta.com>
	 <p0521061fbae9b312fc7a@[128.113.24.47]>
Content-Type: text/plain
Organization: University of Missouri - Rolla
Message-Id: <1053046424.26158.17.camel@cessna.rollanet.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4.99 
Date: 15 May 2003 19:53:44 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If you make PAG id's permanent, then you have to make them
> visible (*1).  You have to manage them.  You have to be able
> to look them up (ie, "give me pag #5").  You have to have
> them unique across multiple machines, where those machines
> will also span multiple administrative domains.  You have to
> add passwords to them.  You will make them much much heavier
> weight, and I really don't see all that much advantage from
> that adding that extra weight and complexity.

Currently they are visible, but it's considered opaque and really isn't
of use to anything other than administrative tools (for the local
system).

> Note that if you did have join-able PAG's, it would not be
> based on the userid who first authenticated to it.  We have
> people who use a shared account for access to local (unix)
> files, and then klog to separate AFS user accounts.  Personally
> I don't like that, but I either accept it or get a new job.
> 

> So, if you're going to have joinable PAG's, then you need to
> attach some password/authentication method which is specific
> to that PAG, and not related to any of the tokens which have
> been used in that PAG.
> 
> 

Joinable pags is a purely administrative function, used by almost nobody
right now except for a few esoteric system admin functions on select
installations, certainly nothing in a normal install/setup.

If that capability is objectionable (most people didn't even realize it
was possible currently, and at that, only for root/suid=0 procs)

> In fact, you could think of a PAG as just being an automatic
> way to have an ssh-agent -- and an ssh-agent which did not
> depend on keeping those environment variables set correctly.
> When using ssh, I start up an ssh-agent in one window, and
> then copy the environment variable-settings to all my other
> unix windows.  That's because they have separate environments
> (and because I'm too lazy to do something more intelligent
> in my .bashrc file).  I also have to hope that if I run
> process X, and process X runs process Y, that the ssh-agent
> variables are correctly passed through to process Y.
> 
> But as far as AFS is concerned, I just 'klog drosehn' in one
> window, and all my session-related processes immediately have
> that access.  No need to track them down and change
> environment variables in them.  No need to start the ssh-agent
> before starting the GUI-ish applications.  No worries about
> processes not-passing along environment variables to other
> processes that they start.  This all works fairly well, in
> my experience.  In fact, I honestly wish I could get the
> ssh-userids tied to a PAG, instead of an environment variable.

And more importantly - that behavior is totally expected across ALL
on-the-same-system activities by AFS users. We expect that we're not
going to get new pags assigned except at explicit request or expected
times, and that includes copying tokens/tickets/etc. 

If I run a subshell/suid app/etc. and klog/kinit to get new
tokens/keys/whatever, I expect that those keys will be available to the
parent process and all other processes in that same pag. If I don't want
this behavior, I'll request a new pag before starting the
subshell/app/whatever. AFS cmd line tools make this real easy "pagsh
cmd". 

It would be best if y'all would avoid trying to combine the issue of
PAGs with the issue of auth/key/token/ticket data in the kernel. They
are orthogonal to each other. 

I've also seen numerous mentions of the fact that afs can only deal with
a single token per cell per pag. This shouldn't be of issue to the PAG
discussion at all - it's up to the individual filesystem to handle how
it accepts token data into the kernel. The only thing that is decided
for it is what PAG the data is associated with.

Additionally - why all this worry/concern about sharing keys. Yuck. If
we want multiple separate pags authenticated to the same entity, we'll
just insert the tokens more than once from user space. No reason to
concern the kernel with that.

-- Nathan

------------------------------------------------------------
Nathan Neulinger                       EMail:  nneul@umr.edu
University of Missouri - Rolla         Phone: (573) 341-4841
Computing Services                       Fax: (573) 341-4216

