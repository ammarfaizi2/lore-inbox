Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265286AbUGGSXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265286AbUGGSXQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 14:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265282AbUGGSXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 14:23:15 -0400
Received: from palrel10.hp.com ([156.153.255.245]:59373 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S265281AbUGGSWo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 14:22:44 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16620.16241.664033.493568@napali.hpl.hp.com>
Date: Wed, 7 Jul 2004 11:22:41 -0700
To: roland@redhat.com
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: ptrace "fix" breaks ia64
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland,

Peter Chubb found that your recent ptrace change to fix x86-64 access
to the 32-bit vsyscall page breaks ia64.  See:

 http://www.gelato.unsw.edu.au/linux-ia64/0407/10253.html

The problem is due to the fact that the gate page on ia64 really does
live in the kernel-mapped segment (as your original code correctly
assumed).  Furthermore, pgd_offset_k() is different from pgd_offset()
since the kernel-mapped segment gets a full page-directory inside a
single region, whereas user-space regions get only 1/8th of a
page-directory, so it's not OK to use pgd_offset() in lieu of
pgd_offset().

As Peter's mail suggests, we _could_ make pgd_offset() smarter by
automatically redirecting it to pgd_offset_k() when necessary, but
that's not a nice solution because it would slow down everything else
and would kind of defeat the purpose of having separate pgd_offset_k()
and pgd_offset() macros.

I suppose we could have a new macro pgd_offset_gate() or something
along those lines to accommodate platform-differences in where the
gage page lives.

	--david
