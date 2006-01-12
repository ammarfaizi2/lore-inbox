Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932683AbWALGg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932683AbWALGg5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 01:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932686AbWALGg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 01:36:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:54209 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932683AbWALGg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 01:36:56 -0500
From: Neil Brown <neilb@suse.de>
To: Jurriaan <thunder7@xs4all.nl>
Date: Thu, 12 Jan 2006 17:36:42 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17349.63738.220760.681335@cse.unsw.edu.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm3 hangs during boot (raid related?)
In-Reply-To: message from Jurriaan on adsl-gate on Thursday January 12
References: <20060112062310.GA12471@gates.of.nowhere>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday January 12, thunder7@xs4all.nl wrote:
> 
> 2.6.15-mm3 hangs during boot for me, after the lines
> 
> ========
> md4: bitmap initialized from disk: read 15/15 pages, set 51 bits, status: 0
> created bitmap (224 pages) for device md4
> ========
> 
> ctrl-alt-del to reboot works sometimes (2 out of 3). Below is complete
> dmesg (from 2.6.15-mm2, ver_linux output, .config and raid details).

Yep, this is probably a known problem with recent changes to the
'barrier' code.

Try to convince md not to use barrier by changing md_super_write in
drivers/md/md.c.  Simply remove

	if (!test_bit(BarriersNotsupp, &rdev->flags)) {
		struct bio *rbio;
		rw |= (1<<BIO_RW_BARRIER);
		rbio = bio_clone(bio, GFP_NOIO);
		rbio->bi_private = bio;
		rbio->bi_end_io = super_written_barrier;
		submit_bio(rw, rbio);
	} else

leaving the
		submit_bio(rw, rbio);

which comes after it.

NeilBrown
