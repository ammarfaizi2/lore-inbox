Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVDQTTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVDQTTz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 15:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVDQTTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 15:19:55 -0400
Received: from hermes.domdv.de ([193.102.202.1]:33809 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261417AbVDQTTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 15:19:51 -0400
Message-ID: <4262B6D4.30805@domdv.de>
Date: Sun, 17 Apr 2005 21:19:48 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       jmorris@redhat.com, davem@davemloft.net, ak@suse.de
Subject: [RFC][PATCH 0/4] AES assembler implementation for x86_64
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implementation:
===============
The encrypt/decrypt code is based on an x86 implementation I did a while
ago which I never published. This unpublished implementation does
include an assembler based key schedule and precomputed tables. For
simplicity and best acceptance, however, I took Gladman's in-kernel code
for table generation and key schedule for the kernel port of my
assembler code and modified this code to produce the key schedule as
required by my assembler implementation. File locations and Kconfig are
kept similar to the i586 AES assembler implementation.
It may seem a little bit strange to use 32 bit I/O and registers in the
assembler implementation but this gives the best code size. My
implementation takes one instruction more per round compared to
Gladman's x86 assembler but it doesn't require any stack for local
variables or saved registers and it is less serialized than Gladman's
x86 code.
Note that all comparisons to Gladman's code were done after my code was
implemented. I did only use FIPS PUB 197 for the implementation so my
implementation is independent work.
If anybody has a better assembler solution for x86_64 I'll be pleased to
have my code replaced with the better solution.

Testing:
========
The implementation passes the in-kernel crypto testing module and I'm
running it without any problems on my laptop where it is mainly used for
dm-crypt.

Microbenchmark:
===============
The microbenchmark was done in userspace with similar compile flags as
used during kernel compile.
Encrypt/decrypt is about 35% faster than the generic C implementation.
As the generic C as well as my assembler implementation are both table
driven I don't really expect that there is much room for further
improvements though I'll be glad to be corrected here.
The key schedule is about 5% slower than the generic C implementation.
This is due to the fact that some more work has to be done in the key
schedule routine to fit the schedule to the assembler implementation.

Code Size:
==========
Encrypt and decrypt are together about 2.1 Kbytes smaller than the
generic C implementation which is important with regard to L1 cache
usage. The key schedule routine is about 100 bytes larger than the
generic C implementation.

Data Size:
==========
There's no difference in data size requirements between the assembler
implementation and the generic C implementation.

License:
========
Gladmans's code is dual BSD/GPL whereas my assembler code is GPLv2 only
(I'm  not going to change the license for my code). So I had to change
the module license for the x86_64 aes module from 'Dual BSD/GPL' to
'GPL' to reflect the most restrictive license within the module.

PS: It can happen that it may take a while until I can reply as I'm
regularly offline due to my current daytime job requirements.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de

