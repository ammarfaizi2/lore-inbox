Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269226AbUIBVxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269226AbUIBVxd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 17:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269224AbUIBVtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 17:49:51 -0400
Received: from mail.shareable.org ([81.29.64.88]:8907 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S269214AbUIBVso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 17:48:44 -0400
Date: Thu, 2 Sep 2004 22:47:31 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Christer Weinigel <christer@weinigel.se>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
Message-ID: <20040902214731.GF24932@mail.shareable.org>
References: <20040901200806.GC31934@mail.shareable.org> <200409021407.i82E70hx004899@laptop11.inf.utfsm.cl> <20040902173214.GB24932@mail.shareable.org> <m3pt54il82.fsf@zoo.weinigel.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3pt54il82.fsf@zoo.weinigel.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christer Weinigel wrote:
> Can be done with dnotify/inotify and a cache daemon keeping track of
> mtime.  Yes, this will need a kernel change to make sure mtime always
> changed when the file changes, but it does not require anything else.

    - Can the daemon keep track of _every_ file on my disk like this?
      That's more than a million files, and about 10^5 directories.
      dnotify would require the daemon to open all the directories.
      I'm not sure what inotify offers.

    - What happens at reboot - I guess the daemon has to call stat()
      on every file to verify its indexes? Have you any idea how long
      it takes to call stat() on every file in my home directory?

    - The ordering problem: I write to a file, then the program
      returns.  System is very busy compiling.  2 minutes later, I
      execute a search query.  The file I wrote two minute ago doesn't
      appear in the search results.  What's wrong?

      Due to scheduling, the daemon hasn't caught up yet.  Ok, we can
      accept that's just hard life.  Sometimes it takes a while for
      something I write to appear in search results.

      But!  That means I can't use these optimised queries as drop-in
      replacements for calling grep and find, or for making Make-like
      programs run faster (by eliminating parsing and stat() calls).
      That's a shame, it would have been nice to have a mechanism that
      could transparently optimise prorgrams that do calculations....

Do you see what I'm getting at?  There's building some nice GUI
and search engine like functionality, where changes made by one
program _eventually_ show up in another (i.e. not synchronously).

That's easy.

And then there's optimising things like grep, find, perl, gcc,
make, httpd, rsync, in a way that's semantically transparent, but
executes faster _as if_ they had recalculated everything they
need to every time.  That's harder.

> >     3. Email program scanning for subject lines fast:
> 
> Same here.
> 
> >     4. Blog server caching built pages:
> >     5. Programming environment scanning for tags:
> >     6. File transfer program scanning for shared deltas.
> 
> And so on.

No, not 3, 4 or 6.  For correct behaviour those require synchronous
query results.  Think about 6, where one important cached query is
"what is the MD5 sum of this file", and another critical one, which
can only work through indexing, is "give me the name of any file whose
MD5 sum matches $A_SPECIFIC_MD5".  Trusting the async results for
those kind of queries from your daemon would occasionally result in
data loss due to race conditions.  So you wouldn't trust the async
results, and you fail to get those CPU-saving and bandwidth-saving
optimisations.

-- Jamie
