Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262883AbSJ1Fyp>; Mon, 28 Oct 2002 00:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262884AbSJ1Fyp>; Mon, 28 Oct 2002 00:54:45 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:34831 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S262883AbSJ1Fyo>;
	Mon, 28 Oct 2002 00:54:44 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200210280601.g9S612d334569@saturn.cs.uml.edu>
Subject: Re: warped security
To: jw@pegasys.ws (jw schultz)
Date: Mon, 28 Oct 2002 01:01:02 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), linux-kernel@vger.kernel.org
In-Reply-To: <20021027184548.GB21165@pegasys.ws> from "jw schultz" at Oct 27, 2002 10:45:48 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jw schultz writes:
> On Sun, Oct 27, 2002 at 03:24:28AM -0500, Albert D. Cahalan wrote:

>> As a non-root user:
>>
>> a. I can't do readlink() on /proc/1/exe ("ls -l /proc/1/exe")
>> b. I can do "cat /proc/1/maps" to see what files are mapped
>>
>> That's backwards. If a user can read /proc/1/cmdline, then
>> they might as well be permitted to readlink() on /proc/1/exe
>> as well. Reading /proc/1/maps is quite another matter,
>> exposing more info than the (prohibited) /proc/1/fd/* does.
>
> It seems to have been this way since at least 2.2.  It isn't
> exclusive to the /proc/*/exe.  It applies to all symlinks in
> /proc/$pid.

Guessing:

1. readlink and follow permissions were not distinct
2. symlink following in /proc wasn't done normally
3. therefore, readlink implied access to the target's data

Rather than fix #1 or #2, readlink() got restricted.

> As near as i can tell it seems to be a
> functional-equivalency carryover from 2.2.  It isn't causing
> much harm but i do wonder if this is intentional and if so,
> why.  I'm at a loss to see why refusing to allow non-owners
> to identify a process's cwd, exe, and root would be
> desireable.  The only other things we refuse are mem, fd/
> and eviron, the reasons for which are obvious and the
> restrictions are per-file rather than as a class.

Being able to readlink() in the fd directory is much less
revealing than the content of the maps file. IMHO both of
them should be restricted, but the "maps" file matters more.

Just look at this:   cat /proc/1/maps

This all looks completely mixed up. Users SHOULD NOT be able
to read /proc/1/maps, but SHOULD be able to readlink at least
any /proc/1/* symlink that has meaning in the current namespace.
(so not if the observer is in a chroot environment)
