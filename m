Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932558AbWGBSic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbWGBSic (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 14:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932641AbWGBSic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 14:38:32 -0400
Received: from mail.gmx.net ([213.165.64.21]:31413 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932558AbWGBSib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 14:38:31 -0400
X-Authenticated: #420190
Message-ID: <44A81279.6040309@gmx.net>
Date: Sun, 02 Jul 2006 20:37:45 +0200
From: Marko Macek <Marko.Macek@gmx.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Nish Aravamudan <nish.aravamudan@gmail.com>, thoffman@arnor.net,
       vanackere@lif.univ-mrs.fr, linux-kernel@vger.kernel.org
Subject: Re: USB input ati_remote autorepeat problem
References: <44A18C38.7040504@gmx.net> <29495f1d0606271446y79ffef0aiffe445ee9e3909cd@mail.gmail.com> <20060628065204.GC5546@suse.cz>
In-Reply-To: <20060628065204.GC5546@suse.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Tue, Jun 27, 2006 at 02:46:39PM -0700, Nish Aravamudan wrote:
>   
>> On 6/27/06, Marko Macek <Marko.Macek@gmx.net> wrote:
>>     
>>> Hello!
>>>
>>> I have problems with autorepeat in ati_remote (drivers/usb/input) driver
>>> in "recent" kernels: all keys start repeating immediately without some
>>> delay.
>>>
>>> This makes some things, like changing the channel prev/next or toggling
>>> fullscreen, etc... impossible/hard.
>>>
>>> The problem seems to be related to FILTER_TIME and HZ=250 (which I
>>> forgot to change).
>>>
>>> FILTER_TIME is defined to HZ / 20, and since 250 is not divisible by 20,
>>> the time will be too short to ignore enough events.
>>>
>>> Defining FILTER_TIME to HZ / 20 + 1 seems to fix things, but I'm not
>>> sure if there are any bad side effects.
>>>       
>> Can you try just defining it to msecs_to_jiffies(50)? That should
>> handle the various HZ cases just fine.
>>     
>  
> Indeed, that would be thr right solution. Even better would be to 
>
> 	#define	FILTER_TIME	50	/* 50 msec */
>
> and later use
>
> 	msecs_to_jiffies(FILTER_TIME)
>
> in the code.
There is still a problem (reproducible in HZ=100, at least), because 
msec_to_jiffies

#if HZ <= MSEC_PER_SEC && !(MSEC_PER_SEC % HZ)
        return (m + (MSEC_PER_SEC / HZ) - 1) / (MSEC_PER_SEC / HZ);

Calculates 5 ticks for 50ms, which might seem to be correct, but it 
really isn't,  since 5 ticks can happen in as little as 40 (+eps) ms.

I wonder if this usage of msec_to_jiffies is correct (seems wrong to me).

A working (but not clean) patch might look like this:

--- linux-2.6.17.orig/drivers/usb/input/ati_remote.c    2006-06-29 21:18:15.000000000 +0200

+++ linux-2.6.17/drivers/usb/input/ati_remote.c    2006-07-02 20:10:17.000000000 +0200

@@ -155,9 +155,8 @@

  * events. The hardware generates 5 events for the first keypress

  * and we have to take this into account for an accurate repeat

  * behaviour.

- * (HZ / 20) == 50 ms and works well for me.

  */

-#define FILTER_TIME (HZ / 20)

+#define FILTER_TIME 51 /* msec */

 

 struct ati_remote {

     struct input_dev *idev;

@@ -470,7 +469,7 @@

         /* Filter duplicate events which happen "too close" together. */

         if ((ati_remote->old_data[0] == data[1]) &&

             (ati_remote->old_data[1] == data[2]) &&

-            time_before(jiffies, ati_remote->old_jiffies + FILTER_TIME)) {

+            time_before(jiffies, ati_remote->old_jiffies + msecs_to_jiffies(FILTER_TIME))) {

             ati_remote->repeat_count++;

         } else {

             ati_remote->repeat_count = 0;


Some googling reveals that an old patch used HZ >> 4 (HZ / 16) instead 
of HZ / 20;

Perhaps using msec_to_jiffies(50) + 1 would be the correct fix?

    Mark

