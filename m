Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265641AbUBJFrn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 00:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265643AbUBJFrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 00:47:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:51908 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265641AbUBJFrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 00:47:41 -0500
Date: Mon, 9 Feb 2004 21:50:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: 4.1GB limit with nfs3, 2.6 & knfsd?
Message-Id: <20040209215020.60cf2f93.akpm@osdl.org>
In-Reply-To: <20040210043926.GG18674@srv-lnx2600.matchmail.com>
References: <20040210043926.GG18674@srv-lnx2600.matchmail.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> wrote:
>
> Hi,
> 
> I was trying to tar and bzip2 some directories over the weekend and I think
> I may have found a bug.
> 
> The operation would consistantly fail when the bzip2ed tar file hit 4.1GB
> when directed at a 2.6.1-bk2-nfs-stale-file-handles knfsd server from
> another computer running the same kernel.
> 
> If I try the operation against a local filesystem, or a 2.4.24 knfsd server
> on the network there are no failures and the file is at 18GB and growing on
> the local filesystem (not enough space on the 2.4 server...).
> 
> This is all from the same nfs client computer.
> 
> I plan on doing some more tests with dd and cat against the server after the
> files have finished compressing.
> 
> Anyone have any ideas?  I know this could be userspace, but why does it work
> against a 2.4 knfsd and on the local filesystem?

Yes, something funny does seem to be happening.

I have a simple NFS mount of an ext2 filesystem via localhost and a 6GB
`dd' fails after 4G:

vmm:/mnt/localhost> strace dd if=/dev/zero of=foo bs=1M count=6000
...
write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1048576) = 1048576
read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1048576) = 1048576
write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1048576) = 1048576
read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1048576) = 1048576
write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1048576) = -1 EINVAL (Invalid argument)

vmm:/mnt/localhost> ls -l foo                                     
-rw-r--r--    1 akpm     akpm     4296015872 Feb  9 21:36 foo

But after that, one can continue to grow the file:

vmm:/mnt/localhost> cat /dev/zero >> foo
^C
vmm:/mnt/localhost> ls -l foo           
-rw-r--r--    1 akpm     akpm     4573638656 Feb  9 21:48 foo

Maybe Neil can shed some light?
