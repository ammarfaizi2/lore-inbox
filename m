Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965046AbVLNWng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbVLNWng (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 17:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbVLNWnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 17:43:35 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:26568 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965046AbVLNWnf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 17:43:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=HPmgvmXXh+v5RKfA6eZ0cEJJxvINUls8oY6ZFFnoBJaQVvYXJt0XM8iuIofZCEswne8xX2r2GnIxUHjvw8kUj3ndJRFByR11z66kPRf5CEmfsdzk+Uaz4KYQ6j7vwz+sclhOu4rtLG/JoCuOJVjIlmOLkYAEWuV7CoPJirFy0D4=
Message-ID: <43A0A012.9070300@gmail.com>
Date: Thu, 15 Dec 2005 06:43:30 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Knut Petersen <Knut_Petersen@t-online.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] Re: [PATCH 1/1: 2.6.15-rc5-git3] Fixed and
 updated CyblaFB
References: <439EF4CB.8030007@t-online.de> <43A03568.6010602@gmail.com> <43A06771.6060808@t-online.de>
In-Reply-To: <43A06771.6060808@t-online.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Knut Petersen wrote:
> Antonino Daplas wrote:
> 
>> But current users of cyblafb will be affected if your patch
>> does have a problem.
>>
>>  
>>
> They definitely will be affected when they lock their system
> while trying rotation options ...

You can always divide the patch into bug fix and feature addition.
The bug fix goes to mainline, the feature addition goes into trial.

It's also easier to spot regressions if you divide the patch into
logical parts. For example, the recent atyfb update was composed of
10 different patches, each doing 1 logical thing.

> 
>>> +    // That should never happen, but it would be fatal
>>>   
>>
>> It won't :-)
>>
>>  
>>
> The graphics engine would not react kindly, and it does not really hurt.
> 
>>> +    if (image->width == 0 || image->height == 0) {
>>> +        output("imageblit: width/height 0 detected\n");
>>> +        return;
>>> +    }
>>> +
>>> +    if (bpp < 8 || bpp > 32 || bpp % 8 != 0 ||
>>> +                   info->pixmap.scan_align > 4 ) {
>>>   
>> Why this paranoid check?  The check_var() function already
>> guaranteed that these conditions will not happen.
>>
>>  
>>
> Yes, I am a bit paranoid. That paranoia led to the discovery of some bugs
> nobody knew or cared about. But you are right, this check might be a bit
> too
> paranoid.

Well yes.  But this is a fast path that will affect performance.  And the
check will tend to hide bugs than reveal them (though you do have a printk
function).  And thirdly, cfb_imageblit does not support scan_align != 1.

> 
>> Do you really have to support scan_align 1 and 2?  Why not just stick
>> with scan_align of 4, the code is so much easier to understand? I can't
>> find anything useful with this, even for debugging.
>>
>>  
>>
> Well, you are shure that there is really not a single bug left in the
> bitmap construction
> code? And that the code will never be touched again because it already
> is optimal? I
> think support for all alignment possibilities will be handy in the near
> future, and
> although it could be hidden by an #ifdef or stay a private patch, I
> prefer to include it.

It's the same code whether you use scan_align of 1, 2, 4, 8, 16, etc. So,
I still don't see any benefit. You even confused akpm et al at what it does,
why you need to cast with u32. (It's because the accelerator needs u32
values, but supporting scan_align 1 and 2 means the bitmap becomes aligned
at u8 and u16 boundaries).

> 
> Currently bitmap construction takes longer than blitting the image to
> the screen with
> cyblafb, and I think I will have a very close look at that code soon.
> 
> BTW, something fundamental: Isn´t the pixelmap alignment really a
> property of the
> image bitmap like the depth of the image data?

No, it's the property of the accelerator.

> 
>>> +    // try to be smart about (x|y)res(_virtual) problems.
>>> +    //
>>> +    if (var->xres % 8 != 0)
>>>        return -EINVAL;
>>>   
>>
>> Isn't this too much?  Why not var->xres = (var->xres + 7) & ~7?
>>
>>  
>>
> Do you really think that this is a good idea? I would like to ease the
> use of
> e.g. fbset in scripts by returning -EINVAL when something as fundamental as
> the selected xres is not acceptable. Ok, it´s always possible to parse
> the output
> of fbset -s  in those cases.

That has always been the (not often followed) rule - Round up if you can,
return -EINVAL if you can't.  Because with most user apps, finding the best
mode involves many iterations of FB_ACTIVATE_TEST, so that particular method
will be speeded up if you give working values rather than -EINVAL.  And yes,
properly working fb apps will check the contents of fb_var_screeninfo even if
the check_var returns success.

If your user will set something crazy like 799x600, might as well give him
an 800x600. As long as you use values that are higher than requested,
it won't hurt. 

Tony
