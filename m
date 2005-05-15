Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVEOXbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVEOXbM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 19:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVEOXbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 19:31:12 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:13188 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S261161AbVEOXbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 19:31:09 -0400
Message-Id: <4287DBC3.7000907@khandalf.com>
Date: Mon, 16 May 2005 01:31:15 +0200
From: "Brian O'Mahoney" <omb@khandalf.com>
Reply-To: omb@bluewin.ch
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Cache based insecurity/CPU cache/Disk Cache Tradeoffs
References: <Pine.LNX.4.58.0505151657230.19181@artax.karlin.mff.cuni.cz>
    <200505151121.36243.gene.heskett@verizon.net>
    <20050515152956.GA25143@havoc.gtf.org>
    <20050516.012740.93615022.okuyamak@dd.iij4u.or.jp>
    <42877C1B.2030008@pobox.com>	<m1zmuw8m3a.fsf@muc.de>
    <20050515134405.6c099391.akpm@osdl.org>
In-Reply-To: <20050515134405.6c099391.akpm@osdl.org>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Md5-Body: a26ab712b140e4ed87ad5f457f2be4b5
X-Transmit-Date: Monday, 16 May 2005 1:31:46 +0200
X-Message-Uid: 0000b49cec9d7e3700000002000000004287dbe20001fcba00000001000a30aa
X-Sender-Postmaster: Postmaster@80-218-57-125.dclient.hispeed.ch.
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-07.tornado.cablecom.ch 32701; Body=2
	Fuz1=2 Fuz2=2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In principle, it is correct that CPU caches should _not_ permit, or
facilitate data leakage attacks and disk caches should _not_ prevent
applications from ensuring that data is really transferred to non-
volatile storage.

But turning Hypertheading, multiple ALUs, or disk cacheing off in the
OS is not a solution, it is a cop-out, and as other posters have pointed
out, simply invites other more serious failure modes; thus the BSD
knee jerk reactions are simply wrong, and in fact counter productive.
The name of the game is a correct, not a fast fix. Don't make things
worse.

So what really does need doing

(a) a power-is-failing hook which does a dirty-writback and flush
cache to disk; this is the best you can do, and it is very very cheap
to provide DC power hold up for 10(s)->100(s) seconds, by which time
the crap disks will do an autonomous writback anyway (1-10 F +5v,+12b
~ 12 USD say), or, on servers use a UPS with, say 30m hold up.

Well designed servers, or SAN disks have this built in.

(b) CPU registers, and caches, are inherently insecure, and most
hardware designers still do not have a good enough background to
understand what the OS really needs to do this right in hardware:

so secure apps need a way to tell the OS to do an _expensive_
context switch in which it is guarenteed to flush all all leaky-context,
and since this is architecture-model-sub_architecture- ...
mask step dependant it can only be done in the OS, but user-land
needs a way to tell the OS to be paranoic, after the context
save and before scheduling another real context (excluding
the idle-loop), this is an API extension, ulimit ?.

This will let user-land, not include atchitecture dependant code,
and most context switches to be no more expensive than they are
now.

Almost no applications need paranoic context flushes, can't know
how to do it themselves, so this has to go in the model dependant
OS code, with a user mode API to turn it on per-thead.



-- 
mit freundlichen Grüßen, Brian.

Dr. Brian O'Mahoney
Mobile +41 (0)79 334 8035 Email: omb@bluewin.ch
Bleicherstrasse 25, CH-8953 Dietikon, Switzerland
PGP Key fingerprint = 33 41 A2 DE 35 7C CE 5D  F5 14 39 C9 6D 38 56 D5
