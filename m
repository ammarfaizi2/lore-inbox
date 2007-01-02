Return-Path: <linux-kernel-owner+w=401wt.eu-S964977AbXABVHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbXABVHU (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 16:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbXABVHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 16:07:20 -0500
Received: from smtp.osdl.org ([65.172.181.25]:60558 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964977AbXABVHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 16:07:18 -0500
Date: Tue, 2 Jan 2007 13:07:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Amit Choudhary <amit2030@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.20-rc2] fs/jffs2/scan.c: Fix error-path leak
Message-Id: <20070102130709.0cd13b14.akpm@osdl.org>
In-Reply-To: <20061229033202.5f008efc.amit2030@gmail.com>
References: <20061229033202.5f008efc.amit2030@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Dec 2006 03:32:02 -0800
Amit Choudhary <amit2030@gmail.com> wrote:

> Description: Fix error-path leak in function jffs2_scan_medium(), in file fs/jffs2/scan.c
> 
> Signed-off-by: Amit Choudhary <amit2030@gmail.com>
> 
> diff --git a/fs/jffs2/scan.c b/fs/jffs2/scan.c
> index e241346..cd9ed6e 100644
> --- a/fs/jffs2/scan.c
> +++ b/fs/jffs2/scan.c
> @@ -130,6 +130,8 @@ #endif
>  	if (jffs2_sum_active()) {
>  		s = kmalloc(sizeof(struct jffs2_summary), GFP_KERNEL);
>  		if (!s) {
> +			free(flashbuf);
> +			flashbuf = NULL;
>  			JFFS2_WARNING("Can't allocate memory for summary\n");
>  			return -ENOMEM;
>  		}

err, no.

I merged the below, thanks.

--- a/fs/jffs2/scan.c~fs-jffs2-scanc-fix-error-path-leak
+++ a/fs/jffs2/scan.c
@@ -130,6 +130,7 @@ int jffs2_scan_medium(struct jffs2_sb_in
 	if (jffs2_sum_active()) {
 		s = kzalloc(sizeof(struct jffs2_summary), GFP_KERNEL);
 		if (!s) {
+			kfree(flashbuf);
 			JFFS2_WARNING("Can't allocate memory for summary\n");
 			return -ENOMEM;
 		}
_

