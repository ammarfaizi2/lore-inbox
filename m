Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317295AbSFCHB2>; Mon, 3 Jun 2002 03:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317296AbSFCHB1>; Mon, 3 Jun 2002 03:01:27 -0400
Received: from 1-173.ctame701-2.telepar.net.br ([200.181.138.173]:36854 "EHLO
	brinquendo.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S317295AbSFCHBV>; Mon, 3 Jun 2002 03:01:21 -0400
Date: Sun, 2 Jun 2002 04:01:10 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BKPATCH] more copy_{to,from}_user fixes
Message-ID: <20020602070110.GJ19932@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, some more, please consider pulling from:

http://kernel-acme.bkbits.net:8080/copy_to_from_user-2.5

I stopped this (re)audit when 544 were still to be reviewed. Bedtime 8)

And there are some observations for the ones that know the code mentioned
below...

And from a quick look ./arch/i386/kernel/vm86.c seems to have problems too,
look at this:

struct pt_regs * save_v86_state(struct kernel_vm86_regs * regs)
.
.
.
        tmp = copy_to_user(&current->thread.vm86_info->regs,regs, VM86_REGS_SIZE1);
        tmp += copy_to_user(&current->thread.vm86_info->regs.VM86_REGS_PART2,
                &regs->VM86_REGS_PART2, VM86_REGS_SIZE2);
        tmp += put_user(current->thread.screen_bitmap,&current->thread.vm86_info

Another one:

./arch/parisc/hpux/fs.c

static int filldir(void * __buf, const char * name, int namlen, loff_t offset, ino_t ino)

is not checking copy_{to,from}_user and {put,get}_user.

Haven't checked the call chain to see if this is OK

Also ./arch/ppc64/kernel/sys_ppc32.c seems to have problems, not checking
returns, etc, haven't checked the call chain to see if this is OK

But for this ones, even if it is OK to call it without checking (uh) it could
be __copy_{to,from}_user

Question in the show_regs functions (one per arch, I guess) is it ok not to
check the return of these functions? (s390 for one doesn't checks)

Others that are possibly wrong:

./arch/sparc/kernel/sys_sunos.c - sunos_filldir (other _filldir routines also
don't check the return).

- Arnaldo

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.413   -> 1.414  
#	arch/alpha/kernel/osf_sys.c	1.12    -> 1.13   
#	arch/ppc/kernel/ppc_htab.c	1.7     -> 1.8    
#	arch/cris/drivers/sync_serial.c	1.3     -> 1.4    
#	drivers/cdrom/cdu31a.c	1.15    -> 1.16   
#	drivers/cdrom/sbpcd.c	1.18    -> 1.19   
#	drivers/cdrom/optcd.c	1.9     -> 1.10   
#	arch/ppc64/kernel/rtasd.c	1.3     -> 1.4    
#	arch/ia64/sn/io/ifconfig_net.c	1.1     -> 1.2    
#	drivers/cdrom/sonycd535.c	1.13    -> 1.14   
#	drivers/char/drm/i810_dma.c	1.12    -> 1.13   
#	arch/sparc64/solaris/timod.c	1.11    -> 1.12   
#	arch/ppc/iSeries/mf.c	1.1     -> 1.2    
#	arch/alpha/kernel/signal.c	1.7     -> 1.8    
#	arch/ia64/ia32/sys_ia32.c	1.14    -> 1.15   
#	drivers/cdrom/sjcd.c	1.9     -> 1.10   
#	arch/mips/kernel/sysirix.c	1.6     -> 1.7    
#	drivers/bluetooth/hci_vhci.c	1.6     -> 1.7    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/06/03	acme@conectiva.com.br	1.414
# arch/*
# drivers/cdrom/*
# drivers/char/*
# 
# 	Fix some copy_{to,from}_user and {put,get}_user error handling,
#         get rid of some verify_area, copy_{to,from}_user already checks for errors.
# --------------------------------------------
#
diff -Nru a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
--- a/arch/alpha/kernel/osf_sys.c	Mon Jun  3 03:52:10 2002
+++ b/arch/alpha/kernel/osf_sys.c	Mon Jun  3 03:52:10 2002
@@ -116,15 +116,17 @@
 	if (reclen > buf->count)
 		return -EINVAL;
 	if (buf->basep) {
-		put_user(offset, buf->basep);
+		if (put_user(offset, buf->basep))
+			return -EFAULT;
 		buf->basep = NULL;
 	}
 	dirent = buf->dirent;
 	put_user(ino, &dirent->d_ino);
 	put_user(namlen, &dirent->d_namlen);
 	put_user(reclen, &dirent->d_reclen);
-	copy_to_user(dirent->d_name, name, namlen);
-	put_user(0, dirent->d_name + namlen);
+	if (copy_to_user(dirent->d_name, name, namlen) ||
+	    put_user(0, dirent->d_name + namlen))
+		return -EFAULT;
 	((char *) dirent) += reclen;
 	buf->dirent = dirent;
 	buf->count -= reclen;
@@ -629,18 +631,16 @@
 			error = args->fset.nbytes;
 		break;
 	case PL_GET:
-		get_user(min_buf_size_ptr, &args->get.min_buf_size);
-		error = verify_area(VERIFY_WRITE, min_buf_size_ptr,
-				    sizeof(*min_buf_size_ptr));
-		if (!error)
-			put_user(0, min_buf_size_ptr);
+		error = get_user(min_buf_size_ptr, &args->get.min_buf_size);
+		if (error)
+			break;
+		error = put_user(0, min_buf_size_ptr);
 		break;
 	case PL_FGET:
-		get_user(min_buf_size_ptr, &args->fget.min_buf_size);
-		error = verify_area(VERIFY_WRITE, min_buf_size_ptr,
-				    sizeof(*min_buf_size_ptr));
-		if (!error)
-			put_user(0, min_buf_size_ptr);
+		error = get_user(min_buf_size_ptr, &args->fget.min_buf_size);
+		if (error)
+			break;
+		error = put_user(0, min_buf_size_ptr);
 		break;
 	case PL_DEL:
 	case PL_FDEL:
diff -Nru a/arch/alpha/kernel/signal.c b/arch/alpha/kernel/signal.c
--- a/arch/alpha/kernel/signal.c	Mon Jun  3 03:52:10 2002
+++ b/arch/alpha/kernel/signal.c	Mon Jun  3 03:52:10 2002
@@ -253,9 +253,8 @@
 		   struct switch_stack *sw)
 {
 	unsigned long usp;
-	long i, err = 0;
+	long i, err = __get_user(regs->pc, &sc->sc_pc);
 
-	err |= __get_user(regs->pc, &sc->sc_pc);
 	sw->r26 = (unsigned long) ret_from_sys_call;
 
 	err |= __get_user(regs->r0, sc->sc_regs+0);
diff -Nru a/arch/cris/drivers/sync_serial.c b/arch/cris/drivers/sync_serial.c
--- a/arch/cris/drivers/sync_serial.c	Mon Jun  3 03:52:10 2002
+++ b/arch/cris/drivers/sync_serial.c	Mon Jun  3 03:52:10 2002
@@ -551,7 +551,8 @@
 	}
 
 	port = &ports[dev];
-	copy_from_user(port->out_buffer, buf, count);
+	if (copy_from_user(port->out_buffer, buf, count))
+		return -EFAULT;
 	port->outp = port->out_buffer;
 	port->out_count = count;
 	port->odd_output = 1;
@@ -597,7 +598,8 @@
 		return sync_serial_manual_write(file, buf, count, ppos); 
 	}
   
-	copy_from_user(port->out_buffer, buf, count);
+	if (copy_from_user(port->out_buffer, buf, count))
+		return -EFAULT;
 	add_wait_queue(&port->out_wait_q, &wait);
 	set_current_state(TASK_INTERRUPTIBLE);
 	start_dma(port, buf, count);
@@ -658,7 +660,8 @@
 		avail = port->in_buffer + IN_BUFFER_SIZE - start;
   
 	count = count > avail ? avail : count;
-	copy_to_user(buf, start, count);
+	if (copy_to_user(buf, start, count))
+		return -EFAULT;
 
 	/* Disable interrupts while updating readp */
 	save_flags(flags);
diff -Nru a/arch/ia64/ia32/sys_ia32.c b/arch/ia64/ia32/sys_ia32.c
--- a/arch/ia64/ia32/sys_ia32.c	Mon Jun  3 03:52:10 2002
+++ b/arch/ia64/ia32/sys_ia32.c	Mon Jun  3 03:52:11 2002
@@ -278,7 +278,8 @@
 		return -ENOMEM;
 
 	if (old_prot)
-		copy_from_user(page, (void *) PAGE_START(start), PAGE_SIZE);
+		if (copy_from_user(page, (void *) PAGE_START(start), PAGE_SIZE))
+			return -EFAULT;
 
 	down_write(&current->mm->mmap_sem);
 	{
diff -Nru a/arch/ia64/sn/io/ifconfig_net.c b/arch/ia64/sn/io/ifconfig_net.c
--- a/arch/ia64/sn/io/ifconfig_net.c	Mon Jun  3 03:52:10 2002
+++ b/arch/ia64/sn/io/ifconfig_net.c	Mon Jun  3 03:52:10 2002
@@ -202,16 +202,30 @@
 	 * Read in the header and see how big of a buffer we really need to 
 	 * allocate.
 	 */
-	ifname_num = (struct ifname_num *) kmalloc(sizeof(struct ifname_num), 
-			GFP_KERNEL);
-	copy_from_user( ifname_num, (char *) arg, sizeof(struct ifname_num));
+	ifname_num = kmalloc(sizeof(struct ifname_num), GFP_KERNEL);
+	if (!ifname_num)
+		return -ENOMEM;
+	if (copy_from_user(ifname_num, (char *)arg,
+			   sizeof(struct ifname_num))) {
+		kfree(ifname_num);
+		return -EFAULT;
+	}
 	size = ifname_num->size;
 	kfree(ifname_num);
-	ifname_num = (struct ifname_num *) kmalloc(size, GFP_KERNEL);
+	ifname_num = kmalloc(size, GFP_KERNEL);
+	if (!ifname_num)
+		return -ENOMEM;
 	ifname_MAC = (struct ifname_MAC *) ((char *)ifname_num + (sizeof(struct ifname_num)) );
 
-	copy_from_user( ifname_num, (char *) arg, size);
+	if (copy_from_user(ifname_num, (char *)arg, size)) {
+		kfree(ifname_num);
+		return -EFAULT;
+	}
 	new_devices =  kmalloc(size - sizeof(struct ifname_num), GFP_KERNEL);
+	if (!new_devices) {
+		kfree(ifname_num);
+		return -EFAULT;
+	}
 	temp_new_devices = new_devices;
 
 	memset(new_devices, 0, size - sizeof(struct ifname_num));
@@ -257,9 +271,9 @@
 	/*
 	 * Copy back to the User Buffer area any new devices encountered.
 	 */
-	copy_to_user((char *)arg + (sizeof(struct ifname_num)), new_devices, 
-			size - sizeof(struct ifname_num));
-
+	if (copy_to_user((char *)arg + (sizeof(struct ifname_num)),
+			 new_devices, size - sizeof(struct ifname_num)))
+		return -EFAULT;
 	return(0);
 
 }
diff -Nru a/arch/mips/kernel/sysirix.c b/arch/mips/kernel/sysirix.c
--- a/arch/mips/kernel/sysirix.c	Mon Jun  3 03:52:11 2002
+++ b/arch/mips/kernel/sysirix.c	Mon Jun  3 03:52:11 2002
@@ -1048,10 +1048,7 @@
 
 asmlinkage int irix_gettimeofday(struct timeval *tv)
 {
-	int retval;
-
-	retval = copy_to_user(tv, &xtime, sizeof(*tv)) ? -EFAULT : 0;
-	return retval;
+	return copy_to_user(tv, &xtime, sizeof(*tv)) ? -EFAULT : 0;
 }
 
 #define IRIX_MAP_AUTOGROW 0x40
diff -Nru a/arch/ppc/iSeries/mf.c b/arch/ppc/iSeries/mf.c
--- a/arch/ppc/iSeries/mf.c	Mon Jun  3 03:52:10 2002
+++ b/arch/ppc/iSeries/mf.c	Mon Jun  3 03:52:10 2002
@@ -950,7 +950,10 @@
 	return -ENOMEM;
     }
 
