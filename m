Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268503AbRGXWbq>; Tue, 24 Jul 2001 18:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268504AbRGXWbo>; Tue, 24 Jul 2001 18:31:44 -0400
Received: from myth8.Stanford.EDU ([171.64.15.22]:239 "EHLO myth8.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S268503AbRGXWb0>;
	Tue, 24 Jul 2001 18:31:26 -0400
Date: Tue, 24 Jul 2001 15:31:26 -0700 (PDT)
From: Evan Parker <nave@stanford.edu>
To: <linux-kernel@vger.kernel.org>
cc: <mc@cs.stanford.edu>
Subject: [CHECKER] null-deref errors for 2.4.7
Message-ID: <Pine.GSO.4.31.0107241528560.20515-100000@myth8.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Enclosed are 100 bugs found by an automatic checker that checks
the internal consistency of code with respect to pointer dereferences and
comparisons to NULL.

The checker was written with the following common sense rule in mind:
pointers should be checked against NULL before being dereferenced.  So
this checker looks for patterns in code in which a pointer is dereferenced,
or passed to a function such as memset or strcpy (that dereferences the
pointer), but instead of being checked against NULL before the
dereference, they are checked AFTER the dereference.  The comparison
implies that the pointer could be NULL, in which case the dereference
would be a bug.  Now, the pointer could already have been checked against
NULL at some earlier point in the code, in which case the dereference would
be perfectly OK, but then the subsequent comparison against NULL is
confusing and may indicate other bugs in the code.

Luckily, most of these bugs are easy to fix: just hoist the comparison
above the dereference and that's it.

The most common pattern the checker found was when a pointer is
dereferenced in a declaration initialization, and then immidately checked
against NULL.  The following code, one example of this pattern, was found
copied and pasted almost verbatim in over 20 different locations.


static int yam_close(struct net_device *dev)
{
	struct sk_buff *skb;
Start --->
	struct yam_port *yp = (struct yam_port *) dev->priv;

Error --->
	if (!dev || !yp)
		return -EINVAL;
	/*
	 * disable interrupts


Now, dev could have been checked before being passed into yam_close, but
the check if(!dev || !yp) implies that dev could be NULL, and therefore
the dereference two lines above could cause an error.

Another common type of error involves a malloc, then a memset, and THEN a
comparison against NULL.  This is definitely a bug, and was found in
several places:


		dev->priv = kmalloc(sizeof(struct awc_private),GFP_KERNEL );
Start --->
		memset(dev->priv,0,sizeof(struct awc_private));
Error --->
		if (!dev->priv) {
			printk(KERN_CRIT "aironet4x00: could not allocate device private, some unstability may follow\n");
			return -1;
		};


Overall, this checker is pretty robust, with a very low false positive
rate.  On kernel 2.4.7, it found 146 possible errors, of which 100 were
obvious bugs, 18 were false positives, and the rest were unknown (usually
because the dereference and the check happened too far apart).
Furthermore, the majority of the false positives were triggered by macro
expansions that included checks against NULL.


# Summary for 2.4.7
#  Total Errors				  = 100
# BUGs	|	File Name
4	|	drivers/net/aironet4500_core.c/
3	|	drivers/char/cyclades.c/
3	|	drivers/net/hamradio/baycom_ser_hdx.c/
3	|	drivers/net/aironet4500_card.c/
3	|	drivers/net/hamradio/baycom_par.c/
2	|	net/khttpd/security.c/
2	|	drivers/scsi/tmscsim.c/
2	|	drivers/char/specialix.c/
2	|	drivers/char/riscom8.c/
2	|	drivers/net/hamradio/soundmodem/sm_wss.c/
2	|	drivers/isdn/hisax/l3ni1.c/
2	|	drivers/net/arlan.c/
2	|	drivers/net/hamradio/baycom_ser_fdx.c/
2	|	drivers/net/dmfe.c/
2	|	drivers/char/ip2main.c/
2	|	drivers/isdn/hisax/l3dss1.c/
2	|	drivers/usb/serial/whiteheat.c/
2	|	drivers/net/hamradio/yam.c/
2	|	drivers/char/esp.c/
2	|	fs/efs/inode.c/
2	|	drivers/usb/serial/empeg.c/
2	|	drivers/net/rrunner.c/
2	|	drivers/net/hamradio/soundmodem/sm_sbc.c/
2	|	drivers/net/sb1000.c/
2	|	drivers/char/mxser.c/
2	|	drivers/usb/se401.c/
1	|	fs/nfsd/nfsxdr.c/
1	|	drivers/acpi/executer/exfldio.c/
1	|	drivers/ide/hpt366.c/
1	|	drivers/net/rcpci45.c/
1	|	drivers/char/tpqic02.c/
1	|	fs/ufs/dir.c/
1	|	fs/udf/inode.c/
1	|	drivers/usb/rio500.c/
1	|	drivers/net/wan/sdla_ppp.c/
1	|	drivers/scsi/ini9100u.c/
1	|	drivers/isdn/isdn_tty.c/
1	|	net/decnet/dn_route.c/
1	|	drivers/scsi/advansys.c/
1	|	drivers/net/skfp/skfddi.c/
1	|	net/sched/cls_route.c/
1	|	drivers/net/wan/comx-proto-lapb.c/
1	|	drivers/net/eepro.c/
1	|	drivers/isdn/isdn_net.c/
1	|	fs/udf/namei.c/
1	|	drivers/net/wan/comx-hw-comx.c/
1	|	drivers/net/depca.c/
1	|	drivers/scsi/scsi_error.c/
1	|	drivers/net/pcmcia/ray_cs.c/
1	|	drivers/usb/uhci.c/
1	|	fs/ntfs/dir.c/
1	|	drivers/net/arlan-proc.c/
1	|	drivers/ide/ide-probe.c/
1	|	fs/hfs/super.c/
1	|	drivers/net/wan/sdla_chdlc.c/
1	|	net/ipv4/fib_hash.c/
1	|	drivers/net/wan/wanpipe_multppp.c/
1	|	drivers/scsi/eata_pio.c/
1	|	drivers/net/pcmcia/xirc2ps_cs.c/
1	|	drivers/net/wireless/airo_cs.c/
1	|	drivers/char/rocket.c/
1	|	drivers/isdn/eicon/bri.c/
1	|	fs/affs/inode.c/
1	|	drivers/net/hp100.c/
1	|	drivers/net/pcmcia/nmclan_cs.c/
1	|	fs/hpfs/hpfs_fn.h/
1	|	drivers/mtd/devices/slram.c/
1	|	drivers/pnp/isapnp.c/


############################################################
# errors
---------------------------------------------------------
[BUG]
drivers/char/mxser.c:884:mxser_write: ERROR:INTERNAL_NULL2:881:884: Checked "tty" against null AFTER dereferencing it! [nbytes = 3132]  [distance=3]

static int mxser_write(struct tty_struct *tty, int from_user,
		       const unsigned char *buf, int count)
{
	int c, total = 0;
Start --->
	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
	unsigned long flags;

Error --->
	if (!tty || !info->xmit_buf || !mxvar_tmp_buf)
		return (0);

	if (from_user)
---------------------------------------------------------
[BUG]
drivers/char/mxser.c:954:mxser_put_char: ERROR:INTERNAL_NULL2:951:954: Checked "tty" against null AFTER dereferencing it! [nbytes = 3132]  [distance=3]
	return (total);
}

static void mxser_put_char(struct tty_struct *tty, unsigned char ch)
{
Start --->
	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
	unsigned long flags;

Error --->
	if (!tty || !info->xmit_buf)
		return;

	save_flags(flags);
---------------------------------------------------------
[BUG]
drivers/char/ip2main.c:1825:ip2_hangup: ERROR:INTERNAL_NULL2:1813:1825: Checked "tty" against null AFTER dereferencing it! [nbytes = 3132]  [distance=5]
/*                                                                            */
/******************************************************************************/
static void
ip2_hangup ( PTTY tty )
{
Start --->
	i2ChanStrPtr  pCh = tty->driver_data;

#ifdef IP2DEBUG_TRACE
	ip2trace (CHANN, ITRC_HANGUP, ITRC_ENTER, 0 );
#endif

	ip2_flush_buffer(tty);

	/* disable DSS reporting */

	i2QueueCommands(PTYPE_BYPASS, pCh, 0, 1, CMD_DCD_NREP);
	i2QueueCommands(PTYPE_INLINE, pCh, 0, 2, CMD_CTSFL_DSAB, CMD_RTSFL_DSAB);
Error --->
	if ( !tty || (tty->termios->c_cflag & HUPCL) ) {
		i2QueueCommands(PTYPE_BYPASS, pCh, 0, 2, CMD_RTSDN, CMD_DTRDN);
		pCh->dataSetOut &= ~(I2_DTR | I2_RTS);
		i2QueueCommands( PTYPE_INLINE, pCh, 100, 1, CMD_PAUSE(25));
---------------------------------------------------------
[BUG]
drivers/char/cyclades.c:3067:cy_put_char: ERROR:INTERNAL_NULL2:3057:3067: Checked "tty" against null AFTER dereferencing it! [nbytes = 3132]  [distance=14]
 * in the queue, the character is ignored.
 */
static void
cy_put_char(struct tty_struct *tty, unsigned char ch)
{
Start --->
  struct cyclades_port *info = (struct cyclades_port *)tty->driver_data;
  unsigned long flags;

#ifdef CY_DEBUG_IO
    printk("cyc:cy_put_char ttyC%d\n", info->line);
#endif

    if (serial_paranoia_check(info, tty->device, "cy_put_char"))
        return;

Error --->
    if (!tty || !info->xmit_buf)
        return;

    CY_LOCK(info, flags);
---------------------------------------------------------
[BUG]
drivers/char/esp.c:1306:rs_write: ERROR:INTERNAL_NULL2:1300:1306: Checked "tty" against null AFTER dereferencing it! [nbytes = 3132]  [distance=14]

static int rs_write(struct tty_struct * tty, int from_user,
		    const unsigned char *buf, int count)
{
	int	c, t, ret = 0;
Start --->
	struct esp_struct *info = (struct esp_struct *)tty->driver_data;
	unsigned long flags;

	if (serial_paranoia_check(info, tty->device, "rs_write"))
		return 0;

Error --->
	if (!tty || !info->xmit_buf || !tmp_buf)
		return 0;

	if (from_user)
---------------------------------------------------------
[BUG]
drivers/char/esp.c:1261:rs_put_char: ERROR:INTERNAL_NULL2:1255:1261: Checked "tty" against null AFTER dereferencing it! [nbytes = 3132]  [distance=14]
	restore_flags(flags);
}

static void rs_put_char(struct tty_struct *tty, unsigned char ch)
{
Start --->
	struct esp_struct *info = (struct esp_struct *)tty->driver_data;
	unsigned long flags;

	if (serial_paranoia_check(info, tty->device, "rs_put_char"))
		return;

Error --->
	if (!tty || !info->xmit_buf)
		return;

	save_flags(flags); cli();
---------------------------------------------------------
[BUG]
drivers/char/riscom8.c:1291:rc_put_char: ERROR:INTERNAL_NULL2:1285:1291: Checked "tty" against null AFTER dereferencing it! [nbytes = 3132]  [distance=14]
	return total;
}

static void rc_put_char(struct tty_struct * tty, unsigned char ch)
{
Start --->
	struct riscom_port *port = (struct riscom_port *)tty->driver_data;
	unsigned long flags;

	if (rc_paranoia_check(port, tty->device, "rc_put_char"))
		return;

Error --->
	if (!tty || !port->xmit_buf)
		return;

	save_flags(flags); cli();
---------------------------------------------------------
[BUG]
drivers/char/specialix.c:1683:sx_put_char: ERROR:INTERNAL_NULL2:1677:1683: Checked "tty" against null AFTER dereferencing it! [nbytes = 3132]  [distance=14]
}


static void sx_put_char(struct tty_struct * tty, unsigned char ch)
{
Start --->
	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
	unsigned long flags;

	if (sx_paranoia_check(port, tty->device, "sx_put_char"))
		return;

Error --->
	if (!tty || !port->xmit_buf)
		return;

	save_flags(flags); cli();
---------------------------------------------------------
[BUG]
drivers/isdn/isdn_tty.c:1185:isdn_tty_write: ERROR:INTERNAL_NULL2:1180:1185: Checked "tty" against null AFTER dereferencing it! [nbytes = 3132]  [distance=14]
static int
isdn_tty_write(struct tty_struct *tty, int from_user, const u_char * buf, int count)
{
	int c;
	int total = 0;
Start --->
	modem_info *info = (modem_info *) tty->driver_data;
	atemu *m = &info->emu;

	if (isdn_tty_paranoia_check(info, tty->device, "isdn_tty_write"))
		return 0;
Error --->
	if (!tty)
		return 0;
	if (from_user)
		down(&info->write_sem);
---------------------------------------------------------
[BUG]
drivers/char/cyclades.c:2982:cy_write: ERROR:INTERNAL_NULL2:2970:2982: Checked "tty" against null AFTER dereferencing it! [nbytes = 3132]  [distance=15]
 */
static int
cy_write(struct tty_struct * tty, int from_user,
           const unsigned char *buf, int count)
{
Start --->
  struct cyclades_port *info = (struct cyclades_port *)tty->driver_data;
  unsigned long flags;
  int c, ret = 0;

#ifdef CY_DEBUG_IO
    printk("cyc:cy_write ttyC%d\n", info->line); /* */
#endif

    if (serial_paranoia_check(info, tty->device, "cy_write")){
        return 0;
    }

Error --->
    if (!tty || !info->xmit_buf || !tmp_buf){
        return 0;
    }

---------------------------------------------------------
[BUG]
drivers/char/specialix.c:1611:sx_write: ERROR:INTERNAL_NULL2:1601:1611: Checked "tty" against null AFTER dereferencing it! [nbytes = 3132]  [distance=17]


static int sx_write(struct tty_struct * tty, int from_user,
                    const unsigned char *buf, int count)
{
Start --->
	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
	struct specialix_board *bp;
	int c, total = 0;
	unsigned long flags;

	if (sx_paranoia_check(port, tty->device, "sx_write"))
		return 0;

	bp = port_Board(port);

Error --->
	if (!tty || !port->xmit_buf || !tmp_buf)
		return 0;

	save_flags(flags);
---------------------------------------------------------
[BUG]
drivers/char/riscom8.c:1217:rc_write: ERROR:INTERNAL_NULL2:1207:1217: Checked "tty" against null AFTER dereferencing it! [nbytes = 3132]  [distance=17]
}

static int rc_write(struct tty_struct * tty, int from_user,
		    const unsigned char *buf, int count)
{
Start --->
	struct riscom_port *port = (struct riscom_port *)tty->driver_data;
	struct riscom_board *bp;
	int c, total = 0;
	unsigned long flags;

	if (rc_paranoia_check(port, tty->device, "rc_write"))
		return 0;

	bp = port_Board(port);

Error --->
	if (!tty || !port->xmit_buf || !tmp_buf)
		return 0;

	save_flags(flags);
---------------------------------------------------------
[BUG]
drivers/net/pcmcia/ray_cs.c:1504:ray_get_wireless_stats: ERROR:INTERNAL_NULL2:1501:1504: Checked "local" against null AFTER dereferencing it! [nbytes = 868]  [distance=3]
/*===========================================================================*/
#if WIRELESS_EXT > 7	/* If wireless extension exist in the kernel */
static iw_stats * ray_get_wireless_stats(struct net_device *	dev)
{
  ray_dev_t *	local = (ray_dev_t *) dev->priv;
Start --->
  dev_link_t *link = local->finder;
  struct status *p = (struct status *)(local->sram + STATUS_BASE);

Error --->
  if(local == (ray_dev_t *) NULL)
    return (iw_stats *) NULL;

  local->wstats.status = local->card_status;
---------------------------------------------------------
[BUG]
fs/hfs/super.c:93:hfs_write_super: ERROR:INTERNAL_NULL2:90:93: Checked "sb" against null AFTER dereferencing it! [nbytes = 504]  [distance=2]
 *   (hfs_put_super() must set this flag!). Some MDB fields are updated
 *   and the MDB buffer is written to disk by calling hfs_mdb_commit().
 */
static void hfs_write_super(struct super_block *sb)
{
Start --->
	struct hfs_mdb *mdb = HFS_SB(sb)->s_mdb;

	/* is this a valid hfs superblock? */
Error --->
	if (!sb || sb->s_magic != HFS_SUPER_MAGIC) {
		return;
	}

---------------------------------------------------------
[BUG]
fs/nfsd/nfsxdr.c:140:encode_fattr: ERROR:INTERNAL_NULL2:139:140: Checked "inode" against null AFTER dereferencing it! [nbytes = 464]  [distance=2]
}

static inline u32 *
encode_fattr(struct svc_rqst *rqstp, u32 *p, struct inode *inode)
{
Start --->
	int type = (inode->i_mode & S_IFMT);
Error --->
	if (!inode)
		return 0;
	*p++ = htonl(nfs_ftypes[type >> 12]);
	*p++ = htonl((u32) inode->i_mode);
---------------------------------------------------------
[BUG]
drivers/scsi/ini9100u.c:681:i91uSCBPost: ERROR:INTERNAL_NULL2:679:681: Checked "pSRB" against null AFTER dereferencing it! [nbytes = 388]  [distance=2]
		printk("ini9100u: %x %x\n", pSCB->SCB_HaStat, pSCB->SCB_TaStat);
		pSCB->SCB_HaStat = DID_ERROR;	/* Couldn't find any better */
		break;
	}

Start --->
	pSRB->result = pSCB->SCB_TaStat | (pSCB->SCB_HaStat << 16);

Error --->
	if (pSRB == NULL) {
		printk("pSRB is NULL\n");
	}
	pSRB->scsi_done(pSRB);	/* Notify system DONE           */
---------------------------------------------------------
[BUG]
drivers/net/sb1000.c:1028:sb1000_dev_ioctl: ERROR:INTERNAL_NULL2:1026:1028: Checked "dev" against null AFTER dereferencing it! [nbytes = 380]  [distance=2]
	char* name;
	unsigned char version[2];
	short PID[4];
	int ioaddr[2], status, frequency;
	unsigned int stats[5];
Start --->
	struct sb1000_private *lp = (struct sb1000_private *)dev->priv;

Error --->
	if (!(dev && dev->flags & IFF_UP))
		return -ENODEV;

	ioaddr[0] = dev->base_addr;
---------------------------------------------------------
[BUG]
drivers/net/hamradio/yam.c:891:yam_close: ERROR:INTERNAL_NULL2:889:891: Checked "dev" against null AFTER dereferencing it! [nbytes = 380]  [distance=2]
/* --------------------------------------------------------------------- */

static int yam_close(struct net_device *dev)
{
	struct sk_buff *skb;
Start --->
	struct yam_port *yp = (struct yam_port *) dev->priv;

Error --->
	if (!dev || !yp)
		return -EINVAL;
	/*
	 * disable interrupts
---------------------------------------------------------
[BUG]
drivers/net/hamradio/baycom_ser_hdx.c:519:ser12_close: ERROR:INTERNAL_NULL2:517:519: Checked "dev" against null AFTER dereferencing it! [nbytes = 380]  [distance=2]

/* --------------------------------------------------------------------- */

static int ser12_close(struct net_device *dev)
{
Start --->
	struct baycom_state *bc = (struct baycom_state *)dev->priv;

Error --->
	if (!dev || !bc)
		return -EINVAL;
	/*
	 * disable interrupts
---------------------------------------------------------
[BUG]
drivers/net/hamradio/baycom_ser_fdx.c:471:ser12_close: ERROR:INTERNAL_NULL2:469:471: Checked "dev" against null AFTER dereferencing it! [nbytes = 380]  [distance=2]

/* --------------------------------------------------------------------- */

static int ser12_close(struct net_device *dev)
{
Start --->
	struct baycom_state *bc = (struct baycom_state *)dev->priv;

Error --->
	if (!dev || !bc)
		return -EINVAL;
	/*
	 * disable interrupts
---------------------------------------------------------
[BUG]
drivers/net/arlan.c:1888:arlan_close: ERROR:INTERNAL_NULL2:1886:1888: Checked "dev" against null AFTER dereferencing it! [nbytes = 380]  [distance=2]
}


static int arlan_close(struct net_device *dev)
{
Start --->
	struct arlan_private *priv = (struct arlan_private *) dev->priv;

Error --->
	if (!dev)
	{
		printk(KERN_CRIT "arlan: No Device\n");
		return 0;
---------------------------------------------------------
[BUG]
drivers/net/rcpci45.c:121:rcpci45_remove_one: ERROR:INTERNAL_NULL2:119:121: Checked "dev" against null AFTER dereferencing it! [nbytes = 380]  [distance=2]

static void __exit
rcpci45_remove_one (struct pci_dev *pdev)
{
	struct net_device *dev = pci_get_drvdata (pdev);
Start --->
	PDPA pDpa = dev->priv;

Error --->
	if (!dev) {
		printk (KERN_ERR
			"(rcpci45 driver:) remove non-existent device\n");
		return;
---------------------------------------------------------
[BUG] PRIV dereferences dev
drivers/net/skfp/skfddi.c:910:skfp_interrupt: ERROR:INTERNAL_NULL2:907:910: Checked "dev" against null AFTER dereferencing it! [nbytes = 380]  [distance=2]

void skfp_interrupt(int irq, void *dev_id, struct pt_regs *regs)
{
	struct net_device *dev = (struct net_device *) dev_id;
	struct s_smc *smc;	/* private board structure pointer */
Start --->
	skfddi_priv *bp = PRIV(dev);


Error --->
	if (dev == NULL) {
		printk("%s: irq %d for unknown device\n", dev->name, irq);
		return;
	}
---------------------------------------------------------
[BUG]
drivers/net/hamradio/baycom_par.c:283:par96_interrupt: ERROR:INTERNAL_NULL2:281:283: Checked "dev" against null AFTER dereferencing it! [nbytes = 380]  [distance=2]
/* --------------------------------------------------------------------- */

static void par96_interrupt(int irq, void *dev_id, struct pt_regs *regs)
{
	struct net_device *dev = (struct net_device *)dev_id;
Start --->
	struct baycom_state *bc = (struct baycom_state *)dev->priv;

Error --->
	if (!dev || !bc || bc->hdrv.magic != HDLCDRV_MAGIC)
		return;

	baycom_int_freq(bc);
---------------------------------------------------------
[BUG]
drivers/net/hamradio/soundmodem/sm_sbc.c:330:sbc_interrupt: ERROR:INTERNAL_NULL2:327:330: Checked "dev" against null AFTER dereferencing it! [nbytes = 380]  [distance=3]
/* --------------------------------------------------------------------- */

static void sbc_interrupt(int irq, void *dev_id, struct pt_regs *regs)
{
	struct net_device *dev = (struct net_device *)dev_id;
Start --->
	struct sm_state *sm = (struct sm_state *)dev->priv;
	unsigned int curfrag;

Error --->
	if (!dev || !sm || sm->hdrv.magic != HDLCDRV_MAGIC)
		return;
	cli();
 	sbc_int_ack_8bit(dev);
---------------------------------------------------------
[BUG]
drivers/net/hamradio/baycom_ser_hdx.c:479:ser12_open: ERROR:INTERNAL_NULL2:476:479: Checked "dev" against null AFTER dereferencing it! [nbytes = 380]  [distance=3]

/* --------------------------------------------------------------------- */

static int ser12_open(struct net_device *dev)
{
Start --->
	struct baycom_state *bc = (struct baycom_state *)dev->priv;
	enum uart u;

Error --->
	if (!dev || !bc)
		return -ENXIO;
	if (!dev->base_addr || dev->base_addr > 0x1000-SER12_EXTENT ||
	    dev->irq < 2 || dev->irq > 15)
---------------------------------------------------------
[BUG]
drivers/net/eepro.c:1157:eepro_interrupt: ERROR:INTERNAL_NULL2:1154:1157: Checked "dev" against null AFTER dereferencing it! [nbytes = 380]  [distance=3]
static void
eepro_interrupt(int irq, void *dev_id, struct pt_regs * regs)
{
	struct net_device *dev =  (struct net_device *)dev_id;
	                      /* (struct net_device *)(irq2dev_map[irq]);*/
Start --->
	struct eepro_local *lp = (struct eepro_local *)dev->priv;
	int ioaddr, status, boguscount = 20;

Error --->
	if (dev == NULL) {
                printk (KERN_ERR "eepro_interrupt(): irq %d for unknown device.\\n", irq);
                return;
        }
---------------------------------------------------------
[BUG]
drivers/net/hamradio/baycom_ser_fdx.c:418:ser12_open: ERROR:INTERNAL_NULL2:415:418: Checked "dev" against null AFTER dereferencing it! [nbytes = 380]  [distance=3]

/* --------------------------------------------------------------------- */

static int ser12_open(struct net_device *dev)
{
Start --->
	struct baycom_state *bc = (struct baycom_state *)dev->priv;
	enum uart u;

Error --->
	if (!dev || !bc)
		return -ENXIO;
	if (!dev->base_addr || dev->base_addr > 0x1000-SER12_EXTENT ||
	    dev->irq < 2 || dev->irq > 15)
---------------------------------------------------------
[BUG]
drivers/net/depca.c:1195:set_multicast_list: ERROR:INTERNAL_NULL2:1192:1195: Checked "dev" against null AFTER dereferencing it! [nbytes = 380]  [distance=3]
** Set or clear the multicast filter for this adaptor.
*/
static void
set_multicast_list(struct net_device *dev)
{
Start --->
  struct depca_private *lp = (struct depca_private *)dev->priv;
  u_long ioaddr = dev->base_addr;

Error --->
  if (dev) {
    netif_stop_queue(dev);
    while(lp->tx_old != lp->tx_new);  /* Wait for the ring to empty */

---------------------------------------------------------
[BUG]
drivers/net/hamradio/baycom_par.c:372:par96_close: ERROR:INTERNAL_NULL2:369:372: Checked "dev" against null AFTER dereferencing it! [nbytes = 380]  [distance=3]

/* --------------------------------------------------------------------- */

static int par96_close(struct net_device *dev)
{
Start --->
	struct baycom_state *bc = (struct baycom_state *)dev->priv;
	struct parport *pp;

Error --->
	if (!dev || !bc)
		return -EINVAL;
	pp = bc->pdev->port;
	/* disable interrupt */
---------------------------------------------------------
[BUG]
drivers/net/wan/comx-proto-lapb.c:125:comxlapb_xmit: ERROR:INTERNAL_NULL2:122:125: Checked "dev" against null AFTER dereferencing it! [nbytes = 380]  [distance=3]
	return 0;
}

static int comxlapb_xmit(struct sk_buff *skb, struct net_device *dev)
{
Start --->
	struct comx_channel *ch = dev->priv;
	struct sk_buff *skb2;

Error --->
	if (!dev || !(ch = dev->priv) || !(dev->flags & (IFF_UP | IFF_RUNNING))) {
		return -ENODEV;
	}

---------------------------------------------------------
[BUG]
drivers/net/hamradio/baycom_ser_hdx.c:387:ser12_interrupt: ERROR:INTERNAL_NULL2:384:387: Checked "dev" against null AFTER dereferencing it! [nbytes = 380]  [distance=3]
/* --------------------------------------------------------------------- */

static void ser12_interrupt(int irq, void *dev_id, struct pt_regs *regs)
{
	struct net_device *dev = (struct net_device *)dev_id;
Start --->
	struct baycom_state *bc = (struct baycom_state *)dev->priv;
	unsigned char iir;

Error --->
	if (!dev || !bc || bc->hdrv.magic != HDLCDRV_MAGIC)
		return;
	/* fast way out */
	if ((iir = inb(IIR(dev->base_addr))) & 1)
---------------------------------------------------------
[BUG]
drivers/net/hamradio/baycom_par.c:325:par96_open: ERROR:INTERNAL_NULL2:322:325: Checked "dev" against null AFTER dereferencing it! [nbytes = 380]  [distance=3]

/* --------------------------------------------------------------------- */

static int par96_open(struct net_device *dev)
{
Start --->
	struct baycom_state *bc = (struct baycom_state *)dev->priv;
	struct parport *pp = parport_enumerate();

Error --->
	if (!dev || !bc)
		return -ENXIO;
	while (pp && pp->base != dev->base_addr)
		pp = pp->next;
---------------------------------------------------------
[BUG]
drivers/net/pcmcia/nmclan_cs.c:1099:mace_interrupt: ERROR:INTERNAL_NULL2:1095:1099: Checked "dev" against null AFTER dereferencing it! [nbytes = 380]  [distance=4]
---------------------------------------------------------------------------- */
static void mace_interrupt(int irq, void *dev_id, struct pt_regs *regs)
{
  mace_private *lp = (mace_private *)dev_id;
  struct net_device *dev = &lp->dev;
Start --->
  ioaddr_t ioaddr = dev->base_addr;
  int status;
  int IntrCnt = MACE_MAX_IR_ITERATIONS;

Error --->
  if (dev == NULL) {
    DEBUG(2, "mace_interrupt(): irq 0x%X for unknown device.\n",
	  irq);
    return;
---------------------------------------------------------
[BUG]
drivers/isdn/isdn_net.c:2034:isdn_net_init: ERROR:INTERNAL_NULL2:2030:2034: Checked "ndev" against null AFTER dereferencing it! [nbytes = 380]  [distance=4]
 */
static int
isdn_net_init(struct net_device *ndev)
{
	ushort max_hlhdr_len = 0;
Start --->
	isdn_net_local *lp = (isdn_net_local *) ndev->priv;
	int drvidx,
	 i;

Error --->
	if (ndev == NULL) {
		printk(KERN_WARNING "isdn_net_init: dev = NULL!\n");
		return -ENODEV;
	}
---------------------------------------------------------
[BUG]
drivers/net/hp100.c:2373:hp100_interrupt: ERROR:INTERNAL_NULL2:2368:2373: Checked "dev" against null AFTER dereferencing it! [nbytes = 380]  [distance=4]
 */

static void hp100_interrupt( int irq, void *dev_id, struct pt_regs *regs )
{
  struct net_device *dev = (struct net_device *)dev_id;
Start --->
  struct hp100_private *lp = (struct hp100_private *)dev->priv;

  int ioaddr;
  u_int val;

Error --->
  if ( dev == NULL ) return;
  ioaddr = dev->base_addr;

  spin_lock (&lp->lock);
---------------------------------------------------------
[BUG]
drivers/net/hamradio/soundmodem/sm_wss.c:394:wss_interrupt: ERROR:INTERNAL_NULL2:389:394: Checked "dev" against null AFTER dereferencing it! [nbytes = 380]  [distance=4]
/* --------------------------------------------------------------------- */

static void wss_interrupt(int irq, void *dev_id, struct pt_regs *regs)
{
	struct net_device *dev = (struct net_device *)dev_id;
Start --->
	struct sm_state *sm = (struct sm_state *)dev->priv;
	unsigned int curfrag;
	unsigned int nums;

	if (!dev || !sm || !sm->mode_rx || !sm->mode_tx ||
Error --->
	    sm->hdrv.magic != HDLCDRV_MAGIC)
		return;
	cli();
	wss_ack_int(dev);
---------------------------------------------------------
[BUG]
fs/affs/inode.c:303:affs_new_inode: ERROR:INTERNAL_NULL2:298:303: Checked "dir" against null AFTER dereferencing it! [nbytes = 464]  [distance=5]
}

struct inode *
affs_new_inode(struct inode *dir)
{
Start --->
	struct super_block	*sb = dir->i_sb;
	struct inode		*inode;
	u32			 block;
	struct buffer_head	*bh;

Error --->
	if (!dir || !(inode = get_empty_inode()))
		goto err_inode;

	if (!(block = affs_alloc_block(dir, dir->i_ino)))
---------------------------------------------------------
[BUG] [GEM] allocate, memset, and THEN check if it is null
drivers/net/aironet4500_card.c:172:awc_pci_init: ERROR:INTERNAL_NULL2:171:172: Checked "dev->priv" against null AFTER passing it to "__memset_generic"!
		if (!dev)
			return -ENOMEM;
		allocd_dev = 1;
	}
	dev->priv = kmalloc(sizeof(struct awc_private),GFP_KERNEL );
Start --->
	memset(dev->priv,0,sizeof(struct awc_private));
Error --->
	if (!dev->priv) {
		printk(KERN_CRIT "aironet4x00: could not allocate device private, some unstability may follow\n");
		if (allocd_dev) {
			unregister_netdev(dev);
---------------------------------------------------------
[BUG] [GEM] allocate, memset, and THEN check if it is null
drivers/net/aironet4500_card.c:380:awc4500_pnp_probe: ERROR:INTERNAL_NULL2:379:380: Checked "dev->priv" against null AFTER passing it to "__memset_generic"!
				isapnp_cfg_end();
				return -ENOMEM;
			}
		}
		dev->priv = kmalloc(sizeof(struct awc_private),GFP_KERNEL );
Start --->
		memset(dev->priv,0,sizeof(struct awc_private));
Error --->
		if (!dev->priv) {
			printk(KERN_CRIT "aironet4x00: could not allocate device private, some unstability may follow\n");
			return -1;
		};
---------------------------------------------------------
[BUG] [GEM] allocate, memset, and THEN check if it is null
drivers/net/aironet4500_card.c:546:awc4500_isa_probe: ERROR:INTERNAL_NULL2:545:546: Checked "dev->priv" against null AFTER passing it to "__memset_generic"!
				release_region(isa_ioaddr, AIRONET4X00_IO_SIZE);
				return (card == 0) ? -ENOMEM : 0;
			}
		}
		dev->priv = kmalloc(sizeof(struct awc_private),GFP_KERNEL );
Start --->
		memset(dev->priv,0,sizeof(struct awc_private));
Error --->
		if (!dev->priv) {
			printk(KERN_CRIT "aironet4x00: could not allocate device private, some unstability may follow\n");
			return -1;
		};
---------------------------------------------------------
[BUG]
drivers/usb/uhci.c:1694:uhci_unlink_urb: ERROR:INTERNAL_NULL2:1692:1694: Checked "urb" against null AFTER dereferencing it! [nbytes = 84]  [distance=2]
/*  that pipe to match what actually completed */
static int uhci_unlink_urb(struct urb *urb)
{
	struct uhci *uhci;
	unsigned long flags;
Start --->
	struct urb_priv *urbp = urb->hcpriv;

Error --->
	if (!urb)
		return -EINVAL;

	if (!urb->dev || !urb->dev->bus || !urb->dev->bus->hcpriv)
---------------------------------------------------------
[BUG]
drivers/usb/se401.c:491:se401_button_irq: ERROR:INTERNAL_NULL2:489:491: Checked "urb" against null AFTER dereferencing it! [nbytes = 84]  [distance=2]
}

/* irq handler for snapshot button */
static void se401_button_irq(struct urb *urb)
{
Start --->
	struct usb_se401 *se401=urb->context;

Error --->
	if (!urb) {
		info("ohoh: null urb");
		return;
	}
---------------------------------------------------------
[BUG]
drivers/net/hamradio/yam.c:842:yam_open: ERROR:INTERNAL_NULL2:836:842: Checked "dev" against null AFTER dereferencing it! [nbytes = 380]  [distance=5]

/* --------------------------------------------------------------------- */

static int yam_open(struct net_device *dev)
{
Start --->
	struct yam_port *yp = (struct yam_port *) dev->priv;
	enum uart u;
	int i;

	printk(KERN_INFO "Trying %s at iobase 0x%lx irq %u\n", dev->name, dev->base_addr, dev->irq);

Error --->
	if (!dev || !yp || !yp->bitrate)
		return -ENXIO;
	if (!dev->base_addr || dev->base_addr > 0x1000 - YAM_EXTENT ||
		dev->irq < 2 || dev->irq > 15) {
---------------------------------------------------------
[BUG]
drivers/net/hamradio/soundmodem/sm_sbc.c:693:sbcfdx_interrupt: ERROR:INTERNAL_NULL2:688:693: Checked "dev" against null AFTER dereferencing it! [nbytes = 380]  [distance=5]
/* --------------------------------------------------------------------- */

static void sbcfdx_interrupt(int irq, void *dev_id, struct pt_regs *regs)
{
	struct net_device *dev = (struct net_device *)dev_id;
Start --->
	struct sm_state *sm = (struct sm_state *)dev->priv;
	unsigned char intsrc, pbint = 0, captint = 0;
	unsigned int ocfrag, icfrag;
	unsigned long flags;

Error --->
	if (!dev || !sm || sm->hdrv.magic != HDLCDRV_MAGIC)
		return;
	save_flags(flags);
	cli();
---------------------------------------------------------
[BUG]
drivers/net/sb1000.c:1126:sb1000_interrupt: ERROR:INTERNAL_NULL2:1120:1126: Checked "dev" against null AFTER dereferencing it! [nbytes = 380]  [distance=5]
{
	char *name;
	unsigned char st;
	int ioaddr[2];
	struct net_device *dev = (struct net_device *) dev_id;
Start --->
	struct sb1000_private *lp = (struct sb1000_private *)dev->priv;

	const unsigned char Command0[6] = {0x80, 0x2c, 0x00, 0x00, 0x00, 0x00};
	const unsigned char Command1[6] = {0x80, 0x2e, 0x00, 0x00, 0x00, 0x00};
	const int MaxRxErrorCount = 6;

Error --->
	if (dev == NULL) {
		printk(KERN_ERR "sb1000_interrupt(): irq %d for unknown device.\n",
			irq);
		return;
---------------------------------------------------------
[BUG]
drivers/net/hamradio/soundmodem/sm_wss.c:715:wssfdx_interrupt: ERROR:INTERNAL_NULL2:709:715: Checked "dev" against null AFTER dereferencing it! [nbytes = 380]  [distance=5]
/* --------------------------------------------------------------------- */

static void wssfdx_interrupt(int irq, void *dev_id, struct pt_regs *regs)
{
	struct net_device *dev = (struct net_device *)dev_id;
Start --->
	struct sm_state *sm = (struct sm_state *)dev->priv;
	unsigned long flags;
	unsigned char cry_int_src;
	unsigned icfrag, ocfrag, isamps, osamps;

	if (!dev || !sm || !sm->mode_rx || !sm->mode_tx ||
Error --->
	    sm->hdrv.magic != HDLCDRV_MAGIC)
		return;
	save_flags(flags);
	cli();
---------------------------------------------------------
[BUG]
drivers/usb/rio500.c:358:read_rio: ERROR:INTERNAL_NULL2:353:358: Checked "rio" against null AFTER dereferencing it! [nbytes = 60]  [distance=2]
	ssize_t read_count;
	unsigned int partial;
	int this_read;
	int result;
	int maxretry = 10;
Start --->
	char *ibuf = rio->ibuf;

        /* Sanity check to make sure rio is connected, powered, etc */
        if ( rio == NULL ||
             rio->present == 0 ||
Error --->
             rio->rio_dev == NULL )
          return -1;

	read_count = 0;
---------------------------------------------------------
[BUG]
drivers/ide/hpt366.c:212:hpt366_get_info: ERROR:INTERNAL_NULL2:199:212: Checked "bmide2_dev" against null AFTER dereferencing it! [nbytes = 648]  [distance=8]

static int hpt366_get_info (char *buffer, char **addr, off_t offset, int count)
{
	char *p		= buffer;
	u32 bibma	= bmide_dev->resource[4].start;
Start --->
	u32 bibma2 	= bmide2_dev->resource[4].start;
	char *chipset_names[] = {"HPT366", "HPT366", "HPT368", "HPT370", "HPT370A"};
	u8  c0 = 0, c1 = 0;
	u32 class_rev;

	pci_read_config_dword(bmide_dev, PCI_CLASS_REVISION, &class_rev);
	class_rev &= 0xff;

        /*
         * at that point bibma+0x2 et bibma+0xa are byte registers
         * to investigate:
         */
	c0 = inb_p((unsigned short)bibma + 0x02);
Error --->
	if (bmide2_dev)
		c1 = inb_p((unsigned short)bibma2 + 0x02);

	p += sprintf(p, "\n                                %s Chipset.\n", chipset_names[class_rev]);
---------------------------------------------------------
[BUG]
drivers/acpi/executer/exfldio.c:66:acpi_ex_setup_field: ERROR:INTERNAL_NULL2:65:66: Checked "obj_desc" against null AFTER dereferencing it! [nbytes = 36]  [distance=2]
	ACPI_OPERAND_OBJECT     *rgn_desc;


	/* Parameter validation */

Start --->
	rgn_desc = obj_desc->common_field.region_obj;
Error --->
	if (!obj_desc || !rgn_desc) {
		return (AE_AML_NO_OPERAND);
	}

---------------------------------------------------------
[BUG] [GEM] highly suspicious: why kmalloc to *curmtd, then check if
curmtd is NULL?  The check should probably be (!*curmtd) instead of
(!curmtd).
drivers/mtd/devices/slram.c:142:register_device: ERROR:INTERNAL_NULL2:141:142: Checked "curmtd" against null AFTER dereferencing it! [nbytes = 4]  [distance=2]
	curmtd = &slram_mtdlist;
	while (*curmtd) {
		curmtd = &(*curmtd)->next;
	}

Start --->
	*curmtd = kmalloc(sizeof(slram_mtd_list_t), GFP_KERNEL);
Error --->
	if (!curmtd) {
		E("slram: Cannot allocate new MTD device.\n");
		return(-ENOMEM);
	}
---------------------------------------------------------
[BUG]
fs/hpfs/hpfs_fn.h:161:copy_de: ERROR:INTERNAL_NULL2:159:161: Checked "dst" against null AFTER dereferencing it! [nbytes = 32]  [distance=3]
	return ((0x1f + namelen + 3) & ~3) + (down_ptr ? 4 : 0);
}

extern inline void copy_de(struct hpfs_dirent *dst, struct hpfs_dirent *src)
{
Start --->
	int a = dst->down;
	int n = dst->not_8x3;
Error --->
	if (!dst || !src) return;
	memcpy((char *)dst + 2, (char *)src + 2, 28);
	dst->down = a;
	dst->not_8x3 = n;
---------------------------------------------------------
[BUG] would have already returned if info->tty was null, but then why
check it again?
drivers/char/cyclades.c:3246:set_line_char: ERROR:INTERNAL_NULL2:3240:3246: Checked "info->tty" against null AFTER dereferencing it! [distance=3]
        return;
    }
    if (info->line == -1){
        return;
    }
Start --->
    cflag = info->tty->termios->c_cflag;
    iflag = info->tty->termios->c_iflag;

    /*
     * Set up the tty->alt_speed kludge
     */
Error --->
    if (info->tty) {
	if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_HI)
	    info->tty->alt_speed = 57600;
	if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_VHI)
---------------------------------------------------------
[BUG]
drivers/net/wan/sdla_chdlc.c:637:update: ERROR:INTERNAL_NULL2:630:637: Checked "wandev" against null AFTER dereferencing it! [nbytes = 296]  [distance=6]
 * as to minimize the time that we are inside the interrupt handler.
 *
 */
static int update (wan_device_t* wandev)
{
Start --->
	sdla_t* card = wandev->private;
 	netdevice_t* dev;
        volatile chdlc_private_area_t* chdlc_priv_area;
        SHARED_MEMORY_INFO_STRUCT *flags;
	unsigned long timeout;

	/* sanity checks */
Error --->
	if((wandev == NULL) || (wandev->private == NULL))
		return -EFAULT;

	if(wandev->state == WAN_UNCONFIGURED)
---------------------------------------------------------
[BUG]
drivers/net/wan/sdla_ppp.c:474:update: ERROR:INTERNAL_NULL2:467:474: Checked "wandev" against null AFTER dereferencing it! [nbytes = 296]  [distance=6]
/*============================================================================
 * Update device status & statistics.
 */
static int update(wan_device_t *wandev)
{
Start --->
	sdla_t* card = wandev->private;
 	netdevice_t* dev;
        volatile ppp_private_area_t *ppp_priv_area;
	ppp_flags_t *flags = card->flags;
	unsigned long timeout;

	/* sanity checks */
Error --->
	if ((wandev == NULL) || (wandev->private == NULL))
		return -EFAULT;

	if (wandev->state == WAN_UNCONFIGURED)
---------------------------------------------------------
[BUG]
drivers/net/wan/wanpipe_multppp.c:481:update: ERROR:INTERNAL_NULL2:474:481: Checked "wandev" against null AFTER dereferencing it! [nbytes = 296]  [distance=6]
 * as to minimize the time that we are inside the interrupt handler.
 *
 */
static int update (wan_device_t* wandev)
{
Start --->
	sdla_t* card = wandev->private;
 	netdevice_t* dev;
        volatile chdlc_private_area_t* chdlc_priv_area;
        SHARED_MEMORY_INFO_STRUCT *flags;
	unsigned long timeout;

	/* sanity checks */
Error --->
	if((wandev == NULL) || (wandev->private == NULL))
		return -EFAULT;

	if(wandev->state == WAN_UNCONFIGURED)
---------------------------------------------------------
[BUG]
fs/ntfs/dir.c:796:ntfs_getdir_unsorted: ERROR:INTERNAL_NULL2:792:796: Checked "ino" against null AFTER dereferencing it! [nbytes = 44]  [distance=4]
	ntfs_io io;
	int length;
	int block;
	int start;
	ntfs_attribute *attr;
Start --->
	ntfs_volume *vol = ino->vol;
	int byte, bit;
	int error = 0;

Error --->
	if (!ino) {
		ntfs_error("No inode passed to getdir_unsorted\n");
		return -EINVAL;
	}
---------------------------------------------------------
[BUG]
drivers/net/wan/comx-hw-comx.c:348:COMX_interrupt: ERROR:INTERNAL_NULL2:340:348: Checked "dev" against null AFTER dereferencing it! [nbytes = 380]  [distance=8]


static void COMX_interrupt(int irq, void *dev_id, struct pt_regs *regs)
{
	struct net_device *dev = dev_id;
Start --->
	struct comx_channel *ch = dev->priv;
	struct comx_privdata *hw = ch->HW_privdata;
	struct net_device *interrupted;
	unsigned long jiffs;
	char idle = 0;
	int count = 0;
	word tmp;

Error --->
	if (dev == NULL) {
		printk(KERN_ERR "COMX_interrupt: irq %d for unknown device\n", irq);
		return;
	}
---------------------------------------------------------
[BUG]
net/decnet/dn_route.c:798:dn_route_output_slow: ERROR:INTERNAL_NULL2:792:798: Checked "neigh" against null AFTER dereferencing it! [nbytes = 100]  [distance=6]
	if ((rt = dst_alloc(&dn_dst_ops)) == NULL) {
		neigh_release(neigh);
		return -EINVAL;
	}

Start --->
	dn_db = (struct dn_dev *)neigh->dev->dn_ptr;

	rt->key.saddr  = src;
	rt->rt_saddr   = src;
	rt->key.daddr  = dst;
	rt->rt_daddr   = dst;
Error --->
	rt->key.oif    = neigh ? neigh->dev->ifindex : -1;
	rt->key.iif    = 0;
	rt->key.fwmark = 0;

---------------------------------------------------------
[BUG]
drivers/pnp/isapnp.c:415:isapnp_read_tag: ERROR:INTERNAL_NULL2:409:415: Checked "type" against null AFTER dereferencing it! [nbytes = 1]
	if (tag & 0x80) {	/* large item */
		*type = tag;
		isapnp_peek(tmp, 2);
		*size = (tmp[1] << 8) | tmp[0];
	} else {
Start --->
		*type = (tag >> 3) & 0x0f;
		*size = tag & 0x07;
	}
#if 0
	printk(KERN_DEBUG "tag = 0x%x, type = 0x%x, size = %i\n", tag, *type, *size);
#endif
Error --->
	if (type == 0)				/* wrong type */
		return -1;
	if (*type == 0xff && *size == 0xffff)	/* probably invalid data */
		return -1;
---------------------------------------------------------
[BUG] would have already returned if dev->priv was null, but then why
check it again?
drivers/net/arlan.c:1210:arlan_allocate_device: ERROR:INTERNAL_NULL2:1204:1210: Checked "dev->priv" against null AFTER passing it to "__memset_generic"!
	{
		printk(KERN_CRIT "init_etherdev failed ");
		return 0;
	}

Start --->
	memset(dev->priv,0,sizeof(struct arlan_private));

	((struct arlan_private *) dev->priv)->conf =
	    kmalloc(sizeof(struct arlan_shmem), GFP_KERNEL);

	if (dev == NULL || dev->priv == NULL ||
Error --->
	    ((struct arlan_private *) dev->priv)->conf == NULL)
	{
		return 0;
		printk(KERN_CRIT " No memory at arlan_allocate_device \n");
---------------------------------------------------------
[BUG]
drivers/scsi/eata_pio.c:485:eata_pio_reset: ERROR:INTERNAL_NULL2:482:485: Checked "sp" against null AFTER dereferencing it! [nbytes = 388]  [distance=12]
	    continue;

	sp = HD(cmd)->ccb[x].cmd;
	HD(cmd)->ccb[x].status = RESET;
	printk(KERN_WARNING "eata_pio_reset: slot %d in reset, pid %ld.\n", x,
Start --->
               sp->pid);
	DBG(DBG_ABNORM && DBG_DELAY, DELAY(1));

Error --->
	if (sp == NULL)
	    panic("eata_pio_reset: slot %d, sp==NULL.\n", x);
	DBG(DBG_ABNORM && DBG_DELAY, DELAY(1));
    }
---------------------------------------------------------
[BUG]
drivers/net/dmfe.c:526:dmfe_remove_one: ERROR:INTERNAL_NULL2:522:526: Checked "dev" against null AFTER dereferencing it! [nbytes = 380]  [distance=13]


static void __exit dmfe_remove_one (struct pci_dev *pdev)
{
	struct net_device *dev = pci_get_drvdata(pdev);
Start --->
	struct dmfe_board_info *db = dev->priv;

	DMFE_DBUG(0, "dmfe_remove_one()", 0);

Error --->
 	if (dev) {
		pci_free_consistent(db->net_dev, sizeof(struct tx_desc) *
					DESC_ALL_CNT + 0x20, db->desc_pool_ptr,
 					db->desc_pool_dma_ptr);
---------------------------------------------------------
[BUG]
drivers/net/aironet4500_core.c:2321:awc_interrupt_process: ERROR:INTERNAL_NULL2:2317:2321: Checked "dev" against null AFTER dereferencing it! [nbytes = 380]  [distance=13]
//	unsigned long flags;

//	save_flags(flags);
//	cli();
	// here we need it, because on 2.3 SMP there are truly parallel irqs
Start --->
	disable_irq(dev->irq);

	DEBUG(2," entering interrupt handler %s ",dev->name);

Error --->
	if (!dev) {
		printk(KERN_ERR "No dev in interrupt   \n");
		goto bad_end;
	};
---------------------------------------------------------
[BUG]
fs/udf/inode.c:2161:inode_bmap: ERROR:INTERNAL_NULL2:2153:2161: Checked "inode" against null AFTER dereferencing it! [nbytes = 464]  [distance=14]
}

int inode_bmap(struct inode *inode, int block, lb_addr *bloc, Uint32 *extoffset,
	lb_addr *eloc, Uint32 *elen, Uint32 *offset, struct buffer_head **bh)
{
Start --->
	Uint64 lbcount = 0, bcount = block << inode->i_sb->s_blocksize_bits;
	char etype;

	if (block < 0)
	{
		printk(KERN_ERR "udf: inode_bmap: block < 0\n");
		return -1;
	}
Error --->
	if (!inode)
	{
		printk(KERN_ERR "udf: inode_bmap: NULL inode\n");
		return -1;
---------------------------------------------------------
[BUG]
drivers/net/aironet4500_core.c:3051:awc_start_xmit: ERROR:INTERNAL_NULL2:3044:3051: Checked "dev" against null AFTER dereferencing it! [nbytes = 380]  [distance=14]
long long last_tx_q_hack;
int direction = 1;

int awc_start_xmit(struct sk_buff *skb, struct net_device *dev) {

Start --->
	struct awc_private *priv = (struct awc_private *)dev->priv;
	int retval = 0;
//	unsigned long flags;

	DEBUG(2, "%s: awc_start_xmit \n",  dev->name);


Error --->
	if (!dev) {
		DEBUG(1, " xmit dev=NULL, jiffie %ld \n",jiffies);
		return -1;
	};
---------------------------------------------------------
[BUG]
drivers/net/dmfe.c:793:dmfe_interrupt: ERROR:INTERNAL_NULL2:787:793: Checked "dev" against null AFTER dereferencing it! [nbytes = 380]  [distance=15]
 */

static void dmfe_interrupt(int irq, void *dev_id, struct pt_regs *regs)
{
	struct DEVICE *dev = dev_id;
Start --->
	struct dmfe_board_info *db = (struct dmfe_board_info *) dev->priv;
	unsigned long ioaddr = dev->base_addr;
	unsigned long flags;

	DMFE_DBUG(0, "dmfe_interrupt()", 0);

Error --->
	if (!dev) {
		DMFE_DBUG(1, "dmfe_interrupt() without DEVICE arg", 0);
		return;
	}
---------------------------------------------------------
[BUG]
net/khttpd/security.c:129:OpenFileForSecurity: ERROR:INTERNAL_NULL2:122:129: Checked "filp" against null AFTER dereferencing it! [nbytes = 96]  [distance=13]

	if (IS_ERR(filp))
		return NULL;

#ifndef BENCHMARK
Start --->
	permission = filp->f_dentry->d_inode->i_mode;

	/* Rule no. 4 : must have enough permissions */


	if ((permission & sysctl_khttpd_permreq)==0)
	{
Error --->
		if (filp!=NULL)
			fput(filp);
		filp=NULL;
		return NULL;
---------------------------------------------------------
[BUG] if you check if something isn't null, then presumably it could be null...
drivers/net/pcmcia/xirc2ps_cs.c:2058:exit_xirc2ps_cs: ERROR:INTERNAL_NULL2:2056:2058: Checked "dev_list" against null AFTER dereferencing it! [nbytes = 140]  [distance=14]
exit_xirc2ps_cs(void)
{
    DEBUG(0, "unloading\n");
    unregister_pccard_driver(&dev_info);
    while (dev_list) {
Start --->
	if (dev_list->state & DEV_CONFIG)
	    xirc2ps_release((u_long)dev_list);
Error --->
	if (dev_list)	/* xirc2ps_release() might already have detached... */
	    xirc2ps_detach(dev_list);
    }
}
---------------------------------------------------------
[BUG]
drivers/isdn/hisax/l3dss1.c:2220:l3dss1_cmd_global: ERROR:INTERNAL_NULL2:2215:2220: Checked "pc" against null AFTER dereferencing it! [nbytes = 208]  [distance=15]
       if (ic->parm.dss1_io.timeout > 0)
        if (!(pc = dss1_new_l3_process(st, -1)))
          { free_invoke_id(st, id);
            return(-2);
          }
Start --->
       pc->prot.dss1.ll_id = ic->parm.dss1_io.ll_id; /* remember id */
       pc->prot.dss1.proc = ic->parm.dss1_io.proc; /* and procedure */

       if (!(skb = l3_alloc_skb(l)))
         { free_invoke_id(st, id);
Error --->
           if (pc) dss1_release_l3_process(pc);
           return(-2);
         }
       memcpy(skb_put(skb, l), temp, l);
---------------------------------------------------------
[BUG]
drivers/isdn/hisax/l3ni1.c:2081:l3ni1_cmd_global: ERROR:INTERNAL_NULL2:2076:2081: Checked "pc" against null AFTER dereferencing it! [nbytes = 208]  [distance=15]
       if (ic->parm.ni1_io.timeout > 0)
        if (!(pc = ni1_new_l3_process(st, -1)))
          { free_invoke_id(st, id);
            return(-2);
          }
Start --->
       pc->prot.ni1.ll_id = ic->parm.ni1_io.ll_id; /* remember id */
       pc->prot.ni1.proc = ic->parm.ni1_io.proc; /* and procedure */

       if (!(skb = l3_alloc_skb(l)))
         { free_invoke_id(st, id);
Error --->
           if (pc) ni1_release_l3_process(pc);
           return(-2);
         }
       memcpy(skb_put(skb, l), temp, l);
---------------------------------------------------------
[BUG]
drivers/net/aironet4500_core.c:592:awc_bap_write: ERROR:INTERNAL_NULL2:588:592: Checked "cmd->bap" against null AFTER dereferencing it! [distance=13]
inline
int
awc_bap_write(struct awc_command * cmd){
          register u16 len;
          register u16 * buff = (u16 *) cmd->buff;
Start --->
          register u16 port= cmd->bap->data;


      AWC_ENTRY_EXIT_DEBUG(" entry awc_bap_write ");
Error --->
      if (!cmd->bap && !(cmd->lock_state & (AWC_BAP_SEMALOCKED |AWC_BAP_LOCKED)))
     		DEBUG(0,"no bap or bap not locked %d !!", cmd->command);

          cmd->len = (cmd->len + 1) & (~1);               // round up to even value
---------------------------------------------------------
[BUG]
drivers/net/aironet4500_core.c:557:awc_bap_read: ERROR:INTERNAL_NULL2:553:557: Checked "cmd->bap" against null AFTER dereferencing it! [distance=13]
inline
int
awc_bap_read(struct awc_command * cmd) {
	register u16 len;
	register u16 * buff = (u16 *) cmd->buff;
Start --->
	register u16 port= cmd->bap->data;


        AWC_ENTRY_EXIT_DEBUG(" entry awc_bap_read ");
Error --->
     	if (!cmd->bap && !(cmd->lock_state & (AWC_BAP_SEMALOCKED |AWC_BAP_LOCKED)))
     		DEBUG(0,"no bap or bap not locked %d !!", cmd->command);
        cmd->len = (cmd->len + 1) & (~1);               // round up to even value
        len = cmd->len / 2;
---------------------------------------------------------
[BUG]
drivers/usb/se401.c:515:se401_video_irq: ERROR:INTERNAL_NULL2:508:515: Checked "urb" against null AFTER dereferencing it! [nbytes = 84]  [distance=14]
	}
}

static void se401_video_irq(struct urb *urb)
{
Start --->
	struct usb_se401 *se401=urb->context;
	int length=urb->actual_length;

	/* ohoh... */
	if (!se401->streaming) {
		return;
	}
Error --->
	if (!urb) {
		info ("ohoh: null urb");
		return;
	}
---------------------------------------------------------
[BUG]
drivers/scsi/advansys.c:11169:AscExeScsiQueue: ERROR:INTERNAL_NULL2:11165:11169: Checked "scsiq" against null AFTER dereferencing it! [nbytes = 48]  [distance=14]
    uchar               disable_cmd;
    ASC_SG_HEAD         *sg_head;
    ASC_DCNT            data_cnt;

    iop_base = asc_dvc->iop_base;
Start --->
    sg_head = scsiq->sg_head;
    asc_exe_callback = asc_dvc->exe_callback;
    if (asc_dvc->err_code != 0)
        return (ERR);
Error --->
    if (scsiq == (ASC_SCSI_Q *) 0L) {
        AscSetLibErrorCode(asc_dvc, ASCQ_ERR_SCSIQ_NULL_PTR);
        return (ERR);
    }
---------------------------------------------------------
[BUG]
net/sched/cls_route.c:323:route4_delete: ERROR:INTERNAL_NULL2:319:323: Checked "f" against null AFTER dereferencing it! [nbytes = 32]  [distance=14]

static int route4_delete(struct tcf_proto *tp, unsigned long arg)
{
	struct route4_head *head = (struct route4_head*)tp->root;
	struct route4_filter **fp, *f = (struct route4_filter*)arg;
Start --->
	unsigned h = f->handle;
	struct route4_bucket *b;
	int i;

Error --->
	if (!head || !f)
		return -EINVAL;

	b = f->bkt;
---------------------------------------------------------
[BUG]
drivers/ide/ide-probe.c:713:init_irq: ERROR:INTERNAL_NULL2:700:713: Checked "hwgroup->hwif" against null AFTER dereferencing it! [distance=14]

	/*
	 * Everything is okay, so link us into the hwgroup
	 */
	hwif->hwgroup = hwgroup;
Start --->
	hwif->next = hwgroup->hwif->next;
	hwgroup->hwif->next = hwif;

	for (index = 0; index < MAX_DRIVES; ++index) {
		ide_drive_t *drive = &hwif->drives[index];
		if (!drive->present)
			continue;
		if (!hwgroup->drive)
			hwgroup->drive = drive;
		drive->next = hwgroup->drive->next;
		hwgroup->drive->next = drive;
		ide_init_queue(drive);
	}
Error --->
	if (!hwgroup->hwif) {
		hwgroup->hwif = HWIF(hwgroup->drive);
#ifdef DEBUG
		printk("%s : Adding missed hwif to hwgroup!!\n", hwif->name);
---------------------------------------------------------
[BUG] a check if bh is not NULL implies bh could be NULL...
fs/efs/inode.c:290:efs_map_block: ERROR:INTERNAL_NULL2:284:290: Checked "bh" against null AFTER dereferencing it! [nbytes = 96]  [distance=15]
#endif
			first = 0;
			lastblock = iblock;
		}

Start --->
		exts = (efs_extent *) bh->b_data;

		extent_copy(&(exts[ioffset]), &ext);

		if (ext.cooked.ex_magic != 0) {
			printk(KERN_ERR "EFS: extent %d has bad magic number in block %d\n", cur, iblock);
Error --->
			if (bh) brelse(bh);
			return 0;
		}

---------------------------------------------------------
[BUG]
drivers/net/wireless/airo_cs.c:314:airo_detach: ERROR:INTERNAL_NULL2:304:314: Checked "link->priv" against null AFTER dereferencing it! [distance=16]
	}

	if ( ((local_info_t*)link->priv)->eth_dev ) {
		stop_airo_card( ((local_info_t*)link->priv)->eth_dev, 0 );
	}
Start --->
	((local_info_t*)link->priv)->eth_dev = 0;

	/* Break the link with Card Services */
	if (link->handle)
		CardServices(DeregisterClient, link->handle);



	/* Unlink device structure, free pieces */
	*linkp = link->next;
Error --->
	if (link->priv) {
		kfree(link->priv);
	}
	kfree(link);
---------------------------------------------------------
[BUG]
drivers/char/tpqic02.c:2574:qic02_tape_ioctl: ERROR:INTERNAL_NULL2:2562:2574: Checked "inode" against null AFTER dereferencing it! [nbytes = 464]  [distance=21]
/* ioctl allows user programs to rewind the tape and stuff like that */
static int qic02_tape_ioctl(struct inode * inode, struct file * filp,
		     unsigned int iocmd, unsigned long ioarg)
{
    int error;
Start --->
    int dev_maj = MAJOR(inode->i_rdev);
    int c;
    struct mtop operation;
    unsigned char blk_addr[6];
    struct mtpos ioctl_tell;


    if (TP_DIAGS(current_tape_dev))
    {
	printk(TPQIC02_NAME ": ioctl(%4x, %4x, %4lx)\n", dev_maj, iocmd, ioarg);
    }

Error --->
    if (!inode || !ioarg)
    {
	return -EINVAL;
    }
---------------------------------------------------------
[BUG]
drivers/scsi/scsi_error.c:464:scsi_request_sense: ERROR:INTERNAL_NULL2:447:464: Checked "scsi_result" against null AFTER passing it to "__memset_generic"! [nbytes = 1]
	 * sense, so it is not a good idea that SCpnt->request_buffer and
	 * SCpnt->sense_buffer point to the same address (DB).
	 * 0 is not a valid sense code.
	 */
	memset((void *) SCpnt->sense_buffer, 0, sizeof(SCpnt->sense_buffer));
Start --->
	memset((void *) scsi_result, 0, 256);

	... DELETED 11 lines ...

	if (!scsi_sense_valid(SCpnt))
		memcpy((void *) SCpnt->sense_buffer,
		       SCpnt->request_buffer,
		       sizeof(SCpnt->sense_buffer));

Error --->
	if (scsi_result != &scsi_result0[0] && scsi_result != NULL)
		kfree(scsi_result);

	/*
---------------------------------------------------------
[BUG]
drivers/char/rocket.c:932:rp_open: ERROR:INTERNAL_NULL2:916:932: Checked "info" against null AFTER dereferencing it! [nbytes = 364]  [distance=23]
	if (!page)
		return -ENOMEM;

	tty->driver_data = info = rp_table[line];

Start --->
	if (info->flags & ROCKET_CLOSING) {

	... DELETED 10 lines ...

	if (rp_table[line] == NULL) {
		tty->flags = (1 << TTY_IO_ERROR);
		free_page(page);
		return 0;
	}
Error --->
	if (!info) {
		printk("rp_open: rp_table[%d] is NULL!\n", line);
		free_page(page);
		return -EIO;
---------------------------------------------------------
[BUG]
fs/udf/namei.c:159:udf_find_entry: ERROR:INTERNAL_NULL2:154:159: Checked "dir" against null AFTER dereferencing it! [nbytes = 464]  [distance=25]
	int block, flen;
	char fname[255];
	char *nameptr;
	Uint8 lfi;
	Uint16 liu;
Start --->
	loff_t size = (udf_ext0_offset(dir) + dir->i_size) >> 2;
	lb_addr bloc, eloc;
	Uint32 extoffset, elen, offset;
	struct buffer_head *bh = NULL;

Error --->
	if (!dir)
		return NULL;

	f_pos = (udf_ext0_offset(dir) >> 2);
---------------------------------------------------------
[BUG] maybe the check should be for *sw_id == NULL?
drivers/isdn/eicon/bri.c:655:GetProtFeatureValue: ERROR:INTERNAL_NULL2:652:655: Checked "sw_id" against null AFTER dereferencing it! [nbytes = 1]  [distance=22]

word GetProtFeatureValue(char *sw_id)
{
	word features = 0;

Start --->
	while ((*sw_id) && (sw_id[0] != '['))
		sw_id++;

Error --->
	if (sw_id == NULL)
	{
		DPRINTF(("divas: no feature string present"));
		features = -1;
---------------------------------------------------------
[BUG]
drivers/isdn/hisax/l3dss1.c:2225:l3dss1_cmd_global: ERROR:INTERNAL_NULL2:2215:2225: Checked "pc" against null AFTER dereferencing it! [nbytes = 208]  [distance=25]
       if (ic->parm.dss1_io.timeout > 0)
        if (!(pc = dss1_new_l3_process(st, -1)))
          { free_invoke_id(st, id);
            return(-2);
          }
Start --->
       pc->prot.dss1.ll_id = ic->parm.dss1_io.ll_id; /* remember id */
       pc->prot.dss1.proc = ic->parm.dss1_io.proc; /* and procedure */

       if (!(skb = l3_alloc_skb(l)))
         { free_invoke_id(st, id);
           if (pc) dss1_release_l3_process(pc);
           return(-2);
         }
       memcpy(skb_put(skb, l), temp, l);

Error --->
       if (pc)
        { pc->prot.dss1.invoke_id = id; /* remember id */
          L3AddTimer(&pc->timer, ic->parm.dss1_io.timeout, CC_TDSS1_IO | REQUEST);
        }
---------------------------------------------------------
[BUG]
drivers/isdn/hisax/l3ni1.c:2086:l3ni1_cmd_global: ERROR:INTERNAL_NULL2:2076:2086: Checked "pc" against null AFTER dereferencing it! [nbytes = 208]  [distance=25]
       if (ic->parm.ni1_io.timeout > 0)
        if (!(pc = ni1_new_l3_process(st, -1)))
          { free_invoke_id(st, id);
            return(-2);
          }
Start --->
       pc->prot.ni1.ll_id = ic->parm.ni1_io.ll_id; /* remember id */
       pc->prot.ni1.proc = ic->parm.ni1_io.proc; /* and procedure */

       if (!(skb = l3_alloc_skb(l)))
         { free_invoke_id(st, id);
           if (pc) ni1_release_l3_process(pc);
           return(-2);
         }
       memcpy(skb_put(skb, l), temp, l);

Error --->
       if (pc)
        { pc->prot.ni1.invoke_id = id; /* remember id */
          L3AddTimer(&pc->timer, ic->parm.ni1_io.timeout, CC_TNI1_IO | REQUEST);
        }
---------------------------------------------------------
[BUG] maybe false path: IS_ERR might check filp for NULL already
net/khttpd/security.c:140:OpenFileForSecurity: ERROR:INTERNAL_NULL2:122:140: Checked "filp" against null AFTER dereferencing it! [nbytes = 96]  [distance=24]

	if (IS_ERR(filp))
		return NULL;

#ifndef BENCHMARK
Start --->
	permission = filp->f_dentry->d_inode->i_mode;

	... DELETED 12 lines ...

	/* Rule no. 5 : cannot have "forbidden" permission */


	if ((permission & sysctl_khttpd_permforbid)!=0)
	{
Error --->
		if (filp!=NULL)
			fput(filp);
		filp=NULL;
		return NULL;
---------------------------------------------------------
[BUG]
drivers/net/rrunner.c:1344:rr_close: ERROR:INTERNAL_NULL2:1324:1344: Checked "rrpriv->rx_ctrl" against null AFTER dereferencing it! [distance=24]
		writel(0, &regs->CmdRing[i]);

	rrpriv->info->tx_ctrl.entries = 0;
	rrpriv->info->cmd_ctrl.pi = 0;
	rrpriv->info->evt_ctrl.pi = 0;
Start --->
	rrpriv->rx_ctrl[4].entries = 0;

	... DELETED 14 lines ...

			dev_kfree_skb(rrpriv->rx_skbuff[i]);
			rrpriv->rx_skbuff[i] = NULL;
		}
	}

Error --->
	if (rrpriv->rx_ctrl) {
		kfree(rrpriv->rx_ctrl);
		rrpriv->rx_ctrl = NULL;
	}
---------------------------------------------------------
[BUG]
fs/efs/inode.c:295:efs_map_block: ERROR:INTERNAL_NULL2:284:295: Checked "bh" against null AFTER dereferencing it! [nbytes = 96]  [distance=25]
#endif
			first = 0;
			lastblock = iblock;
		}

Start --->
		exts = (efs_extent *) bh->b_data;

		extent_copy(&(exts[ioffset]), &ext);

		if (ext.cooked.ex_magic != 0) {
			printk(KERN_ERR "EFS: extent %d has bad magic number in block %d\n", cur, iblock);
			if (bh) brelse(bh);
			return 0;
		}

		if ((result = efs_extent_check(&ext, block, sb))) {
Error --->
			if (bh) brelse(bh);
			in->lastextent = cur;
			return result;
		}
---------------------------------------------------------
[BUG]
drivers/scsi/tmscsim.c:2571:dc390_set_info: ERROR:INTERNAL_NULL2:2557:2571: Checked "pos" against null AFTER dereferencing it! [nbytes = 1]  [distance=25]
  int dum = 0;
  char dev;
  PDCB pDCB = pACB->pLinkDCB;
  DC390_IFLAGS
  DC390_AFLAGS
Start --->
  pos[length] = 0;

  DC390_LOCK_IO;
  DC390_LOCK_ACB;
  /* UPPERCASE */
  /* Don't use kernel toupper, because of 2.0.x bug: ctmp unexported */
  while (*pos)
    { if (*pos >='a' && *pos <= 'z') *pos = *pos + 'A' - 'a'; pos++; };

  /* We should protect __strtok ! */
  /* spin_lock (strtok_lock); */

  /* Remove WS */
  pos = strtok (buffer, " \t:\n=,;");
Error --->
  if (!pos) goto ok;

 next:
  if (!memcmp (pos, "RESET", 5)) goto reset;
---------------------------------------------------------
[BUG]
drivers/scsi/tmscsim.c:2658:dc390_set_info: ERROR:INTERNAL_NULL2:2653:2658: Checked "pos" against null AFTER passing it to "simple_strtoul"! [nbytes = 1]  [distance=26]
	  if (!pos) goto ok;
	  /* decimal */
	  if (pos-1 == pdec)
	     {
		int dumold = dum;
Start --->
		dum = simple_strtoul (pos, &p0, 10) * 10;
		for (; p0-pos > 1; p0--) dum /= 10;
		pDCB->NegoPeriod = (100000/(100*dumold + dum)) >> 2;
		if (pDCB->NegoPeriod < 19) pDCB->NegoPeriod = 19;
		pos = strtok (0, " \t\n:=,;");
Error --->
		if (!pos) goto ok;
	     };
	  if (*pos == 'M') pos = strtok (0, " \t\n:=,;");
	  if (pDCB->NegoPeriod != olddevmode) needs_inquiry++;
---------------------------------------------------------
[BUG]
drivers/net/arlan-proc.c:431:arlan_sysctl_info: ERROR:INTERNAL_NULL2:423:431: Checked "ctl->procname" against null AFTER dereferencing it! [distance=34]
	if (ctl->procname == NULL || arlan_drive_info == NULL)
	{
		printk(KERN_WARNING " procname is NULL in sysctl_table or arlan_drive_info is NULL \n at arlan module\n ");
		return -1;
	}
Start --->
	devnum = ctl->procname[5] - '0';
	if (devnum < 0 || devnum > MAX_ARLANS - 1)
	{
		printk(KERN_WARNING "too strange devnum in procfs parse\n ");
		return -1;
	}
	else if (arlan_device[devnum] == NULL)
	{
Error --->
		if (ctl->procname)
			pos += sprintf(arlan_drive_info + pos, "\t%s\n\n", ctl->procname);
		pos += sprintf(arlan_drive_info + pos, "No device found here \n");
		goto final;
---------------------------------------------------------
[BUG]
drivers/net/rrunner.c:1348:rr_close: ERROR:INTERNAL_NULL2:1321:1348: Checked "rrpriv->info" against null AFTER dereferencing it! [distance=42]
	writel(0, &regs->EvtPrd);

	for (i = 0; i < CMD_RING_ENTRIES; i++)
		writel(0, &regs->CmdRing[i]);

Start --->
	rrpriv->info->tx_ctrl.entries = 0;

	... DELETED 21 lines ...


	if (rrpriv->rx_ctrl) {
		kfree(rrpriv->rx_ctrl);
		rrpriv->rx_ctrl = NULL;
	}
Error --->
	if (rrpriv->info) {
		kfree(rrpriv->info);
		rrpriv->info = NULL;
	}
---------------------------------------------------------
[BUG]
fs/ufs/dir.c:168:ufs_check_dir_entry: ERROR:INTERNAL_NULL2:156:168: Checked "dir" against null AFTER dereferencing it! [nbytes = 464]  [distance=48]
{
	struct super_block * sb;
	const char * error_msg;
	unsigned flags, swab;

Start --->
	sb = dir->i_sb;
	flags = sb->u.ufs_sb.s_flags;
	swab = sb->u.ufs_sb.s_swab;
	error_msg = NULL;

	if (SWAB16(de->d_reclen) < UFS_DIR_REC_LEN(1))
		error_msg = "reclen is smaller than minimal";
	else if (SWAB16(de->d_reclen) % 4 != 0)
		error_msg = "reclen % 4 != 0";
	else if (SWAB16(de->d_reclen) < UFS_DIR_REC_LEN(ufs_get_de_namlen(de)))
		error_msg = "reclen is too small for namlen";
	else if (dir && ((char *) de - bh->b_data) + SWAB16(de->d_reclen) >
Error --->
		 dir->i_sb->s_blocksize)
		error_msg = "directory entry across blocks";
	else if (dir && SWAB32(de->d_ino) > (sb->u.ufs_sb.s_uspi->s_ipg * sb->u.ufs_sb.s_uspi->s_ncg))
		error_msg = "inode out of bounds";
---------------------------------------------------------
[BUG]
drivers/char/ip2main.c:1762:ip2_close: ERROR:INTERNAL_NULL2:1702:1762: Checked "tty" against null AFTER dereferencing it! [nbytes = 3132]  [distance=79]
/*                                                                            */
/******************************************************************************/
static void
ip2_close( PTTY tty, struct file *pFile )
{
Start --->
	i2ChanStrPtr  pCh = tty->driver_data;

	... DELETED 54 lines ...

	i2InputFlush( pCh );

	/* disable DSS reporting */
	i2QueueCommands(PTYPE_INLINE, pCh, 100, 4,
				CMD_DCD_NREP, CMD_CTS_NREP, CMD_DSR_NREP, CMD_RI_NREP);
Error --->
	if ( !tty || (tty->termios->c_cflag & HUPCL) ) {
		i2QueueCommands(PTYPE_INLINE, pCh, 100, 2, CMD_RTSDN, CMD_DTRDN);
		pCh->dataSetOut &= ~(I2_DTR | I2_RTS);
		i2QueueCommands( PTYPE_INLINE, pCh, 100, 1, CMD_PAUSE(25));
---------------------------------------------------------
[BUG]
net/ipv4/fib_hash.c:376:fn_hash_select_default: ERROR:INTERNAL_NULL2:366:376: Checked "res->fi" against null AFTER dereferencing it! [distance=56]
		if ((f->fn_state&FN_S_ZOMBIE) ||
		    f->fn_scope != res->scope ||
		    f->fn_type != RTN_UNICAST)
			continue;

Start --->
		if (next_fi->fib_priority > res->fi->fib_priority)
			break;
		if (!next_fi->fib_nh[0].nh_gw || next_fi->fib_nh[0].nh_scope != RT_SCOPE_LINK)
			continue;
		f->fn_state |= FN_S_ACCESSED;

		if (fi == NULL) {
			if (next_fi != res->fi)
				break;
		} else if (!fib_detect_death(fi, order, &last_resort, &last_idx)) {
Error --->
			if (res->fi)
				fib_info_put(res->fi);
			res->fi = fi;
			atomic_inc(&fi->fib_clntref);
---------------------------------------------------------
[BUG]
drivers/usb/serial/empeg.c:597:empeg_set_termios: ERROR:INTERNAL_NULL2:584:597: Checked "port->tty" against null AFTER dereferencing it! [distance=58]


/* This function is all nice and good, but we don't change anything based on it :) */
static void empeg_set_termios (struct usb_serial_port *port, struct termios *old_termios)
{
Start --->
	unsigned int cflag = port->tty->termios->c_cflag;

	dbg(__FUNCTION__ " - port %d", port->number);

	/* check that they really want us to change something */
	if (old_termios) {
		if ((cflag == old_termios->c_cflag) &&
		    (RELEVANT_IFLAG(port->tty->termios->c_iflag) == RELEVANT_IFLAG(old_termios->c_iflag))) {
			dbg(__FUNCTION__ " - nothing to change...");
			return;
		}
	}

Error --->
	if ((!port->tty) || (!port->tty->termios)) {
		dbg(__FUNCTION__" - no tty structures");
		return;
	}
---------------------------------------------------------
[BUG]
drivers/usb/serial/whiteheat.c:430:whiteheat_set_termios: ERROR:INTERNAL_NULL2:415:430: Checked "port->tty" against null AFTER dereferencing it! [distance=60]
}


static void whiteheat_set_termios (struct usb_serial_port *port, struct termios *old_termios)
{
Start --->
	unsigned int cflag = port->tty->termios->c_cflag;

	... DELETED 9 lines ...

			dbg(__FUNCTION__ " - nothing to change...");
			goto exit;
		}
	}

Error --->
	if ((!port->tty) || (!port->tty->termios)) {
		dbg(__FUNCTION__" - no tty structures");
		goto exit;
	}
---------------------------------------------------------
[BUG]
drivers/usb/serial/empeg.c:597:empeg_set_termios: ERROR:INTERNAL_NULL2:584:597: Checked "port->tty->termios" against null AFTER dereferencing it! [distance=68]


/* This function is all nice and good, but we don't change anything based on it :) */
static void empeg_set_termios (struct usb_serial_port *port, struct termios *old_termios)
{
Start --->
	unsigned int cflag = port->tty->termios->c_cflag;

	dbg(__FUNCTION__ " - port %d", port->number);

	/* check that they really want us to change something */
	if (old_termios) {
		if ((cflag == old_termios->c_cflag) &&
		    (RELEVANT_IFLAG(port->tty->termios->c_iflag) == RELEVANT_IFLAG(old_termios->c_iflag))) {
			dbg(__FUNCTION__ " - nothing to change...");
			return;
		}
	}

Error --->
	if ((!port->tty) || (!port->tty->termios)) {
		dbg(__FUNCTION__" - no tty structures");
		return;
	}
---------------------------------------------------------
[BUG]
drivers/usb/serial/whiteheat.c:430:whiteheat_set_termios: ERROR:INTERNAL_NULL2:415:430: Checked "port->tty->termios" against null AFTER dereferencing it! [distance=70]
}


static void whiteheat_set_termios (struct usb_serial_port *port, struct termios *old_termios)
{
Start --->
	unsigned int cflag = port->tty->termios->c_cflag;

	... DELETED 9 lines ...

			dbg(__FUNCTION__ " - nothing to change...");
			goto exit;
		}
	}

Error --->
	if ((!port->tty) || (!port->tty->termios)) {
		dbg(__FUNCTION__" - no tty structures");
		goto exit;
	}


--------------------------------------------------------------------
Evan Parker
eparker@cs.stanford.edu
--------------------------------------------------------------------

