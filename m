Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286314AbSAAWEO>; Tue, 1 Jan 2002 17:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285618AbSAAWEE>; Tue, 1 Jan 2002 17:04:04 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28946 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285590AbSAAWDx>; Tue, 1 Jan 2002 17:03:53 -0500
Message-ID: <3C322EEE.5040402@zytor.com>
Date: Tue, 01 Jan 2002 13:49:34 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: robert@schwebel.de
CC: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        Jason Sodergren <jason@mugwump.taiga.com>,
        Anders Larsen <anders@alarsen.net>, rkaiser@sysgo.de,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH][RFC] AMD Elan patch
In-Reply-To: <Pine.LNX.4.33.0112311900380.3056-100000@callisto.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Schwebel wrote:

> diff -urN -X kernel-patches/dontdiff linux-2.4.17/arch/i386/boot/setup.S linux-2.4.17-rs/arch/i386/boot/setup.S
> --- linux-2.4.17/arch/i386/boot/setup.S	Fri Nov  9 22:58:02 2001
> +++ linux-2.4.17-rs/arch/i386/boot/setup.S	Mon Dec 31 17:20:17 2001
> @@ -42,6 +42,9 @@
>   * if CX/DX have been changed in the e801 call and if so use AX/BX .
>   * Michael Miller, April 2001 <michaelm@mjmm.org>
>   *
> + * New A20 code ported from SYSLINUX by H. Peter Anvin. AMD Elan bugfixes
> + * by Robert Schwebel, December 2001 <robert@schwebel.de>
> + *
>   */
> 
>  #include <linux/config.h>
> @@ -646,7 +649,14 @@
>  #
>  # Enable A20.  This is at the very best an annoying procedure.
>  # A20 code ported from SYSLINUX 1.52-1.63 by H. Peter Anvin.
> +# AMD Elan bug fix by Robert Schwebel.
>  #
> +
> +#if defined(CONFIG_MELAN)
> +	inb $0xee, %al			# reading 0xee enables A20
> +	jmp a20_done
> +#endif
> +
> 


Do you have documentation which verifies that A20 is enabled by the time 
the IN instruction returns?  If not, you probably don't want to jump to 
a20_done, but rather fall into a loop like the following:

#if defined(CONFIG_MELAN)
	inb $0xee, %al
a20_elan_wait:
	call a20_test
	jz a20_elan_wait
	jmp a20_done
#endif

Furthermore, I would still like to argue that this does not belong into 
"processor type and features", because all of these are *chipset* 
issues; in fact, in this particular case you're more than anything 
working around a BIOS bug (not having INT 15h AX=2401h do the right thing).

I'm also very uncomfortable with putting this where you do; I think it 
should be put before a20_kbc instead.  If the BIOS is implemented 
correctly, it should be used.

	-hpa

