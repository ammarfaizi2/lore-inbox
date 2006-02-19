Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbWBSGuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbWBSGuF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 01:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWBSGuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 01:50:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33201 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751071AbWBSGuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 01:50:01 -0500
Date: Sat, 18 Feb 2006 22:49:24 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       zaitcev@redhat.com,
       Wolfgang =?UTF-8?B?TcO8ZXM=?= <wolfgang@iksw-muees.de>,
       <martinmaurer@gmx.at>
Subject: Re: 2.6.15: usb storage device not detected
Message-Id: <20060218224924.737bd36b.zaitcev@redhat.com>
In-Reply-To: <20060219051915.GA1888@zip.com.au>
References: <20060109130540.GB2035@zip.com.au>
	<20060109101713.469d3a7f.zaitcev@redhat.com>
	<20060219051915.GA1888@zip.com.au>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.12; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Feb 2006 16:19:15 +1100, CaT <cat@zip.com.au> wrote:

Thanks for the trace, CaT!

> c31f414c 744561726 S Bo:005:02 -115 31 = 55534243 00000000 00000000 00000600 00000000 00000000 00000000 000000
> c31f414c 744561854 C Bo:005:02 0 31 >
> c31f414c 744561863 S Bi:005:01 -115 13 <
> c31f414c 745057444 C Bi:005:01 0 13 = 55534253 00000000 00000000 00
> c31f414c 745057463 S Ci:005:00 s a1 fe 0000 0000 0001 1 <
> c31f414c 745057691 C Ci:005:00 -32 0
> c31f414c 745057750 S Co:005:00 s 02 01 0000 0081 0000 0
> c31f414c 745058065 C Co:005:00 0 0
> c31f414c 745058072 S Co:005:00 s 02 01 0000 0002 0000 0
> c31f414c 745058314 C Co:005:00 0 0
> c31f414c 745058386 S Bo:005:02 -115 31 = 55534243 01000000 00000000 00000600 00000000 00000000 00000000 000000
> c31f414c 745058437 C Bo:005:02 0 31 >
> c31f414c 745058444 S Bi:005:01 -115 13 <
> c31f414c 750057024 C Bi:005:01 -104 0

I see... This is a device which dislikes the stall clear when called after
a stall on the control pipe.

I knew this was inevitable ever since Wolfgang pointed me at it when we
debugged Martin's Elitegroup K7S5A.

I'm going to send the attached patch to Greg to get it into 2.6.17
(this way it will be separated from all the reset machinery which goes
into 2.6.16). I have tested it on my honest to goodness ZIP-100, and
yes, it stalls the control pipe at the GetMaxLUN, and yes, it works
after that. Here's the hope that it is some kind of an urban legend.

Thanks again,
-- Pete

--- linux-2.6.16-rc2/drivers/block/ub.c	2006-02-11 00:31:36.000000000 -0800
+++ linux-2.6.16-rc2-lem/drivers/block/ub.c	2006-02-18 22:21:30.000000000 -0800
@@ -2480,19 +2477,8 @@ static int ub_probe(struct usb_interface
 
 	nluns = 1;
 	for (i = 0; i < 3; i++) {
-		if ((rc = ub_sync_getmaxlun(sc)) < 0) {
-			/* 
-			 * This segment is taken from usb-storage. They say
-			 * that ZIP-100 needs this, but my own ZIP-100 works
-			 * fine without this.
-			 * Still, it does not seem to hurt anything.
-			 */
-			if (rc == -EPIPE) {
-				ub_probe_clear_stall(sc, sc->recv_bulk_pipe);
-				ub_probe_clear_stall(sc, sc->send_bulk_pipe);
-			}
+		if ((rc = ub_sync_getmaxlun(sc)) < 0)
 			break;
-		}
 		if (rc != 0) {
 			nluns = rc;
 			break;
