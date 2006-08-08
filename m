Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbWHHRmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbWHHRmV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 13:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbWHHRmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 13:42:21 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:54190 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S965015AbWHHRmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 13:42:20 -0400
Subject: Re: How to lock current->signal->tty
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Eric Paris <eparis@redhat.com>, Al Viro <viro@ftp.linux.org.uk>,
       James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
       davem@redhat.com, jack@suse.cz, dwmw2@infradead.org,
       tony.luck@intel.com, jdike@karaya.com,
       James.Bottomley@HansenPartnership.com
In-Reply-To: <1155058994.5729.99.camel@localhost.localdomain>
References: <1155050242.5729.88.camel@localhost.localdomain>
	 <1155057114.1123.97.camel@moss-spartans.epoch.ncsc.mil>
	 <1155058994.5729.99.camel@localhost.localdomain>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 08 Aug 2006 13:44:06 -0400
Message-Id: <1155059046.1123.120.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-08 at 18:43 +0100, Alan Cox wrote:
> Ar Maw, 2006-08-08 am 13:11 -0400, ysgrifennodd Stephen Smalley:
> > Does this look sane?  Or do we need a common helper factored from
> > disassociate_ctty()?  Why is the locking different for TIOCNOTTY in the
> > non-leader case?
> 
> The non-leader case for TIOCNOTTY in the base kernel is different
> because it is wrong and I've fixed that one.
> 
> If you can factor disassociate_ctty out to do what you need I'd prefer
> that path so the tty locking actually ends up in the tty layer.
> 
> > +	mutex_lock(&tty_mutex);
> > +	tty = current->signal->tty;
> >  	if (tty) {
> >  		file_list_lock();
> 
> Looks sane and the lock ordering matches vhangup() which may actually
> also do what you want - I'm not 100% sure I follow what SELinux tries to
> do here.

SELinux is just revalidating access to the tty when the task changes
contexts upon execve, and resetting the tty if the task is no longer
allowed to use it.  Likewise with the open file descriptors that would
be inherited.  No clearing of the ttys of other tasks required as far as
SELinux is concerned, although that might not fit with normal semantics.
  
-- 
Stephen Smalley
National Security Agency

