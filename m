Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWBVPZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWBVPZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 10:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWBVPZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 10:25:27 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:24265 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751308AbWBVPZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 10:25:26 -0500
Subject: Dasd driver woes.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Christoph Hellwig <hch@lst.de>, Bastian Blank <bastian@waldi.eu.org>,
       akpm@osdl.org, Horst Hummel <horst.hummel@de.ibm.com>,
       Stefan Weinhuber <wein@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 22 Feb 2006 16:25:29 +0100
Message-Id: <1140621930.4820.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,
seems like there has been some heated discussion about the dasd driver
while I was away. Let me summerize as I see things.

Christoph spent quite some effort to create a set of patches to improve
the dasd ioctl code because he found bugs in the old code and in
principle doesn't like the way how ioctls are handled in the dasd
driver. As he puts it in his unique way: "fix the dasd ioctl mess". I
wouldn't call it a mess since the code worked for quite some time but
there is definitly room for improvement. So lets look at the patches:

1) cleanup dasd_ioctl
This patch calls the ioctls that are defined in dasd_ioctl.c via a
switch statement instead of using the ioctl registration. First step
towards the removal of the ioctl registration. The patch doesn't change
any functionality. My quick test showed that the patch works fine.

2) add per-discipline ioctl method
This adds an ->ioctl method to the dasd discipline structure. Good idea
because the current method to dynamically add an ioctl on module load
defines the ioctl for all dasd devices independent of their discipline.
A eckd reserve/release on a fba disk doesn't work but the ioctl is
defined for it. That doesn't make sense. The ->ioctl method does what
was intended, restricting the discipline specific ioctls to devices that
use the discipline. The fishy return value propagations from
copy_to_user are bugs. A return value of -EFAULT is required if
copy_to_user didn't return 0. Quick test showed that this patch works
fine too.

3) merge dasd_cmb into dasd_mod
Moves the channel measurement code to the main dasd module. The code
required to suppport the cmb ioctls this is very small, having it as a
separate module doesn't really buy us much. We should not remove the
ioctls since they provide us with additional information that is not
available via the sysfs.  
As a side discussion we are thinking of a second, independent access
method to the channel measurement data via sysfs or relayfs based on the
ccw device. The cmb facility is not restricted to dasd devices. That it
is only available for dasd devices is a 2.4 relict.
Quick test showed that this patch works as well.

4) backout dasd_eer module
That has been done. Heiko resent the code without noticing that the
patch has already been sent by me and got rejected. One the second sent
the code slipped in which made Horst temporarily happy. Code that is
disputed should never go into git, so backing it out has been the
correct thing to do. That did frustrate Horst since we are now in the
situation that we do not have a solution for one of our requirements. We
need to come up with an acceptable solution, e.g. one that uses a sysfs
files instead of a misc device and ioctls. The trick here is that we
need to find a clean way to transfer a binary blob of data to user space
without doing any memory allocation on the read step. All required
memory need to be allcoated in the open step.

5) kill dynamic ioctl registration
Last step in the removal of dynamic ioctls. That interface was needed on
2.4 for the EMC support. This support doesn't exist on 2.6 and will be
done by the EMC folks in a clean way without using dynamic ioctls.
Therefore the ioctl registration interface can go away and it's a good
thing that we are rid of it.

Overall the only disputed code is the dasd_eer module, the other 4
patches do make sense and survived my testing. I for my part like the
new code since its shorter and more readable. Horst, do you still have
any objections against pushing Christophs ioctl patches ?

-- 
blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH


