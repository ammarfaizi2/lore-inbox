Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWIJOcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWIJOcR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 10:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWIJOcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 10:32:17 -0400
Received: from rekin26.go2.pl ([193.17.41.76]:26752 "EHLO rekin22.go2.pl")
	by vger.kernel.org with ESMTP id S932204AbWIJOcO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 10:32:14 -0400
Subject: =?UTF-8?Q?problem=20with=20OWN=20bit=20when=20writting=20driver=20?=
	=?UTF-8?Q?for=20rtl8139=3F?=
From: =?UTF-8?Q?mwitosz-linux?= <mwitosz-linux@o2.pl>
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Message-ID: <231c973f.7ffabfd8.450421ed.620bc@o2.pl>
Date: Sun, 10 Sep 2006 16:32:13 +0200
X-Originator: 213.102.147.249
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, everybody
my name is Mariusz, I am newbie to linux kernel, 
For several weeks I have been writing kernel driver for network card based on 
rtl8139c chip. 

I have some problems with DMA, i suppose.

there is a bit in Transmit Status Descriptor of RTL8139c which after clearing(It must be cleared to 
start transmit operation) shouldb be placed in 1 state - which according to RTL8139 specification means that 
DMA copy from memory to internal RTL fifo has finished.

The problem is: rtl doesn't clear this bit

I use  pci_map_single to map address of packet buffer to dma capable memory, then cpu_to_le32 to get physicall
address of this buffer. 

Do you have any idea what may work wrong?

here is transmit part of my driver:

/**function called by kernel when kernel wat to transmit packet which is 
   located in socket buffer structure skb
   @param skb:  socket buffer structure with packet to transmit
   @param netdev: device used to send this packet 
*/
int rtl_tx(struct sk_buff *skb, struct net_device *netdev){
	int len;
	char *data, shortpkt[ETH_ZLEN];
	struct rtl_private_data *priv; 
	
	//get private data pointer
	priv = netdev_priv(netdev);

	//if the length of this packet is below 64 bytes, expand it to 64 bytes 
	//by padding
	data = skb->data;
	len = skb->len;
	if(len < ETH_ZLEN){
		memset(shortpkt, 0, ETH_ZLEN);
		memcpy(shortpkt, skb->data, skb->len);
		len = ETH_ZLEN;
		data = shortpkt;
	}

	//save skb for freeing when this packet will be transmited
	priv->skb = skb;

	
	//finaly transmit this packet
	udelay(500);
	rtl_hw_tx(data, len, netdev, skb);

	return 0;
};


/**transmit data from packet
   @param data: buffer with packet
   @param len: lenth of this packet
   @param netdev: network device used to transmit this packet
*/
int rtl_hw_tx(char *data, int len, struct net_device *netdev, struct sk_buff *skb){
	unsigned char td;
	u32 physical_addr;
	unsigned int physical_addr_len;
	//void *base_ptr;
	u32 io_base;
	struct rtl_private_data *priv;
	unsigned int dword;
	//u32 ertx;
	int i;
	u16 word;
	bool assigned;
	dma_addr_t mapping;
	int result;
	int j;
	
	
	//KDEBUG("@PACKET IS --------------------------------------------------------------\n");
	//show_packet(data, len);
	//KDEBUG("@PACKET IS --------------------------------------------------------------\n");

	KDEBUG("@rtl_hw_tx: new packet to transmit \n");	

	priv = netdev_priv(netdev);
	//base_ptr = priv->base_ptr;
	io_base = priv->io_base;
	
	//wait for available free transmit descriptor
	assigned = false;
	//while(true){
	for(i=0; i<1000; i++){

		if( !is_empty( &descriptors ) ){
		//there is no available transmit descriptor 

			assigned = true;
			break;
		}
	}

	if( !assigned) {
		KERROR("@rtl_hw_txt: no available desriptor \n");
		return 1;
	}

	//free transmit descriptor found, get it!
	dequeue(&descriptors, &td);

	spin_lock_irq(&priv->lock);


	//skb_copy_and_csum_dev(skb, priv->tx_buff[td]);
	//dev_kfree_skb(skb);


	
	//get physical address of data buffer
	//physical_addr = __pa(data);
	mapping = pci_map_single(priv->pcidev, data, len, PCI_DMA_TODEVICE);
	if(mapping == NULL){
		KERROR("MAPPING null \n");
	}
		
	KDEBUG("@rtl_hw_tx: mapping is %d \n", mapping);
	physical_addr = cpu_to_le32(mapping);

	
	//KDEBUG("@rtl_hw_tx: compare: %ld ... %ld \n", physical_addr, __pa(data));


	//set physical_address of this packet in tsad register
	outl(physical_addr, io_base + tsad[td]);
	//outl(priv->dma_buff[td], io_base + tsad[td]);
	//iowrite32(physical_addr, base_ptr + tsad[td]);
	//outl(physical_addr, io_ba


	//early transmit threshlog
	//ertx = 2;
	//ertx = ertx << TSD_ERTHX_OFS;	
	
	//set size of transmited data
	physical_addr_len = len;
	KINFO("@rtl_hw_tx: physical_addr_len is %x \n", physical_addr_len);

	dword = inl(io_base + tsd[td]);
	KINFO("@rtl_hw_tx: current tsd is %x \n", dword);

	dword = dword & ~(TSD_SIZE | TSD_ERTHX);
	physical_addr_len = physical_addr_len & TSD_SIZE;
	dword = dword | (physical_addr_len);
	KINFO("@rtl_hw_tx: new tsd is %x \n", dword);

	outl(dword, io_base + tsd[td]);
	dword = inl(io_base + tsd[td]);
	KINFO("@rtl_hw_tx: written tsd is %x \n", dword);

	//save skb buffer pointer for future use
	//skbs[td]= priv->skb;

	priv->x = 0;
	//clear own bit to start transmision
	KINFO("@rtl_hw_tx: before clearing OWN: %x \n", dword);
	
	word = inw(io_base+ IMR);		
	dword = inl(io_base + tsd[td]);
	 KDEBUG("@-----------IMR-------------: %x \n", word);
	 KDEBUG("@-----------TSD: %d %x-------------:  \n", td, dword);

	netdev->trans_start = jiffies; 

	dword = dword & ~TSD_OWN;
	outl(dword, io_base + tsd[td]);

	//dword = inl(io_base + tsd[td]);
	//KINFO("@rtl_hw_tx: after clearing OWN: %x \n", dword);

	for(j=0; j<500; j++){
	word = inw(io_base + ISR);
	dword = inl(io_base + tsd[td]);
	KINFO("@rtl_hw_tx: ISR is %x  TSD is %x \n", word, dword);
	udelay(10000);
	}

	spin_unlock_irq(&priv->lock);
	return 0;
}