-    copy_from_user(page, buffer, size);
+    if (copy_from_user(page, buffer, size)) {
+	    rc = -EFAULT;
+	    goto out;
+    }
     memset(&myVspCmd, 0, sizeof(myVspCmd));
 
     myVspCmd.xCmd = 30;
@@ -973,7 +976,7 @@
 	    rc = -ENOMEM;
 	}
     }
-
+out:
     pci_free_consistent(NULL, size, page, dma_addr);
 
     return rc;
diff -Nru a/arch/ppc/kernel/ppc_htab.c b/arch/ppc/kernel/ppc_htab.c
--- a/arch/ppc/kernel/ppc_htab.c	Mon Jun  3 03:52:10 2002
+++ b/arch/ppc/kernel/ppc_htab.c	Mon Jun  3 03:52:10 2002
@@ -223,7 +223,8 @@
 		n = strlen(buffer) - *ppos;
 	if (n > count)
 		n = count;
-	copy_to_user(buf, buffer + *ppos, n);
+	if (copy_to_user(buf, buffer + *ppos, n))
+		return -EFAULT;
 	*ppos += n;
 	return n;
 }
diff -Nru a/arch/ppc64/kernel/rtasd.c b/arch/ppc64/kernel/rtasd.c
--- a/arch/ppc64/kernel/rtasd.c	Mon Jun  3 03:52:10 2002
+++ b/arch/ppc64/kernel/rtasd.c	Mon Jun  3 03:52:10 2002
@@ -99,9 +99,7 @@
 	rtas_log_size -= 1;
 	spin_unlock(&rtas_log_lock);
 
