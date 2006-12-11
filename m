Return-Path: <linux-kernel-owner+w=401wt.eu-S936300AbWLKPLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936300AbWLKPLZ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 10:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936456AbWLKPLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 10:11:25 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:2134 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936300AbWLKPLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 10:11:24 -0500
Message-ID: <457D750C.9060807@shadowen.org>
Date: Mon, 11 Dec 2006 15:11:08 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Herbert Poetzl <herbert@13thfloor.at>, Andi Kleen <ak@suse.de>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: 2.6.19-git13: uts banner changes break SLES9 (at least)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

test.kernel.org testing seems to have shaken out a problem with the 
kernel banner changing, introduced by this commit:

	[PATCH] Fix linux banner utsname information
	commit a2ee8649ba6d71416712e798276bf7c40b64e6e5

We first noticed it with 2.6.19-git13 as we use this version string as 
part of our boot validation process, which started tripping for every 
job.  Although we have been able to modify our validation, I am 
concerned that this is a widespread mechanism for finding the version of 
the kernel from non-running kernels.  It appears that SLES9 and possibly 
SLES10 is going to be affected too.

On a SLES9 box here, making an initrd for this kernel fails as below:

	Module list:	sym53c8xx reiserfs
	Kernel version:	%s (powerpc)
	Kernel image:	/boot/vmlinuz-autobench
	Initrd image:	/boot/initrd-autobench.img.new
	No modules found for kernel %s

If you follow the initrd build process it appears that they look at the 
compressed kernel and extract the internal version number from it, in 
order to find the modules.  For this they use the get_kernel_version, 
which starts returning %s with this change:

	# get_kernel_version /boot/vmlinuz-autobench
	%s

Obviously this method is dubious at best for finding the kernel version 
here.  I do wonder if there should be some approved interface for 
getting this information out of the kernel.  Perhaps something similar 
to the IKCFG_ST<config>IKCFG_ED bracketing the uname structure or something.

Andi, just a heads up.

-apw
