Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264361AbUD0Vrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264361AbUD0Vrb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 17:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264364AbUD0Vrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 17:47:31 -0400
Received: from chococat.sd.dreamhost.com ([66.33.206.16]:12763 "EHLO
	chococat.sd.dreamhost.com") by vger.kernel.org with ESMTP
	id S264361AbUD0VrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 17:47:23 -0400
Message-ID: <4448.171.64.70.113.1083102442.spork@webmail.coverity.com>
Date: Tue, 27 Apr 2004 14:47:22 -0700 (PDT)
Subject: [CHECKER] Implementation inconsistencies in 2.6.3
From: "Ken Ashcraft" <ken@coverity.com>
To: linux-kernel@vger.kernel.org, linux@coverity.com
Cc: mdharm-usb@one-eyed-alien.net, drew@colorado.edu, romieu@cogenit.fr,
       gadio@netvision.net.il, linux-dev@micro-solutions.com,
       bcollins@debian.org, khc@pm.waw.pl, ganesh@veritas.com
Reply-To: ken@coverity.com
User-Agent: DreamHost Webmail
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to cross check implementations of the same interface for
errors.  I assume that if functions are assigned to the same function
pointer, they are implementations of a common interface and should be
consistent with each other.  For example, if one implementation checks one
of its arguments for NULL, the other implementation should also check that
argument for NULL.

In this case, I'm looking at which arguments are referenced at all in the
implementation.  If we have 10 implementations and 9 of them read argument
1 and the 10th fails to read argument 1, the 10th implementation may be
missing some code.  In each of the reports below, I give an example
implementation that does read the argument.  That is followed by an
implementation that fails to read the argument.

If you find yourself CC'd on this email, it is because I think that you
are the maintainer of code that contains one of the error reports.  Search
for your email address to find the appropriate report.

This checker is experimental, so be warned that these reports may be
false.  I would very much appreciate your feedback and suggestions so that
I can give you better reports in the future.

Thanks,
Ken Ashcraft

#  Total 				  = 8
# BUGs	|	File Name
1	|	/drivers/scsi/scsi_sysfs.c
1	|	/drivers/net/wan/dscc4.c
1	|	/drivers/usb/serial/ipaq.c
1	|	/drivers/ieee1394/eth1394.c
1	|	/drivers/usb/storage/scsiglue.c
1	|	/drivers/net/wan/hdlc_cisco.c
1	|	/drivers/block/paride/bpck6.c
1	|	/drivers/scsi/ide-scsi.c

---------------------------------------------------------
[BUG] (mdharm-usb@one-eyed-alien.net) looks like it should return count
instead of strlen(buf), but this is in scsiglue.c, so is it special code?

example:
/home/kash/linux/2.6.3/linux-2.6.3/drivers/scsi/scsi_sysfs.c:274:store_rescan_field:
NOTE:READ: Checking arg count [EXAMPLE=device_attribute.store-2]

/home/kash/linux/2.6.3/linux-2.6.3/drivers/usb/storage/scsiglue.c:321:store_max_sectors:
ERROR:READ: Not checking arg [COUNTER=device_attribute.store-2]  [fit=1]
[fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=233] [counter=1] [z =
3.20943839741638] [fn-z = -4.35889894354067]

	return sprintf(buf, "%u\n", sdev->request_queue->max_sectors);
}

/* Input routine for the sysfs max_sectors file */

Error --->
static ssize_t store_max_sectors(struct device *dev, const char *buf,
		size_t count)
{
	struct scsi_device *sdev = to_scsi_device(dev);
---------------------------------------------------------
[BUG] <drew@colorado.edu> not doing anything with buf

example:
/home/kash/linux/2.6.3/linux-2.6.3/drivers/usb/core/driverfs.c:56:set_bConfigurationValue:
NOTE:READ: Checking arg buf [EXAMPLE=device_attribute.store-1]

/home/kash/linux/2.6.3/linux-2.6.3/drivers/scsi/scsi_sysfs.c:271:store_rescan_field:
ERROR:READ: Not checking arg [COUNTER=device_attribute.store-1] [SMALL]
[fit=2] [fit_fn=2] [fn_ex=0] [fn_counter=1] [ex=232] [counter=2] [z =
2.90949088363915] [fn-z = -4.35889894354067]
sdev_rd_attr (model, "%.16s\n");
sdev_rd_attr (rev, "%.4s\n");
sdev_rw_attr_bit (online);

static ssize_t

Error --->
store_rescan_field (struct device *dev, const char *buf, size_t count)
{
	scsi_rescan_device(dev);
	return count;
---------------------------------------------------------
[BUG] (romieu@cogenit.fr) unimplemented

example:
/home/kash/linux/2.6.3/linux-2.6.3/drivers/ieee1394/eth1394.c:304:ether1394_tx_timeout:
NOTE:READ: Checking arg dev [EXAMPLE=net_device.tx_timeout-0]

/home/kash/linux/2.6.3/linux-2.6.3/drivers/net/wan/dscc4.c:957:dscc4_tx_timeout:
ERROR:READ: Not checking arg [COUNTER=net_device.tx_timeout-0] [SMALL]
[fit=3] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=84] [counter=1] [z =
1.61743595582868] [fn-z = -4.35889894354067]
done:
        dpriv->timer.expires = jiffies + TX_TIMEOUT;
        add_timer(&dpriv->timer);
}


Error --->
static void dscc4_tx_timeout(struct net_device *dev)
{
	/* FIXME: something is missing there */
}
---------------------------------------------------------
[BUG] <gadio@netvision.net.il> doesn't look at 'capacity'