-	copy_to_user(buf, tmp, count);
-	error = count;
-
+	error = copy_to_user(buf, tmp, count) ? -EFAULT : count;
 out:
 	kfree(tmp);
 	return error;
diff -Nru a/arch/sparc64/solaris/timod.c b/arch/sparc64/solaris/timod.c
--- a/arch/sparc64/solaris/timod.c	Mon Jun  3 03:52:10 2002
+++ b/arch/sparc64/solaris/timod.c	Mon Jun  3 03:52:10 2002
@@ -820,14 +820,18 @@
 	if (error && ctl_maxlen > sizeof(udi) && sock->state == TS_IDLE) {
 		SOLD("generating udi");
 		udi.PRIM_type = T_UNITDATA_IND;
-		get_user(udi.SRC_length, ctl_len);
+		if (get_user(udi.SRC_length, ctl_len))
+			return -EFAULT;
 		udi.SRC_offset = sizeof(udi);
 		udi.OPT_length = udi.OPT_offset = 0;
-		copy_to_user(ctl_buf, &udi, sizeof(udi));
-		put_user(sizeof(udi)+udi.SRC_length, ctl_len);
+		if (copy_to_user(ctl_buf, &udi, sizeof(udi)) ||
+		    put_user(sizeof(udi)+udi.SRC_length, ctl_len))
+			return -EFAULT;
 		SOLD("udi done");
-	} else
-		put_user(0, ctl_len);
+	} else {
+		if (put_user(0, ctl_len))
+			return -EFAULT;
+	}
 	put_user(error, data_len);
 	SOLD("done");
 	return 0;
