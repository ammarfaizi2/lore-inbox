Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbWFUHcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbWFUHcE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 03:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWFUHcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 03:32:04 -0400
Received: from canuck.infradead.org ([205.233.218.70]:690 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S932468AbWFUHcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 03:32:02 -0400
Subject: Re: cfq-iosched.c:RB_CLEAR_COLOR
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Jens Axboe <axboe@suse.de>
In-Reply-To: <Pine.LNX.4.64.0606201800320.5498@g5.osdl.org>
References: <20060620.173434.35660839.davem@davemloft.net>
	 <Pine.LNX.4.64.0606201800320.5498@g5.osdl.org>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 08:31:53 +0100
Message-Id: <1150875113.3176.506.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-20 at 18:03 -0700, Linus Torvalds wrote:
> > There were two explicit calls in the cfq-iosched.c file
> > to RB_CLEAR_COLOR, only the one in cfq_del_crq_rb() got
> > removed so the build fails.

Apologies for that; the new one got added only last week, and escaped my
attention.

> I think the right fix is to just remove the RB_CLEAR_COLOR() call, since 
> the memset will set everything to 0/NULL, which should be the correct 
> initialization these days anyway.
> 
> David (the other one - dwmw2), pls confirm? 

Yes, that looks correct. Other code, including the AS scheduler, was
(ab)using the colour field by storing a 'RB_NONE' value which was
neither red nor black to mark an 'off-tree' node, then checking for it
with ON_RB(). I changed that scheme -- we now set the node's parent
pointer to point to itself to mark an off-tree node. 

However, the cfq scheduler looks like it only inherited the macros from
AS, and was never actually _checking_ if a given node was on-tree or
not. So just dropping the magic initialisation stuff there is fine.

-- 
dwmw2

