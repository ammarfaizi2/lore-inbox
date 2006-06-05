Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750881AbWFEVLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWFEVLL (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 17:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbWFEVLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 17:11:11 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:28374 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750881AbWFEVLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 17:11:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=GbICGmdT+7efH5YiZe2bOf+QtnK8TE5QEmzq0nlj+ORFf5dO8w58F3tB7QSOxOWNgwZSM0h3iVITmNcSSeGupCldV1zQhmNf/sTf393hojQXTvrIbj/WAAMhQJY0XszO/RpMFMGXd8tOuopJq5PGoSqYUqpu3f0fqp3qW8PbrmM=
Message-ID: <44849DE9.6060305@gmail.com>
Date: Tue, 06 Jun 2006 00:11:05 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6-7.5.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
CC: linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 03/12] input: new force feedback interface
References: <20060530105705.157014000@gmail.com>	 <20060530110131.136225000@gmail.com> <d120d5000606051152p2cf999bcv8d832e007ea02810@mail.gmail.com>
In-Reply-To: <d120d5000606051152p2cf999bcv8d832e007ea02810@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On 5/30/06, Anssi Hannula <anssi.hannula@gmail.com> wrote:
> 
>> Implement a new force feedback interface, in which all
>> non-driver-specific
>> operations are separated to a common module. This includes handling
>> effect
>> type validations, effect timers, locking, etc.
>>
> 
> Still looking at it, couple of random points for now...
> 
>>
>> The code should be built as part of the input module, but
>> unfortunately that
>> would require renaming input.c, which we don't want to do. So instead
>> we make
>> INPUT_FF_EFFECTS a bool so that it cannot be built as a module.
>>
> 
> I am not opposed to rename input.c, I wonder what pending changes
> besides David's header cleanup Andrew had in mind.
>
>> @@ -865,6 +865,9 @@ struct input_dev {
>>        unsigned long sndbit[NBITS(SND_MAX)];
>>        unsigned long ffbit[NBITS(FF_MAX)];
>>        unsigned long swbit[NBITS(SW_MAX)];
>> +
>> +       struct ff_device *ff;
>> +       struct mutex ff_lock;
> 
> 
> I believe that ff_lock should be part of ff_device and be only used to
> controll access when uploading/erasing effects. The teardown process
> should make sure that device inactive anyway only then remove
> ff_device from input_dev; by that time noone should be able to
> upload/erase effects. Therefore ff_lock is not needed to protect
> dev->ff.
> 

Hmm, I remember testing this by putting a 10 second sleep into the end
of input_ff_effect_upload() and dropping the ff_locking when
unregistering device. Then while in that sleep I unplugged the device.
The dev->ff was indeed removed while the input_ff_effect_upload() was
still running.

Maybe there was/is some bug in the input device unregistering process
that doesn't account for ioctls.

Anyway, I'll retest this issue soon.

> 
>> ===================================================================
>> --- linux-2.6.17-rc4-git12.orig/drivers/input/input.c   2006-05-27
>> 02:28:57.000000000 +0300
>> +++ linux-2.6.17-rc4-git12/drivers/input/input.c        2006-05-27
>> 02:38:35.000000000 +0300
>> @@ -733,6 +733,17 @@ static void input_dev_release(struct cla
>>  {
>>        struct input_dev *dev = to_input_dev(class_dev);
>>
>> +       if (dev->ff) {
>> +               struct ff_device *ff = dev->ff;
>> +               clear_bit(EV_FF, dev->evbit);
>> +               mutex_lock(&dev->ff_lock);
>> +               del_timer_sync(&ff->timer);
> 
> 
> This is too late. We need to stop timer when device gets unregistered.

And what if driver has called input_allocate_device(),
input_ff_allocate(), input_ff_register(), but then decides to abort and
calls input_dev_release()?   input_unregister_device() would not get
called at all.

> Clearing FF bits is pointless here as device is about to disappear;
> locking is also not needed because we are guaranteed to be the last
> user of the device structure.

True, if that guarantee really exists.

> I wonder if ff should be released right at unregister time...
> 
>> +               dev->flush = NULL;
>> +               dev->ff = NULL;
>> +               mutex_unlock(&dev->ff_lock);
>> +               kfree(ff);
>> +       }
>> +
>>        kfree(dev);
>>        module_put(THIS_MODULE);
>>  }
> 
> 
>> +static inline int input_ff_safe_lock(struct input_dev *dev)
>> +{
>> +       mutex_lock(&dev->ff_lock);
>> +       if (dev->ff)
>> +               return 0;
>> +
>> +       mutex_unlock(&dev->ff_lock);
>> +       return 1;
>> +}
> 
> 
> This needs to go away. Users should check whether a device supports FF
> and if it is then it is device's responsibility to keep it there until
> untregister time. We don't expect FF capabilities to flip/flop on a
> live device.

This too can be removed if it is guaranteed that the device is not
deleted while ioctl is executing.

>> +static void input_ff_calc_timer(struct ff_device *ff)
>> +{
>> +       int i;
>> +       int events = 0;
>> +       unsigned long next_time = 0;
> 
> ...
> 
>> +
>> +               if (time_after(jiffies, event_time)) {
>> +                       event_time = jiffies;
> 
> 
> Should it be next_time = jiffies? We want to schedule thetimer ASAP, right?

Yes, a good catch.

>> +
>> +/**
>> + * abs() with -0x8000 => 0x7fff exception
>> + */
>> +static inline u16 input_ff_unsign(s16 value)
>> +{
>> +       if (value == -0x8000)
>> +               return 0x7fff;
>> +
>> +       return (value < 0 ? -value : value);
>> +}
> 
> 
> Why is it needed?

Oh, well... the maximum value of s16 is 0x7fff in positive side, -0x8000
in negative side. In input_ff_sum_effect() (apparently the only function
that uses this) the "i = i * gain / 0x7fff" uses the maximum value of
0x7fff.

Then again, I guess it wouldn't really matter if that exception is just
skipped and then detect the small overflow in input_ff_safe_sum().

> 
>> +
>> +/**
>> + * Safe sum
>> + * @a: Integer to sum
>> + * @b: Integer to sum
>> + * @limit: The sum limit
>> + *
>> + * If @a+@b is above @limit, return @limit
>> + */
>> +static int input_ff_safe_sum(int a, int b, int limit)
>> +{
>> +       int c;
>> +       if (!a)
>> +               return b;
>> +       c = a + b;
>> +       if (c > limit)
>> +               return limit;
>> +       return c;
>> +}
> 
> 
> As it was mentioned the result will not be limited if a == 0. Is it
> intended?

Well, b is guaranteed by the caller to be below the limit. However, if
that input_ff_unsign() stuff is dropped in favor of abs(), b could be
above limit and then if(!a) should be dropped.

> PLease don;t start making any changes yet, I am still looking...
> 

Ok.

-- 
Anssi Hannula

