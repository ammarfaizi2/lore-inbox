Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbVGZDxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVGZDxj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 23:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVGZDxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 23:53:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49061 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261545AbVGZDxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 23:53:38 -0400
Date: Mon, 25 Jul 2005 20:52:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: Fw: Oops in hidinput_hid_event
Message-Id: <20050725205226.6343f323.akpm@osdl.org>
In-Reply-To: <20050718141637.074c6f70.zaitcev@redhat.com>
References: <20050718141637.074c6f70.zaitcev@redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev <zaitcev@redhat.com> wrote:
>
> I think this patch is rather obvious, so maybe I should ask Andrew to
> apply it to -mm for now, to get some testing. Would that help to verify
> it for acceptance?
> 
> -- Pete
> 
> Begin forwarded message:
> 
> Date: Tue, 28 Jun 2005 15:00:23 -0700
> From: Pete Zaitcev <zaitcev@redhat.com>
> To: vojtech@suse.cz
> Cc: zaitcev@redhat.com, linux-usb-devel@lists.sourceforge.net
> Subject: Oops in hidinput_hid_event
> 
> Hi, Vojtech:
> 
> Someone reported a bug in Fedora, which runs a largely unmodified upstream
> kernel in this area. Whenever the user hits a key which switches LED,
> the system oopses. Here's a trace:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 000000c8
> EFLAGS: 00010006   (2.6.11-1.1369_FC4smp)
> EIP is at hidinput_hid_event+0x2d/0x292                                       
> Call Trace:           
>  [<c02872e0>] hid_process_event+0x57/0x5f
>  [<c028758a>] hid_input_field+0x2a2/0x2ac
>  [<c0287632>] hid_input_report+0x9e/0xb8
>  [<c0287f62>] hid_ctrl+0x14c/0x151
>  [<e0a21060>] uhci_destroy_urb_priv+0xb5/0x10a [uhci_hcd]
>  [<c027dab5>] usb_hcd_giveback_urb+0x24/0x67
>  [<e0a22360>] uhci_finish_urb+0x2d/0x38 [uhci_hcd]
>  [<e0a223af>] uhci_finish_completion+0x44/0x56 [uhci_hcd]
>  [<e0a224a2>] uhci_scan_schedule+0xaa/0x13a [uhci_hcd]
>  [<c023413d>] i8042_interrupt+0x121/0x234
>  [<e0a226d0>] uhci_irq+0x47/0x10d [uhci_hcd]
> 
> Full trace at
>  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=160709
> 
> Any ideas?
> 
> By the way, it seems that I see a bug in hidinput_hid_event.
> The check for NULL can never work, becaue &hidinput->input
> is nonzero at all times. How about this?

Do you expect this patch:

> --- linux-2.6.12/drivers/usb/input/hid-input.c	2005-06-21 12:58:47.000000000 -0700
> +++ linux-2.6.12-lem/drivers/usb/input/hid-input.c	2005-06-28 14:57:22.000000000 -0700
> @@ -397,11 +397,12 @@
>  
>  void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct hid_usage *usage, __s32 value, struct pt_regs *regs)
>  {
> -	struct input_dev *input = &field->hidinput->input;
> +	struct input_dev *input;
>  	int *quirks = &hid->quirks;
>  
> -	if (!input)
> +	if (!field->hidinput)
>  		return;
> +	input = &field->hidinput->input;
>  
>  	input_regs(input, regs);

To actually fix the above oops?  It sure looks like it will.  But I worry
whether it is the correct fix?


