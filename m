Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316437AbSFJDyO>; Sun, 9 Jun 2002 23:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316456AbSFJDyN>; Sun, 9 Jun 2002 23:54:13 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:20116 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S316437AbSFJDyK>;
	Sun, 9 Jun 2002 23:54:10 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200206100354.UAA17008@csl.Stanford.EDU>
Subject: [CHECKER] 18 potential missing unlocks in 2.4.17
To: linux-kernel@vger.kernel.org
Date: Sun, 9 Jun 2002 20:54:07 -0700 (PDT)
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

Run over 2.4.17 it found 18 errors:

# BUGs	|	File Name
3	|	/fs/vfs.c
2	|	/mtd/cfi_cmdset_0001.c
2	|	/drivers/trident.c
1	|	/drivers/i2c-core.c
1	|	/net/smctr.c
1	|	/irda/ircomm_core.c
1	|	/fs/file.c
1	|	/drivers/devices.c
1	|	/message/i2o_core.c
1	|	/net/tcp_ipv6.c
1	|	/net/sch_teql.c
1	|	/2.4.17/super.c
1	|	/irda/ircomm_tty.c
1	|	/drivers/dabusb.c

Dawson

---------------------------------------------------------
[BUG] if the if-statement doesn't trigger, sti() is not called.  plus,
the loop seems really busted, since err is never updated.
/u2/engler/mc/oses/linux/2.4.17/drivers/net/tokenring/smctr.c:4585:smctr_rx_frame: ERROR:A_B:4527:4585: did not reverse 'cli' [COUNTER=cli:4527] [fit=1] [fit_fn=1] [fn_ex=2] [fn_counter=1] [ex=1711] [counter=36] [z = 5.63698904269095] [fn-z = -2.25170500701057]
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
[BUG]  is an assert, but doesn't enable.
/u2/engler/mc/oses/linux/2.4.17/net/irda/ircomm/ircomm_core.c:504:ircomm_proc_read: ERROR:A_B:496:504: did not reverse 'cli' [COUNTER=cli:496] [fit=1] [fit_fn=4] [fn_ex=1] [fn_counter=1] [ex=1711] [counter=36] [z = 5.63698904269095] [fn-z = -2.91998558035372]
	struct ircomm_cb *self;
	unsigned long flags;
	int i=0;
	
	save_flags(flags);
Start --->
	cli();

	len = 0;

	len += sprintf(buf+len, "Instance %d:\n", i++);

	self = (struct ircomm_cb *) hashbin_get_first(ircomm);
	while (self != NULL) {
Error --->
		ASSERT(self->magic == IRCOMM_MAGIC, return len;);

		self = (struct ircomm_cb *) hashbin_get_next(ircomm);
 	} 
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/net/irda/ircomm/ircomm_tty.c:527:ircomm_tty_close: ERROR:A_B:517:527: did not reverse 'cli' [COUNTER=cli:517] [fit=1] [fit_fn=9] [fn_ex=3] [fn_counter=2] [ex=1711] [counter=36] [z = 5.63698904269095] [fn-z = -3.59092423229804]

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
[BUG]  nasty: macro that returns.
/u2/engler/mc/oses/linux/2.4.17/drivers/sound/trident.c:2702:trident_release: ERROR:A_B:2682:2702: did not reverse 'lock_kernel' [COUNTER=lock_kernel:2682] [fit=2] [fit_fn=1] [fn_ex=1] [fn_counter=1] [ex=471] [counter=21] [z = 0.744685923405709] [fn-z = -2.91998558035372]
	struct trident_state *state = (struct trident_state *)file->private_data;
	struct trident_card *card;
	struct dmabuf *dmabuf;
	unsigned long flags;

