Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310367AbSCLDBm>; Mon, 11 Mar 2002 22:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310371AbSCLDBd>; Mon, 11 Mar 2002 22:01:33 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:54691 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S310367AbSCLDBW>;
	Mon, 11 Mar 2002 22:01:22 -0500
Date: Tue, 12 Mar 2002 13:59:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrea Arcangeli <andrea@suse.de>
Cc: oskar@osk.mine.nu, linux-kernel@vger.kernel.org
Subject: Re: directory notifications lost after fork?
Message-Id: <20020312135949.3be7d9ca.sfr@canb.auug.org.au>
In-Reply-To: <20020312022046.R10413@dualathlon.random>
In-Reply-To: <20020310210802.GA1695@oskar>
	<20020311112652.E10413@dualathlon.random>
	<20020312120452.3038c4bc.sfr@canb.auug.org.au>
	<20020312022046.R10413@dualathlon.random>
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrea,

On Tue, 12 Mar 2002 02:20:46 +0100 Andrea Arcangeli <andrea@suse.de> wrote:
>
> If somebody overrides the dnotify on the same file, he should become the
> new owner, that's not handled in the below patch.

My contention is that if some process (not in the same thread group as the
process that originally set up the directory notifier) tries to set up a
directory notifier on the same file descriptor (i.e. they are a child of
the original process), then they should get their own notifier.  The
parent can remove their notifier if they want to.

Notice that multiple processes can have notifiers enabled for the same
directory (even with a different set of flags).

My patch makes directory notifiers per thread group instead of per process
tree (which they are now).

> Secondly I prefer to return -EPERM to userspace if somebody tries to
> drop a dnotify that it doesn't own, it gives more information back to
> userspace.

This would be equivalent to returning -EPERM if you tried to remove a
lock on a file when you didn't set it ...

-- 
Cheers, Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
