Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751513AbWIWT5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbWIWT5N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 15:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWIWT5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 15:57:12 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:61673 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751513AbWIWT5L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 15:57:11 -0400
Date: Sat, 23 Sep 2006 20:57:10 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [PATCH] more get_property() fallout
Message-ID: <20060923195710.GM29920@ftp.linux.org.uk>
References: <20060923172135.GL29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060923172135.GL29920@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2006 at 06:21:35PM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  drivers/video/riva/fbdev.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
> index 61a4665..4acde4f 100644
> --- a/drivers/video/riva/fbdev.c
> +++ b/drivers/video/riva/fbdev.c
> @@ -1826,7 +1826,7 @@ static int __devinit riva_get_EDID_OF(st
>  {
>  	struct riva_par *par = info->par;
>  	struct device_node *dp;
> -	unsigned char *pedid = NULL;
> +	const unsigned char *pedid = NULL;

Ho-hum...  Actually, that looks like a genuine bug.  Look:

rivafb_probe():
	riva_get_EDID(info, pd);
	riva_get_edidinfo(info);

riva_get_EDID() -> riva_get_EDID_OF() ->
                        pedid = get_property(dp, propnames[i], NULL);
                        if (pedid != NULL) {
                                par->EDID = pedid;
                                NVTRACE("LCD found.\n");
                                return 1;
                        }
then in 
riva_get_edidinfo():
        struct riva_par *par = info->par;

        fb_edid_to_monspecs(par->EDID, &info->monspecs);

fb_edid_to_monspecs() -> edid_checksum() -> fix_edid() -> modifies the string.

What's worse, fb_edid_to_monspecs() appears to assume that the string it
got is long enough.  So... what the hell is going on there?  I'd probably
did kmalloc() and copy that sucker there, making sure that it _is_ long
enough for fbmon.c while we are at it.  Other suggestions?