diff -Nru a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
--- a/drivers/bluetooth/hci_vhci.c	Mon Jun  3 03:52:11 2002
+++ b/drivers/bluetooth/hci_vhci.c	Mon Jun  3 03:52:11 2002
@@ -139,7 +139,10 @@
 	if (!(skb = bluez_skb_alloc(count, GFP_KERNEL)))
 		return -ENOMEM;
 	
-	copy_from_user(skb_put(skb, count), buf, count); 
+	if (copy_from_user(skb_put(skb, count), buf, count)) {
+		kfree_skb(skb);
+		return -EFAULT;
+	}
 
 	skb->dev = (void *) &hci_vhci->hdev;
 	skb->pkt_type = *((__u8 *) skb->data);
@@ -170,7 +173,8 @@
 	char *ptr = buf;
 
 	len = MIN(skb->len, len); 
-	copy_to_user(ptr, skb->data, len); 
+	if (copy_to_user(ptr, skb->data, len))
+		return -EFAULT;
 	total += len;
 
 	hci_vhci->hdev.stat.byte_tx += len;
diff -Nru a/drivers/cdrom/cdu31a.c b/drivers/cdrom/cdu31a.c
--- a/drivers/cdrom/cdu31a.c	Mon Jun  3 03:52:10 2002
+++ b/drivers/cdrom/cdu31a.c	Mon Jun  3 03:52:10 2002
@@ -2619,13 +2619,14 @@
 						retval = -EIO;
 						goto exit_read_audio;
 					}
-				} else {
-					copy_to_user((char *) (ra->buf +
+				} else if (copy_to_user((char *)(ra->buf +
 							       (CD_FRAMESIZE_RAW
 								* cframe)),
-						     (char *)
-						     readahead_buffer,
-						     CD_FRAMESIZE_RAW);
+							(char *)
+							       readahead_buffer,
+							CD_FRAMESIZE_RAW)) {
+					retval = -EFAULT;
+					goto exit_read_audio;
 				}
 			} else {
 				printk
@@ -2635,12 +2636,12 @@
 				retval = -EIO;
 				goto exit_read_audio;
 			}
