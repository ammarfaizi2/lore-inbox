Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbUERJM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbUERJM1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 05:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbUERJM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 05:12:26 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:53458 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S261321AbUERJMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 05:12:05 -0400
Message-ID: <40A9D356.6060807@stanford.edu>
Date: Tue, 18 May 2004 02:11:51 -0700
From: Andy Lutomirski <luto@stanford.edu>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Andy Lutomirski <luto@myrealbox.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       olaf+list.linux-kernel@olafdietsche.de, Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] scaled-back caps, take 4 (was Re: [PATCH] capabilites,
 take 2)
References: <fa.dt4cg55.jnqvr5@ifi.uio.no> <40A4F163.6090802@stanford.edu> <20040514110752.U21045@build.pdx.osdl.net> <200405141548.05106.luto@myrealbox.com> <20040517231912.H21045@build.pdx.osdl.net>
In-Reply-To: <20040517231912.H21045@build.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chris Wright wrote:
> * Andy Lutomirski (luto@myrealbox.com) wrote:
> 
>>This version throws out the inheritable mask.  There is no change in
>>behavior with newcaps=0.
> 
> 
> Alright, I tried to write up my expectations for all the various modes
> w.r.t dropping privs, keeping them, setuid apps, etc.  I then wrote some
> tests to get a baseline, and well as a way to compare results.  Finally
> I wrote a patch that meets the requirements I laid out, and compared it
> against yours.  With one minor exception, the capabilities bits match
> up.  You drop effective caps when a non-root users execs a non-root
> setuid app, and I the caps alone.  ...

Paranoia.  There are legacy setuid programs out there (presumably even 
setuid-nonroot).  Let's make them behave as closely to the way they 
currently do as possible.


 > ... One side note, you're changes effect
> the user/group saved ids unexpectedly.

Oops.  That's a trivial fix.

> 
> Here's a bunch of test cases:

> # Still w/out changing inheritable and with KEEPCAPS set
> # 10 Root process does setuid(!0), effective caps are dropped
> # 11 Root process does seteuid(!0), effective caps are dropped
> # 12 Nonroot process restores uid 0, effective restored to permitted

I still want some variant on KEEPCAPS that causes setxuid to leave caps 
completely alone.  Oh, well.

> # 18 Non-root execs setuid-nonroot process, new caps bound by inheritable

What new caps?

>>cap_2.6.6-mm2_4.patch: New stripped-back capabilities.
>>
>> fs/exec.c               |   15 ++++-
>> include/linux/binfmts.h |    9 ++-
>> security/commoncap.c    |  130 ++++++++++++++++++++++++++++++++++++++++++------
>> 3 files changed, 136 insertions(+), 18 deletions(-)
>>
>>--- linux-2.6.6-mm2/fs/exec.c~caps	2004-05-13 11:42:26.000000000 -0700
>>+++ linux-2.6.6-mm2/fs/exec.c	2004-05-14 12:36:17.000000000 -0700
>>@@ -882,8 +882,10 @@
>> 
>> 	if(!(bprm->file->f_vfsmnt->mnt_flags & MNT_NOSUID)) {
>> 		/* Set-uid? */
>>-		if (mode & S_ISUID)
>>+		if (mode & S_ISUID) {
>> 			bprm->e_uid = inode->i_uid;
>>+			bprm->secflags |= BINPRM_SEC_SETUID;
>>+		}
> 
> 
> No strong objection, but I don't think it's necessary.

I wanted to distinguish between setuid-me and non-setuid in apply_creds. 
That one doesn't matter much, though.

> 
> 
>> 
>> 		/* Set-gid? */
>> 		/*
>>@@ -891,10 +893,18 @@
>> 		 * is a candidate for mandatory locking, not a setgid
>> 		 * executable.
>> 		 */
>>-		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP))
>>+		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
>> 			bprm->e_gid = inode->i_gid;
>>+			bprm->secflags |= BINPRM_SEC_SETGID;
>>+		}
>> 	}
>> 
>>+	/* Pretend we have VFS capabilities */
>>+	if ((bprm->secflags & BINPRM_SEC_SETUID) && bprm->e_uid == 0)
>>+		cap_set_full(bprm->cap_permitted);
>>+	else
>>+		cap_clear(bprm->cap_permitted);
>>+
> 
> 
> Thus far we've kept all this stuff out of core.  I believe we should
> keep it that way.  This could easily be left in bprm_set().

True.  But as long as linux_binprm has fields for this stuff, intuitively 
it should always be filled in (i.e. not just in commoncap).  That way we 
can say that commoncap doesn't get special treatment :)

Also, this seems like the right place to check for VFS caps.  This way we can.

> 
> 
>>--- linux-2.6.6-mm2/security/commoncap.c~caps	2004-05-13 11:42:26.000000000 -0700
>>+++ linux-2.6.6-mm2/security/commoncap.c	2004-05-14 13:24:45.000000000 -0700
>>@@ -24,6 +24,11 @@
>> #include <linux/xattr.h>
>> #include <linux/hugetlb.h>
>> 
>>+static int newcaps = 0;
>>+
>>+module_param(newcaps, int, 444);
>>+MODULE_PARM_DESC(newcaps, "Set newcaps=1 to enable experimental capabilities");
> 
> 
> It would be really nice to have a one size fits all solution.  Esp.
> since the legacy mode is what one gets when leaving inheritable mask
> untouched.

I agree.  Andrew specifically asked for this, though, at least until this 
stuff is well-tested and everyone likes it.

> 
> 
>> int cap_bprm_set_security (struct linux_binprm *bprm)
>> {
>>+	if (newcaps)
>>+		return 0;
>>+
> 
> 
> That setup could go here instead of in core.
> 
> 

[snip]
>> 
>>+/*
>>+ * The rules of Linux capabilities (not POSIX!)
>>+ *
>>+ * What the masks mean:
>>+ *  pP = capabilities that this process has
>>+ *  pE = capabilities that this process has and are enabled
>>+ * (so pE <= pP)
>>+ *
>>+ * The capability evolution rules are:
>>+ *
>>+ *  pP' = ((fP & cap_bset) | pP) & Y
>>+ *  pE' = (pE | fP) & pP'
>>+ *
>>+ *  X = cap_bset
>>+ *  Y is zero if uid!=0, euid==0, and setuid non-root
>>+ *
>>+ *  Exception: if setuid-nonroot, then pE' is reset to 0.
> 
> 
> While this works fine, I was interested to see what we could do to
> leave the old algorithm.  Seems both work out fine.
> 
> 
>>+	/* setuid-nonroot is special. */
>>+	if (is_setuid && bprm->e_uid != 0 && current->uid != 0 &&
>>+	    current->euid == 0)
>>+		cap_clear(new_pP);
> 
> 
> setuid-nonroot from a non-root user needs to clear effective?

Yes.  Say user 500 runs a setuid-root program, which goes back and runs a 
setuid-500 program.  uid==euid==500 now, so the program expects to be 
unprivileged.  This makes that work.  (I'm assuming you meant permitted. 
Effective gets cleared in cap_mask(new_pE, new_pP)).


The reason I killed the old algorithm is because it's scary (in the sense 
of being complicated and subtle for no good reason) and because I don't see 
the point of inheritable caps.  I doubt anything uses them currently on a 
vanilla kernel because they don't _do_ anything.  So I killed them.


--Andy
