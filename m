Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbUK0HGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbUK0HGN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 02:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbUK0HGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 02:06:08 -0500
Received: from zeus.kernel.org ([204.152.189.113]:18110 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261368AbUKZTHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:07:50 -0500
Subject: Re: 2.4.28-bk3 ext3 oopses at boot
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@redhat.com>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20041125212833.0ff3af4f@lembas.zaitcev.lan>
References: <20041125212833.0ff3af4f@lembas.zaitcev.lan>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1101459722.1941.10.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Nov 2004 09:02:02 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2004-11-26 at 05:28, Pete Zaitcev wrote:

> I keep getting pretty random oopses at boot which point at either ext3 or
> the SATA. This is a Dell PE750 which Matt sent me, BTW. 

...

> Failures are generally random, and they look like this (transcribed by hand):
> 
> VA NULL (0x0c)
> EIP: write_one_revoke_record

> VA 0x89e389d5
> EIP: find_revoke_record

Both of these are when list-walking the revoke list.  That's purely an
in-memory data structure, it shouldn't be affected by anything on disk. 
You could try a forced fsck just to be sure, but it doesn't sound like
there's a corruption on disk here.  (There *is* a variant of the revoke
list that is read from disk, but that's only used during log replay,
which isn't active in your oops traces.)

> if the box passes the boot, everything is peachy.
> No filesystem corruption of any kind.

Sounds to me like you're getting corruption in a repeatable address
somewhere at boot time that just happens to be hitting the revoke list
early on.

I saw something like this once before, except it was on a buffer_head
list.  Debugging, I was able to identify that the *previous* entry of
the list was always exactly at the 16MB mark in memory, and the list
pointers there were getting corrupted.  Turned out to be a bad BIOS that
was trapping a PCI bus operation, setting up a pte for some internal
workspace, restoring it on exit back to the OS but forgetting to flush
the tlb.  Adding a tlb flush after various PCI ops fixed it completely. 
Similar footprint to yours: a crash shortly after boot in a specific
data structure but with pretty random VAs, and at random points in the
bh walking code.

The revoke code hasn't changed in *ages*, and I've never seen a report
of that list getting corrupted before.  I suspect the fs is just an
innocent victim here.

Cheers,
 Stephen

