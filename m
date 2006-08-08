Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWHHD3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWHHD3t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 23:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWHHD3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 23:29:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33727 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932129AbWHHD3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 23:29:48 -0400
Date: Mon, 7 Aug 2006 20:29:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, gregkh <greg@kroah.com>
Subject: Re: [PATCH -mm 5/5] usbnet: printk format warning
Message-Id: <20060807202945.48d7e86a.akpm@osdl.org>
In-Reply-To: <20060807155640.63e59e6b.rdunlap@xenotime.net>
References: <20060807154750.5a268055.rdunlap@xenotime.net>
	<20060807155044.a8eee456.rdunlap@xenotime.net>
	<20060807155208.666d7ea3.rdunlap@xenotime.net>
	<20060807155432.a7462087.rdunlap@xenotime.net>
	<20060807155640.63e59e6b.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Aug 2006 15:56:40 -0700
"Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> Fix printk format warning(s):
> drivers/usb/net/usbnet.c:654: warning: int format, different type arg (arg 3)
> 
> Can't say that I understand this one...
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> ---
>  drivers/usb/net/usbnet.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2618-rc3mm2.orig/drivers/usb/net/usbnet.c
> +++ linux-2618-rc3mm2/drivers/usb/net/usbnet.c
> @@ -652,7 +652,7 @@ static int usbnet_open (struct net_devic
>  			framing = "simple";
>  
>  		devinfo (dev, "open: enable queueing "
> -				"(rx %d, tx %d) mtu %d %s framing",
> +				"(rx %ld, tx %d) mtu %u %s framing",
>  			RX_QLEN (dev), TX_QLEN (dev), dev->net->mtu,
>  			framing);

Your compiler wasn't very helpful.  Or maybe we get better diagnostics with
a 64-bit compiler:



From: Randy Dunlap <rdunlap@xenotime.net>

Fix printk format warning(s):

drivers/usb/net/usbnet.c: In function 'usbnet_open':
drivers/usb/net/usbnet.c:654: warning: format '%d' expects type 'int', but argument 3 has type 'size_t'

The fact that rx_urb_size happens to be a size_t has propagated all the way
back to this printk.  It's fragile to be using %z in this case - let's just
typecast the args instead.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/usb/net/usbnet.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/usb/net/usbnet.c~usbnet-printk-format-warning drivers/usb/net/usbnet.c
--- a/drivers/usb/net/usbnet.c~usbnet-printk-format-warning
+++ a/drivers/usb/net/usbnet.c
@@ -653,7 +653,7 @@ static int usbnet_open (struct net_devic
 
 		devinfo (dev, "open: enable queueing "
 				"(rx %d, tx %d) mtu %d %s framing",
-			RX_QLEN (dev), TX_QLEN (dev), dev->net->mtu,
+			(int)RX_QLEN(dev), (int)TX_QLEN(dev), dev->net->mtu,
 			framing);
 	}
 
_

