Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291291AbSCDEXD>; Sun, 3 Mar 2002 23:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291306AbSCDEWy>; Sun, 3 Mar 2002 23:22:54 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:24561
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S291291AbSCDEWm>; Sun, 3 Mar 2002 23:22:42 -0500
Date: Sun, 3 Mar 2002 18:17:14 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: James D Strandboge <jstrand1@rochester.rr.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ext3 and undeletion
Message-ID: <20020304021714.GB353@matchmail.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	James D Strandboge <jstrand1@rochester.rr.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1014848170.18953.57.camel@hedwig.strandboge.cxm> <E16gCdF-00069W-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16gCdF-00069W-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 10:33:05PM +0000, Alan Cox wrote:
> > /root/.bashrc /etc/fstab'), wouldn't 'cp' (or most any other app) first
> > unlink the first file (/etc/fstab), then create and write the new one?
> 
> Unlikely - It will truncate it and write over it. Try strace cp 8)

Doesn't truncate use the same inode after the trunc op?  If so, then using
another inode after the trunc op would break unix semantics.  In order to
work, you'd have to use a new inode (in .undelete, of course), copy, then do
the actual trunc call. 
This would make truncation expensive, whereas before it was pretty fast.
Modifying unlink will probably suffice.

Though, if truncate is modified for undelete, people could claim that our
solution is better than others and can save data in more cases.  Also, it
could be used as a rudamentary file versioning system. :)  This feature
should be optional, and enabled only at the sysadmin's discression.

Hmm, truncating a large file would basically copy it, and that is what
usually happens during a save operation.  So, this option needs some serious
thinking before proceeding.

Also, it would put more stress on the cleanup facilities of undeletion
because more data would pass through the undelete dir.  But, communication
(however you want do to do that, be it socket or etc...) between the
unlink/truncate calls and the cleanup system should make most possible races
small or non-existant.

I've probably left something out, so feel free to fill in the blanks.

Mike
