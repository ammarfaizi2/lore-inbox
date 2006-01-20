Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWATUXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWATUXm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 15:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWATUXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 15:23:42 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:50384 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932166AbWATUXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 15:23:41 -0500
Date: Fri, 20 Jan 2006 14:23:39 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Serge Hallyn <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 00/34] PID Virtualization Overview
Message-ID: <20060120202339.GB13265@sergelap.austin.ibm.com>
References: <1137517698.8091.29.camel@localhost.localdomain> <43CD32F0.9010506@FreeBSD.org> <1137521557.5526.18.camel@localhost.localdomain> <1137522550.14135.76.camel@localhost.localdomain> <1137610912.24321.50.camel@localhost.localdomain> <1137612537.3005.116.camel@laptopd505.fenrus.org> <1137613088.24321.60.camel@localhost.localdomain> <1137624867.1760.1.camel@localhost.localdomain> <1137654906.2993.10.camel@laptopd505.fenrus.org> <m1k6cvo555.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1k6cvo555.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> Arjan van de Ven <arjan@infradead.org> writes:
> 
> > On Wed, 2006-01-18 at 22:54 +0000, Alan Cox wrote:
> >> On Mer, 2006-01-18 at 11:38 -0800, Dave Hansen wrote:
> >> > But, it seems that many drivers like to print out pids as a unique
> >> > identifier for the task.  Should we just let them print those
> >> > potentially non-unique identifiers, deprecate and kill them, or provide
> >> > a replacement with something else which is truly unique?
> >> 
> >> Pick a format for container number + pid and document/stick with it -
> >> something like container::pid (eg 0::114) or 114[0] whatever so long as
> >> it is consistent
> >
> > having a pid_to_string(<task struct>) or maybe task_to_string() thing
> > for convenient printing of pids/tasks.. I'm all for that. Means you can
> > even configure how verbose you want it to be (include ->comm or not,
> > ->state maybe etc)
> 
> The only way I can see to sanely do this is to pass it the temporary
> buffer it writes it's contents into.
> Something like:
> printk(KERN_XXX "%s\n", task_to_string(buf, tsk)); ?

That's kind of neat :)

The only other thing I can think of is to do something like

#define task_str(tsk) tsk->container_id, tsk->pid
or
#define task_str(tsk) tsk->container_id, ":", tsk->pid

and have it be used as

printk(KERN_XXX "%s::%s\n", task_str(tsk));
or
printk(KERN_XXX "%s%s%s\n", task_str(tsk));

The only reason I point it out is that we don't risk memory corruption
if the printk caller forgets to give the extra '%s's, like we do if
the caller forgets they need char buf[PID_CONTAINER_MAXLENGTH] instead
of 'char *buf;' or 'char buf;'.

-serge
