Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267808AbUIPAS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267808AbUIPAS3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 20:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267656AbUIPAP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 20:15:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12701 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267720AbUIPAKG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 20:10:06 -0400
Date: Thu, 16 Sep 2004 01:10:01 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Roland Dreier <roland@topspin.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Being more careful about iospace accesses..
Message-ID: <20040916001001.GN23987@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org> <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org> <52zn3rupw8.fsf@topspin.com> <Pine.LNX.4.58.0409151546400.2333@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409151546400.2333@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 04:26:12PM -0700, Linus Torvalds wrote:
 
>    other bitwise type. You'd get a warnign about incompatible types. Makes 
>    sense, no?
>  - you can only do operations that are safe within that byte order. For 
>    example, it is safe to do a bitwise "&" on two __le16 values. Clearly 
>    the result is meaningful.

BTW, so far the most frequent class of endianness bugs had been along the
lines of
	foo->le16_field = cpu_to_le32(12);
and vice versa.  On big-endian it's a guaranteed FUBAR - think carefully about
the value that will end up there.

> Oh, btw, right now you only get the warnings from sparse if you use
> "-Wbitwise" on the command line. Without that, sparse will ignore the
> bitwise attribute.

We probably want __attribute__((opaque)) in addition to bitwise - e.g. for
the handles of all sorts passed in network filesystem protocols.  I'll look
into that when we get the endianness warnings somewhat under control.

For now I'm going to #define __opaque __bitwise and use it for stuff like
	typedef __u32 __opaque cifs_fid;
etc.
