Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315410AbSEQDoJ>; Thu, 16 May 2002 23:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315411AbSEQDoI>; Thu, 16 May 2002 23:44:08 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:55198 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S315410AbSEQDoH>; Thu, 16 May 2002 23:44:07 -0400
Date: Thu, 16 May 2002 23:43:57 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: joergprante@gmx.de, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.19pre8][RFC] remove-NFS-close-to-open from VFS (was Re: [PATCHSET] 2.4.19-pre8-jp12)
Message-ID: <20020517034357.GA18449@ravel.coda.cs.cmu.edu>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>, joergprante@gmx.de,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200205162142.AWF00051@netmail.netcologne.de> <E178TUb-0005Bh-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2002 at 11:13:01PM +0100, Alan Cox wrote:
> > Is it possible to leave the VFS layer untouched? Or restrict the dentry 
> > revalidation to NFS and let other remote file systems coexist, i.e. without 
> > revalidation calls? 
> 
> Really the other file systems want fixing - that revalidation is a real bug
> fix and the situation could occur for other network file systems too

And I thought I broke something with my latest changes in Coda. This
'bugfix' is hitting us hard. In some cases we hand down quite volatile
objects, files that are involved in a conflict, fake expanded directory
trees during the repair/examination of such conflicts.

These object are passed down with a 'no-cache' flag, which uses
dentry_revalidate to skip the cached lookup from the dcache but forces
all lookups to be passed through to the Coda filesystem. This bugfix
causes breakage, instead of forcing a new filesystem lookup, the VFS
simply returns ESTALE.

AFAIK, before the fix, failing dentry revalidate meant 'the lookup path
in the dcache is probably invalid, please double check with the
filesystem'. And now it means, 'the lookup path is invalid, return failure'.

Jan