Start --->
	lock_kernel();

	... DELETED 14 lines ...

	/* stop DMA state machine and free DMA buffers/channels */
	down(&card->open_sem);

	if (file->f_mode & FMODE_WRITE) {
		stop_dac(state);
Error --->
		lock_set_fmt(state);

		unlock_set_fmt(state);
		dealloc_dmabuf(state);
---------------------------------------------------------
[BUG] all other exits release kernel lock.
/u2/engler/mc/oses/linux/2.4.17/fs/intermezzo/vfs.c:2071:lento_close: ERROR:A_B:2054:2071: did not reverse 'lock_kernel' [COUNTER=lock_kernel:2054] [fit=2] [fit_fn=2] [fn_ex=1] [fn_counter=1] [ex=471] [counter=21] [z = 0.744685923405709] [fn-z = -2.91998558035372]
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
[BUG] not a good idea.
/u2/engler/mc/oses/linux/2.4.17/fs/intermezzo/file.c:303:presto_apply_write_policy: ERROR:A_B:299:303: did not reverse 'lock_kernel' [COUNTER=lock_kernel:299] [fit=2] [fit_fn=3] [fn_ex=1] [fn_counter=1] [ex=471] [counter=21] [z = 0.744685923405709] [fn-z = -2.91998558035372]
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
/u2/engler/mc/oses/linux/2.4.17/fs/intermezzo/vfs.c:1970:lento_iopen: ERROR:A_B:1965:1970: did not reverse 'lock_kernel' [COUNTER=lock_kernel:1965] [fit=2] [fit_fn=6] [fn_ex=1] [fn_counter=1] [ex=471] [counter=21] [z = 0.744685923405709] [fn-z = -2.91998558035372]
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
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/mtd/chips/cfi_cmdset_0001.c:782:do_write_buffer: ERROR:A_B:700:782:Did not reverse 'spin_lock' [COUNTER=spin_lock:700] [fit=3] [fit_fn=1] [fn_ex=4] [fn_counter=1] [ex=3872] [counter=202] [z = 0.122205739732443] [fn-z = -1.53896752812773]
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
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/mtd/chips/cfi_cmdset_0001.c:782:do_write_buffer: ERROR:A_B:756:782:Did not reverse 'spin_lock' [COUNTER=spin_lock:756] [fit=3] [fit_fn=2] [fn_ex=3] [fn_counter=1] [ex=3872] [counter=202] [z = 0.122205739732443] [fn-z = -1.83532587096449]
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
[BUG]  from what i can tell, it does return with a lock held.
/u2/engler/mc/oses/linux/2.4.17/fs/super.c:605:get_sb_bdev: ERROR:A_B:588:605:Did not reverse 'spin_lock' [COUNTER=spin_lock:588] [fit=3] [fit_fn=3] [fn_ex=2] [fn_counter=1] [ex=3872] [counter=202] [z = 0.122205739732443] [fn-z = -2.25170500701057]
		goto out1;
	down_write(&s->s_umount);

	error = -EBUSY;
restart:
Start --->
	spin_lock(&sb_lock);

	... DELETED 11 lines ...

		if (!grab_super(old))
			goto restart;
		put_super(s);
		blkdev_put(bdev, BDEV_FS);
		path_release(&nd);
Error --->
		return old;
	}
	s->s_dev = dev;
	s->s_bdev = bdev;
---------------------------------------------------------
[BUG]  recheck: seems unlikely, though it does seem that the path is valid.
/u2/engler/mc/oses/linux/2.4.17/net/ipv6/tcp_ipv6.c:199:tcp_v6_get_port: ERROR:A_B:109:199:Did not reverse 'spin_lock' [COUNTER=spin_lock:109] [fit=3] [fit_fn=9] [fn_ex=2] [fn_counter=1] [ex=3872] [counter=202] [z = 0.122205739732443] [fn-z = -2.25170500701057]
		rover = tcp_port_rover;
		do {	rover++;
			if ((rover < low) || (rover > high))
				rover = low;
			head = &tcp_bhash[tcp_bhashfn(rover)];
Start --->
			spin_lock(&head->lock);

	... DELETED 84 lines ...


fail_unlock:
	spin_unlock(&head->lock);
fail:
	local_bh_enable();
Error --->
	return ret;
}

