Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129096AbQJaPKs>; Tue, 31 Oct 2000 10:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129033AbQJaPK2>; Tue, 31 Oct 2000 10:10:28 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:49421 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S129032AbQJaPKQ>; Tue, 31 Oct 2000 10:10:16 -0500
Date: Tue, 31 Oct 2000 16:09:51 +0100
From: Jan Kara <jack@suse.cz>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: jank@redhat.com, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Quota mods needed for journaled quota
Message-ID: <20001031160951.D14635@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20001025184239.U6085@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20001025184239.U6085@redhat.com>; from sct@redhat.com on Wed, Oct 25, 2000 at 06:42:39PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello.

> There are a few problems in the Linux quota code which make it
> impossible to perform quota updates transactionally when using a
> journaled filesystem.
> 
> Basically we have the following problems:
> 
>  * The underlying filesystem does not know which files are the quota
>    files, so cannot tell when to apply journaling consistency
>    guarantees to data writes
> 
>  * "chown" is not transactional: the filesystem is given no
>    opportunity to wrap the quota transfer and the owner-attribute
>    notify-change call into a single transaction.
  In my quota fix this has changed a bit as now filesystem's notify_change()
is calling dquot_transfer() (it was needed due to some races and I think it's
also more consistent with how other quota calls work). So this problem
should exist no more.
  
> All of these could be fixed very easily (at least for ext3) if it were
> possible for ext3 to install its own version of the superblock->dq_ops
> quota operations (which would just be simple wrappers around the
> existing quota calls).  However, the current sys_quotactl installs the
> default quota_ops into the superblock on quota_on without any chance
> for the filesystem to override it.
> 
> The addition of an "init_quota" method to the super_operations struct,
> with quota_on calling this and defaulting to installing the default
> quota_ops if the method is NULL, ought to be sufficient to let ext3
> get quotas right in all cases as far as I can see.
  Actually I was proposing something similar in my reaction on dquot hang in
ext3... The only difference was that I proposed to install dq_ops in
foo_read_super() so that it will be more consistent with how other callbacks
work. And in my fix of quota I removed testing of dq_ops being NULL so
operations can be set during all life (mount time) of filesystem.

								Honza
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
