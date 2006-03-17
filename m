Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWCQWL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWCQWL0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 17:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWCQWL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 17:11:26 -0500
Received: from thunk.org ([69.25.196.29]:34726 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932253AbWCQWLZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 17:11:25 -0500
Date: Fri, 17 Mar 2006 17:11:03 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Jamie Lokier <jamie@shareable.org>, Badari Pulavarty <pbadari@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, jack@suse.cz
Subject: Re: ext3_ordered_writepage() questions
Message-ID: <20060317221103.GA17337@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Jamie Lokier <jamie@shareable.org>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, jack@suse.cz
References: <1141777204.17095.33.camel@dyn9047017100.beaverton.ibm.com> <20060308124726.GC4128@lst.de> <4410551D.5000303@us.ibm.com> <20060309153550.379516e1.akpm@osdl.org> <4410CA25.2090400@us.ibm.com> <20060316180904.GA29275@thunk.org> <20060317153213.GA20161@mail.shareable.org> <1142632221.3641.33.camel@orbit.scot.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142632221.3641.33.camel@orbit.scot.redhat.com>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2006 at 04:50:21PM -0500, Stephen C. Tweedie wrote:
> 
> It's *only* for updating existing data blocks that there's any
> justification for writing mtime first.  That's the question here.
> 
> There's a significant cost in forcing the mtime to go first: it means
> that the VM cannot perform any data writeback for data written by a
> transaction until the transaction has first been committed.  That's the
> last thing you want to be happening under VM pressure, as you may not in
> fact be able to close the transaction without first allocating more
> memory.

Actually, we're not even able to force the mtime to happen first in
this case.  In ordered mode, we still force the data blocks *first*,
and only later do we force the mtime update out.  With Badari's
proposed change, we completely decouple when the data blocks get
written out with the mtime update; it could happen before, or after,
at the OS's convenience.  

If the application cares about the precise ordering of data blocks
being written out with respect to the mtime field, I'd respectfully
suggest that the application use data journalling mode --- and note
that most applications which update existing data blocks, especially
relational databases, either don't care about mtime, have their own
data recovering subsystems, or both.

					- Ted
