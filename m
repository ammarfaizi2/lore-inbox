Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314459AbSEPR2B>; Thu, 16 May 2002 13:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314465AbSEPR2A>; Thu, 16 May 2002 13:28:00 -0400
Received: from ns.suse.de ([213.95.15.193]:51722 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314459AbSEPR17>;
	Thu, 16 May 2002 13:27:59 -0400
Date: Thu, 16 May 2002 19:27:59 +0200
From: Andi Kleen <ak@suse.de>
To: Mark Gross <mgross@unix-os.sc.intel.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: PATCH Multithreaded core dump support for the 2.5.14 (and 15) kernel.
Message-ID: <20020516192759.A5326@wotan.suse.de>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C057B485B@orsmsx111.jf.intel.com.suse.lists.linux.kernel> <200205152353.g4FNrew30146@unix-os.sc.intel.com.suse.lists.linux.kernel> <p73it5oz21j.fsf@oldwotan.suse.de> <200205161714.g4GHE3w02908@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2002 at 10:13:40AM -0400, Mark Gross wrote:
> Also, does anyone know WHY the mmap_sem is needed in the elf_core_dump code, 
> and is this need still valid if I've suspended all the other processes that 
> could even touch that mm?  I.e. can I fix this by removing the down_write / 
> up_write in elf_core_dump?

The mmap_sem is needed to access current->mm (especially the vma list)
safely. Otherwise someone else sharing the mm_struct could modify it. 
If you make sure all others sharing the mm_struct are killed first 
(including now way for them to start new clones inbetween) then
the only loophole left would be remote access using /proc/pid/mem or ptrace. 
If you handle that too then it is probably safe to drop it. Unfortunately
I don't see a way to handle these remote users without at least 
taking it temporarily.

Of course there are other semaphores in involved in dumping too (e.g. the
VFS ->write code may take the i_sem or other private ones). I guess they 
won't be a big problem if you first kill and then dump later.

-Andi

