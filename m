Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265055AbUEKX0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265055AbUEKX0w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 19:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265058AbUEKX0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 19:26:52 -0400
Received: from mail.tmr.com ([216.238.38.203]:38662 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S265055AbUEKXZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 19:25:39 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Kernel 2.6.6: Removing the last large file does not reset   filesystem
 properties
Date: Tue, 11 May 2004 19:27:36 -0400
Organization: TMR Associates, Inc
Message-ID: <c7rn7l$ifm$1@gatekeeper.tmr.com>
References: <20040511004956.70f7e17d.akpm@osdl.org> <20040511084510.J33555@shell.inch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1084317749 18934 192.168.12.100 (11 May 2004 23:22:29 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <20040511084510.J33555@shell.inch.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John McGowan wrote:
> On Tue, 11 May 2004, Andrew Morton wrote:
> 
> 
>>John McGowan <jmcgowan@inch.com> wrote:
>>
>>I think this is really an e2fsck/initscript problem.
>>
>>fsck saw that there were no large files on the fs, then fixed up the
>>superblock to say that then returned an exit code which says "I modified
>>the fs".
>>
>>The initscripts see that exit code and have a heart attack.
> 
> 
> Yes. But why did it have to modify the file system/superblock/properties?
> Should the file system have had to be modified (relying upon
> fsck to fix the "largefile" property when next it is run)?
> 
> 
>>What should happen is that fsck returns an exit code which says "I modified
>>the fs, but everythig is OK".  And the initscripts should say "oh, cool"
>>and keep booting.
> 
> 
> Actually, they do, if it isn't the root partition (if I create/delay the
> large file from another partition it gives a message and continues - but
> for the root partition, the initscript, with an exit code greater than 1
> drops one to a root prompt for "maintenance" - and with my /usr on a
> different partition and seeing a bunch of "id not found"
> "test not found" messages ... for a few minutes I was a bit flustered.
> It is easy enough to modify the init script to do a reboot on exit
> code 2).
> 
> (Fedora Core1 initscript on mounting the root partition:
> 
>   # A return of 2 or higher means there were serious problems.
>   echo $"*** An error occurred during the file system check."
>   echo $"*** Dropping you to a shell; the system will reboot"
>   echo $"*** when you leave the shell."
>   str=$"(Repair filesystem)"
>   PS1="$str \# # "; export PS1
>   sulogin
> 
> (the sulogin login message is:
>   "Give root password for maintenance")
> 
> 
>>I don't know whether the problem lies with fsck or initscripts.

I would say the problem is in the interface. There should be one more 
state in the exit codes, and initscripts should handle that:

  0 - okay
  1 - fixes but okay to continue
  2 - fixes and reboot to update in-core info
  3 - help! Uncorrected errors.

> 
> 
> fsck does fix it. Or should the removal of the last large file have
> resulted in the change without the mismatch between the "largefile"
> property being set with no large files?

If the system was shutdown cleanly, then there should not have been this 
problem in the first place. Of course if you are testing recovery by 
doing sync and hitting the switch, well actually that should still work, 
the metadata should be correct, right?
> 
> It's a small annoyance (no damage to the file system itself), no more.
> 
> I know what's happening and how to patch the initscript to get an
> automatic reboot on exit code 2. Is that the proper way to handle it?

Absolutely not! It will leave you in an endless loop of rebooting!

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
