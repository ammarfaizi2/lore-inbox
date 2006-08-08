Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbWHHRKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWHHRKa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 13:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbWHHRKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 13:10:30 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:32230 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1030195AbWHHRK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 13:10:29 -0400
Subject: Re: How to lock current->signal->tty
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Eric Paris <eparis@redhat.com>, Al Viro <viro@ftp.linux.org.uk>,
       James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
       davem@redhat.com, jack@suse.cz, dwmw2@infradead.org,
       tony.luck@intel.com, jdike@karaya.com,
       James.Bottomley@HansenPartnership.com
In-Reply-To: <1155050242.5729.88.camel@localhost.localdomain>
References: <1155050242.5729.88.camel@localhost.localdomain>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 08 Aug 2006 13:11:54 -0400
Message-Id: <1155057114.1123.97.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-08 at 16:17 +0100, Alan Cox wrote:
> The biggest crawly horror I've found so far in auditing the tty locking
> is current->signal->tty. The tty layer currently and explicitly protects
> this using tty_mutex. The core kernel likewise knows about this.
> 
> Unfortunately:
> 	SELinux doesn't do any locking at all
> 	Dquot passes the tty to tty_write_message without locking
> 	audit_log_exit doesn't do any locking at all
> 	acct.c thinks tasklist_lock protects it (wrong)
> 	drivers/char/sx misuses it unlocked in debug info
> 	fs/proc/array thinks tasklist_lock will save it (also wrong)
> 	fs3270 does fascinating things with it which don't look safe
> 	ebtables remote debugging (#if 0 thankfully) does no locking
> 		and just for fun calls the tty driver directly with no
> 		driver locking either.
> 	voyager_thread sets up a thread and then touches ->tty unlocked
> 		(and it seems daemonize already fixed it)
> 	Sparc solaris_procids sets it to NULL without locking
> 	arch/ia64/kernel/unanligned seems to write to it without locking
> 	arch/um/kernel/exec.c appears to believe task_lock is used
> 
> The semantics are actually as follows
> 
> signal->tty must not be changed without holding tty_mutex
> signal->tty must not be used unless tty_mutex is held from before
> reading it to completing using it
> Simple if(signal->tty == NULL) type checks are ok
> 
> I'm looking longer term at tty ref counting and the like but for now and
> current distributions it might be an idea to fix the existing problems.

Does this look sane?  Or do we need a common helper factored from
disassociate_ctty()?  Why is the locking different for TIOCNOTTY in the
non-leader case?

---

selinux:  fix tty locking

Take tty_mutex when accessing ->signal->tty.
Noted by Alan Cox.  

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 security/selinux/hooks.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5d1b8c7..4b0f904 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1711,10 +1711,12 @@ static inline void flush_unauthorized_fi
 {
 	struct avc_audit_data ad;
 	struct file *file, *devnull = NULL;
-	struct tty_struct *tty = current->signal->tty;
+	struct tty_struct *tty;
 	struct fdtable *fdt;
 	long j = -1;
 
+	mutex_lock(&tty_mutex);
+	tty = current->signal->tty;
 	if (tty) {
 		file_list_lock();
 		file = list_entry(tty->tty_files.next, typeof(*file), f_u.fu_list);
@@ -1734,6 +1736,7 @@ static inline void flush_unauthorized_fi
 		}
 		file_list_unlock();
 	}
+	mutex_unlock(&tty_mutex);
 
 	/* Revalidate access to inherited open files. */
 


-- 
Stephen Smalley
National Security Agency

