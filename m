Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264628AbSLIIAU>; Mon, 9 Dec 2002 03:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264637AbSLIIAU>; Mon, 9 Dec 2002 03:00:20 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:39698 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S264628AbSLIIAT>; Mon, 9 Dec 2002 03:00:19 -0500
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Kurt Roeckx <Q@ping.be>
Date: Mon, 09 Dec 2002 09:07:35 +0100
MIME-Version: 1.0
Subject: Re: adjtimex/ppskit
CC: linux-kernel@vger.kernel.org
Message-ID: <3DF45D39.24443.3D7228@localhost>
In-reply-to: <20021207151404.A3627@ping.be>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.13/Sophos-3.62+2.10+2.03.098+07 October 2002+76781@20021209.080029Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Dec 2002 at 15:14, Kurt Roeckx wrote:

> I have this problem with the ntp/adjtimex.  Ntpd sets the freq
> field to a value outside the valid range.  According to Dave
> Mills, the kernel is supposed to clamp the frequency.  I see that
> in the PPSkit this is done properly ...
> 
> Would it be possible to integrate the PPSkit in the kernel soon?
> 
> If not, could you atleast get parts of it in the kernel, so it
> works correctly with ntpd?

I see: The code used in v2.4.10 of the kernel reads like this:

            if (txc->modes & ADJ_FREQUENCY) {   /* p. 22 */
                if (txc->freq > MAXFREQ || txc->freq < -MAXFREQ) {
                    result = -EINVAL;
                    goto leave;
                }
                time_freq = txc->freq - pps_freq;
            }

The PPSkit code reads like this:

                if (txc->modes & MOD_FREQUENCY) {       /* p. 22 */
                        long freq;              /* frequency ns/s) */
                        freq = txc->freq / SCALE_PPM;
                        if (freq > MAXFREQ) {
                                result = -EINVAL;
                                freq = MAXFREQ;
                        } else if (freq < -MAXFREQ) {
                                result = -EINVAL;
                                freq = -MAXFREQ;
                        }
                        L_LINT(time_freq, freq);
#ifdef CONFIG_NTP_PPS
                        pps.freq = time_freq;
#endif

(So just limit the argument in addition to returning -EINVAL; the other 
differences are because of the modified clock model and nanoseconds)

Returning "-EINVAL" is a subject to discussion, so it could be left out.
I don't have the time to make a proper patch at the moment, but I think 
everyone could fix it until a proper patch is available.

Regards,
Ulrich


> 
> 
> Kurt
> 


