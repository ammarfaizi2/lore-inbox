Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbTELGbi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 02:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbTELGbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 02:31:38 -0400
Received: from elaine24.Stanford.EDU ([171.64.15.99]:22423 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id S261957AbTELGbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 02:31:36 -0400
Date: Sun, 11 May 2003 23:44:14 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: mc@cs.stanford.edu
Subject: Re: [CHECKER] 1 potential derefence of user-pointer without verification
 error
In-Reply-To: <Pine.GSO.4.44.0305112325140.2457-100000@elaine24.Stanford.EDU>
Message-ID: <Pine.GSO.4.44.0305112337160.3242-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


here is a detailed explanation in case the warnning itself isn't clear:

1. ds_ioctl is assigned to file_operantions.ioctl
so its argument 'arg' is tainted. verify_area are
also called on 'arg', which confirms.

2. copy_from_user (&buf, arg, _) copies in the content of arg

3. buf.win_info.handle is thus a user provided pointer.

4. pcmcia_get_mem_page dereferences its first parameter, in this case
buf.win_info.handle

-Junfeng

On Sun, 11 May 2003, Junfeng Yang wrote:

>
> Hi,
>
> Below is a warning found in pcmcia/ds.c, where user pointer is
> dereferenced without check. Please confirm or clarify, Thanks!
>
> -Junfeng
>
> ---------------------------------------------------------
>
> [BUG] buf is tainted implies buf.win_info.handle is tainted.
> pcmcia_get_mem_page dereferences its first parameter
>
> /home/junfeng/linux-tainted/drivers/pcmcia/ds.c:814:ds_ioctl:
> ERROR:TAINTED: 814:814:deref tainted component 'buf.win_info.handle'
> [struct=win_info_t.handle] [type=call]
>
> 	break;
>     case DS_GET_NEXT_WINDOW:
> 	ret = pcmcia_get_next_window(&buf.win_info.handle,
> &buf.win_info.window);
> 	break;
>     case DS_GET_MEM_PAGE:
>
> Error --->
> 	ret = pcmcia_get_mem_page(buf.win_info.handle,
> 			   &buf.win_info.map);
> 	break;
>     case DS_REPLACE_CIS:
>
>

