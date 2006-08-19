Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751766AbWHSTFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbWHSTFE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 15:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751774AbWHSTFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 15:05:04 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32486 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751766AbWHSTFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 15:05:02 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <containers@lists.osdl.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH 4/7] proc: Make the generation of the self symlink table driven.
References: <m1u04d98wa.fsf@ebiederm.dsl.xmission.com>
	<1155665132774-git-send-email-ebiederm@xmission.com>
	<20060819010656.e169c3b7.akpm@osdl.org>
	<m1psexum92.fsf@ebiederm.dsl.xmission.com>
	<20060819090322.1b991a33.akpm@osdl.org>
Date: Sat, 19 Aug 2006 13:04:34 -0600
In-Reply-To: <20060819090322.1b991a33.akpm@osdl.org> (Andrew Morton's message
	of "Sat, 19 Aug 2006 09:03:22 -0700")
Message-ID: <m1veootum5.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Sat, 19 Aug 2006 03:07:37 -0600
> ebiederm@xmission.com (Eric W. Biederman) wrote:
>
>> Andrew Morton <akpm@osdl.org> writes:
>> 
>> > On Tue, 15 Aug 2006 12:05:27 -0600
>> > "Eric W. Biederman" <ebiederm@xmission.com> wrote:
>> >
>> >> By not rolling our own inode we get a little more code reuse,
>> >> and things get a little simpler and we don't have special
>> >> cases to contend with later.
>> >
>> > On a standard FC5 install (which has selinux enabled) things get very ugly.
>> >
>> > udev: MAKEDEV: mkdir: file exists
>> >
>> > followed by a stream of udev errors of various sorts and then an infinite
>> > loop of auditd complaints about klogd and "/" and tmpfs.  Nothing makes it
>> > to logs because klogd itself is failing.
>> 
>> I'm not feeling very generous today.  I'm wondering what selinux bug
>> I have found now.  Without selinux everything is fine on FC5.
>> 
>> Any chance of a search through that patchset to see which patch selinux
>> trips on?
>> 
>
> This one.  "PATCH 4/7] proc: Make the generation of the self symlink table
> driven."

Thanks.  I have reproduced it and I can see what is different.  There
is a call of security_task_to_inode that was added to the /proc/self
inode creation.

The following patch works around the problem, by preserving the
current behavior of security label assignment.  I have yet to work out
why having a different security label causes failure for a world
accessible symlink.

I am starting to suspect that security_task_to_inode is a fundamentally
flawed concept, as I can get around it by opening a file before the security
label changes, and still have access to it.   Which in proc is a bad
thing.  But there are already checks on the paths that have sensitive
data so I'm not certain what the point of security_task_to_inode.

I have a bunch more digging to do to understand what is really going
on and if any of it makes sense.

Currently it looks like the good fix will be to just delete security_task_to_inode.
But I won't generate the patch for that until I dig into this farther.

---
 security/selinux/hooks.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 180b26b..59bfd3c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2868,7 +2868,18 @@ static void selinux_task_to_inode(struct
 	struct task_security_struct *tsec = p->security;
 	struct inode_security_struct *isec = inode->i_security;
 
-	isec->sid = tsec->sid;
+	if (S_ISLNK(inode->i_mode)) {
+		struct superblock_security_struct *sbsec;
+		sbsec = inode->i_sb->s_security;
+		if (!sbsec->initialized) {
+			/* Defer initialization */
+			printk(KERN_EMERG "%s sb not initialized\n", __func__);
+			return;
+		}
+		isec->sid = sbsec->sid;
+	} else {
+		isec->sid = tsec->sid;
+	}
 	isec->initialized = 1;
 	return;
 }
