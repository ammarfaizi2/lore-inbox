Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267757AbUHEPyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267757AbUHEPyc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 11:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267758AbUHEPyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 11:54:31 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:27115 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S267757AbUHEPxa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 11:53:30 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] scheduling while atomic in visor/serial (2.6.8-rc2-mm2)
Date: Thu, 5 Aug 2004 08:46:12 -0700
User-Agent: KMail/1.6.2
Cc: Norbert Preining <preining@logic.at>, linux-kernel@vger.kernel.org
References: <20040805072410.GA10350@gamma.logic.tuwien.ac.at>
In-Reply-To: <20040805072410.GA10350@gamma.logic.tuwien.ac.at>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200408050846.12661.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 August 2004 00:24, Norbert Preining wrote:
> Hi USB Gurus!
> 
> 2.6.8-rc2-mm2
> 
> It just happened to me that my X stopped working (all frozen) while
> syncing my palm. Sysrq/syslog brought forth:
> 
> vmunix: bad: scheduling while atomic!
> vmunix:  [<c0306098>] schedule+0x3d8/0x3e0
> vmunix:  [<f0cc273d>] usb_kill_urb+0xdd/0x160 [usbcore]

Looks like a synchronous unlink from a call context that
requires asynchronous unlinks ...

> vmunix:  [<c0116ba0>] autoremove_wake_function+0x0/0x50
> vmunix:  [<c0116ba0>] autoremove_wake_function+0x0/0x50
> vmunix:  [<f0cc2650>] usb_unlink_urb+0x40/0x50 [usbcore]
> vmunix:  [<f0de3608>] serial_throttle+0x38/0x90 [usbserial]
> vmunix:  [<c01e8a7f>] n_tty_receive_buf+0x1cf/0xe50

... aha!  TTY layer, and flush_to_ldisc() ... I seem to recall that
function is inconsistent about its locking policy.  Evidently
something about this call gave you the undesirable one.


> vmunix:  [<f12c2828>] _nv001903rm+0x98/0xa4 [nvidia]
> vmunix:  [<f0cbd912>] usb_get_dev+0x12/0x20 [usbcore]
> vmunix:  [<f0bca72e>] uhci_submit_common+0x1ee/0x2a0 [uhci_hcd]
> vmunix:  [<f0cc1b86>] hcd_submit_urb+0x106/0x190 [usbcore]
> vmunix:  [<c01e7468>] flush_to_ldisc+0x98/0x100

Someone's going to have to sort this out starting from about
right here... 

> vmunix:  [<f0dea741>] visor_read_bulk_callback+0x111/0x200 [visor]
> vmunix:  [<f0bc9f45>] uhci_destroy_urb_priv+0xb5/0x100 [uhci_hcd]
> vmunix:  [<f0cc20cd>] usb_hcd_giveback_urb+0x1d/0x60 [usbcore]
> vmunix:  [<f0bcb549>] uhci_finish_urb+0x39/0x60 [uhci_hcd]
> vmunix:  [<f0bcb5a3>] uhci_finish_completion+0x33/0x50 [uhci_hcd]
> vmunix:  [<f0bcb789>] uhci_irq+0x179/0x1d0 [uhci_hcd]
> vmunix:  [<f0cc213e>] usb_hcd_irq+0x2e/0x60 [usbcore]
> vmunix:  [<c0106140>] handle_IRQ_event+0x30/0x60
> vmunix:  [<c01064a0>] do_IRQ+0x90/0x130
> vmunix:  [<c01048f4>] common_interrupt+0x18/0x20
> vmunix: visor ttyUSB1: visor_unthrottle - failed submitting read urb, error 
-1 
