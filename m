Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbTKTTJM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 14:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbTKTTJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 14:09:12 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:19183 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S262864AbTKTTJI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 14:09:08 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: OT: why no file copy() libc/syscall ??
Date: Thu, 20 Nov 2003 13:08:17 -0600
X-Mailer: KMail [version 1.2]
Cc: Valdis.Kletnieks@vt.edu, Daniel Gryniewicz <dang@fprintf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1068512710.722.161.camel@cube> <03111209360001.11900@tabby> <20031120172143.GA7390@deneb.enyo.de>
In-Reply-To: <20031120172143.GA7390@deneb.enyo.de>
MIME-Version: 1.0
Message-Id: <03112013081700.27566@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 November 2003 11:21, Florian Weimer wrote:
> Jesse Pollard wrote:
> > > > 	int sys_copy(int fd_src, int fd_dst)
> > >
> > > Doesn't work.  You have to set the security attributes while you open
> > > fd_dst.
> >
> > Why? the open for fd_src should have the security attributes (both
> > locally and in the file server if networked). Opening fd_dst should SET
> > the security attributes desired (again, locally and in the target
> > fileserver).
>
> The default attributes in the new location might be less strict than the
> attributes of the source file.

So what. the user was authorized to open the input file. The user was
authorized to open the output file. A file copy should be possible remotely
since the equivalent implementation of a local read/write loop would
accomplish the same thing.

> If sys_copy() is just an API to introduce a new copy-on-write hard link,
> these problems disappear.  They are only relevant if sys_copy() is
> intended to be a generic "copy that file" interface.

Now if you wanted the remote server to deny the network copy... could
be done - after all the credentials for both input and output files
are present on the server. If the server decides NOT to copy, then fine.
It would just cause the user to make the copy with a read/write loop.

I was only thinking of it as a way to gain access to any filesystem
support that may be available for copying files. If none is available,
then do it in user mode.

Personally, I'm not sure it is a good idea, partly because the semantics
of a file copy operation are not well defined (some of the following IS 
known).

1. what happens if the copy is aborted?
2. what happens if the network drops while the remote server continues?
3. what about buffer synchronization?
4. what errors should be reported ?
5. what happens when the syscall is interupted? Especially if the remote
   copy may take a while (I've seen some require an hour or more - worst
   case: days due to a media error (completed after the disk was replaced)).
6. what about a client opening the copy before it is finished copying?
