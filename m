Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965029AbWEOWWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029AbWEOWWr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 18:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbWEOWWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 18:22:47 -0400
Received: from smtpout.mac.com ([17.250.248.178]:40652 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S965029AbWEOWWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 18:22:46 -0400
In-Reply-To: <200605151559.09504.rob@landley.net>
References: <200605121421.00044.rob@landley.net> <200605142008.39420.rob@landley.net> <6BCF90AC-FF8B-48BC-8659-DBE0DD00E270@mac.com> <200605151559.09504.rob@landley.net>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <64472CD2-5640-4611-B631-035AF83F7BB0@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Which process context does /sbin/hotplug run in?
Date: Mon, 15 May 2006 18:22:41 -0400
To: Rob Landley <rob@landley.net>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 15, 2006, at 15:59, Rob Landley wrote:
> On Monday 15 May 2006 12:17 am, Kyle Moffett wrote:
>>> I can CD into them endlessly, and both "ls -lR" and "find ."  
>>> report cycles in the tree, which surprised me that they had a  
>>> specific error message for that, actually.  Good enough for me. :)
>>
>> Odd, I'm unable to replicate that behavior here.  If I run "ls / 
>> var/sub2/sub2" I don't get any entries.  Find and ls -lR have  
>> error messages of that because it can occasionally be triggered  
>> with symlinks and such.
>
> Perhaps I copied it down wrong.  I did this in a 2.6.16 UML  
> instance...
>
> sh-3.00# mount -t tmpfs /tmp /tmp
> sh-3.00# cd /tmp
> sh-3.00# mkdir woot
> sh-3.00# mount --bind woot /var
> sh-3.00# cd /var
> sh-3.00# mkdir sub
> sh-3.00# mount --move /tmp sub
> sh-3.00# ls -lR
> .:
> total 0
> drwxrwxrwt  3 root root 60 May 15 15:57 sub
>
> ./sub:
> total 0
> drwxr-xr-x  3 root root 60 May 15 15:57 woot
> ls: not listing already-listed directory: ./sub/woot
> sh-3.00# find .
> .
> ./sub
> find: Filesystem loop detected; `./sub/woot' has the same device  
> number and
> inode as a directory which is 2 levels higher in the filesystem  
> hierarchy.
> ./sub/woot
> sh-3.00#
>
> Works for me. :)

I get the exact same behavior, but:

sh-3.00# ls -alh /var/sub/woot/sub
total 0
drwxr-xr-x  2 root root 40 May 15 18:09 .
drwxr-xr-x  3 root root 60 May 15 18:09 ..
sh-3.00#

It does *not* recurse indefinitely here, because the mount tree is  
not recursive.  A bind mount (Or a --move, which is bind and umount - 
l), does not share submounts, so it's impossible to circularly link  
them.  This is why it's possible to do this:

mount --bind /var /apache1/bin
mount --bind /var /apache2/var
mount --bind /www1 /apache1/var/www
mount --bind /www2 /apache2/var/www

Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so simple that there are obviously no deficiencies. And the  
other way is to make it so complicated that there are no obvious  
deficiencies.  The first method is far more difficult.
   -- C.A.R. Hoare


