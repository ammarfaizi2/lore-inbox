Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWGFSZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWGFSZT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 14:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWGFSZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 14:25:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58558 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750719AbWGFSZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 14:25:18 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060706103134.197c8679.akpm@osdl.org> 
References: <20060706103134.197c8679.akpm@osdl.org>  <20060706124716.7098.5752.stgit@warthog.cambridge.redhat.com> <20060706124721.7098.50514.stgit@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       bernds_cb1@t-online.de, sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] FRV: Fix FRV arch compile errors [try #3] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 06 Jul 2006 19:25:03 +0100
Message-ID: <25855.1152210303@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> - The __init-style tags on declarations don't actually do anything and
>   the compiler doesn't check for consistency with the definition - it's
>   best to just omit it from the declaration.

Well, you're wrong.  They *do* do something.  They stop the compiler using the
register-relative addressing reserved for small data.  If this isn't in there,
then the linker will spit out a relocation error.

On fixed-size instruction architectures, it takes several instructions to
dereference an absolute address, so you try and squeeze all your small data
into a section of its own, plonk a register in the middle of it, and use
indirect-addressing relative to that register.  This saves you two or more
instructions and a register on each normal global variable access.

For instance, on FRV, it may change:

	sethi.p		%hi(nr_kernel_pages),gr4
	setlo		%lo(nr_kernel_pages),gr4
	ld		@(gr4,gr0),gr5

Into:

	ld		@(gr16,%gprel(nr_kernel_pages)),gr5

Small data is 1-byte, 2-byte, 4-byte or 8-byte values that aren't arrays or
const.

Setting a section marker on the variable *declaration* disables the
gp-relative addressing and forces the longer absolute addressing.

> - Setting nr_kernel_pages to be unloaded at free_initmem() seems risky.

That's nothing to do with my patch.

> - nr_kernel_pages is actually __meminitdata.

Okay, I'll fix my patch to be that instead.

David
