Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265353AbUBPEFX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 23:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265340AbUBPEFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 23:05:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37530 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265353AbUBPEFQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 23:05:16 -0500
Message-ID: <4030416E.9070805@pobox.com>
Date: Sun, 15 Feb 2004 23:05:02 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grzegorz Kulewski <kangur@polcom.net>
CC: Christophe Saout <christophe@saout.de>, linux-kernel@vger.kernel.org
Subject: Re: dm-crypt using kthread
References: <402A4B52.1080800@centrum.cz>  <1076866470.20140.13.camel@leto.cs.pocnet.net>  <20040215180226.A8426@infradead.org>  <1076870572.20140.16.camel@leto.cs.pocnet.net>  <20040215185331.A8719@infradead.org>  <1076873760.21477.8.camel@leto.cs.pocnet.net>  <20040215194633.A8948@infradead.org>  <20040216014433.GA5430@leto.cs.pocnet.net>  <20040215175337.5d7a06c9.akpm@osdl.org>  <Pine.LNX.4.58.0402160303560.26082@alpha.polcom.net> <1076900606.5601.47.camel@leto.cs.pocnet.net> <Pine.LNX.4.58.0402160409190.26082@alpha.polcom.net>
In-Reply-To: <Pine.LNX.4.58.0402160409190.26082@alpha.polcom.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Kulewski wrote:
> Could somebody write dm-compress (compressing not encrypting)? Is it 
> technically possible (can device mapper handle different data size at 
> input, differet at output)? (I think there is compressing loop patch.)
> Could dm first compress data (even with weak algorithm), then encrypt, to 
> make statistical analysis harder?


It's certainly possible, but you have to consider that data transfer 
almost always should be considered in page-sized chunks.  For compress 
that would imply you would need to allocate/free blocks and similar 
duties that a filesystem must perform, simply because you do not have 
one-to-one correspondence with blocks being passed to you.

You also have to consider that the kernel may request one or more pages 
that are in the middle of a compressed run of pages.  For example, 
consider an algorithm that compresses 16 pages into a run of 4 pages. 
Later on, when the kernel requests (uncompressed) page 9, you likely 
need to read all 4 pages, and allocate 16 more pages for decompression. 
  So, reading 1 upper layer page required dm-compress tying up 20 pages.

	Jeff



