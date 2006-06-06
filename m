Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWFFNLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWFFNLh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 09:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWFFNLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 09:11:37 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:10362 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932160AbWFFNLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 09:11:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=nuDhkHjqgUqr84VMReYw+jWI+U39NwHLQOMUy1pt77G78pUWN+X0WMlFQgX0f/AY+n4b/OirQGlaKaPoH5AUIpAxX3kPIn/muJX5Xd9a4DLe1h9dPkkbYqVr4O4jW0mb98+iBA1899zsvAdCJPC6KsPdERf05zgfgIe2QZXZDGk=
Message-ID: <44857EF6.1080403@gmail.com>
Date: Tue, 06 Jun 2006 16:11:18 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6-7.5.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
CC: linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 03/12] input: new force feedback interface
References: <20060530105705.157014000@gmail.com>	 <d120d5000606051152p2cf999bcv8d832e007ea02810@mail.gmail.com>	 <44849DE9.6060305@gmail.com>	 <200606052202.26019.dtor_core@ameritech.net>	 <448565BA.2070805@gmail.com> <d120d5000606060545n5852360ex8993d8c6f6c922e4@mail.gmail.com>
In-Reply-To: <d120d5000606060545n5852360ex8993d8c6f6c922e4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On 6/6/06, Anssi Hannula <anssi.hannula@gmail.com> wrote:
> 
>> Dmitry Torokhov wrote:
>> > On Monday 05 June 2006 17:11, Anssi Hannula wrote:
>> >
>> >>Dmitry Torokhov wrote:
>> >>
>> >>>On 5/30/06, Anssi Hannula <anssi.hannula@gmail.com> wrote:
>> >>>>--- linux-2.6.17-rc4-git12.orig/drivers/input/input.c   2006-05-27
>> >>>>02:28:57.000000000 +0300
>> >>>>+++ linux-2.6.17-rc4-git12/drivers/input/input.c        2006-05-27
>> >>>>02:38:35.000000000 +0300
>> >>>>@@ -733,6 +733,17 @@ static void input_dev_release(struct cla
>> >>>> {
>> >>>>       struct input_dev *dev = to_input_dev(class_dev);
>> >>>>
>> >>>>+       if (dev->ff) {
>> >>>>+               struct ff_device *ff = dev->ff;
>> >>>>+               clear_bit(EV_FF, dev->evbit);
>> >>>>+               mutex_lock(&dev->ff_lock);
>> >>>>+               del_timer_sync(&ff->timer);
>> >>>
>> >>>
>> >>>This is too late. We need to stop timer when device gets unregistered.
>> >>
>> >>And what if driver has called input_allocate_device(),
>> >>input_ff_allocate(), input_ff_register(), but then decides to abort and
>> >>calls input_dev_release()?   input_unregister_device() would not get
>> >>called at all.
>> >>
>> >
>> >
>> > Right, but if device was never registered there is no device node so
>> noone
>> > could start the timer and deleting it is a noop. Hmm, I think even
>> better
>> > place would be to stop ff timer when device is closed (i.e. when
>> last user
>> > closes file handle).
>> >
>>
>> Hmm... actually, they are stopped in flush(), and IIRC that is always
>> called before deleting input_dev.
>>
> 
> flush is called when you close one file handle. If there are more than
> one process opened event device you only want to stop timer when they
> all closed ther handles, not when the first one did.
> 

It doesn't stop the timer explicitely. It only calls the timer
recalculator function and when all file handles are closed => all
effects are deleted => no events => input_ff_recalculate_timer() stops
the timer.

And IIRC when device is being removed, kernel actually waits for the
file handles to be flush()ed before kfree()ing the input_dev.

But hmm, when device is being removed with effects running, and
input_ff_flush() erases effects and calls input_ff_recalculate_timer(),
that function schedules the timer to run immediately to stop the
effects. Therefore we would have a race condition: without locking
dev->ff could be deleted while input_ff_timer() is still running.

That is the reason why del_timer_sync() is in input_dev_release(), to
make sure the input_ff_timer() is no longer running.

-- 
Anssi Hannula

