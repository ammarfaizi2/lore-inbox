Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279923AbRJ3L3w>; Tue, 30 Oct 2001 06:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279922AbRJ3L3h>; Tue, 30 Oct 2001 06:29:37 -0500
Received: from adsl-63-194-232-126.dsl.lsan03.pacbell.net ([63.194.232.126]:21256
	"HELO alpha.dyndns.org") by vger.kernel.org with SMTP
	id <S279920AbRJ3L2U>; Tue, 30 Oct 2001 06:28:20 -0500
Message-ID: <3BDE9251.3010901@alpha.dyndns.org>
Date: Tue, 30 Oct 2001 03:43:13 -0800
From: Mark McClelland <mark@alpha.dyndns.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: video4linux-list@redhat.com
CC: livid-gatos@linuxvideo.org, linux-kernel@vger.kernel.org,
        volodya@mindspring.com
Subject: Re: [V4L] Re: [RFC] alternative kernel multimedia API
In-Reply-To: <Pine.LNX.4.20.0110290807280.17469-100000@node2.localnet.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I realize Gerd already replied to this, but I just had to throw in my 2 
cents...

volodya@mindspring.com wrote:

>On Mon, 29 Oct 2001, Gerd Knorr wrote:
>
>I already got a report from the user that in his kernel
>video_register_device has 2 arguments and not 3. This is pain to deal with
>in drivers distributed separately from kernel tree.
>
It's an internal kernel interface, not an ioctl. Yeah, it's a PITA, but 
that's the price of progress. Just #ifdef it like I did in 
http://alpha.dyndns.org/ov511/download/ov511.c

>The way you write device specific appliacation is by including kernel
>headers. If the stuff we want is not there makes a lot trouble for
>installing and maintaining code.
>
That's flat-out wrong. Read the linux-kernel archives and see what Linus 
thinks about including kernel headers, esp. regarding glibc. Apps should 
keep a private copy of the header(s). This is what I do with my (yet to 
materialize) ov511-control app, and it works OK, even across ioctl changes.

>>You can't.  But I don't see why this is a issue:  The only thing a
>>application can handle easily are controls like contrast/hue where the
>>only thing a application needs to do is to map it to a GUI and let the
>>user understand and adjust stuff.  The other stuff has way to much
>>non-trivial dependences, I doubt a application can blindly use new
>>driver features.
>>
>Have you ever thought that the reason we only use these controls is
>because they are the only ones easy to implement now ?
>
What I don't understand is how will your driver implement these controls 
in a generic V4L3  GUI control app automatically? No matter how powerful 
the semantic information you give to the app is, it can still only build 
interfaces from standard GUI components that it already knows about. The 
app cannot build a gamma curve control on its own. If it could, we 
wouldn't need programmers anymore :)

So, the real issue here is not whether a string-parsing API is 
ultimately more powerful than ioctls. It probably is, but at the expense 
of code size, speed, and things like:

SET GAMMA_TABLE_ENTRY 56742="exec("/bin/sh")"

The real issue is which is more maintainable. Since you have to update 
the kernel when you add new features to your (in-kernel) driver, adding 
#defines to videodev.h doesn't take much extra work.

>>>      * what do I do if someone uses the same ioctl in the kernel source
>>>
>>???
>>
>Same ioctl number, in the kernel headers..
>
Conflicts can happen, but they will usually be caught when merging 
patches into the mainline kernel. If not, then it is probably because 
someone screwed up and redefined ioctls from public ranges in their 
driver's header. That's what private ranges are for.

The same thing can happen with any name/number space, including the one 
you have devised.

>>>What if the driver does not support counting dropped frames ?
>>>
>>-EINVAL or something like that.
>>
>But supports every other field.
>
Then don't report any dropped frames (hardcode it to zero). If the 
driver can't detect dropped frames, then how will telling the app that 
it can't make any difference? The app can detect it via the frames' 
timecodes if it has to.

>>>What if there is a control with no min/max limits ?
>>>
>>Do you have a example?
>>
>Overlay color key - this is basically an RGB pixel value.
>
Export it as three integers, with range of 0-255. Remember, most 
settings values ultimately end up in integer (or less) sized hardware 
registers. Ones that don't are special cases, which can be set via a 
private ioctl. Regardless of how settings are communicated between the 
control-app and driver, you will have to build a custom GUI component 
for any oddball setting.

>>Multiple choice controls have strings for each value.
>>
>With no way to pass strings (and their meaning) from the driver to the
>user applications.
>
See struct v4l2_querymenu

>>>Can I set/read gamma values ?
>>>
>>Gamma values yes (tables no).
>>
While I appreciate the creativity and originality of your API proposal 
(not to mention the time you took to write it; you'd have to pay me $$$ 
to do that much work), I must ask: Why should we dump V4L/V4L2 and 
rewrite all of our apps and drivers, just to save you the trouble of 
adding one (private) ioctl? Is your hardware really that difficult to 
fit into V4L2?

-- 
Mark McClelland
mmcclell@bigfoot.com
PGP public key fingerprint: 317C 58AC 1B39 2AB0 AB96  EB38 0B6F 731F 3573 75CC



