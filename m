Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264133AbUDBR3R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 12:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264135AbUDBR3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 12:29:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45014 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264133AbUDBR3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 12:29:11 -0500
To: Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de>
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
       ak@suse.de
Subject: Re: Linux 2.6 nanosecond time stamp weirdness breaks GCC build
References: <200404011928.VAA23657@faui1d.informatik.uni-erlangen.de>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 02 Apr 2004 14:27:56 -0300
In-Reply-To: <200404011928.VAA23657@faui1d.informatik.uni-erlangen.de>
Message-ID: <orptaq8f37.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr  1, 2004, Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de> wrote:

> - STAMP = echo timestamp >
> + STAMP = sleep 1 >

I don't think this will fix the problem, at least not portably.

sleep 1 > filename

will truncate filename before sleep starts, modifying its timestamp at
that point, and leave it unchanged afterwards.  Some systems might
update the timestamp again when the file truncated&opened for writing
is closed, but I don't think this is required.  Worse yet: some
systems don't support empty files, and will error out because sleep 1
produced no output.  Also, since some filesystems don't have 1-second
granularity, you should probably use `sleep 2' instead.

A more portable way to spell it would be:

STAMP = sleep 2; echo timestamp >

or, in order to make $(STAMP) usable in the middle of &&/|| sequences:

STAMP = { sleep 2; echo timestamp; } >

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
