Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280916AbRKGTJ5>; Wed, 7 Nov 2001 14:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280915AbRKGTJr>; Wed, 7 Nov 2001 14:09:47 -0500
Received: from cc78409-a.hnglo1.ov.nl.home.com ([212.120.97.185]:45188 "EHLO
	dexter.hensema.xs4all.nl") by vger.kernel.org with ESMTP
	id <S280916AbRKGTJi>; Wed, 7 Nov 2001 14:09:38 -0500
From: spamtrap@use.reply-to (Erik Hensema)
Subject: Yet another design for /proc. Or actually /kernel.
Date: 7 Nov 2001 19:09:35 GMT
Message-ID: <slrn9uj1nf.5lj.spamtrap@dexter.hensema.xs4all.nl>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.6.3 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's my go at a new design for /proc. I designed it from a userland
point of view and tried not to drown myself into details.

Design goals
============

- Backward compatibility
	The current /proc interface is coded into many applications.
	A new design must leave room for backward compatibility.
- Forward compatibility
	The new interface must be clearly defined and must not change
	in the future, unless that change is clearly indicated and it
	would cause horrible pain maintaining the current interface.
	(Note: I mean the interface to userland, kernel interfaces may
	change as much as they like)
- Parsable by applications
	Information in /proc isn't really meant for humans to read.
	Maybe programmers, but they aren't human anyway. The new /proc
	interface must be parsable by applications as easily as
	possible.
- Readable by humans
	When there's no compelling need to obscure information, don't.
- As simple as possible
	Don't bloat the interface with all kinds of fancy decorations.
	Let's leave that to userspace.


>From these goals I come to the following design:

Design
======

- Multiple values per file when needed
	A file is a two dimensional array: it has lines and every line
	can consist of multiple fields.
	A good example of this is the current /proc/mounts.
	This can be parsed very easily in all languages.
	No need for single-value files, that's oversimplification.
- No headers, no pretty formatting
	Headers are nice to humans, but applications tend to dislike
	them. Same goes for formatting.
	An example of this is in /proc/partitions or -- horrors --
	/proc/meminfo.
- ASCII values
	ASCII is the only format which can be read by humans, shell
	scripts, perl, C and the rest of the world.
- Maybe we should move out of /proc
	Since this design must leave room for backwards compatibility
	we must assume the current /proc stays around for a while. I
	propose we create a new kernelfs which is to be mounted at
	/kernel.
- Mandatory documentation
	Each and every value must be documented. This documentation
	may be very, very basic, but it must clearly define the entry
	and its intention. This is forward compatibility.


As an example, this is how I would organize the info currently in
/proc/meminfo (any boy, that file is UGLY!):

Every value is in bytes. Rounding to kbytes or mbytes should be done
in userspace.

New		Current entry in /proc/meminfo
--------------- -----------------------------------
mem/total	MemTotal
mem/free	MemFree
mem/shared	MemShared
mem/buffers	Buffers
mem/cached	Cached
mem/active	Active
mem/inactive	Inactive

mem/high/total	HighTotal
mem/high/free	HighFree

mem/low/total	LowTotal
mem/low/free	LowFree

mem/swap/total	SwapTotal
mem/swap/free	SwapFree
mem/swap/cached	SwapCached
mem/swap/files	(current /proc/swaps)
-- 
Erik Hensema (erik@hensema.net)
I'm on the list, no need to Cc: me, though I appreciate one if your
mailer doesn't support the References header.
