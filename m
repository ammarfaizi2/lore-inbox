Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbTIQXjX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 19:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbTIQXjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 19:39:23 -0400
Received: from dsl092-233-042.phl1.dsl.speakeasy.net ([66.92.233.42]:17567
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id S262884AbTIQXjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 19:39:21 -0400
X-All-Your-Base: Are Belong To Us!!!
X-Envelope-Recipient: linux-kernel@vger.kernel.org
X-Envelope-Sender: oliver@klozoff.com
Message-ID: <3F68F004.7020107@klozoff.com>
Date: Wed, 17 Sep 2003 19:36:36 -0400
From: Stevie-O <oliver@klozoff.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Aliasing physical memory using virtual memory (from a driver's perspective)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on a driver for a PCI card that outputs a LOT of data.  Think tens 
of megabytes per second.

Each separate DMA transfer is for about 640KB of data. Since the standard PC 
architecture was designed too cheaply to have a set of DMA remapping registers, 
it's highly unlikely that even in That Other OS will one find 160 consecutive 
free pages.  Thus, the card has a built-in scatter-gather mechanism.

The driver needs to do some processing on each 640KB chunk before passing it 
onto userspace (there are reasons why this processing can't happen in userspace, 
that's all anyone should need to know).  There's a sort-of-a-shortcut that is 
currently done that processes 9 pages worth at once.  Since the 9 pages need to 
be contiguous, the driver (sadly) kmalloc()s the scatter-gather buffer in 9-page 
chunks; if I understand the slab stuff correctly, this actually winds up 
allocating 16 *consecutive* pages for each sub-buffer.   16 consecutive pages is 
  still kinda hard to come by, however, so the driver allocates a very large 
pile at startup.

The card uses physical memory, but if I understand things correctly (which I 
probably don't), the driver/kernel runs on virtual memory.

My thinking is this: I want to use __get_free_pages(1) 80 times to get the 160 
pages, then passed those 80 pieces to the card (it's known the card can handle 
requests with that many pieces).  Then I want to create a *virtually* contiguous
160-page mapping, so the postprocessing code in the driver can view the 80 
2-page sub-buffers as one big consecutive 160-page buffer.  Doing this would (a) 
make for more efficient use of memory, and (b) leave the larger piles of 
contiguous pages to the drivers of cards that actually require them.

Is this possible?

-- 
- Stevie-O

Real Programmers use COPY CON PROGRAM.EXE


