Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264635AbUFLEgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264635AbUFLEgA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 00:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264638AbUFLEgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 00:36:00 -0400
Received: from waste.org ([209.173.204.2]:20710 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264635AbUFLEf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 00:35:58 -0400
Date: Fri, 11 Jun 2004 23:35:47 -0500
From: Matt Mackall <mpm@selenic.com>
To: Rik van Riel <riel@redhat.com>
Cc: stian@nixia.no, linux-kernel@vger.kernel.org
Subject: Re: timer + fpu stuff locks my console race
Message-ID: <20040612043546.GF5414@waste.org>
References: <1701.83.109.60.63.1086814977.squirrel@nepa.nlc.no> <Pine.LNX.4.44.0406112252160.13607-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0406112252160.13607-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2004 at 10:53:48PM -0400, Rik van Riel wrote:
> On Wed, 9 Jun 2004 stian@nixia.no wrote:
> 
> > I'm doing some code tests when I came across problems with my program
> > locking my console (even X if I'm using a xterm).
> 
> Reproduced here, on my test system running a 2.6 kernel.
> I did get a kernel backtrace over serial console, though ;)

I stuck some strategic printks in the kernel. The example code's bogus
asm is generating an FPU fault in frstor in its signal handler, that's
bumping us into math_error -> force_sig_info ->
specific_send_sig_info. Then we hit:

        if (LEGACY_QUEUE(&t->pending, sig))

which decides we don't need to send the signal after all and we bail
all the way back out and recurse.

-- 
Mathematics is the supreme nostalgia of our time.
