Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262964AbTEOEq6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 00:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263811AbTEOEq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 00:46:58 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50949 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262964AbTEOEq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 00:46:56 -0400
Date: Wed, 14 May 2003 21:59:13 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Russ Allbery <rra@stanford.edu>
cc: Garance A Drosihn <drosih@rpi.edu>, Jan Harkes <jaharkes@cs.cmu.edu>,
       David Howells <dhowells@redhat.com>, <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>, <openafs-devel@openafs.org>
Subject: Re: [OpenAFS-devel] Re: [PATCH] PAG support, try #2
In-Reply-To: <ylel30zvgw.fsf@windlord.stanford.edu>
Message-ID: <Pine.LNX.4.44.0305142142190.1605-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 May 2003, Russ Allbery wrote:
> 
> If a single process is in possession of multiple sets of credentials at
> the same time, how does the file system code in the kernel know which ones
> to use for a given operation with a network file system?

The file system code will have to make up its own mind about it. 

In particular, it's likely the case that only _one_ credential is valid 
for that particular mount anyway. You have to ask yourself: where did 
these keys all _come_ from in the first place? And the answer is: usually 
the filesystem. The key was used and registered at mount-time (encrypted 
filesystem), or by some filesystem-specific key exchange.

So I expect that for many filesystems there will never be any confusion.  
Clearly AFS only expects to have one session PAG, for example (since that
is how the _current_ AFS stuff wants to do it), and that implies that
whenever that session PAG is instantiated, the code that instantiates it
will remove any old stale PAGs.

But the fact that you'd have AFS with just one set of credentials doesn't
mean that the same process might not want to have another PAG for other 
uses. Each use might only fit one way. 

And even when you have multiple PAG's for the same entity, this is not a
new situation. In fact, UNIX pretty much since day 1 has had it: what do
you think user/group/other are? They are prioritized credentials. There,
you have two different credentials (well, groups are multiple ones in
themselves), with a prioritation scheme ("user matters more, but if user
doesn't match there is no prioritation in groups _except_ one group entry
is special in that we'll use that for new ID creation").

Up to the filesystem to decide what it does with the different 
credentials, in other words. Some filesystem may decide to only allow one.

			Linus

