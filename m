Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268164AbUIFP5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268164AbUIFP5W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 11:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268215AbUIFP4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 11:56:11 -0400
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:17362 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S268183AbUIFPzZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 11:55:25 -0400
To: Jamie Lokier <jamie@shareable.org>
Cc: Christer Weinigel <christer@weinigel.se>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
References: <20040901200806.GC31934@mail.shareable.org>
	<200409021407.i82E70hx004899@laptop11.inf.utfsm.cl>
	<20040902173214.GB24932@mail.shareable.org>
	<m3pt54il82.fsf@zoo.weinigel.se>
	<20040902214731.GF24932@mail.shareable.org>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 06 Sep 2004 17:55:21 +0200
In-Reply-To: <20040902214731.GF24932@mail.shareable.org>
Message-ID: <m3oekjgzo6.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> Christer Weinigel wrote:
> > Can be done with dnotify/inotify and a cache daemon keeping track of
> > mtime.  Yes, this will need a kernel change to make sure mtime always
> > changed when the file changes, but it does not require anything else.
> 
>     - Can the daemon keep track of _every_ file on my disk like this?
>       That's more than a million files, and about 10^5 directories.
>       dnotify would require the daemon to open all the directories.
>       I'm not sure what inotify offers.

I don't think dnotify/inotify handles subdirectories well yet, so I
suppose that they would have to be extended.

>     - What happens at reboot - I guess the daemon has to call stat()
>       on every file to verify its indexes? Have you any idea how long
>       it takes to call stat() on every file in my home directory?

The daemon saves state before it shuts down and reloads the state
after a reboot.  You have to make sure that it is started first and
stopped last during the boot process.  How would a kernel plugin
handle things that happen before or after the plugin module has been
loaded?  It's the same problem.

>     - The ordering problem: I write to a file, then the program
>       returns.  System is very busy compiling.  2 minutes later, I
>       execute a search query.  The file I wrote two minute ago doesn't
>       appear in the search results.  What's wrong?
>
>       Due to scheduling, the daemon hasn't caught up yet.  Ok, we can
>       accept that's just hard life.  Sometimes it takes a while for
>       something I write to appear in search results.
> 
>       But!  That means I can't use these optimised queries as drop-in
>       replacements for calling grep and find, or for making Make-like
>       programs run faster (by eliminating parsing and stat() calls).
>       That's a shame, it would have been nice to have a mechanism that
>       could transparently optimise prorgrams that do calculations....

Sure you can.  First of all, you can just wait for the daemon to
finish indexing any files that it has been notified about changes in.
This is no different from you having to wait for the kernel to finish
indexing the files.  Or are you suggesting that the kernel should stop
all other processes until the indexing is done?

> Do you see what I'm getting at?  There's building some nice GUI
> and search engine like functionality, where changes made by one
> program _eventually_ show up in another (i.e. not synchronously).
> 
> That's easy.
> 
> And then there's optimising things like grep, find, perl, gcc,
> make, httpd, rsync, in a way that's semantically transparent, but
> executes faster _as if_ they had recalculated everything they
> need to every time.  That's harder.

If you have a good notify, it's not harder.  

> No, not 3, 4 or 6.  For correct behaviour those require synchronous
> query results.  Think about 6, where one important cached query is
> "what is the MD5 sum of this file", and another critical one, which
> can only work through indexing, is "give me the name of any file whose
> MD5 sum matches $A_SPECIFIC_MD5".  Trusting the async results for
> those kind of queries from your daemon would occasionally result in
> data loss due to race conditions.  So you wouldn't trust the async
> results, and you fail to get those CPU-saving and bandwidth-saving
> optimisations.

So how do you calculate the MD5 sum of a file that is in the process
of being modified?  It's not possible to do that unless you block all
other access to that file and recalculate the MD5 sum after each
write.  With a notifier that tells the daemon that it has stale data
and needs to reprocess the file, it's no different.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
