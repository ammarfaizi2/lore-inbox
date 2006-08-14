Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751774AbWHNMHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbWHNMHb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 08:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbWHNMHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 08:07:31 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:58857 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S1751774AbWHNMHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 08:07:30 -0400
Date: Mon, 14 Aug 2006 06:07:29 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: parisc-linux@parisc-linux.org, linux-kernel@vger.kernel.org
Subject: stack-protect in conflict with CROSS_COMPILE
Message-ID: <20060814120729.GB4340@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Sam,

We've stumbled on a problem with -fno-stack-protector and CROSS_COMPILE:

CFLAGS          := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
                   -fno-strict-aliasing -fno-common
# Force gcc to behave correct even for buggy distributions
CFLAGS          += $(call cc-option, -fno-stack-protector)

round about line 310 of Makefile will cause CC to be called before we
get a chance to set CROSS_COMPILE in arch/parisc/Makefile.  For people
who are compiling 64-bit parisc kernels, this means the wrong gcc gets
called, and sometimes the compiler versions are out of sync.

We will have similar problems with:

CFLAGS          += -fno-omit-frame-pointer $(call cc-option,-fno-optimize-sibling-calls,)

Should we include the arch Makefile earlier in the proceedings?
