Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUBTPm7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 10:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbUBTPlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 10:41:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:43654 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261295AbUBTPgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 10:36:20 -0500
Date: Fri, 20 Feb 2004 07:41:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Tridge <tridge@samba.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Jamie Lokier <jamie@shareable.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: explicit dcache <-> user-space cache coherency, sys_mark_dir_clean(),
 O_CLEAN
In-Reply-To: <20040220120417.GA4010@elte.hu>
Message-ID: <Pine.LNX.4.58.0402200733350.1107@ppc970.osdl.org>
References: <16435.60448.70856.791580@samba.org> <Pine.LNX.4.58.0402181457470.18038@home.osdl.org>
 <16435.61622.732939.135127@samba.org> <Pine.LNX.4.58.0402181511420.18038@home.osdl.org>
 <20040219081027.GB4113@mail.shareable.org> <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org>
 <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org>
 <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org>
 <20040220120417.GA4010@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Feb 2004, Ingo Molnar wrote:
> 
> One 'user-space cache is valid/clean' bit should be enough - where all
> non-Samba accesses clear the 'valid bit', and Samba sets the bit
> manually.

Yes, that, together with O_CLEAN would work.

The problem is that you'd still need other system calls: it's not like 
open(O_CREAT) is the only way to create a file. So you'd have to add 
versions of "link()" etc, which means that O_CLEAN is really pretty 
pointless, and you might as well just do it in a new system call.

Your version is also not multi-threaded: you can never allow more than one 
thread doing the "sys_mark_dir_clean()". That was the reason for having 
two bits: so that anybody can do a lookup in parallell, and only the 
"filldir" part needs to be serialized.

So I do believe you'd want two bits anyway.

		Linus
