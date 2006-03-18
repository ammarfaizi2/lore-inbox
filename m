Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751820AbWCRAYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbWCRAYa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 19:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWCRAYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 19:24:30 -0500
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63]:7317 "HELO
	smtp009.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751820AbWCRAY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 19:24:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=V+zPcwONlNJg+uqwEfuFWGPPE62WHx1/t7Qv4+xnziMIfxTESnW3mRNjfpvKOnCMghzUt62Ta9x2TJq1RQCFTmgLygHyiZqMNr9KSEwzYvEhapCQFcKsUmc5o3szp2zEP8fLs891O4e5Am+s86NGuqgEFj0Q4SFHMZUIfLg4TMc=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] kernel BUG at drivers/block/loop.c:621
Date: Sat, 18 Mar 2006 01:24:18 +0100
User-Agent: KMail/1.8.3
Cc: Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org
References: <200603171912.12082.rob@landley.net>
In-Reply-To: <200603171912.12082.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603180124.19077.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 March 2006 01:12, Rob Landley wrote:
> I can reproduce the following in 2.6.16-rc5, User Mode Linux:
>
> kernel BUG at drivers/block/loop.c:621!
> Kernel panic - not syncing: BUG!
>
> EIP: 0073:[<ffffe410>] CPU: 0 Not tainted ESP: 007b:b7de1f9c EFLAGS:
> 00200246 Not tainted
> EAX: 00000000 EBX: 000018be ECX: 00000013 EDX: 000018be
> ESI: 000018bb EDI: 00000011 EBP: b7de1fb8 DS: 007b ES: 007b
> 09b87bb4:  [<0806c762>] show_regs+0x102/0x110
> 09b87bd0:  [<0805b6fc>] panic_exit+0x2c/0x50
> 09b87be0:  [<0807ff7d>] notifier_call_chain+0x2d/0x50
> 09b87c00:  [<08071095>] panic+0x75/0x120
> 09b87c20:  [<0812e181>] loop_thread+0x151/0x160
> 09b87c4c:  [<08065297>] run_kernel_thread+0x37/0x60
> 09b87cfc:  [<0805bbd1>] new_thread_handler+0x91/0xc0

The below is strange - GCC is putting disks in the .text section or kallsyms 
has some bug.

> 09b87d20:  [<ffffe420>] disks+0xf7e7ec84/0x4

> The reproduction sequence is a bit involved (my mount regression test and
> the current svn snapshot of busybox are involved), and running the
> following sequence of commands:
>
> mount; mount -a; mount; mount /dev/loop1 /images/vfat.dir ;
> losetup /dev/loop1; ls; vi /etc/fstab; cat /etc/fstab; losetup /dev/loop0;
> mount /images/vfat.img /images/vfat.dir -o ro
>
> The current busybox mount is still broken in a couple of known places
> (hence the testing; I'm fixing it).  But it probably shouldn't panic the
> kernel...

*) Is this reproducible on host?

*) I don't understand yet what UML may be doing wrong.
*) look at: that spin_lock (SMP kernel? SPINLOCK_DEBUG? Try enabling the 
latter and see what happens).

(a bio is a block I/O request)
*) given what the code says, on that line bio is NULL, i.e. loop_get_bio 
returned NULL, i.e. (I guess) wait_for_completion_interruptible returned, 
because someone else (loop_make_request) did "complete" on its param, but 
incorrectly as the "someone else" hadn't filled the lo->lo_bio.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com