-		} else {
-			copy_to_user((char *) (ra->buf +
-					       (CD_FRAMESIZE_RAW *
-						cframe)),
-				     (char *) readahead_buffer,
-				     CD_FRAMESIZE_RAW);
+		} else if (copy_to_user((char *)(ra->buf + (CD_FRAMESIZE_RAW *
+							    cframe)),
+					(char *)readahead_buffer,
+					CD_FRAMESIZE_RAW)) {
+			retval = -EFAULT;
+			goto exit_read_audio;
 		}
 
 		cframe++;
diff -Nru a/drivers/cdrom/optcd.c b/drivers/cdrom/optcd.c
--- a/drivers/cdrom/optcd.c	Mon Jun  3 03:52:10 2002
+++ b/drivers/cdrom/optcd.c	Mon Jun  3 03:52:10 2002
@@ -1445,10 +1445,8 @@
 	int status;
 	struct cdrom_msf msf;
 
-	status = verify_area(VERIFY_READ, (void *) arg, sizeof msf);
-	if (status)
-		return status;
-	copy_from_user(&msf, (void *) arg, sizeof msf);
+	if (copy_from_user(&msf, (void *) arg, sizeof msf))
+		return -EFAULT;
 
 	bin2bcd(&msf);
 	status = exec_long_cmd(COMPLAY, &msf);
@@ -1469,10 +1467,8 @@
 	struct cdrom_ti ti;
 	struct cdrom_msf msf;
 
-	status = verify_area(VERIFY_READ, (void *) arg, sizeof ti);
-	if (status)
-		return status;
-	copy_from_user(&ti, (void *) arg, sizeof ti);
+	if (copy_from_user(&ti, (void *) arg, sizeof ti))
+		return -EFAULT;
 
 	if (ti.cdti_trk0 < disk_info.first
 	    || ti.cdti_trk0 > disk_info.last
@@ -1514,15 +1510,10 @@
 	int status;
 	struct cdrom_tochdr tochdr;
 
-	status = verify_area(VERIFY_WRITE, (void *) arg, sizeof tochdr);
-	if (status)
-		return status;
-
 	tochdr.cdth_trk0 = disk_info.first;
 	tochdr.cdth_trk1 = disk_info.last;
 
-	copy_to_user((void *) arg, &tochdr, sizeof tochdr);
-	return 0;
+	return copy_to_user((void *)arg, &tochdr, sizeof tochdr) ? -EFAULT : 0;
 }
 
 
@@ -1532,10 +1523,8 @@
 	struct cdrom_tocentry entry;
 	struct cdrom_subchnl *tocptr;
 
-	status = verify_area(VERIFY_WRITE, (void *) arg, sizeof entry);
-	if (status)
-		return status;
-	copy_from_user(&entry, (void *) arg, sizeof entry);
+	if (copy_from_user(&entry, (void *) arg, sizeof entry))
+		return -EFAULT;
 
 	if (entry.cdte_track == CDROM_LEADOUT)
 		tocptr = &toc[disk_info.last + 1];
@@ -1557,8 +1546,7 @@
 	else if (entry.cdte_format != CDROM_MSF)
 		return -EINVAL;
 
-	copy_to_user((void *) arg, &entry, sizeof entry);
-	return 0;
+	return copy_to_user((void *)arg, &entry, sizeof entry) ? -EFAULT : 0;
 }
 
 
@@ -1568,10 +1556,8 @@
 	struct cdrom_volctrl volctrl;
 	struct cdrom_msf msf;
 
-	status = verify_area(VERIFY_READ, (void *) arg, sizeof volctrl);
-	if (status)
-		return status;
-	copy_from_user(&volctrl, (char *) arg, sizeof volctrl);
+	if (copy_from_user(&volctrl, (char *) arg, sizeof volctrl))
+		return -EFAULT;
 
 	msf.cdmsf_min0 = 0x10;
 	msf.cdmsf_sec0 = 0x32;
@@ -1594,10 +1580,8 @@
 	int status;
 	struct cdrom_subchnl subchnl;
 
-	status = verify_area(VERIFY_WRITE, (void *) arg, sizeof subchnl);
-	if (status)
-		return status;
-	copy_from_user(&subchnl, (void *) arg, sizeof subchnl);
+	if (copy_from_user(&subchnl, (void *) arg, sizeof subchnl))
+		return -EFAULT;
 
 	if (subchnl.cdsc_format != CDROM_LBA
 	    && subchnl.cdsc_format != CDROM_MSF)
