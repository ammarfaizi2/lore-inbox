Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129667AbQKIT3u>; Thu, 9 Nov 2000 14:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129703AbQKIT3l>; Thu, 9 Nov 2000 14:29:41 -0500
Received: from [64.64.109.142] ([64.64.109.142]:21262 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S129667AbQKIT3c>; Thu, 9 Nov 2000 14:29:32 -0500
Message-ID: <3A0AFA85.27F38728@didntduck.org>
Date: Thu, 09 Nov 2000 14:27:01 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Module open() problems, Linux 2.4.0
In-Reply-To: <Pine.LNX.3.95.1001109135504.14703A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> `lsmod` shows that a device is open twice when using Linux-2.4.0-test9
> when, in fact, it has been opened only once.
> 
> lsmod is version 2.3.15, the latest-and-greatest.
> 
> Here are the open/close routines for a module.
> 
> /*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
> /*
>  *  Open the device.
>  */
> static int device_open(struct inode *inp, struct file *fp)
> {
>     DEB(printk("%s open\n", info->dev));
>     MOD_INC_USE_COUNT;                         /* Increment usage count */
>     return 0;
> }
> /*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
> /*
>  *  Close the device.
>  */
> static int device_close(struct inode *inp, struct file *fp)
> {
>     DEB(printk("%s close\n", info->dev));
>     MOD_DEC_USE_COUNT;                         /* Decrement usage count */
>     return 0;
> }
> 
> When the module is closed, the use-count goes to zero as expected.
> However, a single open() causes the use-count to be 2.

This is harmless.  It is caused by a try_inc_mod_count(module) in the
function calling device_open(), which is the proper way for module
locking to be handled when not holding the BKL.  You can keep the
MOD_INC_USE_COUNT in the device driver for compatability with 2.2.

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
