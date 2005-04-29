Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262992AbVD2VNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262992AbVD2VNv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 17:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262994AbVD2VMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 17:12:33 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:44286 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262992AbVD2VJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 17:09:23 -0400
Message-ID: <4272A275.4030801@austin.rr.com>
Date: Fri, 29 Apr 2005 16:09:09 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: handle termination of cifs oplockd kernel thread
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > does and who revied that?  Things like that don't have a business in the
 > kernel, and certainly not as ioctl.

Other filesystems such as smbfs had an ioctl that returned the uid of 
the mounter which they used (in the smbfs case in smbumount).  This was 
required by the unmount helper to determine if the unmount would allow a 
user to unmount a particular mount that they mounted.   Unlike in the 
case of mount, for unmount  you can not use the owner uid of the mount 
target to tell who mounted that mount.   I had not received any better 
suggestions as to how to address it.   I had proposed various 
alternatives - exporting in in /proc/mounts e.g.   

As we try to gradually obsolete smbfs, this came up with various users 
(there was even a bugzilla bug opened for adding it) who said that they 
need the ability to unmount their own mounts for network filesystems 
without using /etc/fstab.    Unfortunately for network filesytsems, 
unlike local filesystems, it is impractical to put every possible mount 
target in /etc/fstab since servers get renamed and the universe of 
possible cifs mount targets for a user is large.

There seemed only three alternatives -
1) mimic the smbfs ioctl -   as can be seen from smbfs and smbumount 
source this has portability problems because apparently there is no 
guarantee that uid_t is the same size in kernel and in userspace - smbfs 
actually has two ioctls for different sizes of uid field - this seemed 
like a bad idea
2) export the uid in /proc/mounts - same problem as above
3) call into the kernel to see if current matches the uid of the mounter 
- this has no 16/32/64 bit uid portability issues since the check is 
made in kernel

If there is a better way to achieve these goals I would like to know - I 
had not gotten any feedback on a better way.   Although I am not a fan 
of ioctls, this is as simple as they get and I checked for overlaps in 
the ioctl numbers and the utility checks to make sure it is only invoked 
if the filesystem magic number matches CIFS's magic number and no parms 
are passed or returned so it is quite safe.

Of course I would have preferred that this facility were built into the 
kernel via a syscall so the same approach could be put in umount itself 
instead of in a umount helper.
