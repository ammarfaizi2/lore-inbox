Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262504AbSIZMWK>; Thu, 26 Sep 2002 08:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262505AbSIZMWK>; Thu, 26 Sep 2002 08:22:10 -0400
Received: from pc-62-31-66-34-ed.blueyonder.co.uk ([62.31.66.34]:63106 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S262504AbSIZMWJ>; Thu, 26 Sep 2002 08:22:09 -0400
Date: Thu, 26 Sep 2002 13:27:23 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jakob Oestergaard <jakob@unthought.net>,
       "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: jbd bug(s) (?)
Message-ID: <20020926132723.D2721@redhat.com>
References: <20020924072117.GD2442@unthought.net> <20020925173605.A12911@redhat.com> <20020926122124.GS2442@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020926122124.GS2442@unthought.net>; from jakob@unthought.net on Thu, Sep 26, 2002 at 02:21:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 26, 2002 at 02:21:24PM +0200, Jakob Oestergaard wrote:

> Originally it was my impression that the index was written fairly
> frequently, *and* that you did not have the atomic-sector-write
> guarantee.

The index is only updated when we purge stuff out of the journal.
That can still be quite frequent on a really busy journal, but it's
definitely not a required part of a transaction.  

That's deliberate --- the ext3 journal is designed to be written as
sequentially as possible, so seeking to the index block is an expense
which we try to avoid.

> RAID wouldn't save me in the case where the journal index is screwed due
> to a partial sector write and a power loss.

A partial sector write is essentially impossible.  It's unlikely that
the data on disk would be synchronised beyond the point at which the
write stopped, and even if it was, the CRC would be invalid, so you'd
get a bad sector error return on subsequent attempts to read that data
--- you'd not be given silently corrupt data.

Making parts of the disk suddenly unreadable on power-fail is
generally considered a bad thing, though, so modern disks go to great
lengths to ensure the write finishes.

--Stephen
