Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272793AbRIPUa4>; Sun, 16 Sep 2001 16:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272794AbRIPUaq>; Sun, 16 Sep 2001 16:30:46 -0400
Received: from hermes.domdv.de ([193.102.202.1]:31506 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S272793AbRIPUaf>;
	Sun, 16 Sep 2001 16:30:35 -0400
Message-ID: <XFMail.20010916222959.ast@domdv.de>
X-Mailer: XFMail 1.4.6-3 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <9o2vct$889$1@penguin.transmeta.com>
Date: Sun, 16 Sep 2001 22:29:59 +0200 (CEST)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: <torvalds@transmeta.com (Linus Torvalds)>
Subject: Re: broken VM in 2.4.10-pre9
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The fact that the "use-once" logic didn't kick in is the problem. It's
> hard to tell _why_ it didn't kick in, possibly because the MP3 player
> read small chunks of the pages (touching them multiple times). 
> 
Then you should have an eye on mmap(). aide uses it. And it causes a real
problem. The basic logic is here:

open(file,O_RDONLY);
mmap(whole-file,PROT_READ,MAP_SHARED);
<do md5sum of mapped file>
munmap();
close();

No matter how you call the thing above (not my code, anyway): I strongly feel
that the use once logic isn't a great idea. What if lots of pages get accessed
twice? Where to set the limit?
How about adding a swapout cost factor? This would prevent swapping until
pressure is really high without any fixed limits. Calculate clean page reuse in
microseconds whereas swapout followed by swapin is going to be milliseconds.
That's a factor of at least 1000 which needs to be applied in page selection.


Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
