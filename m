Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbTJJOgA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 10:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262814AbTJJOgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 10:36:00 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:44939 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262805AbTJJOfz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 10:35:55 -0400
Date: Fri, 10 Oct 2003 15:35:53 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
Message-ID: <20031010143553.GA28795@mail.shareable.org>
References: <Pine.LNX.4.44.0310091525200.20936-100000@home.osdl.org> <3F85ED01.8020207@redhat.com> <20031010002248.GE7665@parcelfarce.linux.theplanet.co.uk> <20031010044909.GB26379@mail.shareable.org> <16262.17185.757790.524584@charged.uio.no> <20031010123732.GA28224@mail.shareable.org> <16262.47147.943477.24070@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16262.47147.943477.24070@charged.uio.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> Sure. We might even try actually implementing leases on NFSv4 for
> delegated files.

That would be nice.  (Aside: Can NFSv4 do anything like dnotify, or am I
restricted to, in effect, keeping many files open to detect changes in
any of them?)

Generally NFSv4 sounds like the way to go.  Should I be recommending
it to all my friends yet, is the implementation ready for that?

>      > I don't care about the cache semantics at all; what I care
>      > about is whether a returned stat() result may be stale.
> 
> Note that this too may be a per-file property. Under NFSv4 I can
> guarantee you that stat() results are correct in the case where I have
> a delegation. Otherwise, you are indeed subject to inherent races.
> "noac" cannot entirely resolve such races, but it sounds as if it
> could in the particular cases you describe.

You're right, in the cases I describe "noac" is fine.

I don't like having to ship an FAQ with a program which explains that
the program is theoretically fine, users should simply mount their
home directory with "noac", and tough if that's not within their
administrative power.

I'd rather make the program work correctly with the default mount
options, and maybe have an entry in the FAQ saying that "noac" may
improve performance but is not required for correct behaviour.

Unfortunately that means ugly knowledge of filesystem specifics and
/proc/mount parsing - or significantly lower performance on local
filesystems, which largely negates the purpose of the program.  (It is
very much about caching things derived from file contents).

>      > This is not ideal.  In particular, I don't know of any way to
>      > _guarantee_ that I have the latest file contents from remote
>      > filesystems short of F_SETLK, which way too heavy.[2]
> 
> Err... open() should normally suffice to do that...

Server = RH linux-2.4.20-18.9.  Client = 2.6.0-test6.  I have done
this in the last few days:

	[on client] editing file in emacs, save-buffer
	[on server] diff -ur mumble commands >> file
		    (and wait until command prompt returns)
	[on client] in emacs, find-alternate-file which discards the
		    current buffer and opens & reads the file from fs.
	[on client] edit some more, save file, post to l-k etc.
	[meta]	    notice that the diff wasn't appended to the file

Emacs didn't see the appended data.  (The reason I did the diff command
on the server is that it's a lot faster - a tree's worth of stat calls
is slow over PCMCIA ethernet).

> ...so I would argue that the caching models both can and do make a
> difference to your example cases (contrary to what you assert).

Of course they make a difference when there is no call to say "just do
X and hide the implementation details from me".  What I'd like is an
abstraction so I don't observe a difference, or at least a systematic
way of working around them at application level.

In the same way I expect CPUs to abstract away the (sometimes very)
complex memory caching models, and present something simple to the
program code.

-- Jamie
