Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbWBRORi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWBRORi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 09:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWBRORi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 09:17:38 -0500
Received: from relay4.usu.ru ([194.226.235.39]:4525 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S1751259AbWBRORh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 09:17:37 -0500
Message-ID: <43F72C7A.8010709@ums.usu.ru>
Date: Sat, 18 Feb 2006 19:17:30 +0500
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_ums.usu.ru-2876-1140272251-0001-2"
To: "Adam Tla/lka" <atlka@pg.gda.pl>
Cc: torvalds@osdl.org, bug-ncurses@gnu.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]console:UTF-8 mode compatibility fixes
References: <20060217233333.GA5208@sunrise.pg.gda.pl>
In-Reply-To: <20060217233333.GA5208@sunrise.pg.gda.pl>
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.33.1.0; VDF: 6.33.1.4; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_ums.usu.ru-2876-1140272251-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

[sorry for repost, the first attempt got blocked due to html attachment, 
now I gzipped it to circumvent the filter]

Adam Tla/lka wrote:
> This patch applies to 2.6.15.3 kernel sources to drivers/char/vt.c file.
> It should work with other versions too.
> 
> Changed console behaviour so in UTF-8 mode vt100 alternate character
> sequences work as described in terminfo/termcap linux terminal definition.
> Programs can use vt100 control seqences - smacs, rmacs and acsc  characters
> in UTF-8 mode in the same way as in normal mode so one definition is always
> valid - current behaviour make these seqences not working in UTF-8 mode.

Doesn't work here with linux-2.6.16-rc3-mm1, ncurses-5.5. BTW has this
been discussed with Thomas Dickey (ncurses maintainer)?

> Added reporting malformed UTF-8 seqences as replacement glyphs.

Works.

> I think that terminal should always display something rather then ignoring
> these kind of data as it does now. Also it sticks to Unicode standards
> saying that every wrong byte should be reported. It is more human readable
> too in case of Latin subsets including ASCII chars.

Another feature request / bug report (spotted while viewing in Lynx a
page containing English text and a few Chinese characters, artificial
testcase attached):

If ncurses attempt to add some Chinese character to the Linux text
screen, Linux (correctly) prints this replacement character and advances
the cursor by one position. Ncurses think that the cursor has moved two
positions forward. The effect is that when you view the testcase in Lynx
(compiled --with-screen=ncursesw) on Linux console and press PageDown,
the fourth line contains "Thek" instead of "The" in the end.

This disagreement has to be solved somehow.

