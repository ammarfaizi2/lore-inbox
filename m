Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbVJKAae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbVJKAae (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 20:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbVJKAad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 20:30:33 -0400
Received: from tux06.ltc.ic.unicamp.br ([143.106.24.50]:51365 "EHLO
	tux06.ltc.ic.unicamp.br") by vger.kernel.org with ESMTP
	id S1751316AbVJKAac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 20:30:32 -0400
Date: Mon, 10 Oct 2005 21:40:43 -0300
From: Glauber de Oliveira Costa <glommer@br.ibm.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: glommer@br.ibm.com, Andrew Morton <akpm@osdl.org>,
       Anton Altaparmakov <aia21@cam.ac.uk>, mikulas@artax.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
       linux-ntfs-dev@lists.sourceforge.net, aia21@cantab.net,
       hch@infradead.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] Use of getblk differs between locations
Message-ID: <20051011004043.GD13399@br.ibm.com>
References: <20051010204517.GA30867@br.ibm.com> <Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk> <20051010214605.GA11427@br.ibm.com> <Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz> <20051010223636.GB11427@br.ibm.com> <Pine.LNX.4.64.0510102328110.6247@hermes-1.csi.cam.ac.uk> <20051010163648.3e305b63.akpm@osdl.org> <20051011000734.GC13399@br.ibm.com> <20051011000503.GR7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051011000503.GR7992@ftp.linux.org.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some of them can be wrong, but they're not that random.

Let's discuss each one of them

In the changes made in affs.h, I returned NULL because it seemed to be
the some-went-wrong behaviour on these functions

affs_getzeroblk, for example, tests some conditions. The buffer being
NULL is just another test.

In the code you commented, I thought that we get the same case testing
from or to conditions, and thus, it would be correct to threat them in
the same way.

in minix, ext2 and ext3 code, I changed the alloc_branch functions ,
because they already has some code that is prepared to recover from a
failed allocation

In the others, I've just put my hands on code that would execute inside
conditionals using struct members, to prevent dereferencing a NULL pointer. 
As I said, there is a lot of code that has the problem, and are untouched. 
If I was being at random, they would also figuring out here.

I don't think it will necessarily hide the problems (although it can be doing 
it in some of them), because __getblk_slow will produce a lot of noise
in the case something did get wrong.


glauber

On Tue, Oct 11, 2005 at 01:05:03AM +0100, Al Viro wrote:
> On Mon, Oct 10, 2005 at 09:07:34PM -0300, Glauber de Oliveira Costa wrote:
> >  	if (!bh)
> >  		return -EIO;
> >  	new = sb_getblk(sb, to);
> > +	if (!new)
> > +		return -EIO;
> 
> You've just introduced a leak here, obviously.
> 
> Please, read the code before "fixing" that stuff; slapping returns at random
> and hoping that it will help is not a good way to deal with that - the only
> thing you achieve is hiding the problem.
> 
> The same goes for the rest of patch - in each case it's not obvious that your
> changes are correct.
> 

-- 
=====================================
Glauber de Oliveira Costa
IBM Linux Technology Center - Brazil
glommer@br.ibm.com
=====================================
