Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbULVLDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbULVLDy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 06:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbULVLDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 06:03:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:25769 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261962AbULVLDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 06:03:40 -0500
Date: Wed, 22 Dec 2004 03:03:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] revert- sys_setaltroot
Message-Id: <20041222030304.07bb036e.akpm@osdl.org>
In-Reply-To: <1103710694.6111.127.camel@localhost.localdomain>
References: <200410261928.i9QJS7h3011015@hera.kernel.org>
	<1103710694.6111.127.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Tue, 2004-10-26 at 15:22 +0000, Linux Kernel Mailing List wrote:
>  > ChangeSet 1.2187, 2004/10/26 08:22:01-07:00, akpm@osdl.org
>  > 
>  > 	[PATCH] revert- sys_setaltroot	
>  > 	We decided to do this a different way.
> 
>  Can you elaborate?

There were security problems and suggestions that a namespace-based
approach would be better.   umm, have a random sprinkle of emails:



Begin forwarded message:

Date: Tue, 19 Oct 2004 13:14:55 -0700
From: "Seth, Rohit" <rohit.seth@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <torvalds@osdl.org>
Subject: RE: FW: [PATCH] Support ia32 exec domains without CONFIG_IA32_SUPPORT


Seth, Rohit <> wrote on Tuesday, October 19, 2004 10:14 AM:

> Andrew Morton <mailto:akpm@osdl.org> wrote on Tuesday, October 19,
> 2004 12:35 AM: 
> 
>> "Seth, Rohit" <rohit.seth@intel.com> wrote:
>>> 
>>> [sys-altroot4.patch  application/octet-stream (7320 bytes)]
>> 
>> hm.  Should sys_setaltroot() really not require any privileges?
>> 
> 
> As the extent of change is limited to current execution thread (just
> like set_personality) so it is fine to not require any privileges. 
> 

I need to take this back.  There is indeed a security hole that is
introduced by this new system call.  And that is mainly coming because
of the fact that (unlike set_personality) alternate root is maintained
across execs (and also the fact that there is a random string that can
become the alternate root  for a user).  So any program can exec a suid
program and then use the alternate root to exploit system security.

I will be sending you the patch to fix this issue soon.

Thanks, rohit

>> Not that I can see any problems with it, but it needs
>> consideration... 




Begin forwarded message:

Date: Mon, 25 Oct 2004 19:14:05 -0700
From: "Seth, Rohit" <rohit.seth@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, <torvalds@osdl.org>, <viro@parcelfarce.linux.theplanet.co.uk>
Subject: RE: FW: [PATCH] Support ia32 exec domains without CONFIG_IA32_SUPPORT


Andrew Morton <mailto:akpm@osdl.org> wrote on Monday, October 25, 2004
12:31 PM:

> "Seth, Rohit" <rohit.seth@intel.com> wrote:
>> 
>> altroot()
> 
> Do we have a decision/direction on this?  I have a
> revert-sys_setaltroot() 
> patch lined up and my trigger finger is itchy!

I know there is already enough said about altroot and the need to
restrict its usage.  Because of the critical need having another stab at
it.  Would it make sense to have different semantics of the new system
call (call it sys_setexecdomain).  Here super-user makes a new system
call to register a new exec_domain.  And as part of this system call, a
new data structure, something that specify a mapping from personality to
alternate root.  Whenever any app makes a new setpersonality system
call, if that correspond to one of these specified then alternate root
takes into affect....much on the same lines that is happening in kernel
today.

Sys_setaltroot, I agree, in its current form should be reverted.

Please let me know what you think about this.

Thanks, rohit




Begin forwarded message:

Date: Tue, 19 Oct 2004 15:32:57 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Seth, Rohit" <rohit.seth@intel.com>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>
Subject: RE: FW: [PATCH] Support ia32 exec domains without CONFIG_IA32_SUPPORT



Hmm. Do we actually want to clear the alternate root? It looks like that 
would make altroot useless.

Who uses it? I thought it was only really used for the emulation 
environments on sparc64 etc. And clearly now ia64. But not saving it 
across an exec would make it useless, no?

		Linus


On Tue, 19 Oct 2004, Seth, Rohit wrote:

> Seth, Rohit <> wrote on Tuesday, October 19, 2004 1:15 PM:
> > I need to take this back.  There is indeed a security hole that is
> > introduced by this new system call.  And that is mainly coming
> > because of the fact that (unlike set_personality) alternate root is
> > maintained across execs (and also the fact that there is a random
> > string that can become the alternate root  for a user).  So any
> > program can exec a suid program and then use the alternate root to
> > exploit system security.      
> > 
> > I will be sending you the patch to fix this issue soon.
> 
> 
> Andrew,
> 
> Please find attached a small patch that fixes the above security issue
> with set_altroot system call.
> 
> Thanks, rohit
> 
> 

