Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbVLPXxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbVLPXxq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 18:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbVLPXxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 18:53:18 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:119 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S964805AbVLPXtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 18:49:14 -0500
Subject: [PATCH 05/13]  [RFC] ipath LLD core, part 2
In-Reply-To: <200512161548.20XjmmxDHjOZRXcz@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 16 Dec 2005 15:48:55 -0800
Message-Id: <200512161548.YvnmQHKTsmmCBp1k@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
X-OriginalArrivalTime: 16 Dec 2005 23:48:56.0870 (UTC) FILETIME=[47756460:01C6029B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Next part of ipath core driver

---

 drivers/infiniband/hw/ipath/ipath_driver.c | 2290 ++++++++++++++++++++++++++++
 1 files changed, 2290 insertions(+), 0 deletions(-)

fc2b052ff2abadc8547dc1b319883f9c942b0ae4
diff --git a/drivers/infiniband/hw/ipath/ipath_driver.c b/drivers/infiniband/hw/ipath/ipath_driver.c
index df650d6..0dee4ce 100644
--- a/drivers/infiniband/hw/ipath/ipath_driver.c
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c
@@ -2587,3 +2587,2293 @@ static int ipath_get_unit_counters(struc
 		return -EFAULT;
 	return ipath_get_counters(c.unit, (struct infinipath_counters *)c.data);
 }
+
+/*
+ * ioctls for the control device, which is useful when you don't want
+ * to open the main device and use up a port.
+ */
+
+static int ipath_ctrl_ioctl(struct file *fp, unsigned int cmd, unsigned long a)
+{
+	int ret = 0;
+
+	switch (cmd) {
+	case IPATH_GETSTATS:		/* return driver stats */
+		ret = ipath_get_stats((struct infinipath_stats *) a);
+		break;
+	case IPATH_GETUNITCOUNTERS:	/* return chip counters */
+		ret = ipath_get_unit_counters((struct infinipath_getunitcounters *) a);
+		break;
+	default:
+		_IPATH_DBG("%x not a valid CTRL ioctl for infinipath\n", cmd);
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+long ipath_ioctl(struct file *fp, unsigned int cmd, unsigned long a)
+{
+	int ret = 0;
+	ipath_portdata *pd;
+	ipath_type unit;
+	uint32_t tmp, i, nactive = 0;
+
+	if (cmd == IPATH_GETUNITS) {
+		/*
+		 * Return number of units supported.  This is called
+		 * here as this ioctl is needed via both the normal and
+		 * diags interface, and it does not need the device to
+		 * be opened.
+		 */
+		return ipath_get_units();
+	}
+
+	pd = port_fp(fp);
+	if (!pd) {
+		if (IPATH_SMA == (unsigned long)fp->private_data)
+			/* sma separate; no pd */
+			return (long)ipath_sma_ioctl(fp, cmd, a);
+#ifdef IPATH_DIAG
+		else if (IPATH_DIAG == (unsigned long)fp->private_data)
+			/* diags separate; no pd */
+			return (long)ipath_diags_ioctl(fp, cmd, a);
+#endif
+		else if (IPATH_CTRL == (unsigned long)fp->private_data)
+			/* ctrl separate; no pd */
+			return (long)ipath_ctrl_ioctl(fp, cmd, a);
+		else {
+			_IPATH_DBG("NULL pd from fp (%p), cmd=%x\n", fp, cmd);
+			return -ENODEV;	/* bad; shouldn't ever happen */
+		}
+	}
+
+	unit = pd->port_unit;
+
+	if ((devdata[unit].ipath_flags & IPATH_PRESENT)
+	    && (cmd == IPATH_GETCOUNTERS || cmd == IPATH_GETSTATS
+		|| cmd == IPATH_READ_EEPROM || cmd == IPATH_WRITE_EEPROM)) {
+		/* allowed to do these, as long as chip is accessible */
+	} else if (!(devdata[unit].ipath_flags & IPATH_INITTED)) {
+		_IPATH_DBG
+		    ("%s not initialized (flags=0x%x), failing ioctl #%u\n",
+		     ipath_get_unit_name(unit), devdata[unit].ipath_flags,
+		     _IOC_NR(cmd));
+		ret = -ENODEV;
+	} else
+	    if ((devdata[unit].
+		 ipath_flags & (IPATH_LINKDOWN | IPATH_LINKUNK))) {
+		_IPATH_DBG("%s link is down, failing ioctl #%u\n",
+			   ipath_get_unit_name(unit), _IOC_NR(cmd));
+		ret = -ENETDOWN;
+	}
+
+	if (ret)
+		return ret;
+
+	/* normal driver ioctls, not sim-specific */
+	switch (cmd) {
+	case IPATH_USERINIT:
+		/* real application is starting on a port */
+		ret = ipath_do_user_init(pd, (struct ipath_user_info *) a);
+		break;
+	case IPATH_BASEINFO:
+		/* it's done the init, now return the info it needs */
+		ret = ipath_get_baseinfo(pd, (struct ipath_base_info *) a);
+		break;
+	case IPATH_GETPORT:
+		/*
+		 * just return the unit:port that we were assigned,
+		 * and the number of active chips.  This is is used for
+		 * doing sched_setaffinity() before initialization.
+		 */
+		for (i = 0; i < infinipath_max; i++)
+			if ((devdata[i].ipath_flags & IPATH_PRESENT)
+			    && devdata[i].ipath_kregbase
+			    && devdata[i].ipath_lid
+			    && !(devdata[i].ipath_flags &
+				 (IPATH_LINKDOWN | IPATH_LINKUNK)))
+				nactive++;
+		tmp = (nactive << 24) | (unit << 16) | unit;
+		if(copy_to_user((void *)a, &tmp, sizeof(unit)))
+			ret = EFAULT;
+		break;
+	case IPATH_GETLID:
+		/* get LID for given unit # */
+		ret = ipath_layer_get_lid(a);
+		break;
+	case IPATH_UPDM_TID:	/* update expected TID entries */
+		ret = ipath_tid_update(pd, (struct _tidupd *)a);
+		break;
+	case IPATH_FREE_TID:	/* free expected TID entries */
+		ret = ipath_tid_free(pd, (struct _tidupd *)a);
+		break;
+	case IPATH_GETCOUNTERS:	/* return chip counters */
+		ret = ipath_get_counters(unit, (struct infinipath_counters *)a);
+		break;
+	case IPATH_GETSTATS:	/* return driver stats */
+		ret = ipath_get_stats((struct infinipath_stats *) a);
+		break;
+	case IPATH_GETUNITCOUNTERS:	/* return chip counters */
+		ret = ipath_get_unit_counters((struct infinipath_getunitcounters *) a);
+		break;
+	case IPATH_SET_PKEY:	/* set a partition key */
+		ret = ipath_set_partkey(pd, (uint16_t) a);
+		break;
+	case IPATH_RCVCTRL:	/* error handling to manage the rcvq */
+		ret = ipath_manage_rcvq(pd, (uint16_t) a);
+		break;
+	case IPATH_WRITE_EEPROM:
+		/* write the eeprom (for GUID) */
+		ret = ipath_wr_eeprom(pd, (struct ipath_eeprom_req *)a);
+		break;
+	case IPATH_READ_EEPROM:	/* read the eeprom (for GUID) */
+		ret = ipath_rd_eeprom(pd->port_unit,
+				      (struct ipath_eeprom_req *)a);
+		break;
+	case IPATH_WAIT:
+		/*
+		 * wait for a receive intr for this port, or PIO avail
+		 */
+		ret = ipath_wait_intr(pd, (uint32_t) a);
+		break;
+
+	default:
+		_IPATH_DBG("cmd %x (%c,%u) not a valid ioctl\n", cmd,
+			   _IOC_TYPE(cmd), _IOC_NR(cmd));
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static loff_t ipath_llseek(struct file *fp, loff_t off, int whence)
+{
+	loff_t ret;
+
+	/* range checking is done where offset is used, not here. */
+	down(&fp->f_dentry->d_inode->i_sem);
+	if (!whence)
+		ret = fp->f_pos = off;
+	else if (whence == 1) {
+		fp->f_pos += off;
+		ret = fp->f_pos;
+	} else
+		ret = -EINVAL;
+	up(&fp->f_dentry->d_inode->i_sem);
+	_IPATH_DBG("New offset %llx from seek %llx whence=%d\n", fp->f_pos, off,
+		   whence);
+
+	return ret;
+}
+
+/*
+ * We use this to have a shared buffer between the kernel and the user
+ * code for the rcvhdr queue, egr buffers, and the per-port user regs and pio
+ * buffers in the chip.  We have the open and close entries so we can bump
+ * the ref count and keep the driver from being unloaded while still mapped.
+ */
+
+static struct vm_operations_struct ipath_vmops = {
+	.nopage = ipath_nopage,
+};
+
+static int ipath_mmap(struct file *fp, struct vm_area_struct *vm)
+{
+	int setlen = 0, ret = -EINVAL;
+	ipath_portdata *pd;
+
+	if (fp->private_data && 255UL < (unsigned long)fp->private_data) {
+		pd = port_fp(fp);
+		{
+			/*
+			 * This is the ipath_do_user_init() code,
+			 * mapping the shared buffers into the user
+			 * process. The address referred to by vm_pgoff
+			 * is the virtual, not physical, address; we only
+			 * do one mmap for each space mapped.
+			 */
+			uint64_t pgaddr, ureg;
+
+			pgaddr = vm->vm_pgoff << PAGE_SHIFT;
+
+			/*
+			 * note that ureg does *NOT* have the kregvirt
+			 * as part of it, to be sure that for 32 bit
+			 * programs, we don't end up trying to map
+			 * a > 44 address.  Has to match ipath_get_baseinfo()
+			 * code that sets __spi_uregbase
+			 */
+
+			ureg = devdata[pd->port_unit].ipath_uregbase +
+			    devdata[pd->port_unit].ipath_palign * pd->port_port;
+
+			_IPATH_MMDBG
+			    ("ushare: pgaddr %llx vm_start=%lx, vmlen %lx\n",
+			     pgaddr, vm->vm_start, vm->vm_end - vm->vm_start);
+
+			if (pgaddr == ureg) {
+				/* it's the real hardware, so io_remap works */
+				unsigned long phys;
+				if ((vm->vm_end - vm->vm_start) > PAGE_SIZE) {
+					_IPATH_INFO
+					    ("FAIL mmap userreg: reqlen %lx > PAGE\n",
+					     vm->vm_end - vm->vm_start);
+					ret = -EFAULT;
+				} else {
+					phys =
+					    devdata[pd->port_unit].
+					    ipath_physaddr + ureg;
+					vm->vm_page_prot =
+					    pgprot_noncached(vm->vm_page_prot);
+
+					vm->vm_flags |=
+					    VM_DONTCOPY | VM_DONTEXPAND | VM_IO
+					    | VM_SHM | VM_LOCKED;
+					ret =
+			io_remap_pfn_range(vm, vm->vm_start, phys >> PAGE_SHIFT,
+					   vm->vm_end - vm->vm_start,
+					   vm->vm_page_prot);
+				}
+			} else if (pgaddr == pd->port_piobufs) {
+				/*
+				 * We use io_remap, so there is not a
+				 * nopage handler for this case!
+				 * when we map the PIO buffers, we want
+				 * to map them as writeonly, no read possible.
+				 */
+
+				unsigned long phys;
+				if ((vm->vm_end - vm->vm_start) >
+				    (devdata[pd->port_unit].ipath_pbufsport *
+				     devdata[pd->port_unit].ipath_palign)) {
+					_IPATH_INFO
+					    ("FAIL mmap userreg: reqlen %lx > PAGE\n",
+					     vm->vm_end - vm->vm_start);
+					ret = -EFAULT;
+				} else {
+					phys =
+					    devdata[pd->port_unit].
+					    ipath_physaddr + pd->port_piobufs;
+					/*
+					 * Do *NOT* mark this as
+					 * non-cached (PWT bit), or we
+					 * don't get the write combining
+					 * behavior we want on the
+					 * PIO buffers!
+					 * vm->vm_page_prot = pgprot_noncached(vm->vm_page_prot);
+					 */
+
+#if defined (pgprot_writecombine) && defined(_PAGE_MA_WC)
+					/* Enable WC */
+					vm->vm_page_prot =
+					    pgprot_writecombine(vm->
+								vm_page_prot);
+#endif
+
+					if (vm->vm_flags & VM_READ) {
+						_IPATH_INFO
+						    ("Can't map piobufs as readable (flags=%lx)\n",
+						     vm->vm_flags);
+						ret = -EPERM;
+					} else {
+						/*
+						 * don't allow them to
+						 * later change to readable
+						 * with mprotect
+						 */
+
+						vm->vm_flags &= ~VM_MAYWRITE;
+
+						vm->vm_flags |=
+						    VM_DONTCOPY | VM_DONTEXPAND
+						    | VM_IO | VM_SHM |
+						    VM_LOCKED;
+						ret =
+			io_remap_pfn_range(vm, vm->vm_start, phys >> PAGE_SHIFT,
+					   vm->vm_end - vm->vm_start,
+					   vm->vm_page_prot);
+					}
+				}
+			} else if (pgaddr == (uint64_t) pd->port_rcvegr_phys) {
+				if (!pd->port_rcvegrbuf_virt)
+					return -EFAULT;
+				/*
+				 * page_alloc'ed egr memory, not
+				 * physically contiguous
+				 * *BUT* to work around the 32 bit mmap64
+				 * only handling 44 bits, we have remapped
+				 * the first page to kernel virtual, so
+				 * we have to do the conversion here to
+				 * get back to the original virtual
+				 * address (not contig pages) so we have
+				 * to mark this for special handling.
+				 */
+
+				/*
+				 * not egrbufs * egrsize since they are
+				 * no longer virtually contiguous.
+				 */
+				setlen = pd->port_rcvegrbuf_chunks * PAGE_SIZE *
+				    (1 << pd->port_rcvegrbuf_order);
+				if ((vm->vm_end - vm->vm_start) > setlen) {
+					_IPATH_INFO
+					    ("FAIL on egr bufs: reqlen %lx > actual %x\n",
+					     vm->vm_end - vm->vm_start, setlen);
+					ret = -EFAULT;
+				} else {
+					vm->vm_ops = &ipath_vmops;
+					vm->vm_private_data =
+					    (void *)(3 | (uint64_t) pd);
+					if (vm->vm_flags & VM_WRITE) {
+						_IPATH_INFO
+						    ("Can't map eager buffers as writable (flags=%lx)\n",
+						     vm->vm_flags);
+						ret = -EPERM;
+					} else {
+						/*
+						 * don't allow them to
+						 * later change to writeable
+						 * with mprotect
+						 */
+
+						vm->vm_flags &= ~VM_MAYWRITE;
+						_IPATH_MMDBG
+						    ("egrbufs, set private to %p, not %llx\n",
+						     vm->vm_private_data,
+						     pgaddr);
+						ret = 0;
+					}
+				}
+			} else if (pgaddr == (uint64_t) pd->port_rcvhdrq_phys) {
+				/*
+				 * kmalloc'ed memory, physically
+				 * contiguous; this is from
+				 * spi_rcvhdr_base; we allow user to
+				 * map read-write so they can write
+				 * hdrq entries to allow protocol code
+				 * to directly poll whether a hdrq entry
+				 * has been written.
+				 */
+				setlen =
+				    round_up(devdata[pd->port_unit].
+					     ipath_rcvhdrcnt *
+					     devdata[pd->port_unit].
+					     ipath_rcvhdrentsize *
+					     sizeof(uint32_t), PAGE_SIZE);
+				if ((vm->vm_end - vm->vm_start) > setlen) {
+					_IPATH_INFO
+					    ("FAIL on rcvhdrq: reqlen %lx > actual %x\n",
+					     vm->vm_end - vm->vm_start, setlen);
+					ret = -EFAULT;
+				} else {
+					vm->vm_ops = &ipath_vmops;
+					vm->vm_private_data =
+					    (void *)(pgaddr | 1);
+					ret = 0;
+				}
+			}
+			/*
+			 * when we map the PIO bufferavail registers,
+			 * we want to map them as readonly, no read
+			 * possible.
+			 */
+			else if (pgaddr ==
+				 devdata[pd->port_unit].
+				 ipath_pioavailregs_phys) {
+				/*
+				 * kmalloc'ed memory, physically
+				 * contiguous, one page only, readonly
+				 */
+				setlen = PAGE_SIZE;
+				if ((vm->vm_end - vm->vm_start) > setlen) {
+					_IPATH_INFO
+					    ("FAIL on pioavailregs_dma: reqlen %lx > actual %x\n",
+					     vm->vm_end - vm->vm_start, setlen);
+					ret = -EFAULT;
+				} else if (vm->vm_flags & VM_WRITE) {
+					_IPATH_INFO
+					    ("Can't map pioavailregs as writable (flags=%lx)\n",
+					     vm->vm_flags);
+					ret = -EPERM;
+				} else {
+					/*
+					 * don't allow them to later
+					 * change with mprotect
+					 */
+					vm->vm_flags &= ~VM_MAYWRITE;
+					vm->vm_ops = &ipath_vmops;
+					vm->vm_private_data =
+					    (void *)(pgaddr | 2);
+					ret = 0;
+				}
+			}
+			if (!ret && setlen) {
+				/* keep page(s) from being swapped, etc. */
+				vm->vm_flags |=
+				    VM_DONTEXPAND | VM_DONTCOPY | VM_RESERVED |
+				    VM_IO | VM_SHM;
+			} else {
+				/* failure, or io_remap case */
+				vm->vm_private_data = NULL;
+				if (ret)
+					_IPATH_INFO
+					    ("Failure %d, setlen %d, on addr %lx, off %lx\n",
+					     ret, setlen, vm->vm_start,
+					     vm->vm_pgoff);
+			}
+		}
+	} else			/* something very wrong */
+		_IPATH_INFO("fp_private wasn't set, no mmaping\n");
+
+	return ret;
+}
+
+/* page fault handler.  For each page that is first faulted in from the
+ * mmap'ed shared address buffer, this routine is called.
+ * It's always for a single page.
+ * We use the low bits of the private_data field to tell us which case
+ * we are dealing with.
+ */
+
+static struct page *ipath_nopage(struct vm_area_struct *vma, unsigned long addr,
+				 int *type)
+{
+	unsigned long avirt,	/* the original [kv]malloc virtual address */
+	 paddr,			/* physical address */
+	 off;			/* calculated page offset */
+	uint32_t which, chunk;
+	void *vaddr = NULL;
+	ipath_portdata *pd;
+	struct page *vpage = NOPAGE_SIGBUS;
+
+	if (!(avirt = (unsigned long)vma->vm_private_data)) {
+		_IPATH_DBG("NULL private_data, vm_pgoff %lx\n", vma->vm_pgoff);
+		which = 0;	/* quiet incorrect gcc warning */
+		goto done;
+	}
+	which = avirt & 3;
+	avirt &= ~3ULL;
+
+	if (addr > vma->vm_end) {
+		_IPATH_DBG("trying to fault in addr %lx past end\n", addr);
+		goto done;
+	}
+
+	/*
+	 * most of our memory is vmalloc'ed, but rcvhdr Q is physically
+	 * contiguous, either from kmalloc or alloc_pages()
+	 * pgoff is virtual.
+	 */
+	switch (which) {
+	case 1:		/* rcvhdrq_phys */
+		/* should always be 0 */
+		off = vma->vm_pgoff - (avirt >> PAGE_SHIFT);
+		paddr = addr - vma->vm_start + (off << PAGE_SHIFT) + avirt;
+		_IPATH_MMDBG("hdrq %lx (u=%lx)\n", paddr, addr);
+		vpage = pfn_to_page(paddr >> PAGE_SHIFT);
+		break;
+	case 2:		/* PIO buffer avail regs */
+		/* should always be 0 */
+		off = vma->vm_pgoff - (avirt >> PAGE_SHIFT);
+		paddr = (addr - vma->vm_start + (off << PAGE_SHIFT) + avirt);
+		_IPATH_MMDBG("pioav %lx\n", paddr);
+		vpage = pfn_to_page(paddr >> PAGE_SHIFT);
+		break;
+	case 3:
+		/*
+		 * rcvegrbufs; page_alloc()'ed like rcvhdrq, but we
+		 * have to pick out which page_alloc()'ed chunk it is.
+		 */
+		pd = (ipath_portdata *) avirt;
+		/* this should always be 0 */
+		off =
+		    vma->vm_pgoff -
+		    ((unsigned long)pd->port_rcvegr_phys >> PAGE_SHIFT);
+		off = (addr - vma->vm_start + (off << PAGE_SHIFT));
+
+		chunk = off / (PAGE_SIZE * (1 << pd->port_rcvegrbuf_order));
+		if (chunk > pd->port_rcvegrbuf_chunks)
+			_IPATH_DBG("Bad egrbuf chunk %u (max %u); off = %lx\n",
+				   chunk, pd->port_rcvegrbuf_chunks, off);
+		vaddr = pd->port_rcvegrbuf_virt[chunk] +
+		    off % (PAGE_SIZE * (1 << pd->port_rcvegrbuf_order));
+		paddr = virt_to_phys(vaddr);
+		vpage = pfn_to_page(paddr >> PAGE_SHIFT);
+		_IPATH_MMDBG("egrb %p,%lx\n", vaddr, paddr);
+		break;
+	default:
+		_IPATH_DBG
+		    ("trying to fault in mmap addr %lx (avirt %lx) that isn't known (case %u)\n",
+		     addr, avirt, which);
+	}
+
+done:
+	if (vpage != NOPAGE_SIGBUS && vpage != NOPAGE_OOM) {
+		if (which == 2)
+			/*
+			 * media/video/video-buf.c doesn't do get_page() for
+			 * buffer from alloc_page().  Hmmm.
+			 *
+			 * keep it from being swapped, complaints if
+			 * process exits before we [vf]free it, etc,
+			 * and keep shared page counts correct, etc.
+			 */
+			get_page(vpage);
+		mark_page_accessed(vpage);
+		if (type)
+			*type = VM_FAULT_MINOR;
+	} else
+		_IPATH_DBG("faultin of addr %lx vaddr %p avirt %lx failed\n",
+			   addr, vaddr, avirt);
+
+	return vpage;
+}
+
+/* this is separate to allow for better optimization of ipath_intr() */
+
+static void ipath_bad_intr(const ipath_type t, uint32_t * unexpectp)
+{
+	ipath_devdata *dd = &devdata[t];
+
+	/*
+	 * sometimes happen during driver init and unload, don't want
+	 * to process any interrupts at that point
+	 */
+
+	/* this is just a bandaid, not a fix, if something goes badly wrong */
+	if (++*unexpectp > 100) {
+		if (++*unexpectp > 105) {
+			/*
+			 * ok, we must be taking somebody else's interrupts,
+			 * due to a messed up mptable and/or PIRQ table, so
+			 * unregister the interrupt.  We've seen this
+			 * during linuxbios development work, and it
+			 * may happen in the future again.
+			 */
+			if (dd->pcidev && dd->pcidev->irq) {
+				_IPATH_UNIT_ERROR(t,
+						  "Now %u unexpected interrupts, unregistering interrupt handler\n",
+						  *unexpectp);
+				_IPATH_DBG("free_irq of irq %x\n",
+					   dd->pcidev->irq);
+				free_irq(dd->pcidev->irq, dd);
+				dd->pcidev->irq = 0;
+			}
+		}
+		if (ipath_kget_kreg32(t, kr_intmask)) {
+			_IPATH_UNIT_ERROR(t,
+					  "%u unexpected interrupts, disabling interrupts completely\n",
+					  *unexpectp);
+			/* disable all interrupts, something is very wrong */
+			ipath_kput_kreg(t, kr_intmask, 0ULL);
+		}
+	} else if (*unexpectp > 1)
+		_IPATH_DBG
+		    ("Interrupt when not ready, should not happen, ignoring\n");
+}
+
+/* separate routine, for better optimization of ipath_intr() */
+
+static void ipath_bad_regread(const ipath_type t)
+{
+	static int allbits;
+	ipath_devdata *dd = &devdata[t];
+
+	/*
+	 * We print the message and disable interrupts, in hope of
+	 * having a better chance of debugging the problem.
+	 */
+	_IPATH_UNIT_ERROR(t,
+			  "Read of interrupt status failed (all bits set)\n");
+	if (allbits++) {
+		/* disable all interrupts, something is very wrong */
+		ipath_kput_kreg(t, kr_intmask, 0ULL);
+		if (allbits == 2) {
+			_IPATH_UNIT_ERROR(t,
+					  "Still bad interrupt status, unregistering interrupt\n");
+			free_irq(dd->pcidev->irq, dd);
+			dd->pcidev->irq = 0;
+		} else if (allbits > 2) {
+			if ((allbits % 10000) == 0)
+				printk(".");
+		} else
+			_IPATH_UNIT_ERROR(t,
+					  "Disabling interrupts, multiple errors\n");
+	}
+}
+
+static irqreturn_t ipath_intr(int irq, void *data, struct pt_regs *regs)
+{
+	ipath_devdata *dd = data;
+	const ipath_type t = IPATH_UNIT(dd);
+	uint32_t istat = ipath_kget_kreg32(t, kr_intstatus);
+	uint64_t estat = 0;
+	static unsigned unexpected = 0;
+
+	if (unlikely(!istat)) {
+		ipath_stats.sps_nullintr++;
+		/* not our interrupt, or already handled */
+		return IRQ_NONE;
+	}
+	if (unlikely(istat == ~0)) {
+		ipath_bad_regread(t);
+		/* don't know if it was our interrupt or not */
+		return IRQ_NONE;
+	}
+
+	ipath_stats.sps_ints++;
+
+	/*
+	 * this needs to be flags&initted, not statusp, so we keep
+	 * taking interrupts even after link goes down, etc.
+	 * Also, we *must* clear the interrupt at some point, or we won't
+	 * take it again, which can be real bad for errors, etc...
+	 */
+
+	if (!(dd->ipath_flags & IPATH_INITTED)) {
+		ipath_bad_intr(t, &unexpected);
+		return IRQ_NONE;
+	}
+	if (unexpected)
+		unexpected = 0;
+
+	if (istat & ~infinipath_i_bitsextant)
+		_IPATH_UNIT_ERROR(t,
+				  "interrupt with unknown interrupts %x set\n",
+				  istat & (uint32_t) ~ infinipath_i_bitsextant);
+
+	if (istat & INFINIPATH_I_ERROR) {
+		ipath_stats.sps_errints++;
+		estat = ipath_kget_kreg64(t, kr_errorstatus);
+		if (!estat)
+			_IPATH_INFO
+			    ("error interrupt (%x), but no error bits set!\n",
+			     istat);
+		else if (estat == ~0ULL)
+			/*
+			 * should we try clearing all, or hope next read
+			 * works?
+			 */
+			_IPATH_UNIT_ERROR(t,
+					  "Read of error status failed (all bits set); ignoring\n");
+		else
+			ipath_handle_errors(t, estat);
+	}
+
+	if (istat & INFINIPATH_I_GPIO) {
+		/* Clear GPIO status bit 2 */
+		ipath_kput_kreg(t, kr_gpio_clear, (uint64_t)(1 << 2));
+
+		/*
+		 * Packets are available in the port 0 receive queue.
+		 * Eventually this needs to be generalized to check
+		 * IPATH_GPIO_INTR, and the specific GPIO bit, when
+		 * GPIO interrupts start being used for other things.
+		 * We skip that now to improve performance.
+		 */
+		ipath_kreceive(t);
+	}
+
+	/*
+	 * clear the ones we will deal with on this round
+	 * We clear it early, mostly for receive interrupts, so we
+	 * know the chip will have seen this by the time we process
+	 * the queue, and will re-interrupt if necessary.  The processor
+	 * itself won't take the interrupt again until we return.
+	 */
+	ipath_kput_kreg(t, kr_intclear, istat);
+
+	if (istat & INFINIPATH_I_SPIOBUFAVAIL) {
+		atomic_clear_mask(INFINIPATH_S_PIOINTBUFAVAIL,
+				  &dd->ipath_sendctrl);
+		ipath_kput_kreg(t, kr_sendctrl, dd->ipath_sendctrl);
+
+		if (dd->ipath_portpiowait) {
+			uint32_t i;
+			/*
+			 * start from port 1, since for now port 0  is
+			 * never using wait_event for PIO
+			 */
+			for (i = 1;
+			     dd->ipath_portpiowait && i < dd->ipath_cfgports;
+			     i++) {
+				if (dd->ipath_pd[i]
+				    && dd->ipath_portpiowait & (1U << i)) {
+					atomic_clear_mask(1U << i,
+							  &dd->
+							  ipath_portpiowait);
+					if (dd->ipath_pd[i]->
+					    port_flag & IPATH_PORT_WAITING_PIO)
+					{
+						dd->ipath_pd[i]->port_flag &=
+						    ~IPATH_PORT_WAITING_PIO;
+						wake_up_interruptible(&dd->
+								      ipath_pd
+								      [i]->
+								      port_wait);
+					}
+				}
+			}
+		}
+
+		if (dd->ipath_layer.l_intr) {
+			if (dd->ipath_layer.l_intr(t,
+				IPATH_LAYER_INT_SEND_CONTINUE)) {
+				atomic_set_mask(INFINIPATH_S_PIOINTBUFAVAIL,
+						&dd->ipath_sendctrl);
+				ipath_kput_kreg(t, kr_sendctrl,
+						dd->ipath_sendctrl);
+			} 
+		}
+
+		if (dd->verbs_layer.l_piobufavail) {
+			if (!dd->verbs_layer.l_piobufavail(t)) {
+				atomic_set_mask(INFINIPATH_S_PIOINTBUFAVAIL,
+						&dd->ipath_sendctrl);
+				ipath_kput_kreg(t, kr_sendctrl,
+						dd->ipath_sendctrl);
+			}
+		}
+	}
+
+	/*
+	 * we check for both transition from empty to non-empty, and urgent
+	 * packets (those with the interrupt bit set in the header)
+	 */
+
+	if (istat & ((infinipath_i_rcvavail_mask << INFINIPATH_I_RCVAVAIL_SHIFT)
+		     | (infinipath_i_rcvurg_mask << INFINIPATH_I_RCVURG_SHIFT))) {
+		uint64_t portr;
+		int i;
+		uint32_t rcvdint = 0;
+
+		portr = ((istat >> INFINIPATH_I_RCVAVAIL_SHIFT) &
+			 infinipath_i_rcvavail_mask)
+		    | ((istat >> INFINIPATH_I_RCVURG_SHIFT) &
+		       infinipath_i_rcvurg_mask);
+		for (i = 0; i < dd->ipath_cfgports; i++) {
+			if (portr & (1 << i) && dd->ipath_pd[i]) {
+				if (i == 0)
+					ipath_kreceive(t);
+				else if (dd->ipath_pd[i]->
+					 port_flag & IPATH_PORT_WAITING_RCV) {
+					atomic_clear_mask
+					    (IPATH_PORT_WAITING_RCV,
+					     &dd->ipath_pd[i]->port_flag);
+					wake_up_interruptible(&dd->ipath_pd[i]->
+							      port_wait);
+					rcvdint |= 1U << i;
+				}
+			}
+		}
+		if (rcvdint) {
+			/*
+			 * only want to take one interrupt, so turn off
+			 * the rcv interrupt for all the ports that we
+			 * did the wakeup on (but never for kernel port)
+			 */
+			atomic_clear_mask(rcvdint <<
+					  INFINIPATH_R_INTRAVAIL_SHIFT,
+					  &dd->ipath_rcvctrl);
+			ipath_kput_kreg(t, kr_rcvctrl, dd->ipath_rcvctrl);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void ipath_decode_err(char *buf, size_t blen, uint64_t err)
+{
+	*buf = '\0';
+	if (err & INFINIPATH_E_RHDRLEN)
+		strlcat(buf, "rhdrlen ", blen);
+	if (err & INFINIPATH_E_RBADTID)
+		strlcat(buf, "rbadtid ", blen);
+	if (err & INFINIPATH_E_RBADVERSION)
+		strlcat(buf, "rbadversion ", blen);
+	if (err & INFINIPATH_E_RHDR)
+		strlcat(buf, "rhdr ", blen);
+	if (err & INFINIPATH_E_RLONGPKTLEN)
+		strlcat(buf, "rlongpktlen ", blen);
+	if (err & INFINIPATH_E_RSHORTPKTLEN)
+		strlcat(buf, "rshortpktlen ", blen);
+	if (err & INFINIPATH_E_RMAXPKTLEN)
+		strlcat(buf, "rmaxpktlen ", blen);
+	if (err & INFINIPATH_E_RMINPKTLEN)
+		strlcat(buf, "rminpktlen ", blen);
+	if (err & INFINIPATH_E_RFORMATERR)
+		strlcat(buf, "rformaterr ", blen);
+	if (err & INFINIPATH_E_RUNSUPVL)
+		strlcat(buf, "runsupvl ", blen);
+	if (err & INFINIPATH_E_RUNEXPCHAR)
+		strlcat(buf, "runexpchar ", blen);
+	if (err & INFINIPATH_E_RIBFLOW)
+		strlcat(buf, "ribflow ", blen);
+	if (err & INFINIPATH_E_REBP)
+		strlcat(buf, "EBP ", blen);
+	if (err & INFINIPATH_E_SUNDERRUN)
+		strlcat(buf, "sunderrun ", blen);
+	if (err & INFINIPATH_E_SPIOARMLAUNCH)
+		strlcat(buf, "spioarmlaunch ", blen);
+	if (err & INFINIPATH_E_SUNEXPERRPKTNUM)
+		strlcat(buf, "sunexperrpktnum ", blen);
+	if (err & INFINIPATH_E_SDROPPEDDATAPKT)
+		strlcat(buf, "sdroppeddatapkt ", blen);
+	if (err & INFINIPATH_E_SDROPPEDSMPPKT)
+		strlcat(buf, "sdroppedsmppkt ", blen);
+	if (err & INFINIPATH_E_SMAXPKTLEN)
+		strlcat(buf, "smaxpktlen ", blen);
+	if (err & INFINIPATH_E_SMINPKTLEN)
+		strlcat(buf, "sminpktlen ", blen);
+	if (err & INFINIPATH_E_SUNSUPVL)
+		strlcat(buf, "sunsupVL ", blen);
+	if (err & INFINIPATH_E_SPKTLEN)
+		strlcat(buf, "spktlen ", blen);
+	if (err & INFINIPATH_E_INVALIDADDR)
+		strlcat(buf, "invalidaddr ", blen);
+	if (err & INFINIPATH_E_RICRC)
+		strlcat(buf, "CRC ", blen);
+	if (err & INFINIPATH_E_RVCRC)
+		strlcat(buf, "VCRC ", blen);
+	if (err & INFINIPATH_E_RRCVEGRFULL)
+		strlcat(buf, "rcvegrfull ", blen);
+	if (err & INFINIPATH_E_RRCVHDRFULL)
+		strlcat(buf, "rcvhdrfull ", blen);
+	if (err & INFINIPATH_E_IBSTATUSCHANGED)
+		strlcat(buf, "ibcstatuschg ", blen);
+	if (err & INFINIPATH_E_RIBLOSTLINK)
+		strlcat(buf, "riblostlink ", blen);
+	if (err & INFINIPATH_E_HARDWARE)
+		strlcat(buf, "hardware ", blen);
+	if (err & INFINIPATH_E_RESET)
+		strlcat(buf, "reset ", blen);
+}
+
+/* decode RHF errors; only used one place now, may want more later */
+static void get_rhf_errstring(uint32_t err, char *msg, size_t len)
+{
+	/* if no errors, and so don't need to check what's first */
+	*msg = '\0';
+
+	if (err & INFINIPATH_RHF_H_ICRCERR)
+		strlcat(msg, "icrcerr ", len);
+	if (err & INFINIPATH_RHF_H_VCRCERR)
+		strlcat(msg, "vcrcerr ", len);
+	if (err & INFINIPATH_RHF_H_PARITYERR)
+		strlcat(msg, "parityerr ", len);
+	if (err & INFINIPATH_RHF_H_LENERR)
+		strlcat(msg, "lenerr ", len);
+	if (err & INFINIPATH_RHF_H_MTUERR)
+		strlcat(msg, "mtuerr ", len);
+	if (err & INFINIPATH_RHF_H_IHDRERR)
+		/* infinipath hdr checksum error */
+		strlcat(msg, "ipathhdrerr ", len);
+	if (err & INFINIPATH_RHF_H_TIDERR)
+		strlcat(msg, "tiderr ", len);
+	if (err & INFINIPATH_RHF_H_MKERR)
+		/* bad port, offset, etc. */
+		strlcat(msg, "invalid ipathhdr ", len);
+	if (err & INFINIPATH_RHF_H_IBERR)
+		strlcat(msg, "iberr ", len);
+	if (err & INFINIPATH_RHF_L_SWA)
+		strlcat(msg, "swA ", len);
+	if (err & INFINIPATH_RHF_L_SWB)
+		strlcat(msg, "swB ", len);
+}
+
+static void ipath_handle_errors(const ipath_type t, uint64_t errs)
+{
+	char msg[512];
+	uint32_t piobcnt;
+	uint64_t sbuf[4], ignore_this_time = 0;
+	int i;
+	int chkerrpkts = 0, noprint = 0;
+	cycles_t nc;
+	static cycles_t nextmsg_time;
+	static unsigned nmsgs, supp_msgs;
+	ipath_devdata *dd = &devdata[t];
+
+#define E_SUM_PKTERRS (INFINIPATH_E_RHDRLEN | INFINIPATH_E_RBADTID \
+     | INFINIPATH_E_RBADVERSION \
+     | INFINIPATH_E_RHDR | INFINIPATH_E_RLONGPKTLEN | INFINIPATH_E_RSHORTPKTLEN \
+     | INFINIPATH_E_RMAXPKTLEN | INFINIPATH_E_RMINPKTLEN \
+     | INFINIPATH_E_RFORMATERR | INFINIPATH_E_RUNSUPVL | INFINIPATH_E_RUNEXPCHAR \
+     | INFINIPATH_E_REBP)
+
+#define E_SUM_ERRS ( INFINIPATH_E_SPIOARMLAUNCH \
+    | INFINIPATH_E_SUNEXPERRPKTNUM | INFINIPATH_E_SDROPPEDDATAPKT \
+    | INFINIPATH_E_SDROPPEDSMPPKT | INFINIPATH_E_SMAXPKTLEN \
+    | INFINIPATH_E_SUNSUPVL | INFINIPATH_E_SMINPKTLEN | INFINIPATH_E_SPKTLEN \
+    | INFINIPATH_E_INVALIDADDR)
+
+	/*
+	 * throttle back "fast" messages to no more than 10 per 5 seconds
+	 * (1.4-2GHz clock).  This isn't perfect, but it's a reasonable
+	 * heuristic
+	 * If we get more than 10, give a 5x longer delay
+	 */
+	nc = get_cycles();
+	if (nmsgs > 10) {
+		if (nc < nextmsg_time) {
+			noprint = 1;
+			if (!supp_msgs++)
+				nextmsg_time = nc + 50000000000ULL;
+		} else if (supp_msgs) {
+			/*
+			 * Print the message unless it's ibc status
+			 * change only, which happens so often we never
+			 * want to count it.
+			 */
+			if (dd->ipath_lasterror & ~INFINIPATH_E_IBSTATUSCHANGED) {
+				ipath_decode_err(msg, sizeof msg,
+						 dd->
+						 ipath_lasterror &
+						 ~INFINIPATH_E_IBSTATUSCHANGED);
+				if (dd->
+				    ipath_lasterror & ~(INFINIPATH_E_RRCVEGRFULL
+							|
+							INFINIPATH_E_RRCVHDRFULL))
+					_IPATH_UNIT_ERROR(t,
+							  "Suppressed %u messages for fast-repeating errors (%s) (%llx)\n",
+							  supp_msgs, msg,
+							  dd->ipath_lasterror);
+				else {
+					/*
+					 * rcvegrfull and rcvhdrqfull are
+					 * "normal", for some types of
+					 * processes (mostly benchmarks)
+					 * that send huge numbers of
+					 * messages, while not processing
+					 * them.  So only complain about
+					 * these at debug level.
+					 */
+					_IPATH_DBG
+					    ("Suppressed %u messages for %s\n",
+					     supp_msgs, msg);
+				}
+			}
+			supp_msgs = 0;
+			nmsgs = 0;
+		}
+	} else if (!nmsgs++ || nc > nextmsg_time)	/* start timer */
+		nextmsg_time = nc + 10000000000ULL;
+
+	/*
+	 * don't report errors that are masked (includes those always
+	 * ignored)
+	 */
+	errs &= ~dd->ipath_maskederrs;
+
+	/* do these first, they are most important */
+	if (errs & INFINIPATH_E_HARDWARE) {
+		/* reuse same msg buf */
+		ipath_handle_hwerrors(t, msg, sizeof msg);
+	}
+
+	if (!noprint && (errs & ~infinipath_e_bitsextant))
+		_IPATH_UNIT_ERROR(t,
+				  "error interrupt with unknown errors %llx set\n",
+				  errs & ~infinipath_e_bitsextant);
+
+	if (errs & E_SUM_ERRS) {
+		/* if possible that sendbuffererror could be valid */
+		piobcnt = dd->ipath_piobcnt;
+		/* read these before writing errorclear */
+		sbuf[0] = ipath_kget_kreg64(t, kr_sendbuffererror);
+		sbuf[1] = ipath_kget_kreg64(t, kr_sendbuffererror + 1);
+		if (piobcnt > 128) {
+			sbuf[2] = ipath_kget_kreg64(t, kr_sendbuffererror + 2);
+			sbuf[3] = ipath_kget_kreg64(t, kr_sendbuffererror + 3);
+		}
+
+		if (sbuf[0] || sbuf[1]
+		    || (piobcnt > 128 && (sbuf[2] || sbuf[3]))) {
+			_IPATH_PDBG("SendbufErrs %llx %llx ", sbuf[0], sbuf[1]);
+			if (infinipath_debug & __IPATH_PKTDBG && piobcnt > 128)
+				printk("%llx %llx ", sbuf[2], sbuf[3]);
+			for (i = 0; i < piobcnt; i++) {
+				if (test_bit(i, sbuf)) {
+					uint32_t sendctrl;
+					if (infinipath_debug & __IPATH_PKTDBG)
+						printk("%u ", i);
+					sendctrl =
+					    dd->
+					    ipath_sendctrl | INFINIPATH_S_DISARM
+					    | (i <<
+					       INFINIPATH_S_DISARMPIOBUF_SHIFT);
+					ipath_kput_kreg(t, kr_sendctrl,
+							sendctrl);
+				}
+			}
+			if (infinipath_debug & __IPATH_PKTDBG)
+				printk("\n");
+		}
+		if ((errs &
+		     (INFINIPATH_E_SDROPPEDDATAPKT | INFINIPATH_E_SDROPPEDSMPPKT
+		      | INFINIPATH_E_SMINPKTLEN))
+		    && !(dd->ipath_flags & IPATH_LINKACTIVE)) {
+			/*
+			 * This can happen when SMA is trying to bring
+			 * the link up, but the IB link changes state
+			 * at the "wrong" time.  The IB logic then
+			 * complains that the packet isn't valid.
+			 * We don't want to confuse people, so we just
+			 * don't print them, except at debug
+			 */
+			_IPATH_DBG
+			    ("Ignoring pktsend errors %llx, because not yet active\n",
+			     errs);
+			ignore_this_time |=
+			    INFINIPATH_E_SDROPPEDDATAPKT |
+			    INFINIPATH_E_SDROPPEDSMPPKT |
+			    INFINIPATH_E_SMINPKTLEN;
+		}
+	}
+
+	if (supp_msgs == 250000) {
+		/*
+		 * It's not entirely reasonable assuming that the errors
+		 * set in the last clear period are all responsible for
+		 * the problem, but the alternative is to assume it's the only
+		 * ones on this particular interrupt, which also isn't great
+		 */
+		dd->ipath_maskederrs |= dd->ipath_lasterror | errs;
+		ipath_kput_kreg(t, kr_errormask, ~dd->ipath_maskederrs);
+		ipath_decode_err(msg, sizeof msg,
+				 (dd->ipath_maskederrs & ~dd->
+				  ipath_ignorederrs));
+
+		if ((dd->ipath_maskederrs & ~dd->ipath_ignorederrs)
+		    & ~(INFINIPATH_E_RRCVEGRFULL | INFINIPATH_E_RRCVHDRFULL))
+			_IPATH_UNIT_ERROR(t,
+					  "Disabling error(s) %llx because occuring too frequently (%s)\n",
+					  (dd->ipath_maskederrs & ~dd->
+					   ipath_ignorederrs), msg);
+		else {
+			/*
+			 * rcvegrfull and rcvhdrqfull are "normal",
+			 * for some types of processes (mostly benchmarks)
+			 * that send huge numbers of messages, while not
+			 * processing them.  So only complain about
+			 * these at debug level.
+			 */
+			_IPATH_DBG
+			    ("Disabling frequent queue full errors (%s)\n",
+			     msg);
+		}
+
+		/*
+		 * re-enable the masked errors after around 3 minutes.
+		 * in ipath_get_faststats().  If we have a series of
+		 * fast repeating but different errors, the interval will keep
+		 * stretching out, but that's OK, as that's pretty catastrophic.
+		 */
+		dd->ipath_unmasktime = nc + 400000000000ULL;
+	}
+
+	ipath_kput_kreg(t, kr_errorclear, errs);
+	if (ignore_this_time)
+		errs &= ~ignore_this_time;
+	if (errs & ~dd->ipath_lasterror) {
+		errs &= ~dd->ipath_lasterror;
+		/* never suppress duplicate hwerrors or ibstatuschange */
+		dd->ipath_lasterror |= errs &
+		    ~(INFINIPATH_E_HARDWARE | INFINIPATH_E_IBSTATUSCHANGED);
+	}
+	if (!errs)
+		return;
+
+	if (!noprint)
+		/* the ones we mask off are handled specially below or above */
+		ipath_decode_err(msg, sizeof msg,
+				 errs & ~(INFINIPATH_E_IBSTATUSCHANGED |
+					  INFINIPATH_E_RRCVEGRFULL |
+					  INFINIPATH_E_RRCVHDRFULL |
+					  INFINIPATH_E_HARDWARE));
+	else
+		/* so we don't need if(!noprint) at strlcat's below */
+		*msg = 0;
+
+	if (errs & E_SUM_PKTERRS) {
+		ipath_stats.sps_pkterrs++;
+		chkerrpkts = 1;
+	}
+	if (errs & E_SUM_ERRS)
+		ipath_stats.sps_errs++;
+
+	if (errs & (INFINIPATH_E_RICRC | INFINIPATH_E_RVCRC)) {
+		ipath_stats.sps_crcerrs++;
+		chkerrpkts = 1;
+	}
+
+	/*
+	 * We don't want to print these two as they happen, or we can make
+	 * the situation even worse, because it takes so long to print messages.
+	 * to serial consoles.  kernel ports get printed from fast_stats, no
+	 * more than every 5 seconds, user ports get printed on close
+	 */
+	if (errs & INFINIPATH_E_RRCVHDRFULL) {
+		int any;
+		uint32_t hd, tl;
+		ipath_stats.sps_hdrqfull++;
+		for (any = i = 0; i < dd->ipath_cfgports; i++) {
+			if (i == 0) {
+				hd = dd->ipath_port0head;
+				tl = *dd->ipath_hdrqtailptr;
+			} else if (dd->ipath_pd[i] &&
+				   dd->ipath_pd[i]->port_rcvhdrtail_kvaddr) {
+				/*
+				 * don't report same point multiple times,
+				 * except kernel
+				 */
+				tl = (uint32_t) *
+				    dd->ipath_pd[i]->port_rcvhdrtail_kvaddr;
+				if (tl == dd->ipath_lastrcvhdrqtails[i])
+					continue;
+				hd = ipath_kget_ureg32(t, ur_rcvhdrhead, i);
+			} else
+				continue;
+			if (hd == (tl + 1) || (!hd && tl == dd->ipath_hdrqlast)) {
+				dd->ipath_lastrcvhdrqtails[i] = tl;
+				dd->ipath_pd[i]->port_hdrqfull++;
+				if (i == 0)
+					chkerrpkts = 1;
+			}
+		}
+	}
+	if (errs & INFINIPATH_E_RRCVEGRFULL) {
+		/*
+		 * since this is of less importance and not likely to
+		 * happen without also getting hdrfull, only count
+		 * occurrences; don't check each port (or even the kernel
+		 * vs user)
+		 */
+		ipath_stats.sps_etidfull++;
+		if (dd->ipath_port0head != *dd->ipath_hdrqtailptr)
+			chkerrpkts = 1;
+	}
+
+	/*
+	 * do this before IBSTATUSCHANGED, in case both bits set in a single
+	 * interrupt; we want the STATUSCHANGE to "win", so we do our 
+	 * internal copy of state machine correctly
+	 */
+	if (errs & INFINIPATH_E_RIBLOSTLINK) {
+		/* force through block below */
+		errs |= INFINIPATH_E_IBSTATUSCHANGED;
+		ipath_stats.sps_iblink++;
+		dd->ipath_flags |= IPATH_LINKDOWN;
+		dd->ipath_flags &= ~(IPATH_LINKUNK | IPATH_LINKINIT
+				     | IPATH_LINKARMED | IPATH_LINKACTIVE);
+		if (!noprint)
+			_IPATH_DBG("Lost link, link now down (%s)\n",
+				   ipath_ibcstatus_str[ipath_kget_kreg64
+						       (t,
+							kr_ibcstatus) & 0xf]);
+	}
+
+	if ((errs & INFINIPATH_E_IBSTATUSCHANGED) && (!ipath_diags_enabled)) {
+		uint64_t val;
+		uint32_t ltstate;
+
+		val = ipath_kget_kreg64(t, kr_ibcstatus);
+		ltstate = val & 0xff;
+		if(ltstate == 0x11 || ltstate == 0x21 || ltstate == 0x31)
+			_IPATH_DBG("Link state changed unit %u to 0x%x, last was 0x%llx\n",
+				t, ltstate, dd->ipath_lastibcstat);
+		else {
+			ltstate = dd->ipath_lastibcstat & 0xff;
+			if(ltstate == 0x11 || ltstate == 0x21 || ltstate == 0x31)
+				_IPATH_DBG("Link state unit %u changed to down state 0x%llx, last was 0x%llx\n",
+					t, val, dd->ipath_lastibcstat);
+			else
+				_IPATH_VDBG("Link state unit %u changed to 0x%llx from one of down states\n",
+					t, val);
+		}
+		ltstate = (val >> INFINIPATH_IBCS_LINKTRAININGSTATE_SHIFT) &
+		    INFINIPATH_IBCS_LINKTRAININGSTATE_MASK;
+
+		if (ltstate == 2 || ltstate == 3) {
+			uint32_t last_ltstate;
+
+			/*
+			 * ignore cycling back and forth from states 2 to 3
+			 * while waiting for other end of link to come up
+			 * except that if it keeps happening, we switch between
+			 * linkinitstate SLEEP and POLL.  While we cycle
+			 * back and forth between them, we aren't seeing
+			 * any other device, either no cable plugged in,
+			 * other device powered off, other device is
+			 * switch that hasn't yet polled us, etc.
+			 */
+			last_ltstate = (dd->ipath_lastibcstat >>
+					INFINIPATH_IBCS_LINKTRAININGSTATE_SHIFT)
+			    & INFINIPATH_IBCS_LINKTRAININGSTATE_MASK;
+			if (last_ltstate == 2 || last_ltstate == 3) {
+				if (++dd->ipath_ibpollcnt > 4) {
+					uint64_t ibc;
+					dd->ipath_flags |=
+					    IPATH_LINK_SLEEPING | IPATH_NOCABLE;
+					*dd->ipath_statusp |=
+					    IPATH_STATUS_IB_NOCABLE;
+					_IPATH_VDBG
+					    ("linkinitcmd POLL, move to SLEEP\n");
+					ibc = dd->ipath_ibcctrl;
+					ibc |= INFINIPATH_IBCC_LINKINITCMD_SLEEP
+					    <<
+					    INFINIPATH_IBCC_LINKINITCMD_SHIFT;
+					/*
+					 * don't put linkinitcmd in
+					 * ipath_ibcctrl, want that to
+					 * stay a NOP
+					 */
+					ipath_kput_kreg(t, kr_ibcctrl, ibc);
+					dd->ipath_ibpollcnt = 0;
+				}
+				goto skip_ibchange;
+			}
+		}
+		/* some state other than 2 or 3 */
+		dd->ipath_ibpollcnt = 0;
+		ipath_stats.sps_iblink++;
+		/*
+		 * Note:  We try to match the Mellanox HCA LED behavior
+		 * as best we can.  That changed around Oct 2003.
+		 * Green indicates link state (something is plugged in,
+		 * and we can train).  Amber indicates the link is
+		 * logically up (ACTIVE).  Mellanox further blinks the
+		 * amber LED to indicate data packet activity, but we
+		 * have no hardware support for that, so it would require
+		 * waking up every 10-20 msecs and checking the counters
+		 * on the chip, and then turning the LED off if
+		 * appropriate.  That's visible overhead, so not something
+		 * we will do.
+		 */
+		if (ltstate != 1 || ((dd->ipath_lastibcstat & 0x30) == 0x30 &&
+				     (val & 0x30) != 0x30)) {
+			dd->ipath_flags |= IPATH_LINKDOWN;
+			dd->ipath_flags &= ~(IPATH_LINKUNK | IPATH_LINKINIT
+					     | IPATH_LINKACTIVE |
+					     IPATH_LINKARMED);
+			*dd->ipath_statusp &= ~IPATH_STATUS_IB_READY;
+			if (!noprint) {
+				if ((dd->ipath_lastibcstat & 0x30) == 0x30)
+					/* if from up to down be more vocal */
+					_IPATH_DBG("Link unit %u is now down (%s)\n",
+						   t, ipath_ibcstatus_str
+						   [ltstate]);
+				else
+					_IPATH_VDBG("Link unit %u is down (%s)\n",
+						    t, ipath_ibcstatus_str
+						    [ltstate]);
+			}
+
+			if (val & 0x30) {
+				/* leave just green on, 0x11 and 0x21 */
+				dd->ipath_extctrl &=
+				    ~INFINIPATH_EXTC_LEDPRIPORTYELLOWON;
+				dd->ipath_extctrl |=
+				    INFINIPATH_EXTC_LEDPRIPORTGREENON;
+			} else	/* not up at all, so turn the leds off */
+				dd->ipath_extctrl &=
+				    ~(INFINIPATH_EXTC_LEDPRIPORTGREENON |
+				      INFINIPATH_EXTC_LEDPRIPORTYELLOWON);
+			ipath_kput_kreg(t, kr_extctrl,
+					(uint64_t) dd->ipath_extctrl);
+			if (ltstate == 1
+			    && (dd->
+				ipath_flags & (IPATH_LINK_TOARMED |
+					       IPATH_LINK_TOACTIVE))) {
+				ipath_set_ib_lstate(t,
+						    INFINIPATH_IBCC_LINKCMD_INIT);
+			}
+		} else if ((val & 0x31) == 0x31) {
+			if (!noprint)
+				_IPATH_DBG("Link unit %u is now in active state\n", t);
+			dd->ipath_flags |= IPATH_LINKACTIVE;
+			dd->ipath_flags &=
+			    ~(IPATH_LINKUNK | IPATH_LINKINIT | IPATH_LINKDOWN |
+			      IPATH_LINKARMED | IPATH_NOCABLE |
+			      IPATH_LINK_TOACTIVE | IPATH_LINK_SLEEPING);
+			*dd->ipath_statusp &= ~IPATH_STATUS_IB_NOCABLE;
+			*dd->ipath_statusp |=
+			    IPATH_STATUS_IB_READY | IPATH_STATUS_IB_CONF;
+			/* set the externally visible LEDs to indicate state */
+			dd->ipath_extctrl |= INFINIPATH_EXTC_LEDPRIPORTGREENON
+			    | INFINIPATH_EXTC_LEDPRIPORTYELLOWON;
+			ipath_kput_kreg(t, kr_extctrl,
+					(uint64_t) dd->ipath_extctrl);
+
+			/*
+			 * since we are now active, set the linkinitcmd
+			 * to NOP (0) it was probably either POLL or SLEEP
+			 */
+			dd->ipath_ibcctrl &=
+			    ~(INFINIPATH_IBCC_LINKINITCMD_MASK <<
+			      INFINIPATH_IBCC_LINKINITCMD_SHIFT);
+			ipath_kput_kreg(t, kr_ibcctrl, dd->ipath_ibcctrl);
+
+			if (devdata[t].ipath_layer.l_intr)
+				devdata[t].ipath_layer.l_intr(t,
+							      IPATH_LAYER_INT_IF_UP);
+		} else if ((val & 0x31) == 0x11) {
+			/*
+			 * set set INIT and DOWN.  Down is checked by
+			 * most of the other code, but INIT is useful
+			 * to know in a few places.
+			 */
+			dd->ipath_flags |= IPATH_LINKINIT | IPATH_LINKDOWN;
+			dd->ipath_flags &=
+			    ~(IPATH_LINKUNK | IPATH_LINKACTIVE | IPATH_LINKARMED
+			      | IPATH_NOCABLE | IPATH_LINK_SLEEPING);
+			*dd->ipath_statusp &= ~(IPATH_STATUS_IB_NOCABLE
+				| IPATH_STATUS_IB_READY);
+
+			/* set the externally visible LEDs to indicate state */
+			dd->ipath_extctrl &=
+			    ~INFINIPATH_EXTC_LEDPRIPORTYELLOWON;
+			dd->ipath_extctrl |= INFINIPATH_EXTC_LEDPRIPORTGREENON;
+			ipath_kput_kreg(t, kr_extctrl,
+					(uint64_t) dd->ipath_extctrl);
+			if (dd->
+			    ipath_flags & (IPATH_LINK_TOARMED |
+					   IPATH_LINK_TOACTIVE)) {
+				/*
+				 * if we got here while trying to bring
+				 * the link up, try again, but only once more!
+				 */
+				ipath_set_ib_lstate(t,
+						    INFINIPATH_IBCC_LINKCMD_ARMED);
+				dd->ipath_flags &=
+				    ~(IPATH_LINK_TOARMED | IPATH_LINK_TOACTIVE);
+			}
+		} else if ((val & 0x31) == 0x21) {
+			dd->ipath_flags |= IPATH_LINKARMED;
+			dd->ipath_flags &=
+			    ~(IPATH_LINKUNK | IPATH_LINKDOWN | IPATH_LINKINIT |
+			      IPATH_LINKACTIVE | IPATH_NOCABLE |
+			      IPATH_LINK_TOARMED | IPATH_LINK_SLEEPING);
+			*dd->ipath_statusp &= ~(IPATH_STATUS_IB_NOCABLE
+				| IPATH_STATUS_IB_READY);
+			/*
+			 * set the externally visible LEDs to indicate
+			 * state (same as 0x11)
+			 */
+			dd->ipath_extctrl &=
+			    ~INFINIPATH_EXTC_LEDPRIPORTYELLOWON;
+			dd->ipath_extctrl |= INFINIPATH_EXTC_LEDPRIPORTGREENON;
+			ipath_kput_kreg(t, kr_extctrl,
+					(uint64_t) dd->ipath_extctrl);
+			if (dd->ipath_flags & IPATH_LINK_TOACTIVE) {
+				/*
+				 * if we got here while trying to bring
+				 * the link up, try again, but only once more!
+				 */
+				ipath_set_ib_lstate(t,
+						    INFINIPATH_IBCC_LINKCMD_ACTIVE);
+				dd->ipath_flags &= ~IPATH_LINK_TOACTIVE;
+			}
+		} else {
+			if (dd->
+			    ipath_flags & (IPATH_LINK_TOARMED |
+					   IPATH_LINK_TOACTIVE))
+				ipath_set_ib_lstate(t,
+						    INFINIPATH_IBCC_LINKCMD_INIT);
+			else if (!noprint)
+				_IPATH_DBG("IBstatuschange unit %u: %s\n",
+					  t, ipath_ibcstatus_str[ltstate]);
+		}
+		dd->ipath_lastibcstat = val;
+	}
+
+skip_ibchange:
+
+	if (errs & INFINIPATH_E_RESET) {
+		if (!noprint)
+			_IPATH_UNIT_ERROR(t,
+					  "Got reset, requires re-initialization (unload and reload driver)\n");
+		dd->ipath_flags &= ~IPATH_INITTED;	/* needs re-init */
+		/* mark as having had error */
+		*dd->ipath_statusp |= IPATH_STATUS_HWERROR;
+		*dd->ipath_statusp &= ~IPATH_STATUS_IB_CONF;
+	}
+
+	if (!noprint && *msg)
+		_IPATH_UNIT_ERROR(t, "%s error\n", msg);
+	if (dd->ipath_sma_state_wanted & dd->ipath_flags) {
+		_IPATH_VDBG("sma wanted state %x, iflags now %x, waking\n",
+			    dd->ipath_sma_state_wanted, dd->ipath_flags);
+		wake_up_interruptible(&ipath_sma_state_wait);
+	}
+
+	if (chkerrpkts)
+		/* process possible error packets in hdrq */
+		ipath_kreceive(t);
+}
+
+/* must only be called if ipath_pd[port] is known to be allocated */
+static __inline__ void *ipath_get_egrbuf(const ipath_type t, uint32_t bufnum,
+					 int err)
+{
+	return devdata[t].ipath_port0_skbs ?
+	    (void *)devdata[t].ipath_port0_skbs[bufnum]->data : NULL;
+
+#ifdef _USE_FOR_DEBUGGING_ONLY
+	/*
+	 * want routine to be inlined and fast this is here so if we do ports
+	 * other than 0, I don't have to rewrite the code, since it's slightly
+	 * complicated
+	 */
+	if (port != 1) {
+		void *chunkbase;
+		/*
+		 * This calculation takes about 50 cycles.  Could do
+		 * what I did for protocol code, and have an array of
+		 * addresses, getting it down to just a few cycles per
+		 * lookup, at the cost of 16KB of memory.
+		 */
+		if (!devdata[t].ipath_pd[port]->port_rcvegrbuf_virt)
+			return NULL;
+		chunkbase = devdata[t].ipath_pd[port]->port_rcvegrbuf_virt
+		    [bufnum /
+		     devdata[t].ipath_pd[port]->port_rcvegrbufs_perchunk];
+		return (void *)(chunkbase +
+				(bufnum %
+				 devdata[t].ipath_pd[port]->
+				 port_rcvegrbufs_perchunk)
+				* devdata[t].ipath_rcvegrbufsize);
+	}
+#endif
+}
+
+/* receive an sma packet.  Separate for better overall optimization */
+static void ipath_rcv_sma(const ipath_type t, uint32_t tlen,
+			  uint64_t * rc, void *ebuf)
+{
+	int sindex, slen, elen;
+	void *smbuf;
+	uint8_t pad, *bthbytes;
+
+	ipath_stats.sps_sma_rpkts++;	/* another SMA packet received */
+
+	bthbytes = (uint8_t *) ((ips_message_header_typ *) & rc[1])->bth;
+
+	pad = (bthbytes[1] >> 4) & 3;
+	elen = tlen - (IPATH_SMA_HDRSZ + pad + (uint32_t) sizeof(uint32_t));
+	if (elen > (SMA_MAX_PKTSZ - IPATH_SMA_HDRSZ))
+		elen = SMA_MAX_PKTSZ - IPATH_SMA_HDRSZ;
+
+	spin_lock_irq(&ipath_sma_lock);
+	sindex = ipath_sma_next;
+	smbuf = ipath_sma_data[sindex].buf;
+	ipath_sma_data[sindex].unit = t;
+	slen = ipath_sma_data[ipath_sma_next].len;
+	memcpy(smbuf, &rc[1], IPATH_SMA_HDRSZ);
+	memcpy(smbuf + IPATH_SMA_HDRSZ, ebuf, elen);
+	if (slen) {
+		/*
+		 * overwriting a yet unread old one (buffer wrap), have to
+		 * advance ipath_sma_first to next oldest
+		 */
+
+		/* count OK packets that we drop */
+		ipath_stats.sps_krdrops++;
+		if (++ipath_sma_first >= IPATH_NUM_SMAPKTS)
+			ipath_sma_first = 0;
+	}
+	slen = ipath_sma_data[sindex].len = elen + IPATH_SMA_HDRSZ;
+	if (++ipath_sma_next >= IPATH_NUM_SMAPKTS)
+		ipath_sma_next = 0;
+	spin_unlock_irq(&ipath_sma_lock);
+}
+
+/*
+ * receive a packet for the layered (ethernet) driver.
+ * Separate routine for better overall optimization
+ */
+static void ipath_rcv_layer(const ipath_type t, uint32_t etail,
+			    uint32_t tlen, ether_header_typ * hdr)
+{
+	uint32_t elen;
+	uint8_t pad, *bthbytes;
+	struct sk_buff *skb;
+	struct sk_buff *nskb;
+	ipath_devdata *dd = &devdata[t];
+	ipath_portdata *pd;
+	unsigned long pa, pent;
+	uint64_t *egrbase;
+	uint64_t lenvalid;	/* in words */
+
+	if (dd->ipath_port0_skbs && hdr->sub_opcode == OPCODE_ENCAP) {
+		/*
+		 * Allocate a new sk_buff to replace the one we give
+		 * to the network stack.
+		 */
+		if (!(nskb = dev_alloc_skb(dd->ipath_ibmaxlen + 4))) {
+			/* count OK packets that we drop */
+			ipath_stats.sps_krdrops++;
+			return;
+		}
+
+		bthbytes = (uint8_t *) hdr->bth;
+		pad = (bthbytes[1] >> 4) & 3;
+		/* +CRC32 */
+		elen = tlen - (sizeof(*hdr) + pad + sizeof(uint32_t));
+
+		skb_reserve(nskb, 4);
+
+		skb = dd->ipath_port0_skbs[etail];
+		dd->ipath_port0_skbs[etail] = nskb;
+		skb_put(skb, elen);
+
+		pd = dd->ipath_pd[0];
+		lenvalid = (dd->ipath_ibmaxlen - pd->port_egrskip) >> 2;
+		lenvalid <<= INFINIPATH_RT_BUFSIZE_SHIFT;
+		lenvalid |= INFINIPATH_RT_VALID;
+		pa = virt_to_phys(nskb->data);
+		pa += pd->port_egrskip;
+		pent = (pa & INFINIPATH_RT_ADDR_MASK) | lenvalid;
+		/* This is simplified for port 0 */
+		egrbase = (uint64_t *) ((char *)(dd->ipath_kregbase) +
+					dd->ipath_rcvegrbase);
+		ipath_kput_memq(t, &egrbase[etail], pent);
+
+		dd->ipath_layer.l_rcv(t, hdr, skb);
+
+		/* another ether packet received */
+		ipath_stats.sps_ether_rpkts++;
+	} else if (hdr->sub_opcode == OPCODE_LID_ARP) {
+		if (dd->ipath_layer.l_rcv_lid)
+			dd->ipath_layer.l_rcv_lid(t, hdr);
+	}
+
+}
+
+/* called from interrupt handler for errors or receive interrupt */
+void ipath_kreceive(const ipath_type t)
+{
+	uint64_t *rc;
+	void *ebuf;
+	ipath_devdata *dd = &devdata[t];
+	const uint32_t rsize = dd->ipath_rcvhdrentsize;	/* words */
+	const uint32_t maxcnt = dd->ipath_rcvhdrcnt * rsize;	/* in words */
+	uint32_t etail = ~0U, l, hdrqtail, sma_this_time = 0;
+	ips_message_header_typ *hdr;
+	uint32_t eflags, i, etype, tlen, pkttot=0;
+	static uint64_t totcalls; /* stats, may eventually remove */
+	char emsg[128];
+
+	if (!dd->ipath_hdrqtailptr) {
+		_IPATH_UNIT_ERROR(t,
+				  "hdrqtailptr not set, can't do receives\n");
+		return;
+	}
+
+	if (test_and_set_bit(0, &dd->ipath_rcv_pending)) {
+		/* There is already a thread processing this queue. */
+		return;
+	}
+
+	if (dd->ipath_port0head == *dd->ipath_hdrqtailptr)
+		goto done;
+
+gotmore:
+	/*
+	 * read only once at start.  If in flood situation, this helps
+	 * performance slightly.  If more arrive while we are processing,
+	 * we'll come back here and do them
+	 */
+	hdrqtail = *dd->ipath_hdrqtailptr;
+
+	for (i = 0, l = dd->ipath_port0head; l != hdrqtail; i++) {
+		uint32_t qp;
+		uint8_t *bthbytes;
+
+
+		rc = (uint64_t *) (dd->ipath_pd[0]->port_rcvhdrq + (l << 2));
+		hdr = (ips_message_header_typ *) & rc[1];
+		/*
+		 * could make a network order version of IPATH_KD_QP, and
+		 * do the obvious shift before masking to speed this up.
+		 */
+		qp = ntohl(hdr->bth[1]) & 0xffffff;
+		bthbytes = (uint8_t *) hdr->bth;
+
+		eflags = ips_get_hdr_err_flags(rc);
+		etype = ips_get_rcv_type(rc);
+		tlen = ips_get_length_in_bytes(rc);	/* total length */
+		ebuf = NULL;
+		if (etype != RCVHQ_RCV_TYPE_EXPECTED) {
+			/*
+			 * it turns out that the chips uses an eager buffer for
+			 * all non-expected packets, whether it "needs"
+			 * one or not.	So always get the index, but
+			 * don't set ebuf (so we try to copy data)
+			 * unless the length requires it.
+			 */
+			etail = ips_get_index(rc);
+			if (tlen > sizeof(*hdr)
+			    || etype == RCVHQ_RCV_TYPE_NON_KD) {
+				ebuf = ipath_get_egrbuf(t, etail, 0);
+			}
+		}
+
+		/*
+		 * both tiderr and ipathhdrerr are set for all plain IB
+		 * packets; only ipathhdrerr should be set.
+		 */
+
+		if (etype != RCVHQ_RCV_TYPE_NON_KD
+		    && etype != RCVHQ_RCV_TYPE_ERROR
+		    && ips_get_ipath_ver(hdr->iph.ver_port_tid_offset) !=
+		    IPS_PROTO_VERSION) {
+			_IPATH_PDBG("Bad InfiniPath protocol version %x\n",
+				    etype);
+		}
+
+		if (eflags &
+		    ~(INFINIPATH_RHF_H_TIDERR | INFINIPATH_RHF_H_IHDRERR)) {
+			get_rhf_errstring(eflags, emsg, sizeof emsg);
+			_IPATH_PDBG
+			    ("RHFerrs %x hdrqtail=%x typ=%u tlen=%x opcode=%x egridx=%x: %s\n",
+			     eflags, l, etype, tlen, bthbytes[0],
+			     ips_get_index(rc), emsg);
+		} else if (etype == RCVHQ_RCV_TYPE_NON_KD) {
+			/*
+			 * If there is a userland SMA and this is a MAD packet,
+			 * then pass it to the userland SMA.
+			 */
+			if (ipath_sma_alive && qp <= 1) {
+				/*
+				 * count OK packets that we drop because
+				 * SMA isn't yet running, or because we
+				 * are in an sma flood (no point in
+				 * constantly acquiring the spin lock, and
+				 * overwriting previous packets).
+				 * Eventually things will recover.
+				 * Similarly if the sma consumer is
+				 * so far behind that we would overwrite
+				 * (yes, it's outside the lock)
+				 */
+				if (!ipath_sma_data_spare ||
+				    ipath_sma_data[ipath_sma_next].len ||
+				    ++sma_this_time > IPATH_NUM_SMAPKTS) {
+					ipath_stats.sps_krdrops++;
+				} else if (ebuf) {
+					ipath_rcv_sma(t, tlen, rc, ebuf);
+				}
+			} else if (dd->verbs_layer.l_rcv) {
+				dd->verbs_layer.l_rcv(t, rc + 1, ebuf, tlen);
+			} else {
+				_IPATH_VDBG("received IB packet, not SMA (QP=%x)\n",
+					    qp);
+			}
+		} else if (etype == RCVHQ_RCV_TYPE_EAGER) {
+			if (qp == IPATH_KD_QP && bthbytes[0] ==
+			    dd->ipath_layer.l_rcv_opcode && ebuf)
+				ipath_rcv_layer(t, etail, tlen,
+						(ether_header_typ *) hdr);
+			else
+				_IPATH_PDBG
+				    ("typ %x, opcode %x (eager, qp=%x), len %x; ignored\n",
+				     etype, bthbytes[0], qp, tlen);
+		} else if (etype == RCVHQ_RCV_TYPE_EXPECTED) {
+			_IPATH_DBG("Bug: Expected TID, opcode %x; ignored\n",
+				   hdr->bth[0] & 0xff);
+		} else if (eflags &
+			   (INFINIPATH_RHF_H_TIDERR | INFINIPATH_RHF_H_IHDRERR))
+		{
+			/*
+			 * This is a type 3 packet, only the LRH is in
+			 * the rcvhdrq, the rest of the header is in
+			 * the eager buffer.
+			 */
+			uint8_t opcode;
+			if (ebuf) {
+				bthbytes = (uint8_t *) ebuf;
+				opcode = *bthbytes;
+			} else
+				opcode = 0;
+			get_rhf_errstring(eflags, emsg, sizeof emsg);
+			_IPATH_DBG
+			    ("Err %x (%s), opcode %x, egrbuf %x, len %x\n",
+			     eflags, emsg, opcode, etail, tlen);
+		} else {
+			/*
+			 * error packet, type of error	unknown.
+			 * Probably type 3, but we don't know, so don't
+			 * even try to print the opcode, etc.
+			 */
+			_IPATH_DBG
+			    ("Error Pkt, but no eflags! egrbuf %x, len %x\n"
+			     "hdrq@%lx;hdrq+%x rhf: %llx; hdr %llx %llx %llx %llx %llx\n",
+			     etail, tlen, (unsigned long)rc, l, rc[0], rc[1],
+			     rc[2], rc[3], rc[4], rc[5]);
+		}
+		l += rsize;
+		if (l >= maxcnt)
+			l = 0;
+		/*
+		 * update for each packet, to help prevent overflows if we have
+		 * lots of packets.
+		 */
+		(void)ipath_kput_ureg(t, ur_rcvhdrhead, l, 0);
+		if (etype != RCVHQ_RCV_TYPE_EXPECTED)
+			(void)ipath_kput_ureg(t, ur_rcvegrindexhead, etail, 0);
+	}
+
+	pkttot += i;
+
+	dd->ipath_port0head = l;
+
+	if (hdrqtail != *dd->ipath_hdrqtailptr)
+		goto gotmore;	/* more arrived while we handled first batch */
+
+	if(pkttot > ipath_stats.sps_maxpkts_call)
+		ipath_stats.sps_maxpkts_call = pkttot;
+	ipath_stats.sps_port0pkts += pkttot;
+	ipath_stats.sps_avgpkts_call = ipath_stats.sps_port0pkts / ++totcalls;
+
+	if (sma_this_time)	/* only once at end, not each time */
+		wake_up_interruptible(&ipath_sma_wait);
+
+done:
+	clear_bit(0, &dd->ipath_rcv_pending);
+	smp_mb__after_clear_bit();
+}
+
+/*
+ * Update our shadow copy of the PIO availability register map, called
+ * whenever our local copy indicates we have run out of send buffers
+ * NOTE: This can be called from interrupt context by ipath_bufavail()
+ * and from non-interrupt context by ipath_getpiobuf().
+ */
+
+static void ipath_update_pio_bufs(const ipath_type t)
+{
+	unsigned long flags;
+	int i;
+	const unsigned piobregs = (unsigned)devdata[t].ipath_pioavregs;
+
+	/* If the generation (check) bits have changed, then we update the
+	 * busy bit for the corresponding PIO buffer.  This algorithm will
+	 * modify positions to the value they already have in some cases
+	 * (i.e., no change), but it's faster than changing only the bits
+	 * that have changed.
+	 *
+	 * We would like to do this atomicly, to avoid spinlocks in the
+	 * critical send path, but that's not really possible, given the
+	 * type of changes, and that this routine could be called on multiple
+	 * cpu's simultaneously, so we lock in this routine only, to avoid
+	 * conflicting updates; all we change is the shadow, and it's a
+	 * single 64 bit memory location, so by definition the update is
+	 * atomic in terms of what other cpu's can see in testing the
+	 * bits.  The spin_lock overhead isn't too bad, since it only
+	 * happens when all buffers are in use, so only cpu overhead,
+	 * not latency or bandwidth is affected.
+	 */
+#define _IPATH_ALL_CHECKBITS 0x5555555555555555ULL
+	if (!devdata[t].ipath_pioavailregs_dma) {
+		_IPATH_DBG("Update shadow pioavail, but regs_dma NULL!\n");
+		return;
+	}
+	if (infinipath_debug & __IPATH_VERBDBG) {
+		/* only if packet debug and verbose */
+		_IPATH_PDBG("Refill avail, dma0=%llx shad0=%llx, "
+			    "d1=%llx s1=%llx, d2=%llx s2=%llx, d3=%llx s3=%llx\n",
+			    devdata[t].ipath_pioavailregs_dma[0],
+			    devdata[t].ipath_pioavailshadow[0],
+			    devdata[t].ipath_pioavailregs_dma[1],
+			    devdata[t].ipath_pioavailshadow[1],
+			    devdata[t].ipath_pioavailregs_dma[2],
+			    devdata[t].ipath_pioavailshadow[2],
+			    devdata[t].ipath_pioavailregs_dma[3],
+			    devdata[t].ipath_pioavailshadow[3]);
+		if (piobregs > 4)
+			_IPATH_PDBG("2nd group, dma4=%llx shad4=%llx, "
+				    "d5=%llx s5=%llx, d6=%llx s6=%llx, d7=%llx s7=%llx\n",
+				    devdata[t].ipath_pioavailregs_dma[4],
+				    devdata[t].ipath_pioavailshadow[4],
+				    devdata[t].ipath_pioavailregs_dma[5],
+				    devdata[t].ipath_pioavailshadow[5],
+				    devdata[t].ipath_pioavailregs_dma[6],
+				    devdata[t].ipath_pioavailshadow[6],
+				    devdata[t].ipath_pioavailregs_dma[7],
+				    devdata[t].ipath_pioavailshadow[7]);
+	}
+	spin_lock_irqsave(&ipath_pioavail_lock, flags);
+	for (i = 0; i < piobregs; i++) {
+		uint64_t pchbusy, pchg, piov, pnew;
+		/* Chip Errata: bug 6641; even and odd qwords>3 are swapped */
+		piov = devdata[t].ipath_pioavailregs_dma[i > 3 ? i ^ 1 : i];
+		pchg =
+		    _IPATH_ALL_CHECKBITS & ~(devdata[t].
+					     ipath_pioavailshadow[i] ^ piov);
+		pchbusy = pchg << INFINIPATH_SENDPIOAVAIL_BUSY_SHIFT;
+		if (pchg && (pchbusy & devdata[t].ipath_pioavailshadow[i])) {
+			pnew = devdata[t].ipath_pioavailshadow[i] & ~pchbusy;
+			pnew |= piov & pchbusy;
+			devdata[t].ipath_pioavailshadow[i] = pnew;
+		}
+	}
+	spin_unlock_irqrestore(&ipath_pioavail_lock, flags);
+}
+
+static int ipath_do_user_init(ipath_portdata * pd,
+			      struct ipath_user_info *uinfo)
+{
+	int ret = 0;
+	ipath_type t = pd->port_unit;
+	ipath_devdata *dd = &devdata[t];
+	struct ipath_user_info kinfo;
+
+	if (copy_from_user(&kinfo, uinfo, sizeof kinfo))
+		ret = -EFAULT;
+	else {
+		/* for now, if major version is different, bail */
+		if ((kinfo.spu_userversion >> 16) != IPATH_USER_SWMAJOR) {
+			_IPATH_INFO
+			    ("User major version %d not same as driver major %d\n",
+			     kinfo.spu_userversion >> 16, IPATH_USER_SWMAJOR);
+			ret = -ENODEV;
+		} else {
+			if ((kinfo.spu_userversion & 0xffff) !=
+			    IPATH_USER_SWMINOR)
+				_IPATH_DBG
+				    ("User minor version %d not same as driver minor %d\n",
+				     kinfo.spu_userversion & 0xffff,
+				     IPATH_USER_SWMINOR);
+			if (kinfo.spu_rcvhdrsize) {
+				if ((ret =
+				     ipath_setrcvhdrsize(t,
+							 kinfo.spu_rcvhdrsize)))
+					goto done;
+			} else if (!dd->ipath_rcvhdrsize) {
+				/*
+				 * first user of field, kernel or user
+				 * code, and using default
+				 */
+				dd->ipath_rcvhdrsize = IPATH_DFLT_RCVHDRSIZE;
+				ipath_kput_kreg(pd->port_unit, kr_rcvhdrsize,
+						dd->ipath_rcvhdrsize);
+				_IPATH_VDBG
+				    ("Use default protocol header size %u\n",
+				     dd->ipath_rcvhdrsize);
+			}
+
+			pd->port_egrskip = kinfo.spu_egrskip;
+			if (pd->port_egrskip) {
+				if (pd->port_egrskip & 3) {
+					_IPATH_DBG
+					    ("eager skip 0x%x invalid, must be word multiple; using 0x%x\n",
+					     pd->port_egrskip,
+					     pd->port_egrskip & ~3);
+					pd->port_egrskip &= ~3;
+				}
+				_IPATH_DBG
+				    ("user reserves 0x%x bytes at start of eager TIDs\n",
+				     pd->port_egrskip);
+			}
+
+			/*
+			 * for now we do nothing with rcvhdrcnt:
+			 * kinfo.spu_rcvhdrcnt
+			 */
+
+			/*
+			 * set up for the rcvhdr Q tail register writeback
+			 * to user memory
+			 */
+			if (kinfo.spu_rcvhdraddr &&
+			    access_ok(VERIFY_WRITE, kinfo.spu_rcvhdraddr,
+				      sizeof(uint64_t))) {
+				uint64_t physaddr, uaddr, off, atmp;
+				struct page *pagep;
+				off = offset_in_page(kinfo.spu_rcvhdraddr);
+				uaddr =
+				    PAGE_MASK & (unsigned long)kinfo.
+				    spu_rcvhdraddr;
+				if ((ret = ipath_mlock_nocopy(uaddr, &pagep))) {
+					_IPATH_INFO
+					    ("Failed to lookup and lock address %llx for rcvhdrtail: errno %d\n",
+					     kinfo.spu_rcvhdraddr, -ret);
+					goto done;
+				}
+				ipath_stats.sps_pagelocks++;
+				pd->port_rcvhdrtail_uaddr = uaddr;
+				pd->port_rcvhdrtail_pagep = pagep;
+				pd->port_rcvhdrtail_kvaddr =
+				    page_address(pagep);
+				pd->port_rcvhdrtail_kvaddr += off;
+				physaddr = page_to_phys(pagep) + off;
+				_IPATH_VDBG
+				    ("port %d user addr %llx hdrtailaddr, %llx physical (off=%llx)\n",
+				     pd->port_port, kinfo.spu_rcvhdraddr,
+				     physaddr, off);
+				ipath_kput_kreg_port(t, kr_rcvhdrtailaddr,
+						     pd->port_port, physaddr);
+				atmp =
+				    ipath_kget_kreg64_port(t, kr_rcvhdrtailaddr,
+							   pd->port_port);
+				if (physaddr != atmp) {
+					_IPATH_UNIT_ERROR(t,
+							  "Catastrophic software error, RcvHdrTailAddr%u written as %llx, read back as %llx\n",
+							  pd->port_port,
+							  physaddr, atmp);
+					ret = -EINVAL;
+					goto done;
+				}
+			} else {
+				_IPATH_DBG
+				    ("Port %d rcvhdrtail addr %llx not valid\n",
+				     pd->port_port, kinfo.spu_rcvhdraddr);
+				ret = -EINVAL;
+				goto done;
+			}
+
+			/*
+			 * for right now, kernel piobufs are at end,
+			 * so port 1 is at 0
+			 */
+			pd->port_piobufs = dd->ipath_piobufbase +
+			    dd->ipath_pbufsport * (pd->port_port -
+						   1) * dd->ipath_palign;
+			_IPATH_VDBG("Set base of piobufs for port %u to 0x%x\n",
+				    pd->port_port, pd->port_piobufs);
+
+			/*
+			 * Now allocate the rcvhdr Q and eager TIDs;
+			 * skip the TID array for time being.
+			 * If pd->port_port > chip-supported, we need
+			 * to do extra stuff here to handle by handling
+			 * overflow through port 0, someday
+			 */
+			if (!(ret = ipath_create_rcvhdrq(pd)))
+				ret = ipath_create_user_egr(pd);
+			if (!ret) {	/* enable receives now */
+				uint64_t head;
+				uint32_t head32;
+				/* atomically set enable bit for this port */
+				atomic_set_mask(1U <<
+						(INFINIPATH_R_PORTENABLE_SHIFT +
+						 pd->port_port),
+						&dd->ipath_rcvctrl);
+
+				/*
+				 * set the head registers for this port
+				 * to the current values of the tail
+				 * pointers, since we don't know if they
+				 * were updated on last use of the port.
+				 */
+				head32 =
+				    ipath_kget_ureg32(t, ur_rcvhdrtail,
+						      pd->port_port);
+				head = (uint64_t) head32;
+				ipath_kput_ureg(t, ur_rcvhdrhead, head,
+						pd->port_port);
+				head32 =
+				    ipath_kget_ureg32(t, ur_rcvegrindextail,
+						      pd->port_port);
+				ipath_kput_ureg(t, ur_rcvegrindexhead, head32,
+						pd->port_port);
+				dd->ipath_lastegrheads[pd->port_port] = ~0;
+				dd->ipath_lastrcvhdrqtails[pd->port_port] = ~0;
+				_IPATH_VDBG
+				    ("Wrote port%d head %llx, egrhead %x from tail regs\n",
+				     pd->port_port, head, head32);
+				/* start at beginning after open */
+				pd->port_tidcursor = 0;
+				{
+					/*
+					 * now enable the port; the tail
+					 * registers will be written to
+					 * memory by the chip as soon
+					 * as it sees the write to
+					 * kr_rcvctrl.  The update only
+					 * happens on transition from 0
+					 * to 1, so clear it first, then
+					 * set it as part of enabling
+					 * the port.  This will (very
+					 * briefly) affect any other open
+					 * ports, but it shouldn't be long
+					 * enough to be an issue.
+					 */
+					ipath_kput_kreg(t, kr_rcvctrl,
+							dd->
+							ipath_rcvctrl &
+							~INFINIPATH_R_TAILUPD);
+					ipath_kput_kreg(t, kr_rcvctrl,
+							dd->ipath_rcvctrl);
+				}
+			}
+		}
+	}
+
+done:
+	return ret;
+}
+
+static int ipath_get_baseinfo(ipath_portdata * pd,
+			      struct ipath_base_info *ubase)
+{
+	int ret = 0;
+	struct ipath_base_info kbase;
+	ipath_devdata *dd = &devdata[pd->port_unit];
+
+	/* be sure anything we don't set is 0ed */
+	memset(&kbase, 0, sizeof kbase);
+	kbase.spi_rcvhdr_cnt = dd->ipath_rcvhdrcnt;
+	kbase.spi_rcvhdrent_size = dd->ipath_rcvhdrentsize;
+	kbase.spi_tidegrcnt = dd->ipath_rcvegrcnt;
+	kbase.spi_rcv_egrbufsize = dd->ipath_rcvegrbufsize;
+	kbase.spi_rcv_egrbuftotlen = pd->port_rcvegrbuf_chunks * PAGE_SIZE * (1 << pd->port_rcvegrbuf_order);	/* have to mmap whole thing */
+	kbase.spi_rcv_egrperchunk = pd->port_rcvegrbufs_perchunk;
+	kbase.spi_rcv_egrchunksize = kbase.spi_rcv_egrbuftotlen /
+	    pd->port_rcvegrbuf_chunks;
+	kbase.spi_tidcnt = dd->ipath_rcvtidcnt;
+	/*
+	 * for this use, may be ipath_cfgports summed over all chips that
+	 * are are configured and present
+	 */
+	kbase.spi_nports = dd->ipath_cfgports;
+	kbase.spi_unit = pd->port_unit;	/* unit (chip/board) our port is on */
+	/* for now, only a single page */
+	kbase.spi_tid_maxsize = PAGE_SIZE;
+
+	/*
+	 * doing this per port, and based on the skip value, etc.
+	 * This has to be the actual buffer size, since the protocol
+	 * code treats it as an array.
+	 *
+	 * These have to be set to user addresses in the user code via mmap
+	 * These values are used on return to user code for the mmap target
+	 * addresses only.  For 32 bit, same 44 bit address problem, so use
+	 * the physical address, not virtual.  Before 2.6.11, using the
+	 * page_address() macro worked, but in 2.6.11, even that returns
+	 * the full 64 bit address (upper bits all 1's).
+	 * So far, using the physical addresses (or chip offsets, for
+	 * chip mapping) works, but no doubt some future kernel release
+	 * will chang that, and we'll be on to yet another method of
+	 * dealing with this
+	 */
+	kbase.spi_rcvhdr_base = (uint64_t) pd->port_rcvhdrq_phys;
+	kbase.spi_rcv_egrbufs = (uint64_t) pd->port_rcvegr_phys;
+	kbase.spi_pioavailaddr = (uint64_t) dd->ipath_pioavailregs_phys;
+	kbase.spi_status = (uint64_t) kbase.spi_pioavailaddr +
+	    (void *)dd->ipath_statusp - (void *)dd->ipath_pioavailregs_dma;
+	kbase.spi_piobufbase = (uint64_t) pd->port_piobufs;
+	kbase.__spi_uregbase =
+	    dd->ipath_uregbase + dd->ipath_palign * pd->port_port;
+
+	kbase.spi_pioindex = dd->ipath_pbufsport * (pd->port_port - 1);
+	kbase.spi_piocnt = dd->ipath_pbufsport;
+	kbase.spi_pioalign = dd->ipath_palign;
+
+	kbase.spi_qpair = IPATH_KD_QP;
+	kbase.spi_piosize = dd->ipath_ibmaxlen;
+	kbase.spi_mtu = dd->ipath_ibmaxlen;	/* maxlen, not ibmtu */
+	kbase.spi_port = pd->port_port;
+	kbase.spi_sw_version = IPATH_KERN_SWVERSION;
+	kbase.spi_hw_version = dd->ipath_revision;
+
+	if (copy_to_user(ubase, &kbase, sizeof kbase))
+		ret = -EFAULT;
+
+	return ret;
+}
+
+/*
+ * return number of units supported by driver.  This is infinipath_max,
+ * unless there are no initted units.
+ */
+static int ipath_get_units(void)
+{
+	int i;
+
+	for (i = 0; i < infinipath_max; i++)
+		if (devdata[i].ipath_flags & IPATH_INITTED)
+			return infinipath_max;
+	return 0;
+}
+
+/* write data to the EEPROM on the board */
+static int ipath_wr_eeprom(ipath_portdata * pd, struct ipath_eeprom_req *req)
+{
+	int ret = 0;
+	struct ipath_eeprom_req kreq;
+	void *buf = NULL;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;	/* not just any old user can write flash */
+	if (copy_from_user(&kreq, req, sizeof kreq))
+		return -EFAULT;
+	if (!kreq.addr || (kreq.offset + kreq.len) > 128) {
+		_IPATH_DBG
+		    ("called with NULL addr %llx, or bad cnt %u or offset %u\n",
+		     kreq.addr, kreq.len, kreq.offset);
+		return -EINVAL;
+	}
+
+	if (!(buf = vmalloc(kreq.len))) {
+		ret = -ENOMEM;
+		_IPATH_UNIT_ERROR(pd->port_unit,
+				  "Couldn't allocate memory to write %u bytes from eeprom\n",
+				  kreq.len);
+		goto done;
+	}
+	if (copy_from_user(buf, (void *)kreq.addr, kreq.len)) {
+		ret = -EFAULT;
+		goto done;
+	}
+	if (ipath_eeprom_write(pd->port_unit, kreq.offset, buf, kreq.len)) {
+		ret = -ENXIO;
+		_IPATH_UNIT_ERROR(pd->port_unit,
+				  "Failed write to eeprom %u bytes offset %u\n",
+				  kreq.len, kreq.offset);
+	}
+
+done:
+	if (buf)
+		vfree(buf);
+	return ret;
+}
+
+/* read data from the EEPROM on the board */
+int ipath_rd_eeprom(const ipath_type port_unit, struct ipath_eeprom_req *req)
+{
+	int ret = 0;
+	struct ipath_eeprom_req kreq;
+	void *buf = NULL;
+
+	if (copy_from_user(&kreq, req, sizeof kreq))
+		return -EFAULT;
+	if (!kreq.addr || (kreq.offset + kreq.len) > 128) {
+		_IPATH_DBG
+		    ("called with NULL addr %llx, or bad cnt %u or offset %u\n",
+		     kreq.addr, kreq.len, kreq.offset);
+		return -EINVAL;
+	}
+
+	if (!(buf = vmalloc(kreq.len))) {
+		ret = -ENOMEM;
+		_IPATH_UNIT_ERROR(port_unit,
+				  "Couldn't allocate memory to read %u bytes from eeprom\n",
+				  kreq.len);
+		goto done;
+	}
+	if (ipath_eeprom_read(port_unit, kreq.offset, buf, kreq.len)) {
+		ret = -ENXIO;
+		_IPATH_UNIT_ERROR(port_unit,
+				  "Failed reading %u bytes offset %u from eeprom\n",
+				  kreq.len, kreq.offset);
+	}
+	if (copy_to_user((void *)kreq.addr, buf, kreq.len))
+		ret = -EFAULT;
+
+done:
+	if (buf)
+		vfree(buf);
+	return ret;
+}
+
+/*
+ * wait for something to happen on a port.  Currently this is 
+ * PIO buffer available, or a packet being received.  For now, at
+ * least, we wait no longer than 1/2 seconds on rcv, 1 tick on PIO, so
+ * we recover from any bugs (or, as we see in ips.c init and close, cases
+ * where other side isn't yet ready).
+ * NOTE: currently called only with PIO or RCV, never both, so path with both
+ * has not been tested
+ */
+static int ipath_wait_intr(ipath_portdata * pd, uint32_t flag)
+{
+	ipath_devdata *dd = &devdata[pd->port_unit];
+	/* stupid compiler can't tell it's initialized */
+	uint32_t im = 0;
+	uint32_t head, tail, timeo = 0, wflag = 0;
+
+	if (!(flag & (IPATH_WAIT_RCV | IPATH_WAIT_PIO)))
+		return -EINVAL;
+	if (flag & IPATH_WAIT_RCV) {
+		head = flag >> 16;
+		im = (1U << pd->port_port) << INFINIPATH_R_INTRAVAIL_SHIFT;
+		atomic_set_mask(im, &dd->ipath_rcvctrl);
+		/*
+		 * now, before blocking, make sure that head is still == tail,
+		 * reading from the chip, so we can be sure the interrupt enable
+		 * has made it to the chip.  If not equal, disable
+		 * interrupt again and return immediately.  This avoids
+		 * races, and the overhead of the chip read doesn't
+		 * matter much at this point, since we are waiting for
+		 * something anyway.
+		 */
+		ipath_kput_kreg(pd->port_unit, kr_rcvctrl, dd->ipath_rcvctrl);
+		tail =
+		    ipath_kget_ureg32(pd->port_unit, ur_rcvhdrtail,
+				      pd->port_port);
+		if (tail == head) {
+			timeo = HZ / 2;
+			wflag = IPATH_PORT_WAITING_RCV;
+		} else {
+			atomic_clear_mask(im, &dd->ipath_rcvctrl);
+			ipath_kput_kreg(pd->port_unit, kr_rcvctrl,
+					dd->ipath_rcvctrl);
+		}
+	}
+	if (flag & IPATH_WAIT_PIO) {
+		/*
+		 * this one's a bit worse than the receive case, in that we
+		 * can't really verify that at least one interrupt
+		 * will happen...
+		 * We do use a really short timeout, however
+		 */
+		timeo = 1;	/* if both, the short PIO timeout wins */
+		atomic_set_mask(1U << pd->port_port, &dd->ipath_portpiowait);
+		wflag |= IPATH_PORT_WAITING_PIO;
+		/*
+		 * this has a possible race with the ipath stuff, so do
+		 * it atomicly
+		 */
+		atomic_set_mask(INFINIPATH_S_PIOINTBUFAVAIL,
+				&dd->ipath_sendctrl);
+		ipath_kput_kreg(pd->port_unit, kr_sendctrl, dd->ipath_sendctrl);
+	}
+	if (wflag) {
+		pd->port_flag |= wflag;
+		wait_event_interruptible_timeout(pd->port_wait,
+						 (pd->port_flag & wflag) !=
+						 wflag, timeo);
+		if (wflag & pd->port_flag & IPATH_PORT_WAITING_PIO) {
+			/* timed out, no PIO interrupts */
+			atomic_clear_mask(IPATH_PORT_WAITING_PIO,
+					  &pd->port_flag);
+			pd->port_piowait_to++;
+			atomic_clear_mask(1U << pd->port_port,
+					  &dd->ipath_portpiowait);
+			/*
+			 * *don't* clear the pio interrupt enable;
+			 * let that happen in the interrupt handler;
+			 * else we have a race condition.
+			 */
+		}
+		if (wflag & pd->port_flag & IPATH_PORT_WAITING_RCV) {
+			/* timed out, no packets received */
+			atomic_clear_mask(IPATH_PORT_WAITING_RCV,
+					  &pd->port_flag);
+			pd->port_rcvwait_to++;
+			atomic_clear_mask(im, &dd->ipath_rcvctrl);
+			ipath_kput_kreg(pd->port_unit, kr_rcvctrl,
+					dd->ipath_rcvctrl);
+		}
+	} else {
+		/* else it's already happened, don't do wait_event overhead */
+		if (flag & IPATH_WAIT_RCV)
+			pd->port_rcvnowait++;
+		if (flag & IPATH_WAIT_PIO)
+			pd->port_pionowait++;
+	}
+	return 0;
+}
-- 
0.99.9n
