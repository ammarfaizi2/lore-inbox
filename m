Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWAQRRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWAQRRj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 12:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWAQRRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 12:17:39 -0500
Received: from smtpout.mac.com ([17.250.248.88]:64448 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932211AbWAQRRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 12:17:38 -0500
In-Reply-To: <1137513818.14135.23.camel@localhost.localdomain>
References: <20060117143258.150807000@sergelap> <20060117143326.283450000@sergelap> <1137511972.3005.33.camel@laptopd505.fenrus.org> <20060117155600.GF20632@sergelap.austin.ibm.com> <1137513818.14135.23.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EF8F3CA7-3EB0-49FE-A51A-2A0DC020681D@mac.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       LKML Kernel <linux-kernel@vger.kernel.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
Date: Tue, 17 Jan 2006 12:16:12 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 17, 2006, at 11:19, Suleiman Souhlal wrote:
> Why does there need a separate pid space for each container?  You  
> don't really need one to make sure that only processes in the same  
> containers can see each other.

On Jan 17, 2006, at 11:03, Alan Cox wrote:
> This is an obscure, weird piece of functionality for some special  
> case usages most of which are going to be eliminated by Xen. I  
> don't see the kernel side justification for it at all.
>
> Maybe you should remap it the other side of the user->kernel  
> boundary ?

To answer both questions at the same time, this is to make it  
practical to reliably freeze and restore whole process-trees/jobs,  
possibly restarting or migrating to a different computer in-between.   
Such freeze/restore code is mostly possible now, except for programs  
that store a pid internally to send a signal to another process.  The  
usage would be something like this:

start:
	create container:
		run jobs

freeze
	for each process/thread in the container:
		send SIGSTOP to halt execution
	for each process in the container:
		store process data, filehandles, vpid, etc

restore:
	create container:
		iterate over the frozen processes in the freeze file:
			clone_with_pid(flags, original_vpid);
			adjust session, connect filehandles, etc
			remap shared memory, etc
			block on atomic "resume" variable in mmap-ed file
		
		set "resume" to 1

The end result is that you could freeze and resume _any_ process tree  
in a container, even ones that do weird things with filehandles,  
sockets, pids, etc.  Personally I would find this useful to migrate  
an extensive memory-leak-debugging session in a large application  
over from laptop to desktop or vice versa.  You could also freeze/ 
migrate/restore a whole X session (not including the X process  
itself, but all the client apps).  You could not do this at all for  
statically-linked applications without kernel support, and it would  
be rather inefficient to do even for dynamically-linked ones.

The one other option would be to allow opening a file /proc/$PID/ 
control, to which you could write a signal number, and require  
freezable programs to use that interface to reliably send signals  
(This also makes signals non-racy if you're reusing all 60000+ pids  
on a regular basis).  This has the disadvantage of not even working  
for existing dynamically-linked programs either..

Cheers,
Kyle Moffett

--
There is no way to make Linux robust with unreliable memory  
subsystems, sorry.  It would be like trying to make a human more  
robust with an unreliable O2 supply. Memory just has to work.
   -- Andi Kleen


