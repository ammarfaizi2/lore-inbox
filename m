Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264913AbUD2XrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264913AbUD2XrM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 19:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265027AbUD2XrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 19:47:12 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43789 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264913AbUD2XrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 19:47:09 -0400
Date: Fri, 30 Apr 2004 00:47:05 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: marcus hall <marcus@tuells.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mmap returns incorrect data
Message-ID: <20040430004705.A13006@flint.arm.linux.org.uk>
Mail-Followup-To: marcus hall <marcus@tuells.org>,
	linux-kernel@vger.kernel.org
References: <20040429231243.GA8216@bastille.tuells.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040429231243.GA8216@bastille.tuells.org>; from marcus@tuells.org on Thu, Apr 29, 2004 at 05:12:43PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 05:12:43PM -0600, marcus hall wrote:
> I have a system based on 2.5.59 kernel for arm.  This system was previously
> running OK with all filesystems on a stratoflash chip, but I have recently
> moved the filesystems to a compact flash chip.  Some filesystems are
> cramfs, and some have changed from jffs2 to ext3 along with the move.

You _really_ don't want to use ext3 on CF unless you want to wear the
flash quickly.  Just because a filesystem has journaling does _not_
mean that its suitable for flash (in fact, it may be far worse for
flash than its non-journaled counterpart, as in this case.)

> I am having trouble with ldconfig not recognizing some files as being valid.
> The files that cause the problem are files that are on an ext3 filesystem
> on the CF.  Other files on a cramfs filesystem seem to work reliably.
> It seems that ldconfig mmap()s the file into its address space, and what
> it sees doesn't match what is in the file.  If I pre-read the file before
> running ldconfig, so that the contents get into the cache, then ldconfig
> proceeds normally.

This is an IDE driver bug - it performs PIO but does not ensure that the
individual pages are properly flushed to RAM before telling the kernel
that the IO is complete.  (If someone wants to disagree, look at how
rd.c does flush_dcache_page, and see previous discussions on lkml
concerning this.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
