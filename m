Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316023AbSETNzb>; Mon, 20 May 2002 09:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316025AbSETNza>; Mon, 20 May 2002 09:55:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30981 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316023AbSETNz3>; Mon, 20 May 2002 09:55:29 -0400
Date: Mon, 20 May 2002 15:55:31 +0200
From: Jan Kara <jack@suse.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org,
        Nathan Scott <nathans@wobbly.melbourne.sgi.com>
Subject: Quota patches
Message-ID: <20020520135530.GB9209@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  In following mails I'll send (because patches are big, I'll post them just
diretly to Linus - others see ftp below) quota patches for 2.5.15 (patches
apply well on 2.5.16 too). Currently they implement:
  * new quota format (allows 32 uids, accounting in bytes -> mainly for
    Reiserfs)
  * needed infrastructure for XFS quota
  * quota statistics in /proc (we can drop Q_GETSTATS call; it's a lot
    easier to change in future)
  * implements correct syncing of quota
  * introduces interface which allows usage of both quota formats in kernel
  * implemented filesystem callback function on certain quota operations
    (needed for journaled quota, Ext3)
  * implements ioctl() for reporting occupied space in bytes (not just blocks)

  The patches can be downloaded at:
ftp://atrey.karlin.mff.cuni.cz/pub/local/jack/quota/v2.5/2.5.15/

  Old quota tools should work with patches if you configure old quota interface
in '.config'. There are also quota utilities capable of communicating with new
generic interface. You can download them at:

http://www.sf.net/projects/linuxquota/

or you can checkout version from SourceForge CVS.

  Any comments & bugreports welcome.

								Honza

Below is a bit more detailed list of changes:
  The changes are split into 13 parts (should I create one empty patch? ;-)):
quota-2.5.15-1-newlocks - this patch changes counting of references on dquot structures
  so filesystem can be sure we never call it during DQUOT_ALLOC/DQUOT_FREE/..
  calls.
quota-2.5.15-2-formats - this patch removes most format dependent code from dquot.c
  and quota.h and puts calls of callback functions instead
quota-2.5.15-3-register - this patch implements registering/unregistering of quota
  formats
quota-2.5.15-4-getstats - this patch removes Q_GETSTATS call and creates /proc/fs/quota
  entry instead
quota-2.5.15-5-bytes - implements accounting of used space in bytes on quota side
quota-2.5.15-6-bytes - implements accounting of used space in bytes on VFS side -
  - neccessary functions are added to fs.h
quota-2.5.15-7-quotactl - implementation of generic quotactl interface (probably the
  biggest patch). Interface is moved from dquot.c to quota.c file. Pointers
  to quota operations in superblock are now not filled on quota_on() but
  on mount so filesystem can override them (for example ext3 would like to
  check on quota_on() that quotafile lies on proper device and turn on
  data-journaling on it - at least when we'll have journaled quota :)).
quota-2.5.15-8-format1 - implementation of old quota format (mainly moved stuff from
  dquot.c + some interface functions)
quota-2.5.15-9-format2 - implementation of new quota format (mainly just copied from
  patches used in -ac kernels)
quota-2.5.15-10-inttype - replace silly usage of 'short' by 'int'
quota-2.5.15-11-sync - implements correct syncing of quota - also quota info stored
  in superblock is stored (here 2.4.18 and 2.5.6 patches significantly differ
  - in 2.5.6 it's a bit simplier to do it)
quota-2.5.15-12-compat - implements backward compatible quotactl() interface. It's
  configurable whether it should be used at all and whether is should behave
  as interface in Linus's (the oldest interface) or Alan's (old interface for
  new quota format) kernel.
quota-2.5.15-13-ioctl - implements ioctl for getting file size in bytes. I placed
  this patch as the last one because I consider it ugly to create ioctl() for
  such thing (changing stat() would be cleaner but this change isn't probably
  important enough for it to be worth yet another stat() change). So if it
  is decided the patch won't be included there won't be problems...

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
