Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbUKPWbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbUKPWbs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 17:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbUKPWbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 17:31:48 -0500
Received: from ozlabs.org ([203.10.76.45]:50402 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261852AbUKPWbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 17:31:46 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16794.32730.184008.344036@cargo.ozlabs.ibm.com>
Date: Wed, 17 Nov 2004 09:31:54 +1100
From: Paul Mackerras <paulus@samba.org>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kai Makisara <Kai.Makisara@metla.fi>, Willem Riede <osst@riede.org>,
       coda@cs.cmu.edu
Subject: Re: [patch 0/4] Cleanup file_count usage
In-Reply-To: <20041116135200.GA23257@impedimenta.in.ibm.com>
References: <20041116135200.GA23257@impedimenta.in.ibm.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai writes:

> 2. Read to f_count at drivers/net/ppp_generic.c:
>    The PPPIOCDETACH ioctl is failed if the device fd is duped and
>    being polled by another process -- which is determined by a read
>    to f_count.  The comments in the code indicate that the PPPIOCDETACH 
>    ioctl should be junked and userland can use a workaround
>    by closing the fd and reopening /dev/ppp.  I can make a patch to junk
>    PPPIOCDETACH, but is it okay to break binary compatibility? Paul?

I would very much rather not break binary compatibility.  People using
ppp-2.4.2 or ppp-2.4.3 won't be affected by this change, but ppp-2.4.2
was released in January this year and I wouldn't be surprised if
some people are still using ppp-2.4.1 (or even ppp-2.4.0), which would
be affected.

I suggest that as a temporary compromise, we keep PPPIOCDETACH but
make it zero file->private_data without freeing the ppp structure that
it points to.  That will cause a memory leak but will avoid the
possibility of using that memory after it is freed (in the case where
the descriptor has been dup'd and another process is doing a poll on
it).

We should make the kernel whinge loudly when anyone uses PPPIOCDETACH,
too.  If/when 2.7.0 comes along we can remove it.

Paul.
