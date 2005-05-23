Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVEWOmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVEWOmn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 10:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVEWOmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 10:42:43 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:19213 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S261737AbVEWOmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 10:42:32 -0400
Date: Mon, 23 May 2005 22:34:38 +0800 (WST)
From: raven@themaw.net
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [VFS-RFC] autofs4 and bind, rbind and move mount requests
Message-ID: <Pine.LNX.4.62.0505232041410.8361@donald.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-98.1, required 8,
	NO_REAL_NAME, RCVD_IN_ORBS, RCVD_IN_OSIRUSOFT_COM, USER_AGENT_PINE,
	USER_IN_WHITELIST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been investigating a bug report about bind mounting an autofs 
controlled mount point. It is indeed disastrous for autofs. It would be 
simple enough it to check and fail silently but that won't give sensible 
behavior.

What should the semantics be for these type of mount requests against 
autofs?

First, a move mount doesn't make sense as it places the autofs 
filesystem in a location that is not specified in the autofs map to which 
it belongs. It looks like the user space daemon would loose contact with 
the newly mounted filesystem and so it would become useless and probably 
not umountable, not to mention how the daemon would handle it. I believe 
that this shouldn't be allowed. What do people think? If we don't treat 
these as invalid then how should they behave?

Should there be a way for a filesystem to veto a mount request?
This doesn't appear possible atm.

This couls be done by adding a method such as "mount_begin" to match the 
"umount_begin". Should the methods simply be named "mount" and "umount" 
instead?

Is there a reason that the umount_begin is called only as a special case 
instead of leaving it to the filesystem which implements it to decide 
what needs to be done?

Bind mount requests are another question.

In the case of a bind mount we can find ourselves with a dentry in the 
bound filesystem that is marked as mounted but can't be followed 
because the parent vfsmount is in the source filesystem.

Should the automount functionality go along with the bind mount 
filesystem? At this stage there's no straight forward way for autofs to 
handle two independent mount trees from the same automount daemon. It's 
just not designed to do that.

It's probably possible to make this behave as though the automounted 
filesystem is mirrored under the filesystem to which it is bound. But it's 
likely problematic. What do people think about this?

I've not really thought enough about recursive bind mounts yet but on 
the face of it they look fairly ugly as well.

I know this post is short on detail but hopefully that will come out if 
there are people interested in discussing it further.

I look forward to some feedback and hope I can find a realistic approach 
to solving this problem.

Ian
