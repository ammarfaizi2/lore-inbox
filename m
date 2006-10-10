Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030601AbWJJXN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030601AbWJJXN4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 19:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030631AbWJJXN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 19:13:56 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:26855 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030601AbWJJXNz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 19:13:55 -0400
Subject: Re: [ckrm-tech] [PATCH 0/5] Allow more than PAGESIZE data read in
	configfs
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Paul Menage <menage@google.com>, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20061010215808.GK7911@ca-server1.us.oracle.com>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
	 <20061010203511.GF7911@ca-server1.us.oracle.com>
	 <6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com>
	 <20061010215808.GK7911@ca-server1.us.oracle.com>
Content-Type: text/plain
Organization: IBM
Date: Tue, 10 Oct 2006 16:13:52 -0700
Message-Id: <1160522032.6389.26.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 14:58 -0700, Joel Becker wrote:
> On Tue, Oct 10, 2006 at 02:31:43PM -0700, Paul Menage wrote:
> > >        NAK.  This forces a complex and inappropriate interface on the
> > >majority of users, and doesn't honor configfs' simplicity-first design.
> > 
> > How is the seq_file interface complex and inappropriate? For the
> > configfs clients it's basically a drop-in replacement for sprintf(),
> > as Chandra's patches show.
> 
> 	Well, they now have to learn seq_file.  They now get to assume

If they are simple users, they don't have to "learn" seq_file semantics,
they would just replace their sprintf's with seq_printfs (as my changes
in OCFS2 show).

IMO, seq_file interface is not that complex to learn either.

> that "spewing large amounts of junk" is the default rather than "single
> attribute", which is correct.  None of it is relevant for the majority
> of correct users.

"char *" can also be used to spew out large amount of data (ok, maybe up
to PAGESIZE in configfs's case :). My point is that changing char * to
seq_file doesn't necessarily "introduce" the issue (of spewing large
amounts of data).
 
> 	It exposes the "I'm a file" knowledge down to the client module.
> The entire point of configfs is that the "filesystem bits" are
> independant of the "client bits".  To the client, it's an item
> hierarchy.  To the user, the interface happens to be a filesystem.

This issue is moot, unless you have intentions of changing the user
interface of configfs to be anything other than a file system, isn't
it ?

> 	Technically, the seq_printf() as a drop-in replacement seems to
> be functional.  I'm worried about lifetiming, but I think it's OK (what
> do I mean?  If I open the file, I'd better not be able to remove the
> client module until everything is torn down.  If I close the file, it
> had better get all torn down before module_put() so that when
> ->release() returns, te module can safely be removed.  I *think* this
> change satisfies these worries, but it's something that absolutely has
> to be done right.  Yes, I'm very paranoid about this).
> 	My bigger worry is that we haven't solved the write side.  How
> does one *set* a large attribute?  It had better not be multiple
> attributes.  I know that your module doesn't set it, but hey, we don't
> codify that requirement.  Perhaps a patch where we say "if you are a
> large display attribute, we'll use seq_file and error on write because
> it isn't allowed" but that leaves the old buffer-based approach for
> normal-sized read-write attributes.

Now we are in need of *large* reads. We can add this feature and let it
evolve to the next level later when somebody needs to *set* a large
attribute.

Also, these changes do not result in any change in the user level
interface. So, we can afford this interface changes to change again
later.

> Joel
> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


