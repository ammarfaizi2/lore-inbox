Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751564AbVJSHYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbVJSHYH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 03:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbVJSHYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 03:24:07 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:55002 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751564AbVJSHYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 03:24:06 -0400
Date: Wed, 19 Oct 2005 09:23:45 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Badari Pulavarty <pbadari@gmail.com>
cc: 7eggert@gmx.de, Guido Fiala <gfiala@s.netic.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: large files unnecessary trashing filesystem cache?
In-Reply-To: <1129676753.23632.90.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0510190902210.2281@be1.lrz>
References: <4Z5WG-1iM-19@gated-at.bofh.it> <4Z6zs-27l-39@gated-at.bofh.it>
  <E1ERzTq-0001IA-Ba@be1.lrz> <1129676753.23632.90.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2005, Badari Pulavarty wrote:

> On Tue, 2005-10-18 at 23:58 +0200, Bodo Eggert wrote:
> > Badari Pulavarty <pbadari@gmail.com> wrote:
> > > On Tue, 2005-10-18 at 22:01 +0200, Guido Fiala wrote:
> > 
> > [large files trash cache]
> > 
> > > Is there a reason why those applications couldn't use O_DIRECT ?
> > 
> > The cache trashing will affect all programs handling large files:
> > 
> > mkisofs * > iso
> > dd < /dev/hdx42 | gzip > imagefile
> > perl -pe's/filenamea/filenameb/' < iso | cdrecord - # <- never tried
> > 
> 
> Are these examples which demonstrate the thrashing problem.

You can alyo cat a big file into /dev/null. I made those examples in order 
to demonstrate the problem with using O_DIRECT.

OTOH, I don't realtime stuff on my computer, so I'm not really affected, 
but I'll try to show it anyway.

> > Changing a few programs will only partly cover the problems.
> > 
> > I guess the solution would be using random cache eviction rather than
> > a FIFO. I never took a look the cache mechanism, so I may very well be
> > wrong here.
> 
> Read-only pages should be re-cycled really easily & quickly. I can't
> belive read-only pages are causing you all the trouble.

Just a q&d test:

$ time ls -l $DIR > /dev/null
real    0m0.442s
user    0m0.008s
sys     0m0.024s

$ time ls -l $DIR > /dev/null
real    0m0.077s
user    0m0.008s
sys     0m0.008s

cat $BIGFILES_1.5GB > /Dev/null

$ time ls -l $DIR > /dev/null
real    0m0.270s
user    0m0.008s
sys     0m0.008s

$ time ls -l $DIR > /dev/null
real    0m0.078s
user    0m0.004s
sys     0m0.004s



BTW:
I suggested the random eviction because it will evict pages from large 
files more likely than pages from small files, but I now think it will 
cause the evicted pages to be non-continuous, too, and thereby cause 
rereading them to be slower. I don't know which effect would be worse.

-- 
Is reading in the bathroom considered Multitasking? 
