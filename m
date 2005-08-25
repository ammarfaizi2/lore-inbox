Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964913AbVHYKHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbVHYKHz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 06:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbVHYKHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 06:07:54 -0400
Received: from tornado.reub.net ([202.89.145.182]:23724 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S964913AbVHYKHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 06:07:54 -0400
Message-ID: <430D986E.30209@reub.net>
Date: Thu, 25 Aug 2005 22:07:42 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20050823)
MIME-Version: 1.0
To: John McCutchan <ttb@tentacle.dhs.org>
CC: Andrew Morton <akpm@osdl.org>, johannes@sipsolutions.net,
       linux-kernel@vger.kernel.org, Robert Love <rml@novell.com>
Subject: Inotify problem [was Re: 2.6.13-rc6-mm1]
References: <fa.h7s290f.i6qp37@ifi.uio.no> <fa.e1uvbs1.l407h7@ifi.uio.no>
In-Reply-To: <fa.e1uvbs1.l407h7@ifi.uio.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22/08/2005 9:10 p.m., John McCutchan wrote:
> On Sat, 2005-08-20 at 23:52 -0700, Andrew Morton wrote:
>> Reuben Farrelly <reuben-lkml@reub.net> wrote:
>>> Hi,
>>>
>>> On 19/08/2005 11:37 a.m., Andrew Morton wrote:
>>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc6/2.6.13-rc6-mm1/
>>>>
>>>> - Lots of fixes, updates and cleanups all over the place.
>>>>
>>>> - If you have the right debugging options set, this kernel will generate
>>>>   a storm of sleeping-in-atomic-code warnings at boot, from the scsi code.
>>>>   It is being worked on.
>>>>
>>>>
>>>> Changes since 2.6.13-rc5-mm1:
>>>>
>>>>  linus.patch
>>> Noted this in my log earlier today.
>>>
>>> Is this inotify related?
>>>
>>> Aug 21 08:33:04 tornado kernel: idr_remove called for id=2048 which is not 
>>> allocated.
>>> Aug 21 08:33:04 tornado kernel:  [<c0103a00>] dump_stack+0x17/0x19
>>> Aug 21 08:33:04 tornado kernel:  [<c01c9f9a>] idr_remove_warning+0x1b/0x1d
>>> Aug 21 08:33:04 tornado kernel:  [<c01ca024>] sub_remove+0x88/0xea
>>> Aug 21 08:33:04 tornado kernel:  [<c01ca0a1>] idr_remove+0x1b/0x7f
>>> Aug 21 08:33:04 tornado kernel:  [<c018176a>] remove_watch_no_event+0x7a/0x12e
>>> Aug 21 08:33:04 tornado kernel:  [<c0181f64>] inotify_release+0x8f/0x1af
>>> Aug 21 08:33:04 tornado kernel:  [<c015ca80>] __fput+0xaf/0x199
>>> Aug 21 08:33:04 tornado kernel:  [<c015c9b8>] fput+0x22/0x3b
>>> Aug 21 08:33:04 tornado kernel:  [<c015b2ed>] filp_close+0x41/0x67
>>> Aug 21 08:33:04 tornado kernel:  [<c015b383>] sys_close+0x70/0x92
>>> Aug 21 08:33:04 tornado kernel:  [<c0102a9b>] sysenter_past_esp+0x54/0x75
>>> Aug 21 08:33:04 tornado kernel: idr_remove called for id=3072 which is not 
>>> allocated.
>>> Aug 21 08:33:05 tornado kernel:  [<c0103a00>] dump_stack+0x17/0x19
>>> Aug 21 08:33:05 tornado kernel:  [<c01c9f9a>] idr_remove_warning+0x1b/0x1d
>>> Aug 21 08:33:05 tornado kernel:  [<c01ca024>] sub_remove+0x88/0xea
>>> Aug 21 08:33:05 tornado kernel:  [<c01ca0a1>] idr_remove+0x1b/0x7f
>>> Aug 21 08:33:05 tornado kernel:  [<c018176a>] remove_watch_no_event+0x7a/0x12e
>>> Aug 21 08:33:05 tornado kernel:  [<c0181f64>] inotify_release+0x8f/0x1af
>>> Aug 21 08:33:05 tornado kernel:  [<c015ca80>] __fput+0xaf/0x199
>>> Aug 21 08:33:05 tornado kernel:  [<c015c9b8>] fput+0x22/0x3b
>>> Aug 21 08:33:05 tornado kernel:  [<c015b2ed>] filp_close+0x41/0x67
>>> Aug 21 08:33:05 tornado kernel:  [<c015b383>] sys_close+0x70/0x92
>>> Aug 21 08:33:05 tornado kernel:  [<c0102a9b>] sysenter_past_esp+0x54/0x75
>>>
>>> This would have been triggered by using dovecot IMAP which is configured to 
>>> use inotify on Maildir.
>>> I'm also seeing some userspace errors logged for dovecot:
>>>
>>> "Aug 21 04:17:22 Error: IMAP(reuben): inotify_rm_watch() failed: Invalid argument"
>>>
>>> I'll deal with those with the guy who wrote the inotify code in dovecot.
>>>
>>> I'm not so sure userspace should be able or need to cause the kernel to dump 
>>> stack traces like that though?
>>>
>> Yes, the stack dumps would appear to be due to an inotify bug.
>>
>> The message from dovecot is allegedly due to dovecot passing in a file
>> descriptor which was not obtained from the inotify_init() syscall.  But
>> until we know what caused those stack dumps we cannot definitely say
>> whether dovecot is at fault.
>>
> 
> Inotify has a check on both add and rm watch syscalls:
> 
>     /* verify that this is indeed an inotify instance */
>     if (unlikely(filp->f_op != &inotify_fops)) {
>         ret = -EINVAL;
>         goto out;
>     }
> 
> This is crashing in inotify_release, which is called on close of the
> inotify instance. So this fd must be from an inotify instance right?
> 
> I looked at the dovecot code, it looks fine wrt inotify. Long shot, but
> the close-on-exec flag is set. Could this be tripping anything up?

