Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWEFCfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWEFCfx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 22:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbWEFCfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 22:35:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43927 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751108AbWEFCfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 22:35:53 -0400
Date: Fri, 5 May 2006 19:35:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device core: remove redundant call to
 device_initialize.
Message-Id: <20060505193542.0332557b.akpm@osdl.org>
In-Reply-To: <20060505153907.12756.23295.stgit@zion.home.lan>
References: <20060505153907.12756.23295.stgit@zion.home.lan>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 May 2006 17:39:08 +0200
"Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:

> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> platform_device_add calls device_register which calls then again
> device_initialize, redundantly.
> 
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> ---
> 
>  drivers/base/platform.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 83f5c59..b0d9bd4 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -317,7 +317,6 @@ EXPORT_SYMBOL_GPL(platform_device_del);
>   */
>  int platform_device_register(struct platform_device * pdev)
>  {
> -	device_initialize(&pdev->dev);
>  	return platform_device_add(pdev);
>  }
>  EXPORT_SYMBOL_GPL(platform_device_register);

platform_device_add() initialises a bunch of things in pdev->dev and _then_
calls device_register(&pdev->dev) which calls device_initialize() to "init
device structure".  This happens after we've already done some
initialisation on the thing.   This is not nice.

A better design would be to rip out all the device_initialize() calls and
require that the caller run device_initialize() before "add"ing or
"register"ing the platform_device.

And indeed platform_device_alloc() already does that.  If that is
sufficient then we're in good shape.

If it is not sufficient then more thought would be needed.  We could at
least run device_initialize() at the _start_ of platform_device_add(),
rather than towards the end.

icky stuff.
