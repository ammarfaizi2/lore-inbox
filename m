Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbUBRK3X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 05:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbUBRK3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 05:29:23 -0500
Received: from [212.28.208.94] ([212.28.208.94]:31503 "HELO dewire.com")
	by vger.kernel.org with SMTP id S263823AbUBRK3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 05:29:21 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
Date: Wed, 18 Feb 2004 11:29:11 +0100
User-Agent: KMail/1.6.1
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <Pine.LNX.4.58.0402171927520.2686@home.osdl.org> <4032F861.3080304@zytor.com>
In-Reply-To: <4032F861.3080304@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402181129.11064.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 February 2004 06.30, H. Peter Anvin wrote:
> Linus Torvalds wrote:
> > On Tue, 17 Feb 2004, H. Peter Anvin wrote:
> >>Well, the reason you'd want an out-of-band mechanism is to be able to
> >>display it as some kind of escapes. 
> > I'd suggest just doing that when you convert the utf-8 format to printable 
> > format _anyway_.  At that point you just make the "printable" 
> > representation be the binary escape sequence (which you have to have for 
> > other non-printable utf-8 characters anyway).
> What does "printable" mean in this context?  Typically you have to 
> convert it to UCS-4 first, so you can index into your font tables, then 
> you have to create the right composition, apply the bidirectional text 
> algorithm, and so forth.

> Rendering general Unicode text is complex enough that you really want it 
> layered.  What I described what the first step of that -- mostly trying 
> to show that "throwing an error" doesn't necessarily mean "produce no 
> output."  What you shouldn't do, though, is alias it with legitimate input.

I think you can use libicu here. Conversion to UCS-4 doesn't for determining
character type doesn't mean you will every have actual strings of UCS-4. It could 
be character by character just for looking it up, so you can have the out-of-band
error flags internally.

> > And if you do things right (ie you allow user input in that same escaped 
> > output format), you can allow users to re-create the exact "broken utf-8". 
> > Which is actually important just so that the user can fix it up (ie 
> > imagine the user noticing that the filename is broken, and now needs to do 
> > a "mv broken-name fixed-name" - the user needs some way to re-create the 
> > brokenness).
> 
> Indeed.  The C language has gone with \x77 for bytes and \u7777 or 
> \U77777777 for Unicode characters (4 vs 8 hex digits respectively); I 
> think this is a good UI for shells to follow.  The \x representation 
> then doesn't stand for characters but for bytes.  It may be desirable to 
> disallow encoding of *valid* UTF-8 characters this way, though.

Agree. \u80808080 I would assume represents a valid character, while \x80\x80\x80\x80
does not. A problem with invalid sequences I just noted is that they break some of 
the nice properties of UTF-8, that people will assume apply, i.e. that you can parse it 
backwards. With UTF-8 (i.e. well-formed utf-8) you can point at a byte and figure "this is 
not the first byte", lets skip backwards to find the start. If invalid sequences can ever occur
you must read from the start of the string.

-- robin
