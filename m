Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311885AbSGKVcn>; Thu, 11 Jul 2002 17:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311898AbSGKVcm>; Thu, 11 Jul 2002 17:32:42 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:2780 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S311885AbSGKVcc>;
	Thu, 11 Jul 2002 17:32:32 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200207112135.OAA03801@csl.Stanford.EDU>
Subject: [CHECKER] 56 potential lock/unlock bugs in 2.5.8
To: linux-kernel@vger.kernel.org
Date: Thu, 11 Jul 2002 14:35:18 -0700 (PDT)
Cc: mc@cs.Stanford.EDU
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

enclosed is an error log for a checker that warns when a lock/disable
was not paired with an unlock/enable.  These errors could be tricky,
and they only got a quick inspection, so treat the reports as potential
rather than guaranteed bugs.

Run over 2.5.8 it found 56 potential errors.  

Dawson

(Note the path names in the summary are a bit mangled):

# BUGs	|	File Name
7	|	/wan/lmc_main.c
3	|	/usb/pwc-if.c
3	|	/drivers/i2c-core.c
3	|	/usb/ov511.c
2	|	/mtd/cfi_cmdset_0001.c
2	|	/fs/vfs.c
2	|	/net/irlap.c
2	|	/sound/es1371.c
2	|	/net/irlmp.c
2	|	/usb/dabusb.c
1	|	/message/i2o_core.c
1	|	/net/sch_teql.c
1	|	/media/cpia_pp.c
1	|	/usb/devices.c
1	|	/fs/file.c
1	|	/irda/ircomm_core.c
1	|	/drivers/dv1394.c
1	|	/char/riointr.c
1	|	/fs/dir.c
1	|	/usb/printer.c
1	|	/isa/gus_pcm.c
1	|	/irda/ircomm_tty.c
1	|	/fs/jfs_imap.c
1	|	/sound/es1968.c
1	|	/synth/emux_synth.c
1	|	/sound/pcm_lib.c
1	|	/net/tcp_ipv6.c
1	|	/drivers/pcilynx.c
1	|	/pci/ali5451.c
1	|	/drivers/acpi_processor.c
1	|	/net/smctr.c
1	|	/drivers/cdu31a.c
1	|	/2.5.8/shmem.c
1	|	/usb/usbvideo.c
1	|	/net/ali-ircc.c
1	|	/fs/namei.c
1	|	/pci/rme9652.c
1	|	/fs/svclock.c

############################################################
# 2.5.8 specific errors

#
---------------------------------------------------------
[BUG]  it seems like one.
/u2/engler/mc/oses/linux/2.5.8/mm/shmem.c:554:shmem_getpage_locked: ERROR:A_B:506:554:Did not reverse 'spin_lock' [COUNTER=spin_lock:506] [fit=3] [fit_fn=2] [fn_ex=5] [fn_counter=1] [ex=5619] [counter=272] [z = 1.34804760770983] [fn-z = -1.31122013621437]

	entry = shmem_alloc_entry (info, idx);
	if (IS_ERR(entry))
		return (void *)entry;

Start --->
	spin_lock (&info->lock);

	... DELETED 42 lines ...

			goto wait_retry;

		error = move_from_swap_cache(page, idx, mapping);
		if (error < 0) {
			UnlockPage(page);
Error --->
			return ERR_PTR(error);
		}

		swap_free(*entry);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.5.8/drivers/mtd/chips/cfi_cmdset_0001.c:782:do_write_buffer: ERROR:A_B:700:782:Did not reverse 'spin_lock' [COUNTER=spin_lock:700] [fit=3] [fit_fn=1] [fn_ex=5] [fn_counter=1] [ex=5619] [counter=272] [z = 1.34804760770983] [fn-z = -1.31122013621437]
	/* Let's determine this according to the interleave only once */
	status_OK = CMD(0x80);

	timeo = jiffies + HZ;
 retry:
Start --->
	spin_lock_bh(chip->mutex);

	... DELETED 76 lines ...

			map->write16 (map, *((__u16*)buf)++, adr+z);
		} else if (cfi_buswidth_is_4()) {
			map->write32 (map, *((__u32*)buf)++, adr+z);
		} else {
			DISABLE_VPP(map);
Error --->
			return -EINVAL;
		}
	}
	/* GO GO GO */
---------------------------------------------------------
[BUG]  this seems like a security hole as well.
/u2/engler/mc/oses/linux/2.5.8/drivers/usb/class/printer.c:649:usblp_write: ERROR:A_B:614:649:Did not reverse 'down' [COUNTER=down:614] [fit=6] [fit_fn=1] [fn_ex=5] [fn_counter=1] [ex=1231] [counter=170] [z = -12.2522803630056] [fn-z = -1.31122013621437]
				}
			}
			remove_wait_queue(&usblp->wait, &wait);
		}

Start --->
		down (&usblp->sem);

	... DELETED 29 lines ...


		usblp->writeurb->transfer_buffer_length = (count - writecount) < USBLP_BUF_SIZE ?
							  (count - writecount) : USBLP_BUF_SIZE;

		if (copy_from_user(usblp->writeurb->transfer_buffer, buffer + writecount,
Error --->
				usblp->writeurb->transfer_buffer_length)) return -EFAULT;

		usblp->writeurb->dev = usblp->dev;
		usblp->wcomplete = 0;
---------------------------------------------------------
[BUG]  i think it's a bug, line 1880 has:
          if (frames == 0 && runtime->status->state == SNDRV_PCM_STATE_PAUSED) {
                    err = -EPIPE;
                    goto _end;
          }
   which will skip the unlock.
/u2/engler/mc/oses/linux/2.5.8/sound/core/pcm_lib.c:1926:snd_pcm_lib_write1: ERROR:A_B:1892:1926:Did not reverse 'spin_lock' [COUNTER=spin_lock:1892] [fit=3] [fit_fn=4] [fn_ex=4] [fn_counter=1] [ex=5619] [counter=272] [z = 1.34804760770983] [fn-z = -1.53896752812773]
		appl_ptr = runtime->control->appl_ptr;
		appl_ofs = appl_ptr % runtime->buffer_size;
		spin_unlock_irq(&runtime->lock);
		if ((err = transfer(substream, appl_ofs, (void *)data, offset, frames)) < 0)
			goto _end;
Start --->
		spin_lock_irq(&runtime->lock);

	... DELETED 28 lines ...

			snd_pcm_tick_prepare(substream);
	}
 _end_unlock:
	spin_unlock_irq(&runtime->lock);
 _end:
Error --->
	return xfer > 0 ? xfer : err;
}

snd_pcm_sframes_t snd_pcm_lib_write(snd_pcm_substream_t *substream, const void *buf, snd_pcm_uframes_t size)
---------------------------------------------------------
[BUG]  all other case arms call __sti(); however, it may be that safe_halt
       does something weird.
