Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132399AbRCaNyY>; Sat, 31 Mar 2001 08:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132400AbRCaNyO>; Sat, 31 Mar 2001 08:54:14 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:38416 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S132399AbRCaNyA>; Sat, 31 Mar 2001 08:54:00 -0500
Date: Sat, 31 Mar 2001 15:58:11 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: "Scott G. Miller" <scgmille@indiana.edu>
cc: <linux-kernel@vger.kernel.org>, Andy Carlson <naclos@swbell.net>
Subject: Re: pcnet32 (maybe more) hosed in 2.4.3 
In-Reply-To: <20010330190137.A426@indiana.edu>
Message-ID: <Pine.LNX.4.30.0103311541300.406-100000@fs131-224.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 Mar 2001, Scott G. Miller wrote:

> Linux 2.4.3, Debian Woody.  2.4.2 works without problems.  However, in
> 2.4.3, pcnet32 loads, gives an error message:

2.4.3 (and -ac's) are also broken as guest in VMWware due to the pcnet32
changes [doing 32 bit IO on 16 bit regs on the 79C970A controller].
Reverting this part of patch-2.4.3 below made things work again.

	Szaka

@@ -528,11 +535,13 @@
     pcnet32_dwio_reset(ioaddr);
     pcnet32_wio_reset(ioaddr);

-    if (pcnet32_wio_read_csr (ioaddr, 0) == 4 && pcnet32_wio_check (ioaddr)) {
-       a = &pcnet32_wio;
+    /* Important to do the check for dwio mode first. */
+    if (pcnet32_dwio_read_csr(ioaddr, 0) == 4 && pcnet32_dwio_check(ioaddr)) {
+        a = &pcnet32_dwio;
     } else {
-       if (pcnet32_dwio_read_csr (ioaddr, 0) == 4 && pcnet32_dwio_check(ioaddr)) {
-           a = &pcnet32_dwio;
+        if (pcnet32_wio_read_csr(ioaddr, 0) == 4 &&
+           pcnet32_wio_check(ioaddr)) {
+           a = &pcnet32_wio;
        } else
            return -ENODEV;
     }


