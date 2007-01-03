Return-Path: <linux-kernel-owner+w=401wt.eu-S1750984AbXACR2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbXACR2p (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 12:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbXACR2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 12:28:45 -0500
Received: from mail-gw3.adaptec.com ([216.52.22.36]:50401 "EHLO
	mail-gw3.adaptec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbXACR2o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 12:28:44 -0500
X-Greylist: delayed 655 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jan 2007 12:28:44 EST
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: udev/aacraid interaction - should aacraid set 'removable'?
Date: Wed, 3 Jan 2007 12:17:47 -0500
Message-ID: <AE4F746F2AECFC4DA4AADD66A1DFEF0134F7DD@otce2k301.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: udev/aacraid interaction - should aacraid set 'removable'?
Thread-Index: AccvT+61VLfiMJvzTiOaAEPvx+VaYwACUrBw
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "dann frazier" <dannf@debian.org>, <linux-kernel@vger.kernel.org>,
       <md@Linux.IT>
Cc: <404927@bugs.debian.org>, <404927-submitter@bugs.debian.org>,
       <debian-kernel@lists.debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ips driver, indirectly via Firmware as it spoofs it's own inquiry
data, reports the Removable bit set in the inquiry response for the
arrays. The dpt_i2o driver similarly has the firmware constructing the
bit set. Some of the Array Bridges and external RAID boxes do the same
thing. I think the aacraid driver is the only RAID driver that has it's
own SCSI interpreter such that this coded activity surrounding the
removable status is visible, however it currently responds by setting
the removable scsi_device field when the READ_CAPACITY is reported.
About four years ago and before it would actually set the RMB bit in the
Inquiry response like the other array drivers.

If a new interface was added to tell the scsi layer to re-read the
partition table, then the aacraid driver, at least, could stop reporting
the array as removable. However, we loose the 'busy check' that results
from the upper layers doing media locking when the removable device is
mounted; the array management applications would then be permitted to
change an array while it is in use. We would need some other way of
asking the upper layers if the device is in use (open or mounted), that
apparently is impossible given the new design of the scsi layers
(Christoph?).

Sincerely -- Mark Salyzyn

> -----Original Message-----
> From: dann frazier [mailto:dannf@debian.org] 
> Sent: Wednesday, January 03, 2007 10:58 AM
> To: Salyzyn, Mark; linux-kernel@vger.kernel.org; md@Linux.IT
> Cc: 404927@bugs.debian.org; 404927-submitter@bugs.debian.org; 
> debian-kernel@lists.debian.org
> Subject: udev/aacraid interaction - should aacraid set 'removable'?
> 
> 
> (lkml readers: this concerns a security issue reported to debian by a
> user of udev/aacraid. udev gives the aacraid devices the floppy group
> because it reports block devices as 'removable'. See
> http://bugs.debian.org/404927 for the entire thread).
> 
> On Wed, Jan 03, 2007 at 11:49:51AM +0100, Marco d'Itri wrote:
> > On Jan 03, dann frazier <dannf@debian.org> wrote:
> > 
> > >  Can you elaborate on what you believe the kernel is doing
> > > incorrectly? My first guess would be the setting of the removable
> > > flag, but aacraid claims to be setting this to prevent 
> partition table
> > > caching - do you believe that to be an incorrect usage?
> > Yes, this looks like an abuse of the interface to me.
> 
> Ok, let's ask lkml
> 
> > > It seems like there is precedence for workarounds for 
> older kernels in
> > > permissions.rules, so would it be appropriate to add an 
> override of
> > > the default floppy rule for aacraid devices for 
> compatability even if
> > > this is a kernel bug?
> > There are workarounds for bugs which are going to be fixed, 
> but looks
> > like this is going to stay forever...
> > Are there other drivers in this situation?
> 
> I didn't turn up any otherwise when I was grepping yesterday, but my
> search terms may have been too naive. I also checked a machine I had
> w/ cciss - it did not have the removable flag set.
> 
> I found a message from Mark Salyzyn from last year that suggested this
> was more pervasive:
>   http://www.ussg.iu.edu/hypermail/linux/kernel/0602.2/1231.html
> Mark: Can you identify some of these other drivers?
> 
> 
> -- 
> dann frazier
> 
> 
