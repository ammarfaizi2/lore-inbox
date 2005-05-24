Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbVEXKiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbVEXKiZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 06:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbVEXKa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 06:30:29 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:58250 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262063AbVEXK2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 06:28:35 -0400
Date: Tue, 24 May 2005 12:28:40 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: cotte@freenet.de, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, schwidefsky@de.ibm.com, akpm@osdl.org,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC/PATCH 2/4] fs/mm: execute in place (3rd version)
Message-ID: <20050524102839.GA17254@wohnheim.fh-wedel.de>
References: <1116866094.12153.12.camel@cotte.boeblingen.de.ibm.com> <1116869420.12153.32.camel@cotte.boeblingen.de.ibm.com> <20050524093029.GA4390@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050524093029.GA4390@in.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 May 2005 15:00:29 +0530, Suparna Bhattacharya wrote:
> 
> OK, though this leaves filemap.c alone which is good, I have to admit
> that this entire duplication of read/write routines really worries me.
> 
> There has to be a third way.

There is.  I'm not convinced it's a good idea, but maybe someone
smarter can comment on it.

v1 and v2 basically contained the generic code with an extra check
here and there.

int do_shtuff(...)
{
	if (xip)
		do_xip_shtuff(...);
	/* shtuff */
	...
}

v3 contains a copy of the generic code in filemap_xip.c.

int do_shtuff_xip(...)
{
	do_xip_shtuff(...);
	/* shtuff copied from filemap.c */
	...
}

v4 could do something like this:

int __do_generic_shtuff(...)
{
	/* the generic shtuff */
	...
}

int do_shtuff(...)
{
	return __do_generic_shtuff(...);
}

int do_shtuff_xip(...)
{
	do_xip_shtuff(...);
	return __do_generic_shtuff(...);
}

Jörn

-- 
You cannot suppose that Moliere ever troubled himself to be original in the
matter of ideas. You cannot suppose that the stories he tells in his plays
have never been told before. They were culled, as you very well know.
-- Andre-Louis Moreau in Scarabouche
