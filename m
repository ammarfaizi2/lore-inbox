Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264727AbUFLLsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264727AbUFLLsO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 07:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264729AbUFLLsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 07:48:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:50099 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264727AbUFLLsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 07:48:09 -0400
Date: Sat, 12 Jun 2004 13:48:08 +0200
From: Jan Kara <jack@suse.cz>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Eugene Crosser <crosser@rol.ru>, akpm@osdl.org
Subject: Quota and page lock
Message-ID: <20040612114808.GD22251@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hello!

  Thanks to Eugene Crosser I've spotted one more lock which comes into play
when using quotas and that is the lock on each page. The quota code is called
inside a transaction and needs to write the changed data to the quota file (at
least in the journalled quota case) and writing of the data needs PageLock.
OTOH standard ordering is that the PageLock is acquired first and then the
transaction is started (and this actually happens even if we are journalling
data because after we commit a transaction we mark the jbddirty buffers dirty,
pdflush comes and wants to write them...). So we have a lock inversion on
PageLock and journal_lock. Bad.
  In the unjournalled quota case I could imagine it will be possible to do an
assertion that quota calls which need to do IO (DQUOT_INIT, DQUOT_DROP,
DQUOT_TRANSFER) will be called outside a transaction and so the locking problem
would not arise (it would be a real pain to synchronize the things inside the
quota code when some routines will be called inside the transaction and some of
them outside but probably there is some way). But in the case of journalled
quota the IO must be started inside a transaction - it is a question of data
integrity... So how to solve this? I have two ideas:
  1) Always acquire the PageLock inside a transaction - uh oh... need to change
     all the filesystems doing journalling and the generic code for writing.
     I'm afraid this would cause more problems than we currently have...
  2) Avoid acquiring PageLock at all - we could just start threating the quota
     data as a filesystem metadata (which IMO makes a sence) and do not access
     them by foo_file_read/write but via bread and such. Probably a filesystem
     would have to provide some interface similar to ext3_bread for reading
     and to ext3_journal_dirty_metadata for writing... Using this approach
     there will arise an issue with consistency when userspace accesses the
     quota files. But we can invalidate the pages of the quota files during
     the quotaoff and quota sync so that userspace will get consistent
     data afterwards and we can invalidate_bdev and sync quota files
     during quotaon so that we see the updates userspace did before. Writing to
     files when quota is turned on is not allowed and who does it deserves
     to loose the data...

  I like 2) more - do you think that it is plausible to implement quota IO this
way? Any comments and suggestions welcome :)

									Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
