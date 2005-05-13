Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262275AbVEMXNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbVEMXNb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 19:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262615AbVEMXMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 19:12:01 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:3804 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262452AbVEMXLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 19:11:07 -0400
In-Reply-To: <E1DWVby-0000zz-00@dorka.pomaz.szeredi.hu>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: bulb@ucw.cz, ericvh@gmail.com, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com
MIME-Version: 1.0
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF61E069CA.D46E38EE-ON88257000.00738E9B-88257000.007F4E51@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Fri, 13 May 2005 16:09:59 -0700
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V70_04122005|April 12, 2005) at
 05/13/2005 19:11:02,
	Serialize complete at 05/13/2005 19:11:02
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>For ptrace the definition is:
>     If the tracee has different privileges, than the tracer, than it
>     can't be traced.
> For this definition, the check is not a hack. It's the only way to go.

I agree this is the proper goal for ptrace and this code is not a hack. 
It's a bug.  In Linux, uid, euid, suid, gid, egid, and sgid do not by 
themselves determine privileges.  And that's what ptrace checks.  The main 
determiner of basic privileges is the process capabilities.  The euid, 
etc. do also.   I have frequently have on my system a process that runs 
with the same uid, euid, etc. as some other process, but should not be 
allowed to ptrace it because the tracee has CAP_DAC_OVERRIDE (the 
privilege to access files in spite of file permissions) and the tracer 
does not.  (Furthermore, the tracee got that privilege courtesy of a 
set-uid file, but as we seem to agree, that is not relevant here).

So as with the user space programs I mentioned (where the euid check is 
indeed a hack), I have to fix ptrace too.  Fortunately, it looks as simple 
as comparing capability sets.

> Now this definition is really what is needed for the filesystem case
> too, so I think it's not a hack either. 

Maybe I got lost in the problem we were trying to solve, then.  What does 
comparing the privileges of one process with those of another have to do 
with this thread about making safe unprivileged mounts via namespaces? The 
post to which I replied said we have to deal with set-uid programs. Aren't 
we talking about the problem where someone sets a file's setuid flag on 
with the assumption that when the program within runs, it will see certain 
files at certain places?  And the fact that if one could mount whatever he 
wants, that would violate the assumption?  The two ways suggested of 
handling that are: 1) after the private mount, ignore all setuid flags. 2) 
after the private mount, don't let a program that has gained privileges 
via set-uid see the user-made names.

My point is still that (2) can't be done because you can't know that a 
program has gained privileged via set-uid.

If it's really not about set-uid, but about ptrace-like privilege 
borrowing, please enlighten me.

--
Bryan Henderson                          IBM Almaden Research Center
San Jose CA                              Filesystems

