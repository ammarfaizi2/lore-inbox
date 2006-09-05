Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161004AbWIETlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161004AbWIETlY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 15:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030239AbWIETlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 15:41:24 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:6867 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030237AbWIETlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 15:41:23 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: VFAT truncate performance
To: Mattias =?ISO-8859-1?Q?R=F6nnblom?= <hofors@lysator.liu.se>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Tue, 05 Sep 2006 21:38:45 +0200
References: <6RJD8-3i0-1@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1GKglG-00018u-4l@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mattias Rönnblom <hofors@lysator.liu.se> wrote:

> extending files by ftruncate(2) runs very slow on VFAT file
> systems. On my USB harddisk w/ VFAT, it takes 14 seconds to extend an
> empty file to 1 GB. On a memory stick, it takes well over 4 minutes.
> 
> My question is: is this problem on the conceptual level (ie there is
> no way of extending files on FAT that doesn't involve many disk
> operations) or is the current Linux fs driver suboptimal in this
> respect?

Linux needs to zero files it truncate-extends because of security guarantees.

You could temporarily ignore the truncate after create if it's followed by
writing the file (defer untill first non-write), but it will be a BAD hack.
It might work.

Default: open(O_WRITE|O_CREAT|O_TRUNC) -> do it, goto State 1
         otherwise -> just do it

State 1: ftruncate -> remember offset instead of executing ftruncate,
                      goto State 2
         otherwise -> goto Default

State 2: write     -> do it, stay in State 2 unless file size increases
                      beyond fake size, then goto Default
         stat      -> return fake size
         otherwise -> really do ftruncate, goto Default

It might cause some operations to be slow you'd expect to be fast, and
I'm not sure how it has to deal with concurrent access.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
