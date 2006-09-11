Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbWIKOF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWIKOF6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 10:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWIKOF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 10:05:57 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:48520 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750999AbWIKOF5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 10:05:57 -0400
Message-ID: <45056D3E.6040702@fr.ibm.com>
Date: Mon, 11 Sep 2006 16:05:50 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       containers@lists.osdl.org
Subject: Re: [patch -mm] update mq_notify to use a struct pid
References: <45019CC3.2030709@fr.ibm.com>	<m18xktkbli.fsf@ebiederm.dsl.xmission.com>	<450537B6.1020509@fr.ibm.com> <m1u03eacdc.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1u03eacdc.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

>>> I was just about to send out this patch in a couple more hours.
>> Well, you did the same with the usb/devio.c and friends :)
> 
> Good.  The you should be familiar enough with it to review my patch
> and make certain I didn't do anything stupid :)

well, the least i can try ...

>>> So expect the fact we wrote the same code is a good sign :)
>> How does oleg feel about it ? I've seen some long thread on possible race
>> conditions with put_pid() and solutions with rcu. I didn't quite get all of
>> it ... it will need another run for me.
> 
> Short.  Oleg felt it was a shame that locking was needed to use a
> struct pid.
> 
> While parsing that I realized my second vt patch that deals with
> vt_pid (the pid for console switching) has a subtle race, and
> that patch needs to be reworked.
> 
> We confused each other. :)
> 
>> On the "pid_t to struct pid*" topic:
>>
>> * I started smbfs and realized it was useless.
> 
> Killing the user space part is useless?
> I thought that is what I saw happening.

smb_fill_super() says :

	if (warn_count < 5) {
		warn_count++;
		printk(KERN_EMERG "smbfs is deprecated and will be removed in"
				" December, 2006.  Please migrate to cifs\n");
	}

So, i guess we should forget about it and spend our time on the cifs
kthread instead.

> Of course I don't frequently mount smbfs.
> 
>> * in the following, the init process is being killed directly using 1. I'm
>> not sure how useful it would be to use a struct pid. To begin with, may be
>> they could use a :
>>
>> 	kill_init(int signum, int priv)
> 
> An interesting notion.  The other half of them use cad_pid.

yes.

> Converting that is going to need some sysctl work, so I have been
> ignoring it temporarily.
> 
> Filling in a struct pid through sysctl is extremely ugly at the
> moment, plus cad_pid needs some locking.

Which distros use /proc/sys/kernel/cad_pid and why ? I can image the need
but i didn't find much on the topic.

> My patch todo list (almost a series file) currently looks like:
>> n_r396r
>> fs3270-Change-to-use-struct-pid.txt

done that. will send to martin for review.

>> smbfs-Make-conn_pid-a-struct-pid.txt

deprecated in december. so we could just forget about it.

>> ncpfs-Use-struct-pid-to-track-the-userspace-watchdog-process.txt
>>
>> Don-t-use-kill_pg-in-the-sunos-compatibility-code.txt
>>
>> usbatm-use-kthread-api (I think I have this one)
> I did usbatm mostly to figure out why kthread conversions seem
> to be so hard, and got lucky this one wasn't too ugly.

argh. i've done also and i just send my second version of the patch to the
maintainer Duncan Sands.

This one might just be useless also because greg kh has a patch in -mm to
enable multithread probing of USB devices.

>> The-dvb_core-needs-to-use-the-kthread-api-not-kernel-threads.txt
>> nfs-Note-we-need-to-start-using-the-kthreads-api.txt
> 
> dvb-core I have only started looking at.

suka and i have sent patches to fix :

drivers/media/video/tvaudio.c
drivers/media/video/saa7134/saa7134-tvaudio.c

we are no waiting for the maintainer feedback.

> nfs I noticed it is the svc stuff that matters.
> 
> usbatm, dvb-core, and nfs are the 3 kernel_thread users
> that also use kill_proc, and thus are high on my immediate hit list.

nfs is also full of signal_pending() ...

>> pid-Replace-session_of_pgrp-with-pgrp_in_current_session.txt
>> pid-Use-struct-pid-for-talking-about-process-groups-in-exit.c.txt
>> pid-Replace-is_orphaned_pgrp-with-is_current_pgrp_orphaned.txt
>>
>> tty-Update-the-tty-layer-to-work-with-struct-pid.txt
> I need to ensure I don't have a race with task->signal->tty_old_pgrp.
> tty_old_pgrp is a weird notion that I haven't fully wrapped my head
> around yet.
> 
>> pid-Remove-use-of-old-do_each_task_pid-while_each_task_pid.txt
>>
>> Rewrite-kill_something_info-so-it-uses-newer-helpers.txt
>>
>> pid-Remove-now-unused-do_each_task_pid-and-while_each_task_pid.txt
>> Remove-the-now-unused-kill_pg-kill_pg_info-and-__kill_pg_info.txt
>>
>>
>> pid-Better-tests-for-same-thread-group-membership.txt
>> pid-Cleanup-the-pid-equality-tests.txt
>> pid-Track-the-sending-pid-of-a-queued-signal.txt

is that about updating the siginfos in collect_signal() to hold the right
pid value depending on the pid namespace they are being received ?

>> proc-Use-pid_nr-in-array.c-so-the-code-is-foobar-safe.txt
>>
>> sysctl-Implement-get_data-put_data.txt
>>
>> cad-pid (killing init)
> 
> Once the above list is processed none of the old none of the signal
> functions that take a pid_t is needed anymore.
> i.e. kill_proc, kill_pg, and do_each_task_pid will be removable.
> 
> I have at least a first draft of everything on my list except for the
> kthread conversions which I just started messing with yesterday.   But
> don't worry about beating me to something if you feel you have it
> complete.  That just means I will have enough of a clue to review your
> code :)

good list ! I look at it in details.

thanks,

C.
