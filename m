Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267808AbUIJTWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267808AbUIJTWu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 15:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267807AbUIJTWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 15:22:18 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:5132 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S267808AbUIJTRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 15:17:43 -0400
Message-ID: <4141FF13.8030009@techsource.com>
Date: Fri, 10 Sep 2004 15:22:59 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Jan Harkes <jaharkes@cs.cmu.edu>,
       =?ISO-8859-1?Q?Markus_T=F6rnqvist?= <mjt@nysv.org>,
       Matt Mackall <mpm@selenic.com>, Nicholas Miell <nmiell@gmail.com>,
       Wichert Akkerman <wichert@wiggy.net>, Jeremy Allison <jra@samba.org>,
       Andrew Morton <akpm@osdl.org>, Spam <spam@tnonline.net>,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org> <1453698131.20040826011935@tnonline.net> <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy> <20040826044425.GL5414@waste.org> <1093496948.2748.69.camel@entropy> <20040826053200.GU31237@waste.org> <20040826075348.GT1284@nysv.org> <20040826163234.GA9047@delft.aura.cs.cmu.edu> <Pine.LNX.4.58.0408260936550.2304@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408260936550.2304@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linus Torvalds wrote:

> 
> The same goes for something like a "container file". Whether you see it as
> "dir-as-file" or "file-as-dir" (and I agree with Jan that the two are
> totally equivalent), the point of having the capability in the kernel is
> not that the operations cannot be done in user space - the point is that
> they cannot be done in user space _safely_. The kernel is kind of the
> thing that guarantees that everybody follows the rules.
> 

Well, it CAN be done safely if every client has to go through the kernel 
which does all the appropriate locks/semaphors and then passes the 
request down to the daemon.  (Isn't NFS implemented this way?)

This is very micro-kernel-ish, but it's a reasonable idea to do it this 
way in cases where things are non-critical.

Say there's a way to cd into a tgz file to look around.  If the access 
methods through the kernel get routed back to a user-space process 
(which probably does some amount of caching in memory and on disk of 
uncompressed bits of the archive), it could be a bit slower than if it 
were all in-kernel.  The thing is that the processing time in the daemon 
is probably quite high compared to the overhead of the context switches, 
so it doesn't cost much.  (And if it CAN be done in userspace without 
being horribly convoluted or unsafe, then it SHOULD be done in 
userspace.)  Besides, even if it were a LOT slower to access a tgz file 
without extracting it first, I would STILL think it was wonderful AND 
use it a LOT.

Heh... now, the next thing is to be able to do some sort of union-mount 
like thing where the tgz is really read-only but if you WRITE to it, it 
gets stored somewhere else.  This way, you can compile a kernel tree 
without extracting it first.

Taking this a bit further, the union-mount could be done away with if 
the daemon were to lazily rebuild the tgz file from its cache when the 
tgz is modified.  That is, writes have little or no penalty because they 
just get stored in the daemon's cache, and the daemon rebuilds the 
archive in the background.

The VFS layer would have to recognize that a particular file has been 
accessed in such a way that it must go through the daemon for ANY access 
to it, which means that if someone tries to access the original archive 
as a file, requests have to go through the daemon.  This makes it 
coherent, although with an expected performance penalty.

One issue to consider is that of shutdowns, both intentional and 
crashes.  This is a non-issue with an underlying journaling file system. 
  As long as the tgz daemon comes up early enough, it would see its 
cache (which is on-disk anyway), recognize which archive it belongs to, 
and continue where it left off.  This way, the daemon doesn't have to go 
through a long process of rebuilding every archive you've ever modified 
on the disk on shut-down.  If, however, you needed to access the archive 
without the daemon, that could be a problem (but what you'd get is 
probably the archive before it was modified).  Also, some sort of sync 
command would be needed to cause the daemon to rebuild all archives 
immediately.

I really dig the idea of being able to access archives without 
extracting them first, regardless of any performance penalty.

