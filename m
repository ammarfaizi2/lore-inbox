Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315463AbSEBXBb>; Thu, 2 May 2002 19:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315466AbSEBXBa>; Thu, 2 May 2002 19:01:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59154 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315465AbSEBXBW>;
	Thu, 2 May 2002 19:01:22 -0400
Message-ID: <3CD1C50B.1DB3DBA2@zip.com.au>
Date: Thu, 02 May 2002 16:00:27 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Pittman <daniel@rimspace.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.12 severe ext3 filesystem corruption warning!
In-Reply-To: <87u1pqln4h.fsf@enki.rimspace.net> <3CD191C5.AC09B1F4@zip.com.au> <87znzi18hn.fsf@enki.rimspace.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel, this is good stuff.  Thanks.

Daniel Pittman wrote:
> 
> ...
> 
> Not quite. I found the corruption in three places:
> 
> * my XEmacs and Gnus mail spool.
> * gkrellm configuration files.
> * galeon/mozilla bookmarks and preferences.

So all of those files were written to by their application
during the failed session.

Question on the table is: did the kernel write the wrong
stuff into those files, or did it forget to write the
right stuff?

Is the incorrect content within those files recognisable
at all?  If so, what is it?

> XEmacs uses the mode (O_WRONLY | O_TRUNC) when it writes out files, so
> everything that was written there would have been truncated before
> output. There shouldn't have been any mmap() of the files, though.
> 
> It's also worth noting that XEmacs would fsync() the file handle after
> writing the content, for what that's worth.
> 
> I found corruption in the galeon bookmarks file, which seemed to start
> writing XML half way through the actual data and to add a block of
> around 2K NULL bytes half way through the content.
> 
> I also found corruption in the mozilla prefs.js file from the same
> application[1]. That was simply a truncated file -- no NULL bytes or
> anything, just a file that cut off half way through a single expression
> like:
> 
> user_pref("wallet.capture
> 
> This /may/ be the logical break between two write(2) calls or a partly
> completed write, though.

That sounds like metadata corruption.  Are you sure that
the file doesn't have a chunk of invisible nulls in it,
after the text?  Because if it got chopped off in this
manner, e2fsck should have detected something.

> > And no, it doesn't promise anything good - last time we had crap in
> > truncate/mmap interaction it was a hell to fix.
> >
> > I suspect that you had screwed the truncate exclusion warranties up.
> > If _any_ IO happens in the area currently manipulated by ->truncate()
> > - you are screwed and results would look pretty much like the things
> > mentioned in bug report.
> 
> Ick. Er, good luck. I am quite happy to provide more information and
> even to install a scratch disk and try to get it to fail the same way if
> you wish.

It would be good if you had the time to do that.
 

-
