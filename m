Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268427AbRGXTIM>; Tue, 24 Jul 2001 15:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268432AbRGXTIC>; Tue, 24 Jul 2001 15:08:02 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:5302 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S268427AbRGXTHw>; Tue, 24 Jul 2001 15:07:52 -0400
Date: Tue, 24 Jul 2001 15:07:45 -0400
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Larry McVoy <lm@bitmover.com>,
        Jerome de Vivie <jerome.de-vivie@wanadoo.fr>,
        linux-kernel@vger.kernel.org, linux-fsdev@vger.kernel.org,
        martizab@libertsurf.fr, rusty@rustcorp.com.au
Subject: Re: Yet another linux filesytem: with version control
Message-ID: <20010724150745.A19281@cs.cmu.edu>
Mail-Followup-To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
	Larry McVoy <lm@bitmover.com>,
	Jerome de Vivie <jerome.de-vivie@wanadoo.fr>,
	linux-kernel@vger.kernel.org, linux-fsdev@vger.kernel.org,
	martizab@libertsurf.fr, rusty@rustcorp.com.au
In-Reply-To: <200107240524.f6O5OwX286884@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200107240524.f6O5OwX286884@saturn.cs.uml.edu>
User-Agent: Mutt/1.3.18i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 24, 2001 at 01:24:57AM -0400, Albert D. Cahalan wrote:
> The traditional revision control approach seems to get pretty
> wasteful as well. Maybe you have a few dozen developers, each
> with a few files checked out of a multi-gigabyte source tree.

Ouch, but that is a lot more difficult in kernel space than that.
Every developer would have his own personal view on the same filesystem.

One problem is how to identify a developer, by his uid's/gid's? This is
either not fine-grained enough, or breaks with setuid/gid processes. The
process group id or session id, these are already used by shells for
signal handling and typically don't follow a user's identity. AFS uses
yet another 'session identifier', the process authentication group.

Maybe some of the session information can be stored in the vfsmount
structure, or it might already be solved by Al's namespaces patch and
can be 'set' by remounting a file system. Perhaps the security module
work will give the stuff to track actions of a specific user.

Then keep the various versions/views of a file need to be kept separate
from each other in the pagecache, which involves having a separate
inode/address_space for each filehandle. On the other hand, when two
developers are working with the same revision they expect UNIX sharing
semantics, so in these cases at least the address_space does need to be
shared.

This actually should work as a result of how Coda handles container
files as long as we agressively unhash dentries and have iget return new
inodes each time, a checked-out revision can then be stored in a
separate container file. But as a result there would be many more
upcalls to userspace, i.e. a serious performance penalty.

    Jan

