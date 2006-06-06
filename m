Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWFFMpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWFFMpR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 08:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWFFMpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 08:45:17 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:25227 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751244AbWFFMpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 08:45:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VH+hxOWSEsrlPaNUO+tPRLWjySJLdcMcSBOerGwAWDhGdLak+NHhBm4LQfjJpEraEBLVRcXZYcEzN12pXLzCb1x7md0kaOQUtXtEho7bJeNUCDcnqkh/z0UZGkjm7C+YqcAUrc219Hz6AObBhDvLXInhdafei3ktciZqhYnH0OA=
Message-ID: <d120d5000606060545n5852360ex8993d8c6f6c922e4@mail.gmail.com>
Date: Tue, 6 Jun 2006 08:45:14 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Anssi Hannula" <anssi.hannula@gmail.com>
Subject: Re: [patch 03/12] input: new force feedback interface
Cc: linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <448565BA.2070805@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060530105705.157014000@gmail.com>
	 <d120d5000606051152p2cf999bcv8d832e007ea02810@mail.gmail.com>
	 <44849DE9.6060305@gmail.com>
	 <200606052202.26019.dtor_core@ameritech.net>
	 <448565BA.2070805@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/06, Anssi Hannula <anssi.hannula@gmail.com> wrote:
> Dmitry Torokhov wrote:
> > On Monday 05 June 2006 17:11, Anssi Hannula wrote:
> >
> >>Dmitry Torokhov wrote:
> >>
> >>>On 5/30/06, Anssi Hannula <anssi.hannula@gmail.com> wrote:
> >>>>--- linux-2.6.17-rc4-git12.orig/drivers/input/input.c   2006-05-27
> >>>>02:28:57.000000000 +0300
> >>>>+++ linux-2.6.17-rc4-git12/drivers/input/input.c        2006-05-27
> >>>>02:38:35.000000000 +0300
> >>>>@@ -733,6 +733,17 @@ static void input_dev_release(struct cla
> >>>> {
> >>>>       struct input_dev *dev = to_input_dev(class_dev);
> >>>>
> >>>>+       if (dev->ff) {
> >>>>+               struct ff_device *ff = dev->ff;
> >>>>+               clear_bit(EV_FF, dev->evbit);
> >>>>+               mutex_lock(&dev->ff_lock);
> >>>>+               del_timer_sync(&ff->timer);
> >>>
> >>>
> >>>This is too late. We need to stop timer when device gets unregistered.
> >>
> >>And what if driver has called input_allocate_device(),
> >>input_ff_allocate(), input_ff_register(), but then decides to abort and
> >>calls input_dev_release()?   input_unregister_device() would not get
> >>called at all.
> >>
> >
> >
> > Right, but if device was never registered there is no device node so noone
> > could start the timer and deleting it is a noop. Hmm, I think even better
> > place would be to stop ff timer when device is closed (i.e. when last user
> > closes file handle).
> >
>
> Hmm... actually, they are stopped in flush(), and IIRC that is always
> called before deleting input_dev.
>

flush is called when you close one file handle. If there are more than
one process opened event device you only want to stop timer when they
all closed ther handles, not when the first one did.

> >
> >>>Clearing FF bits is pointless here as device is about to disappear;
> >>>locking is also not needed because we are guaranteed to be the last
> >>>user of the device structure.
> >>
> >>True, if that guarantee really exists.
> >>
> > Yes, this is guaranteed.
> >
>
> So, now you guarantee it, but it isn't really so? ;)
>

Hmm, I thought I could guarantee it, but not yet ;)

> When we remove locking, timer_del, clear_bit, all that is left is
> kfree() and I guess that has to still be run in the input_dev_release().
>

Yes.

-- 
Dmitry