@@ -1609,7 +1593,8 @@
 		return -EIO;
 	}
 
-	copy_to_user((void *) arg, &subchnl, sizeof subchnl);
+	if (copy_to_user((void *)arg, &subchnl, sizeof subchnl))
+		return -EFAULT;
 	return 0;
 }
 
@@ -1620,10 +1605,8 @@
 	struct cdrom_msf msf;
 	char buf[CD_FRAMESIZE_RAWER];
 
-	status = verify_area(VERIFY_WRITE, (void *) arg, blocksize);
-	if (status)
-		return status;
-	copy_from_user(&msf, (void *) arg, sizeof msf);
+	if (copy_from_user(&msf, (void *) arg, sizeof msf))
+		return -EFAULT;
 
 	bin2bcd(&msf);
 	msf.cdmsf_min1 = 0;
@@ -1637,8 +1620,7 @@
 		return -EIO;
 	fetch_data(buf, blocksize);
 
-	copy_to_user((void *) arg, &buf, blocksize);
-	return 0;
+	return copy_to_user((void *)arg, &buf, blocksize) ? -EFAULT : 0;
 }
 
 
@@ -1647,10 +1629,8 @@
 	int status;
 	struct cdrom_msf msf;
 
-	status = verify_area(VERIFY_READ, (void *) arg, sizeof msf);
-	if (status)
-		return status;
-	copy_from_user(&msf, (void *) arg, sizeof msf);
+	if (copy_from_user(&msf, (void *)arg, sizeof msf))
+		return -EFAULT;
 
 	bin2bcd(&msf);
 	status = exec_seek_cmd(COMSEEK, &msf);
@@ -1669,10 +1649,8 @@
 	int status;
 	struct cdrom_multisession ms;
 
-	status = verify_area(VERIFY_WRITE, (void*) arg, sizeof ms);
-	if (status)
-		return status;
-	copy_from_user(&ms, (void*) arg, sizeof ms);
+	if (copy_from_user(&ms, (void*) arg, sizeof ms))
+		return -EFAULT;
 
 	ms.addr.msf.minute = disk_info.last_session.minute;
 	ms.addr.msf.second = disk_info.last_session.second;
@@ -1686,8 +1664,8 @@
 
 	ms.xa_flag = disk_info.xa;
 
-  	copy_to_user((void*) arg, &ms,
-		sizeof(struct cdrom_multisession));
+  	if (copy_to_user((void *)arg, &ms, sizeof(struct cdrom_multisession)))
+		return -EFAULT;
 
 #if DEBUG_MULTIS
  	if (ms.addr_format == CDROM_MSF)
diff -Nru a/drivers/cdrom/sbpcd.c b/drivers/cdrom/sbpcd.c
--- a/drivers/cdrom/sbpcd.c	Mon Jun  3 03:52:10 2002
+++ b/drivers/cdrom/sbpcd.c	Mon Jun  3 03:52:10 2002
@@ -4255,9 +4255,9 @@
 		if (D_S[d].has_data>1) RETURN_UP(-EBUSY);
 #endif /* SAFE_MIXED */ 
 		if (D_S[d].aud_buf==NULL) RETURN_UP(-EINVAL);
-		i=verify_area(VERIFY_READ, (void *) arg, sizeof(struct cdrom_read_audio));
-		if (i) RETURN_UP(i);
-		copy_from_user(&read_audio, (void *) arg, sizeof(struct cdrom_read_audio));
+		if (copy_from_user(&read_audio, (void *)arg,
+				   sizeof(struct cdrom_read_audio)))
+			RETURN_UP(-EFAULT);
 		if (read_audio.nframes < 0 || read_audio.nframes>D_S[d].sbp_audsiz) RETURN_UP(-EINVAL);
 		i=verify_area(VERIFY_WRITE, read_audio.buf,
 			      read_audio.nframes*CD_FRAMESIZE_RAW);
@@ -4454,9 +4454,10 @@
 				msg(DBG_AUD,"read_audio: cc_ReadError was necessary after read: %02X\n",i);
 				continue;
 			}
-			copy_to_user((u_char *) read_audio.buf,
-				    (u_char *) D_S[d].aud_buf,
-				    read_audio.nframes*CD_FRAMESIZE_RAW);
+			if (copy_to_user((u_char *)read_audio.buf,
+					 (u_char *) D_S[d].aud_buf,
+					 read_audio.nframes * CD_FRAMESIZE_RAW))
+				RETURN_UP(-EFAULT);
 			msg(DBG_AUD,"read_audio: copy_to_user done.\n");
 			break;
 		}
