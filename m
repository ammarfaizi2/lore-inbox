Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751638AbWJWVB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbWJWVB6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 17:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751649AbWJWVB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 17:01:58 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:18625 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751638AbWJWVB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 17:01:57 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc2-mm2: reproducible hang on shutdown on i386
Date: Mon, 23 Oct 2006 23:00:45 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20061020015641.b4ed72e5.akpm@osdl.org> <200610231643.32148.rjw@sisk.pl> <20061023103448.7c35063b.akpm@osdl.org>
In-Reply-To: <20061023103448.7c35063b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610232300.45462.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 23 October 2006 19:34, Andrew Morton wrote:
> > On Mon, 23 Oct 2006 16:43:31 +0200 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > On Saturday, 21 October 2006 19:30, Rafael J. Wysocki wrote:
> > > On Friday, 20 October 2006 10:56, Andrew Morton wrote:
> > > > 
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc2/2.6.19-rc2-mm2/
> > > > 
> > > > - Added the IOAT tree as git-ioat.patch (Chris Leech)
> > > > 
> > > > - I worked out the git magic to make the wireless tree work
> > > >   (git-wireless.patch).  Hopefully it will be in -mm more often now.
> > > 
> > > [Margin note: bcm43xx doesn't work on my test boxes although it used to on one
> > > of them, but I have to play with it a bit more.]
> > > 
> > > It looks like i386 cannot shut down cleanly with this kernel.  On my test
> > > boxes (2 of them) it hangs after killing all processes, 100% of the time.
> > 
> > I've carried out a binary search which shows that
> > 
> > add-process_session-helper-routine-deprecate-old-field-fix-warnings.patch
> > 
> > causes this to happen.
> 
> Thanks.  That patch had one bug - this will hopefully fi things up:
> 
> From: Jeff Dike <jdike@addtoit.com>
> 
> add-process_session-helper-routine-deprecate-old-field-fix-warnings.patch
> in -mm causes UML to hang at shutdown - init is sitting in a select on the
> initctl socket.
> 
> This patch fixes it for me.
> 
> Signed-off-by: Jeff Dike <jdike@addtoit.com>
> Cc: Cedric Le Goater <clg@fr.ibm.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  fs/proc/array.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN fs/proc/array.c~add-process_session-helper-routine-deprecate-old-field-fix-warnings-fix fs/proc/array.c
> --- a/fs/proc/array.c~add-process_session-helper-routine-deprecate-old-field-fix-warnings-fix
> +++ a/fs/proc/array.c
> @@ -388,7 +388,7 @@ static int do_task_stat(struct task_stru
>  			stime = cputime_add(stime, sig->stime);
>  		}
>  
> -		signal_session(sig);
> +		sid = signal_session(sig);
>  		pgid = process_group(task);
>  		ppid = rcu_dereference(task->real_parent)->tgid;
>  
> _
> 

Yes, this fixes the issue.  Thanks.


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
