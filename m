Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317488AbSFDXaC>; Tue, 4 Jun 2002 19:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317500AbSFDXaB>; Tue, 4 Jun 2002 19:30:01 -0400
Received: from nameservices.net ([208.234.17.10]:12567 "EHLO linuxfrost.org")
	by vger.kernel.org with ESMTP id <S317488AbSFDXaA>;
	Tue, 4 Jun 2002 19:30:00 -0400
Message-ID: <009301c20c1f$bf5a4980$0101c80a@sashastation>
From: "Alexandr Sandler" <rookie@linuxfrost.org>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Requests never returning?
Date: Wed, 5 Jun 2002 01:29:26 +0200
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list.

I am working on a logical volume manager (yep, another one) driver for
Linux. I implemented block device driver that used to receive requests and
to redirect them to scsi disks (by changing bh->b_rdev and bh->b_rsector). I
am experiencing a problem with my driver and I was wondering if anyone can
help me with it.

Notice that scsi disks sitting on SAN.

The driver, as it is, seems to be quite stable. I confident it can run for
weeks under the most heavy stress test, despite I only tried 48 hours tests.
But sometimes, very rarely, something goes wrong and process doing I/O (on
the logical volume + file system) getting stacked. Call trace (from kdb)
looks like this. Process trying to do generic_file_read() (or ..._write())
and, eventually, getting into lock_page() - this is where it's getting
stacked. What seems to be obvious (for me - correct me if I am wrong), is
that process supposed to succeed locking page, but buffer_head using this
page is never getting it's b_end_io() and here we go - it's stacked.

This is happening, usually, when one or several computers on SAN getting
restarted and as a result making a lot of noise (LIPs) on fiber. And it's
even more strange because I made special tests to reveal the conditions
needed for this to happen. I caused hundreds of LIPs, but Linux box was
stable and test was running - it was couple of month ago. And now it
happened once again - when I rebooted some lame NetWare host.

I think the problem is not with my driver (yes, I know it's better to be
paranoiac in this things), despite I never tried to do some stress tests
with scsi disks - without my driver.

So, my question is like this. Is there any condition, under which I/O
requests may not return (even with error), when working with SAN?

Here are some specs:
It's Pentium III 800 MHz UP with 256Mb of RAM. Kernel 2.4.16 (as far as I
remember there was no major changes and bugfixes in scsi layer in 2.4.17 and
2.4.18, so I think it doesn't really matter if I use 2.4.16 or 2.4.18 - once
again, correct me if I am wrong) . I am using RedHat 7.1 distro. Two Qlogic
2200 optical HBAs powered by qlogic 4.27b driver (this part may seem to be
crucial - I never tried to work with other versions of their drivers. On the
other hand, I never had a reason to doubt stability of this version). SAN
sitting on Gadzoox Capellix 3000 - arbitrated loop (I got the same behavour
with Brocade switch - don't remember the model).

Thanks in advance for any help.

Alexandr Sandler.


