Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbVBIMbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVBIMbk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 07:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbVBIMbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 07:31:40 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:331 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261813AbVBIMbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 07:31:39 -0500
Date: Wed, 9 Feb 2005 12:30:24 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Chris Wright <chrisw@osdl.org>
cc: "Mark F. Haigh" <Mark.Haigh@SpirentCom.COM>,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/fork.c: VM accounting bugfix (2.6.11-rc3-bk5)
In-Reply-To: <20050208230447.V24171@build.pdx.osdl.net>
Message-ID: <Pine.LNX.4.61.0502091223310.5842@goblin.wat.veritas.com>
References: <420988C1.5030408@spirentcom.com> 
    <20050208230447.V24171@build.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2005, Chris Wright wrote:
> * Mark F. Haigh (Mark.Haigh@SpirentCom.COM) wrote:
> > 
> > If security_vm_enough_memory() fails there, then we vm_unacct_memory()
> > that we never accounted (if security_vm_enough_memory() fails, no memory
> > is accounted).
> 
> You missed one subtle point.  That failure case actually unaccts 0 pages
> (note the use of charge).  Not the nicest, but I believe correct.

Not quite: Mark's patch is worse than unnecessary, it's wrong.

dup_mmap's charge starts out at 0 and gets added to each time around
the loop through vmas; if security_vm_enough_memory fails at any point
in that loop, we need to vm_unacct_memory the charge already accumulated.

Hugh
