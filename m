Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbUK2Q5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUK2Q5g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 11:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbUK2Q5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 11:57:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38105 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261763AbUK2Q5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 11:57:33 -0500
Date: Mon, 29 Nov 2004 11:57:01 -0500
From: Dave Jones <davej@redhat.com>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: MTRR vesafb and wrong X performance
Message-ID: <20041129165701.GA903@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Gerd Knorr <kraxel@bytesex.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <1101338139.1780.9.camel@PC3.dom.pl> <20041124171805.0586a5a1.akpm@osdl.org> <1101419803.1764.23.camel@PC3.dom.pl> <87is7ogb93.fsf@bytesex.org> <20041129154006.GB3898@redhat.com> <20041129162242.GA25668@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041129162242.GA25668@bytesex>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(loony with broken SPF mailfilter removed from Cc)
		
On Mon, Nov 29, 2004 at 05:22:42PM +0100, Gerd Knorr wrote:

 > > vesafb is assuming that the memory used in the current screen mode
 > > xres*yres*depth rounded up to nearest power of 2, is the amount of
 > > ram the card has, which is not just wrong, it's dumb.
 > 
 > It used to do that, but doesn't any more in 2.6.10-rc2.  Check the
 > current code please.

ah, I was looking at a 2.6.9 tree, my apologies.

but..

    if (mtrr) {
        int temp_size = size_total;
        /* Find the largest power-of-two */
        while (temp_size & (temp_size - 1))
                    temp_size &= (temp_size - 1);

                /* Try and find a power of two to add */
        while (temp_size && mtrr_add(vesafb_fix.smem_start, temp_size, MTRR_TYPE_WRCOMB, 1)==-EINVAL) {
            temp_size >>= 1;
        }
    }

size_total is calculated thus:

    size_total = screen_info.lfb_size * 65536;
    if (vram_total)
        size_total = vram_total * 1024 * 1024;
    if (size_total < size_vmode)
        size_total = size_vmode;


where is screen_info.lfb_size set ?

 > > If vesafb can't get it right, maybe it shouldn't be
 > > attempted to do it in the half-assed way it currently does.
 > 
 > Well, 2.6.10-rc1 + newer should get it right now.  We can't do much
 > about BIOS bugs through, other than maybe disabling mtrr by default
 > if too many machines are affected.

or blacklist if there aren't too many perhaps?

		Dave

