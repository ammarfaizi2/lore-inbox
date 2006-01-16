Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbWAPQAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbWAPQAS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 11:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWAPQAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 11:00:17 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:35083 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751063AbWAPQAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 11:00:16 -0500
Message-ID: <43CBC27B.6010405@shadowen.org>
Date: Mon, 16 Jan 2006 15:57:47 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
CC: Andrew Morton <akpm@osdl.org>, lhms-devel@lists.sourceforge.net,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] BUG: gfp_zone() not mapping zone modifiers correctly
 and bad ordering of fallback lists
References: <20060113155026.GA4811@skynet.ie> <20060113121652.114941a3.akpm@osdl.org>
In-Reply-To: <20060113121652.114941a3.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think we need to be careful here. Although the __GFP_* modifiers
appear to be directly convertable to ZONE_* types they don't have
to be.  We could potentially have a new modifier which would want
to specify a different list combination whilst not representing
a zone in and of itself; for example __GFP_NODEONLY which might
request use of zones which are NUMA node local.  The bits covered
by GFP_ZONEMASK represent 'zone modifier space', those GFP bits
which affect where we should try and get memory. The zonelists
correspond to the lists of zones to try for that combination in
'zone modifier space' not for a specific zone.

Right now there is a near one-to-one correspondance between
the __GFP_x and ZONE_x identifiers. As more zones are added we
exponentially waste more and more 'zone modifier space' to allow
for the possible combinations. If we are willing and able to assert
that only one memory zone related modifier is valid at once we
could deliberatly squash the zone number into the bottom corner of
'zone modifier space' whilst still maintaining that space and the
ability to allow new bits to be combined with it.

My feeling is that as long as we don't lose the ability to have
modifiers combine and select separate lists and there is currently
no use of combined zone modifiers then we can make this optimisation.

Comments?

-apw

