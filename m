Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272064AbTHBIUa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 04:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272120AbTHBIU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 04:20:29 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:43658
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S272064AbTHBIU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 04:20:28 -0400
Message-ID: <3F2B7435.7070101@redhat.com>
Date: Sat, 02 Aug 2003 01:20:05 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030731 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] bug in setpgid()? process groups and thread groups
References: <1059811048.18516.43.camel@ixodes.goop.org>
In-Reply-To: <1059811048.18516.43.camel@ixodes.goop.org>
X-Enigmail-Version: 0.81.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeremy Fitzhardinge wrote:

> I think there's a bug in setpgid().  At present, it only allows the
> thread group leader to change process groups, but it doesn't change the
> other threads in the thread group to the new process group.

The PGID is not the only value which is handled incorrectly like this.
The PID, GID, etc all need to be treated similarly.

Your approach with iterating over the threads is not acceptable (at
least to me).  It is racy (concurrent runs are not synchronized) and has
a non-constant time.  We've sketched out already a mechanism which
solves to problem.  Basically, most of the time the value from the
thread group leader is used (just follow the pointer).  Then setting the
value is an atomic operation an constant.

The problem is that Linus already said it is too late for this for 2.6.
 So we are waiting for a signal that the time is right.  The changes
will be substantial since all the different IDs should be covered.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/K3Q12ijCOnn/RHQRAonMAJ9L5s/ZH682oq3/gT6OfNcC+V+QTACdFESs
bwhXkcCynmDdtszLiE5OZn8=
=fyzs
-----END PGP SIGNATURE-----

