Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbVKJJYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbVKJJYi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 04:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbVKJJYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 04:24:38 -0500
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:65440 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750717AbVKJJYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 04:24:37 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 10 Nov 2005 09:24:32 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Paulo da Silva <psdasilva@esoterica.pt>
cc: linux-kernel@vger.kernel.org
Subject: Re: Accessing file mapped data inside the kernel
In-Reply-To: <4372A5F6.7030306@esoterica.pt>
Message-ID: <Pine.LNX.4.64.0511100918490.25186@hermes-1.csi.cam.ac.uk>
References: <437258CD.8060206@esoterica.pt> <Pine.LNX.4.64.0511092143400.19282@hermes-1.csi.cam.ac.uk>
 <4372A5F6.7030306@esoterica.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2005, Paulo da Silva wrote:
> Anton Altaparmakov wrote:
> > On Wed, 9 Nov 2005, Paulo da Silva wrote:
> > > I posted about this a few days ago but got no responses
> > > so far! I think this should be a trivial question for those
> > > involved in the kernel internals. May be I didn't develop
> > > the problem enough to be understood.
> > > 
> > > So, here is the question reformulated.
> > > 
> > > A given file system must supply a procedure for mmap.
> > > 
> > > int <fsname>_file_mmap(struct file * file, struct vm_area_struct * vma)
> > > {
> > >  int addr;
> > >  addr=generic_file_mmap(file,vma);
> > >  <Code to access addr pointed bytes or vma->vm_start>
> > >  return addr;
> > > }
> > > 
> > > I could verify that "addr" is what is returned to the user as
> > > a pointer to a string of bytes that maps a file when a user
> > > program calls mmap or mmap2.
> > > 
> > > In the user program, I can access those bytes (read/write)
> > > as, for ex., a char pointer.
> > > 
> > > I don't know how to access those bytes inside the kernel
> > > at the point <Code to access addr pointed bytes or vma->vm_start>
> > > 
> > > First trys led the program that invoked mmap to block.
> > > I thought that there's something to do with a previous
> > >   down_write(&current->mm->mmap_sem);
> > > If I execute
> > >   up_write(&current->mm->mmap_sem);
> > > before accessing the data the block situation does not
> > > occur anymore. I would like to hear something about
> > > this.
> > > 
> > > Anyway, I tryed to use "copy_from_user" but I got
> > > garbage, not the file contents! Using "strncpy" crashes
> > > the kernel (UML)!
> > > 
> > > Can someone please write a fragment of code to safely
> > > access those bytes, copying them to and from a
> > > kernel char pointed area so that they are read/written
> > > to the file?
> > 
> > Why do you want to do that?  If you explain what you are trying to do it may
> > be possible to help you better.  It is almost 100% certain that your are
> > going about it in completely the wrong way, so please describe what you are
> > trying to do...
> >  
> Just try to understand the kernel filesystem.
> So far I could understand the 1st layer of
> reading and writing. mmap seems to be a
> difficult task however. So, I made a 1st try
> looking at mmap supplied by the filesystem,
> but I couldn't even succeed with a printk
> of the mapped area! I would like to understand
> what is the meaning of the address (int) returned
> by generic_file_mmap that is also into vma->vm_start
> and is returned to the user as a char pointer.
> I thought that this address, being accessible
> by a user program as a char pointer, should also
> be accessible by a copy-from-user inside the
> kernel. Unfortunately, this didn't happen!
> Why? That's my question. Did I make any mistake?
> A basic fragment of code showing how to access
> that area could enlight me so that I could go
> deeply into the code.
> 
> Ex.
> Suppose a file has a string of text ("foo")
> and the user calls mmap.
> 
> Why does this code not work?
> 
> The supplied filesystem mmap is "generic_file_mmap".
> So, I changed it to foo_file_mmap as follows:
> 
> int foo_file_mmap(struct file * file, struct vm_area_struct * vma)
> {
> 
>  int addr;
>  char tstr[100];
>  addr=generic_file_mmap(file,vma);
>  up_write(&current->mm->mmap_sem); /* Without this the user program is dead
> locked */
>  copy_from_user(tstr,(char*)addr,4);
>  printk("%s",tstr);
> 
>  return addr;
> }

That's what I thought.  You are doing completely the wrong thing.  mmap() 
does not read anything, it just creates the page tables.  Only after that, 
when the user tries to access the memory, does a page fault occur (because 
the page does not exist) and the page fault handler kicks in which leads 
to the file system's ->readpage() being called which fills the accessed 
page with data.  Subsequent accesses to the same address (or any other 
address belonging to the same page) are direct memory accesses.  When the 
user tries to access an address outside the page, another page fault 
occurs and the page corresponding to the new address is faulted in, etc...

So what you are trying to do makes no sense from a kernel point of view at 
all.  If you want to read page cache data in the kernel (this is what you 
are actually trying to do but going about it in the wrong way), you want 
to use read_cache_page(), then kmap() or kmap_atomic() of the page, then 
access the data, then kunmap() or kunmap_atomic(), then finally 
page_cache_release().

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
