Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161341AbWJLAtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161341AbWJLAtp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 20:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161342AbWJLAtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 20:49:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38798 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161341AbWJLAto
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 20:49:44 -0400
Date: Thu, 12 Oct 2006 01:49:44 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Andreas Schwab <schwab@suse.de>
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] m68k: more workarounds for recent binutils idiocy
Message-ID: <20061012004944.GF29920@ftp.linux.org.uk>
References: <E1GXlNt-0004Xc-Fi@ZenIV.linux.org.uk> <jek636o62y.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jek636o62y.fsf@sykes.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 12:12:05AM +0200, Andreas Schwab wrote:
> Al Viro <viro@ftp.linux.org.uk> writes:
> 
> > cretinous thing doesn't believe that (%a0)+ is one macro argument and
> > splits it in two; worked around by quoting the argument...
> 
> What version are you using?  Works rather fine here with 2.17.

There are two problems; see below for the testcase covering both
.macro a x
	.byte 1
.endm
	a.x
	a %(a0)+

Old binutils (i.e. what Roman's code expects) treat the above as
	.byte 1
	.byte 1

That behaviour exists in 2.16.1 and earlier.  Everything starting at least
with 2.16.90.0.2 and up to current CVS generates
	Error: Unknown operator -- statement `a.x' ignored
for line 4.  That's the problem dealt with by the first patch (and yes,
current gas from CVS does blow on arch/m68k/math-emu/ as soon as you get
to getuser.l <something>).

_Another_ problem manifests as
	Error: too many positional arguments
in line 5.  That had been introduced later (in 2.16.91.0.3, if you look at
versions on kernel.org, or 2005-08-08 in mainline) and had been fixed since
then (2.16.91.0.7 or 2006-02-28 in CVS).  That's what the second patch
dealt with and yes, I agree that just slapping "don't use those versions
of binutils" in Documentation/Changes is a better variant.

The first problem still needs to be dealt with.
