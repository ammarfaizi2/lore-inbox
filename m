Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268848AbUH3SYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268848AbUH3SYv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 14:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268838AbUH3SYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 14:24:23 -0400
Received: from open.hands.com ([195.224.53.39]:61070 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S268724AbUH3SEP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 14:04:15 -0400
Date: Mon, 30 Aug 2004 19:15:20 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org
Subject: Re: fireflier firewall userspace program doing userspace packet filtering
Message-ID: <20040830181519.GE8382@lkcl.net>
References: <20040830104202.GG3712@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040830104202.GG3712@lkcl.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

regarding this issue, i have done some exploration and found that
ipt_owner is capable of registering by pid.

therefore, the naive approach considered was to have fireflier
"vet" rules via its userspace rules dynamically creating per-pid
_new_ and _real_ rules (based on the template of options specified
from the corresponding userspace rule) but of course with the
ipt_owner "pid" set.

this would at first glance solve the "INCOMING" problem which i
understand the present ipt_owner code to be suffering from.

anyway - this approach is insufficient and fraught with
difficulties, not least involving purging the queue of existing
packets that _would_ match the newly created rule, but it's
too late, they're already in the queue.

etc.

so, what i would like to consider doing is to modify the ipt_owner
module to include the full pathname of the binary it is supposed to
vet.

i don't give a rat's monkeybutt about "oo, yuk, that's disgusting
to do that in the kernel" or "that would _so_ slow network traffic
down": i don't care: this is going in an selinux system where the
performance hit of selinux has already been accepted, so a couple
more percentage performance hit i really don't give a stuff.


so, my question, therefore, is:

	what should i record in a modified version of ipt_owner in
	order to "vet" packets on a per-executable basis?

	should i consider recording the inode of the program's binary?

	should i consider recording the _name_ of the program?

	if i record the inode number, what example code should i examine
	in order to DoTheRightThing of getting from process-pid to
	inode/program?

for example, i notice in ipt_owner.c that match_pid() calls
find_task_by_pid().   okkkaaay... so... and then in fs/proc/base.c's
proc_exe_link(), i see that get_task_mm() is called to get
something called an mm_struct.   and theeeennn... dget is called
on _that_, and _then_ in struct dentry, there's something called
a d_inode, and _that_ is what i presume contains the inode number
of the running process (i_ino).

am i along the right lines, or should i be (according to
proc_exe_link()) hunting down the struct vfsmount argument
with mntget() instead?  somehow i don't think so, but i haven't
any point of reference to know in advance.

anyone with experience in the workings of proc and things, your
input and advice greatly appreciated.

l.


On Mon, Aug 30, 2004 at 11:42:02AM +0100, Luke Kenneth Casson Leighton wrote:

> 	is it possible to leverage - and i mean without cut/pasting
> 	large parts of kernel-space code into fireflier-in-userspace -
> 	the EXISTING kernel's iptables functionality in some way,
> 	such that per-program packet filtering may be performed?

> ultimate aim:
> 
> 	to be able to "enhance" existing iptables firewall rule
> 	checking rather than to be backed into a corner of "replacing"
> 	existing functionality.... just because of one extra check
> 	[the pid]
