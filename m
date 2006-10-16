Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161184AbWJPAbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161184AbWJPAbr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 20:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbWJPAbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 20:31:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49347 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030300AbWJPAbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 20:31:46 -0400
Date: Sun, 15 Oct 2006 17:31:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Brownell <david-b@pacbell.net>
Cc: alan@lxorguk.ukuu.org.uk, matthew@wil.cx, val_henson@linux.intel.com,
       netdev@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH 1/2] [PCI] Check that MWI bit really did get set
Message-Id: <20061015173134.8a72bc2c.akpm@osdl.org>
In-Reply-To: <200610151716.36337.david-b@pacbell.net>
References: <1160161519800-git-send-email-matthew@wil.cx>
	<200610151545.59477.david-b@pacbell.net>
	<20061015161834.f96a0761.akpm@osdl.org>
	<200610151716.36337.david-b@pacbell.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Oct 2006 17:16:35 -0700
David Brownell <david-b@pacbell.net> wrote:

> 
> > You, the driver author _do not know_ what pci_set_mwi() does at present, on
> > all platforms, nor do you know what it does in the future. 
> 
> I know that it enables MWI accesses ... or fails.  Beyond that, there
> should be no reason to care.  If the hardware can use a lower-overhead
> type of PCI bus cycle, I want it to do so.  If not, no sweat.
> 

There are two reasons why it can fail:

1: The bus doesn't support MWI.  Here, the caller doesn't care.

2: The bus _does_ support MWI, but the attempt to enable it failed. 
   Here we very much do care, because we're losing performance.

> 
> > This is not a terribly important issue, and it is far from the worst case
> > of missed error-checking which we have in there. 
> 
> The reason I think it's important enough to continue this discussion is
> that as it currently stands, it's a good example of a **BAD** interface
> design ... since it's pointlessly marked as must_check.  (See appended
> patch to fix that issue.)

It's important to continue this discussion so that certain principles can
be set and agreed to.  Because we have a *lot* of unchecked errors in
there.  We would benefit from setting guidelines establishing

- Which sorts of errors should be handled in callers

- Which sorts of errors should be handled (ie: just reported) in callees

- Which sorts of errors should be handled in neither callers nor callees
  (are there any of these?)

- Whether is it ever legitimate for a caller to not check the return code
  from a callee which can return -EFOO.  (I suspect not - it probably
  indicates a misdesign in the callee, as in this case).



