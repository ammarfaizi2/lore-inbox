Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWHPRKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWHPRKl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 13:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWHPRKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 13:10:41 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:35550 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S932115AbWHPRKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 13:10:40 -0400
Subject: [patch 0/5] -fstack-protector feature for the kernel (try 2)
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Aug 2006 18:48:22 +0200
Message-Id: <1155746902.3023.63.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the gcc -fstack-protector feature to
the kernel. While gcc 4.1 supports this feature for userspace, the patches to support
it for the kernel only got added to the gcc tree on 27/7/2006 (eg for 4.2);
it is expected that several distributors will backport this patch to their 4.1
gcc versions. (For those who want to know more, see gcc PR 28281)

-fstack-protector is a security feature in gcc that causes "selected" functions
to store a special "canary" value at the start of the function, just below
the return address. At the end of the function, just before using this
return address with the "ret" instruction, this canary value is compared to
the reference value again. If the value of the stack canary has changed, it is a sign
that there has been some stack corruption (most likely due to a buffer overflow) that
has compromised the integrity of the return address.

Standard, the "selected" functions are those that actually have stack
buffers of at least 8 bytes, this selection is done to limit the overhead to
only those functions with the highest risk potential. There is an override to enable this
for all functions.

On first sight this would not be needed for the kernel, because the kernel
is "perfect" and "has no buffer overflows on the stack". I thought that too
for a long time, but the last year has shown a few cases where that would
have been overly naive.

This feature has some performance overhead (but it's not that incredibly expensive
either) so it should be a configuration option for those who want this extra security.

I've included fixes for the comments from the last review on lkml, and especially the Makefile
side is now changed to automatically detect if the used gcc has the fix for PR 28281.

