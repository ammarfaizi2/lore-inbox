Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbUCCFfu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 00:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbUCCFfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 00:35:50 -0500
Received: from adsl-186.flex.com ([206.126.1.185]:11904 "EHLO mail.imodulo.com")
	by vger.kernel.org with ESMTP id S261684AbUCCFfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 00:35:48 -0500
Date: Tue, 2 Mar 2004 19:35:47 -1000
From: Glen Nakamura <glen@imodulo.com>
To: James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mysterious string truncation in 2.4.25 kernel
Message-ID: <20040303053547.GA3160@modulo.internal>
References: <20040302235353.GA4215@modulo.internal> <Xine.LNX.4.44.0403022302030.31759-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0403022302030.31759-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2004 at 11:03:15PM -0500, James Morris wrote:
> I don't see how the patch could be related to the problem you are seeing.  

Thanks for the response...  I took another look and my current theory is
that the problem occurs in the following invocation of do_mount:

void __init mount_devfs_fs (void)
{
    int err;
                                                                                
    if ( !(boot_options & OPTION_MOUNT) ) return;
    if (err == 0) printk (KERN_INFO "Mounted devfs on /dev\n");
    else PRINTK ("(): unable to mount devfs, err: %d\n", err);
}   /*  End Function mount_devfs_fs  */

This call to do_mount is on line 3552 of fs/devfs/base.c and passes a const
string as the data_page parameter.  Then in do_mount in fs/namespace.c on
line 718:

	if (data_page)
		((char *)data_page)[PAGE_SIZE - 1] = 0;

The above statement zeros a byte that is out of bounds and corrupts another
string in the same section of memory.  In my build, this happens to truncate
the "serial" string to "se".

So is it really safe to simply zero the byte at [PAGE_SIZE - 1]?
The comment says "up to PAGE_SIZE-1 bytes", _not_ "exactly PAGE_SIZE-1 bytes".
It doesn't mention anything about padding, etc.

Of course, perhaps 0 should passed instead of "" for data_page?

-    err = do_mount ("none", "/dev", "devfs", 0, "");
+    err = do_mount ("none", "/dev", "devfs", 0, 0);

Comments?

- glen
