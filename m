Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVEaU5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVEaU5b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 16:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVEaU5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 16:57:31 -0400
Received: from [194.90.237.34] ([194.90.237.34]:9920 "EHLO mtlex01.yok.mtl.com")
	by vger.kernel.org with ESMTP id S261470AbVEaU50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 16:57:26 -0400
Date: Tue, 31 May 2005 23:57:29 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Greg KH <gregkh@suse.de>, stable@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] pci-sysfs: backport fix for 2.6.11.12
Message-ID: <20050531205729.GA7921@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20050531163619.GA6711@mellanox.co.il> <20050531192349.GA21050@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050531192349.GA21050@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Greg KH <gregkh@suse.de>:
> Subject: Re: [PATCH] pci-sysfs: backport fix for 2.6.11.12
> 
> On Tue, May 31, 2005 at 07:36:19PM +0300, Michael S. Tsirkin wrote:
> > Greg, before 2.6.12, pci_write_config in pci-sysfs.c was broken, causing
> > incorrect data being written to the configuration register,
> > which in the case of my userspace driver results in system failure.
> > 
> > This has been fixed in 2.6.12-rc5:
> > 
> > http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fv2.6%2Ftesting%2Fpatch-2.6.12-rc5.bz2;z=2656
> > 
> > Would you please consider merging the fix for 2.6.11.12 as well?
> 
> Would you care to split out only the proper part for that fix?  There
> are a few different patches in that link above.

Hmm. There's also a new attribute there, that shall wait for 2.6.12.
There was a general cleanup coverting *all* direct uses of char* to
first cast to u8 *, not only in pci_write_config where it triggers
an actual bug. Do you want all that cleanup in?
I can do it, just let me know.

> > Alternatively (since there were multiple other changes in pci-sysfs.c), here's
> > a small patch to fix just this issue.
> 
> I don't think this fixes the problem properly.  Can you verify it?

I did verify it before sending :), my patch below does fix the problem.

> Also, this is only a 64bit issue, right?

No, unsigned int is 32 bit wide on all platforms with gcc,
char is signed and 8 bit wide on all platforms with gcc.
So if you have a char value with a top bit set:

char c = 0xe0;

then the following holds:

((unsigned int)c) == 0xffffffe0

> What platform are you seeing
> this on?

I use Intel x86_64.

> And, any patch that you want to propose for the -stable releases, needs
> to be sent to the stable@kernel.org email alias.
> 
> thanks,
> 
> greg k-h
> 

Okay, since its small I repost here. Let me know whether you want that or
the bigger cleanup backported 2.6.12.

---

cast from (signed) char to unsigned int in pci_write_config causes the result
to be sign extended, clobbering high bits in the result. Thus:

# setpci -s 07:00.0 14.L=E4
# setpci -s 07:00.0 14.L
ffffffe4

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

--- linux-2.6.11-openib/drivers/pci/pci-sysfs.c.bad	2005-05-30 13:45:02.000000000 +0300
+++ linux-2.6.11-openib/drivers/pci/pci-sysfs.c	2005-05-30 13:51:39.000000000 +0300
@@ -161,10 +161,10 @@ pci_write_config(struct kobject *kobj, c
 	}
 
 	while (size > 3) {
-		unsigned int val = buf[off - init_off];
-		val |= (unsigned int) buf[off - init_off + 1] << 8;
-		val |= (unsigned int) buf[off - init_off + 2] << 16;
-		val |= (unsigned int) buf[off - init_off + 3] << 24;
+		unsigned int val = (u8)buf[off - init_off];
+		val |= (unsigned int)(u8)buf[off - init_off + 1] << 8;
+		val |= (unsigned int)(u8)buf[off - init_off + 2] << 16;
+		val |= (unsigned int)(u8)buf[off - init_off + 3] << 24;
 		pci_write_config_dword(dev, off, val);
 		off += 4;
 		size -= 4;
-- 
MST - Michael S. Tsirkin
