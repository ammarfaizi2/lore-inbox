Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbTDJATp (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 20:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263966AbTDJATo (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 20:19:44 -0400
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:34526 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP id S263962AbTDJATn (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 20:19:43 -0400
Message-ID: <20030410003116.9596.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Clayton Weaver" <cgweav@email.com>
To: wa@almesberger.net
Cc: linux-kernel@vger.kernel.org
Date: Wed, 09 Apr 2003 19:31:16 -0500
Subject: Re: [PATCH] new syscall: flink
X-Originating-Ip: 172.200.16.65
X-Originating-Server: ws3-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: Werner Almesberger <wa@almesberger.net>
Date: Mon, 7 Apr 2003 15:43:03 -0300
To: Clayton Weaver <cgweav@email.com>
Subject: Re: [PATCH] new syscall: flink

> Clayton Weaver wrote:
> > If the client process subsequently flink()s to the inode, it is merely
> > a zerocopy file copy.

> As far as access to the data is concerned, yes. But there's also the
> location of the file. E.g. this might enable you to fill somebody
> else's quota, or, if distinct physical devices can be be covered by
> the same file system, to access a physical device that would
> otherwise not be available to you.

> Example: I write some kind of RAID mounted at /world, that contains
> my disk under /world/disk, and some Flash storage under /world/flash.
> I protect /world/flash against writes by other people. If a
> read-only FD could be turned into something writeable, some malicious
> creature could "wear out" my Flash by writing to it a lot of times.

> - Werner

I'm wondering about the semantics of the unlink
of the last directory entry and subsequent
flink(). When is the inode updated?
 
I presume that the open fd has owner and mode
information from open(), but would flink()update the inode with new owner information if the
last directory reference had already been
unlinked, and how would this interact with
owner information associated with the open fd
for subsequent file operations? Would fchmod() then succeed, even if the new process is not
owned by the original owner of the flink()ed
to inode? Are any changes to the inode data
delayed until after close()?

What about multiple flink()s before an inode
update has appeared in the filesystem?

It seems to me that "change of owner of the inode" via flink() is an issue, and application programmers that unlink the last directory reference and then pass the open fd to another process had better have no sentimental attachment to the existing access constraints on the file. flink(), close(), open() isn't exactly a difficult hoop to jump through, even if you've passed an
open fd for a read-only file (that you unlinked
any directory references to).

Regards,

Clayton Weaver
<mailto: cgweav@email.com>


-- 
_______________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

