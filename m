Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWFFLZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWFFLZX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 07:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWFFLZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 07:25:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:51324 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751257AbWFFLZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 07:25:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=nZ0rdcShnRwX+sHypwRg5z2E3ZpXHS8iURM+C7CRelPyLCMM9PV2B/YV+yfCAX84ScStYxwH2OveIV//J2aNOkh0XC0Z2zVNWg9g/6NTnQwT+jWrPTCSrrY9gNsp8nhoKDQbOi13BwQ6ICA7pK3s9elLaAqOVbwHPJSamnrqmF8=
Message-ID: <448565BA.2070805@gmail.com>
Date: Tue, 06 Jun 2006 14:23:38 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6-7.5.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 03/12] input: new force feedback interface
References: <20060530105705.157014000@gmail.com> <d120d5000606051152p2cf999bcv8d832e007ea02810@mail.gmail.com> <44849DE9.6060305@gmail.com> <200606052202.26019.dtor_core@ameritech.net>
In-Reply-To: <200606052202.26019.dtor_core@ameritech.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On Monday 05 June 2006 17:11, Anssi Hannula wrote:
> 
>>Dmitry Torokhov wrote:
>>
>>>On 5/30/06, Anssi Hannula <anssi.hannula@gmail.com> wrote:
>>>
>>>
>>>>Implement a new force feedback interface, in which all
>>>>non-driver-specific
>>>>operations are separated to a common module. This includes handling
>>>>effect
>>>>type validations, effect timers, locking, etc.
>>>>
>>>
>>>Still looking at it, couple of random points for now...
>>>
>>>
>>>>The code should be built as part of the input module, but
>>>>unfortunately that
>>>>would require renaming input.c, which we don't want to do. So instead
>>>>we make
>>>>INPUT_FF_EFFECTS a bool so that it cannot be built as a module.
>>>>
>>>
>>>I am not opposed to rename input.c, I wonder what pending changes
>>>besides David's header cleanup Andrew had in mind.
>>>
>>>
>>>>@@ -865,6 +865,9 @@ struct input_dev {
>>>>       unsigned long sndbit[NBITS(SND_MAX)];
>>>>       unsigned long ffbit[NBITS(FF_MAX)];
>>>>       unsigned long swbit[NBITS(SW_MAX)];
>>>>+
>>>>+       struct ff_device *ff;
>>>>+       struct mutex ff_lock;
>>>
>>>
>>>I believe that ff_lock should be part of ff_device and be only used to
>>>controll access when uploading/erasing effects. The teardown process
>>>should make sure that device inactive anyway only then remove
>>>ff_device from input_dev; by that time noone should be able to
>>>upload/erase effects. Therefore ff_lock is not needed to protect
>>>dev->ff.
>>>
>>
>>Hmm, I remember testing this by putting a 10 second sleep into the end
>>of input_ff_effect_upload() and dropping the ff_locking when
>>unregistering device. Then while in that sleep I unplugged the device.
>>The dev->ff was indeed removed while the input_ff_effect_upload() was
>>still running.
>>
>>Maybe there was/is some bug in the input device unregistering process
>>that doesn't account for ioctls.
>>
>>Anyway, I'll retest this issue soon.
>>
> 
> 
> And it will fail, locking is missing many parts of input core. Notice I
> said _should_, not will ;) I was trying to paint how it should work when
> we have proper locking and I don't want to use ff_lock to paper over
> some bugs in the core.
>  

Ah, ok.

>>>>===================================================================
>>>>--- linux-2.6.17-rc4-git12.orig/drivers/input/input.c   2006-05-27
>>>>02:28:57.000000000 +0300
>>>>+++ linux-2.6.17-rc4-git12/drivers/input/input.c        2006-05-27
>>>>02:38:35.000000000 +0300
>>>>@@ -733,6 +733,17 @@ static void input_dev_release(struct cla
>>>> {
>>>>       struct input_dev *dev = to_input_dev(class_dev);
>>>>
>>>>+       if (dev->ff) {
>>>>+               struct ff_device *ff = dev->ff;
>>>>+               clear_bit(EV_FF, dev->evbit);
>>>>+               mutex_lock(&dev->ff_lock);
>>>>+               del_timer_sync(&ff->timer);
>>>
>>>
>>>This is too late. We need to stop timer when device gets unregistered.
>>
>>And what if driver has called input_allocate_device(),
>>input_ff_allocate(), input_ff_register(), but then decides to abort and
>>calls input_dev_release()?   input_unregister_device() would not get
>>called at all.
>>
> 
> 
> Right, but if device was never registered there is no device node so noone
> could start the timer and deleting it is a noop. Hmm, I think even better
> place would be to stop ff timer when device is closed (i.e. when last user
> closes file handle).
> 

Hmm... actually, they are stopped in flush(), and IIRC that is always
called before deleting input_dev.

> 
>>>Clearing FF bits is pointless here as device is about to disappear;
>>>locking is also not needed because we are guaranteed to be the last
>>>user of the device structure.
>>
>>True, if that guarantee really exists.
>>
> Yes, this is guaranteed.
> 

So, now you guarantee it, but it isn't really so? ;)

When we remove locking, timer_del, clear_bit, all that is left is
kfree() and I guess that has to still be run in the input_dev_release().

-- 
Anssi Hannula

