Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759931AbWLDJhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759931AbWLDJhR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 04:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759932AbWLDJhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 04:37:16 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:41157 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1759931AbWLDJhP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 04:37:15 -0500
Message-ID: <365225031.05635@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Mon, 4 Dec 2006 17:37:18 +0800
From: Fengguang Wu <fengguang.wu@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: drop_pagecache: Possible circular locking dependency
Message-ID: <20061204093718.GA7243@mail.ustc.edu.cn>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <365219737.01594@ustc.edu.cn> <20061204003217.c0f05e00.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061204003217.c0f05e00.akpm@osdl.org>
X-GPG-Fingerprint: 53D2 DDCE AB5C 8DC6 188B  1CB1 F766 DA34 8D8B 1C6D
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 12:32:17AM -0800, Andrew Morton wrote:
> On Mon, 4 Dec 2006 16:09:02 +0800
> Fengguang Wu <fengguang.wu@gmail.com> wrote:
> 
> > Got the following message when doing some benchmarks.
> > I guess we should not hold inode_lock on calling invalidate_inode_pages().
> > Any ideas?
> > 
> > Fengguang Wu
> > 
> > =======================================================
> > [ INFO: possible circular locking dependency detected ]
> > 2.6.19-rc6-mm2 #3
> > -------------------------------------------------------
> > rabench.sh/7467 is trying to acquire lock:
> >  (&journal->j_list_lock){--..}, at: [<ffffffff8113bdbc>] journal_try_to_free_buffers+0xdc/0x1c0
> > 
> > but task is already holding lock:
> >  (inode_lock){--..}, at: [<ffffffff810fe857>] drop_pagecache+0x67/0x120
> > 
> > which lock already depends on the new lock.
> > 
> 
> drat, I was afraid someone would notice.
> 
> It's Hard To Fix.  Removing /proc/sys/vm/drop_pagecache would in fact be 
> my preferred fix.

Or fix drop_pagecache_sb():
        Repeat until all possible pages freed:
                grab and save some inodes to a buffer
                zip their pages outside of inode_lock

Takes much more code though.

I'd like to move this sysctl interface to the upcoming /proc/filecache. 
Being a module, it helps reduce the kernel size :)

Fengguang Wu
