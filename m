Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264991AbUJMIut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264991AbUJMIut (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 04:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265900AbUJMIut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 04:50:49 -0400
Received: from canuck.infradead.org ([205.233.218.70]:61970 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S264991AbUJMIur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 04:50:47 -0400
Subject: Re: Using ilookup?
From: David Woodhouse <dwmw2@infradead.org>
To: manningc2@actrix.gen.nz
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041013013930.9BB6649E9@blood.actrix.co.nz>
References: <20041013013930.9BB6649E9@blood.actrix.co.nz>
Content-Type: text/plain
Date: Wed, 13 Oct 2004 09:50:23 +0100
Message-Id: <1097657423.5178.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 (2.0.1-4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-13 at 14:42 +1300, Charles Manning wrote:
> YAFFS allocates its own "objectId"s which are used as inode numbers for most 
> purposes. When objects get deleted (== unlinked), the object numbers get 
> recycles.  Sometimes though the Linux cache has an inode after the object has 
> been deleted. 

Stop there... _why_ is the inode still in the icache after the object
has been deleted? It sounds like this is your real problem. Once the
last link to it goes, and the last file handle to it is closed, it
should be gone immediately. 

It sounds like you're doing too much in your unlink method. The object
isn't necessarily dead at the time you unlink it -- it could still be
open. You just decrement its nlink and wait for the VFS to tell you it's
done with it.

> 1)  Somehow plug myself into the inode iput() chain so that I know when an 
> inode is removed from the cache. I can then make sure that I don't free up 
> the inode number for reuse until the inode is not in the cache. Any hints on 
> how to do that?

->clear_inode() or ->delete_inode() as Andreas said.

> 2) When creating inode numbers, I could test for if there is a corresponding 
> inode in the cache first and just not recycle that number if there is. To do 
> this is ilookup the correct/safe thing to do?

It's safe but it doesn't sound correct. It sounds like a workaround for
the real problem.

> 2') A further issue here is that ilookup is not available in some older 2.4.x 
> versions. Is it Ok to just patch the ilookup code in, say, 2.4.27 back into 
> earlier versions (say 2.4.18 which seems a popular vintage for embedded stuff 
> for some reason or other).

No. If these people want new file systems and new features in code code,
why on earth are they still using 2.4.18? They should be on 2.6, or at
_least_ current 2.4 kernels. I could sort of understand if they've had a
lot of testing in the two and a half years since 2.4.18 was released and
they don't want to change _anything_.... but that obviously isn't the
case if they're adding new stuff like this.

-- 
dwmw2

