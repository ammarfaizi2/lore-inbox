Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030281AbWBUOAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbWBUOAN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 09:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030316AbWBUOAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 09:00:12 -0500
Received: from pat.uio.no ([129.240.130.16]:1931 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030281AbWBUOAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 09:00:10 -0500
Subject: Re: FMODE_EXEC or alike?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: Oleg Drokin <green@linuxhacker.ru>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20060220215122.7aa8bbe5.akpm@osdl.org>
References: <20060220221948.GC5733@linuxhacker.ru>
	 <20060220215122.7aa8bbe5.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 21 Feb 2006 08:59:56 -0500
Message-Id: <1140530396.7864.63.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.699, required 12,
	autolearn=disabled, AWL 1.11, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-20 at 21:51 -0800, Andrew Morton wrote:
> Oleg Drokin <green@linuxhacker.ru> wrote:
> >
> > Hello!
> > 
> >    We are working on a lustre client that would not require any patches
> >    to linux kernel. And there are few things that would be nice to have
> >    that I'd like your input on.
> > 
> >    One of those is FMODE_EXEC - to correctly detect cross-node situations with
> >    executing a file that is opened for write or the other way around, we need
> >    something like this extra file mode to be present (and used as a file open
> >    mode when opening files for exection, e.g. in fs/exec.c)
> >    Do you think there is a chance this can be included into vanilla kernel,
> >    or is there a better solution I oversee?
> >    I am just thinking about something as simple as this
> >    (with some suitable FMODE_EXEC define, of course):
> > 
> > --- linux/fs/exec.c.orig	2006-02-21 00:11:47.000000000 +0200
> > +++ linux/fs/exec.c	2006-02-21 00:12:24.000000000 +0200
> > @@ -127,7 +127,7 @@ asmlinkage long sys_uselib(const char __
> >  	struct nameidata nd;
> >  	int error;
> >  
> > -	error = __user_path_lookup_open(library, LOOKUP_FOLLOW, &nd, FMODE_READ);
> > +	error = __user_path_lookup_open(library, LOOKUP_FOLLOW, &nd, FMODE_READ|FMODE_EXEC);
> >  	if (error)
> >  		goto out;
> >  
> > @@ -477,7 +477,7 @@ struct file *open_exec(const char *name)
> >  	int err;
> >  	struct file *file;
> >  
> > -	err = path_lookup_open(name, LOOKUP_FOLLOW, &nd, FMODE_READ);
> > +	err = path_lookup_open(name, LOOKUP_FOLLOW, &nd, FMODE_READ|FMODE_EXEC);
> >  	file = ERR_PTR(err);
> >  
> >  	if (!err) {
> > 
> 
> Such a patch would have zero runtime cost.  I'd have no problem carrying
> that if it makes things easier for lustre, personally.
> 
> We would need to understand whether this is needed by other distributed
> filesystems and if so, whether the proposed implementation is suitable and
> sufficient.

Hmm.... We might possibly want to use that for NFSv4 at some point in
order to deny write access to the file to other clients while it is in
use.

Cheers
  Trond

