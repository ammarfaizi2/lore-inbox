Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTHZLcA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 07:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263644AbTHZLcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 07:32:00 -0400
Received: from [203.185.132.124] ([203.185.132.124]:43919 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263638AbTHZLb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 07:31:58 -0400
Message-ID: <3F4B44C2.4030406@nectec.or.th>
Date: Tue, 26 Aug 2003 18:30:10 +0700
From: Samphan Raruenrom <samphan@nectec.or.th>
Organization: NECTEC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en, th
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@image.dk>,
       linux-kernel@vger.kernel.org, Linux TLE Team <rdi1@opentle.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [Rdi1] Re: [PATCH] Add MOUNT_STATUS ioctl to cdrom device
References: <3F4A53ED.60801@nectec.or.th> <20030825195026.A10305@infradead.org>	<3F4B0343.7050605@nectec.or.th>	<20030826083249.B20776@infradead.org>	<3F4B23E2.8040401@nectec.or.th>	<20030826105613.A23356@infradead.org> <20030826095830.GA20693@suse.de>
In-Reply-To: <20030826095830.GA20693@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Tue, Aug 26 2003, Christoph Hellwig wrote:
>>On Tue, Aug 26, 2003 at 04:09:54PM +0700, Samphan Raruenrom wrote:
>>>The only visible feature of this new magicdev is that now
>>>GNOME users can eject there CDs (the discs' icon will
>>>disappear). The eject button now act as 'umount' command.
>>>One new requirement from this new magicdev is the question
>>>"will umount failed?". I have no preference on any way to
>>>implement it. Should there be the right way to do it, I'll
>>>do so. I can think of many way to implement it (including
>>>adding a new lazy-lock mode to cdrom device) but since
>>>I have no kernel hacking experience, I need everyone
>>>advices. Novice users need this 'eject' button after all.
>>This doesn't make sense at all.  Just try the unmount and
>>tell the user if it failed - you can't say whether it will
>>fail before trying.

Yes, you can! Reading the code, if vfsmount.mnt_count > 1 then
umount on that device will fail. Similar function is used
by autofs, i.e. may_umount() in fs/namespace.c. I know the patch
is not beautiful but it work.
Hmm. You seem to advice me to detect the 'eject' button then issue
a umount? I don't know how and I guess it is impossible. But maybe
I'm wrong.

> Exactly. You poll media events from the drive, and upon an eject request
> you try and umount it. If it suceeds, you eject the tray. 

No, it seems impossible to sense the eject request (right?). This
is what I really did with the patched kernel and patched magicdev.
When, for example:-

- user insert CD
- magicdev sense the CD, mount /dev/cdrom -> eject is ok
- user play an mp3 file in the disc
- magicdev found MOUNT_STATUS=BUSY, lock the drive -> eject disabled
- user stop using any file on the disc
- magicdev found MOUNT_STATUS=MOUNTED, unlock the drive -> eject is ok
- user push the eject button, the disc pop out because it's not locked.
- magicdev sense empty drive, umount /dev/cdrom


-- 
Samphan Raruenrom,
The Open Source Project,
National Electronics and Computer Technology Center,
National Science and Technology Development Agency,
Thailand.

