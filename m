Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932635AbWBTFhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932635AbWBTFhH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 00:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbWBTFhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 00:37:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18344 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932635AbWBTFhF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 00:37:05 -0500
Date: Sun, 19 Feb 2006 21:35:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] swsusp/pm: refuse to suspend devices if wrong
 console is active
Message-Id: <20060219213526.45efd900.akpm@osdl.org>
In-Reply-To: <200602192326.37265.rjw@sisk.pl>
References: <200602192326.37265.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> 1) Remove the console-switching code from the suspend part of the swsusp
> userland interface and let the userland tools switch the console.
> 
> 2) It is unsafe to suspend devices if the hardware is controlled by X.  Add
> an extra check to prevent this from happening.
> 
> ...
> @@ -82,6 +85,12 @@ int device_suspend(pm_message_t state)
>  {
>  	int error = 0;
>  
> +	/* It is unsafe to suspend devices while X has control of the
> +	 * hardware. Make sure we are running on a kernel-controlled console.
> +	 */
> +	if (vc_cons[fg_console].d->vc_mode != KD_TEXT)
> +		return -EINVAL;
> +
>  	down(&dpm_sem);

Does this mean that swsusp simply won't work if invoked while X is running
and being displayed?  If so, that sounds like a pretty severe limitation.