I have also observed another problem with inotify with dovecot - so I spoke 
with Johannes Berg who wrote the inotify code in dovecot.  He suggested I post 
here to LKML since his opinion is that this to be a kernel bug.

The problem I am observing is this, logged by dovecot after a period of time 
when a client is connected:

dovecot: Aug 22 14:31:23 Error: IMAP(gilly): inotify_rm_watch() failed: 
Invalid argument
dovecot: Aug 22 14:31:23 Error: IMAP(gilly): inotify_rm_watch() failed: 
Invalid argument
dovecot: Aug 22 14:31:23 Error: IMAP(gilly): inotify_rm_watch() failed: 
Invalid argument

Multiply that by about 1000 ;-)

Some debugging shows this:
dovecot: Aug 25 19:31:22 Warning: IMAP(gilly): removing wd 1019 from inotify fd 4
dovecot: Aug 25 19:31:22 Warning: IMAP(gilly): removing wd 1018 from inotify fd 4
dovecot: Aug 25 19:31:22 Warning: IMAP(gilly): inotify_add_watch returned 1019
dovecot: Aug 25 19:31:22 Warning: IMAP(gilly): inotify_add_watch returned 1020
dovecot: Aug 25 19:31:23 Warning: IMAP(gilly): removing wd 1020 from inotify fd 4
dovecot: Aug 25 19:31:23 Warning: IMAP(gilly): removing wd 1019 from inotify fd 4
dovecot: Aug 25 19:31:24 Warning: IMAP(gilly): inotify_add_watch returned 1020
dovecot: Aug 25 19:31:24 Warning: IMAP(gilly): inotify_add_watch returned 1021
dovecot: Aug 25 19:31:24 Warning: IMAP(gilly): removing wd 1021 from inotify fd 4
dovecot: Aug 25 19:31:24 Warning: IMAP(gilly): removing wd 1020 from inotify fd 4
dovecot: Aug 25 19:31:25 Warning: IMAP(gilly): inotify_add_watch returned 1021
dovecot: Aug 25 19:31:25 Warning: IMAP(gilly): inotify_add_watch returned 1022
dovecot: Aug 25 19:31:25 Warning: IMAP(gilly): removing wd 1022 from inotify fd 4
dovecot: Aug 25 19:31:25 Warning: IMAP(gilly): removing wd 1021 from inotify fd 4
dovecot: Aug 25 19:31:26 Warning: IMAP(gilly): inotify_add_watch returned 1022
dovecot: Aug 25 19:31:26 Warning: IMAP(gilly): inotify_add_watch returned 1023
dovecot: Aug 25 19:31:26 Warning: IMAP(gilly): removing wd 1023 from inotify fd 4
dovecot: Aug 25 19:31:26 Warning: IMAP(gilly): removing wd 1022 from inotify fd 4
dovecot: Aug 25 19:31:27 Warning: IMAP(gilly): inotify_add_watch returned 1023
dovecot: Aug 25 19:31:27 Warning: IMAP(gilly): inotify_add_watch returned 1024
dovecot: Aug 25 19:31:27 Warning: IMAP(gilly): removing wd 1024 from inotify fd 4
dovecot: Aug 25 19:31:27 Error: IMAP(gilly): inotify_rm_watch() failed: 
Invalid argument
dovecot: Aug 25 19:31:27 Warning: IMAP(gilly): removing wd 1023 from inotify fd 4
dovecot: Aug 25 19:31:28 Warning: IMAP(gilly): inotify_add_watch returned 1024
dovecot: Aug 25 19:31:28 Warning: IMAP(gilly): inotify_add_watch returned 1024

Note the incrementing wd value even though we are removing them as we go..

This is using latest CVS of dovecot code and with 2.6.12-rc6-mm(1|2) kernel.

Robert, John, what do you think?   Is this possibly related to the oops seen 
in the log that I reported earlier?  (Which is still showing up 2-3 times per 
day, btw)

Reuben

