Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbVK2AON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbVK2AON (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 19:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbVK2AON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 19:14:13 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:53632 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932097AbVK2AOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 19:14:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=oqdJlmr4nBID+uPl7qfUizTCe/BC56ybgse1sc4GtXjK8fp6QkxtbOFRtCknK+IK5gjys4XL1ze2AKXj0t/85ogV5Q7CXzY8lJX3WAO+6/q5gU910uJXMhrult7EKWEgzR/42ynMdzF4YRuCgwOmnZBFM2fgBXeyzJX1DxkWVlo=
Message-ID: <438B9D28.9030206@gmail.com>
Date: Tue, 29 Nov 2005 08:13:28 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Marc Koschewski <marc@osknowledge.org>,
       "Calin A. Culianu" <calin@ajvar.org>, akpm@osdl.org, adaplas@pol.net,
       linux-kernel@vger.kernel.org
Subject: Re: nvidia fb flicker
References: <Pine.LNX.4.64.0511252358390.25302@rtlab.med.cornell.edu> <20051128103554.GA7071@stiffy.osknowledge.org> <438AF8A2.6030403@gmail.com> <20051128132035.GA7265@stiffy.osknowledge.org> <438B0D89.1080400@gmail.com> <20051128212418.GA7185@stiffy.osknowledge.org> <438B82A4.4030107@gmail.com> <Pine.LNX.4.64.0511281450260.3263@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511281450260.3263@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 29 Nov 2005, Antonino A. Daplas wrote:
>> Nov 28 14:02:32 stiffy kernel: Extrapolated
>> Nov 28 14:02:32 stiffy kernel:            H: 75-75KHz V: 60-60Hz DCLK: 162MHz
>>
>> Since the min and max value of the sync timings are equal, nvidiafb has
>> no room left to verify the timings, and will _always_ reject any timings even
>> if they are valid.
>>
>> So, try this patch, we make nvidiafb less restrictive by ignoring the
>> hsync and vsync ranges if the min and max values are equal. This should
>> make your hardware display properly even if CONFIG_FB_NVIDIA_I2c = y.
> 
> Tony,
> 
>  may I suggestinstead making the verifier allow a small error?
> 
> I don't find it at all unlikely that some EDID blocks might say that only 
> a 60Hz refresh rate is allowed. A lot of LCD's are literally specced for 
> that (just read their manuals), even though they often in practice allow 
> other frequencies (often _wildly_ different - most modern LCD's are 
> perfectly happy to sync up with almost anything).
> 
> And if a monitor says that it wants a vertical frequency of 60Hz, a mode 
> that has a frequency of 59 should certainly be accepted.
> 
> So it sounds like something has marked a perfectly valid mode as invalid, 
> just because it's not _exactly_ at the frequency.
> 
> So how about allowing a small error in the frequencies in 
> fb_validate_mode()? And make sure to try to round the divisions to 
> nearest, not down. Something like the appended (totally untested)..
> 

Yes, your patch looks good, and will fix some of the reports I've received.

However, after giving it some more thought, I believe my original
reasoning is probably incorrect.  Because if nvidiafb rejected the
mode timings, nvidiafb would not have loaded at all, but it did.

Which leads me to conclude that Calin's display EDID, specifically the
timing information, is totally garbage.

Calin, can you verify? Set CONFIG_FB_NVIDIA_I2C = y.

First, apply Linus' patch, then boot without any options.  If you get a
nice display, then my original reasoning is correct, and Linus' patch
is all we need.

Secondly, if you get a corrupt display after doing the above, then apply
my patch and boot without any options.  If you get a working display,
something is wrong with Linus' patch :-)  But most probably you'll also get
a corrupt display, so...

Finally, boot with video=nvidiafb:1600x1200MR@60.  If you reach this stage
and you get a working display, then the conclusion is that you have a
garbage EDID block :-).  And we will need both Linus' patch plus another
patch, perhaps a boot option that tells nvidiafb to totally ignore the
EDID block. (We don't want to disable the i2c bus because this is still
useful in userspace).

Tony

