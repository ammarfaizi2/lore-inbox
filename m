Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbVEWOFC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbVEWOFC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 10:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVEWOFC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 10:05:02 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:62358 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261669AbVEWOEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 10:04:54 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: Alexander Nyberg <alexn@telia.com>
Subject: Re: [PATCH] comments on locking of task->comm
Date: Sat, 21 May 2005 18:23:38 +0200
User-Agent: KMail/1.7.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200505060003.j4603LZf008055@hera.kernel.org> <1115402294.1181.6.camel@localhost.localdomain>
In-Reply-To: <1115402294.1181.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505211823.38386.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 May 2005 19:58, Alexander Nyberg wrote:
> tor 2005-05-05 klockan 17:03 -0700 skrev Linux Kernel Mailing List:
> > tree 125d9d7553c5f6dc6ad030e4c829a5bf71ab3ef5
> > parent 291c4a75ce7632ee5c565359fb875ba0597f76be
> > author Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it> Fri, 06 May
> > 2005 06:16:12 -0700 committer Linus Torvalds <torvalds@ppc970.osdl.org>
> > Fri, 06 May 2005 06:36:48 -0700
> >
> > [PATCH] comments on locking of task->comm
> >
> > Add some comments about task->comm, to explain what it is near its
> > definition and provide some important pointers to its uses.
> >
> > Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
> > Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> >
> >  exec.c        |    4 +++-
> >  linux/sched.h |    7 +++++--
> >  2 files changed, 8 insertions(+), 3 deletions(-)
> >
> > Index: fs/exec.c
> > ===================================================================
> > --- be0fe48738b481b4b172cc9a98ac799ca79aece2/fs/exec.c  (mode:100644
> > sha1:52acff3f44f09b6e841424deddd6599938eeafdf) +++
> > 125d9d7553c5f6dc6ad030e4c829a5bf71ab3ef5/fs/exec.c  (mode:100644
> > sha1:e56ee24370255e2ab4df9a3933ec03f0d07a2de3) @@ -869,9 +869,11 @@ int
> > flush_old_exec(struct linux_binprm *
> >  	if (current->euid == current->uid && current->egid == current->gid)
> >  		current->mm->dumpable = 1;
> >  	name = bprm->filename;
> > +
> > +	/* Copies the binary name from after last slash */
> >  	for (i=0; (ch = *(name++)) != '\0';) {
> >  		if (ch == '/')
> > -			i = 0;
> > +			i = 0; /* overwrite what we wrote */
> >  		else
> >  			if (i < (sizeof(tcomm) - 1))
> >  				tcomm[i++] = ch;
> > Index: include/linux/sched.h
> > ===================================================================
> > --- be0fe48738b481b4b172cc9a98ac799ca79aece2/include/linux/sched.h 
> > (mode:100644 sha1:5f868a5885811571fdc701037bf7b09b40a746b8) +++
> > 125d9d7553c5f6dc6ad030e4c829a5bf71ab3ef5/include/linux/sched.h 
> > (mode:100644 sha1:4dbb109022f3646ff39b7f64464bebb0200071fc) @@ -578,7
> > +578,7 @@ struct task_struct {
> >  	unsigned long flags;	/* per process flags, defined below */
> >  	unsigned long ptrace;
> >
> > -	int lock_depth;		/* Lock depth */
> > +	int lock_depth;		/* BKL lock depth */
> >
> >  	int prio, static_prio;
> >  	struct list_head run_list;
> > @@ -661,7 +661,10 @@ struct task_struct {
> >  	struct key *thread_keyring;	/* keyring private to this thread */
> >  #endif
> >  	int oomkilladj; /* OOM kill score adjustment (bit shift). */
> > -	char comm[TASK_COMM_LEN];
> > +	char comm[TASK_COMM_LEN]; /* executable name excluding path
> > +				     - access with [gs]et_task_comm (which lock
> > +				       it with task_lock())
> > +				     - initialized normally by flush_old_exec */
>
> 1) comm is not necessarily the executable name, with sys_prctl =>
> PR_SET_NAME you can change the name arbitrarily
Ok, this can be added in the comment... however that's to give a meaning to 
it...
> 2) cbrowser shows alot of acccesses directly to ->comm, mostly under
> current->comm but a few that touch other processes. So this locking
> comment isn't really valid but may even confuse people.
Well, it's reverse-mapped from the comment about task_lock()... possibly those 
users don't care or 
> I really do value comments but I'm not sure about these.

Sorry for not answering promptly, I was busy and overlooked that you mailed me 
privately (I thought you cc'ed LKML and that nobody really cared, and after I 
forgot about this).
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


