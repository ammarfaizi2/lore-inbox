Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbTIQNXh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 09:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262754AbTIQNXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 09:23:37 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:39335 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262753AbTIQNXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 09:23:35 -0400
Subject: Re: i810_audio bug (?)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Reza Naima <reza@reza.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030917104237.GB21397@boom.net>
References: <20030917104237.GB21397@boom.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063804925.12279.13.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Wed, 17 Sep 2003 14:22:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-17 at 11:42, Reza Naima wrote:
> 1) first, the original rate (32000) is converted to a new rate ..
> 
> 	rate = (rate * clocking)/48000
> 
> 	where clocking, in my case, is 48566. 

We measure the bitrate of the codec, because a lot of them are clocked
at odd frequencies not the official 48000 (I gather it saves parts). We
then adjust the rate to get what should be the right one.

> 3) This results in the value 31627 that I'm seeing.  Now, is this the
>    actual sample rate, or some internal value used to generate a 32000kbps
>    sample rate?  If so, is it perhaps a bug that dmabuf->rate is being
>    returned rather than newrate?

We take the rate you want, shift it for the 48Khz clock offset then ask
the codec to do that rate. ac97_set_dac_rate returns the value the codec
actually used (which may be quite different), and we then bend that back
the other way for the clocking.

So in your case it is going

         I want 32000
         I need to ask the codec for an adjusted value
         Write codec
         Read codec
         Codec replies 32000 (ie it doesnt do a full range of clocking)
         We realise it means you get 31627

Btw - from my experience with video playback audio clocks are +/- 5%
some of the time even when you ask for a rate it can do so software
needs to be fairly adaptive to such things.

