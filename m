Return-Path: <linux-kernel-owner+willy=40w.ods.org-S280408AbVBDFJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S280408AbVBDFJP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 00:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S280406AbVBDFJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 00:09:15 -0500
Received: from waste.org ([216.27.176.166]:57507 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S280035AbVBDFI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 00:08:26 -0500
Date: Thu, 3 Feb 2005 21:08:22 -0800
From: Matt Mackall <mpm@selenic.com>
To: Ethan Weinstein <lists@stinkfoot.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: e1000, sshd, and the infamous "Corrupted MAC on input"
Message-ID: <20050204050822.GT2493@waste.org>
References: <42019E0E.1020205@stinkfoot.org> <20050203070415.GC17460@waste.org> <4202F725.8040509@stinkfoot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4202F725.8040509@stinkfoot.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2005 at 11:16:37PM -0500, Ethan Weinstein wrote:
> Matt Mackall wrote:
> >On Wed, Feb 02, 2005 at 10:44:14PM -0500, Ethan Weinstein wrote:
> ...
> >>Finally, I used a crossover cable between the two boxes, which resulted 
> >>in the same error from sshd again.
> >
> >
> >Well ssh isn't an especially good test as it's hard to debug.
> >
> >Try transferring large compressed files via netcat and comparing the
> >results. eg:
> >
> >host1# nc -l -p 2000 > foo.bz2
> >
> >host2# nc host1 2000 < foo.bz2
> >
> >If the md5sums differ, follow up with a cmp -bl to see what changed.
> >
> >Then we can look at the failure patterns and determine if there's some
> >data or alignment dependence.
> >
> 
> Excellent tip, thanks.  I was able to reprodce the problem several times 
> using this technique with nc, however the problem was intermittent (as 
> nasty problems like this often are).  I used a 1.3G gzipped tarball and 
>  experienced several botched transfers along with a few good ones.  To 
> be fair, I also switched back to 100Fdx and repeated; I didn't get a 
> single failure at this speed over 25 or so runs.
> 
> The results of two cmp's are here:
> 
> http://www.stinkfoot.org/e1000tests.out
> 
> What next?

Ok, reproduceable without ssh makes narrowing this down much easier.
Are you seeing errors on the interface? No would indicate problems
post CRC checking on the receive side. Do errors happen in both
directions? If not, it may be CPU speed-related or specific to a given
NIC - swap them if they're not onboard. 

The next test is to send patterns. Try sending yourself a gigabyte of:

#include <stdio.h>

int main(void)
{
        int i;

        for (i = 0; i < 0x10000000; i++) {
                fwrite(&i, 4, 1, stdout);
        }
}

If there's some sort of partial DMA transfer going on, this should
make it evident.

-- 
Mathematics is the supreme nostalgia of our time.
