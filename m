Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265754AbSKYW0I>; Mon, 25 Nov 2002 17:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265757AbSKYW0I>; Mon, 25 Nov 2002 17:26:08 -0500
Received: from air-2.osdl.org ([65.172.181.6]:2003 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265754AbSKYW0G>;
	Mon, 25 Nov 2002 17:26:06 -0500
Date: Mon, 25 Nov 2002 16:27:01 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Oleg Drokin <green@namesys.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Problem in using kobjects for block devices and partitions
In-Reply-To: <20021123152223.A17314@namesys.com>
Message-ID: <Pine.LNX.4.33.0211251554140.898-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>    Problem code is in register_disk, and though it was included at the end of
>    November, but problems started to appear very recently.
> 
>    At the beginning of register_disk() we see this snippet:
> 
>            s = strchr(disk->kobj.name, '/');
>            if (s)
>                    *s = '!';
>            kobject_register(&disk->kobj);
>            disk_sysfs_symlinks(disk);
> 
>    And now kobject_register() frees disk structure if registration was
>    unsuccesful, so doing anything else with this structure is not very
>    nice thing. This is especially observable if you turn on SLAB poisoning,
>    then it will die during disk_sysfs_symlinks (actually two levels deeper).
> 
>    I think here we should at least check return value of kobject_register
>    and print something useful. This won't help much against crashing since
>    accessing /proc/partition afterwards will still kill the box (in case
>    of SLAB poisoning, otherwise some other unpredictable stuff will happen).
> 
>    It seems that making register_disk() to return error back to caller
>    does not makes much sence either, since struct gendisk is already destroyed
>    and we cannot get it off the lists that easily.
> 
>    May be it was just a bad decision to destroy whole structure of underlying
>    object when kobject creation have failed? 

Thanks for catching this. There are two things wrong: register_disk() is 
calling kobject_register() instead of kobject_add(). This is fixed with a 
patch I posted earlier today. 

Also, though it is now irrelevant in this case, kobject_register() was 
causing the object to be freed if kobject_add() failed. This is a bit 
rude, though kobject_add() really shoudln't fail. It can fail because of 
these reasons: 

- sysfs isn't mounted yet. 
- we couldn't get an inode.
- the file or directory already existed. 

In each case, we probably want to know about it. So, the patch below 
changes the call to kobject_cleanup() to a WARN_ON(error) to flag it, but 
continue going..

Thanks,

	-pat

===== lib/kobject.c 1.8 vs edited =====
--- 1.8/lib/kobject.c	Thu Nov 21 17:01:53 2002
+++ edited/lib/kobject.c	Mon Nov 25 16:01:53 2002
@@ -110,8 +110,7 @@
 	if (kobj) {
 		kobject_init(kobj);
 		error = kobject_add(kobj);
-		if (error)
-			kobject_cleanup(kobj);
+		WARN_ON(error);
 	} else
 		error = -EINVAL;
 	return error;

