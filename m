Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262722AbVAFE7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262722AbVAFE7Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 23:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbVAFE7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 23:59:24 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:19522
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262722AbVAFE7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 23:59:21 -0500
Date: Thu, 6 Jan 2005 05:59:32 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, riel@redhat.com,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
Message-ID: <20050106045932.GN4597@dualathlon.random>
References: <20050105134457.03aca488.akpm@osdl.org> <20050105203217.GB17265@logos.cnet> <41DC7D86.8050609@yahoo.com.au> <Pine.LNX.4.61.0501052025450.11550@chimarrao.boston.redhat.com> <20050105173624.5c3189b9.akpm@osdl.org> <Pine.LNX.4.61.0501052240250.11550@chimarrao.boston.redhat.com> <41DCB577.9000205@yahoo.com.au> <20050105202611.65eb82cf.akpm@osdl.org> <41DCC014.80007@yahoo.com.au> <20050105204706.0781d672.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050105204706.0781d672.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 08:47:06PM -0800, Andrew Morton wrote:
> That's my point.  blk_congestion_wait() will always sleep, regardless of

Since I've no pending bugs at all with the mainline codebase I rate this
just a theoretical issue: but even sleeping for a fixed amount of time
is unreliable there, for example if the storage is very slow. That's why
using io_schedule_timeout for that isn't going to be a fix.

The fix is very simple and it is to call wait_on_page_writeback on one
of the pages under writeback. That guarantees some _writeback_ progress
has been made before retrying. That way some random direct-io or a too
short timeout, can't cause malfunction.
