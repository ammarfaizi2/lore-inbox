Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263623AbUCYVqr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 16:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263624AbUCYVqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 16:46:47 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18573 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263623AbUCYVqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 16:46:43 -0500
To: Jamie Lokier <jamie@shareable.org>
Cc: =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Davide Libenzi <davidel@xmailserver.org>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
References: <20040321125730.GB21844@wohnheim.fh-wedel.de>
	<Pine.LNX.4.44.0403210944310.12359-100000@bigblue.dev.mdolabs.com>
	<20040321181430.GB29440@wohnheim.fh-wedel.de>
	<m1y8ptu42m.fsf@ebiederm.dsl.xmission.com>
	<20040325174942.GC11236@mail.shareable.org>
	<m1ekrgyf5y.fsf@ebiederm.dsl.xmission.com>
	<20040325194303.GE11236@mail.shareable.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Mar 2004 14:46:21 -0700
In-Reply-To: <20040325194303.GE11236@mail.shareable.org>
Message-ID: <m1ptb0zjki.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> Eric W. Biederman wrote:
> > One of the rougher patches, in that we don't have persistent inode
> > numbers.  Basically the two files never have the same inode number.
> > To the user they are always presented as two separate files.
> 
> That is not useful for me or the other people who want to use this to
> duplicate large source trees and run "diff" between trees.
> 
> "diff" depends on being able to check if files in the two trees are
> identical -- by checking whether the inode number and device (and
> maybe other stat data) are identical.  This allows "diff -ur" between
> two cloned trees the size of linux to be quite fast.  Without that
> optimisation, it's very slow indeed.


In the case where cow is implemented as a stackable filesystem it is
easy to discover the changes by looking at the underlying fs instead
of at the cow view.  If the file was not changed the file was not
copied.

The reason for the late copy is some programs open files O_RDRW and
only read the file.  If those triggered a copy on write when you
opened the file, diff would still need to go to the work of manually
comparing the files.

The underlying idea of copy on write is that you have separate files
that happen to be storing the same data, in the same space.  Anytime
you deviate from that is when you are going to get surprised.  

The case I care about is sharing the same root filesystem on different
machines, and that must look like 2 separate filesystems.

It is easy to add something like a cowstat or a readcowlink and teach
the few programs that care (i.e. diff, tar,...) how to use it.  So I
would rather concentrate on making cow links look like a separate copy
than early optimizations.

Eric