diff -Nru a/drivers/cdrom/sjcd.c b/drivers/cdrom/sjcd.c
--- a/drivers/cdrom/sjcd.c	Mon Jun  3 03:52:11 2002
+++ b/drivers/cdrom/sjcd.c	Mon Jun  3 03:52:11 2002
@@ -795,16 +795,12 @@
 
 	case CDROMPLAYTRKIND:{
 			struct cdrom_ti ti;
-			int s;
+			int s = -EFAULT;
 #if defined( SJCD_TRACE )
 			printk("SJCD: ioctl: playtrkind\n");
 #endif
-			if ((s =
-			     verify_area(VERIFY_READ, (void *) arg,
-					 sizeof(ti))) == 0) {
-				copy_from_user(&ti, (void *) arg,
-					       sizeof(ti));
-
+			if (!copy_from_user(&ti, (void *) arg, sizeof(ti))) {
+				s = 0;
 				if (ti.cdti_trk0 < sjcd_first_track_no)
 					return (-EINVAL);
 				if (ti.cdti_trk1 > sjcd_last_track_no)
@@ -879,19 +875,15 @@
 
 	case CDROMREADTOCHDR:{
 			struct cdrom_tochdr toc_header;
-			int s;
 #if defined (SJCD_TRACE )
 			printk("SJCD: ioctl: readtocheader\n");
 #endif
-			if ((s =
-			     verify_area(VERIFY_WRITE, (void *) arg,
-					 sizeof(toc_header))) == 0) {
-				toc_header.cdth_trk0 = sjcd_first_track_no;
-				toc_header.cdth_trk1 = sjcd_last_track_no;
-				copy_to_user((void *) arg, &toc_header,
-					     sizeof(toc_header));
-			}
-			return (s);
+			toc_header.cdth_trk0 = sjcd_first_track_no;
+			toc_header.cdth_trk1 = sjcd_last_track_no;
+			if (copy_to_user((void *)arg, &toc_header,
+					 sizeof(toc_header)))
+				return -EFAULT;
+			return 0;
 		}
 
 	case CDROMREADTOCENTRY:{
@@ -942,8 +934,9 @@
 				default:
 					return (-EINVAL);
 				}
-				copy_to_user((void *) arg, &toc_entry,
-					     sizeof(toc_entry));
+				if (copy_to_user((void *) arg, &toc_entry,
+						 sizeof(toc_entry)))
+					s = -EFAULT;
 			}
 			return (s);
 		}
@@ -998,8 +991,9 @@
 				default:
 					return (-EINVAL);
 				}
-				copy_to_user((void *) arg, &subchnl,
-					     sizeof(subchnl));
+				if (copy_to_user((void *) arg, &subchnl,
+					         sizeof(subchnl)))
+					s = -EFAULT;
 			}
 			return (s);
 		}
@@ -1041,16 +1035,13 @@
 
 #if defined( SJCD_GATHER_STAT )
 	case 0xABCD:{
-			int s;
 #if defined( SJCD_TRACE )
 			printk("SJCD: ioctl: statistic\n");
 #endif
-			if ((s =
-			     verify_area(VERIFY_WRITE, (void *) arg,
-					 sizeof(statistic))) == 0)
-				copy_to_user((void *) arg, &statistic,
-					     sizeof(statistic));
-			return (s);
+			if (copy_to_user((void *)arg, &statistic,
+					 sizeof(statistic)))
+				return -EFAULT;
+			return 0;
 		}
 #endif
 
diff -Nru a/drivers/cdrom/sonycd535.c b/drivers/cdrom/sonycd535.c
--- a/drivers/cdrom/sonycd535.c	Mon Jun  3 03:52:10 2002
+++ b/drivers/cdrom/sonycd535.c	Mon Jun  3 03:52:10 2002
@@ -1022,11 +1022,8 @@
 	if (!sony_toc_read) {
 		return -EIO;
 	}
