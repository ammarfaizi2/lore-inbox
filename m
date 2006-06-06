Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751210AbWFFCC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWFFCC3 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 22:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWFFCC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 22:02:28 -0400
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:30106 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751210AbWFFCC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 22:02:28 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: [patch 03/12] input: new force feedback interface
Date: Mon, 5 Jun 2006 22:02:25 -0400
User-Agent: KMail/1.9.1
Cc: linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@osdl.org>
References: <20060530105705.157014000@gmail.com> <d120d5000606051152p2cf999bcv8d832e007ea02810@mail.gmail.com> <44849DE9.6060305@gmail.com>
In-Reply-To: <44849DE9.6060305@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606052202.26019.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 June 2006 17:11, Anssi Hannula wrote:
> Dmitry Torokhov wrote:
> > On 5/30/06, Anssi Hannula <anssi.hannula@gmail.com> wrote:
> > 
> >> Implement a new force feedback interface, in which all
> >> non-driver-specific
> >> operations are separated to a common module. This includes handling
> >> effect
> >> type validations, effect timers, locking, etc.
> >>
> > 
> > Still looking at it, couple of random points for now...
> > 
> >>
> >> The code should be built as part of the input module, but
> >> unfortunately that
> >> would require renaming input.c, which we don't want to do. So instead
> >> we make
> >> INPUT_FF_EFFECTS a bool so that it cannot be built as a module.
> >>
> > 
> > I am not opposed to rename input.c, I wonder what pending changes
> > besides David's header cleanup Andrew had in mind.
> >
> >> @@ -865,6 +865,9 @@ struct input_dev {
> >>        unsigned long sndbit[NBITS(SND_MAX)];
> >>        unsigned long ffbit[NBITS(FF_MAX)];
> >>        unsigned long swbit[NBITS(SW_MAX)];
> >> +
> >> +       struct ff_device *ff;
> >> +       struct mutex ff_lock;
> > 
> > 
> > I believe that ff_lock should be part of ff_device and be only used to
> > controll access when uploading/erasing effects. The teardown process
> > should make sure that device inactive anyway only then remove
> > ff_device from input_dev; by that time noone should be able to
> > upload/erase effects. Therefore ff_lock is not needed to protect
> > dev->ff.
> > 
> 
> Hmm, I remember testing this by putting a 10 second sleep into the end
> of input_ff_effect_upload() and dropping the ff_locking when
> unregistering device. Then while in that sleep I unplugged the device.
> The dev->ff was indeed removed while the input_ff_effect_upload() was
> still running.
> 
> Maybe there was/is some bug in the input device unregistering process
> that doesn't account for ioctls.
> 
> Anyway, I'll retest this issue soon.
>

And it will fail, locking is missing many parts of input core. Notice I
said _should_, not will ;) I was trying to paint how it should work when
we have proper locking and I don't want to use ff_lock to paper over
some bugs in the core.
 
> > 
> >> ===================================================================
> >> --- linux-2.6.17-rc4-git12.orig/drivers/input/input.c   2006-05-27
> >> 02:28:57.000000000 +0300
> >> +++ linux-2.6.17-rc4-git12/drivers/input/input.c        2006-05-27
> >> 02:38:35.000000000 +0300
> >> @@ -733,6 +733,17 @@ static void input_dev_release(struct cla
> >>  {
> >>        struct input_dev *dev = to_input_dev(class_dev);
> >>
> >> +       if (dev->ff) {
> >> +               struct ff_device *ff = dev->ff;
> >> +               clear_bit(EV_FF, dev->evbit);
> >> +               mutex_lock(&dev->ff_lock);
> >> +               del_timer_sync(&ff->timer);
> > 
> > 
> > This is too late. We need to stop timer when device gets unregistered.
> 
> And what if driver has called input_allocate_device(),
> input_ff_allocate(), input_ff_register(), but then decides to abort and
> calls input_dev_release()?   input_unregister_device() would not get
> called at all.
> 

Right, but if device was never registered there is no device node so noone
could start the timer and deleting it is a noop. Hmm, I think even better
place would be to stop ff timer when device is closed (i.e. when last user
closes file handle).

> > Clearing FF bits is pointless here as device is about to disappear;
> > locking is also not needed because we are guaranteed to be the last
> > user of the device structure.
> 
> True, if that guarantee really exists.
>

Yes, this is guaranteed.

-- 
Dmitry