example:
/home/kash/linux/2.6.3/linux-2.6.3/drivers/message/i2o/i2o_scsi.c:1046:i2o_scsi_bios_param:
NOTE:READ: Checking arg capacity [EXAMPLE=Scsi_Host_Template.bios_param-2]

/home/kash/linux/2.6.3/linux-2.6.3/drivers/scsi/ide-scsi.c:917:idescsi_bios:
ERROR:READ: Not checking arg [COUNTER=Scsi_Host_Template.bios_param-2] 
[fit=12] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=25] [counter=1] [z =
0.26995276239951] [fn-z = -4.35889894354067]
	/* finally, reset the drive (and its partner on the bus...) */
	ide_do_reset (drive);
	return SUCCESS;
}


Error --->
static int idescsi_bios(struct scsi_device *sdev, struct block_device *bdev,
		sector_t capacity, int *parm)
{
	idescsi_scsi_t *idescsi = scsihost_to_idescsi(sdev->host);
---------------------------------------------------------
[BUG]  (linux-dev@micro-solutions.com) I got a lot of reports from
bpck6.c.  I don't know if it just manages to do things completely
differently from the other drivers or if it is wrong.  Here is a place
where they don't read 'pi->delay'

example:
/home/kash/linux/2.6.3/linux-2.6.3/drivers/block/paride/aten.c:76:aten_read_block:
NOTE:READ: Checking arg (*pi).delay
[EXAMPLE=pi_protocol.read_block-0.deref.delay]

/home/kash/linux/2.6.3/linux-2.6.3/drivers/block/paride/bpck6.c:90:bpck6_read_block:
ERROR:READ: Not checking arg
[COUNTER=pi_protocol.read_block-0.deref.delay] [SMALL] [fit=41] [fit_fn=1]
[fn_ex=0] [fn_counter=1] [ex=14] [counter=1] [z = -0.296174438879545]
[fn-z = -4.35889894354067]
static void bpck6_write_block( PIA *pi, char * buf, int len )
{
	ppc6_wr_port16_blk(PPCSTRUCT(pi),ATAPI_DATA,buf,(u32)len>>1);
}


Error --->
static void bpck6_read_block( PIA *pi, char * buf, int len )
{
	ppc6_rd_port16_blk(PPCSTRUCT(pi),ATAPI_DATA,buf,(u32)len>>1);
}
---------------------------------------------------------
[BUG] <bcollins@debian.org> why not set the mac addr?

example:
/home/kash/linux/2.6.3/linux-2.6.3/drivers/net/acenic.c:3113:ace_set_mac_addr:
NOTE:READ: Checking arg p [EXAMPLE=net_device.set_mac_address-1]

/home/kash/linux/2.6.3/linux-2.6.3/drivers/ieee1394/eth1394.c:647:ether1394_mac_addr:
ERROR:READ: Not checking arg [COUNTER=net_device.set_mac_address-1]
[SMALL] [fit=52] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=28] [counter=2]
[z = -0.418853908291694] [fn-z = -4.35889894354067]
					  unsigned char * haddr)
{
	memcpy(((u8*)hh->hh_data) + 6, haddr, dev->addr_len);
}


Error --->
static int ether1394_mac_addr(struct net_device *dev, void *p)
{
	if (netif_running(dev))
		return -EBUSY;
---------------------------------------------------------
[BUG] <khc@pm.waw.pl> not referencing 'dev'

example:
/home/kash/linux/2.6.3/linux-2.6.3/drivers/ieee1394/eth1394.c:569:ether1394_header:
NOTE:READ: Checking arg dev [EXAMPLE=net_device.hard_header-1]

/home/kash/linux/2.6.3/linux-2.6.3/drivers/net/wan/hdlc_cisco.c:37:cisco_hard_header:
ERROR:READ: Not checking arg [COUNTER=net_device.hard_header-1]  [fit=62]
[fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=10] [counter=1] [z =
-0.622543017479467] [fn-z = -4.35889894354067]
#define CISCO_ADDR_REQ		0	/* Cisco address request */
#define CISCO_ADDR_REPLY	1	/* Cisco address reply */
#define CISCO_KEEPALIVE_REQ	2	/* Cisco keepalive request */



Error --->
static int cisco_hard_header(struct sk_buff *skb, struct net_device *dev,
			     u16 type, void *daddr, void *saddr,
			     unsigned int len)
{
---------------------------------------------------------
[BUG] <ganesh@veritas.com> doesn't reference 'port->serial->dev'

example:
/home/kash/linux/2.6.3/linux-2.6.3/drivers/usb/serial/cyberjack.c:280:cyberjack_write:
NOTE:READ: Checking arg (*serial).dev
[EXAMPLE=usb_serial_device_type.write-0.deref.serial.deref.dev]

/home/kash/linux/2.6.3/linux-2.6.3/drivers/usb/serial/ipaq.c:368:ipaq_write:
ERROR:READ: Not checking arg
[COUNTER=usb_serial_device_type.write-0.deref.serial.deref.dev]  [fit=202]
[fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=12] [counter=2] [z =
-1.59416228266091] [fn-z = -4.35889894354067]
	if (result)
		err("%s - failed resubmitting read urb, error %d", __FUNCTION__, result);
	return;
}


Error --->
static int ipaq_write(struct usb_serial_port *port, int from_user, const
unsigned char *buf,
		       int count)
{
	const unsigned char	*current_position = buf;

