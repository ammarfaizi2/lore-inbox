Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbWBCElf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWBCElf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 23:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWBCElf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 23:41:35 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:54896 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S964897AbWBCElf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 23:41:35 -0500
To: Dave Jones <davej@redhat.com>
Cc: Avi Kivity <avi@argo.co.il>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: discriminate single bit error hardware failure from slab
 corruption.
X-Message-Flag: Warning: May contain useful information
References: <20060202192414.GA22074@redhat.com> <43E2A784.2070809@argo.co.il>
	<20060203014645.GD10209@redhat.com> <43E2BA63.5050505@argo.co.il>
	<20060203042035.GF10209@redhat.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 02 Feb 2006 20:41:26 -0800
In-Reply-To: <20060203042035.GF10209@redhat.com> (Dave Jones's message of
 "Thu, 2 Feb 2006 23:20:35 -0500")
Message-ID: <ada3bj1xde1.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 03 Feb 2006 04:41:27.0316 (UTC) FILETIME=[182AED40:01C6287C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Dave> Hmm, I made a mistake in my maths somewhere, and some of
    Dave> those values are incorrect, so having the compiler do the
    Dave> work would have stopped me screwing up, but once the correct
    Dave> values are used, I doubt there's ever a really compelling
    Dave> reason to change the slab poison pattern.

But Avi is still correct about false positives.  For example, if
something stomps on the slab poison and leaves it as

    e0 08 03 00

then that will add up to eb and still trigger your message, even
though it's far from a single bit error.

Maybe making the loop be something like

	unsigned char total = 0, bad_count = 0;
	printk(KERN_ERR "%03x:", offset);
	for (i = 0; i < limit; i++) {
		if (data[offset+i] != POISON_FREE) {
			total += data[offset+i];
			++bad_count;
		}
		printk(" %02x", (unsigned char)data[offset + i]);
	}

and then you can put

	if (bad_count == 1)

before the switch statement.

I have to admit that Avi's code seems clearer to me too, though.

 - R.
