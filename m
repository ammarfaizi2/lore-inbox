Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbWBRLB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWBRLB2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 06:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWBRLB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 06:01:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14236 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750997AbWBRLB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 06:01:27 -0500
Date: Sat, 18 Feb 2006 02:59:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adam Tla/lka <atlka@pg.gda.pl>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH]console:UTF-8 mode compatibility fixes
Message-Id: <20060218025921.7456e168.akpm@osdl.org>
In-Reply-To: <20060217233333.GA5208@sunrise.pg.gda.pl>
References: <20060217233333.GA5208@sunrise.pg.gda.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Tla/lka <atlka@pg.gda.pl> wrote:
>
> 
> This patch applies to 2.6.15.3 kernel sources to drivers/char/vt.c file.
> It should work with other versions too.
> 
> Changed console behaviour so in UTF-8 mode vt100 alternate character
> sequences work as described in terminfo/termcap linux terminal definition.
> Programs can use vt100 control seqences - smacs, rmacs and acsc  characters
> in UTF-8 mode in the same way as in normal mode so one definition is always
> valid - current behaviour make these seqences not working in UTF-8 mode.
> 
> Added reporting malformed UTF-8 seqences as replacement glyphs.
> I think that terminal should always display something rather then ignoring
> these kind of data as it does now. Also it sticks to Unicode standards
> saying that every wrong byte should be reported. It is more human readable
> too in case of Latin subsets including ASCII chars.
> 
> ...
>
> -		} else if (vc->vc_utf) {
> +		} else if (vc->vc_utf && !vc->vc_disp_ctrl) {
>  		    /* Combine UTF-8 into Unicode */
> -		    /* Incomplete characters silently ignored */
> +		    /* Malformed sequence represented as replacement glyphs */
> +rescan_last_byte:
>  		    if(c > 0x7f) {
>
> ...
>
> +					if (vc->vc_npar) {
> +						c = orig;
> +						goto rescan_last_byte;
> +					}
>
> ...
>
> +				}
> +				vc->vc_utf_count = 0;
> +				c = orig;
> +				goto rescan_last_byte;
> +			}
>  			continue;
>  		}

I spent some time trying to work out why this cannot cause an infinite loop
and gave up.  Can you explain?
