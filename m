Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131550AbRCQFfx>; Sat, 17 Mar 2001 00:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131554AbRCQFfo>; Sat, 17 Mar 2001 00:35:44 -0500
Received: from Xenon.Stanford.EDU ([171.64.66.201]:689 "EHLO
	Xenon.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S131550AbRCQFfa>; Sat, 17 Mar 2001 00:35:30 -0500
Date: Fri, 16 Mar 2001 21:34:44 -0800
From: Andy Chou <acc@CS.Stanford.EDU>
To: linux-kernel@vger.kernel.org
Cc: mc@CS.Stanford.EDU
Subject: [CHECKER] 16 potential locking bugs in 2.4.1
Message-ID: <20010316213444.A3592@Xenon.Stanford.EDU>
Reply-To: acc@CS.Stanford.EDU
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.1.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some more results from the MC project.  These are 16 errors found
in 2.4.1 related to inconsistent use of locks.  As usual, if you can
verify any of these or show that they are false positives, please let us
know by CC'ing mc@cs.stanford.edu.

-Andy Chou

PS.  I noticed that many of the locking errors I sent out previously for
2.3.99-pre6 were fixed.  Others remain still, and some of these may have
been reported earlier.

Where the bugs are:

+---------------------------------+----------------------------+
| file                            | fn                         |
+---------------------------------+----------------------------+
| drivers/char/cyclades.c         | cyy_interrupt              |
| drivers/i2o/i2o_block.c         | i2ob_del_device            |
| drivers/media/video/saa7110.c   | saa7110_write_block        |
| drivers/mtd/cfi_cmdset_0001.c   | cfi_intelext_suspend       |
| drivers/mtd/cfi_cmdset_0002.c   | cfi_amdext_suspend         |
| drivers/net/de4x5.c             | de4x5_interrupt            |
| drivers/net/pcmcia/wavelan_cs.c | wavelan_get_wireless_stats |
| drivers/net/sk98lin/skge.c      | SkGeChangeMtu              |
| drivers/net/wan/lmc/lmc_main.c  | lmc_ioctl                  |
| drivers/net/wan/lmc/lmc_main.c  | lmc_watchdog               |
| drivers/scsi/qla1280.c          | qla1280_intr_handler       |
| drivers/sound/cmpci.c           | cm_midi_release            |
| drivers/sound/trident.c         | trident_release            |
| fs/coda/psdev.c                 | coda_psdev_open            |
| fs/nfsd/vfs.c                   | nfsd_link                  |
| fs/nfsd/vfs.c                   | nfsd_symlink               |
+---------------------------------+----------------------------+

Listing:
-----------------------------------------------------------------------------
[BUG]
/u2/acc/oses/linux/2.3.99-pre6/drivers/net/sk98lin/skge.c:2511:SkGeChangeMtu: ERROR:LOCK:2418:2511: Inconsistent
lock using `spin_lock':2418

Flags variable re-used.

static int SkGeChangeMtu(struct net_device *dev, int NewMtu)
{
	...
--> Use "Flags"
	spin_lock_irqsave(&pAC->SlowPathLock, Flags);
	SkEventQueue(pAC, SKGE_RLMT, SK_RLMT_STOP, EvPara);
	SkEventDispatcher(pAC, pAC->IoBase);

	for (i=0; i<pAC->GIni.GIMacsFound; i++) {
--> Re-use of "Flags"
		spin_lock_irqsave(
			&pAC->TxPort[i][TX_PRIO_LOW].TxDesRingLock,
Flags);
	}
	...
	for (i=pAC->GIni.GIMacsFound-1; i>=0; i--) {
--> Restore bogus "Flags"
		spin_unlock_irqrestore(
			&pAC->TxPort[i][TX_PRIO_LOW].TxDesRingLock,
Flags);
	}

--> Restore bogus "Flags" again
	spin_unlock_irqrestore(&pAC->SlowPathLock, Flags);
	
	return 0;
} /* SkGeChangeMtu */


-----------------------------------------------------------------------------
[BUG] error condition
/u2/acc/oses/linux/2.4.1/drivers/i2o/i2o_block.c:1496:i2ob_del_device: ERROR:LOCK:1416:1496: Inconsistent
lock using `spin_lock':1416

void i2ob_del_device(struct i2o_controller *c, struct i2o_device *d)
{	
--> Lock
	spin_lock_irqsave(&io_request_lock, flags);
	...
	if(unit >= MAX_I2OB<<4)
	{
		printk(KERN_ERR "i2ob_del_device called, but not in dev
table!\n");
--> Forgot to unlock
		return;
	}
	...
}

-----------------------------------------------------------------------------
[BUG] GEM continue statement causes potential double lock
/u2/acc/oses/linux/2.4.1/drivers/char/cyclades.c:1174:cyy_interrupt: ERROR:LOCK:1174:1174: Double
lock using `spin_lock':1174

static void
cyy_interrupt(int irq, void *dev_id, struct pt_regs *regs)
{
    do{
        had_work = 0;
        for ( chip = 0 ; chip < cinfo->num_chips ; chip ++) {
	    ...
            while ( (status = cy_readb(base_addr+(CySVRR<<index))) !=
0x00) {
		...
                if (status & CySRReceive) { /* reception interrupt */
		    ...
--> Lock
		    spin_lock(&cinfo->card_lock);
		    ...
                    if(info->tty == 0){
			...
                    }else{ /* there is an open port for this data */
			...
                        if ( j == CyIVRRxEx ) { /* exception */
			    ...
                            if(data & info->ignore_status_mask){
				info->icount.rx++;
--> May cause double lock?
                                continue;
                            }
                            if (tty->flip.count < TTY_FLIPBUF_SIZE){


-----------------------------------------------------------------------------
[BUG] forgot to unlock
/u2/acc/oses/linux/2.4.1/drivers/media/video/saa7110.c:92:saa7110_write_block: ERROR:LOCK:79:92: Inconsistent
lock using `spin_lock':79

static
int saa7110_write_block(struct saa7110* decoder, unsigned const char
*data, unsigned int len)
{
--> Lock
	LOCK_I2C_BUS(decoder->bus);
        i2c_start(decoder->bus);
        i2c_sendbyte(decoder->bus,decoder->addr,I2C_DELAY);
	while (len-- > 0) {
                if (i2c_sendbyte(decoder->bus,*data,0)) {
                        i2c_stop(decoder->bus);
--> Missing Unlock?
                        return -EAGAIN;
                }
		decoder->reg[subaddr++] = *data++;
        }

-----------------------------------------------------------------------------
[BUG] GEM an off-by-one error?
/u2/acc/oses/linux/2.4.1/drivers/mtd/cfi_cmdset_0001.c:833:cfi_intelext_suspend: ERROR:LOCK:806:833: Double
lock using `spin_lock':806

static int cfi_intelext_suspend(struct mtd_info *mtd)
{
	...
	for (i=0; !ret && i<cfi->numchips; i++) {
		chip = &cfi->chips[i];

--> Lock
		spin_lock_bh(chip->mutex);

		switch(chip->state) {
		    ...
		default:
--> This leaves cfi->chips[i].mutex locked, exits switch statement,
increments i
			ret = -EAGAIN;
			break;
		}
	}

	/* Unlock the chips again */

	for (i--; i >=0; i--) {
		chip = &cfi->chips[i];

--> Double lock: decrements i, then re-locks the previous
cfi->chips[i].mutex
		spin_lock_bh(chip->mutex);
		...
	}
	
	return ret;
}

-----------------------------------------------------------------------------
[BUG] cut-and-paste same as the other bug above
/u2/acc/oses/linux/2.4.1/drivers/mtd/cfi_cmdset_0002.c:569:cfi_amdext_suspend: ERROR:LOCK:542:569: Double
lock using `spin_lock':542
-----------------------------------------------------------------------------
[BUG] leave locked and intr disabled on bus error
/u2/acc/oses/linux/2.4.1/drivers/net/de4x5.c:1665:de4x5_interrupt: ERROR:LOCK:1631:1665: Inconsistent
lock using `spin_lock':1631

static void
de4x5_interrupt(int irq, void *dev_id, struct pt_regs *regs)
{
    ...
--> Lock
    spin_lock(&lp->lock);
    ...	
    for (limit=0; limit<8; limit++) {
	...	    
	if (sts & STS_SE) {              /* Bus Error */
	    STOP_DE4X5;
	    printk("%s: Fatal bus error occurred, sts=%#8x, device
stopped.\n",
		   dev->name, sts);
--> Missing unlock?
	    return;
	}
    }

-----------------------------------------------------------------------------
[BUG] error condition
/u2/acc/oses/linux/2.4.1/drivers/net/pcmcia/wavelan_cs.c:2561:wavelan_get_wireless_stats: ERROR:LOCK:2528:2561: Inconsistent
lock using `spin_lock':2528

static iw_stats *
wavelan_get_wireless_stats(device *	dev)
{
  ...
--> Lock
  spin_lock_irqsave (&lp->lock, flags);

  if(lp == (net_local *) NULL)
--> Missing unlock?
    return (iw_stats *) NULL;

-----------------------------------------------------------------------------
[BUG] the LMC_COPY_TO_USER, LMC_COPY_FROM_USER macros can return, holding
lock
/u2/acc/oses/linux/2.4.1/drivers/net/wan/lmc/lmc_main.c:644:lmc_ioctl: ERROR:LOCK:171:644: Inconsistent
lock using `spin_lock':171
-----------------------------------------------------------------------------
[BUG] error condition
/u2/acc/oses/linux/2.4.1/drivers/net/wan/lmc/lmc_main.c:823:lmc_watchdog: ERROR:LOCK:661:823: Inconsistent
lock using `spin_lock':661

/* the watchdog process that cruises around */
static void lmc_watchdog (unsigned long data) /*fold00*/
{
--> Lock
    spin_lock_irqsave(&sc->lmc_lock, flags);

    if(sc->check != 0xBEAFCAFE){
        printk("LMC: Corrupt net_device stuct, breaking out\n");
--> Missing unlock?
        return;
    }

-----------------------------------------------------------------------------
[BUG] error condition
/u2/acc/oses/linux/2.4.1/drivers/scsi/qla1280.c:1594:qla1280_intr_handler: ERROR:LOCK:1522:1594: Inconsistent
lock using `spin_lock':1522

void qla1280_intr_handler(int irq, void *dev_id, struct pt_regs *regs)
{
--> Lock
    spin_lock_irqsave(&io_request_lock, cpu_flags);
    if(test_and_set_bit(QLA1280_IN_ISR_BIT, &ha->flags))
    {
        COMTRACE('X')
--> Missing unlock?
        return;
    }

-----------------------------------------------------------------------------
[BUG] error condition
/u2/acc/oses/linux/2.4.1/drivers/sound/cmpci.c:2073:cm_midi_release: ERROR:LOCK:2058:2073: Inconsistent
lock using `lock_kernel':2058

static int cm_midi_release(struct inode *inode, struct file *file)
{
--> Lock
	lock_kernel();
	if (file->f_mode & FMODE_WRITE) {
		add_wait_queue(&s->midi.owait, &wait);
		for (;;) {
			set_current_state(TASK_INTERRUPTIBLE);
			...
			if (file->f_flags & O_NONBLOCK) {
				remove_wait_queue(&s->midi.owait, &wait);
				set_current_state(TASK_RUNNING);
--> Missing unlock?
				return -EBUSY;
			}

-----------------------------------------------------------------------------
[BUG] GEM return hidden in macro
/u2/acc/oses/linux/2.4.1/drivers/sound/trident.c:2165:trident_release: ERROR:LOCK:2130:2165: Inconsistent
lock using `lock_kernel':2130

static int trident_release(struct inode *inode, struct file *file)
{
--> Lock
	lock_kernel();
	...
--> Macro may return
	VALIDATE_STATE(state);

-----------------------------------------------------------------------------
[BUG] error condition
/u2/acc/oses/linux/2.4.1/fs/coda/psdev.c:313:coda_psdev_open: ERROR:LOCK:290:313: Inconsistent
lock using `lock_kernel':290

static int coda_psdev_open(struct inode * inode, struct file * file)
{
--> Lock
	lock_kernel();
	...
	if(idx >= MAX_CODADEVS)
--> Missing unlock?
		return -ENODEV;
	...
	if(vcp->vc_inuse)
--> Missing unlock?
		return -EBUSY;
	
-----------------------------------------------------------------------------
[BUG] goto jumps out without unlocking
/u2/acc/oses/linux/2.4.1/fs/nfsd/vfs.c:1166:nfsd_symlink: ERROR:LOCK:1136:1166: Inconsistent
lock using `fh_lock':1136

int
nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
				char *fname, int flen,
				char *path,  int plen,
				struct svc_fh *resfhp,
				struct iattr *iap)
{
	...
--> Lock
	fh_lock(fhp);
	...
	if (IS_ERR(dnew))
--> Jump
		goto out_nfserr;
	...
out:
--> Missing unlock?
	return err;

out_nfserr:
	err = nfserrno(err);
--> Jump
	goto out;


-----------------------------------------------------------------------------
[BUG] goto jumps out with lock
/u2/acc/oses/linux/2.4.1/fs/nfsd/vfs.c:1227:nfsd_link: ERROR:LOCK:1199:1227: Inconsistent
lock using `fh_lock':1199

Same as above bug.

