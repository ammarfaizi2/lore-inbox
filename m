Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbWDTGvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWDTGvX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 02:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWDTGvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 02:51:23 -0400
Received: from smtpout.mac.com ([17.250.248.176]:9198 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751314AbWDTGvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 02:51:20 -0400
In-Reply-To: <200604190656.k3J6uSGW010288@turing-police.cc.vt.edu>
References: <20060419014857.35628.qmail@web36606.mail.mud.yahoo.com> <CD11FD59-4E2E-4AD7-9DD0-5811CE792B24@mac.com> <200604190656.k3J6uSGW010288@turing-police.cc.vt.edu>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <32851499-DA27-46AF-A1A4-E668BBE0771D@mac.com>
Cc: casey@schaufler-ca.com, James Morris <jmorris@namei.org>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
Date: Thu, 20 Apr 2006 02:51:07 -0400
To: Valdis.Kletnieks@vt.edu
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 19, 2006, at 02:56:28, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 19 Apr 2006 02:40:25 EDT, Kyle Moffett said:
>> Perhaps the SELinux model should be extended to handle (dir-inode,  
>> path-entry) pairs.  For example, if I want to protect the /etc/ 
>> shadow file regardless of what tool is used to safely modify it, I  
>> would set
>
> Some of us think that the tools can protect /etc/shadow just fine  
> on their own, and are concerned with rogue software that abuses / 
> etc/shadow without bothering to safely modify it..

Here I'm talking about using SELinux to protect /etc/shadow both  
before _and_ after it's edited with vipw.  A tool like vipw does creat 
() write() rename() to overwrite the /etc/shadow file, so any SELinux  
system relying _only_ on inode is guaranteed to break.  In any case,  
the point here is to provide 2 clean semantics for protecting files:  
inodes and directory entries;  They have entirely different use- 
cases.  For an inode all you need is (<inode>), for a directory entry  
you need (<dir-inode>, <path-component>).  The latter would only be  
used when referencing the file by name, if you already have a  
filehandle it would not be used.

>> o  Protect the "/" and "/etc" directory inodes as usual under SELinux
>> (with attributes on directory inodes).
>> o  Create pairs with (etc_inode,"shadow") and (etc_inode,"gshadow")
>> and apply security attributes to those potentially nonexistent pairs.
>
> *bzzt* wrong.  Why should "gshadow" matter? (Think carefully about  
> what happens when a setUID program gets exploited and used to  
> scribble on /etc/shadow - black hats rarely bother to do locking  
> and other such niceties....)

/etc/gshadow matters because it's the group shadow file, no?  If  
you're going to bother protecting the user shadow file, you should  
protect the group shadow file too.

>> I'm not terribly familiar with the exact internal semantics of  
>> SELinux, but that should provide a 90% solution (it fixes bind  
>> mounts and namespaces).
>
> 90% doesn't give the security guys warm-and-fuzzies....

True, but that's why I address the following 2 items below:

>> The remaining 2 issues are hardlinks and fd-passing.  For  
>> hardlinks you don't care about other links to that data, you're  
>> concerned with protecting a particular filesystem location, not  
>> particular contents, so you just need to prevent _new_ hardlinks  
>> to a protected (dir_inode, path_elem) pair, which doesn't seem  
>> very hard.
>
> It's not. include/linux/security.h:
>
>  * @inode_link:
>  *      Check permission before creating a new hard link to a file.
>  *      @old_dentry contains the dentry structure for an existing  
> link to the file.
>  *      @dir contains the inode structure of the parent directory  
> of the new link.
>  *      @new_dentry contains the dentry structure for the new link.
>  *      Return 0 if permission is granted.

I _think_ SELinux provides a way to hook this, but I'm not entirely  
sure.  If not, it should be added, but I suspect it does.

>> For fd-passing, I don't know what to do.  Perhaps nothing.
>
> include/linux/security.h:
>
>  * @file_receive:
>  *      This hook allows security modules to control the ability of  
> a process
>  *      to receive an open file descriptor via socket IPC.
>  *      @file contains the file structure being received.
>  *      Return 0 if permission is granted.
>
> Already a solved problem.

Likewise, this should be solved with inode-based security if it's a  
problem.  The use-case I'm addressing (legitimate use of /etc/shadow  
with vipw) doesn't care about that.  For example, if I want to only  
allow vipw access to /etc/shadow, then associating that policy with  
the /etc/shadow inode is useless, because the first rogue program  
would just remove and rewrite /etc/shadow, getting a different  
inode.  What I need to do is protect the "shadow" entry in the dentry  
for ("/etc") in the particular namespace I care about, right?

Cheers,
Kyle Moffett



