Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291402AbSBHFF5>; Fri, 8 Feb 2002 00:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291414AbSBHFFr>; Fri, 8 Feb 2002 00:05:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7690 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291402AbSBHFFn>;
	Fri, 8 Feb 2002 00:05:43 -0500
Message-ID: <3C635C81.A7635551@zip.com.au>
Date: Thu, 07 Feb 2002 21:05:05 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Manfred Spraul <manfred@colorfullife.com>,
        Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [patch] VM_IO fixes
In-Reply-To: <3C621B44.10C424B9@zip.com.au> <Pine.LNX.4.33.0202071259510.5900-100000@serv> <3C62E8D6.9FDAF382@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Is there a fast and portable way of doing this?
> 

Seems that there isn't.

Here's what I have.  We allow coredumps and ptrace peeking of:

- file mappings
- sysv ipc mappings
- shmem mappings
- /dev/mem if the mapping is page_struct backed
- /dev/kmem
- /dev/zero mappings
- socket mappings
- ftape's dma buffer
- many audio card DMA buffers
- videodev dma buffer mappings

Is anything missing?

--- linux-2.4.18-pre9/mm/mmap.c	Mon Nov  5 21:01:12 2001
+++ linux-akpm/mm/mmap.c	Thu Feb  7 19:21:02 2002
@@ -534,6 +534,11 @@ munmap_back:
 		}
 		vma->vm_file = file;
 		get_file(file);
+		/*
+		 * Subdrivers can clear VM_IO if their mappings are
+		 * valid pages inside mem_map[]
+		 */
+		vma->vm_flags |= VM_IO;
 		error = file->f_op->mmap(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
--- linux-2.4.18-pre9/mm/filemap.c	Thu Feb  7 13:04:22 2002
+++ linux-akpm/mm/filemap.c	Thu Feb  7 19:21:02 2002
@@ -2111,6 +2111,7 @@ int generic_file_mmap(struct file * file
 		return -ENOEXEC;
 	UPDATE_ATIME(inode);
 	vma->vm_ops = &generic_file_vm_ops;
+	vma->vm_flags &= ~VM_IO;
 	return 0;
 }
 
--- linux-2.4.18-pre9/fs/ncpfs/mmap.c	Mon Sep 10 09:04:53 2001
+++ linux-akpm/fs/ncpfs/mmap.c	Thu Feb  7 19:21:02 2002
@@ -119,5 +119,6 @@ int ncp_mmap(struct file *file, struct v
 	}
 
 	vma->vm_ops = &ncp_file_mmap;
+	vma->vm_flags &= ~VM_IO;
 	return 0;
 }
