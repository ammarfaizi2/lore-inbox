Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWFTWQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWFTWQm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWFTWQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:16:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61382 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751267AbWFTWQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:16:41 -0400
Date: Tue, 20 Jun 2006 15:19:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kirill Smelkov <kirr@mns.spb.ru>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide: fix revision comparison in ide_in_drive_list
Message-Id: <20060620151950.21ad94d6.akpm@osdl.org>
In-Reply-To: <200606201452.33925.kirr@mns.spb.ru>
References: <200606201452.33925.kirr@mns.spb.ru>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Smelkov <kirr@mns.spb.ru> wrote:
>
> NB: bart/ide-2.6.git seems to be unmaintained,  so I'm sending this directly to -mm
> 
> Fix ide_in_drive_list:  drive_table->id_firmware should be searched *in* id->fw_rev,
> not vise versa.
> 
> Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
> 
> Index: linux-2.6.17/drivers/ide/ide-dma.c
> ===================================================================
> --- linux-2.6.17.orig/drivers/ide/ide-dma.c	2006-06-20 13:51:49.000000000 +0400
> +++ linux-2.6.17/drivers/ide/ide-dma.c	2006-06-20 13:52:14.000000000 +0400
> @@ -147,7 +147,7 @@
>  {
>  	for ( ; drive_table->id_model ; drive_table++)
>  		if ((!strcmp(drive_table->id_model, id->model)) &&
> -		    ((strstr(drive_table->id_firmware, id->fw_rev)) ||
> +		    ((strstr(id->fw_rev, drive_table->id_firmware)) ||
>  		     (!strcmp(drive_table->id_firmware, "ALL"))))
>  			return 1;
>  	return 0;

hm.  This seems...  rather serious.  I assume that in most cases, the
firmware rev which we have in the table (eg "24.09P07") is a full-string
match for the string which the drive returned.

If not, you've just blacklisted a whole bunch of drives which always should
have been blacklisted, but weren't.
