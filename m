Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbUBTRDw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 12:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbUBTRDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 12:03:52 -0500
Received: from mx2.elte.hu ([157.181.151.9]:39833 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261345AbUBTRDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 12:03:43 -0500
Date: Fri, 20 Feb 2004 18:04:38 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tridge <tridge@samba.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Jamie Lokier <jamie@shareable.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: explicit dcache <-> user-space cache coherency, sys_mark_dir_clean(), O_CLEAN
Message-ID: <20040220170438.GA19722@elte.hu>
References: <16435.61622.732939.135127@samba.org> <Pine.LNX.4.58.0402181511420.18038@home.osdl.org> <20040219081027.GB4113@mail.shareable.org> <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org> <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <20040220120417.GA4010@elte.hu> <Pine.LNX.4.58.0402200733350.1107@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402200733350.1107@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner-4.26.8-itk2 SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> Your version is also not multi-threaded: you can never allow more than
> one thread doing the "sys_mark_dir_clean()". That was the reason for
> having two bits: so that anybody can do a lookup in parallell, and
> only the "filldir" part needs to be serialized.
> 
> So I do believe you'd want two bits anyway.

hm, right. So for the lookup to be lockless, it would have to be managed
via a syscall variant similar in mechanism to the two-bit approach you 
suggested:

	ret = sys_manage_dir_cache(fd, op);

where the following cache states are defined:

	(invalid, refill_in_progress, valid)

the following type of cache ops are defined:

	(lookup, cache_filled)

the semantics of the sys_manage_dir_cache() syscall are the following:

- op is 'lookup': the syscall returns 'valid' if state is valid. If the 
  state is 'refill_in_progress' then lookup returns refill_in_progress. 
  If the state is 'invalid', then the state goes to 'refill_in_progress' 
  and 'invalid' is returned.

- op is 'cache_filled': the syscall moves the state to 'valid' if state
  is still 'refill_in_progress'. It goes to 'refill_in_progress' if the
  state was 'invalid'.

the kernel does the valid->invalid and refill_in_progress->invalid
transitions automatically, when relevant VFS events occur. All dentries
start out in state invalid.

there's another class of problems: is it an issue that directory renames
that move this directory (higher up in the directory hierarchy of this
directory) do not invalidate the cache? In that case there's no dnotify
event either.

	Ingo
