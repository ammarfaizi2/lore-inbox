Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWGDNFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWGDNFy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 09:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWGDNFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 09:05:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5252 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932145AbWGDNFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 09:05:53 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1152017562.3109.48.camel@laptopd505.fenrus.org> 
References: <1152017562.3109.48.camel@laptopd505.fenrus.org>  <14683.1152017262@warthog.cambridge.redhat.com> 
To: Arjan van de Ven <arjan@infradead.org>
Cc: David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: R/W semaphore changes 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 04 Jul 2006 14:05:39 +0100
Message-ID: <15345.1152018339@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:

> > Please, please, please don't.  R/W semaphores are _not_ permitted to nest.
> 
> yet they do in places, there where there is a natural hierarchy..

Where?  I believe the mm used to but no longer does.

They still aren't allowed to.  Consider:

	CPU 1			CPU 2
	=======================	=======================
	-->down_read(&A);
	<--down_read(&A);
				-->down_write(&A);
				   --- SLEEPING ---
	-->down_read(&A);
	   --- DEADLOCKED ---

> > | # define down_read_nested(sem, subclass)		down_read(sem)
> > | # define down_write_nested(sem, subclass)	down_write(sem)
> > 
> > This is _not_ okay.
> 
> why not?

See above.

R/W semaphores are as completely fair as I can make them, and they do not keep
track of who's currently been granted what sort of lock.  This means they are
liable to fall foul of the above deadlock sequence.

Any viable down_read()/down_write() nesting must be handled outside of rwsems
themselves.

Also, assume down_write() nesting is permitted, what do you do in the
following situation:

	CPU 1			CPU 2
	=======================	=======================
	-->down_write(&A);
	<--down_write(&A);
				-->down_read(&A);
				   --- SLEEPING ---
	-->foo();
	   -->down_write(&A);
	   <--down_write(&A);
	   ...
	   -->downgrade_write(&A);
	   <--downgrade_write(&A);
				   --- ??? ---
	   -->up_read(&A);
	      --- ??? ---
	   <--up_read(&A);
	<--foo();
	-->up_write(&A);
	   --- ??? ---
	<--up_write(&A);

David

