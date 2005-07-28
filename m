Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbVG1XT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbVG1XT5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 19:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbVG1XT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 19:19:57 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:63985 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261726AbVG1XT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 19:19:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=QZQqMEBqIag/d76psZAjibjyPb4zdvA/6uoYcY/ToYHTl/eghzZldLthVPwcMYwEGhMf1fUcEs91xVmemcTqkkNSAcHh7z2an+66b3DmXO42Ci+GGxFIMoyBl0DiGJhTx1LunmH8OY7JgZ3uazFJdV9EORlzvfvaqNrvnixPRCk=
Message-ID: <42E96814.8030005@pol.net>
Date: Fri, 29 Jul 2005 07:19:48 +0800
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
CC: "Antonino A. Daplas" <adaplas@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: colormap fixes
References: <200507280031.j6S0V3L3016861@hera.kernel.org> <Pine.LNX.4.62.0507280952140.24391@numbat.sonytel.be> <9e473391050728060741040424@mail.gmail.com> <42E8F0CD.6070500@gmail.com> <Pine.LNX.4.62.0507281758080.24391@numbat.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0507281758080.24391@numbat.sonytel.be>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
From: "Antonino A. Daplas" <adaplas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:
> On Thu, 28 Jul 2005, Antonino A. Daplas wrote:
>> Jon Smirl wrote:
>>> On 7/28/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>>> On Wed, 27 Jul 2005, Linux Kernel Mailing List wrote:
>>> There are a couple of ways to fix this. 
>>> 1) Add a check to limit use of the sysfs attributes to 256 entries. If
>>> you want more you have to use /dev/fb0 and the ioctl. More is an
>>> uncommon case.
>>> 2) Switch this to a binary parameter. Now you have to use tools like
>>> hexdump instead of cat to work with the data. It was nice to be able
>>> to use cat to see the current map.
>>>
>>> Does anyone have preferences for which way to fix it?
>> Or...
>>
>>  3) Add another file in sysfs which specifies at what index and how many
>> entries will be read or written from or to the cmap. With this additional
>> sysfs file, it should be able to handle any reasonable cmap length, but
>> it will take more than one reading of the color_map file. Another
>> advantage is that the entire color map need not be read or written if
>> only one field needs to be changed.
>>
>> I've attached a test patch.  Let me know what you think.
> 
> I like it! ... But, a disadvantages is that it needs to store state between two
> non-atomic operations. E.g. imagine two processes doing this at the same time.

We can add a check that if the incoming buffer index start and length does
not match the current start and len (as set by cmap_range), then exit with
and empty buffer.

Conversely, users  can always check if the output read from color_map matches
the value it entered in cmap_range.

As a side note:

The rest of the fbsysfs attributes suffer from the same thing, especially since the
value of each attribute depends on each other.  What if one process reads the
virtual_size, while another one changes the bits_per_pixel?  I'm pretty sure that
setting bits_per_pixel to a higher value will almost always change the virtual_size.

Currently, the only way to guarantee atomicity is to use the ioctls. The main
reason why we change the video mode, framebuffer format, color format, etc in one
go with fb_set_var() is precisely this.

Tony


 
