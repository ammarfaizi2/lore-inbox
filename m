Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262549AbVAKW1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbVAKW1n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 17:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbVAKW1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 17:27:06 -0500
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:34755 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262549AbVAKWYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 17:24:55 -0500
Message-ID: <41E451EF.30206@kolivas.org>
Date: Wed, 12 Jan 2005 09:23:43 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rajsekar <rajsekar@cse.iitm.ernet.in>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: SCHED_BATCH not stopped (swsusp fails)
References: <m3oeg1uk1y.fsf@rajsekar.pc> <20050110223213.GC1343@elf.ucw.cz>	<41E30D4E.1070007@kolivas.org> <20050110234456.GC1444@elf.ucw.cz>	<m38y70t7lo.fsf@rajsekar.pc> <41E3D6B4.2080706@kolivas.org> <m3d5wbd8a5.fsf@rajsekar.pc>
In-Reply-To: <m3d5wbd8a5.fsf@rajsekar.pc>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig89BEE64FDA3760B3B4837769"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig89BEE64FDA3760B3B4837769
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Rajsekar wrote:
> Con Kolivas <kernel@kolivas.org> writes:
> 
> 
>>Rajsekar wrote:
>>
>>>Pavel Machek <pavel@ucw.cz> writes:
>>>
>>>
>>>>Hi!
>>>>
>>>>
>>>>
>>>>>>>SCHED_BATCH processes dont seem to heed the `stop' request (order?) by
>>>>>>>swsusp.  I run httpd and mysqld (for my wiki page) with SCHED_BATCH (so
>>>>>>>that I can work on my computer even if the load is very high) but when I
>>>>>>>try to suspend the system, it tries to stop the tasks and simply returns.
>>>>>>>Here is the dmesg output (paritial)
>>>>>>
>>>>>>
>>>>>>Aha, so if it mysqld is not running SCHED_BATCH priority, stopping
>>>>>>mysqld will work ok?
>>>>>
>>>>>That makes sense.
>>>>>
>>>>>Sorry, SCHED_BATCH is unique to my tree at the moment so this is my mistake for not considering it. I'll have to
>>>>>transiently schedule SCHED_BATCH tasks as SCHED_NORMAL if we are going into swsusp. It's something I'll have to work
>>>>>on. In the interim, a workaround would be to convert all httpd threads to SCHED_NORMAL before shutting down in your
>>>>>scripts somewhere and convert them back after resuming.
>>>>>
>>>>>Cheers,
>>>>>Con
>>>>>
>>>>>P.S. Raj the --cutme-- thing in your email is very annoying for those of us who reply to up to 300 emails a day (and
>>>>>yes I do know why you do it, but if you keep doing it people will stop replying directly to you).
>>>>
>>>>Seconded. And by now your email address is in l-k, so you might simply
>>>>give it up :-).
>>>>								Pavel
>>>>-- 
>>>>People were complaining that M$ turns users into beta-testers...
>>>>...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
>>>
>>>Can you give me some ideas on how to go about it? Or why exactly
>>>SCHED_BATCH does not respond to SIGSTOP (is it because of UNINTERRUPTIBLE
>>>sleep)?
>>
>>I'm trying a patch to help it work properly; I haven't been able to test it. It is going into ck3. If you want you can
>>try just that patch on your current kernel or download ck3.
>>
>>The small patch is attached.
>>
>>Cheers,
>>Con
>>
>>Index: linux-2.6.10-ck3/kernel/power/process.c
>>===================================================================
>>--- linux-2.6.10-ck3.orig/kernel/power/process.c	2005-01-11 22:44:13.000000000 +1100
>>+++ linux-2.6.10-ck3/kernel/power/process.c	2005-01-11 22:58:39.367058561 +1100
>>@@ -68,6 +68,12 @@ int freeze_processes(void)
>> 		read_lock(&tasklist_lock);
>> 		do_each_thread(g, p) {
>> 			unsigned long flags;
>>+			if (batch_task(p))
>>+				p->flags |= PF_UISLEEP;
>>+				/*
>>+				 * This will make batch tasks run SCHED_NORMAL
>>+				 * too allow them to be frozen.
>>+				 */
>> 			if (!freezeable(p))
>> 				continue;
>> 			if ((p->flags & PF_FROZEN) ||
>>
>>
> 
> 
> Your patch did not solve the problem.
> The problem is that after you set the PF_UISLEEP flag, but no where else is it
> checked.  My idea is to ignore freezing the PF_UISLEEP processes (hoping
> they wont wake up in the mean time) and just adding another condition.  I
> had add just one more line of code to make it work.  May be that it has
> been added in swsusp and mine is out of date.
> 
> Could you tell me if what I have done is right?

Adding the UISLEEP flag was just reusing a flag that is unique in the 
staircase cpu scheduler and makes SCHED_BATCH run as SCHED_NORMAL next 
timeslice (it is used to prevent DoSing with held semaphores from 
SCHED_BATCH). Unfortunately it doesn't seem to make them SCHED_NORMAL 
long enough to run for a bit and then be frozen by swsusp. The batch 
tasks do need to be frozen like the rest. What you are doing is making 
swsusp not even try to freeze SCHED_BATCH processes. I suspect this is 
dangerous as you'll lose data to a suspend by ignoring processes that 
are actually running.

I still don't have time to study the swsusp code much more to figure out 
how to do this properly.

You can still do it in userspace for httpd2 for example with
for i in `/sbin/pidof httpd2`
do
	schedtool -N $i
done

to convert them to SCHED_NORMAL in your swsusp scripts before it tries 
to suspend, and then on wakeup do:
for i in `/sbin/pidof httpd2`
do
	schedtool -B $i
done

Cheers,
Con

--------------enig89BEE64FDA3760B3B4837769
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB5FHxZUg7+tp6mRURAi+dAJsHrallee7bcXUHqLvEN5cK6MrNBgCdFo54
K1B/AxUTv3Z8yt0WK7yFXTE=
=/jtB
-----END PGP SIGNATURE-----

--------------enig89BEE64FDA3760B3B4837769--
