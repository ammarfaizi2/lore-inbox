Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262622AbVA0OD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbVA0OD0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 09:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbVA0ODZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 09:03:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8888 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262622AbVA0ODJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 09:03:09 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1561.1106077468@redhat.com> 
References: <1561.1106077468@redhat.com>  <1106014803.30801.22.camel@localhost.localdomain> <31453.1105979239@redhat.com> 
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       linuxppc64-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix kallsyms/insmod/rmmod race 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Thu, 27 Jan 2005 14:02:42 +0000
Message-ID: <3244.1106834562@redhat.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
> > 	The more I looked at this, the more I warmed to it.  I've known for a
> > while that people are using kallsyms not for OOPS (eg. /proc/$$/wchan),
> > so we should provide a "grabs locks" version, but this solution gets
> > around that nicely, while making life more certain for the oops case,
> > too.
> 
> Hmmm... though it works on i386 SMP, it doesn't, however, seem to work on
> ppc64 SMP:-/
> 
> My pSeries box seems to think that it can't find any symbols from previously
> loaded modules, and my Power5 box is quite happy to load modules that depend
> on other modules but panics because it can't mount its root fs.

Turns out that the patch works. Userspace was being bad. The stripped down
shell running as init (pid #1) wasn't taking into account that it would get
notification of kernel threads exiting when it called wait(), and so ended up
trying to load several modules at once, some of which required dependency
modules loading first.

David
