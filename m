Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262719AbVDYRUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbVDYRUY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 13:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262682AbVDYRNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 13:13:46 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:11027 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S262668AbVDYRDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 13:03:06 -0400
Date: Mon, 25 Apr 2005 19:02:59 +0200
From: Olivier Galibert <galibert@pobox.com>
To: "Hack inc." <linux-kernel@vger.kernel.org>
Subject: tcp_sendpage and page allocation lifetime vs. iscsi
Message-ID: <20050425170259.GA36024@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	"Hack inc." <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a problem with the iscsi driver (both 4.x and 5.x) and scsi
tape I'm not sure how to solve.  It may linked to some specific
characteristics of the tg3 network driver.

What happens is, from what I can trace:
1- st alloc_pages a bunch of pages for buffering

2- st sends a bunch of them to iscsi for writing (32K is common when
     labelling a tape for instance)

3- iscsi sends whatever header is needed followed by the data using
     tcp_sendpage

4- tcp_sendpage copies from of the pages but get_page() others,
     probably depending on the state of the socket buffer.  It returns
     immediatly anyway, leaving some pages with an elevated count (which, I
     guess, it will eventually decrement again)

5- iscsi returns to st

6- st reuses the buffer immediatly, and/or frees it if the device is
     closed.  Silent corruption in one case, bad_page in __free_page_ok
     called from normalize_buffer in the other.

I'm going to complete my traces to be sure that's really what's going
on (I don't have a log immediatly after sendpage yet).  But in any
case, what would the solution be?

  OG.

