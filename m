Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262523AbTENQp7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 12:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbTENQp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 12:45:58 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:18844 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S262523AbTENQpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 12:45:53 -0400
Date: Wed, 14 May 2003 12:58:38 -0400
To: David Howells <dhowells@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
Subject: Re: [PATCH] PAG support, try #2
Message-ID: <20030514165838.GD20171@delft.aura.cs.cmu.edu>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
References: <24225.1052909011@warthog.warthog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24225.1052909011@warthog.warthog>
User-Agent: Mutt/1.5.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 11:43:31AM +0100, David Howells wrote:
> Here's a revised patch for adding PAG support that incorporates suggestions
> and corrections I've been sent.

Please don't call this a pag. PAGs are defined as a simple unique
integer session identifier [1]. Their main purpose it to provide a
isolated permission environment, think of it as a chroot. So joining
or leaving a PAG is just plain wrong.

The implementation to add a PAG to Linux is really nothing more than
adding single integer to the task and file structs. And a couple of
functions to set a new unique value and query the value.

AFS (and possibly DFS) style token management uses both the user id
(fsuid?) and PAG id. It has simple rules,

   All processes with (pag == 0 and same uid) share the same tokens.
   All processes with pag != 0 share the same tokens.

So this really works a lot like chroot. Normally everyone who logs in
inherits pag 0 from the init task and permissions will be shared based
on the userid. However if login newpags' us into a isolated environment
permissions are based on this session.

But the presented code seems to mix up sessions, tokens, lifetimes,
permissions. I cannot provide a isolated environment because people can
both join and leave an existing pag. The in-kernel token cache seems to
be more important, but things like tokens that expire and have to be
replaced while a file is already open are not dealt with.

This was my last mail on the subject as I seem the be the only one on
that actually seem to view PAGs the way I do.

Jan


[1] Integrating Security in a Large Distributed System  (# 12)
    Satyanarayanan, M.
    ACM Transactions on Computer Systems
    Aug. 1989, Vol. 7, No. 3, pp. 247-280 
    http://www-2.cs.cmu.edu/afs/cs/project/coda-www/ResearchWebPages/docdir/sec89.pdf
