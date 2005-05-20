Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVETP1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVETP1B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 11:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVETP1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 11:27:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19944 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261470AbVETP0A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 11:26:00 -0400
Date: Fri, 20 May 2005 11:25:50 -0400
From: Neil Horman <nhorman@redhat.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Neil Horman <nhorman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] vfs: increase scope of critical locked path in fget_light to avoid race
Message-ID: <20050520152550.GF19229@hmsendeavour.rdu.redhat.com>
References: <20050520132325.GE19229@hmsendeavour.rdu.redhat.com> <20050520133337.GP29811@parcelfarce.linux.theplanet.co.uk> <20050520134046.GQ29811@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050520134046.GQ29811@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2005 at 02:40:46PM +0100, Al Viro wrote:
> On Fri, May 20, 2005 at 02:33:38PM +0100, Al Viro wrote:
> > Er...  If we get 1, we *KNOW* who holds the only reference - that's us.
> > And to change refcount of files_struct you need to hold a reference to
>                        or contents

I don't have the complete race scenario, just a stack that suggests that
files->fd was corrupted.  This problem isn't recreatable at will (yet), so this
is really based on a thought experiment more than anything else.  The conditions
that I was envisioning was a multithreaded application in which two threads
modified  the same file descriptor at the same time.  Its my understanding, from
the way I read the code that the ref count on a file_struct will still be one
for a multithreaded application, and as such it would be possible, using the
fget_light routine for one thread to be be preforming an operation on an
descriptor in the fd array, while another thread preformed another operation on
it (say close).  The result potentially would be (if the two operations were on
the same fd index), that the routine operating in fget_light would retrieve a
corrupted fd value from the files->fd array, since it was being modified at the
same time by another execution context. Given the above, I suppose it might be
more appropriate to increment the reference count on thread creation as well as
process creation,  but I wasn't certain of the potential side effects of doing
so.  Also, every other location in the vfs that calls fcheck_files to retrieve a
value out of file_structs fd array, do so under the protection of the
file_structs file_lock, so this really seemed like a candidate for race badness
to me.

Regards
Neil

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/
