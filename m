Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264617AbTBTAbM>; Wed, 19 Feb 2003 19:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264630AbTBTAbM>; Wed, 19 Feb 2003 19:31:12 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:8972 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S264617AbTBTAbK>; Wed, 19 Feb 2003 19:31:10 -0500
Date: Thu, 20 Feb 2003 01:40:48 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Werner Almesberger <wa@almesberger.net>
cc: Rusty Russell <rusty@rustcorp.com.au>, <kuznet@ms2.inr.ac.ru>,
       <kronos@kronoz.cjb.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Is an alternative module interface needed/possible?
In-Reply-To: <20030218142257.A10210@almesberger.net>
Message-ID: <Pine.LNX.4.44.0302191454520.1336-100000@serv>
References: <20030217221837.Q2092@almesberger.net> <20030218050349.44B092C04E@lists.samba.org>
 <20030218042042.R2092@almesberger.net> <Pine.LNX.4.44.0302181252570.1336-100000@serv>
 <20030218111215.T2092@almesberger.net> <20030218142257.A10210@almesberger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 18 Feb 2003, Werner Almesberger wrote:

> Next round: possible remedies and their side-effects. As
> usual, if you disagree with something, please holler.
> 
> If yes, let's look at possible (and not overly insane) solutions,
> using remove_proc_entry as a case study:
> 
> 1) still don't kfree, and leave it to the user to somehow
>    minimize the damage. (Good luck :-)

Obviously not a good idea.

> 3) change remove_proc_entry or add remove_proc_entry_wait that
>    works like remove_proc_entry, but blocks until the entry is
>    deleted. Problem: may sleep "forever".

Sleeping is not a good general solution, as you have to be very careful 
not to hold any important locks, otherwise it's easy to abuse.

> 6) export the lookup mechanism, and let the caller poll for
>    removal. Problem: races with creation of a new entry with
>    the same name.

I don't really understand this one.

> 7) transfer ownership of de->data to procfs, and set some
>    (possibly configurable) destruction policy (e.g. always
>    kfree, or such). Similar to 2), but less flexible.

de->data might contain references to other data and de->data might not the 
only dynamic data, just the most visible one, the read/write functions can 
access other dynamic data as well.

> 2) add a callback that is invoked when the proc entry gets
>    deleted. (This callback may be called before remove_proc_entry
>    completes.) Problem: unload/return race for modules.
> 
> 4) make remove_proc_entry return an indication of whether the
>    entry was successfully removed or not. Problem: if it
>    wasn't, what can we do then ?
> 
> 5) like above, but don't remove the entry if we can't do it
>    immediately. Problem: there's no notification for when we
>    should try again, so we'd have to poll.
> 
> Any more ?

If you want to make 4) and 5) separate options, you could the same with 
2), you can unlink the entry during remove_proc_entry or after the last 
user is gone (before the callback is called).
It would not be difficult to separate an unlink_proc_entry from 
remove_proc_entry, so we can force an unlink if needed and we can reduce 
this again to two basic options in two variations. :)

The question is now whether we return an error value or use a callback. 
When a device is removed, we usually also want to remove all its data 
structures, on the other hand we can only remove a module when there are 
no users, so here we return an error value.
Now I need a bigger example to put this into a context, a nice example is 
scsi_unregister. It removes among other things procfs entries and these 
entries have a reference to struct Scsi_Host. As long as scsi_unregister 
is called from module_exit everything works fine, but a bit searching 
reveals drivers/usb/storage/usb.c, which create/removes a scsi host when 
you plug/unplug a storage device (let's ignore other problems here, like 
it's still mounted). In this case nothing protects the removal of the proc 
entries anymore, this means if someone accesses /proc/scsi/usb-storage/... 
while the device is unplugged he will access freed data. Here would be now 
the patch from yesterday useful to implement a callback, but now we also 
can't simply free the Scsi_Host structure, so we have to add a reference 
count to it and only if all references to it are gone, it can be removed 
as well.

At this point I can also respond to Rusty's main argument against giving 
more control to the modules, that they suddenly had to deal with "I 
started deregistering my stuff, but then...". Unless interfaces are 
only used during module_init/module_exit, they have to deal with this 
anyway. I can understand that the module interface is tempting - just wait 
until all user are gone and then disable the module. The only problem is 
that this breaks horribly, when the driver interface is used in a 
different context (as demonstrated with the usb/scsi example). So what 
speaks against forcing driver/interface writers to get it right from the 
beginning?
(I at least could think of a few more reason that speak for this, but I'll 
continue this later.)

bye, Roman

