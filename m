Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161121AbWJNLxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161121AbWJNLxK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 07:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161123AbWJNLxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 07:53:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:20863 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161121AbWJNLxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 07:53:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:from;
        b=j5hgXnBfdNuu3ORqD5Do3r8T9NDa44AAeJ/POucNFfdsPB0xPowqb5VTCzfYAraioa4AEfVdsr0VFvBtbsG3msPQtJzPxEN+/jP4OXlfdVdv2ZTsJCPZrbsThGKsRg+krz1W1Bvo4lDf+Jy1pG901x0TOr43mnDWX4IS5rf0/6A=
Message-ID: <4530CFA7.7090906@googlemail.com>
Date: Sat, 14 Oct 2006 13:53:11 +0200
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, neilb@suse.de,
       rusty@rustcorp.com.au, LKML <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: + convert-cpu-hotplug-notifiers-to-use-raw_notifier-instead-of-blocking_notifier.patch
 added to -mm tree
References: <200610130506.k9D56YJY031111@shell0.pdx.osdl.net>	<452FAE74.1020500@googlemail.com>	<20061013114132.9e5afab9.akpm@osdl.org>	<6bffcb0e0610131313h2f872cc9uf4dbc3f2b41de3f6@mail.gmail.com> <20061013235536.69d3e098.akpm@osdl.org>
In-Reply-To: <20061013235536.69d3e098.akpm@osdl.org>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Fri, 13 Oct 2006 22:13:43 +0200
> "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
> 
>> On 13/10/06, Andrew Morton <akpm@osdl.org> wrote:
>>> On Fri, 13 Oct 2006 17:19:16 +0200
>>> Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
>>>
>>>> There is something really wrong with this patch (or my hardware).
>>>>
>>>> echo shutdown > /sys/power/disk; echo disk > /sys/power/state
>>>> works fine for me on 2.6.19-rc1-g8770c018.
>>>>
>>>> On 2.6.19-rc1-mm1 +
>>>> convert-cpu-hotplug-notifiers-to-use-raw_notifier-instead-of-blocking_notifier.patch
>>>> + Neil's avoid_lockdep_warning_in_md.patch
>>>> (http://www.ussg.iu.edu/hypermail/linux/kernel/0610.1/0642.html)
>>>> I get a lot of "end_request: I/O error, dev sda, sector 31834343" messages.
>>> That's not exactly an expected result.  What makes you think it's due to
>>> this patch?  Does 2.6.19-rc1-mm1 run OK?
>> Yes. (the only one issue is
>> http://www.stardust.webpages.pl/files/tbf/euridica/2.6.19-rc1-mm1/mm-dmesg)
>>
>> I get many "random" bugs that avoid hibernation with this patch.
> 
> As predicted, it works for me.  In fact it makes a string of nasty SMP-only
> warnings go away.
> 

I reverted Neil's avoid_lockdep_warning_in_md.patch and everything works fine.

2.6.19-rc1-mm1 + avoid_lockdep_warning_in_md.patch works well for me.
2.6.19-rc1-mm1 + convert-cpu-hotplug-notifiers-to-use-raw_notifier-instead-of-blocking_notifier.patch also works well.

2.6.19-rc1-mm1 + both patches = crashing hibernation.

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)

-----------------------
Avoid lockdep warning in md.

md_open takes ->reconfig_mutex which causes lockdep to complain.
This (normally) doesn't have deadlock potential as the possible
conflict is with a reconfig_mutex in a different device.

I say "normally" because if a loop were created in the array->member
hierarchy a deadlock could happen.  However that causes bigger
problems than a deadlock and should be fixed independently.

So we flag the lock in md_open as a nested lock.  This requires
defining mutex_lock_interruptible_nested.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c       |    2 +-
 ./include/linux/mutex.h |    3 ++-
 ./kernel/mutex.c        |    8 ++++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff .prev/drivers/md/md.c ./drivers/md/md.c
--- .prev/drivers/md/md.c	2006-10-09 14:25:11.000000000 +1000
+++ ./drivers/md/md.c	2006-10-10 12:28:35.000000000 +1000
@@ -4422,7 +4422,7 @@ static int md_open(struct inode *inode,
 	mddev_t *mddev = inode->i_bdev->bd_disk->private_data;
 	int err;

-	if ((err = mddev_lock(mddev)))
+	if ((err = mutex_lock_interruptible_nested(&mddev->reconfig_mutex, 1)))
 		goto out;

 	err = 0;

diff .prev/include/linux/mutex.h ./include/linux/mutex.h
--- .prev/include/linux/mutex.h	2006-10-10 12:37:04.000000000 +1000
+++ ./include/linux/mutex.h	2006-10-10 12:40:20.000000000 +1000
@@ -125,8 +125,9 @@ extern int fastcall mutex_lock_interrupt

 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 extern void mutex_lock_nested(struct mutex *lock, unsigned int subclass);
+extern int mutex_lock_interruptible_nested(struct mutex *lock, unsigned int subclass);
 #else
-# define mutex_lock_nested(lock, subclass) mutex_lock(lock)
+# define mutex_lock_interruptible_nested(lock, subclass) mutex_interruptible_lock(lock)
 #endif

 /*

diff .prev/kernel/mutex.c ./kernel/mutex.c
--- .prev/kernel/mutex.c	2006-10-10 12:35:54.000000000 +1000
+++ ./kernel/mutex.c	2006-10-10 13:20:04.000000000 +1000
@@ -206,6 +206,14 @@ mutex_lock_nested(struct mutex *lock, un
 }

 EXPORT_SYMBOL_GPL(mutex_lock_nested);
+int __sched
+mutex_lock_interruptible_nested(struct mutex *lock, unsigned int subclass)
+{
+	might_sleep();
+	return __mutex_lock_common(lock, TASK_INTERRUPTIBLE, subclass);
+}
+
+EXPORT_SYMBOL_GPL(mutex_lock_interruptible_nested);
 #endif

 /*
