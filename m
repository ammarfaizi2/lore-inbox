Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265974AbUHOEJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265974AbUHOEJx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 00:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266389AbUHOEJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 00:09:53 -0400
Received: from out007pub.verizon.net ([206.46.170.107]:34994 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S265974AbUHOEJs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 00:09:48 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Sun, 15 Aug 2004 00:09:44 -0400
User-Agent: KMail/1.6.82
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <20040814021809.GD30627@logos.cnet> <200408140417.20539.gene.heskett@verizon.net>
In-Reply-To: <200408140417.20539.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408150009.45034.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.53.77] at Sat, 14 Aug 2004 23:09:47 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 August 2004 04:17, Gene Heskett wrote:
>On Friday 13 August 2004 22:18, Marcelo Tosatti wrote:
>>On Fri, Aug 13, 2004 at 12:27:24AM -0400, Gene Heskett wrote:
>>> On Wednesday 11 August 2004 00:59, Linus Torvalds wrote:
>>> >I wrote:
>>> >> Notably, the output of "/proc/meminfo" and "/proc/slabinfo".
>>> >> "ps axv" helps too.
>
>[...]
>
>>Hi fellows,
>>
>>I've taken some time to look at this oopses, and I truly believe we
>>are facing real corruption.
>>
>>The symptom is that an inode's (blockdev) i_mapping->private_list
>> gets corrupted, one of its buffer_head's contains a
>> b_assoc_mapping list_head with NULL pointers.
>>
>>And this is not an SMP race, because Gene is not running SMP.
>>
>>Gene's oops happens when remove_inode_buffers calls
>> __remove_assoc_queue(bh)
>>
>>Ingo's oops happens while remove_inode_buffers does
>>
>> struct buffer_head *bh = BH_ENTRY(list->next);
>>
>>which is
>>
>>	mov ffffffd8(%ecx), (%somewhere)
>>
>>%ecx is zero, so...
>>
>>There is a bug somewhere.
>>
>>--- a/fs/buffer.c.original	2004-08-14 00:19:55.000000000 -0300
>>+++ b/fs/buffer.c	2004-08-14 00:34:57.000000000 -0300
>>@@ -802,6 +802,8 @@
>>  */
>> static inline void __remove_assoc_queue(struct buffer_head *bh)
>> {
>>+	BUG_ON(bh->b_assoc_buffers.next == NULL);
>>+	BUG_ON(bh->b_assoc_buffers.prev == NULL);
>> 	list_del_init(&bh->b_assoc_buffers);
>> }
>>
>>@@ -1073,6 +1075,7 @@
>>
>> 		spin_lock(&buffer_mapping->private_lock);
>> 		while (!list_empty(list)) {
>>+			BUG_ON(list->next == NULL);
>> 			struct buffer_head *bh = BH_ENTRY(list->next);
>> 			if (buffer_dirty(bh)) {
>> 				ret = 0;
>
>Just for grins I occasionally do the up-arrow bit and re-run that
>slabinfo sorter line Linus gave me, watching the size of the
>dentry_cache line in particular.  I believe I just saw a first, the
>size was reported as being slightly smaller that the last run an
> hour ago.  Previously it had done nothing but grow.  This is a
> kernel with two patches from -rc4, one being the list_del thing,
> the other being the one liner that presumably forces the fetch, not
> depending on the prefetch in this chip which conjecture says it
> might not be working 100%.

I spoke too soon, and I am now rebooted to this patch in addition to 
the 2 noted previously.  It lasted 35 hours this time.

I was looking at sendmail.mc with vim, trying to see if I could spot a 
reason that local mail to root only gets posted when the sendmail 
buffer needs flushed, often resulting in messages from 5am local 
time, finally making it into kmail at 10pm!  Not finding anything 
obvious, I did a :q to quit.  At that point everything froze 
including the clock on the lower right corner of the launch bar.  The 
only unexplained entries in the log are:
-----------------
Aug 14 22:44:04 coyote bonobo-activation-server (root-27863): iid 
OAFIID:BrokenNoType:20000808 has a NULL type
Aug 14 22:44:04 coyote bonobo-activation-server (root-27863): invalid 
character '#' in iid 'OAFIID:This#!!%$iid%^$%
_|~!OAFIID_ContainsBadChars'
Aug 14 22:44:34 coyote gconfd (root-27861): GConf server is not in 
use, shutting down.
Aug 14 22:44:34 coyote gconfd (root-27861): Exiting

And of course the hardware clock was wrong since a normal shutdown 
wasn't done, just a tap on the reset button.

Aug 15 03:37:17 coyote syslogd 1.4.1: restart.
----------------------
So I am as usual, puzzled.  Or up that famous creek with no visible 
means of locomotion, apply as required.

The only thing I've noted in the slabinfo reports is the ext3_cache 
was well into 6 digits in kilobytes.  Now its only 15,000 of its 
normal units (whatever they are) after the reboot.

But now we have the BUG_ON stuff from above installed, maybe that will 
disclose something we can use.  That would brighten my mood which 
needs lots of help after watching my Shelty die today with no vet 
help available.  We will miss him, he was part of the family for 11 
years.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
