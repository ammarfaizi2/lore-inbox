Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbVEXKWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbVEXKWB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 06:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVEXKU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 06:20:27 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:28588 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S262066AbVEXKP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 06:15:27 -0400
Message-ID: <4292FEBD.6020306@vc.cvut.cz>
Date: Tue, 24 May 2005 12:15:25 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, p2@mind.be, dsd@gentoo.org
Subject: Re: [patch 06/16] Fix matroxfb on big-endian hardware
References: <20050523231529.GL27549@shell0.pdx.osdl.net> <20050523232207.GR27549@shell0.pdx.osdl.net> <20050523235052.GX29811@parcelfarce.linux.theplanet.co.uk> <20050524011711.GD27549@shell0.pdx.osdl.net>
In-Reply-To: <20050524011711.GD27549@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Al Viro (viro@parcelfarce.linux.theplanet.co.uk) wrote:
> 
>>On Mon, May 23, 2005 at 04:22:07PM -0700, Chris Wright wrote:
>>
>>>-				mga_writel(mmio, 0, *chardata);
>>>+#if defined(__BIG_ENDIAN)
>>>+				fb_writel((*chardata) << 24, mmio.vaddr);
>>>+#else
>>>+				fb_writel(*chardata, mmio.vaddr);
>>>+#endif
>>
>>So basically you are passing it cpu_to_le32(*chardata)?
>>
>>
>>>+#if defined(__BIG_ENDIAN)
>>>+				fb_writel((*(u_int16_t*)chardata) << 16, mmio.vaddr);
>>>+#else
>>>+				fb_writel(*(u_int16_t*)chardata, mmio.vaddr);
>>>+#endif
>>
>>*yuck*
>>
>>cpu_to_le32(le16_to_cpu(*(__le16 *)chardata)?  Is that what you are doing
>>here?

Yes.  Hardware wants it this way.  For 8bit wide font you must write font data 
in low 8 bits (some hardware on the way does swapping on BE archs), and for 
16bit wide font you must write font data in low 16 bits.  In both cases first 
pixel is in bit7 of byte 0, going through to bit0 of byte 0, followed by bit7 of 
byte 1 through bit0 of byte 1.  And so on for widths > 16.  Inner leX_to_cpu 
works on data of font size, while outer cpu_to_le32 works on accelerator data 
size, which is always 32 bit.

If you want it absolutely correct (as font data are in big endian), you should 
write cpu_to_le32(swab<font_width>(be<font_width>_to_cpup(chardata))).  Inner 
be16_to_cpup retrieves font data into bits 15 -> 0, swab reorders bytes so first 
pixel is in bit 7, not bit 15 (or 31 for 32bit wide font), and outer cpu_to_le32 
nullifies effect of external swab32() engine.

> Petr, care to comment?  Best I can tell this is from you and is already
> upstream.  Any reason not to use cpu_to_xx instead of what's done?

I'm not sure about speed effects.  Is gcc smart enough to notice that two 
different width byteswaps can be combined to simple shift?
						Thanks,
							Petr Vandrovec