/u2/engler/mc/oses/linux/2.5.8/drivers/acpi/acpi_processor.c:566:acpi_processor_idle: ERROR:A_B:400:566: did not reverse '__cli' [COUNTER=__cli:400] [fit=5] [fit_fn=1] [fn_ex=4] [fn_counter=1] [ex=78] [counter=17] [z = -5.76670162618366] [fn-z = -1.53896752812773]

	/*
	 * Interrupts must be disabled during bus mastering calculations and
	 * for C2/C3 transitions.
	 */
Start --->
	__cli();

	... DELETED 160 lines ...

	 * from the previous and prepare to use the new.
	 */
	if (next_state != pr->power.state)
		acpi_processor_power_activate(pr, next_state);

Error --->
	return;
}


---------------------------------------------------------
[BUG]  i think the missing AG_UNLOCK is a bug --- all the other returns do it.
/u2/engler/mc/oses/linux/2.5.8/fs/jfs/jfs_imap.c:1453:diAlloc: ERROR:A_B:1444:1453:Did not reverse 'down' [COUNTER=down:1444] [fit=6] [fit_fn=2] [fn_ex=4] [fn_counter=1] [ex=1231] [counter=170] [z = -12.2522803630056] [fn-z = -1.53896752812773]

	/* get the ag number of this iag */
	agno = JFS_IP(pip)->agno;

	/* lock the AG inode map information */
Start --->
	AG_LOCK(imap, agno);

	/* Get read lock on imap inode */
	IREAD_LOCK(ipimap);

	/* get the iag number and read the iag */
	iagno = INOTOIAG(inum);
	if ((rc = diIAGRead(imap, iagno, &mp))) {
		IREAD_UNLOCK(ipimap);
Error --->
		return (rc);
	}
	iagp = (iag_t *) mp->data;

---------------------------------------------------------
[BUG]  seems like it --- the other denied_nolocks does do an up.
/u2/engler/mc/oses/linux/2.5.8/fs/lockd/svclock.c:361:nlmsvc_lock: ERROR:A_B:318:361:Did not reverse 'down' [COUNTER=down:318] [fit=6] [fit_fn=4] [fn_ex=4] [fn_counter=1] [ex=1231] [counter=170] [z = -12.2522803630056] [fn-z = -1.53896752812773]
				(long long)lock->fl.fl_start,
				(long long)lock->fl.fl_end,
				wait);

	/* Lock file against concurrent access */
Start --->
	down(&file->f_sema);

	... DELETED 37 lines ...

	/* If we don't have a block, create and initialize it. Then
	 * retry because we may have slept in kmalloc. */
	if (block == NULL) {
		dprintk("lockd: blocking on this lock (allocating).\n");
		if (!(block = nlmsvc_create_block(rqstp, file, lock, cookie)))
Error --->
			return nlm_lck_denied_nolocks;
		goto again;
	}

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.5.8/drivers/mtd/chips/cfi_cmdset_0001.c:782:do_write_buffer: ERROR:A_B:756:782:Did not reverse 'spin_lock' [COUNTER=spin_lock:756] [fit=3] [fit_fn=6] [fn_ex=3] [fn_counter=1] [ex=5619] [counter=272] [z = 1.34804760770983] [fn-z = -1.83532587096449]
		if ((status & status_OK) == status_OK)
			break;

		spin_unlock_bh(chip->mutex);
		cfi_udelay(1);
Start --->
		spin_lock_bh(chip->mutex);

	... DELETED 20 lines ...

			map->write16 (map, *((__u16*)buf)++, adr+z);
		} else if (cfi_buswidth_is_4()) {
			map->write32 (map, *((__u32*)buf)++, adr+z);
		} else {
			DISABLE_VPP(map);
Error --->
			return -EINVAL;
		}
	}
	/* GO GO GO */
---------------------------------------------------------
[BUG]  INIT_REQUEST returns if queue is empty.
/u2/engler/mc/oses/linux/2.5.8/drivers/cdrom/cdu31a.c:1609:do_cdu31a_request: ERROR:A_B:1561:1609: did not reverse 'cli' [COUNTER=cli:1561] [fit=1] [fit_fn=2] [fn_ex=2] [fn_counter=1] [ex=1454] [counter=37] [z = 4.46194604933914] [fn-z = -2.25170500701057]
	/* 
	 * Make sure no one else is using the driver; wait for them
	 * to finish if it is so.
	 */
	save_flags(flags);
Start --->
	cli();

	... DELETED 42 lines ...


		if (!sony_spun_up) {
			scd_spinup();
		}

Error --->
		INIT_REQUEST;

		block = CURRENT->sector;
		nblock = CURRENT->nr_sectors;
---------------------------------------------------------
[BUG] if the if-statement doesn't trigger, sti() is not called.  plus,
the loop seems really busted, since err is never updated.
/u2/engler/mc/oses/linux/2.5.8/drivers/net/tokenring/smctr.c:4585:smctr_rx_frame: ERROR:A_B:4527:4585: did not reverse 'cli' [COUNTER=cli:4527] [fit=1] [fit_fn=1] [fn_ex=2] [fn_counter=1] [ex=1454] [counter=37] [z = 4.46194604933914] [fn-z = -2.25170500701057]
        __u8 *pbuff;

        if(smctr_debug > 10)
                printk("%s: smctr_rx_frame\n", dev->name);

Start --->
        cli();

	... DELETED 52 lines ...


                if(err != SUCCESS)
                        break;
        }

Error --->
        return (err);
}

static int smctr_send_dat(struct net_device *dev)
---------------------------------------------------------
[BUG]  i think this is a security hole.
/u2/engler/mc/oses/linux/2.5.8/fs/hpfs/dir.c:194:hpfs_lookup: ERROR:A_B:192:194: did not reverse 'lock_kernel' [COUNTER=lock_kernel:192] [fit=2] [fit_fn=1] [fn_ex=2] [fn_counter=1] [ex=780] [counter=24] [z = 2.62144158993226] [fn-z = -2.25170500701057]
	ino_t ino;
	int err;
	struct inode *result = NULL;
	struct hpfs_inode_info *hpfs_result;

Start --->
	lock_kernel();
	if ((err = hpfs_chk_name((char *)name, &len))) {
Error --->
		if (err == -ENAMETOOLONG) return ERR_PTR(-ENAMETOOLONG);
		goto end_add;
	}

---------------------------------------------------------
[BUG] unlocked elsewhere, and return value of this function is not checked.
/u2/engler/mc/oses/linux/2.5.8/sound/pci/rme9652/rme9652.c:522:rme9652_set_rate: ERROR:A_B:493:522:Did not reverse 'spin_lock' [COUNTER=spin_lock:493] [fit=3] [fit_fn=10] [fn_ex=2] [fn_counter=1] [ex=5619] [counter=272] [z = 1.34804760770983] [fn-z = -2.25170500701057]
	   Note that a similar but essentially insoluble problem
	   exists for externally-driven rate changes. All we can do
	   is to flag rate changes in the read/write routines.
	 */

Start --->
	spin_lock_irq(&rme9652->lock);

	... DELETED 23 lines ...

			reject_if_open = 1;
		}
		rate = RME9652_DS | RME9652_freq;
		break;
	default:
