Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269081AbUIHJ6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269081AbUIHJ6r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 05:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269082AbUIHJ6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 05:58:47 -0400
Received: from open.hands.com ([195.224.53.39]:7843 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S269081AbUIHJ6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 05:58:43 -0400
Date: Wed, 8 Sep 2004 11:09:47 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org
Subject: [patch] to add device+inode check to ipt_owner.c - HACKED UP
Message-ID: <20040908100946.GA9795@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dear kernel people,

this is a first pass at attempting to add per-program firewall rule
checking to iptables.

fireflier makes a complete hash of this in user-space because there
is no way it track state information (therefore it cannot track RST
and FIN and FIN ACK packets)

so, i figured i'd try do this in kernel space instead, where it
should be done.

digitally signing the name of the exe is not okay.
_using_ the name of the exe isn't really okay in my book, either.

inodes are only meaningful on a per-device basis.

therefore i add a device (80 chars as a hack) and an inode number
argument to ipt_owner.h

i blatantly cut/paste the code from fs/proc/base.c into ipt_owner.c
only to find that a compile resulted in warnings about mmput
and mmget (present in kernel/sched.c) not existing.

therefore i blatantly hacked fs/proc/base.c to expose the functionality
i required, which is, "given a task struct, give me the dentry and
vfsmount structs associated with its executable".  i called it
proc_task_dentry_lookup().

from there, i can grab the inode number and the device name.

i had to add an EXPORT_SYMBOL(proc_task_dentry_lookup).
i realise this is not ideal (it shouldn't be in fs/proc/base.c,
ipt_owner.c shouldn't be dependent on CONFIG_PROC_FS, etc. at
this stage i don't care)

i feel certain that the functionality required in this function
is not only required elsewhere but also available elsewhere
(in which case, why is it being duplicated in fs/proc/base.c)
so clearly i must be missing something.


from previous messages:

- default rules should be "DENY ALL" and invididual "ALLOW"s this patch
  is NOT good to use with "DENY" rules because users can always copy the
  program (even on selinux systems)



anyone reading this far be warned of the following:

- if you don't like what i have done, i so don't care: i HAVE to
  get this to work and no amount of "i don't like" is going to
  take that away.  don't like it?  save yourself some effort:
  delete this message and your mindset.

- if you do like what i have done, and you are not an experienced
  kernel hacker, please be aware that i am still experimenting,
  i am very much in the dark on this, and your input and
  assistance would be greatly appreciated, but you NEED to take
  precautions to ensure it doesn't do your system any damage.

- you'll also need a hacked version of userspace iptables.
  i'm working on it.

with that in mind, comments and assistance much appreciated because
i feel certain that i cannot be the only person looking for this
sort of functionality.

l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

