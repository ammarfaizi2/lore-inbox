Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbTEMRHs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 13:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbTEMRHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 13:07:48 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:3222 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S262426AbTEMRHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 13:07:45 -0400
Date: Tue, 13 May 2003 13:20:30 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
Subject: Re: [PATCH] in-core AFS multiplexor and PAG support
Message-ID: <20030513172029.GB25295@delft.aura.cs.cmu.edu>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
References: <8812.1052841957@warthog.warthog> <Pine.LNX.4.44.0305130929340.1678-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305130929340.1678-100000@home.transmeta.com>
User-Agent: Mutt/1.5.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 09:47:59AM -0700, Linus Torvalds wrote:
> > Maybe... There are arguments either way, but if the token ring is kept in
> > struct user, a task can't detach from it and pass a token-less set of keys
> > onto another process it wants to run.
> 
> Oh, but it can. The pointer should be kept at two places: the "struct 
> task_struct" contains the initial pre-process value, and at file open time 
> that pointer should get copied (and the user count incremented) and put 
> into the "struct file". 
> 
> So you can pass the set of keys the way UNIX _always_ passes rights - 
> through the file descriptor. 

Right, if some process/user opens a file and then passes the descriptor
to another process/user which closes it. The close should operate under
the same permissions as the original opener.

Simple example when this happens is when a setuid application is started
and the stdout/stderr is redirected to a file. 'ping foo >out 2>&1'. The
shell opens the file under my uid, but the setuid application closes it
under the new uid.

> The advantage of associating the PAG with the real uid rather than make it
> per-process is that it's a lot easier to administer that way, I think. You
> don't need to log out or anything like that to have changes take effect
> for your session, and it is very natural to say "this user now gets key
> X". Which is what I think you really want when you do something like enter
> a key to an encrypted filesystem, for example.

The local user id is not a 'trusted' identity for a distributed filesystem.
Any user still have to prove his identity by obtaining tokens. 

If someone obtains my user id on in any way (i.e. weak password/
bufferoverflow/ root exploit), he should not be allowed to use or access
my tokens as he hasn't proven his identity. In this case he would either
still be in his original process authentication group, or a new and
empty PAG. But definitely not in any of my authentication groups.

Which is also why joining a PAG should never be allowed.

Any arguments about 'it avoids the cost of obtaining credentials' are
stupid because that cost is exactly what it takes to prove that a new
session is in fact associated with a specific user. If our identity
already was proven beyond reasonable doubt, we clearly already have our
'token' and the additional cost to associate this with the new PAG is
zero.

Jan

