Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280005AbRKDORx>; Sun, 4 Nov 2001 09:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280001AbRKDORo>; Sun, 4 Nov 2001 09:17:44 -0500
Received: from ns.ithnet.com ([217.64.64.10]:6919 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S280000AbRKDORe>;
	Sun, 4 Nov 2001 09:17:34 -0500
Date: Sun, 4 Nov 2001 15:17:26 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org, groudier@club-internet.fr
Subject: Re: Adaptec vs Symbios performance
Message-Id: <20011104151726.06193c01.skraw@ithnet.com>
In-Reply-To: <200111040547.fA45ldY64666@aslan.scsiguy.com>
In-Reply-To: <200111040350.EAA22275@webserver.ithnet.com>
	<200111040547.fA45ldY64666@aslan.scsiguy.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 03 Nov 2001 22:47:39 -0700 "Justin T. Gibbs" <gibbs@scsiguy.com> wrote:

> >Can you re-comment from todays point of view?                         
> 
> I believe that if you were to set the tag depth in the new aic7xxx
> driver to a level similar to either the symbios or the old aic7xxx
> driver, that the problem you describe would go away.

Nope.
I know the stuff :-) I already took tcq down to 8 (as in old driver) back at
the times I compared old an new driver. Indeed I found out that everything is a
lot worse if using tcq 256 (which doesn't work anyway and gets down to 128 in
real life using my IBM harddrive). After using depth 8 the comparison to
symbios is just as described. Though I must admit, that the symbios driver
takes down tcq from 8 to 4 according to his boot-up message. Do you think it
will make a noticeable difference if I hardcode the depth to 4 in the aic7xxx
driver?

>  The driver
> will only perform internal queuing if a device cannot handle the
> original queue depth exported to the SCSI mid-layer.  Since the
> mid-layer provides no mechanism for proper, dynamic, throttling,
> queuing at the driver level will always be required when the driver
> determines that a target cannot accept additional commands.  The default
> used by the older driver, 8, seems to work for most drives.  So, no
> internal queuing is required.  If you are really concerned about
> interrupt latency, this will also be a win as you will reduce your
> transaction throughput and thus the frequency of interrupts seen
> by the controller.

Hm, this is not really true in my experience. Since a harddrive is in a
completely other time-framing than pure software issues it may well be, that
building up internal data not directly inside the hardware interrupt, but on a
somewhere higher layer, is no noticeable performance loss, _if_ it is done
right. "Right" here means obviously there must not be a synchronous linkage
between this higher layer and the hardware interrupt in this sense that the
higher layer has to wait on hardware interrupts' completion. But this is all
pretty "down to earth" stuff you know anyways.

> >> I won't comment on whether deferring this work until outside of     
> >> an interrupt context would help your "problem" until I understand   
> >> what you are complaining about. 8-)                                 
> >                                                                      
> >In a nutshell:                                                        
> >a) long lasting interrupt workloads prevent normal process activity   
> >(creating latency and sticky behaviour)                               
> 
> Deferring the work to outside of interrupt context will not, in
> general, allow non-kernel processes to run any sooner.

kernel processes would be completely sufficient. If you hit allocation routines
(e.g.) the whole system enters hickup state :-).

>  Only interrupt
> handlers that don't block on the io-request lock (may it die a horrible
> death) would be allowed to pre-empt this activity.  Even in this case,
> there will be times, albeit much shorter, that this interrupt
> will be blocked by the per-controller spin-lock used to protect
> driver data structures and access to the card's registers.

Well, this is a natural thing. You always have to protect such exclusively
working things like controller registers, but doubtlessly things turn out the
better the less exclusiveness you have (what can be more exclusive than a
hardware interrupt?).

> If your processes are really feeling sluggish, you are probably doing
> *a lot* of I/O.

Yes, of course. I wouldn't have complained in the first place _not_ knowing
that symbios does it better.

> The only thing that might help is some interrupt
> coalessing algorithm in the aic7xxx driver's firmware.  Since these
> chips do not have an easily utilized timer facility any such algorithm
> would be tricky to implement.  I've thought about it, but not enough
> to implement it yet.

I cannot comment on that, I don't know what Gerard really does here.

> >b) long lasting interrupt workloads play bad on other interrupt users 
> >(e.g. on the same shared interrupt)                                   
> 
> Sure.  As the comment suggests, the driver should use a bottom half
> handler or whatever new deferral mechanism is currently the rage
> in Linux.

Do you think this is complex in implementation?

> [...]
> >I can see _both_ comparing aic with symbios.                          
> 
> I'm not sure that you would see much of a difference if you set the
> symbios driver to use 253 commands per-device.

As stated earlier I took both drivers to comparable values (8).

> I would be interresting if there is a disparity in the TPS numbers
> and tag depths in your comparisons.  Higher tag depth usually means
> higher TPS which may also mean less interactive response from the
> system.  All things being equal, I would expect the sym and aic7xxx
> drivers to perform about the same.

I can confirm that. 253 is a bad joke in terms of interactive responsiveness
during high load.
Probably the configured standard value should be taken down remarkably.
253 feels like old IDE.
Yes, I know this comment hurt you badly ;-)
In my eyes the changes required in your driver are _not_ that big. The gain
would be noticeable. I don't say its a bad driver, really not, I would only
suggest some refinement. I know _you_ can do a bit better, prove me right ;-)

Regards,
Stephan

