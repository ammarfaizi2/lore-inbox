Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264542AbRFJQi0>; Sun, 10 Jun 2001 12:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264033AbRFJQiQ>; Sun, 10 Jun 2001 12:38:16 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:2829 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S264032AbRFJQiA>; Sun, 10 Jun 2001 12:38:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <andrewm@uow.edu.au>
Subject: Re: [patch] truncate_inode_pages
Date: Sun, 10 Jun 2001 18:40:23 +0200
X-Mailer: KMail [version 1.2]
Cc: Alexander Viro <viro@math.psu.edu>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0106091331120.19361-100000@weyl.math.psu.edu> <01061000533601.03897@starship> <3B22CDFA.2BC46385@uow.edu.au>
In-Reply-To: <3B22CDFA.2BC46385@uow.edu.au>
MIME-Version: 1.0
Message-Id: <01061018402300.05248@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 June 2001 03:31, Andrew Morton wrote:
> Daniel Phillips wrote:
> > This is easy, just set the list head to the page about to be truncated.
>
> Works for me.

It looks good, but it's black magic - it could use a comment along the lines 
of:

/*
 * Ensure at least one pass through all three lists with lock held
 */

There is some fuzz on the original code that could use a scrubbing.  "start" 
should not be the 1st full page needing truncating, it should be the first 
page needing truncating at all, full or partial.

The truncation condition becomes:

-		if ((offset >= start) || (*partial && (offset + 1) == start)) {
+		if (offset >= start) {
[...]
-			if (*partial && (offset + 1) == start)
+			if (*partial && offset == start)

Then the conditions are so easy to test it's not worth passing the &partial, 
just pass lstart... and... oh bother, it's not broke, why fix it ;-)

--
Daniel

