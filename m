Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbUCLSTP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 13:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbUCLSTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 13:19:14 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:2969 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S262378AbUCLSSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 13:18:30 -0500
Date: Fri, 12 Mar 2004 19:18:28 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH for testing] cow behaviour for hard links
Message-ID: <20040312181828.GA7087@wohnheim.fh-wedel.de>
References: <20040310193429.GB4589@wohnheim.fh-wedel.de> <200403121849.03505.s.b.wielinga@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200403121849.03505.s.b.wielinga@student.utwente.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 March 2004 18:48:57 +0100, Sytse Wielinga wrote:
> 
> I'm sorry to say this, but I stumbled upon a prohibitive problem...
> 
> The problem is that if a hard link would be broken up, one of the dentry's 
> would get a link to a new inode with a new inode number. This would mean that 
> right under the nose of the app, the file suddenly gets a new inode number. 
> Apps don't like that. If anyone has any suggestion that might make this 
> possible please say so, but I don't see it.

Different design.  How about this:
- Files with just one link remain as-is.
- Linking a file:
  - Create a new inode and move all data into new inode.
  - Make old inode a pointer to new inode.
  - Create a second pointer to new inode.
- Unlinking a file:
  - Unlink pointer inode
  - Unlink target inode
- Writing to a pointer inode:
  - Make pointer inode a regular one.
  - Copy target inode data into former pointer inode.
  - Unlink target inode
  - If target count was 1, we don't even need to copy.

Or in ascii art:

Regular file:

	inode 1

Second link:

	inode 1 ---> inode 2
	             ^
	inode 3 -----|

Write to inode 1:

	inode 1

	inode 3 ---> inode 2

Unlink of inode 3:

	inode 1


Not quite as simple and straightforward as my first design, but it has
some advantages.  Would even be possible to extend it and allow links
across different filesystems.

Jörn

-- 
A quarrel is quickly settled when deserted by one party; there is
no battle unless there be two.
-- Seneca
