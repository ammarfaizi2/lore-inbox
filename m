Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbUBRC7R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 21:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbUBRC7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 21:59:17 -0500
Received: from hera.kernel.org ([63.209.29.2]:23432 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262360AbUBRC7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 21:59:11 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
Date: Wed, 18 Feb 2004 02:58:42 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c0ukd2$3uk$1@terminus.zytor.com>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <200402161948.i1GJmJi5000299@81-2-122-30.bradfords.org.uk> <Pine.LNX.4.58.0402161141140.30742@home.osdl.org> <20040216202142.GA5834@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1077073122 4053 63.209.29.3 (18 Feb 2004 02:58:42 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 18 Feb 2004 02:58:42 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040216202142.GA5834@outpost.ds9a.nl>
By author:    bert hubert <ahu@ds9a.nl>
In newsgroup: linux.dev.kernel
> 
> Additional good news is that following octets in a utf-8 character sequence
> always have the highest order bit set, precluding / or \x0 from appearing,
> confusing the kernel.
> 

Indeed.  The original name for the encoding was, in fact, "FSS-UTF",
for "filesystem safe Unicode transformation format."  

> The remaining zit is that all these represent '..':
> 2E 2E
> C0 AE C0 AE
> E0 80 AE E0 80 AE 
> F0 80 80 AE F0 80 80 AE 
> F8 80 80 80 AE F8 80 80 80 AE 
> FC 80 80 80 80 AE FC 80 80 80 80 AE

No, they don't.

The first represent "..", the remaining two are illegal encodings and
do not decode to anything.

Those of us who have been involved with the issue have fought
*extremely* hard against DWIM decoders which try to decode the latter
sequences into ".." -- it's incorrect, and a security hazard.  The
only acceptable decodings is to throw an error, or use an out-of-band
encoding mechanism to denote "bad bytecode."

> This in itself is not a problem, the kernel will only recognize 2E 2E as the
> real .., but it does show that 'document.doc' might be encoded in a myriad
> ways.

No, it doesn't.
 
> So some guidance about using only the simplest possible encoding might be
> sensible, if we don't want the kernel to know about utf-8.

UTF-8 requires the use of the shortest possible encoding.  An
application which doesn't obey that and tries to be "smart" is a
security hazard.

It is a bit unfortunate that the encoding don't exclude these by
design as opposed by error checking; it makes it a little too easy for
clueless programmers to skip :(

	-hpa
