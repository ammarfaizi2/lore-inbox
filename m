Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268271AbUH3TSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268271AbUH3TSK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 15:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268275AbUH3TSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 15:18:10 -0400
Received: from trantor.org.uk ([213.146.130.142]:8934 "EHLO trantor.org.uk")
	by vger.kernel.org with ESMTP id S268271AbUH3TR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 15:17:58 -0400
Subject: Re: fireflier firewall userspace program doing userspace packet
	filtering
From: Gianni Tedesco <gianni@scaramanga.co.uk>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040830181519.GE8382@lkcl.net>
References: <20040830104202.GG3712@lkcl.net>
	 <20040830181519.GE8382@lkcl.net>
Content-Type: text/plain
Date: Mon, 30 Aug 2004 20:16:06 +0100
Message-Id: <1093893366.7064.176.camel@sherbert>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-30 at 19:15 +0100, Luke Kenneth Casson Leighton wrote:
> so, my question, therefore, is:
> 
> 	what should i record in a modified version of ipt_owner in
> 	order to "vet" packets on a per-executable basis?
> 
> 	should i consider recording the inode of the program's binary?

Bear in mind that that would make sense for an ACCEPT rule, but for a
DROP rule, copying the binary would bypass the check.

> 	should i consider recording the _name_ of the program?

And bear in mind any user can set the name (I assume you mean the argv
[0] here) of their process to whatever they like, and then use the
firewall rules for another program.

Maybe cryptographically checksumming all the executable file-backed maps
would be closer to what you want. This ensures that the code you "trust"
to do the right-thing(tm) on the network is the only code that can
generate/receive whatever traffic. That approach has it's own issues
though too.

> for example, i notice in ipt_owner.c that match_pid() calls
> find_task_by_pid().   okkkaaay... so... and then in fs/proc/base.c's
> proc_exe_link(), i see that get_task_mm() is called to get
> something called an mm_struct.   and theeeennn... dget is called
> on _that_, and _then_ in struct dentry, there's something called
> a d_inode, and _that_ is what i presume contains the inode number
> of the running process (i_ino).

Firewalling on PID has rather obvious security ramifications, unless the
PID is 0 or 1.

> am i along the right lines, or should i be (according to
> proc_exe_link()) hunting down the struct vfsmount argument
> with mntget() instead?  somehow i don't think so, but i haven't
> any point of reference to know in advance.

Using paths to exec'ed binaries has problems too, as we have per-process
namespaces etc..

I've seen no evidence that any existing firewall software has got this
functionality right thus far.

HTH.

-- 
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/scaramanga.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

