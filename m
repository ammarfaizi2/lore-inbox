Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131192AbRCGVO4>; Wed, 7 Mar 2001 16:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131190AbRCGVOq>; Wed, 7 Mar 2001 16:14:46 -0500
Received: from m162-mp1-cvx1a.col.ntl.com ([213.104.68.162]:57348 "EHLO
	[213.104.68.162]") by vger.kernel.org with ESMTP id <S131188AbRCGVOd>;
	Wed, 7 Mar 2001 16:14:33 -0500
To: <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Racing power management
In-Reply-To: <9038100.983917051702.JavaMail.imail@digger.excite.com>
	<m2vgpltkrh.fsf@boreas.yi.org.> <3AA6951B.45FDBC1B@mandrakesoft.com>
From: John Fremlin <chief@bandits.org>
Date: 07 Mar 2001 21:13:11 +0000
In-Reply-To: Jeff Garzik's message of "Wed, 07 Mar 2001 15:07:55 -0500"
Message-ID: <m2hf15th94.fsf_-_@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Jeff Garzik <jgarzik@mandrakesoft.com> writes:

> John Fremlin wrote:
> > Why not set up the device driver to handle PM events itself. See
> > Documentation/pm.txt under Driver Interface.
> 
> For PCI drivers, you implement the ::suspend and ::remove hooks.
> 
> > I have a race free version of pm_send_all if you want it.
> 
> Is this the same thing that is in 2.4.3-pre3?

Aarrgh. Looks like Alan Cox got his version in kernel first. (I did
write mine before.)

If I am not mistaken there is one (hypothetical) race still remaining
in Alan's version. Last time I checked the only code doing pm_send_all
was in the i386 APM driver (and so of course there is no chance of any
race at all even with the old version, if I understand correctly).

But suppose there were another pm_send_all caller. APM would decide to
user suspend and call pm_send_all asking for a SUSPEND to check it was
allowed to. While this is happening some clueless loser decides to
pm_send_all RESUME for whatever reason. This loser has to wait until
the APM pm_send_all finishes, but hypothetically and if I am not
mistaken, his pm_send_all RESUME could get in just after the APM
pm_send_all finished and just before APM made the physical BIOS call
to suspend the machine. This would screw stuff up of course.

You may say, this is rather improbable if not impossible, but it does
suggest that it would be a good idea to have locking wrapping
pm_send_all and the hardware machine suspend request. Cue: John's
pmpolicy patch.

Unfortunately, my patch adds another thing as well: /sbin/powermanager
so it got (is getting) trampled on by a lot of people who didn't like
that idea. If anybody wants the race free PM by itself, I can factor
out that bit.

-- 

	http://www.penguinpowered.com/~vii
