Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262622AbVGMHUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbVGMHUr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 03:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbVGMHUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 03:20:47 -0400
Received: from siaag2ag.compuserve.com ([149.174.40.140]:30138 "EHLO
	siaag2ag.compuserve.com") by vger.kernel.org with ESMTP
	id S262622AbVGMHUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 03:20:45 -0400
Date: Wed, 13 Jul 2005 03:15:58 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.13-rc2-mm2
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-ID: <200507130319_MC3-1-A450-9F8A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2005 at 17:41:00 -0700, Andrew Morton wrote:

> The patch was empty.  That happens sometimes.  I like to be able to apply
> empty patches, but yes, perhaps that should require -f.
> 
> Either drop the patch of use -f.

  OK, those are easy enough to comment out but I thought the broken-out
tar file would be cleaner than that.


> I fix up the offset errors relatively infrequently, and they all come back
> very soon.

  While playing with this cleanup script:

===============================================================================
#! /bin/bash

[ -f patches/series ]  ||  exit 1

echo $"Refreshing all patches in series..."
quilt pop -a

cat patches/series  |  while read line
do
	lineno=$[$lineno+1]
	if [ -z "$line" ]  ||  [ "${line:0:1}" == "#" ]
	then
		continue
	fi

	echo ""
	quilt push $line

	if [ $? != 0 ]
	then
		echo -e $"\nError at line" $lineno ":"
		echo -e $line
		break
	fi

	quilt refresh
done
===============================================================================


  I found:

===============================================================================
Usage: quilt push [-afqv] [--leave-rejects] [num|patch]

Error at line 308 :
x86-x86_64-deferred-handling-of-writes-to-proc-irq-xx-smp_affinitypatch-added-to-mm-tree.patch # ak no likee
===============================================================================


  I thought this was an isolated instance and fixed it up, then found:

        x86-64-ptrace-ia32-bp-fix.patch # ak no likee

This breaks quilt when you try to push patches by name:

===============================================================================
[me@d2 2.6.13-rc2-mm2]$ quilt push x86-64-ptrace-ia32-bp-fix.patch
Applying x86-64-ptrace-ia32-bp-fix.patch
patch: no: extra operand
patch: Try `/usr/bin/patch --help' for more information.
Patch x86-64-ptrace-ia32-bp-fix.patch does not apply (enforce with -f)
===============================================================================


  Quilt docs only say lines beginning with "#" are ignored, nothing about it
after a patch name.

  ...and BTW why does every line in the series file have a trailing space?

__
Chuck
