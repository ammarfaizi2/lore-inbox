Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265998AbTAOJdu>; Wed, 15 Jan 2003 04:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266006AbTAOJdu>; Wed, 15 Jan 2003 04:33:50 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:979 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S265998AbTAOJdt>; Wed, 15 Jan 2003 04:33:49 -0500
Date: Wed, 15 Jan 2003 22:42:06 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Dell Laptop PCI wierdness, was: Re: Weird sound problems on Dell
 Latitude C840 resolved..
Message-ID: <453810000.1042623726@localhost.localdomain>
In-Reply-To: <229640000.1042530648@localhost.localdomain>
References: <200301140614.h0E6EVqZ024755@turing-police.cc.vt.edu>
 <229640000.1042530648@localhost.localdomain>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tinkered some more with this.  My system is a 900/700 MHz P3 Inspiron 
8000, with GeForce2go video.

The linked page below suggests monkeying with setpci and altering the 
latency timers on those devices in the system that support it.  This works, 
although my system wants somewhat different numbers than suggested. 
Specifically, it appears to work setting the audio latency to 248, leaving 
everything else at default.

By default the video card has a longer latency (64) than the audio 
controller (32), so it is apparently easy for the audio to get bus-starved. 
Increasing the latency for the audio controller well above default fixes 
this.

Now I can have xmms run with a 3ms buffer, in realtime, and it won't skip 
(on RedHat 2.4.18 with ALSA, presently).  Video performance is slightly 
*improved*.  I can concoct linux events that will cause a skip (changing 
virtual consoles does it), because 3ms is well below the latency bound of 
this kernel, but the BIOS isn't doing it anymore.

My clock is still strange, though.

But what on earth can the BIOS be doing?  It appears that, at least, the 
PCI bus goes strange during these skips; however, this doesn't explain the 
clock, does it?  The CPU can't be going away for long enough to explain 
that, given the xmms result.

Confused.

Andrew

--On Tuesday, January 14, 2003 20:50:48 +1300 Andrew McGregor 
<andrew@indranet.co.nz> wrote:

> These are general Dell laptop problems, and so far as I can tell, there's
> no solution yet to either.  Audio is quite hard (except to get apps to
> use bigger buffers; try googling for 'hammerfall cardbus dell', it's a
> common problem).
>
> This page:
> http://www-106.ibm.com/developerworks/library/l-hw2.html
> may contain a solution to the audio issue, too, I just discovered.
>
> The clock problem is something Linux should deal with.  Like to look into
> it?  I can help somewhat.
>
> Andrew
>
>
> --On Tuesday, January 14, 2003 01:14:31 -0500 Valdis.Kletnieks@vt.edu
> wrote:
>
>> A while back, I reported nasty sound distortion/echoing problems
>> on a C840.  Well, this is a follow-up that I found the cause of the
>> problem...
>>
>> I was also running gkrellm, with it's APM monitor activated.  Whenever
>> it read from /proc/apm, this would cause a call to the BIOS down in
>> apm_get_power_status().  As near as I can tell, on this particular Dell,
>> calling the APM drops interrupts on the floor even if you run with
>> CONFIG_APM_ALLOW_INTS.  Another effect of this was a badly drifting
>> clock (which is how I found this in the first place) - doing a
>> a 'grep timer /proc/interrupts', waiting 4 or 5 minutes of wall clock
>> time, doing it again, and doing the math showed only 980 or so interrupts
>> per second.  The clock drift exhibits itself under 2.4.18 as well,
>> but it wasn't breaking audio.
>>
>> My guess is that the 2.4 driver for the i810 audio is a bit more tolerant
>> of the occasional dropped interrupt (it seems to like to keep a lot of
>> data already queued in the ring buffer), but the 2.5 driver runs in much
>> more 'just in time' mode.  As a result, if the kernel gets suspended
>> while we monkey around in the BIOS, we get a data underrun, causing my
>> problems.
>>
>> For what it's worth, the i8k plugin for gkrellm also causes clock drift,
>> but doesn't seem to upset the audio driver.
>>
>> (OK, so it's not as glorious as debugging APIC issues on a NUMAQ system.
>> On the other hand, there's probably a lot more Latitudes out there than
>> NUMAQ boxes, and more importantly to *me*, I have to deal with this
>> particular Latitude 8-10 hours a day.  And somebody made a comment about
>> open source being driven to scratch itches... ;)
>>
>> /Valdis
>>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


