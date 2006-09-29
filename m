Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965033AbWI2AH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbWI2AH7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 20:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbWI2AH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 20:07:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58776 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965033AbWI2AH6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 20:07:58 -0400
Date: Thu, 28 Sep 2006 17:07:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>,
       Hugh Dickens <hugh@veritas.com>,
       Michael Ellerman <michael@ellerman.id.au>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH RFC 1/4] Generic BUG handling.
Message-Id: <20060928170723.c2580a34.akpm@osdl.org>
In-Reply-To: <451C5E3B.60204@goop.org>
References: <20060928225444.439520197@goop.org>
	<20060928225452.229936605@goop.org>
	<20060928163256.aa53b8d7.akpm@osdl.org>
	<451C5E3B.60204@goop.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 16:43:55 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Andrew Morton wrote:
> > What is the locking for these lists?  I don't see much in here.  It has
> > implications for code which wants to do BUG while holding that lock..
> >   
> 
> There's no locking.  This is a direct copy of the original powerpc 
> code.  I assume, but haven't checked, that there's a lock to serialize 
> module loading/unloading, so the insertion/deletion is all properly 
> synchronized. 
> 
> The only other user is traversal when actually handling a bug; if you're 
> very unlucky this could happen while you're actually loading/unloading 
> and you would see the list in an inconsistent state.  I guess we could 
> put a lock there, and trylock it on traversal; at least that would stop 
> a concurrent modload/unload from getting in there while we're trying to 
> walk the list.

The module_bug_cleanup() code is in a stop_machine_run() callback, so
that's all OK.

I _think_ your module_bug_finalize()'s list_add() could race with another
CPU's BUG_ON().  We can live with that.

