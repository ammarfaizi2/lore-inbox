Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWHGTEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWHGTEl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 15:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWHGTEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 15:04:40 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:54839 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932315AbWHGTEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 15:04:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VzPkcBHwxKXelA4T4Tw6uAsksw7O4Ooz+hlnee+ivZ3oi3RDVxCLRJoaYkXw+ULkjkWTvk9BY9Ykma5HO6m+Ngsrd0lUCOzLsZpylRxOBZujj8nN+EOz8UdJRwHQUOCqLGj5XqahT9/c3x+Mlbrw+iD3HcZEs4iHEQ6trrVV9NA=
Message-ID: <d120d5000608071204r5870424dmae61033421ef74fd@mail.gmail.com>
Date: Mon, 7 Aug 2006 15:04:36 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch] Crash on evdev disconnect.
In-Reply-To: <20060807181043.GA5476@aehallh.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060807155916.GE5472@aehallh.com>
	 <d120d5000608071035k2ec5b4ffu949a99ad4a8c3d66@mail.gmail.com>
	 <20060807181043.GA5476@aehallh.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/06, Zephaniah E. Hull <warp@aehallh.com> wrote:
> On Mon, Aug 07, 2006 at 01:35:50PM -0400, Dmitry Torokhov wrote:
> > Hi,
> >
> > On 8/7/06, Zephaniah E. Hull <warp@aehallh.com> wrote:
> > >       if (evdev->open) {
> > >               input_close_device(handle);
> > >               wake_up_interruptible(&evdev->wait);
> > >-               list_for_each_entry(list, &evdev->list, node)
> > >+               list_for_each_entry_safe(list, next, &evdev->list, node)
> > >                       kill_fasync(&list->fasync, SIGIO, POLL_HUP);
> >
> > NAK. kill_fasync does not affect the list state so using _safe does
> > not buy us anything.
>
> Sorry, but you're wrong.
>
> Immediately before the kill_fasync call list->node.next is a valid
> pointer, immediately afterwords it is 0x100100, which happens to be
> list_poison.  kill_fasync is triggering a close somehow, evdev_close
> deletes that element of the list, which poisons the next value, which
> can make us crash and burn.
>
> I have a 100% reproducible crash case, which is fixed by the change.
>
> If kill_fasync shouldn't be making it close that's another issue, but at
> the moment it is and this is a fairly non-invasive change which fixes
> it.
>

Unfortunately it does not really fix the problem, it just papers over
the issue. The crash will still happen if for some reason
evdev_release runs at a bad moment.

> > BTW, dtor_core@ameritech.net address is dead, please use
> > dmitry.torokhov@gmail.com or dtor@mail.ru or dtor@isightbb.com.
>
> Noted, recommend updating the entry in MAINTAINERS. :)
>

Already done ;)

-- 
Dmitry
