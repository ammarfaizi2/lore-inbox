Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261798AbTC0H4K>; Thu, 27 Mar 2003 02:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261802AbTC0H4K>; Thu, 27 Mar 2003 02:56:10 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:21997 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S261798AbTC0H4J>;
	Thu, 27 Mar 2003 02:56:09 -0500
Date: Thu, 27 Mar 2003 09:07:13 +0100
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Junfeng Yang <yjf@stanford.edu>, linux-kernel@vger.kernel.org,
       mc@cs.stanford.edu
Subject: Re: [CHECKER] potential dereference of user pointer errors
Message-ID: <20030327090713.A19647@fi.muni.cz>
References: <200303041112.h24BCRW22235@csl.stanford.edu> <Pine.GSO.4.44.0303202226230.24869-100000@elaine24.Stanford.EDU> <20030321155547.C646@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030321155547.C646@figure1.int.wirex.com>; from chris@wirex.com on Fri, Mar 21, 2003 at 03:55:47PM -0800
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
: Both cosa_readmem and cosa_download don't seem to do any validation of
: the user supplied ptr at all before dereferncing it in get_user.  And
: it'd make sense to use 'code' in cosa_reamdme (as in cosa_download)
: instead of 'd->code'.  Jan, does this look OK?

	Yes, you are right. I've missed this. However, it is not
as bad as it looks like, because you need the CAP_SYS_RAWIO to
exploit this. I agree this patch should be applied.

: ===== drivers/net/wan/cosa.c 1.17 vs edited =====
: --- 1.17/drivers/net/wan/cosa.c	Mon Jan 13 17:11:59 2003
: +++ edited/drivers/net/wan/cosa.c	Fri Mar 21 15:53:38 2003
: @@ -1057,7 +1057,8 @@
:  		return -EPERM;
:  	}
:  
: -	if (get_user(addr, &(d->addr)) ||
: +	if (verify_area(VERIFY_READ, d, sizeof(*d)) ||
: +	    __get_user(addr, &(d->addr)) ||
:  	    __get_user(len, &(d->len)) ||
:  	    __get_user(code, &(d->code)))
:  		return -EFAULT;
: @@ -1098,7 +1099,8 @@
:  		return -EPERM;
:  	}
:  
: -	if (get_user(addr, &(d->addr)) ||
: +	if (verify_area(VERIFY_READ, d, sizeof(*d)) ||
: +	    __get_user(addr, &(d->addr)) ||
:  	    __get_user(len, &(d->len)) ||
:  	    __get_user(code, &(d->code)))
:  		return -EFAULT;
: @@ -1106,7 +1108,7 @@
:  	/* If something fails, force the user to reset the card */
:  	cosa->firmware_status &= ~COSA_FW_RESET;
:  
: -	if ((i=readmem(cosa, d->code, len, addr)) < 0) {
: +	if ((i=readmem(cosa, code, len, addr)) < 0) {
:  		printk(KERN_NOTICE "cosa%d: reading memory failed: %d\n",
:  			cosa->num, i);
:  		return -EIO;

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|-- If you start doing things because you hate others and want to screw  --|
|-- them over the end result is bad.   --Linus Torvalds to the BBC News  --|
