Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161229AbWBUOP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161229AbWBUOP5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 09:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161234AbWBUOP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 09:15:57 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:45959 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161226AbWBUOPz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 09:15:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L73YNhxEIhHL3xPBs0jjIlyLPVd7nyTQSG+BKzV3mGwxn8Ba1Qc/rauEb42fY1WMZV3hzjET//1Dy65KqtsbuafO6k8u+GXQY4aABNdA2z9WF5wqSHnq6qwbYWjuM+cp1gn8VZqI+KhT+goTvPrnCkkfksVUH27pZiQDEzMIsUA=
Message-ID: <69304d110602210615m491829ccx9ba84edc8dafe1f7@mail.gmail.com>
Date: Tue, 21 Feb 2006 15:15:53 +0100
From: "Antonio Vargas" <windenntw@gmail.com>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>,
       "Andrew Morton" <akpm@osdl.org>, "Oleg Drokin" <green@linuxhacker.ru>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: FMODE_EXEC or alike?
In-Reply-To: <1140530396.7864.63.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060220221948.GC5733@linuxhacker.ru>
	 <20060220215122.7aa8bbe5.akpm@osdl.org>
	 <1140530396.7864.63.camel@lade.trondhjem.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/06, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> On Mon, 2006-02-20 at 21:51 -0800, Andrew Morton wrote:
> > Oleg Drokin <green@linuxhacker.ru> wrote:
> > >
> > > Hello!
> > >
> > >    We are working on a lustre client that would not require any patches
> > >    to linux kernel. And there are few things that would be nice to have
> > >    that I'd like your input on.
> > >
> > >    One of those is FMODE_EXEC - to correctly detect cross-node situations with
> > >    executing a file that is opened for write or the other way around, we need
> > >    something like this extra file mode to be present (and used as a file open
> > >    mode when opening files for exection, e.g. in fs/exec.c)
> > >    Do you think there is a chance this can be included into vanilla kernel,
> > >    or is there a better solution I oversee?
> > >    I am just thinking about something as simple as this
> > >    (with some suitable FMODE_EXEC define, of course):
> > >
> > > --- linux/fs/exec.c.orig    2006-02-21 00:11:47.000000000 +0200
> > > +++ linux/fs/exec.c 2006-02-21 00:12:24.000000000 +0200
> > > @@ -127,7 +127,7 @@ asmlinkage long sys_uselib(const char __
> > >     struct nameidata nd;
> > >     int error;
> > >
> > > -   error = __user_path_lookup_open(library, LOOKUP_FOLLOW, &nd, FMODE_READ);
> > > +   error = __user_path_lookup_open(library, LOOKUP_FOLLOW, &nd, FMODE_READ|FMODE_EXEC);
> > >     if (error)
> > >             goto out;
> > >
> > > @@ -477,7 +477,7 @@ struct file *open_exec(const char *name)
> > >     int err;
> > >     struct file *file;
> > >
> > > -   err = path_lookup_open(name, LOOKUP_FOLLOW, &nd, FMODE_READ);
> > > +   err = path_lookup_open(name, LOOKUP_FOLLOW, &nd, FMODE_READ|FMODE_EXEC);
> > >     file = ERR_PTR(err);
> > >
> > >     if (!err) {
> > >
> >
> > Such a patch would have zero runtime cost.  I'd have no problem carrying
> > that if it makes things easier for lustre, personally.
> >
> > We would need to understand whether this is needed by other distributed
> > filesystems and if so, whether the proposed implementation is suitable and
> > sufficient.
>
> Hmm.... We might possibly want to use that for NFSv4 at some point in
> order to deny write access to the file to other clients while it is in
> use.

When done with regards to failing a write if anyone has mapped the
file for executing it, or failing the execute if it's open/mmaped for
write, I can't really see the difference between local, remote and
clustered filesystems...

--
Greetz, Antonio Vargas aka winden of network

http://wind.codepixel.com/
windNOenSPAMntw@gmail.com
thesameasabove@amigascne.org

Every day, every year
you have to work
you have to study
you have to scene.
