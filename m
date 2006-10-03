Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbWJCQfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWJCQfF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 12:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWJCQfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 12:35:05 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:6897 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1750942AbWJCQfD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 12:35:03 -0400
Date: Tue, 3 Oct 2006 09:34:15 -0700
To: Samuel Tardieu <sam@rfc1149.net>
Cc: Pavel Roskin <proski@gnu.org>, "John W. Linville" <linville@tuxdriver.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.18-mm2 - oops in cache_alloc_refill()
Message-ID: <20061003163415.GA17252@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20060928014623.ccc9b885.akpm@osdl.org> <200609290319.k8T3JOwS005455@turing-police.cc.vt.edu> <20060928202931.dc324339.akpm@osdl.org> <200609291519.k8TFJfvw004256@turing-police.cc.vt.edu> <20060929124558.33ef6c75.akpm@osdl.org> <200609300001.k8U01sPI004389@turing-police.cc.vt.edu> <20060929182008.fee2a229.akpm@osdl.org> <20061002175245.GA14744@bougret.hpl.hp.com> <2006-10-03-17-58-31+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2006-10-03-17-58-31+trackit+sam@rfc1149.net>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 05:58:31PM +0200, Samuel Tardieu wrote:
> >>>>> "Jean" == Jean Tourrilhes <jt@hpl.hp.com> writes:
> 
> Jean> @@ -2500,9 +2501,9 @@ static int orinoco_hw_get_essid(struct o
> Jean>  	len = le16_to_cpu(essidbuf.len);
> Jean>  	BUG_ON(len > IW_ESSID_MAX_SIZE);
> Jean>  
> Jean> -	memset(buf, 0, IW_ESSID_MAX_SIZE+1);
> Jean> +	memset(buf, 0, IW_ESSID_MAX_SIZE);
> Jean>  	memcpy(buf, p, len);
> Jean> -	buf[len] = '\0';
> Jean> +	err = len;
> 
> Jean,
> 
> something bugs me here:
> 
>   - either buf is supposed to be a nul-terminated string, in which
>     case if p is IW_ESSID_MAX_SIZE long there may be a bug (no '\0' at
>     the end of buf)

	ESSID is supposed to be up to 32 char, so we need to full
buffer size.

>   - either buf is not-supposed to be nul-terminated and the length
>     value will always be used, in which case the memset() looks
>     useless

	Yes, it is entirely useless, but not incorrect. Note that the
code was not very efficient to start with, the last char of the string
was set to NUL twice.
	I don't really want to overstep my authority there, my goal
was to minimise the changes. Pavel will have to clean up my mess, so I
don't want change things too much.

> I suggest that you revert the memset() to IW_ESSID_MAX_SIZE+1 so that
> the last byte is cleared as well. Or am I missing something?

	No, that would bring back the slab/memory overflow we are
trying to get rid of.

>  Sam
> -- 
> Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/

	Strange, this name remind me someone. Must be a previous life ;-)

	A+

	Jean
