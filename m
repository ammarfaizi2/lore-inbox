Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278808AbRKDFsD>; Sun, 4 Nov 2001 00:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278908AbRKDFry>; Sun, 4 Nov 2001 00:47:54 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:22798 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S278808AbRKDFrp>; Sun, 4 Nov 2001 00:47:45 -0500
Message-Id: <200111040547.fA45ldY64666@aslan.scsiguy.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: linux-kernel@vger.kernel.org, groudier@club-internet.fr
Subject: Re: Adaptec vs Symbios performance 
In-Reply-To: Your message of "Sun, 04 Nov 2001 04:50:43 +0100."
             <200111040350.EAA22275@webserver.ithnet.com> 
Date: Sat, 03 Nov 2001 22:47:39 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Can you re-comment from todays point of view?                         

I believe that if you were to set the tag depth in the new aic7xxx
driver to a level similar to either the symbios or the old aic7xxx
driver, that the problem you describe would go away.  The driver
will only perform internal queuing if a device cannot handle the
original queue depth exported to the SCSI mid-layer.  Since the
mid-layer provides no mechanism for proper, dynamic, throttling,
queuing at the driver level will always be required when the driver
determines that a target cannot accept additional commands.  The default
used by the older driver, 8, seems to work for most drives.  So, no
internal queuing is required.  If you are really concerned about
interrupt latency, this will also be a win as you will reduce your
transaction throughput and thus the frequency of interrupts seen
by the controller.

>> I won't comment on whether deferring this work until outside of     
>> an interrupt context would help your "problem" until I understand   
>> what you are complaining about. 8-)                                 
>                                                                      
>In a nutshell:                                                        
>a) long lasting interrupt workloads prevent normal process activity   
>(creating latency and sticky behaviour)                               

Deferring the work to outside of interrupt context will not, in
general, allow non-kernel processes to run any sooner.  Only interrupt
handlers that don't block on the io-request lock (may it die a horrible
death) would be allowed to pre-empt this activity.  Even in this case,
there will be times, albeit much shorter, that this interrupt
will be blocked by the per-controller spin-lock used to protect
driver data structures and access to the card's registers.

If your processes are really feeling sluggish, you are probably doing
*a lot* of I/O.  The only thing that might help is some interrupt
coalessing algorithm in the aic7xxx driver's firmware.  Since these
chips do not have an easily utilized timer facility any such algorithm
would be tricky to implement.  I've thought about it, but not enough
to implement it yet.

>b) long lasting interrupt workloads play bad on other interrupt users 
>(e.g. on the same shared interrupt)                                   

Sure.  As the comment suggests, the driver should use a bottom half
handler or whatever new deferral mechanism is currently the rage
in Linux.  When I first ported the driver, it was targeted to be a
module, suitable for a driver diskette, to replace the old driver.
Things have changed since then, and this area should be revisited.
Internal queuing was not required in the original FreeBSD driver and
this is something the mid-layer should do on a driver's behalf, but
I've already ranted enough about that.

>I can see _both_ comparing aic with symbios.                          

I'm not sure that you would see much of a difference if you set the
symbios driver to use 253 commands per-device.  I haven't looked at
the sym driver for some time, but last I remember it does not use
a bottom half handler and handles queue throttling internally.  It
may perform less work at interrupt time than the aic7xxx driver if 
locally queued I/O is compiled into a format suitable for controller
consumption rather than queue the ScsiCmnd structure provided by
the mid-layer.  The aic7xxx driver has to convert a ScsiCmnd into a
controller data structure to service an internal queue and this can
take a bit of time.

I would be interresting if there is a disparity in the TPS numbers
and tag depths in your comparisons.  Higher tag depth usually means
higher TPS which may also mean less interactive response from the
system.  All things being equal, I would expect the sym and aic7xxx
drivers to perform about the same.

--
Justin
