Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268950AbUH3TxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268950AbUH3TxG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 15:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268886AbUH3Twj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 15:52:39 -0400
Received: from open.hands.com ([195.224.53.39]:63390 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S268896AbUH3TtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 15:49:13 -0400
Date: Mon, 30 Aug 2004 21:00:23 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Gianni Tedesco <gianni@scaramanga.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fireflier firewall userspace program doing userspace packet filtering
Message-ID: <20040830200023.GA31497@lkcl.net>
References: <20040830104202.GG3712@lkcl.net> <20040830181519.GE8382@lkcl.net> <1093893366.7064.176.camel@sherbert>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093893366.7064.176.camel@sherbert>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 08:16:06PM +0100, Gianni Tedesco wrote:
> On Mon, 2004-08-30 at 19:15 +0100, Luke Kenneth Casson Leighton wrote:
> > so, my question, therefore, is:
> > 
> > 	what should i record in a modified version of ipt_owner in
> > 	order to "vet" packets on a per-executable basis?
> > 
> > 	should i consider recording the inode of the program's binary?
> 
> Bear in mind that that would make sense for an ACCEPT rule, but for a
> DROP rule, copying the binary would bypass the check.
 
 i understand!

 i thought that selinux by default would stop me from being
 able to copy binaries from /usr/bin.... uhn... no such luck.

 if it becomes an issue i will investigate removing read access!


> > 	should i consider recording the _name_ of the program?
> 
> And bear in mind any user can set the name (I assume you mean the argv
> [0] here) of their process to whatever they like, and then use the
> firewall rules for another program.

 so, inode it is.

> Maybe cryptographically checksumming all the executable file-backed maps
> would be closer to what you want. This ensures that the code you "trust"
> to do the right-thing(tm) on the network is the only code that can
> generate/receive whatever traffic. That approach has it's own issues
> though too.

 i should imagine that at some point down the line, selinux would be
 of some assistance here.


> > for example, i notice in ipt_owner.c that match_pid() calls
> > find_task_by_pid().   okkkaaay... so... and then in fs/proc/base.c's
> > proc_exe_link(), i see that get_task_mm() is called to get
> > something called an mm_struct.   and theeeennn... dget is called
> > on _that_, and _then_ in struct dentry, there's something called
> > a d_inode, and _that_ is what i presume contains the inode number
> > of the running process (i_ino).
> 
> Firewalling on PID has rather obvious security ramifications, unless the
> PID is 0 or 1.
> 
> > am i along the right lines, or should i be (according to
> > proc_exe_link()) hunting down the struct vfsmount argument
> > with mntget() instead?  somehow i don't think so, but i haven't
> > any point of reference to know in advance.
> 
> Using paths to exec'ed binaries has problems too, as we have per-process
> namespaces etc..

 i'd be happy to set the rules by the "inode" of the program, and to
 have a userspace program do a lookup (at startup time) of the inode
 of the various programs, and load the rules for the appropriate set
 of binaries.

 the only thing is of course installing new binaries, you need to
 reload the rules (new inodes).

 i could kick that idiot responsible for dpkg maintenance.

 russell's idea of providing /etc/dpkg/postinst.d is exactly the sort
 of thing that's required to re-run iptable-rule-reloading like this,
 and the idiot won't accept the patch.

 l.

