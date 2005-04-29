Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262770AbVD2Ook@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbVD2Ook (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 10:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262755AbVD2Ooa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 10:44:30 -0400
Received: from mail.shareable.org ([81.29.64.88]:7083 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S262762AbVD2OnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 10:43:21 -0400
Date: Fri, 29 Apr 2005 15:42:52 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linuxram@us.ibm.com, ericvh@gmail.com, pavel@ucw.cz,
       viro@parcelfarce.linux.theplanet.co.uk, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050429144252.GA17263@mail.shareable.org>
References: <20050425152049.GB2508@elf.ucw.cz> <20050425190734.GB28294@mail.shareable.org> <20050426092924.GA4175@elf.ucw.cz> <20050426140715.GA10833@mail.shareable.org> <a4e6962a050428064774e88f4a@mail.gmail.com> <20050428192048.GA2895@mail.shareable.org> <1114717183.4180.718.camel@localhost> <20050428220839.GA5183@mail.shareable.org> <1114761430.4180.1566.camel@localhost> <E1DRWEt-000149-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DRWEt-000149-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> Removing the check makes chroot enter the tree under the other
> process's namespace.  However it does not actually change the
> namespace, hence mount/umount won't work.
> 
> So joinig a namespace does need a new syscall unfortunately.

It would be trivial to copy mnt->mnt_namespace to current->namespace
in set_fs_root.  No need for a syscall just for that.

Given that it works, the right place to decide whether it's allowed is
the permissions on /proc/NNN/root.  But remember that you can already
access another process' namespace using ptrace on that process, so
this doesn't relax security if /proc/NNN/root can be entered whenever
ptrace is allowed.

I would really like to know what the purpose of check_mnt() is in
namespace.c.  In standard kernels you can't enter another process'
namespace (without the change you tried in proc/base.c), so I don't see
how check_mnt() can _ever_ fail.  Can it?

And if it can't fail, is there any need for current->namespace, or can
it just be removed?

-- Jamie
