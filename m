Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131588AbRAXBS3>; Tue, 23 Jan 2001 20:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132117AbRAXBST>; Tue, 23 Jan 2001 20:18:19 -0500
Received: from platan.vc.cvut.cz ([147.32.240.81]:58893 "EHLO
	platan.vc.cvut.cz") by vger.kernel.org with ESMTP
	id <S131588AbRAXBSN>; Tue, 23 Jan 2001 20:18:13 -0500
Date: Wed, 24 Jan 2001 02:17:20 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: display problem with matroxfb
Message-ID: <20010124021720.A1075@platan.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grr. Did not pass through due to DUL blacklist...

----- Transcript of session follows -----
... while talking to vger.kernel.org.:
>>> RCPT To:<linux-kernel@vger.kernel.org>
<<< 550 5.7.1 Policy analysis reported: See <URL:http://mail-abuse.org/dul/> rcpt=<linux-kernel@vger.kernel.org>
550 5.1.1 linux-kernel@vger.kernel.org... User unknown

----- Original message -----

Date: Wed, 24 Jan 2001 01:53:09 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: f5ibh <f5ibh@db0bm.ampr.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: display problem with matroxfb
User-Agent: Mutt/1.3.12i
In-Reply-To: <200101232319.AAA08536@db0bm.ampr.org>; from f5ibh@db0bm.ampr.org on Wed, Jan 24, 2001 at 12:19:14AM +0100

On Wed, Jan 24, 2001 at 12:19:14AM +0100, f5ibh wrote:
> I copied the following block in /etc/fb.modes
> 
> mode "640x480-60"
>     # D: 25.200 MHz, H: 31.500 kHz, V: 59.999 Hz
>     geometry 640 480 640 480 8
>     timings 39683 48 16 33 10 96 2
>     accel true
>     rgba 8/0,8/0,8/0,0/0
> endmode
> 
> With these parameters, the command 'fbset -match -a' is enough to reset the
> display to normal operation. So, you was right.

It is stranger and stranger with each email from you :-(

> > Also, you do not have to specify vesa,pixclock,hslen and vslen, as you leave
> > them on defaults. So 'video=matrox:left:50,right:10,upper:32,lower:11'
> > should work... But I think that only 'right:' really matters.
> 
> This does not work ... I've to use the fbset command to reset the display to
> normal operation after login in (or in an automatic command at boot time in
> /et/init.d). This works, but I've lost the logo  ;-)

Can you try 'video=matrox:init' ? And 'video=matrox:nopan'? First (init) should
reinitialize hardware from scratch. Maybe it is programmed to some unusual
delay between memory and CRT - but in such case shift cannot be more than 64 
pixels (8 chars).

And nopan disables vertical panning (by default matroxfb sets vyres to largest 
possible value, equivalent to 'geometry 640 480 640 65535 8'). But if there is 
problem with vertical panning, screen should jump to left and right when scrolling 
up, not stay just moved right.

If everything above fails, there is function matrox_set_var in 
linux/drivers/video/matrox/matroxfb_base.c. This function contains also follwing
lines:

        mga_setr(M_CRTC_INDEX, 0x0D, p0);
        mga_setr(M_CRTC_INDEX, 0x0C, p1);
#ifdef CONFIG_FB_MATROX_32MB
        if (ACCESS_FBINFO(devflags.support32MB))
                mga_setr(M_EXTVGA_INDEX, 0x08, p3);
#endif
        mga_setr(M_EXTVGA_INDEX, 0x00, p2);

Can you just duplicate this block once more? Documentation says that value written
to M_CRTC_INDEX/C,D is applied after write to M_EXTVGA_INDEX/0, but maybe that your
piece of hardware thinks that it is just other way around (I'm sure that Millennium
and Gxx0 hardware needs CRTC0D/0C first, and CRTCEXT0 last, but who knows).
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