----

Previously, altroot was cleared only on crossing exec-domain
boundaries. Specifically, it was not cleared on exec. This has security
implications. This patch resolves the issue by clearing the altroot
on exec.

Signed-off-by: Arun Sharma <arun.sharma@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Rohit Seth <rohit.seth@intel.com>

Index: linux-2.6.8/fs/exec.c
===================================================================
--- linux-2.6.8.orig/fs/exec.c	2004-08-13 22:36:56.000000000 -0700
+++ linux-2.6.8/fs/exec.c	2004-10-19 14:34:25.805323416 -0700
@@ -786,6 +786,14 @@
 	spin_unlock(&files->file_lock);
 }
 
+static inline void clear_altroot(void)
+{
+	dput(current->fs->altroot);
+	mntput(current->fs->altrootmnt);
+	current->fs->altrootmnt = NULL;
+	current->fs->altroot = NULL;
+}
+
 int flush_old_exec(struct linux_binprm * bprm)
 {
 	char * name;
@@ -821,6 +829,8 @@
 	/* This is the point of no return */
 	steal_locks(files);
 	put_files_struct(files);
+	if (current->fs->altroot)
+		clear_altroot();
 
 	current->sas_ss_sp = current->sas_ss_size = 0;
 



Begin forwarded message:

Date: Mon, 25 Oct 2004 19:46:30 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "Seth, Rohit" <rohit.seth@intel.com>, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: FW: [PATCH] Support ia32 exec domains without CONFIG_IA32_SUPPORT




On Mon, 25 Oct 2004, Andrew Morton wrote:
> 
> This is an area in which I have never worked and I don't feel that I'm in a
> position to offer advice - we need to keep poking Linus & Al.

I think it's ok to just revert sys_altroot() for now. The VFS-internal 
altroot usage doesn't seem to be any different from sparc64, so..

> But from a high level one does ask "if the namespace stuff cannot satisfy
> your requirement, then is it broken?".

namespaces are about private mounts, not directly about emulation. altroot
definitely _is_ directly about emulation, and I suspect we could do away
with altroot if we had some kind of "per-personality namespace", which
would switch together with the emulated environment.

The reason I'd like to get rid of altroot (and would still prefer 
something namespace-based) is simply that altroot has these really nasty 
conceptual problems with dual lookups etc. Dammit, but it's an ugly wart.

		Linus




Begin forwarded message:

Date: Fri, 22 Oct 2004 17:28:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Seth, Rohit" <rohit.seth@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: RE: FW: [PATCH] Support ia32 exec domains without CONFIG_IA32_SUPPORT




On Fri, 22 Oct 2004, Seth, Rohit wrote:
> 
> Could you please let me know how we should proceed with this issue so
> that emulators can seemlessly support different execution domains.

Well, my _personal_ preference by far is to use the equivalent of "chroot" 
for the emulated environment. So whenever you hit a x86 binary, you just 
chroot to /emul, and then you run it there.

NOTE! I say "equivalent", because you could do it by creating a separate
namespace instead, if you wanted to - and just overmounting /lib and
/usr/lib with the emulation environment versions in that particular
namespace. 

Also, note the bind mounts: if you do end up having "/emul", you want to
have the local /lib and /usr/lib be there, but the rest would be just bind
mounts back to the original root, making things pretty similar (ie people
would still see all their normal files in their home directories etc, it
would be just /lib that effectively gets swapped out).

I agree that the altroot() thing is very _convenient_, but it's always 
been an ugly wart on the VFS layer, and so I'd rather get rid of it if we 
can, rather than add users.

Al may have more intelligent suggestions.

		Linus





Begin forwarded message:

Date: Wed, 20 Oct 2004 23:07:57 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Seth, Rohit" <rohit.seth@intel.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>
Subject: RE: FW: [PATCH] Support ia32 exec domains without CONFIG_IA32_SUPPORT




On Wed, 20 Oct 2004, Seth, Rohit wrote:
> 
> Without the sys_altroot system call, the kernel still has the support of
> providing alternate root.  Though that support is embeded in
> exec_domains.  The new system call support is extending that mechanism
> to normal applications.  In its current form, emulators will be the most
> immediate customers for this system call.

No.

You're not thinking this through.

You not only expose the dang thing with a system call, you also _clear_ it 
at every execve.

Which, as far as I can tell, makes it totally useless for what it used to 
do.

I might be wrong, but the point is that you seem to have appropriated a 
(bad) interface, removing the usefullness from the original use, and 
taking it over for your own uses.

So no, the kernel does _not_ support alternate root any more, afaik. The 
code is there, but the support is gone.

And quite frankly, if we're going to break the only previous user of
altroot, I'd rather remove the feature entirely than replace one horrid
user with another. I bet you can do your emulation thing more cleanly with 
namespaces anyway.

		Linus
