Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310163AbSCKPuh>; Mon, 11 Mar 2002 10:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310168AbSCKPu2>; Mon, 11 Mar 2002 10:50:28 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:6418 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S310163AbSCKPuS>; Mon, 11 Mar 2002 10:50:18 -0500
Date: Mon, 11 Mar 2002 16:50:08 +0100
From: Jan Kara <jack@suse.cz>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: merlin@transgeek.com, Nathan Scott <nathans@wobbly.melbourne.sgi.com>,
        fede2@fuerzag.ulatina.ac.cr
Subject: [PATCH] Quota patches
Message-ID: <20020311155008.GB22776@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

  So I've created first "publishable" version of quota patches supporting
both quota formats in kernel (so in future the patches can be backported
in 2.4 and included...). Now quota formats are plugins - the idea is similar
to the way how filesystem plugins work.
  The changes are split into 13 parts (should I create one empty patch? ;-)):
quota-1-newlocks - this patch changes counting of references on dquot structures
  so filesystem can be sure we never call it during DQUOT_ALLOC/DQUOT_FREE/..
  calls.
quota-2-formats - this patch removes most format dependent code from dquot.c
  and quota.h and puts calls of callback functions instead
quota-3-register - this patch implements registering/unregistering of quota
  formats
quota-4-getstats - this patch removes Q_GETSTATS call and creates /proc/fs/quota
  entry instead
quota-5-bytes - implements accounting of used space in bytes on quota side
quota-6-bytes - implements accounting of used space in bytes on VFS side -
  - neccessary functions are added to fs.h
quota-7-quotactl - implementation of generic quotactl interface (probably the
  biggest patch). Interface is moved from dquot.c to quota.c file. Pointers
  to quota operations in superblock are now not filled on quota_on() but
  on mount so filesystem can override them (for example ext3 would like to
  check on quota_on() that quotafile lies on proper device and turn on
  data-journaling on it - at least when we'll have journaled quota :)).
quota-8-format1 - implementation of old quota format (mainly moved stuff from
  dquot.c + some interface functions)
quota-9-format2 - implementation of new quota format (mainly just copied from
  patches used in -ac kernels)
quota-10-inttype - replace silly usage of 'short' by 'int'
quota-11-sync - implements correct syncing of quota - also quota info stored
  in superblock is stored (here 2.4.18 and 2.5.6 patches significantly differ
  - in 2.5.6 it's a bit simplier to do it)
quota-12-compat - implements backward compatible quotactl() interface. It's
  configurable whether it should be used at all and whether is should behave
  as interface in Linus's (the oldest interface) or Alan's (old interface for
  new quota format) kernel.
quota-13-ioctl - implements ioctl for getting file size in bytes. I placed
  this patch as the last one because I consider it ugly to create ioctl() for
  such thing (changing stat() would be cleaner but this change isn't probably
  important enough for it to be worth yet another stat() change). So if it
  is decided the patch won't be included there won't be problems...

  The patches seem to work reasonably for me so I think it's time for
wider testing... I haven't tested the patches for archs != i386
so if someone has sparc, ia32 or s390 at hand can you please give patches a try?
  The patches for 2.4.18 and 2.5.6 are at:
ftp://atrey.karlin.mff.cuni.cz/pub/local/jack/quota/
  v2.4/alpha/
  v2.5/alpha/

  There are also quota utilities capable of communicating with new generic
interface (otherwise you can use old utils and compile compatible quotactl()
interface). You can download them at:

ftp://atrey.karlin.mff.cuni.cz/pub/local/jack/quota/utils/alpha/quota-3.05-pre1.tar.gz

  Any comments & bugreports welcome.

								Honza

--
Jan Kara <jack@suse.cz>
SuSE CR Labs
