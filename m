Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbVLNHmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbVLNHmI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 02:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbVLNHmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 02:42:08 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:35745 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751112AbVLNHmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 02:42:06 -0500
Subject: Re: [PATCH] fix warning and missing failure handling for
	scsi_add_host in aic7xxx driver
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org,
       "Daniel M. Eischen" <deischen@iworks.interworks.org>,
       Doug Ledford <dledford@redhat.com>
In-Reply-To: <200512140007.20046.jesper.juhl@gmail.com>
References: <200512140007.20046.jesper.juhl@gmail.com>
Content-Type: text/plain
Date: Tue, 13 Dec 2005 21:33:59 -0700
Message-Id: <1134534839.3133.2.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 00:07 +0100, Jesper Juhl wrote:
> +	if (retval) {
> +		printk(KERN_ERR "aic7xxx: scsi_add_host failed\n");
> +		goto free_and_out;
> +	}
> +
>  	scsi_scan_host(host);
> -	return (0);
> +
> +out:
> +	return retval;
> +free_and_out:
> +	scsi_remove_host(host);
> +	goto out;

I'm not incredibly keen on all this jumping around for no reason.  If
there's a normal out and an error out, then fine, but in this case the
if (retval) { } could contain the entirety of the error path with an
else for the normal path.

scsi_remove_host() is the wrong API, it should be scsi_host_put() (for
an allocated but un added host).

James