Error --->
		return -EINVAL;
	}

	if (reject_if_open &&
---------------------------------------------------------
[BUG]  recheck: seems unlikely, though it does seem that the path is valid.
/u2/engler/mc/oses/linux/2.5.8/net/ipv6/tcp_ipv6.c:206:tcp_v6_get_port: ERROR:A_B:112:206:Did not reverse 'spin_lock' [COUNTER=spin_lock:112] [fit=3] [fit_fn=11] [fn_ex=2] [fn_counter=1] [ex=5619] [counter=272] [z = 1.34804760770983] [fn-z = -2.25170500701057]
		rover = tcp_port_rover;
		do {	rover++;
			if ((rover < low) || (rover > high))
				rover = low;
			head = &tcp_bhash[tcp_bhashfn(rover)];
Start --->
			spin_lock(&head->lock);

	... DELETED 88 lines ...


fail_unlock:
	spin_unlock(&head->lock);
fail:
	local_bh_enable();
Error --->
	return ret;
}

static __inline__ void __tcp_v6_hash(struct sock *sk)
---------------------------------------------------------
[BUG]  doesn't seem to initialize for retry, so if nothing else will deadlock?
/u2/engler/mc/oses/linux/2.5.8/drivers/usb/media/dabusb.c:608:dabusb_open: ERROR:A_B:604:608:Did not reverse 'down' [COUNTER=down:604] [fit=6] [fit_fn=16] [fn_ex=2] [fn_counter=1] [ex=1231] [counter=170] [z = -12.2522803630056] [fn-z = -2.25170500701057]
		schedule_timeout (HZ / 2);

		if (signal_pending (current)) {
			return -EAGAIN;
		}
Start --->
		down (&s->mutex);
	}
	if (usb_set_interface (s->usbdev, _DABUSB_IF, 1) < 0) {
		err("set_interface failed");
Error --->
		return -EINVAL;
	}
	s->opened = 1;
	up (&s->mutex);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.5.8/drivers/message/i2o/i2o_core.c:729:i2o_claim_device: ERROR:A_B:716:729:Did not reverse 'down' [COUNTER=down:716] [fit=6] [fit_fn=15] [fn_ex=2] [fn_counter=1] [ex=1231] [counter=170] [z = -12.2522803630056] [fn-z = -2.25170500701057]
 *	is returned. On success zero is returned.
 */
 
int i2o_claim_device(struct i2o_device *d, struct i2o_handler *h)
{
Start --->
	down(&i2o_configuration_lock);
	if (d->owner) {
		printk(KERN_INFO "Device claim called, but dev already owned by %s!",
		       h->name);
		up(&i2o_configuration_lock);
		return -EBUSY;
	}
	d->owner=h;

	if(i2o_issue_claim(I2O_CMD_UTIL_CLAIM ,d->controller,d->lct_data.tid, 
			   I2O_CLAIM_PRIMARY))
	{
		d->owner = NULL;
Error --->
		return -EBUSY;
	}
	up(&i2o_configuration_lock);
	return 0;
---------------------------------------------------------
[BUG] ouch --- more evidence that we should tag & rank error paths
/u2/engler/mc/oses/linux/2.5.8/sound/pci/es1968.c:1450:snd_es1968_new_memory: ERROR:A_B:1437:1450:Did not reverse 'down' [COUNTER=down:1437] [fit=6] [fit_fn=7] [fn_ex=2] [fn_counter=1] [ex=1231] [counter=170] [z = -12.2522803630056] [fn-z = -2.25170500701057]
static esm_memory_t *snd_es1968_new_memory(es1968_t *chip, int size)
{
	esm_memory_t *buf;
	struct list_head *p;
	
Start --->
	down(&chip->memory_mutex);
	list_for_each(p, &chip->buf_list) {
		buf = list_entry(p, esm_memory_t, list);
		if (buf->empty && buf->size >= size)
			goto __found;
	}
	up(&chip->memory_mutex);
	return NULL;

__found:
	if (buf->size > size) {
		esm_memory_t *chunk = kmalloc(sizeof(*chunk), GFP_KERNEL);
		if (chunk == NULL)
Error --->
			return NULL;
		chunk->size = buf->size - size;
		chunk->buf = buf->buf + size;
		chunk->addr = buf->addr + size;
---------------------------------------------------------
[BUG]  doesn't seem to initialize for retry, so if nothing else will deadlock?
/u2/engler/mc/oses/linux/2.5.8/drivers/usb/media/dabusb.c:608:dabusb_open: ERROR:A_B:591:608:Did not reverse 'down' [COUNTER=down:591] [fit=6] [fit_fn=6] [fn_ex=2] [fn_counter=1] [ex=1231] [counter=170] [z = -12.2522803630056] [fn-z = -2.25170500701057]
		return -EIO;

	s = &dabusb[devnum - DABUSB_MINOR];

	dbg("dabusb_open");
Start --->
	down (&s->mutex);

	... DELETED 11 lines ...

		}
		down (&s->mutex);
	}
	if (usb_set_interface (s->usbdev, _DABUSB_IF, 1) < 0) {
		err("set_interface failed");
Error --->
		return -EINVAL;
	}
	s->opened = 1;
	up (&s->mutex);
---------------------------------------------------------
[BUG]  i'm pretty sure they want to goto out instead of out2.
/u2/engler/mc/oses/linux/2.5.8/sound/oss/es1371.c:1406:es1371_read: ERROR:A_B:1346:1406:Did not reverse 'down' [COUNTER=down:1346] [fit=6] [fit_fn=9] [fn_ex=2] [fn_counter=1] [ex=1231] [counter=170] [z = -12.2522803630056] [fn-z = -2.25170500701057]
		return -ESPIPE;
	if (s->dma_adc.mapped)
		return -ENXIO;
	if (!access_ok(VERIFY_WRITE, buffer, count))
		return -EFAULT;
Start --->
	down(&s->sem);

	... DELETED 54 lines ...

out:
	up(&s->sem);
out2:
	remove_wait_queue(&s->dma_adc.wait, &wait);
	set_current_state(TASK_RUNNING);
Error --->
	return ret;
}

static ssize_t es1371_write(struct file *file, const char *buffer, size_t count, loff_t *ppos)
---------------------------------------------------------
[BUG] does not release the global adap_lock.
/u2/engler/mc/oses/linux/2.5.8/drivers/i2c/i2c-core.c:277:i2c_del_adapter: ERROR:A_B:211:277:Did not reverse 'down' [COUNTER=down:211] [fit=6] [fit_fn=5] [fn_ex=2] [fn_counter=1] [ex=1231] [counter=170] [z = -12.2522803630056] [fn-z = -2.25170500701057]

int i2c_del_adapter(struct i2c_adapter *adap)
{
	int i,j,res;

Start --->
	ADAP_LOCK();

	... DELETED 60 lines ...

ERROR0:
	ADAP_UNLOCK();
	return res;
ERROR1:
	DRV_UNLOCK();
Error --->
	return res;
}


---------------------------------------------------------
[BUG]  the code seems pretty sure that it's not supposed to up, but i don't see
       the logic.
