Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266508AbUBLXA1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 18:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266650AbUBLXA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 18:00:26 -0500
Received: from mail.inter-page.com ([12.5.23.93]:56583 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S266508AbUBLXAQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 18:00:16 -0500
From: "Robert White" <rwhite@casabyte.com>
To: "'Theodore Ts'o'" <tytso@mit.edu>, "'Pavel Machek'" <pavel@ucw.cz>
Cc: "'the grugq'" <grugq@hcunix.net>, <linux-kernel@vger.kernel.org>
Subject: RE: PATCH - ext2fs privacy (i.e. secure deletion) patch
Date: Thu, 12 Feb 2004 14:59:55 -0800
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAiYFsPtMTN0OBYHMfkO9ONQEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <20040204062936.GA2663@thunk.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At which point, in the presence of the theoretical mount option, it becomes
easy to reduce the work load to "a long list of block operations" by making
the shredding unconditional.

That is, instead of thinking of it as shredding a file, the (arbitrarily
named) "zerofree" mount option is passed and every block that is released
from active file system use is zeroed.  E.g. file blocks, directory blocks,
attribute blocks, everything.  That just takes (at the worst) a list/queue
and a block-write of a block-sized page containing all zeros (or, better
yet, an optionally-user-supplied squeegee pattern.)  So take/make the
free_block() routine and make it submit a "dirty block" to the I/O buffering
system.  If the block is immediately re-used then even the write expense
amortizes to near zero for clearing that block (or unwritten fragment).

The down side of the simple form comes up when the user unlinks that 20 gig
file.

And of course there is no such thing as un-erase for such a media.

On the more positive side this would be _*outstanding*_ for my NV-RAM
keychain drive where the files are warranted to be small and I don't want
some random person who finds my lost keychain even able to guess about that
pesky project I was working on last month.

Meh... 8-)

Rob.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Theodore Ts'o
Sent: Tuesday, February 03, 2004 10:30 PM
To: Pavel Machek
Cc: the grugq; linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch

On Wed, Feb 04, 2004 at 01:43:18AM +0100, Pavel Machek wrote:
> > All that said, the user's content is something that the user could be 
> > considered responsible for erasing themselves. The meta-data is the part

> > of the file which they dont' have access to, so having privacy 
> > capabilities for meta-data erasure is a requirement. User data 
> > erasure... I can take it or leave it. I think it should be automatic if 
> > at all, but I'm not really that bothered about it.
> 
> Well, doing it on-demand means one less config option, and possibility
> to include it into 2.7... It should be easy to have tiny patch forcing
> that option always own for your use...

The obvious thing to do would be to make it a mount option, so that
(a) recompilation is not necessary in order to use the feature, and
(b) the feature can be turned on or off on a per-filesystem feature.
In 2.6, it's possible to specify certain mount option to be specifed
by default on a per-filesystem basis (via a new field in the
superblock).  

So if you do things that way, then secure deletion would take place
either if the secure deletion flag is set (so it can be enabled on a
per-file basis), or if the filesystem is mounted with the
secure-deletion mount option.  

					- Ted
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


