Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266117AbUIIUu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266117AbUIIUu3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 16:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266073AbUIIUuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 16:50:09 -0400
Received: from imr2.ericy.com ([198.24.6.3]:8671 "EHLO imr2.ericy.com")
	by vger.kernel.org with ESMTP id S266136AbUIIUt0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 16:49:26 -0400
Message-ID: <4140BFCE.8010701@ericsson.com>
Date: Thu, 09 Sep 2004 16:40:46 -0400
From: Makan Pourzandi <Makan.Pourzandi@ericsson.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Serge E. Hallyn" <hallyn@CS.WM.EDU>
CC: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       Axelle Apvrille <axelle.apvrille@trusted-logic.fr>, serue@us.ibm.com,
       david.gordon@ericsson.com, gaspoucho@yahoo.com
Subject: Re: [ANNOUNCE] Release Digsig 1.3.1: kernel module for run-time authentication
 of binaries
References: <41407CF6.2020808@ericsson.com> <20040909092457.L1973@build.pdx.osdl.net> <41409378.5060908@ericsson.com> <20040909105520.U1924@build.pdx.osdl.net> <20040909190511.GB28807@escher.cs.wm.edu>
In-Reply-To: <20040909190511.GB28807@escher.cs.wm.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Serge E. Hallyn wrote:
> Quoting Chris Wright (chrisw@osdl.org):
> 
>>* Makan Pourzandi (Makan.Pourzandi@ericsson.com) wrote:
> 
> ...
> 
>>>We realized that when a shared library is opened by a binary it can 
>>>still be modified. To solve the problem, we block the write access to 
>>>the shared binary while it is loaded.
>>
>>AFAICT, this means anybody with read access to a file can block all
>>writes.  This doesn't sound great.
> 
> 
> True.
> 

I want to narrow down the discussion, I believe that some people could 
get confused with the mention of "file" here. AFAICT, the above problem 
only concerns the shared libraries. Digsig applies only to binaries: in 
digsig_file_mmap() implementing the file_mmap LSM hook, if the file is 
not executable there is a return and no verification or any other 
blocking is done.

For executables, there is no meaning to load them on read mode, you 
should have execute permission. if you then load them for execution 
IMHO, it makes sense to block the writing on that file.

For shared libraries, you're right. the problem exists, the shared 
libraries can be loaded being only readable (even though I remember 
reading in exec.c:sys_uselib() kernel 2.6.8.1 that the shared libraries 
must be both readable and executable due to "security reasons", but I'm 
not an expert and definitely readable is enough to load the shared 
library but I'll be happy to learn more about this.)

> This could be fixed by adding a check at the top of dsi_file_mmap for
> file->f_dentry->d_inode->i_mode & MAY_EXEC.  Of course then shared
> libraries which are installed without execute permissions will cause
> apps to break.  On my quick test, I couldn't run xterm or vi  :)
> 
> Note that blocking writes requires that the file be a valid ELF file,
> as this is all that digsig mediates.  So I'm not sure which we worry
> about more - the fact that all shared libraries have to be installed
> with execute permissions (under the proposed solution), or that write


My 2 cents, a quick browsing on my machine (fedora core 1) shows that 
almost all my shared libraries are installed with both execution and 
read permissions.  IMHO, I don't believe then that this should be 
considered as a major issue.


> to an ELF file can be prevented by mmap(PROT_EXEC).  Presumably, if

Regards,
Makan

> you are replacing an ELF file, you will always want to do 
> "mv foo.so foo.so.del; cp new/foo.so foo.so" anyway.
> 
> Thoughts?
> 
> thanks,
> -serge
> 

-- 

Makan Pourzandi, Open Systems Lab
Ericsson Research, Montreal, Canada
*This email does not represent or express the opinions of Ericsson Inc.*

