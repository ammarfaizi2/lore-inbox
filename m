Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbTJSArR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 20:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbTJSArR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 20:47:17 -0400
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:43649
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S261920AbTJSArP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 20:47:15 -0400
From: John Mock <kd6pag@qsl.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: test8: uhci-hcd fails after software suspend [Bug #1373]
Message-Id: <E1AB1j8-0001kc-00@penngrove.fdns.net>
Date: Sat, 18 Oct 2003 17:47:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On VAIO R505RE after software suspend (either flavor), USB controller seems
to get hopelessly confused:

    Debian GNU/Linux testing/unstable tvr-vaio tty1

    tvr-vaio login: root
    Password:
    Last login: Sat Oct 18 14:53:29 2003 on tty1
    Linux tvr-vaio 2.6.0-test8 #3 Sat Oct 18 10:51:09 PDT 2003 i686 GNU/Linux
    You have new mail.
    tvr-vaio:~# sync; echo 4b > /proc/acpi/sleep

	[press power button]  lilo: 2.6.0-test8 resume=/dev/hda7

    drivers/usb/host/uhci-hcd.c: 1840: host controller halted. very bad
    hub 3-0:1.0: new USB device on port 1, assigned address 3
    tvr-vaio:~# e100: eth0 NIC Link is Up 100 Mbps Full duplex
    drivers/usb/host/uhci-hcd.c: 1840: host controller halted. very bad
    drivers/usb/host/uhci-hcd.c: 1840: host controller halted. very bad
    drivers/usb/host/uhci-hcd.c: 1840: host controller halted. very bad
    drivers/usb/host/uhci-hcd.c: 1840: host controller halted. very bad
    drivers/usb/host/uhci-hcd.c: 1840: host controller halted. very bad
    usb 3-1: control timeout on ep0out
    drivers/usb/host/uhci-hcd.c: 1840: host controller halted. very bad
    drivers/usb/host/uhci-hcd.c: 1840: host controller halted. very bad
    drivers/usb/host/uhci-hcd.c: 1840: host controller halted. very bad
    usb 3-1: control timeout on ep0out

    tvr-vaio:~#
    tvr-vaio:~# cat > /tmp/console.log

The relevant 'dmesg' and '.config' are contained in bugzilla:

    http://bugzilla.kernel.org/show_bug.cgi?id=1373

The workaround is to 'rmmod uhci-hcd' in the hiberation script, but this
isn't a great solution for something with a file system, like a digital 
camera.  

'uhci-hcd.c' does attempt to handle suspend/resume, but that process may
be buggy.  I did make the bug seem to go away by commenting a few things
out:

	static int uhci_resume(struct usb_hcd *hcd)
	{
		struct uhci_hcd *uhci = hcd_to_uhci(hcd);

		pci_set_master(uhci->hcd.pdev);

	//	if (uhci->state == UHCI_SUSPENDED)
	//		uhci->resume_detect = 1;
	//	else {
			reset_hc(uhci);
			start_hc(uhci);
	//	}
		uhci->hcd.state = USB_STATE_RUNNING;
		return 0;
	}

Which merely suggests to me that the problem isn't intractable.  When it
awakens from hibernation, it indeed recognizes the Sony flash device and
reassigns a SCSI address accordingly.  So there may be hope... 

			       -- JM