-	err = verify_area(VERIFY_WRITE /* and read */ , (char *)arg, sizeof schi);
-	if (err)
-		return err;
-
-	copy_from_user(&schi, (char *)arg, sizeof schi);
+	if (copy_from_user(&schi, (char *)arg, sizeof schi))
+		return -EFAULT;
 
 	switch (sony_audio_status) {
 	case CDROM_AUDIO_PLAY:
@@ -1041,7 +1038,8 @@
 
 	case CDROM_AUDIO_NO_STATUS:
 		schi.cdsc_audiostatus = sony_audio_status;
-		copy_to_user((char *)arg, &schi, sizeof schi);
+		if (copy_to_user((char *)arg, &schi, sizeof schi))
+			return -EFAULT;
 		return 0;
 		break;
 
@@ -1068,8 +1066,7 @@
 		schi.cdsc_absaddr.lba = msf_to_log(last_sony_subcode->abs_msf);
 		schi.cdsc_reladdr.lba = msf_to_log(last_sony_subcode->rel_msf);
 	}
-	copy_to_user((char *)arg, &schi, sizeof schi);
-	return 0;
+	return copy_to_user((char *)arg, &schi, sizeof schi) ? -EFAULT : 0;
 }
 
 
@@ -1218,12 +1215,10 @@
 			if (!sony_toc_read)
 				return -EIO;
 			hdr = (struct cdrom_tochdr *)arg;
-			err = verify_area(VERIFY_WRITE, hdr, sizeof *hdr);
-			if (err)
-				return err;
 			loc_hdr.cdth_trk0 = bcd_to_int(sony_toc->first_track_num);
 			loc_hdr.cdth_trk1 = bcd_to_int(sony_toc->last_track_num);
-			copy_to_user(hdr, &loc_hdr, sizeof *hdr);
+			if (copy_to_user(hdr, &loc_hdr, sizeof *hdr))
+				return -EFAULT;
 		}
 		return 0;
 		break;
@@ -1240,11 +1235,9 @@
 				return -EIO;
 			}
 			entry = (struct cdrom_tocentry *)arg;
-			err = verify_area(VERIFY_WRITE /* and read */ , entry, sizeof *entry);
-			if (err)
-				return err;
 
-			copy_from_user(&loc_entry, entry, sizeof loc_entry);
+			if (copy_from_user(&loc_entry, entry, sizeof loc_entry))
+				return -EFAULT;
 
 			/* Lead out is handled separately since it is special. */
 			if (loc_entry.cdte_track == CDROM_LEADOUT) {
@@ -1268,7 +1261,8 @@
 				loc_entry.cdte_addr.msf.second = bcd_to_int(*(msf_val + 1));
 				loc_entry.cdte_addr.msf.frame = bcd_to_int(*(msf_val + 2));
 			}
-			copy_to_user(entry, &loc_entry, sizeof *entry);
+			if (copy_to_user(entry, &loc_entry, sizeof *entry))
+				return -EFAULT;
 		}
 		return 0;
 		break;
@@ -1281,11 +1275,9 @@
 			sony_get_toc();
 			if (!sony_toc_read)
 				return -EIO;
-			err = verify_area(VERIFY_READ, (char *)arg, sizeof ti);
-			if (err)
-				return err;
 
-			copy_from_user(&ti, (char *)arg, sizeof ti);
+			if (copy_from_user(&ti, (char *)arg, sizeof ti))
+				return -EFAULT;
 			if ((ti.cdti_trk0 < sony_toc->first_track_num)
 				|| (sony_toc->last_track_num < ti.cdti_trk0)
 				|| (ti.cdti_trk1 < ti.cdti_trk0)) {
@@ -1352,11 +1344,9 @@
 		{
 			struct cdrom_volctrl volctrl;
 
-			err = verify_area(VERIFY_READ, (char *)arg, sizeof volctrl);
-			if (err)
-				return err;
-
-			copy_from_user(&volctrl, (char *)arg, sizeof volctrl);
+			if (copy_from_user(&volctrl, (char *)arg,
+					   sizeof volctrl))
+				return -EFAULT;
 			cmd_buff[0] = SONY535_SET_VOLUME;
 			cmd_buff[1] = volctrl.channel0;
 			cmd_buff[2] = volctrl.channel1;
diff -Nru a/drivers/char/drm/i810_dma.c b/drivers/char/drm/i810_dma.c
--- a/drivers/char/drm/i810_dma.c	Mon Jun  3 03:52:10 2002
+++ b/drivers/char/drm/i810_dma.c	Mon Jun  3 03:52:10 2002
@@ -1209,7 +1209,8 @@
 
 	data.offset = dev_priv->overlay_offset;
 	data.physical = dev_priv->overlay_physical;
-	copy_to_user((drm_i810_overlay_t *)arg,&data,sizeof(data));
+	if (copy_to_user((drm_i810_overlay_t *)arg,&data,sizeof(data)))
+		return -EFAULT;
 	return 0;
 }
 
