Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272430AbTHEExx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 00:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272432AbTHEExx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 00:53:53 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:5644 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S272430AbTHEExv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 00:53:51 -0400
Date: Mon, 4 Aug 2003 21:53:46 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-ID: <20030805045346.GC27191@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20030804141548.5060b9db.skraw@ithnet.com> <20030804134415.GA4454@win.tue.nl> <20030804155604.2cdb96e7.skraw@ithnet.com> <03080409334500.03650@tabby> <20030804170506.11426617.skraw@ithnet.com> <3F2E9145.5090407@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2E9145.5090407@namesys.com>
User-Agent: Mutt/1.3.27i
X-Message-Flag: The contents of this message may cause sleeplessness, irritability, loss of appetite, anxiety, depression, or other psychological disorders.  Consult your doctor if these symptoms persist.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 09:00:53PM +0400, Hans Reiser wrote:
> If you want hard linked directories, send us a patch for v4.  Should be 
> VERY easy to write.   If there is some reason it is not simple, let me 
> know.  Discuss it with Vitaly though, it might affect fsck.

I don't recommend it but if you do make sure those links can
only be made by root. 

SVR3 and earlier allowed manual hardlinking of directories
by root only.  They were a real source of problems.   It
also confused the dickens out of fsck so it would have to be
restricted or allowed by the filesystem code, not the VFS
layer.  I remember playing with it and it was a guarantee
that fsck would have to be run manually.

	$mkdir A
	$mkdir B
	$mkdir C
	$mkdir A/A1
	$ln A/A1 B/B1
	$ln A/A1 C/C1
	$rmdir A/A1

Assuming we can do this.  A1 is an empty directory after all.
Now B1 has a link count of 1, but i'll assume that is OK

	$rmdir A

It is after all empty even though the link count is 3.

	$cd B/B1
	$/bin/pwd
	cannot stat .

Remember B/B1/.. is it A with a nlinks==1

	$cd ..

Now where are you? It used to be called A but now it has no
normal path but can be reached through B/B1/..  It still has
.. so what directory is it linked to that doesn't have an
entry pointing back to it.
	
Lets some fun with it.

	$mkdir A2

Ah, now we have a directory the path to which is B/B1/../A2
We can hide all sorts of stuff here and find will never see
it.  It won't get backed up but maybe that doesn't matter.

What a lovely way to hide a rootkit.

If on the other hand you removed A/A1/.. when removing A/A1
you have a B/B1 and C/C1 without ..

Now umount the filesystem and run fsck.  B/B1 and C/C1 each
refer to the same directory with no .. or a .. that points
to a third directory with nlinks==1 and no directory entries
except a ..

You can put in a slew of logic to reduce the risks somewhat.
Things like only allowing rmdir somedir when
somedir->nlinks <= 2 || somedir/.. != .
but that still leaves the issue of where .. is linked and
the potential to bypass parent directory based access
controls such as Linus likes in a way that the admin will
have a hard time identifying.

The issues on a filesystem where .. is simulated would i
imagine be different.



-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
