Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265910AbUHFDS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265910AbUHFDS5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 23:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266085AbUHFDS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 23:18:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40382 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265910AbUHFDS4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 23:18:56 -0400
Date: Fri, 6 Aug 2004 04:18:16 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Gene Heskett <gene.heskett@verizon.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Possible dcache BUG
Message-ID: <20040806031815.GL12308@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408042216.12215.gene.heskett@verizon.net> <Pine.LNX.4.58.0408042359460.24588@ppc970.osdl.org> <Pine.LNX.4.58.0408051923420.24588@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408051923420.24588@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 07:50:28PM -0700, Linus Torvalds wrote:
 
> So as far as I can tell, shrink_dcache_anon() will have _removed_ a dentry 
> from the unused_list, but still left the dentry with wild pointers 
> pointing to other dentries. Next time around we do a dput() on such a 
> dentry, we'll be screwed, because we'll try to remove it again. Boom.

It doesn't even take a dput().  Look: we do list_del(), then notice that
sucker still has positive refcount and leave it alone.  Now think what
happens on the next pass.  That's right, we hit that dentry *again*.
And see that list_empty() is false.  And do list_del() one more time.

However, what used to be e.g. next dentry might very well be freed by
now.  *BOOM*.
