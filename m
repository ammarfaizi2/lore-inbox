Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbUCOFg7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 00:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbUCOFg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 00:36:58 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:55758 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262271AbUCOFg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 00:36:56 -0500
Date: Mon, 15 Mar 2004 06:36:55 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bind Mount Extensions 0.04
Message-ID: <20040315053654.GA31818@MAIL.13thfloor.at>
Mail-Followup-To: Willy Tarreau <willy@w.ods.org>,
	linux-kernel@vger.kernel.org
References: <20040315035350.GA30948@MAIL.13thfloor.at> <20040315045952.GD14537@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315045952.GD14537@alpha.home.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 05:59:52AM +0100, Willy Tarreau wrote:
> Hi Herbert,
> 
> On Mon, Mar 15, 2004 at 04:53:51AM +0100, Herbert Poetzl wrote:
>  
> > an older version of this patch was included in 2.6.0-test6-mm2, 
> > and it is currently used by several people, without any issues, 
> > so I'd kindly request to consider it for inclusion into mainline.
> 
> I have tested 0.03 on 2.4.25 + some other patches, and discovered something
> annoying : an attempt to change something on the R/O FS marked the parent
> FS busy. But I cannot say for sure that it was a problem with your patch,
> because that kernel had several others. I'll try to reproduce on a naked
> kernel. To reproduce it, you can try this :

it _was_ an issue with 0.03 on 2.4.25 (see changelog)

> # mount /dev/hdaXX /mnt/disk
> # mount -r --bind /mnt/disk /mnt/ro
> # touch /mnt/ro/foo
> Read-only file-system (that's what was expected)
> # umount /mnt/ro
> (I don't remember if the problem already arises here)
> # umount /mnt/disk
> device is busy

this has been fixed in 0.04 for 2.4.25, if you need
the fix to include for 0.03 (for whatever reason)
here is the relevant hunk ..

--- linux-2.4.25-bme0.03/fs/namei.c     2004-03-10 14:45:36.000000000 +0100
+++ linux-2.4.25-bme0.04/fs/namei.c     2004-03-10 12:18:35.000000000 +0100
@@ -1045,7 +1045,7 @@ int open_namei(const char * pathname, in
                return error;
        error = -EROFS;
        if (MNT_IS_RDONLY(nd->mnt))
-               return error;
+               goto exit;
 
        /*
         * We have the parent and last component. First of all, check

> Other than that, this feature is really excellent !

thanks for using it ...

> Thanks,
> Willy
