Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965083AbWHOAJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbWHOAJv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 20:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbWHOAJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 20:09:51 -0400
Received: from smtp-out.google.com ([216.239.45.12]:43279 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S965083AbWHOAJu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 20:09:50 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=hIXuyW1HCiBDJZZwj0H/u9gv8s5J+Y76bd1nYNMf6Y0sl1f5w/yicZyqaNYABPFBP
	1Q/317yG5fkADaxEEeBOQ==
Message-ID: <e561bacc0608141709o61294e24o6d920279e721bbf4@mail.google.com>
Date: Mon, 14 Aug 2006 20:09:14 -0400
From: "Alex Polvi" <polvi@google.com>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Subject: Re: [PATCHv3] sunrpc/auth_gss: NULL pointer deref in gss_pipe_release()
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1155595592.5656.22.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e561bacc0607310750p2cba1576m6564a356b94dd26c@mail.google.com>
	 <1154378242.13744.14.camel@localhost>
	 <e561bacc0608090827m45fc8f2fia02589be4efce178@mail.google.com>
	 <1155137983.5731.95.camel@localhost>
	 <e561bacc0608141232h164f86e2ub2a53061b52d1120@mail.google.com>
	 <e561bacc0608141334i2a942ff5ua97b8c8db381fca1@mail.google.com>
	 <1155595592.5656.22.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/06, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> On Mon, 2006-08-14 at 16:34 -0400, Alex Polvi wrote:
> > On 8/14/06, Alex Polvi <polvi@google.com> wrote:
> > > Here is another fix. It is quite silly, but clnt->cl_auth is set to
> > > NULL in rpc_destroy_client(), then eventually referenced in
> > > gss_release_pipe() via rpc_rmdir(). Simply removing the clnt->cl_auth
> > > = NULL from clnt.c fixes the issue. I'm still trying to understand the
> > > subsystem, but it seems like rpc_rmdir is being correctly called to
> > > clean up because of the weirdness with umount -l and the nfs server
> > > being turned on and off. Does that seem correct? Or is this still just
> > > covering up some other part of the code being sloppy cleaning up?
> >
> > Also, I just want to make it clear that I do not think this is the
> > proper fix. It is just pointing out that we intentionally set cl_auth
> > to NULL, then reference it.
>
> OK. I think I've finally managed to clean up the various interactions
> with rpc_pipefs. I've uploaded a series of patches on the NFS client
> website. See
>
>   http://client.linux-nfs.org/Linux-2.6.x/2.6.18-rc4/
>
> The relevant patches are
>
> linux-2.6.18-006-fix_rpc_unlink.dif:
>
>         From: Trond Myklebust <Trond.Myklebust@netapp.com>
>
>         SUNRPC: make rpc_unlink() take a dentry argument instead of a
>         path
>
>         Signe-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
>
> linux-2.6.18-007-fix_rpc_rmdir.dif:
>
>         From: Trond Myklebust <Trond.Myklebust@netapp.com>
>
>         NFS: clean up rpc_rmdir
>
>         Make it take a dentry argument instead of a path
>
>         Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
>
> linux-2.6.18-008-fix_rpc_unlink_rmdir_2.dif:
>
>         From: Trond Myklebust <Trond.Myklebust@netapp.com>
>
>         SUNRPC: rpc_unlink() must check for unhashed dentries
>
>         A prior call to rpc_depopulate() by rpc_rmdir() on the parent
>         directory may have already called simple_unlink() on this entry.
>         Add the same check to rpc_rmdir(). Also remove a redundant call
>         to rpc_close_pipes() in rpc_rmdir.
>
>         Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
>
> linux-2.6.18-009-fix_rpc_unlink_rmdir_3.dif:
>
>         From: Trond Myklebust <Trond.Myklebust@netapp.com>
>
>         SUNRPC: Fix dentry refcounting issues with users of rpc_pipefs
>
>         rpc_unlink() and rpc_rmdir() will dput the dentry reference for
>         you.
>
>         Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

Wooohooooo!!!! I can confirm that it fixes my testcase. I'll let you
know if I run into any problems.

Thanks again for all your help figuring this one out!

-Alex
