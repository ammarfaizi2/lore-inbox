Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbTJMMKR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 08:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTJMMKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 08:10:17 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:33171
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S261753AbTJMMIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 08:08:51 -0400
Date: Mon, 13 Oct 2003 14:09:36 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ernie Petrides <petrides@redhat.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.x performance tests Re: [PATCH] BUG() in exec_mmap()
Message-ID: <20031013120936.GF1887@velociraptor.random>
References: <200310130652.h9D6qiib005952@pasta.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310130652.h9D6qiib005952@pasta.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 13, 2003 at 02:52:44AM -0400, Ernie Petrides wrote:
> --- linux-2.4.21/fs/exec.c.orig
> +++ linux-2.4.21/fs/exec.c
> @@ -452,9 +452,11 @@ static int exec_mmap(void)
>  
>  	old_mm = current->mm;
>  	if (old_mm && atomic_read(&old_mm->mm_users) == 1) {
> +		down_write(&old_mm->mmap_sem);
>  		mm_release();
>  		exit_aio(old_mm);
>  		exit_mmap(old_mm);
> +		up_write(&old_mm->mmap_sem);
>  		return 0;
>  	}

Is there any special reason you take it around mm_release and exit_aio
too? I don't feel this is needed. exit_aio btw still assumes nobody can
race, so it doesn't take any spinlock (brlocks actually) to guard
against other aio threads, I believe that's ok since as worse the other
tasks can mangle the vm with ptrace, they'll never get to mess with aio,
only the current task can and the mm_user == 1 check guarantees we've no
sibiling threads. the mmap_sem shouldn't help exit_aio anyways, if
something it'll make it deadlock if there's any access to the VM that
generates a page fault in the cancel() callback.

So I suggest this sequence should be safe:

	mm_release();
	exit_aio(old_mm);

	down_write(&old_mm->mmap_sem);
	exit_mmap(old_mm);
	up_write(&old_mm->mmap_sem);

Please double check ;)

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
