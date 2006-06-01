Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965081AbWFAAvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965081AbWFAAvE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 20:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965107AbWFAAvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 20:51:04 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:49139 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965081AbWFAAvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 20:51:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=qVIDSaf5Y2qetdyppmly1ySr9flQxkQ6as7MSjA+4bn1mD2QyTG5VnAUvux3dlQLAKG9lOEFJiWuRlIKhlIhqknV3T5c6Tks92vXoHPrW7GdjEXoZqvUpiWT0E93xl+xMDOXKvxtyqcSUXWHkP846ozdmNMwcJVIX+5IuXoro4E=
Message-ID: <447E39DD.7000007@gmail.com>
Date: Thu, 01 Jun 2006 08:50:37 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: "D. Hazelton" <dhazelton@enter.net>, Dave Airlie <airlied@gmail.com>,
       Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>	 <200605302314.25957.dhazelton@enter.net>	 <9e4733910605302116s5a47f5a3kf0f941980ff17e8@mail.gmail.com>	 <200605310026.01610.dhazelton@enter.net> <9e4733910605302139t4f10766ap86f78e50ee62f102@mail.gmail.com>
In-Reply-To: <9e4733910605302139t4f10766ap86f78e50ee62f102@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 5/30/06, D. Hazelton <dhazelton@enter.net> wrote:
>> On Wednesday 31 May 2006 04:16, Jon Smirl wrote:
>> > On 5/30/06, D. Hazelton <dhazelton@enter.net> wrote:
>> > > Like I've said, this has gone onto my list. Now to get back to the
>> > > code... I really do want to see about getting this stuff into the
>> kernel
>> > > ASAP.
>> >
>> > You might want to leave the DRM hot potato alone for a while and just
>> > work on fbdev. Fbdev is smaller and it is easier to get changes
>> > accepted.
>>
>> Yes, but I have accepted that there is a certain direction and order the
>> maintainers want things done in. For this reason I can't just leave DRM
>> alone.
> 
> fbdev (Antonino A. Daplas <adaplas@gmail.com>) and DRM (Dave Airlie
> <airlied@gmail.com>) have two different maintainers. I have not seen
> Tony comment on what he thinks of Dave's plans so I don't know what
> his position is how driver merging can be acomplished.
> 

A minimal framebuffer driver is nothing but a pointer to a structure
(struct fb_info) which contains a pointer to a memory and the description
of the layout of this memory. There is nothing there that absolutely
requires the services of the kernel, nor requires touching the hardware.
If you look at vesafb, the only time it touches the hardware is in
setcolreg (only if in pseudocolor), and pan_display, which is an optional
function.

The point here is that you can do the mode setting anywhere, including in
userland.  Describe this mode as struct fb_info and register it to
the framebuffer core, you already have a working driver and a working
console.

So, it should be easy enough to write a kernel framebuffer module that
listens to userland, waiting for a struct fb_info to arrive. The userland
driver can be anything, it can be a simple driver that executes a few VBE
function calls, or a driver that uses a library, such as svgalib or Xorg.
Add a few user API's for setcolreg and pan_display, and it will be a complete
driver. Optionally, to fully accelerate the console, we only need these in X:

ScreenToScreenCopy
SolidFill
CPUToScreenColorExpand

Once the X library is used for this userland driver, we have eliminated the
problem of fbdev conflicting with X or DRM. (This assumes that we can load
an X instance at bare minimum, ie, without capturing the keyboard or the mouse).

I believe that there will be problems that I haven't foreseen (trustworthiness
of this driver?), but personally it's the best way to go, as we can work on
one subsystem without affecting the others and without breaking compatibility.
It should also be easy to work on, as the framebuffer layer has the simplest
architecture among the three.

Tony 



  




  

