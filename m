Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265515AbTGBW7u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 18:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265454AbTGBW6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 18:58:04 -0400
Received: from holomorphy.com ([66.224.33.161]:22970 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265529AbTGBW5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 18:57:12 -0400
Date: Wed, 2 Jul 2003 16:11:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030702231122.GI26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>, Mel Gorman <mel@csn.ul.ie>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53.0307010238210.22576@skynet> <20030701022516.GL3040@dualathlon.random> <Pine.LNX.4.53.0307021641560.11264@skynet> <20030702171159.GG23578@dualathlon.random> <461030000.1057165809@flay> <20030702174700.GJ23578@dualathlon.random> <20030702214032.GH20413@holomorphy.com> <20030702220246.GS23578@dualathlon.random> <20030702221551.GH26348@holomorphy.com> <20030702222641.GU23578@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030702222641.GU23578@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 03:15:51PM -0700, William Lee Irwin III wrote:
>> What complexity? Just unmap it if you can't allocate a pte_chain and
>> park it on the LRU.

On Thu, Jul 03, 2003 at 12:26:41AM +0200, Andrea Arcangeli wrote:
> the complexity in munlock to rebuild what you destroyed in mlock, that's
> linear at best (and for anonymous mappings there's no objrmap, plus
> objrmap isn't even linear but quadratic in its scan [hence the problem
> with it], though in practice it would be normally faster than the linear
> of the page scanning ;)

Computational complexity; okay.

It's not quadratic; at each munlock(), it's not necessary to do
anything more than:

for each page this mlock()'er (not _all_ mlock()'ers) maps of this thing
	grab some pagewise lock
	if pte_chain allocation succeeded
		add pte_chain
	else
		/* you'll need to put anon pages in swapcache in mlock() */
		unmap the page
	decrement lockcount
	if lockcount vanished
	park it on the LRU
	drop the pagewise lock

Individual mappers whose mappings are not mlock()'d add pte_chains when
faulting the things in just like before.


-- wli
