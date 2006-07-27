Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbWG0HiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbWG0HiS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 03:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932538AbWG0HiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 03:38:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43498 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932533AbWG0HiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 03:38:17 -0400
Date: Thu, 27 Jul 2006 00:38:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: nickpiggin@yahoo.com.au, eike-kernel@sf-tec.de,
       linux-kernel@vger.kernel.org, aia21@cantab.net
Subject: Re: [BUG?] possible recursive locking detected
Message-Id: <20060727003806.def43f26.akpm@osdl.org>
In-Reply-To: <1153984527.21849.2.camel@imp.csi.cam.ac.uk>
References: <200607261805.26711.eike-kernel@sf-tec.de>
	<20060726225311.f51cee6d.akpm@osdl.org>
	<44C86271.9030603@yahoo.com.au>
	<1153984527.21849.2.camel@imp.csi.cam.ac.uk>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2006 08:15:27 +0100
Anton Altaparmakov <aia21@cam.ac.uk> wrote:

> > I'm surprised ext2 is allocating with __GFP_FS set, though. Would that
> > cause any problem?
> 
> That is an ext2 bug IMO.

There is no bug.

What there is is an ill-defined set of rules.  If we want to tighten these
rules we have a choice between

a) Never enter page reclaim while holding i_mutex or

b) never take i_mutex on the page reclaim path.


Implementing a) would be a disaster.  It means that our main write()
implementation in mm/filemap.c (which holds i_mutex) wouldn't be able to
reclaim pages to satisfy the write.  And generally, we do want to use the
strongest memory allocation mode at all times.

So we'll have a better kernel if we implement b).
