Return-Path: <linux-kernel-owner+w=401wt.eu-S965050AbXALT2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbXALT2S (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 14:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbXALT2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 14:28:18 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:60797 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965050AbXALT2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 14:28:17 -0500
Date: Fri, 12 Jan 2007 13:28:12 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Mimi Zohar <zohar@us.ibm.com>,
       akpm@osdl.org, kjhall@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
       safford@watson.ibm.com
Subject: Re: mprotect abuse in slim
Message-ID: <20070112192812.GC10445@sergelap.austin.ibm.com>
References: <OFE2C5A2DE.3ADDD896-ON8525725D.007C0671-8525725D.007D2BA9@us.ibm.com> <1168312045.3180.140.camel@laptopd505.fenrus.org> <20070109094625.GA11918@infradead.org> <20070109231449.GA4547@sergelap.austin.ibm.com> <84144f020701120145r13d5d7bbndf652692f729ad9d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f020701120145r13d5d7bbndf652692f729ad9d@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pekka Enberg (penberg@cs.helsinki.fi):
> On 1/10/07, Serge E. Hallyn <serue@us.ibm.com> wrote:
> >Now, what slim needs isn't "revoke all files for this inode",
> >but "revoke this task's write access to this fd".  So two functions
> >which could be useful are
> >
> >        int fd_revoke_write(struct task_struct *tsk, int fd)
> >        int fd_revoke_write_iter(struct task_struct *tsk,
> >                        (int *)need_revoke(struct task_struct *tsk, int 
> >                        fd))
> 
> This gets interesting. We probably need revokefs (which we use
> internally as a substitute for revoke inodes) to be stacked on top of
> the actual fs so that you can still read from the fd. But most of the
> revocation is still the same, we need to watch out for fork(2) and
> dup(2) and take down shared mappings.

Hmm, would revokefs need to be explicitly stacked on top of the fs,
or could we just swap out fdt[fd] for the revokefs file, and have
the revokefs file's private data point to the original inode, with
it's write function returning an error, and read being passed through?

Do you (or hch) then have a problem with these functions (sitting either
in fs/revoke.c or fs/file_table.c) calling mprotect to remove the write
permission from the mmap'ed segment?  i.e. was the main objection to
mprotect being called from "just anywhere"?

-serge