static __inline__ void __tcp_v6_hash(struct sock *sk)
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/net/sched/sch_teql.c:473:teql_init: ERROR:A_B:468:473: did not reverse 'rtnl_lock' [COUNTER=rtnl_lock:468] [fit=4] [fit_fn=1] [fn_ex=1] [fn_counter=1] [ex=57] [counter=4] [z = -0.558099820673741] [fn-z = -2.91998558035372]
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
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/message/i2o/i2o_core.c:727:i2o_claim_device: ERROR:A_B:714:727:Did not reverse 'down' [COUNTER=down:714] [fit=5] [fit_fn=8] [fn_ex=2] [fn_counter=1] [ex=926] [counter=148] [z = -13.2026997616315] [fn-z = -2.25170500701057]
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
[BUG] does not release the global adap_lock.
/u2/engler/mc/oses/linux/2.4.17/drivers/i2c/i2c-core.c:277:i2c_del_adapter: ERROR:A_B:211:277:Did not reverse 'down' [COUNTER=down:211] [fit=5] [fit_fn=9] [fn_ex=2] [fn_counter=1] [ex=926] [counter=148] [z = -13.2026997616315] [fn-z = -2.25170500701057]

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
[BUG]  doesn't seem to initialize for retry, so if nothing else will deadlock?
/u2/engler/mc/oses/linux/2.4.17/drivers/usb/dabusb.c:608:dabusb_open: ERROR:A_B:604:608:Did not reverse 'down' [COUNTER=down:604] [fit=5] [fit_fn=10] [fn_ex=2] [fn_counter=1] [ex=926] [counter=148] [z = -13.2026997616315] [fn-z = -2.25170500701057]
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
[BUG]  seems like it.
/u2/engler/mc/oses/linux/2.4.17/fs/intermezzo/vfs.c:925:presto_do_symlink: ERROR:A_B:897:925:Did not reverse 'down' [COUNTER=down:897] [fit=5] [fit_fn=12] [fn_ex=2] [fn_counter=1] [ex=926] [counter=148] [z = -13.2026997616315] [fn-z = -2.25170500701057]
        struct presto_version tgt_dir_ver, new_link_ver;
        struct inode_operations *iops;
        void *handle;

        ENTRY;
Start --->
        down(&dir->d_inode->i_zombie);

	... DELETED 22 lines ...

        handle = presto_trans_start(fset, dir->d_inode, PRESTO_OP_SYMLINK);
        if ( IS_ERR(handle) ) {
		presto_release_space(fset->fset_cache, PRESTO_REQHIGH + 4096); 
                printk("ERROR: presto_do_symlink: no space for transaction. Tell Peter.\n"); 
                EXIT;
Error --->
                return -ENOSPC;
        }
        DQUOT_INIT(dir->d_inode);
        lock_kernel();
---------------------------------------------------------
[BUG] macro returns.
/u2/engler/mc/oses/linux/2.4.17/drivers/sound/trident.c:2702:trident_release: ERROR:A_B:2698:2702:Did not reverse 'down' [COUNTER=down:2698] [fit=5] [fit_fn=15] [fn_ex=1] [fn_counter=1] [ex=926] [counter=148] [z = -13.2026997616315] [fn-z = -2.91998558035372]
	printk(KERN_ERR "trident: closing virtual channel %d, hard channel %d\n", 
		state->virt, dmabuf->channel->num);
#endif

	/* stop DMA state machine and free DMA buffers/channels */
Start --->
	down(&card->open_sem);

	if (file->f_mode & FMODE_WRITE) {
		stop_dac(state);
Error --->
		lock_set_fmt(state);

		unlock_set_fmt(state);
		dealloc_dmabuf(state);
---------------------------------------------------------
[BUG] does return with lock held..
/u2/engler/mc/oses/linux/2.4.17/drivers/usb/devices.c:501:usb_device_read: ERROR:A_B:494:501:Did not reverse 'down' [COUNTER=down:494] [fit=5] [fit_fn=18] [fn_ex=1] [fn_counter=1] [ex=926] [counter=148] [z = -13.2026997616315] [fn-z = -2.91998558035372]
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