UTF-8 input issues (fixed by a patch originally from
http://chris.heathens.co.nz/linux/utf8.html) are also outstanding.

> Signed-off-by: Adam Tla/lka <atlka@pg.gda.pl>

Not adding my own signed-off-by line here because the acs part doesn't work.

> --- drivers/char/vt_orig.c	2006-02-13 11:33:54.000000000 +0100
> +++ drivers/char/vt.c	2006-02-17 23:05:50.000000000 +0100
> @@ -63,6 +63,12 @@
>   *
>   * Removed console_lock, enabled interrupts across all console operations
>   * 13 March 2001, Andrew Morton
> + *
> + * Fixed UTF-8 mode so alternate charset modes always work without need
> + * of different linux terminal definition for normal and UTF-8 modes
> + * preserving backward US-ASCII and VT100 semigraphics compatibility,
> + * malformed UTF sequences represented as sequences of replacement glyphs
> + * by Adam Tla/lka <atlka@pg.gda.pl>, Feb 2006
>   */
>  
>  #include <linux/module.h>
> @@ -1991,17 +1997,23 @@
>  		/* Do no translation at all in control states */
>  		if (vc->vc_state != ESnormal) {
>  			tc = c;
> -		} else if (vc->vc_utf) {
> +		} else if (vc->vc_utf && !vc->vc_disp_ctrl) {
>  		    /* Combine UTF-8 into Unicode */
> -		    /* Incomplete characters silently ignored */
> +		    /* Malformed sequence represented as replacement glyphs */
> +rescan_last_byte:
>  		    if(c > 0x7f) {
> -			if (vc->vc_utf_count > 0 && (c & 0xc0) == 0x80) {
> -				vc->vc_utf_char = (vc->vc_utf_char << 6) | (c & 0x3f);
> -				vc->vc_utf_count--;
> -				if (vc->vc_utf_count == 0)
> -				    tc = c = vc->vc_utf_char;
> -				else continue;
> +			if (vc->vc_utf_count) {
> +			       if ((c & 0xc0) == 0x80) {
> +				       vc->vc_utf_char = (vc->vc_utf_char << 6) | (c & 0x3f);
> +       				       if (--vc->vc_utf_count) {
> +					       vc->vc_npar++;
> +				   	       continue;
> +       				       }
> +				       tc = c = vc->vc_utf_char;
> +			       } else
> +				       goto insert_replacement_glyph;
>  			} else {
> +				vc->vc_npar = 0;
>  				if ((c & 0xe0) == 0xc0) {
>  				    vc->vc_utf_count = 1;
>  				    vc->vc_utf_char = (c & 0x1f);
> @@ -2018,12 +2030,13 @@
>  				    vc->vc_utf_count = 5;
>  				    vc->vc_utf_char = (c & 0x01);
>  				} else
> -				    vc->vc_utf_count = 0;
> +	    			    goto insert_replacement_glyph;
>  				continue;
>  			      }
>  		    } else {
> +		      if (vc->vc_utf_count)
> +	  		      goto insert_replacement_glyph;
>  		      tc = c;
> -		      vc->vc_utf_count = 0;
>  		    }
>  		} else {	/* no utf */
>  		  tc = vc->vc_translate[vc->vc_toggle_meta ? (c | 0x80) : c];
> @@ -2040,8 +2053,8 @@
>                   * direct-to-font zone in UTF-8 mode.
>                   */
>                  ok = tc && (c >= 32 ||
> -			    (!vc->vc_utf && !(((vc->vc_disp_ctrl ? CTRL_ALWAYS
> -						: CTRL_ACTION) >> c) & 1)))
> +			    !(vc->vc_disp_ctrl ? (CTRL_ALWAYS >> c) & 1 :
> +				  vc->vc_utf || ((CTRL_ACTION >> c) & 1)))
>  			&& (c != 127 || vc->vc_disp_ctrl)
>  			&& (c != 128+27);
>  
> @@ -2051,6 +2064,7 @@
>  			if ( tc == -4 ) {
>                                  /* If we got -4 (not found) then see if we have
>                                     defined a replacement character (U+FFFD) */
> +insert_replacement_glyph:
>                                  tc = conv_uni_to_pc(vc, 0xfffd);
>  
>  				/* One reason for the -4 can be that we just
> @@ -2062,9 +2076,19 @@
>                                  /* Bad hash table -- hope for the best */
>                                  tc = c;
>                          }
> -			if (tc & ~charmask)
> +			if (tc & ~charmask) {
> +				/*  no replacement glyph */
> +				if (vc->vc_utf_count) {
> +					vc->vc_utf_count = 0;
> +					if (vc->vc_npar) {
> +						c = orig;
> +						goto rescan_last_byte;
> +					}
> +				}
>                                  continue; /* Conversion failed */
> +			}
>  
> +repeat_replacement_glyph:
>  			if (vc->vc_need_wrap || vc->vc_decim)
>  				FLUSH
>  			if (vc->vc_need_wrap) {
> @@ -2088,6 +2112,15 @@
>  				vc->vc_x++;
>  				draw_to = (vc->vc_pos += 2);
>  			}
> +			if (vc->vc_utf_count) {
> +				if (vc->vc_npar) {
> +					vc->vc_npar--;
> +					goto repeat_replacement_glyph;
> +				}
> +				vc->vc_utf_count = 0;
> +				c = orig;
> +				goto rescan_last_byte;
> +			}
>  			continue;
>  		}
>  		FLUSH

-- 
Alexander E. Patrakov


--=_ums.usu.ru-2876-1140272251-0001-2
Content-Type: application/gzip; name="test.html.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="test.html.gz"

H4sICC0n90MAA3Rlc3QuaHRtbADt10tug0AMBuA9p/hFpOwISqqqkTLMJlJOQA8wgGFoYYaH
SUJPXxJ6iFb10tbnx86ystw2WlkyhQ5US2xgmbuI+qm+JuHZOybHUTp3FCJfoyRkunP8qDwh
t2YYiZP39BIdw6UH19yQTmlkdKYireI1o+KfIZkvZh2klrDMyD+RDf7mUPo7Pqa2G+GvNMCg
MV8zCl/thAoVKlSo0L9FlxtYuwqPa4mMSj8Qtv3k+bTdvLy9HvZrAOMKmJKX6pp/w9pChQoV
KvTfUxU/vzX1fPZ08A3oor0RLg4AAA==
--=_ums.usu.ru-2876-1140272251-0001-2--
