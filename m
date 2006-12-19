Return-Path: <linux-kernel-owner+w=401wt.eu-S932965AbWLSV4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932965AbWLSV4e (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 16:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932969AbWLSV4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 16:56:34 -0500
Received: from mail.enyo.de ([212.9.189.167]:2681 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932965AbWLSV4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 16:56:33 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
References: <1166314399.7018.6.camel@localhost>
	<20061217040620.91dac272.akpm@osdl.org>
	<1166362772.8593.2.camel@localhost>
	<20061217154026.219b294f.akpm@osdl.org>
	<1166460945.10372.84.camel@twins>
	<Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
	<45876C65.7010301@yahoo.com.au>
	<Pine.LNX.4.64.0612182230301.3479@woody.osdl.org>
	<45878BE8.8010700@yahoo.com.au>
	<Pine.LNX.4.64.0612182313550.3479@woody.osdl.org>
	<Pine.LNX.4.64.0612182342030.3479@woody.osdl.org>
	<4587B762.2030603@yahoo.com.au>
	<Pine.LNX.4.64.0612190847270.3479@woody.osdl.org>
	<Pine.LNX.4.64.0612190929240.3483@woody.osdl.org>
Date: Tue, 19 Dec 2006 22:56:16 +0100
In-Reply-To: <Pine.LNX.4.64.0612190929240.3483@woody.osdl.org> (Linus
	Torvalds's message of "Tue, 19 Dec 2006 09:43:00 -0800 (PST)")
Message-ID: <87d56fv9bz.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds:

> Now, this should _matter_ only for user processes that are buggy,
> and that have written to the page _before_ extending it with
> ftruncate().

APT seems to properly extend the file before mapping it, by writing a
zero byte at the desired position (creating a hole).

24986 open("/var/cache/apt/pkgcache.bin", O_RDWR|O_CREAT|O_TRUNC, 0666) = 6

24986 lseek(6, 12582911, SEEK_SET)      = 12582911
24986 write(6, "\0", 1)                 = 1

24986 mmap(NULL, 12582912, PROT_READ|PROT_WRITE, MAP_SHARED, 6, 0) = 0x2b6578636000

24986 msync(0x2b6578636000, 7464112, MS_SYNC) = 0
24986 msync(0x2b6578636000, 8656, MS_SYNC) = 0
24986 munmap(0x2b6578636000, 12582912)  = 0
24986 ftruncate(6, 7464112)             = 0
24986 fstat(6, {st_mode=S_IFREG|0644, st_size=7464112, ...}) = 0
24986 mmap(NULL, 7464112, PROT_READ, MAP_SHARED, 6, 0) = 0x2b6578636000

APT's code is pretty convoluted, though, and there might be some code
path in it that gets it wrong. 8-P
