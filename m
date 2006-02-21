Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932733AbWBUOnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932733AbWBUOnH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 09:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbWBUOnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 09:43:07 -0500
Received: from pat.uio.no ([129.240.130.16]:12266 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932474AbWBUOnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 09:43:05 -0500
Subject: Re: FMODE_EXEC or alike?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Antonio Vargas <windenntw@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Oleg Drokin <green@linuxhacker.ru>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <69304d110602210615m491829ccx9ba84edc8dafe1f7@mail.gmail.com>
References: <20060220221948.GC5733@linuxhacker.ru>
	 <20060220215122.7aa8bbe5.akpm@osdl.org>
	 <1140530396.7864.63.camel@lade.trondhjem.org>
	 <69304d110602210615m491829ccx9ba84edc8dafe1f7@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 21 Feb 2006 09:42:49 -0500
Message-Id: <1140532969.7864.76.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.039, required 12,
	autolearn=disabled, AWL 1.77, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-21 at 15:15 +0100, Antonio Vargas wrote:
> On 2/21/06, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> > On Mon, 2006-02-20 at 21:51 -0800, Andrew Morton wrote:
> > > Oleg Drokin <green@linuxhacker.ru> wrote:
> > > >
> > > > Hello!
> > > >
> > > >    We are working on a lustre client that would not require any patches
> > > >    to linux kernel. And there are few things that would be nice to have
> > > >    that I'd like your input on.
> > > >
> > > >    One of those is FMODE_EXEC - to correctly detect cross-node situations with
> > > >    executing a file that is opened for write or the other way around, we need
> > > >    something like this extra file mode to be present (and used as a file open
> > > >    mode when opening files for exection, e.g. in fs/exec.c)
> > > >    Do you think there is a chance this can be included into vanilla kernel,
> > > >    or is there a better solution I oversee?
> > > >    I am just thinking about something as simple as this
> > > >    (with some suitable FMODE_EXEC define, of course):
> > > >
> > > > --- linux/fs/exec.c.orig    2006-02-21 00:11:47.000000000 +0200
> > > > +++ linux/fs/exec.c 2006-02-21 00:12:24.000000000 +0200
> > > > @@ -127,7 +127,7 @@ asmlinkage long sys_uselib(const char __
> > > >     struct nameidata nd;
> > > >     int error;
> > > >
> > > > -   error = __user_path_lookup_open(library, LOOKUP_FOLLOW, &nd, FMODE_READ);
> > > > +   error = __user_path_lookup_open(library, LOOKUP_FOLLOW, &nd, FMODE_READ|FMODE_EXEC);
> > > >     if (error)
> > > >             goto out;
> > > >
> > > > @@ -477,7 +477,7 @@ struct file *open_exec(const char *name)
> > > >     int err;
> > > >     struct file *file;
> > > >
> > > > -   err = path_lookup_open(name, LOOKUP_FOLLOW, &nd, FMODE_READ);
> > > > +   err = path_lookup_open(name, LOOKUP_FOLLOW, &nd, FMODE_READ|FMODE_EXEC);
> > > >     file = ERR_PTR(err);
> > > >
> > > >     if (!err) {
> > > >
> > >
> > > Such a patch would have zero runtime cost.  I'd have no problem carrying
> > > that if it makes things easier for lustre, personally.
> > >
> > > We would need to understand whether this is needed by other distributed
> > > filesystems and if so, whether the proposed implementation is suitable and
> > > sufficient.
> >
> > Hmm.... We might possibly want to use that for NFSv4 at some point in
> > order to deny write access to the file to other clients while it is in
> > use.
> 
> When done with regards to failing a write if anyone has mapped the
> file for executing it, or failing the execute if it's open/mmaped for
> write, I can't really see the difference between local, remote and
> clustered filesystems...

There is a huge difference.

On local filesystems, get_write_access(), put_write_access() and
deny_write_access() may be sufficient, but for remote and clustered
filesystems you need for the filesystem itself to be able to enforce the
lock to remote writers.

NFSv2 and NFSv3 don't actually have any form of mandatory locking we can
use, but NFSv4 has CIFS-like deny bits that can be used in the OPEN call
to deny remote write access.

Cheers
  Trond

