Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276953AbRJQPrf>; Wed, 17 Oct 2001 11:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276957AbRJQPr0>; Wed, 17 Oct 2001 11:47:26 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:49143 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S276953AbRJQPrM>; Wed, 17 Oct 2001 11:47:12 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Wed, 17 Oct 2001 09:47:03 -0600
To: Robert Cohen <robert.cohen@anu.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bench] New benchmark showing fileserver problem in 2.4.12
Message-ID: <20011017094703.E7859@turbolinux.com>
Mail-Followup-To: Robert Cohen <robert.cohen@anu.edu.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3BCD8269.B4E003E5@anu.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BCD8269.B4E003E5@anu.edu.au>
User-Agent: Mutt/1.3.22i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 17, 2001  23:06 +1000, Robert Cohen wrote:
> Factor 1: the performance problems only occur when you are rewriting an
> existing file in place. That is writing to an existing file which is
> opened without O_TRUNC. Equivalently, if you have written a file and
> then seek'ed back to the beginning and started writing again.
> 
> Evidence: in the report I posted yesterday, the test I was using
> involved 5 clients rewriting 30 Meg files on a 128 Meg machine. The
> symptom  was that after about 10 seconds, the throughput as shown by
> vmstat "bo" drops sharply and we start getting reads occuring as shown
> by the "bi" figure.

Just a guess - if you are getting reads that are about the same as writes,
then it would indicate that the code is doing "read-modify-write" for the
existing file data rather than just "write".  This would be caused by not
writing only full-sized aligned blocks to the files.

As to why this is happening only over the network - it may be that you are
are unable to send an even multiple of the blocksize over the network (MTU)
and this is causing fragmented writes.  Try using a smaller block size like
4k or so to see if it makes a difference.

Another possibility is that with 8k chunks you are needing order-1
allocations to receive the data and this is causing a lot of searching for
buffers to free.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

