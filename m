Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264746AbUFGPHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264746AbUFGPHK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 11:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264756AbUFGPHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 11:07:10 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:6097 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S264746AbUFGPHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 11:07:03 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Zoltan.Menyhart@bull.net
Subject: Re: Who owns those locks ?
Date: Mon, 7 Jun 2004 09:06:54 -0600
User-Agent: KMail/1.6.2
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <40A1F4BE.4A298352@nospam.org> <200406031139.58964.bjorn.helgaas@hp.com> <40C42E4B.15F1E605@nospam.org>
In-Reply-To: <40C42E4B.15F1E605@nospam.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406070906.54132.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 June 2004 2:58 am, Zoltan Menyhart wrote:
> Bjorn Helgaas wrote:
> > On Wednesday 12 May 2004 3:56 am, Zoltan Menyhart wrote:
> > > Got a dead lock ?
> > > No idea how you got there ?
> > >
> > > Why don't you put the ID of the owner of the lock in the lock word ?
> > > Here is your patch for IA-64.
> > > Doesn't cost any additional instruction, you can have it in your
> > > "production" kernel, too.
> > 
> > Whatever happened with this patch?  I really like the idea, but
> > it seems like it died on the vine.  Maybe it's time to clean it
> > up, pull all the bits together, and repost it.
> 
> Here you are.
> (I'm still playing with 2.6.5)

There are a couple issues I was thinking of when
I wrote "clean it up, pull the bits together...":

	1) Tony Luck's question about what happens when
	   "shr.u r30 = r13, 12" yields zero in the 32-bit
	   lock value.  I'm not the 2.6 maintainer, but I'd
	   sure like to see some solution for this.  It would
	   be a nightmare to debug a system where one random
	   task didn't release locks correctly.  Since other
	   arches use a trick like this, I'm hoping they've
	   figured out something we can copy (I haven't looked).

	2) A nit-pick, but for things like this:

-                     "  mov r30 = 1;;\n\t"
+                     /* "  mov r30 = 1;;\n\t" */
+                     "  shr.u r30 = r13, 12;;\n\t"     /* Current task pointer */

	   just remove the old line, don't comment it out.

Thanks for collecting the bits.  I looked at it last week, got
derailed trying to figure out how the pre-gcc-3.3 lock contention
code worked (a comment there would have been helpful), and got
distracted.
