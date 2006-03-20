Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWCTQ1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWCTQ1Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWCTQ1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:27:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56536 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751130AbWCTQ1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 11:27:22 -0500
Subject: Re: ext3_ordered_writepage() questions
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Badari Pulavarty <pbadari@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, jack@suse.cz,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20060319023610.GA4824@mail.shareable.org>
References: <20060308124726.GC4128@lst.de> <4410551D.5000303@us.ibm.com>
	 <20060309153550.379516e1.akpm@osdl.org> <4410CA25.2090400@us.ibm.com>
	 <20060316180904.GA29275@thunk.org>
	 <20060317153213.GA20161@mail.shareable.org>
	 <1142632221.3641.33.camel@orbit.scot.redhat.com>
	 <20060317221103.GA17337@thunk.org>
	 <20060317224439.GB14552@mail.shareable.org>
	 <20060318234018.GK21232@thunk.org>
	 <20060319023610.GA4824@mail.shareable.org>
Content-Type: text/plain
Date: Mon, 20 Mar 2006 11:26:25 -0500
Message-Id: <1142871986.3414.14.camel@orbit.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 2006-03-19 at 02:36 +0000, Jamie Lokier wrote:

> Now, to be fair, most programs don't overwrite data blocks in place either.

Which is the point we're trying to make: "make" is almost always being
used to create or fully replace whole files, not to update existing data
inside a file, for example.

> They usually open files with O_TRUNC to write with new contents.  How
> does that work out with/without Badari's patch?  Is that safe in the
> same way as creating new files and appending to them is?

Yes, absolutely.  We have to be extremely careful about ordering when it
comes to truncate, because we cannot allow the discarded data blocks to
be reused until the truncate has committed (otherwise a crash which
rolled back the truncate would potentially expose corruption in those
data blocks.)  That's all done in the allocate logic, not in the
writeback code, so it is unaffected by the writeback patches.

So the O_TRUNC is still fully safe; and the allocation of new blocks
after that is simply a special case of extend, so it is also unaffected
by the patch.

It is *only* the recovery semantics of update-in-place which are
affected.

> It's this: you edit a source file with your favourite editor, and save
> it.  3 seconds later, there's a power cut.  The next day, power comes
> back and you've forgotten that you edited this file.

If your editor is really opening the existing file and modifying the
contents in place, then you have got a fundamentally unsolvable problem
because the crash you worry about might happen while the editor is still
writing and the file is internally inconsistent.  That's not something I
think is the filesystem's responsibility to fix!

--Stephen

