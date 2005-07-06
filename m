Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbVGFAua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbVGFAua (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 20:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbVGFAua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 20:50:30 -0400
Received: from smtp103.rog.mail.re2.yahoo.com ([206.190.36.81]:59057 "HELO
	smtp103.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262029AbVGFAuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 20:50:15 -0400
In-Reply-To: <42CB1E12.2090005@namesys.com>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: reiser4 plugins
Cc: hubert@uhoreg.ca, ross.biro@gmail.com, vonbrand@inf.utfsm.cl,
       mrmacman_g4@mac.com, Valdis.Kletnieks@vt.edu, ltd@cisco.com,
       gmaxwell@gmail.com, jgarzik@pobox.com, hch@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
       zam@namesys.com, vs@thebsh.namesys.com, ndiller@namesys.com,
       ninja@slaphack.com
X-Mailer: BeMail - Mail Daemon Replacement 2.3.1 Final
From: "Alexander G. M. Smith" <agmsmith@rogers.com>
Date: Tue, 05 Jul 2005 20:50:08 -0400 EDT
Message-Id: <1740726161-BeMail@cr593174-a>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote on Tue, 05 Jul 2005 16:56:02 -0700:
> One can have hardlinks to a directory without cycles provided that one
> does not have hardlinks from the children of that directory to any file
> not a child of that directory.  (Mountpoints currently implement that
> restriction.)
> 
> Question: can one implement that lesser restriction above with elegant
> code?  Is the greater restriction below easier to code?  (If no to the
> first and yes to the second is correct, then I can accept the greater
> restriction described below.)
> 
> One can have hardlinks to directories
> without cycles provided that one does not allow any child of the
> directory to have a hardlink.

That sounds equivalent to no hard links (other than the usual parent
directory one).  If there's any directory with two links to it, then
there will be a cycle somewhere!

The tradeoff is the size of the cycle to the amount of memory and other
resources needed to clean up the cycle when rename/deletion changes the
directory graph structure.  Various artificial limits can be imposed,
such as not creating a link which would result in a cycle of more than
some number of files/directories (adjust so that cleanup fits in the
memory size of the machine).  Or just fail the cleanup if it is too
complex (user deletes individual items in the cycle then tries again).

Perhaps you are thinking about the speed improvement for cycle checking
that comes from marking directories as known to not contain children
pointing outside the graph rooted at that directory.  Then that directory
can be treated as an ordinary directory in the cycle cleanup procedure,
avoiding the need to trace down the links to all its descendants.  That's
essentially what your mount point restriction is.

- Alex
