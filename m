Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264376AbUBRLdr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 06:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264372AbUBRLdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 06:33:47 -0500
Received: from mail.shareable.org ([81.29.64.88]:34949 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264376AbUBRLdp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 06:33:45 -0500
Date: Wed, 18 Feb 2004 11:33:38 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
Message-ID: <20040218113338.GH28599@mail.shareable.org>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <200402161948.i1GJmJi5000299@81-2-122-30.bradfords.org.uk> <Pine.LNX.4.58.0402161141140.30742@home.osdl.org> <20040216202142.GA5834@outpost.ds9a.nl> <c0ukd2$3uk$1@terminus.zytor.com> <Pine.LNX.4.58.0402171910550.2686@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402171910550.2686@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Somebody correctly pointed out that you do not need any out-of-band 
> encoding mechanism - the very fact that it's an invalid sequence is in 
> itself a perfectly fine flag. No out-of-band signalling required.

Technically this is almost(*) correct, however a _lot_ of code exists
which assumes logical properties of UTF-8.  (See, for example, the
"stty utf8" patch).

Perl, for example, allows you to pass around invalid sequences in
exactly the way you describe.  It works, right up until you do
something like length() or substr() or a regex match.  Then Perl
screws up the answer, because it sees something like 0xfd and just
assumes it can skip the next 5 bytes, without checking them.

hpa's suggestion that invalid bytes are treated as 0x800000xx works
very nicely, *iff* a program is absolutely consistent about its
treatment of bytes in that way.  When there's a mixture of code which
interprets malformed UTF-8 in different ways, then it's messy and
sometimes a security hazard.

-- Jamie

(*) - It's fine until you concatenate two malformed strings.  Then the
      out-of-band signal is lost if the combination is valid UTF-8.
