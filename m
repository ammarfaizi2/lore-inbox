Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWEPOaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWEPOaK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 10:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWEPOaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 10:30:10 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:2710 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751147AbWEPOaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 10:30:08 -0400
Message-ID: <4469E1AF.7040908@t-online.de>
Date: Tue, 16 May 2006 16:29:03 +0200
From: Bernd Schmidt <bernds_cb1@t-online.de>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, torvalds@osdl.org, luke.yang@analog.com,
       gerg@snapgear.com
Subject: Re: Please revert git commit 1ad3dcc0
References: <4469B63B.6000502@t-online.de> <20060516065848.13028f9f.akpm@osdl.org>
In-Reply-To: <20060516065848.13028f9f.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: ZqavgkZcYeTIJCnBsBNufjBihAnUS5T4-o6dvvChhRqoo0t8Uj6tcp
X-TOI-MSGID: 50c8b0ff-5f6b-4663-8e89-16a714690250
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Bernd Schmidt <bernds_cb1@t-online.de> wrote:
>> please revert 1ad3dcc0.  That was a patch to the binfmt_flat loader, 
>> which was motivated by an LTP testcase which checks that execve returns 
>> EMFILE when the file descriptor table is full.
>>
>> The patch is buggy: the code now keeps file descriptors open for the 
>> executable and its libraries, which has confused at least one 
>> application.  It's also unnecessary, since there is no code that uses 
>> the file descriptor, so the new EMFILE error return is totally artificial.

> I don't get it.  The substance of the patch is
> 
> +	/* check file descriptor */
> +	exec_fileno = get_unused_fd();
> +	if (exec_fileno < 0) {
> +		ret = -EMFILE;
> +		goto err;
> +	}
> +	get_file(bprm->file);
> +	fd_install(exec_fileno, bprm->file);
> 
> and that get_file() will be undone by exit().  Without this change we'll
> forget to do file limit checking.

It's not the get_file that's the problem, it's the get_unused_fd and 
fd_install.  These files are now open while the process lives and 
consume file descriptors.  This does not happen with the ELF loader, 
which does

         if (interpreter_type != INTERPRETER_AOUT)
                 sys_close(elf_exec_fileno);

before transferring control to the application.  So, fewer file 
descriptors are available for the app, and they start at a higher number.

Before the change, we didn't allocate or install a file descriptor, 
hence there wasn't any reason to return EMFILE.  The spec at
   http://www.opengroup.org/onlinepubs/009695399/functions/exec.html
doesn't list EMFILE as a possible error.

If you're unconvinced, then at the very least we need to add a sys_close 
call in the success path.


Bernd
