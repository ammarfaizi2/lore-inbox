Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbWGLJVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbWGLJVS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 05:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWGLJVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 05:21:18 -0400
Received: from javad.com ([216.122.176.236]:26128 "EHLO javad.com")
	by vger.kernel.org with ESMTP id S1751051AbWGLJVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 05:21:17 -0400
From: Sergei Organov <osv@javad.com>
To: Andy Gay <andy@andynet.net>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] Airprime driver improvements to allow full speed EvDO
 transfers
References: <1151646482.3285.410.camel@tahini.andynet.net>
	<874pxof0xl.fsf@javad.com>
	<1152644133.20072.323.camel@tahini.andynet.net>
Date: Wed, 12 Jul 2006 13:20:48 +0400
In-Reply-To: <1152644133.20072.323.camel@tahini.andynet.net> (Andy Gay's
	message of "Tue, 11 Jul 2006 14:55:32 -0400")
Message-ID: <87zmffdvrj.fsf@javad.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Gay <andy@andynet.net> writes:
> On Tue, 2006-07-11 at 22:31 +0400, Sergei Organov wrote:
>> Andy Gay <andy@andynet.net> writes:

[...]

>> > +		/* something happened, so free up the memory for this urb /*
>> 
>> There should be '*/' at the end of this line, not '/*', otherwise the
>> driver even doesn't compile.
>
> Sure. I posted an updated version including that fix -
> http://lkml.org/lkml/2006/7/3/280

OK, I've forgot about that one, sorry.

[...]

>> 
>> After these fixes, I've been able to run the driver with my own USB
>> device and achieved about 320 Kbytes/s read speed. That's still not very
>> exciting as I have another driver here in development that seems to be
>> able to do about 650 Kbytes/s with the same device.
>> 
> Nice. That's over 5Mbits/sec!
>
> Is that on an EvDO network? I didn't know they could go that fast. The
> EvDO network I'm testing on can only manage about 1Mbit/sec at best.

No, it is not, -- that's my own device I write firmware for. In our
earlier discussion about high-speed bulk-to-tty converter Greg suggested
to try to use improved airprime driver to see if it's fast enough, and
probably then we may come up with high speed generic bulk-to-tty
converter. If we finally get it done, the airprime and other similar
drivers may directly use it for read/write/handshake operations and
manage only their specifics themselves.

Now to the difference in speed. I think the main reason airprime can't
match 5Mbits/sec is copying of data into tty in the read callback. I use
specially crafted ring buffer of chars, memory from which is directly
passed to the single read URB, then I immediately resubmit the URB (with
the next chunk of memory from the ring buffer) in the read callback and
schedule tasklet to copy from the ring buffer to tty. This solution is
there from the old days when USB core didn't like submissions of
multiple URBs. Now I think a better approach could be to have a FIFO of
URBs along with their buffers where you put URBs in the read callback,
then get them in the tasklet, copy to tty, and re-submit. I didn't have
time to play with the latter approach though.

-- 
Sergei.