--- linux-2.4.18-pre9/ipc/shm.c	Fri Dec 21 11:19:23 2001
+++ linux-akpm/ipc/shm.c	Thu Feb  7 19:21:02 2002
@@ -159,6 +159,7 @@ static int shm_mmap(struct file * file, 
 {
 	UPDATE_ATIME(file->f_dentry->d_inode);
 	vma->vm_ops = &shm_vm_ops;
+	vma->vm_flags &= ~VM_IO;
 	shm_inc(file->f_dentry->d_inode->i_ino);
 	return 0;
 }
--- linux-2.4.18-pre9/mm/shmem.c	Fri Dec 21 11:19:23 2001
+++ linux-akpm/mm/shmem.c	Thu Feb  7 19:21:02 2002
@@ -657,6 +657,7 @@ static int shmem_mmap(struct file * file
 		return -EACCES;
 	UPDATE_ATIME(inode);
 	vma->vm_ops = ops;
+	vma->vm_flags &= ~VM_IO;
 	return 0;
 }
 
--- linux-2.4.18-pre9/drivers/char/mem.c	Fri Dec 21 11:19:13 2001
+++ linux-akpm/drivers/char/mem.c	Thu Feb  7 12:42:19 2002
@@ -198,10 +198,10 @@ static int mmap_mem(struct file * file, 
 	vma->vm_flags |= VM_RESERVED;
 
 	/*
-	 * Don't dump addresses that are not real memory to a core file.
+	 * Dump addresses that are real memory to a core file.
 	 */
-	if (offset >= __pa(high_memory) || (file->f_flags & O_SYNC))
-		vma->vm_flags |= VM_IO;
+	if (offset < __pa(high_memory) && !(file->f_flags & O_SYNC))
+		vma->vm_flags &= ~VM_IO;
 
 	if (remap_page_range(vma->vm_start, offset, vma->vm_end-vma->vm_start,
 			     vma->vm_page_prot))
@@ -473,6 +473,7 @@ static int mmap_zero(struct file * file,
 		return shmem_zero_setup(vma);
 	if (zeromap_page_range(vma->vm_start, vma->vm_end - vma->vm_start, vma->vm_page_prot))
 		return -EAGAIN;
+	vma->vm_flags &= ~VM_IO;
 	return 0;
 }
 
--- linux-2.4.18-pre9/net/socket.c	Fri Dec 21 11:19:23 2001
+++ linux-akpm/net/socket.c	Thu Feb  7 19:20:54 2002
@@ -705,6 +705,7 @@ static int sock_mmap(struct file * file,
 {
 	struct socket *sock = socki_lookup(file->f_dentry->d_inode);
 
+	vma->vm_flags &= ~VM_IO;
 	return sock->ops->mmap(file, sock, vma);
 }
 
--- linux-2.4.18-pre9/drivers/char/ftape/zftape/zftape-init.c	Thu Sep 13 15:21:32 2001
+++ linux-akpm/drivers/char/ftape/zftape/zftape-init.c	Thu Feb  7 19:29:19 2002
@@ -204,6 +204,7 @@ static int  zft_mmap(struct file *filep,
 	sigfillset(&current->blocked);
 	lock_kernel();
 	if ((result = ftape_mmap(vma)) >= 0) {
+		vma->vm_flags &= ~VM_IO;
 #ifndef MSYNC_BUG_WAS_FIXED
 		static struct vm_operations_struct dummy = { NULL, };
 		vma->vm_ops = &dummy;
--- linux-2.4.18-pre9/drivers/sound/soundcard.c	Sun Sep 30 12:26:08 2001
+++ linux-akpm/drivers/sound/soundcard.c	Thu Feb  7 19:42:13 2002
@@ -481,6 +481,7 @@ static int sound_mmap(struct file *file,
 		return -EAGAIN;
 	}
 
+	vma->vm_flags &= ~VM_IO;
 	dmap->mapping_flags |= DMA_MAP_MAPPED;
 
 	if( audio_devs[dev]->d->mmap)
--- linux-2.4.18-pre9/drivers/sound/es1370.c	Thu Feb  7 13:04:21 2002
+++ linux-akpm/drivers/sound/es1370.c	Thu Feb  7 19:43:30 2002
@@ -1377,6 +1377,7 @@ static int es1370_mmap(struct file *file
 		ret = -EAGAIN;
 		goto out;
 	}
+	vma->vm_flags &= ~VM_IO;
 	db->mapped = 1;
 out:
 	up(&s->sem);
--- linux-2.4.18-pre9/drivers/sound/maestro.c	Sun Sep 30 12:26:08 2001
+++ linux-akpm/drivers/sound/maestro.c	Thu Feb  7 19:44:18 2002
@@ -2512,6 +2512,7 @@ static int ess_mmap(struct file *file, s
 	ret = -EAGAIN;
 	if (remap_page_range(vma->vm_start, virt_to_phys(db->rawbuf), size, vma->vm_page_prot))
 		goto out;
+	vma->vm_flags &= ~VM_IO;
 	db->mapped = 1;
 	ret = 0;
 out:
--- linux-2.4.18-pre9/drivers/sound/trident.c	Thu Feb  7 13:04:21 2002
+++ linux-akpm/drivers/sound/trident.c	Thu Feb  7 19:44:47 2002
@@ -2077,6 +2077,7 @@ static int trident_mmap(struct file *fil
 	if (remap_page_range(vma->vm_start, virt_to_phys(dmabuf->rawbuf),
 			     size, vma->vm_page_prot))
 		goto out;
+	vma->vm_flags &= ~VM_IO;
 	dmabuf->mapped = 1;
 	ret = 0;
 out:
--- linux-2.4.18-pre9/drivers/sound/es1371.c	Thu Feb  7 13:04:21 2002
+++ linux-akpm/drivers/sound/es1371.c	Thu Feb  7 19:45:54 2002
@@ -1566,6 +1566,7 @@ static int es1371_mmap(struct file *file
 		ret = -EAGAIN;
 		goto out;
 	}
+	vma->vm_flags &= ~VM_IO;
 	db->mapped = 1;
 out:
 	up(&s->sem);
@@ -2133,6 +2134,7 @@ static int es1371_mmap_dac(struct file *
 	ret = -EAGAIN;
 	if (remap_page_range(vma->vm_start, virt_to_phys(s->dma_dac1.rawbuf), size, vma->vm_page_prot))
 		goto out;
+	vma->vm_flags &= ~VM_IO;
 	s->dma_dac1.mapped = 1;
 	ret = 0;
 out:
--- linux-2.4.18-pre9/drivers/sound/cs4281/cs4281m.c	Thu Feb  7 13:04:21 2002
+++ linux-akpm/drivers/sound/cs4281/cs4281m.c	Thu Feb  7 19:46:24 2002
@@ -3239,6 +3239,7 @@ static int cs4281_mmap(struct file *file
 	if (remap_page_range
 	    (vma->vm_start, virt_to_phys(db->rawbuf), size,
 	     vma->vm_page_prot)) return -EAGAIN;
+	vma->vm_flags &= ~VM_IO;
 	db->mapped = 1;
 
 	CS_DBGOUT(CS_FUNCTION | CS_PARMS | CS_OPEN, 4,
--- linux-2.4.18-pre9/drivers/sound/cmpci.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/drivers/sound/cmpci.c	Thu Feb  7 19:46:51 2002
@@ -1754,6 +1754,7 @@ static int cm_mmap(struct file *file, st
 	ret = -EINVAL;
 	if (remap_page_range(vma->vm_start, virt_to_phys(db->rawbuf), size, vma->vm_page_prot))
 		goto out;
+	vma->vm_flags &= ~VM_IO;
 	db->mapped = 1;
 	ret = 0;
 out:
--- linux-2.4.18-pre9/drivers/sound/i810_audio.c	Thu Feb  7 13:04:21 2002
+++ linux-akpm/drivers/sound/i810_audio.c	Thu Feb  7 19:47:19 2002
@@ -1672,6 +1672,7 @@ static int i810_mmap(struct file *file, 
 	if (remap_page_range(vma->vm_start, virt_to_phys(dmabuf->rawbuf),
 			     size, vma->vm_page_prot))
 		goto out;
+	vma->vm_flags &= ~VM_IO;
 	dmabuf->mapped = 1;
 	dmabuf->trigger = 0;
 	ret = 0;
--- linux-2.4.18-pre9/drivers/sound/sonicvibes.c	Thu Feb  7 13:04:21 2002
+++ linux-akpm/drivers/sound/sonicvibes.c	Thu Feb  7 19:47:35 2002
@@ -1551,6 +1551,7 @@ static int sv_mmap(struct file *file, st
 	ret = -EAGAIN;
 	if (remap_page_range(vma->vm_start, virt_to_phys(db->rawbuf), size, vma->vm_page_prot))
 		goto out;
+	vma->vm_flags &= ~VM_IO;
 	db->mapped = 1;
 	ret = 0;
 out:
--- linux-2.4.18-pre9/drivers/sound/esssolo1.c	Thu Feb  7 13:04:21 2002
+++ linux-akpm/drivers/sound/esssolo1.c	Thu Feb  7 19:48:12 2002
@@ -1247,6 +1247,7 @@ static int solo1_mmap(struct file *file,
 	ret = -EAGAIN;
 	if (remap_page_range(vma->vm_start, virt_to_phys(db->rawbuf), size, vma->vm_page_prot))
 		goto out;
+	vma->vm_flags &= ~VM_IO;
 	db->mapped = 1;
 	ret = 0;
 out:
--- linux-2.4.18-pre9/drivers/sound/maestro3.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/drivers/sound/maestro3.c	Thu Feb  7 19:48:49 2002
@@ -1557,6 +1557,7 @@ static int m3_mmap(struct file *file, st
     ret = -EAGAIN;
     if (remap_page_range(vma->vm_start, virt_to_phys(db->rawbuf), size, vma->vm_page_prot))
         goto out;
+    vma->vm_flags &= ~VM_IO;
 
     db->mapped = 1;
     ret = 0;
--- linux-2.4.18-pre9/drivers/sound/ymfpci.c	Thu Feb  7 13:04:21 2002
+++ linux-akpm/drivers/sound/ymfpci.c	Thu Feb  7 19:49:14 2002
@@ -1507,6 +1507,7 @@ static int ymf_mmap(struct file *file, s
 	if (remap_page_range(vma->vm_start, virt_to_phys(dmabuf->rawbuf),
 			     size, vma->vm_page_prot))
 		return -EAGAIN;
+	vma->vm_flags &= ~VM_IO;
 	dmabuf->mapped = 1;
 
 /* P3 */ printk(KERN_INFO "ymfpci: using memory mapped sound, untested!\n");
--- linux-2.4.18-pre9/drivers/sound/cs46xx.c	Thu Feb  7 13:04:21 2002
+++ linux-akpm/drivers/sound/cs46xx.c	Thu Feb  7 19:50:02 2002
@@ -2468,6 +2468,7 @@ static int cs_mmap(struct file *file, st
 		ret = -EAGAIN;
 		goto out;
 	}
+	vma->vm_flags &= ~VM_IO;
 	dmabuf->mapped = 1;
 
 	CS_DBGOUT(CS_FUNCTION, 2, printk("cs46xx: cs_mmap()-\n") );
--- linux-2.4.18-pre9/drivers/sound/rme96xx.c	Mon Nov  5 21:01:12 2001
+++ linux-akpm/drivers/sound/rme96xx.c	Thu Feb  7 19:53:01 2002
@@ -1429,7 +1429,7 @@ static int rm96xx_mmap(struct file *file
 
 
 /* this is the mapping */
-
+	vma->vm_flags &= ~VM_IO;
 	dma->mmapped = 1;
 	unlock_kernel();
 	return 0;
--- linux-2.4.18-pre9/drivers/sound/ite8172.c	Mon Nov  5 21:01:12 2001
+++ linux-akpm/drivers/sound/ite8172.c	Thu Feb  7 19:53:26 2002
@@ -1111,6 +1111,7 @@ static int it8172_mmap(struct file *file
 	unlock_kernel();
 	return -EAGAIN;
     }
+    vma->vm_flags &= ~VM_IO;
     db->mapped = 1;
     unlock_kernel();
     return 0;
--- linux-2.4.18-pre9/drivers/usb/audio.c	Thu Feb  7 13:04:21 2002
+++ linux-akpm/drivers/usb/audio.c	Thu Feb  7 19:57:42 2002
@@ -2341,6 +2341,7 @@ static int usb_audio_mmap(struct file *f
 	if (vma->vm_pgoff != 0)
 		goto out;
 
+	vma->vm_flags &= ~VM_IO;
 	ret = dmabuf_mmap(db,  vma->vm_start, vma->vm_end - vma->vm_start, vma->vm_page_prot);
 out:
 	unlock_kernel();
--- linux-2.4.18-pre9/drivers/media/video/videodev.c	Thu Oct 11 09:14:32 2001
+++ linux-akpm/drivers/media/video/videodev.c	Thu Feb  7 20:00:51 2002
@@ -208,6 +208,7 @@ int video_mmap(struct file *file, struct
 		lock_kernel();
 		ret = vfl->mmap(vfl, (char *)vma->vm_start, 
 				(unsigned long)(vma->vm_end-vma->vm_start));
+		vma->vm_flags &= ~VM_IO;
 		unlock_kernel();
 	}
 	return ret;
