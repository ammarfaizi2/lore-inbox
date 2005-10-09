Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbVJISF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbVJISF6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 14:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbVJISF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 14:05:57 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:13469 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932170AbVJISF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 14:05:57 -0400
From: Dan Dennedy <dan@dennedy.org>
To: linux1394-devel@lists.sourceforge.net
Subject: Re: [patch] raw1394: fix locking in the presence of SMP and interrupts
Date: Sun, 9 Oct 2005 11:05:48 -0700
User-Agent: KMail/1.8.1
Cc: Andy Wingo <wingo@pobox.com>, linux-kernel@vger.kernel.org
References: <1128530142.12591.26.camel@localhost.localdomain>
In-Reply-To: <1128530142.12591.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 1942
Message-Id: <200510091105.48336.dan@dennedy.org>
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 October 2005 09:35 am, Andy Wingo wrote:
> In raw1394.c:handle_iso_listen(), don't grab host_info_lock at all --
> we're not accessing host_info_list or host_count, and holding this lock
> while trying to tasklet_kill the iso tasklet this can cause an ABBA
> deadlock if ohci:dma_rcv_tasklet is running and tries to grab
> host_info_lock in raw1394.c:receive_iso. Test program attached reliably
> deadlocks all SMP machines I have been able to test without this patch.

I have to admit being surprised to see this because I have been using an SMP 
machine for a few years and not noticed a consistent or reproducible problem 
here. However, I have to admit the majority of my isochronous usage on kernel 
2.6 has been using the new API and implementation (aka rawiso and 
libiec61883). So, I tested your program on my dual Athlon running a 2.6.12 
SMP kernel, and it worked fine a few times when run manually. Then, I put it 
into a shell loop:
I="0"; while [ $I -lt 1000 ]; do ./raw1394reader_nothreads; \
echo ran iteration $I; I=`expr $I + 1`; done

Eventually, it did deadlock. So, I applied the patch, and the above looping 
test ran fine 3 times.Works for me.
