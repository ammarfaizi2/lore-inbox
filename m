Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262842AbVDHNU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262842AbVDHNU3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 09:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262812AbVDHNSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 09:18:33 -0400
Received: from pat.uio.no ([129.240.130.16]:3292 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262820AbVDHNLm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 09:11:42 -0400
Subject: Re: [PATCH] mtime attribute is not being updated on client
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: linda.dunaphant@ccur.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1112921570.6182.16.camel@lindad>
References: <1112921570.6182.16.camel@lindad>
Content-Type: text/plain
Date: Fri, 08 Apr 2005 09:11:12 -0400
Message-Id: <1112965872.15565.34.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.46, required 12,
	autolearn=disabled, AWL 1.49, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 07.04.2005 Klokka 20:52 (-0400) skreiv Linda Dunaphant:
> Hi Trond,
>  
> The acregmin (default=3) and acregmax (default=60) NFS attributes that
> control the min and max attribute cache lifetimes don't appear to be
> working after the first few timeouts. Using a test program that loops
> on the following sequence:
>         - write to a file on an NFS3 mounted filesystem from the client
>         - sleep for one second
>         - stat the file to get the mtime
> you see the mtime change once after ~56 seconds, but no further mtime
> changes are detected by the test.
>  
> nfs_refresh_inode() currently bypasses the inode vs fattr mtime comparison
> if data_unstable is true. At the end of nfs_refresh_inode(), it resets the
> attribute timer. Since nfs_refresh_inode() is being called after every
> write to the server (which occurs more often than the attribute timer is
> set to expire), the attribute timer never expires again for this file past
> the ~56 sec point.
>  
> In nfs_refresh_inode() I believe the mtime comparison should be moved outside
> the check for data_unstable. The server might already have a newer value for
> mtime than the value on the client. With this change, the test sees the mtime
> change after each write completes on the server.
>  
> Regards,
> Linda

Hi Linda,

 I'm a bit unclear as to what your end-goal is here. Is it basically to
ensure that fstat() always return the correct value for the mtime?

 The reason I ask is that I think your change is likely to have nasty
consequences for the general performance in a lot of other syscalls that
use nfs_revalidate_inode(). I would expect a particularly nasty hit in
the of the write() syscalls themselves, and they really shouldn't have
to worry about the value of mtime in the close-to-open cache consistency
model.
I therefore think we should look for a more fine-grained solution that
addresses more precisely the issues you see.

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