/u2/engler/mc/oses/linux/2.5.8/sound/oss/es1371.c:1491:es1371_write: ERROR:A_B:1425:1491:Did not reverse 'down' [COUNTER=down:1425] [fit=6] [fit_fn=12] [fn_ex=2] [fn_counter=1] [ex=1231] [counter=170] [z = -12.2522803630056] [fn-z = -2.25170500701057]
		return -ESPIPE;
	if (s->dma_dac2.mapped)
		return -ENXIO;
	if (!access_ok(VERIFY_READ, buffer, count))
		return -EFAULT;
Start --->
	down(&s->sem);	

	... DELETED 60 lines ...

	up(&s->sem);
out2:
	remove_wait_queue(&s->dma_dac2.wait, &wait);
out3:	
	set_current_state(TASK_RUNNING);
Error --->
	return ret;
}

/* No kernel lock - we have our own spinlock */
---------------------------------------------------------
[BUG]  is an assert, but doesn't enable.
/u2/engler/mc/oses/linux/2.5.8/net/irda/ircomm/ircomm_core.c:501:ircomm_proc_read: ERROR:A_B:495:501: did not reverse 'cli' [COUNTER=cli:495] [fit=1] [fit_fn=7] [fn_ex=1] [fn_counter=1] [ex=1454] [counter=37] [z = 4.46194604933914] [fn-z = -2.91998558035372]
{ 	
	struct ircomm_cb *self;
	unsigned long flags;
	
	save_flags(flags);
Start --->
	cli();

	len = 0;

	self = (struct ircomm_cb *) hashbin_get_first(ircomm);
	while (self != NULL) {
Error --->
		ASSERT(self->magic == IRCOMM_MAGIC, return len;);

		if(self->line < 0x10)
			len += sprintf(buf+len, "ircomm%d", self->line);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.5.8/fs/affs/namei.c:349:affs_rmdir: ERROR:A_B:345:349: did not reverse 'lock_kernel' [COUNTER=lock_kernel:345] [fit=2] [fit_fn=2] [fn_ex=1] [fn_counter=1] [ex=780] [counter=24] [z = 2.62144158993226] [fn-z = -2.91998558035372]
{
	int res;
	pr_debug("AFFS: rmdir(dir=%u, \"%.*s\")\n", (u32)dir->i_ino,
		 (int)dentry->d_name.len, dentry->d_name.name);

Start --->
	lock_kernel();

	/* WTF??? */
	if (!dentry->d_inode)
Error --->
		return -ENOENT;

	res = affs_remove_header(dentry);
	unlock_kernel();
---------------------------------------------------------
[BUG] not a good idea.
/u2/engler/mc/oses/linux/2.5.8/fs/intermezzo/file.c:303:presto_apply_write_policy: ERROR:A_B:299:303: did not reverse 'lock_kernel' [COUNTER=lock_kernel:299] [fit=2] [fit_fn=5] [fn_ex=1] [fn_counter=1] [ex=780] [counter=24] [z = 2.62144158993226] [fn-z = -2.91998558035372]
                        /* This is really heavy weight and should be fixed
                           ASAP. At most we should be recording the number
                           of bytes written and not locking the kernel, 
                           wait for permits, etc, on the write path. SHP
                        */
Start --->
                        lock_kernel();
                         if ( presto_get_permit(file->f_dentry->d_inode) < 0 ) {
                                 EXIT;
                                 /* we must be disconnected, not to worry */
Error --->
                                return; 
                         }
                         error = presto_journal_close
                                (&rec, fset, file, file->f_dentry, &new_file_ver);
---------------------------------------------------------
[BUG] --- there should be a lot more examples computed from this function though maybe broken mc?
/u2/engler/mc/oses/linux/2.5.8/fs/intermezzo/vfs.c:1951:lento_iopen: ERROR:A_B:1946:1951: did not reverse 'lock_kernel' [COUNTER=lock_kernel:1946] [fit=2] [fit_fn=4] [fn_ex=1] [fn_counter=1] [ex=780] [counter=24] [z = 2.62144158993226] [fn-z = -2.91998558035372]
        if (IS_ERR(tmp)) {
                EXIT;
                return PTR_ERR(tmp);
        }

Start --->
        lock_kernel();
again:  /* look the named file or a parent directory so we can get the cache */
        error = presto_walk(tmp, &nd);
        if ( error && error != -ENOENT ) {
                EXIT;
Error --->
                return error;
        } 
        if (error == -ENOENT)
                dentry = NULL;
---------------------------------------------------------
[BUG] all other exits release kernel lock.
/u2/engler/mc/oses/linux/2.5.8/fs/intermezzo/vfs.c:2052:lento_close: ERROR:A_B:2035:2052: did not reverse 'lock_kernel' [COUNTER=lock_kernel:2035] [fit=2] [fit_fn=3] [fn_ex=1] [fn_counter=1] [ex=780] [counter=24] [z = 2.62144158993226] [fn-z = -2.91998558035372]
        struct file * filp;
        struct dentry *dentry;
        int do_kml, do_expect;

        ENTRY;
Start --->
        lock_kernel();

	... DELETED 11 lines ...

                put_unused_fd(fd);
                FD_CLR(fd, files->close_on_exec);
                error = filp_close(filp, files);
        } else {
                EXIT;
Error --->
                return error;
        }

        if (error) {
---------------------------------------------------------
[BUG] returns with lock held.
/u2/engler/mc/oses/linux/2.5.8/sound/isa/gus/gus_pcm.c:790:snd_gf1_pcm_volume_put: ERROR:A_B:785:790:Did not reverse 'spin_lock' [COUNTER=spin_lock:785] [fit=3] [fit_fn=65] [fn_ex=1] [fn_counter=1] [ex=5619] [counter=272] [z = 1.34804760770983] [fn-z = -2.91998558035372]
	gus->gf1.pcm_volume_level_right1 = val2;
	gus->gf1.pcm_volume_level_left = snd_gf1_lvol_to_gvol_raw(val1 << 9) << 4;
	gus->gf1.pcm_volume_level_right = snd_gf1_lvol_to_gvol_raw(val2 << 9) << 4;
	spin_unlock_irqrestore(&gus->pcm_volume_level_lock, flags);
	/* are we active? */
Start --->
	spin_lock_irqsave(&gus->voice_alloc, flags);
	for (idx = 0; idx < 32; idx++) {
		pvoice = &gus->gf1.voices[idx];
		if (!pvoice->pcm)
			continue;
Error --->
		pcmp = snd_magic_cast(gus_pcm_private_t, pvoice->private_data, return -ENXIO);
		if (!(pcmp->flags & SNDRV_GF1_PCM_PFLG_ACTIVE))
			continue;
		/* load real volume - better precision */
---------------------------------------------------------
[BUG] sure seems like a bug.
/u2/engler/mc/oses/linux/2.5.8/drivers/ieee1394/dv1394.c:2635:dv1394_devfs_find: ERROR:A_B:2625:2635:Did not reverse 'spin_lock' [COUNTER=spin_lock:2625] [fit=3] [fit_fn=48] [fn_ex=1] [fn_counter=1] [ex=5619] [counter=272] [z = 1.34804760770983] [fn-z = -2.91998558035372]
dv1394_devfs_find( char *name)
{
	struct list_head *lh;
	struct dv1394_devfs_entry *p;

Start --->
	spin_lock( &dv1394_devfs_lock);
	if(!list_empty(&dv1394_devfs)) {
		list_for_each(lh, &dv1394_devfs) {
			p = list_entry(lh, struct dv1394_devfs_entry, list);
			if(!strncmp(p->name, name, sizeof(p->name))) {
				spin_unlock( &dv1394_devfs_lock);
				return p;
			}
		}
	}
Error --->
	return NULL;
}

static int dv1394_devfs_add_entry(struct video_card *video)
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.5.8/sound/synth/emux/emux_synth.c:102:snd_emux_note_on: ERROR:A_B:90:102:Did not reverse 'spin_lock' [COUNTER=spin_lock:90] [fit=3] [fit_fn=47] [fn_ex=1] [fn_counter=1] [ex=5619] [counter=272] [z = 1.34804760770983] [fn-z = -2.91998558035372]
#if 0 // seems not necessary
	/* Turn off the same note on the same channel. */
	terminate_note1(emu, key, chan, 0);
#endif

Start --->
	spin_lock_irqsave(&emu->voice_lock, flags);
	for (i = 0; i < nvoices; i++) {

		/* set up each voice parameter */
		/* at this stage, we don't trigger the voice yet. */

		if (table[i] == NULL)
			continue;

		vp = emu->ops.get_voice(emu, port);
		if (vp == NULL || vp->ch < 0)
			continue;
Error --->
		snd_assert(vp->emu != NULL && vp->hw != NULL, return);
		if (STATE_IS_PLAYING(vp->state))
			emu->ops.terminate(vp);

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.5.8/sound/pci/ali5451/ali5451.c:1444:snd_ali_capture_prepare: ERROR:A_B:1430:1444:Did not reverse 'spin_lock' [COUNTER=spin_lock:1430] [fit=3] [fit_fn=78] [fn_ex=1] [fn_counter=1] [ex=5619] [counter=272] [z = 1.34804760770983] [fn-z = -2.91998558035372]
	unsigned int PAN;
	unsigned int VOL;
	unsigned int EC;
	u8	 bValue;

Start --->
	spin_lock_irqsave(&codec->reg_lock, flags);

	snd_ali_printk("capture_prepare...\n");

	snd_ali_enable_special_channel(codec,pvoice->number);

	Delta = snd_ali_convert_rate(runtime->rate, 1);

	// Prepare capture intr channel
	if (pvoice->number == ALI_SPDIF_IN_CHANNEL) {

		unsigned int rate;
		
		if (codec->revision != ALI_5451_V02)
Error --->
			return -1;
		rate = snd_ali_get_spdif_in_rate(codec);
		if (rate == 0) {
			snd_printk("ali_capture_preapre: spdif rate detect err!\n");
---------------------------------------------------------
[BUG]  if port is not on the list, will exit with lock held.
/u2/engler/mc/oses/linux/2.5.8/drivers/media/video/cpia_pp.c:618:cpia_pp_detach: ERROR:A_B:599:618:Did not reverse 'spin_lock' [COUNTER=spin_lock:599] [fit=3] [fit_fn=57] [fn_ex=1] [fn_counter=1] [ex=5619] [counter=272] [z = 1.34804760770983] [fn-z = -2.91998558035372]

static void cpia_pp_detach (struct parport *port)
{
	struct cam_data *cpia;

Start --->
	spin_lock( &cam_list_lock_pp );

	... DELETED 13 lines ...

			kfree(cam);
			cpia->lowlevel_data = NULL;
			break;
		}
	}
Error --->
}

static void cpia_pp_attach (struct parport *port)
{
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.5.8/net/sched/sch_teql.c:473:teql_init: ERROR:A_B:468:473: did not reverse 'rtnl_lock' [COUNTER=rtnl_lock:468] [fit=4] [fit_fn=1] [fn_ex=1] [fn_counter=1] [ex=58] [counter=4] [z = -0.524444892073259] [fn-z = -2.91998558035372]
int __init teql_init(void)
#endif
{
	int err;

Start --->
	rtnl_lock();

	the_master.dev.priv = (void*)&the_master;
	err = dev_alloc_name(&the_master.dev, "teql%d");
	if (err < 0)
Error --->
		return err;
	memcpy(the_master.qops.id, the_master.dev.name, IFNAMSIZ);
	the_master.dev.init = teql_master_init;

---------------------------------------------------------
[BUG] nasty: sets uvd to null, then scribles on &uvd->lock.
/u2/engler/mc/oses/linux/2.5.8/drivers/usb/media/usbvideo.c:1060:usbvideo_AllocateDevice: ERROR:A_B:1054:1060:Did not reverse 'down' [COUNTER=down:1054] [fit=6] [fit_fn=22] [fn_ex=1] [fn_counter=1] [ex=1231] [counter=170] [z = -12.2522803630056] [fn-z = -2.91998558035372]
	dbg("Device entry #%d. at $%p", devnum, uvd);

	/* Not relying upon caller we increase module counter ourselves */
	usbvideo_ClientIncModCount(uvd);

Start --->
	down(&uvd->lock);
	for (i=0; i < USBVIDEO_NUMSBUF; i++) {
		uvd->sbuf[i].urb = usb_alloc_urb(FRAMES_PER_DESC, GFP_KERNEL);
		if (uvd->sbuf[i].urb == NULL) {
			err("usb_alloc_urb(%d.) failed.", FRAMES_PER_DESC);
			uvd->uvd_used = 0;
Error --->
			uvd = NULL;
			goto allocate_done;
		}
	}
---------------------------------------------------------
[BUG] does return with lock held..
/u2/engler/mc/oses/linux/2.5.8/drivers/usb/core/devices.c:578:usb_device_read: ERROR:A_B:571:578:Did not reverse 'down' [COUNTER=down:571] [fit=6] [fit_fn=32] [fn_ex=1] [fn_counter=1] [ex=1231] [counter=170] [z = -12.2522803630056] [fn-z = -2.91998558035372]
		return 0;
	if (!access_ok(VERIFY_WRITE, buf, nbytes))
		return -EFAULT;

	/* enumerate busses */
Start --->
	down (&usb_bus_list_lock);
	for (buslist = usb_bus_list.next; buslist != &usb_bus_list; buslist = buslist->next) {
		/* print devices for this bus */
		bus = list_entry(buslist, struct usb_bus, bus_list);
		/* recurse through all children of the root hub */
		ret = usb_device_dump(&buf, &nbytes, &skip_bytes, ppos, bus->root_hub, bus, 0, 0, 0);
		if (ret < 0)
Error --->
			return ret;
		total_written += ret;
	}
	up (&usb_bus_list_lock);
---------------------------------------------------------
[BUG] seems like it.
/u2/engler/mc/oses/linux/2.5.8/drivers/ieee1394/pcilynx.c:868:mem_read: ERROR:A_B:843:868:Did not reverse 'down' [COUNTER=down:843] [fit=6] [fit_fn=27] [fn_ex=1] [fn_counter=1] [ex=1231] [counter=170] [z = -12.2522803630056] [fn-z = -2.91998558035372]
        default:
                panic("pcilynx%d: unsupported md->type %d in %s",
                      md->lynx->id, md->type, __FUNCTION__);
        }

Start --->
        down(&md->lynx->mem_dma_mutex);

	... DELETED 19 lines ...

        }

        while (bcount >= 4) {
                retval = mem_dmaread(md, md->lynx->mem_dma_buffer_dma
                                     + count - bcount, bcount, off);
Error --->
                if (retval < 0) return retval;

                bcount -= retval;
                off += retval;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.5.8/net/irda/ircomm/ircomm_tty.c:526:ircomm_tty_close: ERROR:A_B:516:526: did not reverse 'cli' [COUNTER=cli:516] [fit=1] [fit_fn=10] [fn_ex=3] [fn_counter=2] [ex=1454] [counter=37] [z = 4.46194604933914] [fn-z = -3.59092423229804]

	if (!tty)
		return;

	save_flags(flags); 
Start --->
	cli();

	if (tty_hung_up_p(filp)) {
		MOD_DEC_USE_COUNT;
		restore_flags(flags);

		IRDA_DEBUG(0, __FUNCTION__ "(), returning 1\n");
		return;
	}

Error --->
	ASSERT(self != NULL, return;);
	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);

	if ((tty->count == 1) && (self->open_count != 1)) {
---------------------------------------------------------
[BUG]  seems to be a missing DRV_LOCK
/u2/engler/mc/oses/linux/2.5.8/drivers/i2c/i2c-core.c:368:i2c_del_driver: ERROR:A_B:328:368:Did not reverse 'down' [COUNTER=down:328] [fit=6] [fit_fn=36] [fn_ex=2] [fn_counter=2] [ex=1231] [counter=170] [z = -12.2522803630056] [fn-z = -4.12948320967011]

int i2c_del_driver(struct i2c_driver *driver)
{
	int i,j,k,res;

Start --->
	DRV_LOCK();

	... DELETED 34 lines ...

				       "dummy driver %s, adapter %s could "
				       "not be detached properly; driver "
				       "not unloaded!",driver->name,
				       adap->name);
				ADAP_UNLOCK();
Error --->
				return res;
			}
		} else {
			for (j=0;j<I2C_CLIENT_MAX;j++) { 
---------------------------------------------------------
[BUG]  does not seem to release DRV_LOCK in caller...
/u2/engler/mc/oses/linux/2.5.8/drivers/i2c/i2c-core.c:392:i2c_del_driver: ERROR:A_B:328:392:Did not reverse 'down' [COUNTER=down:328] [fit=6] [fit_fn=36] [fn_ex=2] [fn_counter=2] [ex=1231] [counter=170] [z = -12.2522803630056] [fn-z = -4.12948320967011]

int i2c_del_driver(struct i2c_driver *driver)
{
	int i,j,k,res;

Start --->
	DRV_LOCK();

	... DELETED 58 lines ...

						       not unloaded!",
						       driver->name,
						       client->addr,
						       adap->name);
						ADAP_UNLOCK();
Error --->
						return res;
					}
				}
			}
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.5.8/net/irda/irlap.c:1104:irlap_proc_read: ERROR:A_B:1098:1104: did not reverse 'cli' [COUNTER=cli:1098] [fit=1] [fit_fn=22] [fn_ex=1] [fn_counter=2] [ex=1454] [counter=37] [z = 4.46194604933914] [fn-z = -4.90076972114066]
	struct irlap_cb *self;
	unsigned long flags;
	int i = 0;
     
	save_flags(flags);
Start --->
	cli();

	len = 0;

	self = (struct irlap_cb *) hashbin_get_first(irlap);
	while (self != NULL) {
Error --->
		ASSERT(self != NULL, return -ENODEV;);
		ASSERT(self->magic == LAP_MAGIC, return -EBADR;);

		len += sprintf(buf+len, "irlap%d ", i++);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.5.8/net/irda/irlap.c:1105:irlap_proc_read: ERROR:A_B:1098:1105: did not reverse 'cli' [COUNTER=cli:1098] [fit=1] [fit_fn=22] [fn_ex=1] [fn_counter=2] [ex=1454] [counter=37] [z = 4.46194604933914] [fn-z = -4.90076972114066]
	struct irlap_cb *self;
	unsigned long flags;
	int i = 0;
     
	save_flags(flags);
Start --->
	cli();

	len = 0;

	self = (struct irlap_cb *) hashbin_get_first(irlap);
	while (self != NULL) {
		ASSERT(self != NULL, return -ENODEV;);
Error --->
		ASSERT(self->magic == LAP_MAGIC, return -EBADR;);

		len += sprintf(buf+len, "irlap%d ", i++);
		len += sprintf(buf+len, "state: %s\n", 
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.5.8/net/irda/irlmp.c:1680:irlmp_proc_read: ERROR:A_B:1673:1680: did not reverse 'cli' [COUNTER=cli:1673] [fit=1] [fit_fn=21] [fn_ex=1] [fn_counter=2] [ex=1454] [counter=37] [z = 4.46194604933914] [fn-z = -4.90076972114066]
	unsigned long flags;

	ASSERT(irlmp != NULL, return 0;);
	
	save_flags( flags);
Start --->
	cli();

	len = 0;
	
	len += sprintf( buf+len, "Unconnected LSAPs:\n");
	self = (struct lsap_cb *) hashbin_get_first( irlmp->unconnected_lsaps);
	while (self != NULL) {
Error --->
		ASSERT(self->magic == LMP_LSAP_MAGIC, return 0;);
		len += sprintf(buf+len, "lsap state: %s, ", 
			       irlsap_state[ self->lsap_state]);
		len += sprintf(buf+len, 
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.5.8/drivers/net/irda/ali-ircc.c:2052:ali_ircc_net_ioctl: ERROR:A_B:2041:2052: did not reverse 'cli' [COUNTER=cli:2041] [fit=1] [fit_fn=25] [fn_ex=1] [fn_counter=2] [ex=1454] [counter=37] [z = 4.46194604933914] [fn-z = -4.90076972114066]

	IRDA_DEBUG(2, __FUNCTION__ "(), %s, (cmd=0x%X)\n", dev->name, cmd);
	
	/* Disable interrupts & save flags */
	save_flags(flags);
Start --->
	cli();	
	
	switch (cmd) {
	case SIOCSBANDWIDTH: /* Set bandwidth */
		IRDA_DEBUG(1, __FUNCTION__ "(), SIOCSBANDWIDTH\n");
		/*
		 * This function will also be used by IrLAP to change the
		 * speed, so we still must allow for speed change within
		 * interrupt context.
		 */
		if (!in_interrupt() && !capable(CAP_NET_ADMIN))
Error --->
			return -EPERM;
		
		ali_ircc_change_speed(self, irq->ifr_baudrate);		
		break;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.5.8/net/irda/irlmp.c:1709:irlmp_proc_read: ERROR:A_B:1673:1709: did not reverse 'cli' [COUNTER=cli:1673] [fit=1] [fit_fn=21] [fn_ex=1] [fn_counter=2] [ex=1454] [counter=37] [z = 4.46194604933914] [fn-z = -4.90076972114066]
	unsigned long flags;

	ASSERT(irlmp != NULL, return 0;);
	
	save_flags( flags);
Start --->
	cli();

	... DELETED 30 lines ...

		len += sprintf(buf+len, "\n");

		len += sprintf(buf+len, "\n  Connected LSAPs:\n");
		self = (struct lsap_cb *) hashbin_get_first(lap->lsaps);
		while (self != NULL) {
Error --->
			ASSERT(self->magic == LMP_LSAP_MAGIC, return 0;);
			len += sprintf(buf+len, "  lsap state: %s, ", 
				       irlsap_state[ self->lsap_state]);
			len += sprintf(buf+len, 
---------------------------------------------------------
[BUG] double lock
/u2/engler/mc/oses/linux/2.5.8/drivers/char/rio/riointr.c:130:riopoll: ERROR:A_B:132:130:Did not reverse 'spin_lock' [COUNTER=spin_lock:132] [fit=3] [fit_fn=195] [fn_ex=1] [fn_counter=2] [ex=5619] [counter=272] [z = 1.34804760770983] [fn-z = -4.90076972114066]
	/*
	** okay, we've got a cpu that hasn't had a go recently 
	** - lets check to see what needs doing.
	*/
	for ( host=0; host<p->RIONumHosts; host++ ) {
Error --->
		struct Host *HostP = &p->RIOHosts[host];

Start --->
		rio_spin_lock( &HostP->HostLock );

		if ( ( (HostP->Flags & RUN_STATE) != RC_RUNNING ) ||
		     HostP->InIntr ) {
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.5.8/drivers/usb/media/pwc-if.c:1756:usb_pwc_disconnect: ERROR:A_B:1750:1756: did not reverse 'lock_kernel' [COUNTER=lock_kernel:1750] [fit=2] [fit_fn=21] [fn_ex=1] [fn_counter=3] [ex=780] [counter=24] [z = 2.62144158993226] [fn-z = -6.42364054837573]
{
	struct pwc_device *pdev;
	int hint;
	DECLARE_WAITQUEUE(wait, current);

Start --->
	lock_kernel();
	free_mem_leak();

	pdev = (struct pwc_device *)ptr;
	if (pdev == NULL) {
		Err("pwc_disconnect() Called without private pointer.\n");
Error --->
		return;
	}
	if (pdev->udev == NULL) {
		Err("pwc_disconnect() already called for %p\n", pdev);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.5.8/drivers/usb/media/pwc-if.c:1760:usb_pwc_disconnect: ERROR:A_B:1750:1760: did not reverse 'lock_kernel' [COUNTER=lock_kernel:1750] [fit=2] [fit_fn=21] [fn_ex=1] [fn_counter=3] [ex=780] [counter=24] [z = 2.62144158993226] [fn-z = -6.42364054837573]
{
	struct pwc_device *pdev;
	int hint;
	DECLARE_WAITQUEUE(wait, current);

Start --->
	lock_kernel();
	free_mem_leak();

	pdev = (struct pwc_device *)ptr;
	if (pdev == NULL) {
		Err("pwc_disconnect() Called without private pointer.\n");
		return;
	}
	if (pdev->udev == NULL) {
		Err("pwc_disconnect() already called for %p\n", pdev);
Error --->
		return;
	}
	if (pdev->udev != udev) {
		Err("pwc_disconnect() Woops: pointer mismatch udev/pdev.\n");
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.5.8/drivers/usb/media/pwc-if.c:1764:usb_pwc_disconnect: ERROR:A_B:1750:1764: did not reverse 'lock_kernel' [COUNTER=lock_kernel:1750] [fit=2] [fit_fn=21] [fn_ex=1] [fn_counter=3] [ex=780] [counter=24] [z = 2.62144158993226] [fn-z = -6.42364054837573]
{
	struct pwc_device *pdev;
	int hint;
	DECLARE_WAITQUEUE(wait, current);

Start --->
	lock_kernel();
	free_mem_leak();

	pdev = (struct pwc_device *)ptr;
	if (pdev == NULL) {
		Err("pwc_disconnect() Called without private pointer.\n");
		return;
	}
	if (pdev->udev == NULL) {
		Err("pwc_disconnect() already called for %p\n", pdev);
		return;
	}
	if (pdev->udev != udev) {
		Err("pwc_disconnect() Woops: pointer mismatch udev/pdev.\n");
Error --->
		return;
	}
#ifdef PWC_MAGIC	
	if (pdev->magic != PWC_MAGIC) {
---------------------------------------------------------
[BUG] really seems like each of these paths is an error.
/u2/engler/mc/oses/linux/2.5.8/drivers/usb/media/ov511.c:1232:ov51x_set_slave_ids: ERROR:A_B:1229:1232:Did not reverse 'down' [COUNTER=down:1229] [fit=6] [fit_fn=137] [fn_ex=1] [fn_counter=3] [ex=1231] [counter=170] [z = -12.2522803630056] [fn-z = -6.42364054837573]

/* Sets I2C read and write slave IDs. Returns <0 for error */
static int 
ov51x_set_slave_ids(struct usb_ov511 *ov, unsigned char sid)
{
Start --->
	down(&ov->i2c_lock);

	if (reg_w(ov, R51x_I2C_W_SID, sid) < 0)
Error --->
		return -EIO;

	if (reg_w(ov, R51x_I2C_R_SID, sid + 1) < 0)
		return -EIO;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.5.8/drivers/usb/media/ov511.c:1235:ov51x_set_slave_ids: ERROR:A_B:1229:1235:Did not reverse 'down' [COUNTER=down:1229] [fit=6] [fit_fn=137] [fn_ex=1] [fn_counter=3] [ex=1231] [counter=170] [z = -12.2522803630056] [fn-z = -6.42364054837573]

/* Sets I2C read and write slave IDs. Returns <0 for error */
static int 
ov51x_set_slave_ids(struct usb_ov511 *ov, unsigned char sid)
{
Start --->
	down(&ov->i2c_lock);

	if (reg_w(ov, R51x_I2C_W_SID, sid) < 0)
		return -EIO;

	if (reg_w(ov, R51x_I2C_R_SID, sid + 1) < 0)
Error --->
		return -EIO;

	if (ov51x_reset(ov, OV511_RESET_NOREGS) < 0)
		return -EIO;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.5.8/drivers/usb/media/ov511.c:1238:ov51x_set_slave_ids: ERROR:A_B:1229:1238:Did not reverse 'down' [COUNTER=down:1229] [fit=6] [fit_fn=137] [fn_ex=1] [fn_counter=3] [ex=1231] [counter=170] [z = -12.2522803630056] [fn-z = -6.42364054837573]

/* Sets I2C read and write slave IDs. Returns <0 for error */
static int 
ov51x_set_slave_ids(struct usb_ov511 *ov, unsigned char sid)
{
Start --->
	down(&ov->i2c_lock);

	if (reg_w(ov, R51x_I2C_W_SID, sid) < 0)
		return -EIO;

	if (reg_w(ov, R51x_I2C_R_SID, sid + 1) < 0)
		return -EIO;

	if (ov51x_reset(ov, OV511_RESET_NOREGS) < 0)
Error --->
		return -EIO;

	up(&ov->i2c_lock);

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.5.8/drivers/net/wan/lmc/lmc_main.c:172:lmc_ioctl: ERROR:A_B:164:172:Did not reverse 'spin_lock' [COUNTER=spin_lock:164] [fit=3] [fit_fn=213] [fn_ex=1] [fn_counter=7] [ex=5619] [counter=272] [z = 1.34804760770983] [fn-z = -10.7066137946303]

    /*
     * Most functions mess with the structure
     * Disable interrupts while we do the polling
     */
Start --->
    spin_lock_irqsave(&sc->lmc_lock, flags);

    switch (cmd) {
        /*
         * Return current driver state.  Since we keep this up
         * To date internally, just copy this out to the user.
         */
    case LMCIOCGINFO: /*fold01*/
Error --->
        LMC_COPY_TO_USER(ifr->ifr_data, &sc->ictl, sizeof (lmc_ctl_t));
        ret = 0;
        break;

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.5.8/drivers/net/wan/lmc/lmc_main.c:188:lmc_ioctl: ERROR:A_B:164:188:Did not reverse 'spin_lock' [COUNTER=spin_lock:164] [fit=3] [fit_fn=213] [fn_ex=1] [fn_counter=7] [ex=5619] [counter=272] [z = 1.34804760770983] [fn-z = -10.7066137946303]

    /*
     * Most functions mess with the structure
     * Disable interrupts while we do the polling
     */
Start --->
    spin_lock_irqsave(&sc->lmc_lock, flags);

	... DELETED 18 lines ...

        if(dev->flags & IFF_UP){
            ret = -EBUSY;
            break;
        }

Error --->
        LMC_COPY_FROM_USER(&ctl, ifr->ifr_data, sizeof (lmc_ctl_t));

        sc->lmc_media->set_status (sc, &ctl);

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.5.8/drivers/net/wan/lmc/lmc_main.c:218:lmc_ioctl: ERROR:A_B:164:218:Did not reverse 'spin_lock' [COUNTER=spin_lock:164] [fit=3] [fit_fn=213] [fn_ex=1] [fn_counter=7] [ex=5619] [counter=272] [z = 1.34804760770983] [fn-z = -10.7066137946303]

    /*
     * Most functions mess with the structure
     * Disable interrupts while we do the polling
     */
Start --->
    spin_lock_irqsave(&sc->lmc_lock, flags);

	... DELETED 48 lines ...

	    if (!capable(CAP_NET_ADMIN)) {
		ret = -EPERM;
		break;
	    }

Error --->
	    LMC_COPY_FROM_USER(&new_type, ifr->ifr_data, sizeof(u_int16_t));

            
	    if (new_type == old_type)
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.5.8/drivers/net/wan/lmc/lmc_main.c:255:lmc_ioctl: ERROR:A_B:164:255:Did not reverse 'spin_lock' [COUNTER=spin_lock:164] [fit=3] [fit_fn=213] [fn_ex=1] [fn_counter=7] [ex=5619] [counter=272] [z = 1.34804760770983] [fn-z = -10.7066137946303]

    /*
     * Most functions mess with the structure
     * Disable interrupts while we do the polling
     */
Start --->
    spin_lock_irqsave(&sc->lmc_lock, flags);

	... DELETED 85 lines ...

        sc->lmc_xinfo.link_status = sc->lmc_media->get_link_status (sc);
        sc->lmc_xinfo.mii_reg16 = lmc_mii_readreg (sc, 0, 16);

        sc->lmc_xinfo.Magic1 = 0xDEADBEEF;

Error --->
        LMC_COPY_TO_USER(ifr->ifr_data, &sc->lmc_xinfo,
                         sizeof (struct lmc_xinfo));
        ret = 0;

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.5.8/drivers/net/wan/lmc/lmc_main.c:286:lmc_ioctl: ERROR:A_B:164:286:Did not reverse 'spin_lock' [COUNTER=spin_lock:164] [fit=3] [fit_fn=213] [fn_ex=1] [fn_counter=7] [ex=5619] [counter=272] [z = 1.34804760770983] [fn-z = -10.7066137946303]

    /*
     * Most functions mess with the structure
     * Disable interrupts while we do the polling
     */
Start --->
    spin_lock_irqsave(&sc->lmc_lock, flags);

	... DELETED 116 lines ...

                (regVal & T1FRAMER_COFA_MASK) >> 2;
            sc->stats.severelyErroredFrameCount +=
                regVal & T1FRAMER_SEF_MASK;
        }

Error --->
        LMC_COPY_TO_USER(ifr->ifr_data, &sc->stats,
                         sizeof (struct lmc_statistics));

        ret = 0;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.5.8/drivers/net/wan/lmc/lmc_main.c:317:lmc_ioctl: ERROR:A_B:164:317:Did not reverse 'spin_lock' [COUNTER=spin_lock:164] [fit=3] [fit_fn=213] [fn_ex=1] [fn_counter=7] [ex=5619] [counter=272] [z = 1.34804760770983] [fn-z = -10.7066137946303]

    /*
     * Most functions mess with the structure
     * Disable interrupts while we do the polling
     */
Start --->
    spin_lock_irqsave(&sc->lmc_lock, flags);

	... DELETED 147 lines ...

        if(dev->flags & IFF_UP){
            ret = -EBUSY;
            break;
        }

Error --->
        LMC_COPY_FROM_USER(&ctl, ifr->ifr_data, sizeof (lmc_ctl_t));
        sc->lmc_media->set_circuit_type(sc, ctl.circuit_type);
        sc->ictl.circuit_type = ctl.circuit_type;
        ret = 0;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.5.8/drivers/net/wan/lmc/lmc_main.c:368:lmc_ioctl: ERROR:A_B:164:368:Did not reverse 'spin_lock' [COUNTER=spin_lock:164] [fit=3] [fit_fn=213] [fn_ex=1] [fn_counter=7] [ex=5619] [counter=272] [z = 1.34804760770983] [fn-z = -10.7066137946303]

    /*
     * Most functions mess with the structure
     * Disable interrupts while we do the polling
     */
Start --->
    spin_lock_irqsave(&sc->lmc_lock, flags);

	... DELETED 198 lines ...

            /*
             * Stop the xwitter whlie we restart the hardware
             */
            LMC_XMITTER_BUSY(dev);

Error --->
            LMC_COPY_FROM_USER(&xc, ifr->ifr_data, sizeof (struct lmc_xilinx_control));
            switch(xc.command){
            case lmc_xilinx_reset: /*fold02*/
                {

