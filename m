Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264839AbUEJPzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264839AbUEJPzm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 11:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264836AbUEJPzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 11:55:42 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:6804 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264822AbUEJPzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 11:55:37 -0400
Date: Mon, 10 May 2004 17:53:59 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, Jamie Lokier <jamie@shareable.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: [ANNOUNCEMENT PATCH COW] proof of concept impementation of cowlinks
Message-ID: <20040510155359.GB16182@wohnheim.fh-wedel.de>
References: <20040506131731.GA7930@wohnheim.fh-wedel.de> <20040508224835.GE29255@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040508224835.GE29255@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 May 2004 00:48:35 +0200, Pavel Machek wrote:
> 
> > Couldn't sleep last night and finished a first complete version of
> > cowlinks, code-named MAD COW.  It is still based on the stupid old
> > design with a flag to distinguish between regular hard links and
> > cowlinks.  Please don't comment on that design, it's just a proof of
> > concept.
> 
> > Patches are against 2.6.5 but most things should apply to other 2.6
> > kernel without too much trouble.
> > 
> > 1 generic_sendpage	- allow sendfile with ext[23] files as target
> > 2 sendfile		- introduce vfs_sendfile for in-kernel use
> > 3 copyfile		- new copyfile() system call
> 
> Well, up to "3" it seems usefull on its own. You might attempt to
> merge that.

True.  Right now I'm just lazy and prefer to keep them under my
control.  Maybe if 2.7 was already opened.

> namei.c: you realy don't want to #include in the middle of .c file.

Actually, I do.  I'm still not convinced that all the low-level
read/write functions need a struct file* as an argument, that looks
like a really ugly hack to help nfs and some others.  And if those can
go, the #include will go as well.  So the ugly line serves as a
reminder for a different problem. :)

On the other hand, if you can convince me that there is no way to
avoid passing the struct file*, then I agree and the #include will
move up.

> vfs_unlink followed by BUG_ON(error)... that's definitely wrong. In
> case of disk error, you might get error on unlink; but you should not
> BUG() on that. Perhaps copyfile() should be specified as "may leave
> part of copy of target on disk in case of error"?

Yes, makes sense.  I will keep the BUG_ON for a while as a reminder to
really think through all the consequences, but most likely, I will
just follow your suggestion.

A real problem is that copyfile() has all errno's from create(),
sendfile() and unlink() combined, which doesn't make error handling in
userspace easy.  "It could be this, that or another error" is the kind
of mess I always hated about Windows, so I should try to do a little
better.

Jörn

-- 
It's not whether you win or lose, it's how you place the blame.
-- unknown
