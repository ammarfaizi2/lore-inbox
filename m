Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbVBJVst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVBJVst (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 16:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVBJVst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 16:48:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:35465 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261790AbVBJVsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 16:48:46 -0500
Date: Thu, 10 Feb 2005 13:48:56 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: "Simon White" <s_a_white@email.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Detecting kernel shutdown in a kernel driver
Message-ID: <20050210134856.6ee0f236@dxpl.pdx.osdl.net>
In-Reply-To: <20050210200537.AD4754BE65@ws1-1.us4.outblaze.com>
References: <20050210200537.AD4754BE65@ws1-1.us4.outblaze.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed-Claws 1.0.0 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2005 15:05:37 -0500
"Simon White" <s_a_white@email.com> wrote:

> Hi,
> 
> I've been writing a device driver for a piece of hardware that we recently found the pci bridge has an issue on software reset (kernel 2.6.8.1, hardware reset is fine).  The bridge appears to corrupt the subvendor/device ids on next boot.  We have found a software work around in that I can write to the bridge on module exit and it will always detect correctly next boot (through module_exit when rmmod'd).
> 
> However on shutting down a machine with the module loaded it never works next time, so is module_exit actually called?

(Line wrap your mail please)

> Secondly I searched through some code and on google to determine if I could detect a shutdown notification in the kernel.  I thougt I'd found something using:
> 
> static struct pci_driver hsid_driver =
> {
>     .name     = HSID_NAME,
>     .id_table = id_table,
>     .probe    = hsid_probe,
>     .driver   =
>     {
>         .shutdown = hsid_shutdown,
>     },
> };
> 
> However that also appears not to work.  I wondered what the correct solution was for detecting system shutdown in the kernel even if the application using the device has locked up on un-interruptible sleep, so I may try to clean the hardware up a little.
> 
> Thankyou for any assistance,
> Simon

How about the following, you probably still need pci_hook to handle PCI hot plug,
but you hardware probably doesn't do bus hot plug anyway.

------------

static int hsid_notify(struct notifier_block *this, unsigned long code, void *unused)
{
        if (code==SYS_DOWN || code==SYS_HALT) {
 		bang_the_bridge();
        }

        return NOTIFY_DONE;
}


static struct notifier_block hsid_notifier = {
	.notifier_call	= hsid_notify,
};


hsid_module_init()
	...
	register_reboot_notifier(&hsid_notifier);


hsid_module_exit()
	...
	unregister_reboot_notifier(&hsid_notifier);
