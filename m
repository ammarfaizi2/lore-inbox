Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265958AbUBPWkm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 17:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265961AbUBPWkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 17:40:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:52199 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265958AbUBPWkd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 17:40:33 -0500
Date: Mon, 16 Feb 2004 14:40:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Marc Lehmann <pcg@schmorp.de>, viro@parcelfarce.linux.theplanet.co.uk,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re:
 JFS default behavior)
In-Reply-To: <20040216222618.GF18853@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0402161431260.30742@home.osdl.org>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca>
 <200402150006.23177.robin.rosenberg.lists@dewire.com>
 <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk>
 <200402150107.26277.robin.rosenberg.lists@dewire.com>
 <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216183616.GA16491@schmorp.de>
 <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <20040216200321.GB17015@schmorp.de>
 <Pine.LNX.4.58.0402161205120.30742@home.osdl.org> <20040216222618.GF18853@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 16 Feb 2004, Jamie Lokier wrote:
> 
> Alas, once userspace has migrated to doing everything in UTF-8, you
> won't be able to read those files because userspace will barf on them.

Nope. Read my other email. Done right, user space will _not_ barf on them, 
because it won't try to "normalize" any UTF-8 strings. If the string has 
garbage in it, user space should just pass the garbage through.

We've had this _exact_ issue before. Long before people worried about
UTF-8, people worried about the fact that programs like "ls" shouldn't
print out the extended ASCII characters as-is, because that would cause
bad problems on a terminal as they'd be seen as terminal control
characters.

Does that mean that unix tools like "rm" cannot remove those files? Hell 
no! It just means that when you do "rm -i *", the filename that is printed 
may not have special characters in it that you don't see.

Same goes for UTF-8. A "broken" UTF-8 string (ie something that isn't 
really UTF-8 at all, but just extended ASCII) won't _print_ right, but 
that doesn't mean that the tools won't work. You'll still be able to edit 
the file.

Try it with a regular C locale. Do a simple

	echo > едц

(that's latin1), and do a "rm -i едц", and see what it says. 

Right: it does the _right_ thing, and it prints out:

	torvalds@home:~> rm -i едц
	rm: remove regular file `\345\344\366'? 

In other words, you have a program that doesn't understand a couple of the 
characters (because they don't make sense in its "locale"), but it still 
_works_. It just can't print them.

Which, if you think about is, is 100% EXACTLY equivalent to what a UTF-8
program should do when it sees broken UTF-8. It can still access the file, 
it can still do everything else with it, but it can't print out the 
filename, and it should use some kind of escape sequence to show that 
fact.

The two cases are 100% equivalent. We've gone through this before. There 
is a bit of pain involved, but it's not something new, or something 
fundamentally impossible. It's very straightforward indeed.

		Linus
