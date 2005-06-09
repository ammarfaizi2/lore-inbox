Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262409AbVFIRMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbVFIRMt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 13:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbVFIRMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 13:12:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42397 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262409AbVFIRMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 13:12:40 -0400
Date: Thu, 9 Jun 2005 18:13:32 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, Linas Vepstas <linas@austin.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH 00/10] IOCHK interface for I/O error handling/detecting
Message-ID: <20050609171332.GC24611@parcelfarce.linux.theplanet.co.uk>
References: <42A8386F.2060100@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A8386F.2060100@jp.fujitsu.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2005 at 09:39:11PM +0900, Hidetoshi Seto wrote:
> Previously I had post two prototypes to LKML:
> 1) readX_check() interface
>    Added new kin of basic readX(), which returns its result of
>    I/O. But, it would not make sense that device driver have to
>    check and react after each of I/Os.
> 2) clear/read_pci_errors() interface
>    Added new pair-interface to sandwich I/Os. It makes sense that
>    device driver can adjust the number of checking I/Os and can
>    react all of them at once. However, this was not generalized,
>    so I thought that more expandable design would be required.
> 
> Today's patch is 3rd one - iochk_clear/read() interface.
> - This also adds pair-interface, but not to sandwich only readX().
>   Depends on platform, starting with ioreadX(), inX(), writeX()
>   if possible... and so on could be target of error checking.

It makes sense to sandwich other kinds of device accesses.  I don't
think the previous clear/read_pci_errors() interface was intended *only*
to sandwich readX().

> - Additionally adds special token - abstract "iocookie" structure
>   to control/identifies/manage I/Os, by passing it to OS.
>   Actual type of "iocookie" could be arch-specific. Device drivers
>   could use the iocookie structure without knowing its detail.

I'm not sure we need this.  Surely it can be deduced from the pci_dev or
struct device?

> Expected usage(sample) is:
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> #include <linux/pci.h>
> #include <asm/io.h>
> 
> int sample_read_with_iochk(struct pci_dev *dev, u32 *buf, int words)
> {
>     unsigned long ofs = pci_resource_start(dev, 0) + DATA_OFFSET;
>     int i;
> 
>     /* Create magical cookie on the stack */
>     iocookie cookie;
> 
>     /* Critical section start */
>     iochk_clear(&dev, &cookie);
>     {
>         /* Get the whole packet of data */
>         for (i = 0; i < words; i++)
>             *buf++ = ioread32(dev, ofs);

You do know that ioread32() doesn't take a pci_dev, right?  I hope you
weren't counting on that for the rest of your implementation.

>     }
>     /* Critical section end. Did we have any trouble? */
>     if ( iochk_read(&cookie) ) return -1;
> 
>     /* OK, all system go. */
>     return 0;
> }

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
