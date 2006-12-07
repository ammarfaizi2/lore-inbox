Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031179AbWLGFmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031179AbWLGFmy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 00:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031182AbWLGFmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 00:42:54 -0500
Received: from smtp.ocgnet.org ([64.20.243.3]:49870 "EHLO smtp.ocgnet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031179AbWLGFmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 00:42:53 -0500
Date: Thu, 7 Dec 2006 14:42:28 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: workqueue cmpxchg() breakage
Message-ID: <20061207054228.GA14119@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The changes in 365970a1ea76d81cb1ad2f652acb605f06dae256 result in
cmpxchg() being invoked with bogus sizes with gcc-4.1 on SH, particularly
when kernel/workqueue.c:set_wq_data() is left inlined:

  LD      .tmp_vmlinux1
kernel/built-in.o: In function `__cmpxchg':
/home/pmundt/devel/git/sh-2.6/include/asm/system.h:247: undefined reference to `__cmpxchg_called_with_bad_pointer'
make: *** [.tmp_vmlinux1] Error 1

If I add a handler for the u64 case, that catches one of the inlined
references, but the other call site generates something completely different,
it's garbage in either case.

Taking set_wq_data() out of line fixes this, but is likely not the right fix.
