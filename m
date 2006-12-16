Return-Path: <linux-kernel-owner+w=401wt.eu-S965330AbWLPFwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965330AbWLPFwp (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 00:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965336AbWLPFwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 00:52:45 -0500
Received: from liaag2ad.mx.compuserve.com ([149.174.40.155]:60420 "EHLO
	liaag2ad.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965330AbWLPFwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 00:52:44 -0500
Date: Sat, 16 Dec 2006 00:47:09 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.18.5 usb/sysfs bug.
To: Dave Jones <davej@redhat.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Message-ID: <200612160050_MC3-1-D538-EA63@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20061215213715.GB15792@redhat.com>

On Fri, 15 Dec 2006 16:37:15 -0500, Dave Jones wrote:

> > Can you enable CONFIG_USB_DEBUG and send the log info that happens right
> > before this oops?
>
> Gah, and here it is, actually attached this time.

> BUG: unable to handle kernel NULL pointer dereference at virtual address 0000000b

> EIP is at sysfs_hash_and_remove+0x18/0xfd

That's strange.  Remove_files called sysfs_hash_and_remove()
with dir==0xfffffff3 (-13 decimal.)

static void remove_files(struct dentry * dir,
                         const struct attribute_group * grp)
{
        struct attribute *const* attr;

        for (attr = grp->attrs; *attr; attr++)
                sysfs_hash_and_remove(dir,(*attr)->name); <========
}

> Process pcscd (pid: 2678, ti=f6d28000 task=f7dbe1f0 task.ti=f6d28000)
> Stack: c0634109 fffffff3 f7063414 c069cf0c fffffff3 fffffff3 f7063414 c04a7f69 
>        c069cf00 f70632b0 c04a7fb8 f7063208 f70473a0 f7063208 c055572f f70632b0 
>        c05513ff f7063208 f7000640 00000001 f703f788 c055142e f6d28ed4 c058800c 
> Call Trace:
>  [<c04a7f69>] remove_files+0x15/0x1e
>  [<c04a7fb8>] sysfs_remove_group+0x46/0x5c
>  [<c055572f>] device_pm_remove+0x2b/0x62
>  [<c05513ff>] device_del+0x11a/0x141
>  [<c055142e>] device_unregister+0x8/0x10
>  [<c058800c>] usb_remove_ep_files+0x5b/0x7b
>  [<c0587b82>] usb_remove_sysfs_intf_files+0x1d/0x54
>  [<c0585b5c>] usb_set_interface+0x135/0x1bf
>  [<c0586047>] usb_unbind_interface+0x4a/0x6a
>  [<c0552a38>] __device_release_driver+0x60/0x78
>  [<c0552c85>] device_release_driver+0x2b/0x3a
>  [<c057e4f5>] usb_driver_release_interface+0x3b/0x63
>  [<c058833d>] releaseintf+0x4b/0x5b
>  [<c058ab8d>] usbdev_release+0x67/0x9e
>  [<c0470402>] __fput+0xba/0x188
>  [<c046dc61>] filp_close+0x52/0x59
>  [<c0404013>] syscall_call+0x7/0xb

What is pcscd?

Earlier in bootup you got this:

hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0004
uhci_hcd 0000:00:1d.0: port 2 portsc 008a,00
hub 1-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
usb 1-2: USB disconnect, address 2
usb 1-2: usb_disable_device nuking all URBs
uhci_hcd 0000:00:1d.0: shutdown urb f7ed7540 pipe 40408280 ep1in-intr
usb 1-2: unregistering interface 1-2:1.0
 usbdev1.2_ep81: ep_device_release called for usbdev1.2_ep81
usb 1-2:1.0: uevent
usb 1-2: unregistering device
 usbdev1.2_ep00: ep_device_release called for usbdev1.2_ep00

usb_remove_ep_files() is in the call trace, so this may be related?

-- 
MBTI: IXTP
