Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbUBRDXO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 22:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUBRDXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 22:23:14 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56336 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261957AbUBRDXJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 22:23:09 -0500
Message-ID: <4032DA76.8070505@zytor.com>
Date: Tue, 17 Feb 2004 19:22:30 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <200402161948.i1GJmJi5000299@81-2-122-30.bradfords.org.uk> <Pine.LNX.4.58.0402161141140.30742@home.osdl.org> <20040216202142.GA5834@outpost.ds9a.nl> <c0ukd2$3uk$1@terminus.zytor.com> <Pine.LNX.4.58.0402171910550.2686@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402171910550.2686@home.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id i1I3MUf12577
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 18 Feb 2004, H. Peter Anvin wrote:
> 
>>Those of us who have been involved with the issue have fought
>>*extremely* hard against DWIM decoders which try to decode the latter
>>sequences into ".." -- it's incorrect, and a security hazard.  The
>>only acceptable decodings is to throw an error, or use an out-of-band
>>encoding mechanism to denote "bad bytecode."
> 
> Somebody correctly pointed out that you do not need any out-of-band 
> encoding mechanism - the very fact that it's an invalid sequence is in 
> itself a perfectly fine flag. No out-of-band signalling required.
> 
> The only thing you should make sure of is to not try to normalize it (that 
> would hide the error). Just keep carrying the bad sequence along, and 
> everybody is happy. Including the filesystem functions that get the "bad" 
> name and match it exactly to what it should be matched against.
> 

Well, the reason you'd want an out-of-band mechanism is to be able to
display it as some kind of escapes.  Consider a UTF-8 decoder which uses
values in the 0x800000xx range to encode "bogus bytes"; that way it
wouldn't alias to anything else, but the bogus sequence "C0 AE" could be
represented as 0x800000C0 0x800000AE and displayed to the user as
\xC0\xAE\xC0\xAE ... which is different from \u00C0\u00AE ("À®", C3 80
C2 AE).  This would make it possible to figure out in, for example, an
ls listing, what those broken filenames are actually composed of.

There are some advantages to being able to represent all possible byte
sequences and present them to the user, even if they're bogus.

	-hpa

