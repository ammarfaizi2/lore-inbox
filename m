Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVBVWBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVBVWBo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 17:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVBVWBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 17:01:44 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:9435 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261289AbVBVWB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 17:01:27 -0500
Message-ID: <421BAC7B.4030100@sgi.com>
Date: Tue, 22 Feb 2005 16:04:43 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Paul Jackson <pj@sgi.com>, ak@muc.de, raybry@austin.rr.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>, Jack Steiner <steiner@sgi.com>
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
 II
References: <20050217235437.GA31591@wotan.suse.de> <4215A992.80400@sgi.com> <20050218130232.GB13953@wotan.suse.de> <42168FF0.30700@sgi.com> <20050220214922.GA14486@wotan.suse.de> <20050220143023.3d64252b.pj@sgi.com> <20050220223510.GB14486@wotan.suse.de> <42199EE8.9090101@sgi.com> <20050221121010.GC17667@wotan.suse.de> <421AD3E6.8060307@sgi.com> <20050222180122.GO23433@wotan.suse.de>
In-Reply-To: <20050222180122.GO23433@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>OK, so what is the alternative?  Well, if we had a va_start and
>>va_end (or a va_start and length) we could move the shared object
>>once using a call of the form
>>
>>   migrate_pages(pid, va_start, va_end, count, old_node_list,
>>	new_node_list);
>>
>>with old_node_list = 0 1 2 ... 31
>>     new_node_list = 2 3 4 ... 33
>>
>>for one of the pid's in the job.
> 
> 
> I still don't like it. It would be bad to make migrate_pages another
> ptrace() [and ptrace at least really enforces a stopped process]
> 
> But I can see your point that migration DEFAULT pages with first touch
> aware applications pretty much needs the old_node, new_node lists.
> I just don't think an external process should mess with other processes
> VA. But I can see that it makes sense to do this on SHM that 
> is mapped into a management process.
> 
> How about you add the va_start, va_end but only accept them 
> when pid is 0 (= current process). Otherwise enforce with EINVAL
> that they are both 0. This way you could map the
> shared object into the batch manager, migrate it there, then
> mark it somehow to not be migrated further, and then
> migrate the anonymous pages using migrate_pages(pid, ...) 
>

There can be mapped files that can't be mapped into the migration task.
.
Here's an example (courtesy of Jack Steiner);

  	sprintf(fname, "/tmp/tmp.%d", getpid());
  	unlink(fname);
  	fd = open(fname, O_CREAT|O_RDWR);
  	p = mmap(NULL, bytes, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
  	close(fd);
  	unlink(fname);
  	/* "p" remains valid until unmapped */

The file /tmp/tmp.pid is both mapped and deleted.  It can't be opened
by another process to mmap() it, so it can't be mapped into the
migration task AFAIK how to do things.  The file does show up in 
/proc/pid/maps as shown below (pardon the line splitting):

2000000000270000-2000000000278000 rw-p 00200000 08:13 75498728  \ 
/lib/tls/libc.so.6.1
2000000000278000-2000000000284000 rw-p 2000000000278000 00:00 0
2000000000300000-2000000000c8c000 rw-s 00000000 08:13 100885287 \ 
/tmp/tmp.18259 (deleted)
4000000000000000-4000000000008000 r-xp 00000000 00:2a 14688706  \ 
/home/tulip14/steiner/apps/bigmem/big

Jack says:

"This is a fairly common way to work with scratch map'ed files. Sites that
have very large disk farms but limited swap space frequently do this (or at 
least they use to...)"

So while I tend to agree with your concern about manipulating
one process's address space from another, I honestly think we
are stuck, and I don't see a good way around this.

> BTW it might be better to make va_end a size, just to be more
> symmetric with mlock,madvise,mmap et.al.
> 

Yes, I agree.  Let's make that so.

> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------
