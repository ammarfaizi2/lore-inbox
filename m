Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316783AbSE3SBa>; Thu, 30 May 2002 14:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316789AbSE3SB3>; Thu, 30 May 2002 14:01:29 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:1913 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316783AbSE3SB3>; Thu, 30 May 2002 14:01:29 -0400
Date: Thu, 30 May 2002 19:59:23 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Denis Lunev <den@asplinux.ru>
Cc: linux-kernel@vger.kernel.org, Andrey Nekrasov <andy@spylog.ru>,
        rwhron@earthlink.net, Yann Dupont <Yann.Dupont@IPv6.univ-nantes.fr>
Subject: Re: inode highmem imbalance fix [Re: Bug with shared memory.]
Message-ID: <20020530175923.GF1383@dualathlon.random>
In-Reply-To: <OF6D316E56.12B1A4B0-ONC1256BB9.004B5DB0@de.ibm.com> <3CE16683.29A888F8@zip.com.au> <20020520043040.GA21806@dualathlon.random> <20020524073341.GJ21164@dualathlon.random> <15606.3088.552163.828139@artemis.asplinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2002 at 03:25:04PM +0400, Denis Lunev wrote:
Content-Description: message body text
> Hello!
> 
> The patch itself cures my problems, but after a small fix concerning
> uninitialized variable resulting in OOPS.
> 
> Regards,
> 	Denis V. Lunev
> 

Content-Description: diff-andrea-inodes2
> --- linux/fs/inode.c.old	Wed May 29 20:16:17 2002
> +++ linux/fs/inode.c	Wed May 29 20:17:08 2002
> @@ -669,6 +669,7 @@
>  	struct inode * inode;
>  
>  	count = pass = 0;
> +	entry = &inode_unused;
>  
>  	spin_lock(&inode_lock);
>  	while (goal && pass++ < 2) {


Great spotting! this fix is certainly correct, without it the unused
list will be corrupted if prune_icache gets a goal == 0 as parameter.
OTOH if fixes that cases only (that riggers only when the number of
unused inodes is <= vm_vfs_scan_ratio, not an extremely common case, I
wonder if that's enough to cure all the oopses I received today),
probably it's enough, the number of unused inodes is != than the number
of inodes allocated. At first glance I don't see other issues (my error
is been to assume goal was going to be always something significant).
BTW, it's great that at the first showstopper bug since a long time I
got such an high quality feedback after a few hours, thank you very
much! :)

Could you test if the below one liner from Denis (I attached it below
too without quotes) fixes all your problems with 2.4.19pre9aa1 or with
the single inode highmem imbalance fix? thanks,

--- linux/fs/inode.c.old	Wed May 29 20:16:17 2002
+++ linux/fs/inode.c	Wed May 29 20:17:08 2002
@@ -669,6 +669,7 @@
 	struct inode * inode;
 
 	count = pass = 0;
+	entry = &inode_unused;
 
 	spin_lock(&inode_lock);
 	while (goal && pass++ < 2) {


Also it seems the O1 scheduler is doing well so far. In next -aa I will
also include the patch from Mike Kravetz that I finished auditing and
it's really strightforward, it serializes the execution of the reder of
the pipe with the writer of the pipe if the writer expires the length
of the pipe buffer, that will maximize pipe bandwith similar to the
pre-o1 levels, and still the tasks runs in parallel in two cpus if no
blocking from the writer is necessary, I think it's the best heuristic.
Adding the sync beahviour also with the reader seems inferior, I can
imagine a writer running full time in a cpu and sometime posting a few
bytes to the pipe, while the reader always blocking. This way the reader
will keep running in its own cpu, and it won't interfere with the "cpu
intensive" writer.

Andrea
