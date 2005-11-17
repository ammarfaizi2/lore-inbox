Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161097AbVKQCEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161097AbVKQCEH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 21:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161098AbVKQCEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 21:04:06 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:13636 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161097AbVKQCEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 21:04:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=X6MILARSGYqrOAetNHGQ4LjVBCeiPs1qduhMHcBt+s97yjW4YfjLjazh2dnzIf4j1aagooiWsQKClYwVPtcwhLn+1pTF8NMzCW/XVsc1eRP9Q4afUH1yOVjSkZbm36T5yKTgzN18shyq3iwM/jKADZtp077pNg8Q+vrPkFhEmB4=
Message-ID: <437BE509.1070309@gmail.com>
Date: Thu, 17 Nov 2005 10:03:53 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@2gen.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: X and intelfb fight over videomode
References: <20051117000144.GA29144@hardeman.nu> <437BD8D9.9030904@gmail.com> <20051117014558.GA30088@hardeman.nu>
In-Reply-To: <20051117014558.GA30088@hardeman.nu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Härdeman wrote:
> On Thu, Nov 17, 2005 at 09:11:53AM +0800, Antonino A. Daplas wrote:
>> David Härdeman wrote:
>>> intelfb: Changing the video mode is not supported.
> 
>> Try booting with video=intelfb:1024x768-16@60,mtrr=0. Do not include
>> the vga=0x318 option.  This prevents intelfb from changing the videomode.
> 
> It seems that intelfb can't change it no matter what....booting with
> video=intelfb:1024x768-16@60,mtrr=0 gives me the usual vga console and
> no framebuffer. The following is printed during boot:
> 

Ah, okay, you have a flatpanel display, so you really need vesa to program
the mode.


> Suggestions?
> 

The main problem is that when check_var fails, set_par is not called
which means that the ringbuffer is not set up correctly after switching
from X.

Try this first, then we'll think of a definitive solution later.

Open drivers/video/intelfb/intelfbdrv.c and look at intelfb_check_var().

Look for this particular snippet...

	if (FIXED_MODE(dinfo) &&
	    (change_var ||
	     var->yres_virtual > dinfo->initial_var.yres_virtual ||
	     var->yres_virtual < dinfo->initial_var.yres ||
	     var->xoffset || var->nonstd)) {
		if (first) {
			ERR_MSG("Changing the video mode is not supported.\n");
			first = 0;
		}
		return -EINVAL;
	}


And then insert a line so it looks like this:

	if (FIXED_MODE(dinfo) &&
	    (change_var ||
	     var->yres_virtual > dinfo->initial_var.yres_virtual ||
	     var->yres_virtual < dinfo->initial_var.yres ||
	     var->xoffset || var->nonstd)) {
		if (first) {
			ERR_MSG("Changing the video mode is not supported.\n");
			first = 0;
		}
		intelfb_set_par(info); /* insert this line */
		return -EINVAL;
	}

