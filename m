Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130660AbQJZBzA>; Wed, 25 Oct 2000 21:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130652AbQJZByv>; Wed, 25 Oct 2000 21:54:51 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:64052 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S130278AbQJZBye>; Wed, 25 Oct 2000 21:54:34 -0400
From: "Nathan Scott" <nathans@wobbly.melbourne.sgi.com>
Message-Id: <10010261253.ZM84523@wobbly.melbourne.sgi.com>
Date: Thu, 26 Oct 2000 12:53:00 -0400
In-Reply-To: "Stephen C. Tweedie" <sct@redhat.com>
        "Quota mods needed for journaled quota" (Oct 25,  6:42pm)
In-Reply-To: <20001025184239.U6085@redhat.com>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: "Stephen C. Tweedie" <sct@redhat.com>, Jan Kara <jack@suse.cz>,
        jank@redhat.com, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Quota mods needed for journaled quota
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Stephen,

On Oct 25,  6:42pm, Stephen C. Tweedie wrote:
> Subject: Quota mods needed for journaled quota
> ...
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
> 
> Comments?
> 

It might also/alternatively be generally useful to allow a
filesystem-specific implementation of quotactl itself - through
an additional member in the dquot_operations set of functions?

This would allow ext3 to do that which it needs to do differently
at Q_QUOTAON and would also allow Jan's changes to work in such
a way that both the current form of dquot structure and his new
version of dquots could be used together (his patches currently
change the ondisk dquot definition, which means the existing user
tools get back different structures to what they were expecting,
after issuing certain quotactl commands).

XFS also has its own, different ondisk format for dquots, which
it would like to pass over the quotactl interface - I imagine
filesystems coming from other OSs would too.  The quotactl
syscall is sufficiently generic - its alot like ioctl ;-) -
to allow any size/form of dquot to be passed back to userspace,
so a few new quotactl commands for Jan's new dquot structure
would allow the existing tools to continue to work & new user
tools could take advantage of his extensions (same again for XFS).

Anyway, hope this is useful input.


cheers.

ps: hmm - just realized something... is jank@redhat == jack@suse?

-- 
Nathan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
