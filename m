Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWDSX3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWDSX3S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 19:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWDSX3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 19:29:18 -0400
Received: from ns1.suse.de ([195.135.220.2]:404 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751326AbWDSX3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 19:29:17 -0400
Date: Wed, 19 Apr 2006 16:24:44 -0700
From: Tony Jones <tonyj@suse.de>
To: Valdis.Kletnieks@vt.edu
Cc: Crispin Cowan <crispin@novell.com>, Arjan van de Ven <arjan@infradead.org>,
       Karl MacMillan <kmacmillan@tresys.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, James Morris <jmorris@namei.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
Message-ID: <20060419232444.GA32096@suse.de>
References: <E1FVtPV-0005zu-00@w-gerrit.beaverton.ibm.com> <1145381250.19997.23.camel@jackjack.columbia.tresys.com> <44453E7B.1090009@novell.com> <1145389813.2976.47.camel@laptopd505.fenrus.org> <44468258.1020608@novell.com> <200604191850.k3JIoeYb015907@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604191850.k3JIoeYb015907@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 02:50:40PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 19 Apr 2006 11:32:56 PDT, Crispin Cowan said:
> 
> > AppArmor initially validates your access at open time, and there after
> > you can read&write to it without mediation. AppArmor re-validates your
> > access if policy is reloaded, you exec() a new program, you get passed
> > the fd from another process, or you call our change_hat() API.
> > 
> > So, if the file is unlinked or renamed while you have it open, and
> > policy says you don't have access to the new name, then:
> > 
> >     * within the same process you get to keep accessing it until
> >           o policy is reloaded by the administrator
> >           o you call the change_hat() API
> >     * in some other process, either a child or some process you passed
> >       an fd to, you don't get to access it because your access gets
> >       revalidated
> 
> My brain is small, and my eyes glaze over easily... ;)

Join the club :)

> What happens for the following sequence:
> 
> a) Process A does   fd = open("/some/protected");
> b) Somebody then does an unlink("/some/protected");
> c) A then does a fork/exec, handing the exec'ed process B the open FD 
> as its stdin.

I just wrote the following which I believe is your test scenario?

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

int main()
{
int fd, err, pid;

	fd = open("/tmp/protected", O_RDONLY);
	if (fd == -1){
		perror("open") ; return 1;
	}

	err=unlink("/tmp/protected");
	if (err == -1){
		perror("unlink"); close(fd); return 1;
	}

	pid=fork();

	if (pid){
		wait();
	}else{
		close(0);
		dup(fd);

		execl("/bin/cat", "/bin/cat", NULL);
	}

	close(fd);
}

d_path reports "/tmp/protected (deleted)" for the dentry in this situation 
when /bin/cat attempts to access it.

It happens a lot with nscd which likes to open files, unlink them and pass
them over unix domain sockets.  Our old code used to have to remove the 
(deleted) [in a safe manner of course]. With the posted patch to d_path to
generate pathnames back to the namespace root I took advantage of including
some control of the appending for unhashed dentries.

> What name do you use to re-validate B's access to the data described by
> the inode that open file is referencing?

Now how you handle what confinement the forked process should have is 
determined when you generate policy. /bin/cat in this situation can run under
it's own policy (probably not ideal in this situation), inherit the openers
(probably the ideal choice), or none at all (if you believe it does not
require confinement).

> Note that although B can't get any access to the data that A didn't have,
> it can still be used to bypass security, because B may be able to *copy* that
> data to an area where A couldn't write (presumably because A is in a confined box).

I'm not sure how.  Perhaps with the above example you can elaborate as 
necessary.  Also thanks for posting the question.

Tony
