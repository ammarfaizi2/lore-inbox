Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVCZSQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVCZSQl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 13:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVCZSQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 13:16:41 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:14088 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261202AbVCZSQi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 13:16:38 -0500
Date: Sat, 26 Mar 2005 19:16:36 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: samba@samba.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 patch] fs/smbfs/request.c: turn NULL dereference into
 BUG()
Message-Id: <20050326191636.3cbd77b4.khali@linux-fr.org>
In-Reply-To: <20050326131132.GB3237@stusta.de>
References: <20050325001540.GF3966@stusta.de>
	<20050326100253.3edbb2fc.khali@linux-fr.org>
	<20050326125301.GA3237@stusta.de>
	<20050326131132.GB3237@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

> On Sat, Mar 26, 2005 at 01:53:01PM +0100, Adrian Bunk wrote:
> >...
> > The problem is actually only in the SMB_RECV_END and
> > SMB_RECV_REQUEST  cases and all code after the NULL pointer
> > dereference is actually dead  code.
> >...
> 
> OK, this was also wrong...

I can confirm, I gave it a try and had to reboot ;)

You are right that the problem is only in the SMB_RECV_END and
SMB_RECV_REQUEST cases. I had missed that point in the patch I proposed.

> Third try.
> (...)
> In a case documented as
>   We should never be called with any of these states
> BUG() in a case that would later result in a NULL pointer dereference.
> (...)
> --- linux-2.6.12-rc1-mm3-full/fs/smbfs/request.c.old	2005-03-26 13:19:19.000000000 +0100
> +++ linux-2.6.12-rc1-mm3-full/fs/smbfs/request.c	2005-03-26 13:41:30.000000000 +0100
> @@ -786,8 +642,7 @@ int smb_request_recv(struct smb_sb_info 
>  		/* We should never be called with any of these states */
>  	case SMB_RECV_END:
>  	case SMB_RECV_REQUEST:
> -		server->rstate = SMB_RECV_END;
> -		break;
> +		BUG();
>  	}

Yes, after reading the whole thing again, it seems to be the correct
thing to do, providing that "should never" is a reference to an internal
state and not something from the outside. I don't know myself, but you
seem to do. Maybe someone from the samba team could confirm?

BTW, it looks to me like Urban Widmark, the author of this module and
supposedly the maintainer of it as well, has vanished some times ago.
Last seen 2004-06-21, and no working e-mail address (both failes for
me). Shouldn't we mark smbfs as unmaintained in MAINTAINERS, or have
someone else take over? Any volunteer?

Thanks,
-- 
Jean Delvare
