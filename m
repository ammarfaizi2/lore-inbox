Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbTLCXJa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 18:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbTLCXJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 18:09:29 -0500
Received: from bolt.sonic.net ([208.201.242.18]:44774 "EHLO bolt.sonic.net")
	by vger.kernel.org with ESMTP id S262315AbTLCXIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 18:08:05 -0500
Date: Wed, 3 Dec 2003 15:08:04 -0800
From: David Hinds <dhinds@sonic.net>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Worst recursion in the kernel
Message-ID: <20031203150804.A19286@sonic.net>
References: <20031203143122.GA6470@wohnheim.fh-wedel.de> <20031203100709.B6625@sonic.net> <20031203190440.GA15857@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031203190440.GA15857@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 08:04:40PM +0100, Jörn Engel wrote:
> 
> You are right, verify_cis_cache() does not belong into the list.
> Gotta see where that bug comes from.  set_cis_map() is correct,
> though.  It does call validate_mem(), at least in my copy of
> 2.6.0-test11:

Oh, so it does; I was looking at the older version I wrote.

> I have no better alternative availlable right now, but there must be
> another way.  Maybe something like this:
> 
> read_cis_mem() {
> 	if (__read_cis_mem() != -EAGAIN)
> 		return;
> 	validate_mem();
> 	__read_cis_mem();
> }

The issue is that validate_mem() doesn't need to use read_cis_mem's
functionality directly (so it can't just be modified to use the __*
form).  It calls other stuff, which calls other stuff, which
eventually calls read_cis_mem(), and all that other stuff is used by
other callers.  So there isn't an obvious place to insert this
bifurcation.

> Not sure about you, but it would make my program much happier.  If you
> look at the relevant part of the call graph (below), you will notice
> that inv_probe() alone is already recursive.  Having multiple
> recursions to worry about in the same function is where the problem
> stops being difficult and becomes impossible.

inv_probe() is pretty comprehensible, it calls itself directly, in
order to traverse a short linked list from tail to head.

-- Dave
