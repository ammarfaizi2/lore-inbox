Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932777AbWCQWpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932777AbWCQWpL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 17:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932818AbWCQWpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 17:45:11 -0500
Received: from mail.shareable.org ([81.29.64.88]:5267 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S932777AbWCQWpJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 17:45:09 -0500
Date: Fri, 17 Mar 2006 22:44:39 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "Theodore Ts'o" <tytso@mit.edu>, "Stephen C. Tweedie" <sct@redhat.com>,
       Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       jack@suse.cz
Subject: Re: ext3_ordered_writepage() questions
Message-ID: <20060317224439.GB14552@mail.shareable.org>
References: <1141777204.17095.33.camel@dyn9047017100.beaverton.ibm.com> <20060308124726.GC4128@lst.de> <4410551D.5000303@us.ibm.com> <20060309153550.379516e1.akpm@osdl.org> <4410CA25.2090400@us.ibm.com> <20060316180904.GA29275@thunk.org> <20060317153213.GA20161@mail.shareable.org> <1142632221.3641.33.camel@orbit.scot.redhat.com> <20060317221103.GA17337@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060317221103.GA17337@thunk.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:
> If the application cares about the precise ordering of data blocks
> being written out with respect to the mtime field, I'd respectfully
> suggest that the application use data journalling mode --- and note
> that most applications which update existing data blocks, especially
> relational databases, either don't care about mtime, have their own
> data recovering subsystems, or both.

I think if you're thinking this only affects "applications" or
individual programs (like databases), then you didn't think about the
example I gave.

Scenario:

   - Person has two computers, A and B.
     Maybe a desktop and laptop.  Maybe office and home machines.

   - Sometimes they do work on A, sometimes they do work on B.
     Things like editing pictures or spreadsheets or whatever.

   - They use "rsync" to copy their working directory from A to B, or
     B to A, when they move between computers.

   - They're working on A one day, and there's a power cut.

   - Power comes back.

   - They decide to start again on A, using "rsync" to copy from B to A
     to get a good set of files.

   - "rsync" is believed to mirror directories from one place to
     another without problems.  It's always worked for them before.
     (Heck, until this thread came up, I assumed it would always work).

   - ext3 is generally trusted, so no fsck or anything else special is
     thought to be required after a power cut.

   - So after running "rsync", they believe it's safe to work on A.

     This assumption is invalid, because of ext3's data vs. mtime
     write ordering when they were working on A before the power cut.

     But the user doesn't expect this.  It's far from obvious (except
     to a very thoughtful techie) that rsync, which always works
     normally and even tidies up mistakes normally, won't give correct
     results this time.

   - So they carry on working, with corrupted data.  Maybe they won't
     notice for a long time, and the corruption stays in their work
     project.

No individual program or mount option is at fault in the above
scenario.  The combination together creates a fault, but only after a
power cut.  The usage is fine in normal use and for all other typical
errors which affect files.

Technically, using data=journal, or --checksum with rsync, would be fine.

But nobody _expects_ to have to do that.  It's a surprise.

And they both imply a big performance overhead, so nobody is ever
advised to do that just to be safe for "ordinary" day to day work.

-- Jamie
