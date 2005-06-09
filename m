Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262383AbVFIMkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbVFIMkY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 08:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbVFIMjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 08:39:52 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:50654 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262374AbVFIMgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 08:36:49 -0400
Message-ID: <42A8386F.2060100@jp.fujitsu.com>
Date: Thu, 09 Jun 2005 21:39:11 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Cc: Linas Vepstas <linas@austin.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH 00/10] IOCHK interface for I/O error handling/detecting
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, long time no see :-D

This is a continuation of previous post quite a while ago:
"[PATCH/RFC] I/O-check interface for driver's error handling"

Reflecting every comments, I brushed up my patch for generic part.
So today I'll post it again, and also post "ia64 part", which
surely implements ia64-arch specific error checking. I think
latter will be a sample of basic implement for other arch.

The patch is divided into 10 parts, as patch series:
	iochk-01-generic.patch
	iochk-02-ia64.patch
	iochk-03-register.patch
	iochk-04-register_bridge.patch
	iochk-05-check_bridge.patch
	iochk-06-mcanotify.patch
	iochk-07-poison.patch
	iochk-08-mcadrv.patch
	iochk-09-cpeh.patch
	iochk-10-rwlock.patch

Only "01" is for generic, and rest 9 parts are for ia64.
Since parts from 02 to 05 are used to construct basic pci-based
checking, they are not so arch-specific even they in /arch/ia64.

I think the generic part is almost completed. No matter if only
"01" is accepted, because it will mean a good start for other
arch where interested in I/O error recovery infrastructures.
Of course, I'd appreciate it if all of them could be accepted.

I feel need of comments, especially against ia64 parts.
Every comments are welcome.

Thanks,
H.Seto

-----

* ...followings are "abstract" copied from my previous post.
   If you know skip it:

-----

Currently, I/O error is not a leading cause of system failure.
However, since Linux nowadays is making great progress on its
scalability, and ever larger number of PCI devices are being
connected to a single high-performance server, the risk of the
I/O error is increasing day by day.

For example, PCI parity error is one of the most common errors
in the hardware world. However, the major cause of parity error
is not hardware's error but software's - low voltage, humidity,
natural radiation... etc. Even though, some platforms are nervous
to parity error enough to shutdown the system immediately on such
error. So if device drivers can retry its transaction once results
as an error, we can reduce the risk of I/O errors.

So I'd like to suggest new interfaces that enable drivers to
check - detect error and retry their I/O transaction easily.

Previously I had post two prototypes to LKML:
1) readX_check() interface
    Added new kin of basic readX(), which returns its result of
    I/O. But, it would not make sense that device driver have to
    check and react after each of I/Os.
2) clear/read_pci_errors() interface
    Added new pair-interface to sandwich I/Os. It makes sense that
    device driver can adjust the number of checking I/Os and can
    react all of them at once. However, this was not generalized,
    so I thought that more expandable design would be required.

Today's patch is 3rd one - iochk_clear/read() interface.
- This also adds pair-interface, but not to sandwich only readX().
   Depends on platform, starting with ioreadX(), inX(), writeX()
   if possible... and so on could be target of error checking.
- Additionally adds special token - abstract "iocookie" structure
   to control/identifies/manage I/Os, by passing it to OS.
   Actual type of "iocookie" could be arch-specific. Device drivers
   could use the iocookie structure without knowing its detail.

Expected usage(sample) is:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#include <linux/pci.h>
#include <asm/io.h>

int sample_read_with_iochk(struct pci_dev *dev, u32 *buf, int words)
{
     unsigned long ofs = pci_resource_start(dev, 0) + DATA_OFFSET;
     int i;

     /* Create magical cookie on the stack */
     iocookie cookie;

     /* Critical section start */
     iochk_clear(&dev, &cookie);
     {
         /* Get the whole packet of data */
         for (i = 0; i < words; i++)
             *buf++ = ioread32(dev, ofs);
     }
     /* Critical section end. Did we have any trouble? */
     if ( iochk_read(&cookie) ) return -1;

     /* OK, all system go. */
     return 0;
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If arch doesn't(or cannot) have its io-checking strategy,
these interfaces don't do anything, so driver maintainer can write
their driver code with these interfaces for all arch, even where
checking is not implemented.






