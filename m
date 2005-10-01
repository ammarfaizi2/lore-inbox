Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbVJAFuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbVJAFuO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 01:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbVJAFuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 01:50:14 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:20904 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750722AbVJAFuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 01:50:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Q0UBPtUYW6JmMqoLdFrMXCVHD5ICiJxhksnO8wo9vL3ZcTzpldGki2X+iIgejXTYABZ30f0VNfFmHmSgpVPLvLgZzOh0KB7EeOLzK8k1A3R1HsdNk39yEhXK/wXcnCywaAP+fdB3ZlTgEUepNpsQBy3eIgRgrDgBe8qU8ShBqtY=
Message-ID: <433E2387.2090608@gmail.com>
Date: Sat, 01 Oct 2005 13:49:59 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Giuseppe Bilotta <bilotta78@hotpop.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Blanky rivafb vs snowy nvidiafb with 2.6.12
References: <1hcq27fp0wwd6.1xosn5xgejhhn$.dlg@40tude.net> <433B049B.1090502@gmail.com> <1gie1vr78iijd$.qcvoypipyouu.dlg@40tude.net> <433BE0D1.1070501@gmail.com> <dsq9rvr3xni3.1py6wljnelhp0.dlg@40tude.net> <433C52F0.6000401@gmail.com> <1hk58zmy4sz0x.kyzvnh8u4ia2.dlg@40tude.net>
In-Reply-To: <1hk58zmy4sz0x.kyzvnh8u4ia2.dlg@40tude.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuseppe Bilotta wrote:
> On Fri, 30 Sep 2005 04:47:44 +0800, Antonino A. Daplas wrote:
> 
>> Giuseppe Bilotta wrote:
>>> On Thu, 29 Sep 2005 20:40:49 +0800, Antonino A. Daplas wrote:
>>>
>>>> Giuseppe Bilotta wrote:
>>>>> On Thu, 29 Sep 2005 05:01:15 +0800, Antonino A. Daplas wrote:
>>>>>
>>>>>> Giuseppe Bilotta wrote:
> 
> What I don't understand, however, is why nvidiafb and xorg's nv give
> different results. Remember, xorg ends up using
> 
> (**) NV(0): *Default mode "1600x1200": 162.0 MHz, 75.0 kHz, 60.0 Hz
> 
> (II) NV(0): Modeline "1600x1200"  162.00  1600 1664 1856 2160  1200
> 1201 1204 1250 +hsync +vsync 
> 

Looks like the nv driver just ignored the EDID and used one of
its built-in VESA modes.  If you notice, X's EDID ouput is the same
as nvidiafb's. But the resulting timings are different.

In contrast, nvidiafb will attempt to use the EDID, and only as a last
resort, use one of the timings in the global mode database.


> """
> 
> and my Modelines go simply like this:
> """
> 	SubSection "Display"
> 		Depth		1
> 		Modes		"1600x1200" "1024x768" "800x600" "640x480"
> 	EndSubSection 
> """
> (for Depth = 1, 4, 8, 15, 16, 24, the latter being the default)

If you don't have a "Modeline" section in Xorg.conf, X will use one of its
timings. 


> 
>> Yes, unfortunately, nvidiafb's hardware initialization routine
>> may disrupt the hardware state, so you need something that will
>> use the framebuffer, such as fbcon.
> 
> D'oh. D'oh. D'oh.
> 
> I *really* need someone to repeatedly and savagely hit me on the head
> with a gigantic, purple-and-yellow CLUEBAT. *sigh*
> 
> Somehow, I just assumed that modprobing for the framebuffer driver
> just loaded everything. But fbcon was *not* automatically load.
> Indeed, modprobing for fbcon allows me to load nvidiafb OR rivafb
> without any more screen garbling/blanking problems!
> 

:-) Yes, many have been burned by this assumption.  If you do want
2.4 behavior, you can compile fbcon statically, nvidiafb as a module.
Doing modprobe nvidiafb will automatically give you a framebuffer
console.

> This allowed me to test the rivafb driver.
> 
> Some interesting results: rivafb reports this:
> 
> """
> rivafb: nVidia device/chipset 10DE0112
> rivafb: nVidia Corporation NV11 [GeForce2 Go]
> rivafb: On a laptop.  Assuming Digital Flat Panel
> rivafb: Detected CRTC controller 1 being used
> rivafb: RIVA MTRR set to ON
> rivafb: could not retrieve EDID from DDC/I2C
> rivafb: setting virtual Y resolution to 52428
> Console: switching to colour frame buffer device 80x30
> rivafb: PCI nVidia NV11 framebuffer ver 0.9.5b (32MB @ 0xE0000000)
> rivafb: mode 1600x1200x16 rejected...resolution too high to fit into
> video memory! 
> """
> 
> Notice how rivafb can't read the EDID from DDC/I2C -- and remark that
> I also have problems reading the EDID with get-edid. Also interesting

read-edid though uses the Video BIOS to grab the EDID.  So even your
card's BIOS is having problems doing i2c/ddc.

> is that rivafb won't let me get to 16 bit depth or higher. By

Hmm, I'll check on that again.

>>>> If possible, you can also get the latest git snapshot then boot with:
>>>>
>>>> video=nvidiafb:1600x1200MR
>>>>
>>>> Note the appended MR - it's CVT with reduced blanking - which is
>>>> for LCD displays especially those manufactured by Dell since they
>>>> are the proponents of CVT.
>>> I'm afraid this will have to wait.
>> That's okay.  I'm not expecting too much from this anyway. I was
>> thinking that the snowy screen might be due to the mode maximizing
>> the bandwidth of the DVI.  So a reduced-blanking calculation, which
>> is not as bandwidth intensive, might be helpful.
> 
> Could be. Especially since I'm only getting very slight snow now, and
> only with deep screens (24 or 32)

Yes, it does look like that the snow can be due to bandwidth limitation.

> 
>>> And while we're talking about Dell: my configuration (GeForce2 Go on
>>> Dell Inspiron 8200 with UXGA monitor 15" at 1600x1200) is known to be
>>> borky even with nVidia's own driver for Windows XP --not all versions
>>> work correctly.
>> Hmm... But X's nv works, right?
> 
> Yes. The interesting thing now is that:
> 
> 1. nv works, and gets the timing right from DDC
> 2. rivafb works, but can't read the EDID

Oh well, I think rivafb and nvidiafb have different i2c timeouts.  I believe
the timeouts in nvidiafb are more correct.

Tony

 

