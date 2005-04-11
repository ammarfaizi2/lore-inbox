Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbVDKVTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbVDKVTr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 17:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVDKVTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 17:19:47 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:20889 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261943AbVDKVT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 17:19:29 -0400
Message-ID: <425AE9DE.5080407@lsrfire.ath.cx>
Date: Mon, 11 Apr 2005 23:19:26 +0200
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Bodo Eggert <7eggert@gmx.de>
Cc: linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
       akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk, pj@engr.sgi.com
Subject: Re: [RFC][PATCH] Simple privacy enhancement for /proc/<pid>
References: <20050410153855.GA24905@lsrfire.ath.cx> <Pine.LNX.4.58.0504101910270.4413@be1.lrz>
In-Reply-To: <Pine.LNX.4.58.0504101910270.4413@be1.lrz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert schrieb:
> On Sun, 10 Apr 2005, Rene Scharfe wrote:
> 
> 
>>First, configuring via kernel parameters is sufficient.
> 
> 
> I don't remember: Would a mount option be equally easy to implement?
> (Kernel parameters are OK for me, too.)

A mount option for procfs would be changable at remount, making
implementation a bit more involved.

>>I have another idea: let's keep the details of _every_ process owned by
>>user root readable by anyone.
> 
> 
> What about SUID processes acting on behalf of users?

SUID root processes will we visible for all, too.  That's fair enough, I
think.  If it's a concern to you use proc.privacy=2.

>>-	processor.max_cstate=   [HW, ACPI]
>>-			Limit processor to maximum C-state
>>-			max_cstate=9 overrides any DMI blacklist limit.
>>-
> 
> 
> This seems to belong into another patch

Strictly speaking, yes, but it's just a trivial cleanup near my own
change.  And I guarantee it has zero impact on any built kernel image. :]

> (in pid_revalidate:)
> What about moving the things around? (just editing in the MUA)
> 
> 
>>+		if (IS_PID_DIR(proc_type(inode)) || task_dumpable(task)) {
>> 			inode->i_uid = task->euid;
>>+			inode->i_gid = proc_gid;
>>+			if (!proc_privacy || IS_PID_DIR(proc_type(inode)))
>> 				inode->i_gid = task->egid;
>> 		} else {
>> 			inode->i_uid = 0;
>> 			inode->i_gid = 0;
>> 		}
>> 		security_task_to_inode(task, inode);
>> 		return 1;
>> 	}

I suppose you could do that, but I don't see any gain.  I also find my
version easier to read because it keeps the two conditionals (having
different intents and purposes) apart.

> BTW: You might be able to cache IS_PID_DIR(). It looks like being a gain.

I'd rather let the compiler do that job.  It's only a small macro, I
really doubt you would measure any speedup from putting it into a local
variable.

>>@@ -1454,6 +1468,11 @@ static struct dentry *proc_pident_lookup
> 
> 
>>+		if (proc_privacy == 2 || task->euid != 0)
> 
>                                                    ^^^^^
> redundand.

You're right and it's a matter of taste, I guess.  By the way, this is
also what the FreeBSD crowd calls a "bikeshed". :-)

Thanks for reviewing my patch!
Rene
