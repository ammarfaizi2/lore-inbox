Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263208AbTEOAC0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 20:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263206AbTEOACZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 20:02:25 -0400
Received: from smtp3.server.rpi.edu ([128.113.2.3]:31890 "EHLO
	smtp3.server.rpi.edu") by vger.kernel.org with ESMTP
	id S263205AbTEOACS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 20:02:18 -0400
Mime-Version: 1.0
Message-Id: <p05210619bae885784bd4@[128.113.24.47]>
In-Reply-To: <20030514165838.GD20171@delft.aura.cs.cmu.edu>
References: <24225.1052909011@warthog.warthog>
 <20030514165838.GD20171@delft.aura.cs.cmu.edu>
Date: Wed, 14 May 2003 20:14:39 -0400
To: Jan Harkes <jaharkes@cs.cmu.edu>, David Howells <dhowells@redhat.com>
From: Garance A Drosihn <drosih@rpi.edu>
Subject: [OpenAFS-devel] Re: [PATCH] PAG support, try #2
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:58 PM -0400 5/14/03, Jan Harkes wrote:
>On Wed, May 14, 2003, David Howells wrote:
>  > Here's a revised patch for adding PAG support that
>  > incorporates suggestions and corrections I've been sent.
>
>Please don't call this a pag. PAGs are defined as a simple
>unique integer session identifier [1]. Their main purpose it
>to provide a isolated permission environment, think of it as
>a chroot. So joining or leaving a PAG is just plain wrong.
>
>The implementation to add a PAG to Linux is really nothing
>more than adding single integer to the task and file structs.
>And a couple of functions to set a new unique value and query
>the value.
>
>AFS (and possibly DFS) style token management uses both the
>user id (fsuid?) and PAG id. It has simple rules,
>
>    All processes with (pag == 0 and same uid) share the
>        same tokens.
>    All processes with pag != 0 share the same tokens.

Let me rephrase this just a little bit, to make sure everyone
is getting the exactly same idea:

     For any process where pag != 0, that process will share
     tokens with all other processes that have the exact same
     pag value as it has.  This is true even if the different
     processes are tied to different user ids.

     Eg:  When doing 'sudo blah', the 'blah' process will
     still be in the exact same pag, and it will have all
     the exact same tokens, even though the process is
     running as uid root.  Another example would be setuid
     programs.

There is absolutely no connection between userids and PAG's,
the same way that there is no connection between userids and
process-numbers.  (Roughly speaking:) The 10th person to log
in will get the 10th pag, no matter what userid they happen
to log in as.

It's tokens which have some relation to userids.  In the world
of AFS, a pag can hold only one token from any one AFS cell
at a given time.  But I can change which "AFS userid" that I
am, without changing which pag I am in, and all processes in
that same pag will instantly become that same "AFS userid".

>This was my last mail on the subject as I seem the be the
>only one on that actually seem to view PAGs the way I do.

This would be a shame, as I think you've done a good job of
presenting a clear picture of what is really needed.

Disclaimer: I have no idea of what code changes would be
appropriate for the linux kernel, I'm just saying the above
description matches my idea of what a PAG should be.

-- 
Garance Alistair Drosehn            =   gad@gilead.netel.rpi.edu
Senior Systems Programmer           or  gad@freebsd.org
Rensselaer Polytechnic Institute    or  drosih@rpi.edu
