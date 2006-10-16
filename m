Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWJPPM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWJPPM0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 11:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWJPPM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 11:12:26 -0400
Received: from shoshil.marvell.com ([199.203.130.250]:63539 "EHLO
	il.marvell.com") by vger.kernel.org with ESMTP id S932131AbWJPPMZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 11:12:25 -0400
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: DIrectIO using kernel buffers
Date: Mon, 16 Oct 2006 17:11:56 +0200
Message-ID: <B9FFC3F97441D04093A504CEA31B7C41E915E1@msilexch01.marvell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: DIrectIO using kernel buffers
Thread-Index: AcbxNWs1rrdfcuX0RIKTlTAH4rjFXQ==
From: "Ronen Shitrit" <rshitrit@marvell.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm using kernel 2.6.12.
I'm trying to improve the usb gadget file storage implementation by
making it accessing the file storage with O_DIRECT,
In general what I'm trying to do is use DirectIO with buffer which was
allocated by kmalloc.

When trying to do so I get kernel panic, after some debug, I found that
I can't call get_user_pages on pages allocated by the kernel (kmalloc),
Is it correct??
Any way, I implemented some basic function get_kernel_pages to fill the
page array with the pages pointer of the kernel buffer,
Then I got lots of errors on illegal buffer freeing, I did some more
debug and I found that the direct-io is using the get_page and put_page
in order to increment the counter of the page and to make sure no one
will release them while the direct-io is using them, after the direct-io
is doing put_page it check if the page_count is 0, if so it release it
(see page_cache_release in direct-io.c), by doing this the direct-io is
trying to release the pages which I allocated by kmalloc and I get
errors.
So what I get is that the direct-io increments the count and then
decrements it and the count get to zero,
So I checked the count of the pages which I got from kmalloc and I found
that only the first page count is 0 (i.e. one process is using it) and
the rest were initialized by -1 (i.e. no process is using this buffer),
Is this a bug??
Any suggestion on how to use DirectIO with kernel buffers??

Regards
Ronen Shitrit

