Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263610AbTF3DCF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 23:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265626AbTF3DCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 23:02:05 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:20229 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263610AbTF3DCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 23:02:03 -0400
Subject: Re: [PATCH] fix for kallsyms module symbol resolution problem
From: James Bottomley <James.Bottomley@steeleye.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030630025802.F2F432C232@lists.samba.org>
References: <20030630025802.F2F432C232@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 29 Jun 2003 22:13:08 -0500
Message-Id: <1056942790.10904.324.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-06-29 at 21:06, Rusty Russell wrote:
> Please test, because that's only one problem.
> 
> The other is that the module_text_address() returns true if the value
> is within the module, *not* just if it's within a function.  So you
> can get some noise there, too, on archs which don't do real
> backtracing.

Well, the fix is pretty cast iron in that it will print out the closest
symbol with a non null name (which has got to be better than printing an
empty string).  The routine length may still be wrong since the next
closest symbol may still be null.

However, that does bring me to another issue we have on parisc (the
problem traceback was actually from x86): our tool chain, for reasons
best known to itself, inserts local symbol names into the symbol table
section.  On parisc, we get rid of them again by throwing them out of
the symbol table section in module_finalize (which we shouldn't do,
since the pointers are constant).

Perhaps there should be a per-arch hook for purging the symbol tables of
irrelevant symbols before we do kallsyms lookups in it?

James


