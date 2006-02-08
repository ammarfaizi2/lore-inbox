Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965046AbWBHMPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbWBHMPF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 07:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbWBHMPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 07:15:04 -0500
Received: from mail.gmx.de ([213.165.64.21]:31418 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965046AbWBHMPD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 07:15:03 -0500
X-Authenticated: #19095397
From: Bernd Schubert <bernd-schubert@gmx.de>
To: John M Flinchbaugh <john@hjsoft.com>, reiserfs-list@namesys.com
Subject: Re: 2.6.15 Bug? New security model?
Date: Wed, 8 Feb 2006 13:14:59 +0100
User-Agent: KMail/1.8.3
Cc: Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org
References: <200602080212.27896.bernd-schubert@gmx.de> <43E94A02.2080205@vilain.net> <20060208053732.GA13560@butterfly.hjsoft.com>
In-Reply-To: <20060208053732.GA13560@butterfly.hjsoft.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602081314.59639.bernd-schubert@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CC'ed also the reiser-list


On Wednesday 08 February 2006 06:37, John M Flinchbaugh wrote:
> On Wed, Feb 08, 2006 at 02:31:46PM +1300, Sam Vilain wrote:
> > Bernd Schubert wrote:
> > >With 2.6.15:
> > >bathl:~# touch /var/run/test
> > >touch: cannot touch `/var/run/test': Permission denied
> > >With 2.6.13:
> > >bathl:~# touch /var/run/test
> > >(No error message)
> >
> > Some ideas; ACLs, SELinux, Attributes, Capabilities.
>
> lsattr -d /var/run && lsattr /var/run

Indeed, with 2.6.13

bathl:~# lsattr -d /var/run
lsattr: Inappropriate ioctl for device While reading flags on /var/run

with 2.6.15.3

bathl:~# cat lsatr.out.2.6.15
--S-ia-AcBZXEj-t- /var/run


After the problem came up, I already suspected something like this and 
therefore already had the kernel recompiled without xattr support, so I  
don't know why lsattr shows something for 2.6.15 and nothing for 2.6.13.

here the reiser part from the kernel config of 2.6.13 

CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y

here 2.6.15

CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set


Anyway, I never set any attributes using chattr, so these seem to be random 
attributes, nice.



>
> I saw very similar things going from 2.6.15.1 to 2.6.15.2.  2.6.15.2's
> changelog advertises a fix to reenable extended attributes on reiserfs.
> On one machine this is fine, and lsattr shows no attributes enabled
> (----------), but on another machine, I ended up with all sorts of crazy
> attributes set seemingly randomly -- compression, experimental flags,
> immutable, append-only, all over the map.
>
> I tried clearing them (chattr -R = /var ...etc), but I still found a
> file here and there which refused to be removed, even though lsattr
> showed no flags for it.  After a restart or 2, I saw some attributes
> revert back and I started having trouble removing files from /var/run
> and other places again.
>
> I ended up reverting back to 2.6.15.1 until I have a chance to
> investigate further and try to come up with something reportable.  In
> 2.6.15.1, attributes didn't work at all, giving an ioctl error, though
> the same kernel options were used.  I suspect this is the fix to which
> the Changelog is referring.
>
> I must wonder if I'm suffering from some sort of fs corruption which
> only manifests itself in the attribute settings, and which a reisefsck
> doesn't recognize or correct.  I could be tempted to recreate the
> filesystems from scratch to see if they still have issues.

-- 
Bernd Schubert
PCI / Theoretische Chemie
Universität Heidelberg
INF 229
69120 Heidelberg

