Return-Path: <linux-kernel-owner+w=401wt.eu-S1752724AbWLTATN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbWLTATN (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 19:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752903AbWLTATN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 19:19:13 -0500
Received: from smtp.osdl.org ([65.172.181.25]:48308 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752420AbWLTATM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 19:19:12 -0500
Date: Tue, 19 Dec 2006 16:18:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Nick Piggin <nickpiggin@yahoo.com.au>, andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
Message-Id: <20061219161834.5466ecf6.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612191553140.6766@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost>
	<20061217040620.91dac272.akpm@osdl.org>
	<1166362772.8593.2.camel@localhost>
	<20061217154026.219b294f.akpm@osdl.org>
	<1166460945.10372.84.camel@twins>
	<Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
	<45876C65.7010301@yahoo.com.au>
	<Pine.LNX.4.64.0612182230301.3479@woody.osdl.org>
	<45878BE8.8010700@yahoo.com.au>
	<Pine.LNX.4.64.0612182313550.3479@woody.osdl.org>
	<Pine.LNX.4.64.0612182342030.3479@woody.osdl.org>
	<4587B762.2030603@yahoo.com.au>
	<Pine.LNX.4.64.0612190847270.3479@woody.osdl.org>
	<Pine.LNX.4.64.0612190929240.3483@woody.osdl.org>
	<Pine.LNX.4.64.0612191037291.3483@woody.osdl.org>
	<1166563828.10372.162.camel@twins>
	<Pine.LNX.4.64.0612191451410.3483@woody.osdl.org>
	<20061219145818.5b36381c.akpm@osdl.org>
	<1166569582.10372.165.camel@twins>
	<Pine.LNX.4.64.0612191553140.6766@woody.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Dec 2006 16:03:49 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> On Wed, 20 Dec 2006, Peter Zijlstra wrote:
> 
> > On Tue, 2006-12-19 at 14:58 -0800, Andrew Morton wrote:
> > 
> > > Well... we'd need to see (corruption && this-not-triggering) to be sure.
> > > 
> > > Peter, have you been able to trigger the corruption?
> > 
> > Yes; however the mail I send describing that seems to be lost in space.
> 
> Btw, can somebody actually explain the mess that is ext3 "dirtying".
> 
> Ext3 does NOT use __set_page_dirty_buffers. It does
> 
> 	static int ext3_journalled_set_page_dirty(struct page *page)
> 	{
> 	        SetPageChecked(page);
> 	        return __set_page_dirty_nobuffers(page);
> 	}
> 
> and uses that "Checked" bit as a "whole page is dirty" bit (which it tests 
> in "writepage()".

This is purely for data=journal, which is rarely used.

In journalled-data mode, write(), write-fault, etc are not allowed to dirty
the pages and buffers, because the data has to be written to the journal
first.  After the data has been written to the journal we only then mark
buffers (and hence pages) dirty as far as the VFS is concerned.  For
checkpointing the data back to its real place on the disk.


For MAP_SHARED pages ext3 cheats madly and doesn't journal the data at all.
In all journalling modes, MAP_SHARED data follows the regular ext2-style
handling.  Which is a bit of a wart.

