Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267736AbTCFDmT>; Wed, 5 Mar 2003 22:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267761AbTCFDmT>; Wed, 5 Mar 2003 22:42:19 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:45277
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S267736AbTCFDmQ>; Wed, 5 Mar 2003 22:42:16 -0500
Message-ID: <3E66C644.2020300@redhat.com>
Date: Wed, 05 Mar 2003 19:53:40 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030303
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Better CLONE_SETTLS support for Hammer
References: <3E664836.7040405@redhat.com> <20030305190622.GA5400@wotan.suse.de> <3E6650D4.8060809@redhat.com> <20030305212107.GB7961@wotan.suse.de> <3E668267.5040203@redhat.com> <20030306010517.GB17865@wotan.suse.de>
In-Reply-To: <20030306010517.GB17865@wotan.suse.de>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andi Kleen wrote:

> You want the change, not me ;)

But I cannot test it since the kernel doesn't work.


> It should already work on the current kernel, modulo clone.
> (but arch_prctl, set_thread_area in 2.5, ldt in 2.4 etc.) 

I cannot confirm this.  I wasted a lot of time on getting it to work.
Without avail.


> It's needed for 32bit emulation at least. The code is 100% shared
> between the emulation and the native 64bit model.
> In theory it could be removed from the system call table for 64bit
> but there didn't seem a good reason to do so - after all 64bit programs
> can put their thread local data into the first 4GB and 
> fast context switches.
> 
> 
>>the use of prctl to get and set the base address.  Then internally in
>>the prctl call map it to either the use of a 32 base address segment or
>>use the MSR.
> 
> 
> The problem is that the 64bit base has different semantics. 
> 
> When you use a segment register you have to do:
> 
> 	call kernel to set gdt/ldt
> 	movl index,%%fs
> 
> But when the kernel did set the 64bit base in the kernel call the
> following movl to the selector would destroy it again
> 
> Loading the index inside the system call would also be problematic:
> First it would be different from what i386 does, causing porting headaches.
> Also you could not easily do it from a different thread unlike the 
> LDT load.
> 	
> 
> 
>>This way whoever needs a segment base address can preferably allocate it
>>in the low 4GB, but if it fails the kernel support still work.  And with
>>the same interface.  Currently this is not the case and this is not
>>acceptable.
> 
> 
> That should already work and it is in fact how I imagined this to be: 
> 
> do MAP_32BIT - if yes use set_thread_area or an LDT entry;
> 
> if not use arch_prctl
> 
> The NPTL signal race problem for the clones in case you have a 64bit
> base is a bit ugly though I agree.
> 
> I don't like your patch currently because it'll guarantee slow 
> context switch times for 64bit.
> 
> Automatic switching based on the set bits in the base may be possible 
> (in fact I had something like this in set_thread_area for some time, but 
> removed it because of the ugly semantics because set_thread_area doesn't
> already load the selector). If the selector load is forced
> in clone however it would not be as weird, just only somewhat
> ugly. You'll have to guarantee in user space then that you don't
> reload it.
> 
> Real solution would be Windowish - Create clone7() with both
> selectors and bases 
> 
> [I suspect 2.8 and 3.0 will get that anyways as experience
> on other operating systems who started on the same path 
> shows. e.g. AmigaOS grew more CreateTask
> variants with more arguments with each release until they eventually
> settled on passing tag lists.]
> 
> -Andi
> 


- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+ZsZE2ijCOnn/RHQRAphoAJ9YRohA3FrNkAWrTlk0nigBj1/NCwCdGmkR
uxv9VRkBY//SftCcmk2KwgQ=
=W1al
-----END PGP SIGNATURE-----

