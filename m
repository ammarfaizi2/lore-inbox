Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVGBKD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVGBKD2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 06:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVGBKD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 06:03:28 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50353 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261411AbVGBKDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 06:03:22 -0400
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: ericvh@gmail.com, akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org, frankvm@frankvm.com,
       v9fs-developer@lists.sourceforge.net
Subject: Re: FUSE merging?
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu>
	<E1DoF86-0002Kk-00@dorka.pomaz.szeredi.hu>
	<20050630235059.0b7be3de.akpm@osdl.org>
	<E1DoFcK-0002Ox-00@dorka.pomaz.szeredi.hu>
	<20050701001439.63987939.akpm@osdl.org>
	<E1DoG6p-0002Rf-00@dorka.pomaz.szeredi.hu>
	<20050701010229.4214f04e.akpm@osdl.org>
	<E1DoIUz-0002a5-00@dorka.pomaz.szeredi.hu>
	<a4e6962a050701062136435471@mail.gmail.com>
	<E1DoLxK-0002ua-00@dorka.pomaz.szeredi.hu>
	<a4e6962a05070107183862ed22@mail.gmail.com>
	<E1DoMYJ-0002ya-00@dorka.pomaz.szeredi.hu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 02 Jul 2005 04:01:45 -0600
In-Reply-To: <E1DoMYJ-0002ya-00@dorka.pomaz.szeredi.hu> (Miklos Szeredi's
 message of "Fri, 01 Jul 2005 16:31:35 +0200")
Message-ID: <m1acl5frw6.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> writes:

>> > What would people say if ext3 was always mounted locally through NFS,
>> > because the kernel would only provide the NFS filesystem client.
>> 
>> Probably the same thing they would say if ext3 was a user-space
>> application that always needed to be mounted via FUSE ;)
>
> Yes, and rightly.
>
> One of the misunderstandings about userspace filesystems (Linus falls
> into this) is to compare it with microkernels.
>
> FUSE (and userspace filesystems in general) are NOT meant to replace
> in kernel filesystems or the VFS.  They are an addition with which
> different kinds of filesystems can be implemented much better than
> they could be in kernel.

Taking a quick glance at v9fs and fuse I fail to see how either
plays nicely with the page cache.

v9fs according to my reading of the protocol specification does
not have any concept of a lease.  So you can't tell if you are
talking about a virtual filesystem where all calls should be passed
straight to the server or a real filesystem where you can perform
caching.  The implementation simply appears to bypass the pagecache
which seems sane.

Skimming through the FUSE code I see the same problem, in that you can't
autodetect the right thing.  This is currently hacked around with
"direct_io" mount option selecting between a cached and a non-cached
status on a filesystem basis at mount time.  But having
a per file flag would be nicer.  I also don't understand
why in fuse direct_io is an if statement in fuse_file_read/write
instead of simply being a different set of filesystem operations.

Neither implementation seems to forward user space locks to the
filesystem server.

Eric
