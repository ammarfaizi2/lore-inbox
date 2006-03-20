Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWCTCSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWCTCSR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 21:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWCTCSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 21:18:17 -0500
Received: from THUNK.ORG ([69.25.196.29]:58826 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751193AbWCTCSQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 21:18:16 -0500
Date: Sun, 19 Mar 2006 21:18:03 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jamie Lokier <jamie@shareable.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
       Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       jack@suse.cz
Subject: Re: ext3_ordered_writepage() questions
Message-ID: <20060320021803.GB17337@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Jamie Lokier <jamie@shareable.org>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, jack@suse.cz
References: <4410551D.5000303@us.ibm.com> <20060309153550.379516e1.akpm@osdl.org> <4410CA25.2090400@us.ibm.com> <20060316180904.GA29275@thunk.org> <20060317153213.GA20161@mail.shareable.org> <1142632221.3641.33.camel@orbit.scot.redhat.com> <20060317221103.GA17337@thunk.org> <20060317224439.GB14552@mail.shareable.org> <20060318234018.GK21232@thunk.org> <20060319023610.GA4824@mail.shareable.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060319023610.GA4824@mail.shareable.org>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2006 at 02:36:10AM +0000, Jamie Lokier wrote:
> It's other programs (OpenOffice, etc.) which are being used just
> before the power cut.  If the programs which run just before the power
> cut do the above (writing then renaming), then they're fine, but many
> programs don't do that.
> 
> Now, to be fair, most programs don't overwrite data blocks in place either.
> 
> They usually open files with O_TRUNC to write with new contents.  How
> does that work out with/without Badari's patch?  Is that safe in the
> same way as creating new files and appending to them is?

The competently written ones don't open files with O_TRUNC; they will
create a temp. file, write to the temp. file, and then rename file
once it is fully written to the original file, just like rsync does.

This is important, given that many developers (especially kernel
developers) like to use hard link farms to minimize space, and if you
just O_TRUNC the existing file, then the change will be visible in all
of the directories.  If instead the editor (or openoffice, etc.)
writes to a temp file and then renames, then it breaks the hard link
with COW semantics, which is what you want --- and in practice,
everyone using (or was using) bk, git, and mercurial use hard-linked
directories and it works just fine.

But yes, using O_TRUNC works just fine with and without Badari's
patch, because allocating new data blocks to a old file that is
truncated is exactly the same as appending new data blocks to a new
file.

> Or does O_TRUNC mean that the old data blocks might be released and
> assigned to other files, before this file's metadata is committed,
> opening a security hole where reading this file after a restart might
> read blocks belonging to another, unrelated file?

No, not in journal=ordered mode, since the data blocks are forced to
disk before the metadata is committed.  Opening with O_TRUNC is
metadata operation, and allocating new blocks after O_TRUNC is also a
metadata operation, and in data=journaled mode, blocks are written out
before the metadata is forced out.

> It's this: you edit a source file with your favourite editor, and save
> it.  3 seconds later, there's a power cut.  The next day, power comes
> back and you've forgotten that you edited this file.

Again, *my* favorite editor saves the file to a newly created file,
#filename, and once it is done writing the new file, renames filename
to filename~, and finally renames #filename to filename.  This means
that we don't have to worry about your power cut scenario, and it also
means that hard-link farms have the proper COW semantics.

> However, all of the above examples really depend on what happens with
> O_TRUNC, because in practice all editors etc. that are likely to be
> used, use that if they don't do write-then-rename.

O_TRUNC is a bad idea, because it means if the editor crashes, or
computer crashes, or the fileserver crashes, the original file is
*G*O*N*E*.  So only silly/stupidly written editors use O_TRUNC; if
yours does, abandon it in favor of another editor, or one day you'll
be really sorry.  It's much, much, safer to do write-then-rename

						- Ted
