Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264526AbTL0ShL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 13:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264535AbTL0ShK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 13:37:10 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:32707 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S264526AbTL0ShH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 13:37:07 -0500
Date: Sat, 27 Dec 2003 10:35:26 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Edward Tandi <ed@efix.biz>, azarah@nosferatu.za.org
cc: perex@suse.cz, alsa-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Rob Love <rml@ximian.com>, Andrew Morton <akpm@osdl.org>,
       Stan Bubrouski <stan@ccs.neu.edu>
Subject: Re: OSS sound emulation broken between 2.6.0-test2 and test3
Message-ID: <1960000.1072550125@[10.10.2.4]>
In-Reply-To: <1072525450.3794.8.camel@wires.home.biz>
References: <1080000.1072475704@[10.10.2.4]> <1072479167.21020.59.camel@nosferatu.lan>  <1480000.1072479655@[10.10.2.4]> <1072480660.21020.64.camel@nosferatu.lan>  <1640000.1072481061@[10.10.2.4]> <1072482611.21020.71.camel@nosferatu.lan>  <2060000.1072483186@[10.10.2.4]> <1072500516.12203.2.camel@duergar>  <8240000.1072511437@[10.10.2.4]> <1072523478.12308.52.camel@nosferatu.lan> <1072525450.3794.8.camel@wires.home.biz>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Something appears to have broken OSS sound emulation between 
>> > test2 and test3. Best I can tell (despite the appearance of the BK logs), 
>> > that included ALSA updates 0.9.5 and 0.9.6. Hopefully someone who
>> > understands the sound architecture better than I can fix this?
>> > 
>> 
>> I wont say I understand it, but a quick look seems the major change is
>> the addition of the 'whole-frag' and 'no-silence' opts.  You might try
>> the following to revert what 'no-silence' change at least does:
>> 
>> --
>>  # echo 'xmms 0 0 no-silence' > /proc/asound/card0/pcm0p/oss
>>  # echo 'xmms 0 0 whole-frag' > /proc/asound/card0/pcm0p/oss
>> --
> 
> Thanks, that fixes it for me. I too have been seeing terrible problems
> with XMMS since the early 2.6 pre- kernels.
> 
> Because it only happens in XMMS I thought it was one of those
> application bugs brought out by scheduler changes. I now use Zinf BTW
> -It's better for large music collections (although not as stable or
> flash).
> 
> I guess someone ought to revert the standard behaviour.

OK, the following patch from Andrew fixes it up 80% or so, but I still 
don't think it's as good as test2 was - turning on whole-frag seems to
fix the rest of it. It's much more difficult to tell now though, so I'd 
like other people's opinions on it. If you want to switch between the
two, the above switches it on, and:

# echo 'clear' > /proc/asound/card0/pcm0p/oss

switches whole-frag back off. I'm using a 192kbps MP3 to test it, repeating
the first 30s of the same song again and again (I'm gonna hate that song 
soon ;-)). Different bitrates might give better differentation of the problem.

Please, please experiment with this, and let us know.

M.

--- compile/sound/core/oss/pcm_oss.c.old	Mon Nov 17 18:29:43 2003
+++ compile/sound/core/oss/pcm_oss.c	Sat Dec 27 10:32:30 2003
@@ -814,7 +814,7 @@
 			xfer += tmp;
 			if (substream->oss.setup == NULL || !substream->oss.setup->wholefrag ||
 			    runtime->oss.buffer_used == runtime->oss.period_bytes) {
-				tmp = snd_pcm_oss_write2(substream, runtime->oss.buffer, runtime->oss.buffer_used, 1);
+				tmp = snd_pcm_oss_write2(substream, runtime->oss.buffer, runtime->oss.period_bytes, 1);
 				if (tmp <= 0)
 					return xfer > 0 ? (snd_pcm_sframes_t)xfer : tmp;
 				runtime->oss.bytes += tmp;

