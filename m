Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262229AbVCBIyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262229AbVCBIyU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 03:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262230AbVCBIyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 03:54:20 -0500
Received: from fire.osdl.org ([65.172.181.4]:63143 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262229AbVCBIyM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 03:54:12 -0500
Date: Wed, 2 Mar 2005 00:53:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: =?ISO-8859-1?B?QXVy6WxpZW4=?= Francillon <aurel@naurel.org>
Cc: linux-kernel@vger.kernel.org, Andreas Gruenbacher <agruen@suse.de>
Subject: Re: 2.6.11-rc5-mm1
Message-Id: <20050302005344.1c3420db.akpm@osdl.org>
In-Reply-To: <4224A905.7060801@naurel.org>
References: <20050301012741.1d791cd2.akpm@osdl.org>
	<4224A905.7060801@naurel.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aurélien Francillon <aurel@naurel.org> wrote:
>
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc5/2.6.11-rc5-mm1/
> > 
> > 
> > - Lots of tuning/balancing changes in the CPU scheduler.  Mainly targetted
> >   at larger SMT/SMP/NUMA machines.  It's going to be hard to work out whether
> >   these are a net benefit.
> > 
> > - A pcmcia update which obsoletes cardmgr (although cardmgr still works) and
> >   makes pcmcia work more like regular hotpluggable devices.  See the
> >   changelong in pcmcia-dont-send-eject-request-events-to-userspace.patch for
> >   details.
> > 
> > - A new reiser4 code drop.
> > 
> > - A new rev of the NFS ACL code.
> 
> hi,
> I have a strange bug with nfs,
> this happens on the 2.6.11-rc5-mm1 and i have no problems with 2.6.11-rc5.
> 
> i have a cvsroot exported over nfs on a server running a fedora core
> kernel (kernel-2.6.5-1.358) and i use it from a notebook. With linus
> kernel no problem, but with mm i have the following error :
> 
> cvs diff Makefile 
>              cvs diff: cannot create read lock in repository 
> `/mnt/iseran/roca/cvsroot/ldpc': No such file or directory
> cvs [diff aborted]: read lock failed - giving up
> 
> but the file is created and i can "cat " it without problem ...
> 
> strace gives me :
> 
> with  2.6.11-rc5-mm1:
> open("/mnt/iseran/roca/cvsroot/ldpc/#cvs.rfl.vanua.6860",O_RDWR|O_CREAT|O_TRUNC, 
> 0666) = -1 ENOENT (No such file or directory)
> 
> with 2.6.11-rc5 kernel:
> open("/mnt/iseran/roca/cvsroot/ldpc/#cvs.rfl.vanua.14403", 
> O_RDWR|O_CREAT|O_TRUNC, 0666) = 3
> close(3)
> 
> 
> nfs is configured without acl in the .config
> and AFAK the server neither uses them
> 

Nice report, thanks.

I can reproduce the problem here.  Simple testcase:

main()
{
	int fd;

	fd = open("a", O_RDWR|O_CREAT|O_TRUNC, 0666);
	if (fd < 0)
		perror("open");
	exit(0);
}

The same happens with CONFIG_NFS_ACL=y.

Binary searching shwos that the bug was introduced by
nfsacl-acl-umask-handling-workaround-in-nfs-client.patch

