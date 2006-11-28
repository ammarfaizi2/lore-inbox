Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936001AbWK1TsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936001AbWK1TsF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 14:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936019AbWK1TsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 14:48:05 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:49596 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S936001AbWK1TsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 14:48:02 -0500
Date: Tue, 28 Nov 2006 11:47:57 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Jeff Mahoney <jeffm@suse.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, Andi Kleen <ak@suse.de>,
       lkml <linux-kernel@vger.kernel.org>, reiserfs-dev@namesys.com,
       sam@ravnborg.org
Subject: Re: reiserfs NET=n build error
Message-Id: <20061128114757.8b027341.randy.dunlap@oracle.com>
In-Reply-To: <4560DB6B.9020601@suse.com>
References: <20061118202206.01bdc0e0.randy.dunlap@oracle.com>
	<200611190650.49282.ak@suse.de>
	<45608FC2.5040406@suse.com>
	<200611191959.55969.ak@suse.de>
	<4560AAC1.3000800@oracle.com>
	<20061119205711.GE3078@ftp.linux.org.uk>
	<4560DB6B.9020601@suse.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2006 17:32:11 -0500 Jeff Mahoney wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Al Viro wrote:
> > On Sun, Nov 19, 2006 at 11:04:33AM -0800, Randy Dunlap wrote:
> >> Andi Kleen wrote:
> >>>>> I would copy a relatively simple C implementation, like 
> >>>>> arch/h8300/lib/checksum.c
> >>>> As long as the h8300 version has the same output as the x86 version.
> >>> The trouble is that the different architecture have different output 
> >>> for csum_partial. So you already got a bug when someone wants to move
> >>> file systems.
> >>>
> >>> -Andi
> >> That argues for having only one version of it (in a lib.; my preference)
> >> -or- Every module having its own local copy/version of it.  :(
> > 
> > Wrong.  csum_partial() result is defined modulo 0xffff and it's basically
> > "whatever's convenient as intermediate for this architecture".
> > 
> > reiserfs use of it is just plain broken.  net/* is fine, since all
> > final uses are via csum_fold() or equivalents.
> > 
> > Note that reiserfs use is broken in another way: it takes fixed-endian value
> > and feeds it to cpu_to_le32().  IOW, even if everything had literally the
> > same csum_partial(), the value it shits on disk would be endian-dependent.
> 
> Oh great. Even better. :(

Even more:  MD/raid (=m) is broken in this way also.
It uses csum_partial(), which isn't present (CONFIG_NET=n).

Kernel: arch/x86_64/boot/bzImage is ready  (#9)
  Building modules, stage 2.
  MODPOST 101 modules
WARNING: "csum_partial" [drivers/md/md-mod.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
# CONFIG_MD_RAID0 is not set
CONFIG_MD_RAID1=m
# CONFIG_MD_RAID10 is not set
# CONFIG_MD_RAID456 is not set
CONFIG_MD_MULTIPATH=m
# CONFIG_MD_FAULTY is not set
CONFIG_BLK_DEV_DM=y
CONFIG_DM_DEBUG=y
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=y
CONFIG_DM_MIRROR=y
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=y
CONFIG_DM_MULTIPATH_EMC=m

---
~Randy
full broken config for MD:
http://oss.oracle.com/~rdunlap/configs/config-md-csum
