Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131459AbQLMROa>; Wed, 13 Dec 2000 12:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131664AbQLMROT>; Wed, 13 Dec 2000 12:14:19 -0500
Received: from dhcp07.ncipher.com ([195.224.55.237]:8178 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S131459AbQLMROP>; Wed, 13 Dec 2000 12:14:15 -0500
From: David Howells <dhowells@redhat.com>
To: Christoph Rohland <cr@sap.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH,preliminary] cleanup shm handling 
In-Reply-To: Message from Christoph Rohland <cr@sap.com> 
   of "13 Dec 2000 14:52:23 +0100." <qwwvgsoig2w.fsf@sap.com> 
Date: Wed, 13 Dec 2000 16:43:25 +0000
Message-ID: <23640.976725805@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> There will be a 
> 
> struct file *shmem_file_setup(char * name, loff_t size)
> 
> which gives you an open sruct file to an unlinked file of size
> size. You can then do
> 
> down(&current->mm->mmap_sem);
> user_addr = (void *) do_mmap (file, addr, size, prot, flags, 0);
> up(&current->mm->mmap_sem);
> 
> with that struct file. You can look at shmget/shmat in ipc/shm.c. They
> use the same procedure form kernel space. 

Looks interesting.

There looks to be a logical mapping between CreateFileMapping() + MEM_SHARED
and your shmem_file_setup(), as long as anonymously named sections are catered
for (not difficult).

There also looks to be a logical mapping between MapViewOfFile() and how you
propose do_mmap() should be used.

At the moment, I have to do most of do_mmap for myself when
implementing CreateFileMapping() with SEC_IMAGE as a parameter since I need to
change the VMA ops table. But that only applies to where a file-backed PE
Image (EXE/DLL) is being mapped.

I'm not sure how shared sections in PE Images are handled on all versions of
Windows (ie: whether they are actually shared), but I image I could adapt your
mechanism for that too. I'd probably just have to create a SHMEM file and load
the backing data into it, and then use the SHMEM as the file to attach to the
VMA for that section (and then it's someone else's problem as far as swapping
is concerned).

If you want a look at what I've done, then you can find it at:

   ftp://infradead.org/pub/people/dwh/wineservmod-20001213.tar.bz2

It will hopefully be in CVS on winehq soon as well.

Look at the files called wineservmod/section* these implement the setting up
of VMAs in the current processes address space (though don't actually do the
page-in as yet).

David
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
