Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbVCYSik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVCYSik (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 13:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbVCYSij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 13:38:39 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:18676 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261740AbVCYSiW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 13:38:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=jHYaJOxkbvE9q+5D+q47ftITNVe+fYycASU16LN/lheQ7VJfLCJuv/owKzMbvTKaqKX7Yb1krGcvZSWCpB7PtH1nSVoMbaqAZk6ACj+RGYo4j+2FzWkzmuAuI8LTHQ6c+O1EJ26nlBbrq3QcJIv6rJ/Km8icHIQSqxIwq1h/CA0=
Message-ID: <aa4c40ff050325103875b09bcf@mail.gmail.com>
Date: Fri, 25 Mar 2005 10:38:21 -0800
From: James Lamanna <jlamanna@gmail.com>
Reply-To: James Lamanna <jlamanna@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [linux-usb-devel] Long delay on serial-usb echo readback
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the following setup:
FTDI USB->Serial chip hooked up to a CAN signaling transceiver.
Due to the nature of CAN, I automatically get local echo back through
the FTDI chip.
I'm not using the CAN protocol, but just its signaling properties.
The problem I am having is everytime I write something I must read
back what I've written in order to read back correct data from the
device it is hooked up to, because of CAN having hardware echo.

I am finding that if the string that I send is long enough (usually
greater than 22 bytes in most cases), the FTDI chip splits the
response into at least two IN data packets.
Unfortunately there is a large delay between these two packets (for a
write of 64 bytes its usually around 19ms @ 115200 baud).

I'm wondering if this delay can be shortened or if it is the result of
USB hardware on either end (either the FTDI chip or the USB
hardware/stack on the computer side).

This is with vanilla linux-2.6.11.

A sample transaction with lots of debugging looks like the following:

FTDI FT232BM Compatible ttyUSB0: ftdi_write - length = 64, data = 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
drivers/usb/serial/ftdi_sio.c: sent write urb, count 64, at 0us
drivers/usb/serial/ftdi_sio.c: ftdi_write write returning: 64
drivers/usb/serial/ftdi_sio.c: ftdi_chars_in_buffer - port 0
drivers/usb/serial/ftdi_sio.c: ftdi_write_room - port 0
drivers/usb/serial/ftdi_sio.c: ftdi_write_bulk_callback - port 0
drivers/usb/serial/ftdi_sio.c: ftdi_chars_in_buffer - port 0
drivers/usb/serial/ftdi_sio.c: ftdi_write_room - port 0
drivers/usb/serial/ftdi_sio.c: 89: ftdi_read_bulk_callback at 2895us
data_count 25
drivers/usb/serial/ftdi_sio.c: ftdi_read_bulk_callback - port 0
drivers/usb/serial/ftdi_sio.c: ftdi_process_read - port 0
FTDI FT232BM Compatible ttyUSB0: ftdi_process_read - length = 25, data
= 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00
drivers/usb/serial/ftdi_sio.c: 90: ftdi_process send urb at 2925us
drivers/usb/serial/ftdi_sio.c: ftdi_chars_in_buffer - port 0
drivers/usb/serial/ftdi_sio.c: ftdi_write_room - port 0
drivers/usb/serial/ftdi_sio.c: ftdi_chars_in_buffer - port 0
drivers/usb/serial/ftdi_sio.c: ftdi_write_room - port 0
drivers/usb/serial/ftdi_sio.c: 90: ftdi_read_bulk_callback at 18893us
data_count 43
drivers/usb/serial/ftdi_sio.c: ftdi_read_bulk_callback - port 0
drivers/usb/serial/ftdi_sio.c: ftdi_process_read - port 0
FTDI FT232BM Compatible ttyUSB0: ftdi_process_read - length = 43, data
= 01 60 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
drivers/usb/serial/ftdi_sio.c: 91: ftdi_process send urb at 18938us
drivers/usb/serial/ftdi_sio.c: ftdi_chars_in_buffer - port 0
drivers/usb/serial/ftdi_sio.c: ftdi_write_room - port 0
drivers/usb/serial/ftdi_sio.c: ftdi_close
drivers/usb/serial/ftdi_sio.c: 91: ftdi_read_bulk_callback at 22891us
data_count 0
drivers/usb/serial/ftdi_sio.c: ftdi_read_bulk_callback - port 0

Thanks in advance,
-- James Lamanna
