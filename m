Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269677AbUHZWQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269677AbUHZWQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 18:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269734AbUHZWPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 18:15:24 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:59915 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S269753AbUHZWMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 18:12:34 -0400
Date: Fri, 27 Aug 2004 00:12:29 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "O.Sezer" <sezeroz@ttnet.net.tr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.28-pre2 and ntfs-2.1.6b ?
Message-ID: <20040826221229.GB564@alpha.home.local>
References: <412E4F43.9030801@ttnet.net.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412E4F43.9030801@ttnet.net.tr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 26, 2004 at 11:59:47PM +0300, O.Sezer wrote:
> Hi all:
> 
> With 2.4.28-pre2, ntfs-2.1.6b from linux-ntfs site
> started failing to compile at aops.c:
> 
> aops.c: In function `ntfs_read_block':
> aops.c:315: parse error before "else"
> -- or in case of gcc3.4 --
> aops.c:315: error: syntax error before "else"
> 
> This happens with gcc-3.2.2 and gcc-3.4.0
> and can be fixed by:
> 
> --- aops.c.BAK	2004-08-26 19:35:11.000000000 +0300
> +++ aops.c	2004-08-26 21:41:53.000000000 +0300
> @@ -310,10 +310,11 @@
>  		return 0;
>  	}
>  	/* No i/o was scheduled on any of the buffers. */
> -	if (likely(!PageError(page)))
> +	if (likely(!PageError(page))) {
>  		SetPageUptodate(page);
> -	else /* Signal synchronous i/o error. */
> +	} else { /* Signal synchronous i/o error. */
>  		nr = -EIO;
> +	}
>  	unlock_page(page);
>  	return nr;
>  }

No !
Please don't fix it this way ! The problem lies within the declaration of
SetPageUptodate() which it seems is a macro which lacks some braces somewhere.
You were very lucky that there was an 'else' to point it out, but imagine
what it would do in the following case :

	if (likely(!PageError(page))) {
 		SetPageUptodate(page);
	blah();

It would always execute the second half of SetPageUptodate(), whatever
the condition, and nothing will alert you.

What does SetPageUptodate() look like ?

> The very same code used to compile fine with
> 2.4.27 without any changes to it.

I think that the gcc-3.4 fixes might have hit some sensible parts...

> I can't see
> where the problem is (it's 23:57 here ;)).
> Can anyone tell, please?

It's even later now, good night :-)

Regards,
Willy

