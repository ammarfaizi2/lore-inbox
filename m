Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266678AbUF3OVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266678AbUF3OVN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 10:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266679AbUF3OVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 10:21:13 -0400
Received: from pop.gmx.de ([213.165.64.20]:34715 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266678AbUF3OVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 10:21:08 -0400
Date: Wed, 30 Jun 2004 16:21:06 +0200 (MEST)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: Jacky Malcles <Jacky.Malcles@bull.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <40E2C888.BB5BB7F1@bull.net>
Subject: Re: A question about extended attributes of filesystem objects (setfattr command)
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <30493.1088605266@www51.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Salut Jacky,

> > > I have a question regarding
> > >  Attributes of symlinks vs. the files pointed to
> > >
> > > If I try to attach name:value pair to object symlink file
> > > then I'll get: "Operation not permitted"
> > 
> > What file system are you using?  If ext2, ext3 (or patched kernel
> > supporting Reiserfs EAs), did you mount with "-o user_xattr?
> > (The above error suggests you haven't used this option.)
> 
> # mount
> /dev/sdb3 on /a type ext3 (rw,acl,user_xattr)
> ...etc...

Okay.

> > > reading the man pages of setfattr (or attr) I thought that it operates
> > > on the attributes of  the  symbolic link itself.
> > 
> > No, these commands follow symbolic links.
> > 
> > > show:
> > > -----
> > > touch f
> > > ln -s f l
> > > setfattr -n user.filename -v ascii1 f l
> > > setfattr -h -n user.filename  -v ascii2 f
> > > getfattr -d f l
> > > setfattr -h -n user.filename  -v ascii3 l
> > > setfattr -h --no-dereference -n user.filename  -v ascii4 l

I'm sorry -- I missed the above "--no-dereference"; that's why
my point below becomes relevant.

> > > getfattr -d f l
> > >
> > > so, my question is : what is expected ?
> should have added this:
> 
> [root@t20 acl]# show
> # file: f
> user.filename="ascii2"
> 
> # file: l
> user.filename="ascii2"
> 
> setfattr: l: Operation not permitted
> setfattr: l: Operation not permitted
> # file: f
> user.filename="ascii2"
> 
> # file: l
> user.filename="ascii2"
> 
> [root@t20 acl]#

But note the following:

> > attr(5) specifically notes that USER EAs are disallowed on
> > symbolic links, but this is rather an issu that affects the
> > use of lsetxattr(2).

or setfattr if you specify "--no-dereference"...

There is a reason for this restriction: for a symbolic link, all 
permissions are enabled for all users, and these permissions 
cannot be changed. This means that permissions cannot be used (as 
they would be with regular files) to prevent arbitrary users from 
placing user EAs on a symbolic link.  Thus all users are 
prevented from creating user EAs on the symbolic link.

Michael


-- 
+++ Jetzt WLAN-Router für alle DSL-Einsteiger und Wechsler +++
GMX DSL-Powertarife zudem 3 Monate gratis* http://www.gmx.net/dsl