and here is output from kernel

klogd 1.4.1#17.2, log source = /proc/kmsg started.
Cannot find map file.
No module symbols loaded - kernel modules not enabled.

<7>kobject rtl: registering. parent: <NULL>, set: module
<7>DEBUG __________________________module rtlmodule loaded___________________________ 
<7>DEBUG @register_as_network_device: New pci_dev to register as net_device 
<6>ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
<7>DEBUG @register_as_network_device: Device Enabled 
<7>DEBUG @register_as_network_device: pci_set_dma_mask ok 
<7>DEBUG @register_as_network_device: request region ok 
<7>DEBUG @register_as_network_device: IOAR is e001 
<7>PCI: Enabling bus mastering for device 0000:00:09.0
<7>DEBUG @ether_dev_init: New net_device registered 
<7>DEBUG @init_hardware: initializing hardware 
<7>DEBUG @init_hardware: reseting rtl8139 
<3>ERROR @init_hardware: NOT RESET 
<7>DEBUG @init_hardware: enabling transmiter and receiver 
<7>DEBUG @init_hardware: TCR is 74400600 
<7>DEBUG @create_transmit_descriptors: creating 4 transmit descriptors 
<7>DEBUG @create_transmit_descriptors: queue initialized 
<7>DEBUG @create_transmit_descriptors: 4 transmit descriptors enqueued 
<7>DEBUG @create TSD is 2000 
<7>DEBUG @create TSD is 2000 
<7>DEBUG @create TSD is 2000 
<7>DEBUG @create TSD is 2000 
<7>DEBUG @create ISR is 0 
<7>DEBUG @init_software: found irq for this device: 11 
<7>kobject eth1: registering. parent: net, set: class_obj
<7>DEBUG @register_as_network_device: netdev registered 
<7>DEBUG @rtlinit: New device found 
<7>DEBUG @ether_dev_open: interface is going up 
<7>DEBUG @ether_dev_open: setting mac address to 0:e:2e:80:2d:de 
<7>DEBUG @ether_dev_open: mac addres set properly 
<7>DEBUG @ether_dev_open: irq successfuly requested 
<7>DEBUG @ether_dev_open: setting interrupt mask register: 49260 
<7>DEBUG @ether_dev_open: queue stared 
tx: ISR is 0  TSD is 3c 
<6>INFO @rtl_hw_tx: ISR is 0  TSD is 3c 
<6>INFO @rtl_hw_tx: ISR is 0  TSD is 3c 
...
...
<6>INFO @rtl_hw_tx: ISR is 0  TSD is 3c 

best regards, 
Mariusz Witosz
