Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281060AbRKDSKv>; Sun, 4 Nov 2001 13:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281057AbRKDSKm>; Sun, 4 Nov 2001 13:10:42 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:27920 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S281056AbRKDSKf>; Sun, 4 Nov 2001 13:10:35 -0500
Message-Id: <200111041810.fA4IAQY68511@aslan.scsiguy.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: linux-kernel@vger.kernel.org, groudier@club-internet.fr
Subject: Re: Adaptec vs Symbios performance 
In-Reply-To: Your message of "Sun, 04 Nov 2001 15:17:26 +0100."
             <20011104151726.06193c01.skraw@ithnet.com> 
Date: Sun, 04 Nov 2001 11:10:26 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Sat, 03 Nov 2001 22:47:39 -0700 "Justin T. Gibbs" <gibbs@scsiguy.com> wrote
>:
>
>> >Can you re-comment from todays point of view?                         
>> 
>> I believe that if you were to set the tag depth in the new aic7xxx
>> driver to a level similar to either the symbios or the old aic7xxx
>> driver, that the problem you describe would go away.
>
>Nope.
>I know the stuff :-) I already took tcq down to 8 (as in old driver) back at
>the times I compared old an new driver.

Then you will have to find some other reason for the difference in
performance.  Internal queuing is not a factor with any reasonable
modern drive when the depth is set at 8.

>Indeed I found out that everything is a lot worse if using tcq 256 (which
>doesn't work anyway and gets down to 128 in real life using my IBM harddrive). 

The driver cannot know if you are using an external RAID controller or
an IBM drive or a Qunatum fireball.  It is my belief that in a true
multi-tasking workload, giving the device as much work to chew on
as it can handle is always best.  Your sequential bandwidth may
be a bit less, but sequential I/O is not that interesting in my opinion.

>After using depth 8 the comparison to
>symbios is just as described. Though I must admit, that the symbios driver
>takes down tcq from 8 to 4 according to his boot-up message. Do you think it
>will make a noticeable difference if I hardcode the depth to 4 in the aic7xxx
>driver?

As mentioned above, I would not expect any difference.

>>  The driver
>> will only perform internal queuing if a device cannot handle the
>> original queue depth exported to the SCSI mid-layer.  Since the
>> mid-layer provides no mechanism for proper, dynamic, throttling,
>> queuing at the driver level will always be required when the driver
>> determines that a target cannot accept additional commands.  The default
>> used by the older driver, 8, seems to work for most drives.  So, no
>> internal queuing is required.  If you are really concerned about
>> interrupt latency, this will also be a win as you will reduce your
>> transaction throughput and thus the frequency of interrupts seen
>> by the controller.
>
>Hm, this is not really true in my experience. Since a harddrive is in a
>completely other time-framing than pure software issues it may well be, that
>building up internal data not directly inside the hardware interrupt, but on a
>somewhere higher layer, is no noticeable performance loss, _if_ it is done
>right. "Right" here means obviously there must not be a synchronous linkage
>between this higher layer and the hardware interrupt in this sense that the
>higher layer has to wait on hardware interrupts' completion. But this is all
>pretty "down to earth" stuff you know anyways.

I don't understand how your comments relate to mine.  In a perfect world,
and with a "real" SCSI layer in Linux, the driver would never have any
queued data above and beyond what it can directly send to the device.
Since Linux lets you set the queue depth only at startup, before you can
dynamically determine a useful value, the driver has little choice.  To
say it more directly, internal queuing is not something I wanted in the
design - in fact it makes it more complicated and less efficient.

>> Deferring the work to outside of interrupt context will not, in
>> general, allow non-kernel processes to run any sooner.
>
>kernel processes would be completely sufficient. If you hit allocation routine
>s
>(e.g.) the whole system enters hickup state :-).

But even those kernel processes will not run unless they have a higher
priority than the bottom half handler.  I can't stress this enough...
interactive performance will not change if this is done because kernel
tasks take priority over user tasks.

>> If your processes are really feeling sluggish, you are probably doing
>> *a lot* of I/O.
>
>Yes, of course. I wouldn't have complained in the first place _not_ knowing
>that symbios does it better.

I wish you could be a bit more quanitative in your analysis.  It seems
clear to me that the area you're pointing to is not the cause of your
complaint.  Without a quantitative analysis, I can't help you figure
this out.

>> Sure.  As the comment suggests, the driver should use a bottom half
>> handler or whatever new deferral mechanism is currently the rage
>> in Linux.
>
>Do you think this is complex in implementation?

No, but doing anything like this requires some research to find a solution
that works for all kernel versions the driver supports.  I hope I don't need
three different implementations to make this work.  Regardless, this change
will not make any difference in your problem.

>> I would be interresting if there is a disparity in the TPS numbers
>> and tag depths in your comparisons.  Higher tag depth usually means
>> higher TPS which may also mean less interactive response from the
>> system.  All things being equal, I would expect the sym and aic7xxx
>> drivers to perform about the same.
>
>I can confirm that. 253 is a bad joke in terms of interactive responsiveness
>during high load.

Its there for throughput, not interactive performance.  I'm sure if you
were doing things like news expirations, you'd appreciate the higher number
(up to the 128 tags your drives support).

>Probably the configured standard value should be taken down remarkably.
>253 feels like old IDE.
>Yes, I know this comment hurt you badly ;-)

Not really.  Each to their own.  You can tune your system however you
see fit.

>In my eyes the changes required in your driver are _not_ that big. The gain
>would be noticeable. I don't say its a bad driver, really not, I would only
>suggest some refinement. I know _you_ can do a bit better, prove me right ;-)

Show me where the real problem is, and I'll fix it.  I'll add the bottom
half handler too eventually, but I don't see it as a pressing item.  I'm
much more interested in why you are seeing the behavior you are and exactly
what, quantitatively, that behavior is.

--
Justin
