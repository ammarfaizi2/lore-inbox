Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbULWGyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbULWGyF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 01:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbULWGyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 01:54:04 -0500
Received: from web41413.mail.yahoo.com ([66.218.93.79]:44470 "HELO
	web41413.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261165AbULWGxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 01:53:38 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=khS7bXJ4P36N7Nx1Ar+NOhZbSqu0io7YFTPbmcOVL0osa+FUHMWq/RY/5Jg4/koc+Ku8f6tZUCnpHzETrw3X3INhwhdAhBi+tHJjQqNBcAIYGVYFpPD1wEMg0AZMmBOoMYC4YQprwcqw/zOuSuJw0jQHE/a/5VDqP/B0h0zwXtY=  ;
Message-ID: <20041223065337.40972.qmail@web41413.mail.yahoo.com>
Date: Wed, 22 Dec 2004 22:53:37 -0800 (PST)
From: cranium2003 <cranium2003@yahoo.com>
Subject: device driver program not running  problem
To: linux-bangalore-programming@yahoogroups.com
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
      I am trying to use snull driver from Ldd book. I
have RH9 with 2.4.20-8 kernel but i install new kernel
2.4.26 also to try all my programming stuff on it.
following is snull code i am attching here.I am
compiling it with command
gcc -c snull.c -I/usr/src/linux-2.4.26/include 
       Then i put host numbers into /etc/hosts as
given in Chapter 14:Network Drivers in LDD.

192.168.0.1   local0
192.168.0.2   remote0
192.168.1.2   local1
192.168.1.1   remote1
 and then i insmod snull.o
ifconfig sn0 local0
ifconfig sn1 local1

then to check it when i give following command 
ping -c 2 remote0
I got oops message with EIP c88bedd8
my first 10 lines of /proc/ksyms
c88bf680 __insmod_tun_S.data_L96        [tun]
c88be000
__insmod_tun_O/lib/modules/2.4.26/kernel/drivers/net/tun.o_M41CA53CB_V132122
  [tun]
c88befc8 __insmod_tun_S.rodata_L20      [tun]
c88be180 tun_net_init   [tun]
c88beaf0 tun_cleanup    [tun]
c88be060 __insmod_tun_S.text_L3591      [tun]
c88beaa0 tun_init       [tun]
c88bc000 __insmod_8139too_S.data_L1096  [8139too]
c88b8000
__insmod_8139too_O/lib/modules/2.4.26/kernel/drivers/net/8139too.o_M41CA53CB_V132122
  [8139too]
c88b8060 __insmod_8139too_S.text_L10506 [8139too]


Where am i wrong in following code and above setup?
Also i would like to know that what is requirements to
run snull on my pc.
I have PC with NIC eth0 having IP 192.168.1.200 set
and no other PC connected to it?
Is it require for me to have another 2 pcs of
snullnet0 and snullnet1?

regards,
cranium

****************************************************
my snull.c is
#define  __KERNEL__
#define  MODULE
#include<linux/module.h>
#include<linux/netdevice.h> /* struct net_device &
other headers*/

#include<linux/config.h>
#include<linux/sched.h>
#include<linux/kernel.h>   /* printk() */
#include<linux/slab.h>   /* kmalloc() */
#include<linux/errno.h>    /* error codes */
#include<linux/types.h>    /* size_t */
#include<linux/interrupt.h> /* mark_bh */
 
#include<linux/in.h>        
#include<linux/etherdevice.h> /* eth_type_trans */
#include<linux/ip.h>          /* struct iphdr */
#include<linux/tcp.h>         /* struct tcphdr */
#include<linux/skbuff.h>      /* struct sk_buff */
 
#define SNULL_RX_INTR 0x0001
#define SNULL_TX_INTR 0x0002
/* CHECKSUM macro as defined in sk_buff.h
#define  CHECKSUM_NONE        0
#define  CHECKSUM_HW          1
#define  CHECKSUM_UNNECESSARY 2
*/
extern struct net_device snull_devs[ ];
 

/* struct used for statical info of  any interface by
inconfig command */
struct snull_priv {
                    struct net_device_stats stats;
                    int status;
                    int rx_packetlen;
                    u8  *rx_packetdata;
                    int tx_packetlen;
                    u8  *tx_packetdata;
                    struct sk_buff *skb;
                    spinlock_t lock;
                  };
static int lockup = 0;
MODULE_PARM(lockup,"i");
#define SNULL_TIMEOUT 5
                         /* in jiffies*/
#ifdef HAVE_TX_TIMEOUT
          static int timeout = SNULL_TIMEOUT;
          MODULE_PARM(timeout,"i");
#endif
 
static int eth=0;
MODULE_PARM(eth,"i");
int snull_eth;
 
int snull_open(struct net_device *dev);
void snull_interrupt(int irq,void *dev_id,struct
pt_regs *regs);
void snull_rx(struct net_device *dev,int len,unsigned
char *buf);
int  snull_tx(struct sk_buff *skb,struct net_device
*dev);
void snull_hw_tx(char *buf, int len, struct net_device
*dev);
void snull_tx_timeout(struct net_device *dev);
int snull_rebuild_header(struct sk_buff *skb);
int snull_header(struct sk_buff *skb, struct
net_device *dev,
                unsigned  short type, void *daddr,
void *saddr,
                unsigned int len);

struct net_device_stats *snull_stats(struct net_device
*dev);
int snull_release(struct net_device *dev);
int snull_init(struct net_device *dev);
int snull_config(struct net_device *dev, struct ifmap
*map);
int snull_ioctl(struct net_device *dev,struct ifreq
*rq,int cmd);

int snull_open(struct net_device *dev)
{
  printk("snull_open \n");
  memcpy(dev->dev_addr,"\0SNUL0",ETH_ALEN);
  dev->dev_addr[ETH_ALEN - 1] += (dev - snull_devs);
/* the number */
  netif_start_queue(dev);
  return 0;
}
int snull_config(struct net_device *dev, struct ifmap
*map)
{
  printk("snull_ifconfig is called");
  if(dev->flags & IFF_UP)
     {
       printk("snull_ifconfig :device is UP");
       return -EBUSY;
     }
  return 0;
}
 
int snull_ioctl(struct net_device *dev,struct ifreq
*rq,int cmd)
{
  return 0;
}
 

/* The interface interrupts the processor to signal
one of two possible events :
   (1)  a new packet is arrived 
            or
   (2) transmission of outgoing packet is complete
*/
void snull_interrupt(int irq,void *dev_id,struct
pt_regs *regs)
{
   int statusword;
   struct snull_priv *priv;
   struct net_device *dev = (struct net_device *)
dev_id;
   printk(" snull_interrupt is called \n"); 
   /* check with hw if it is really ours*/
   if(!dev)
      {
        printk("hw is not ours\n");    
        return;
      }
   /* lock the device */
   priv = (struct snull_priv *) dev->priv;
   spin_lock(&priv->lock);
   /* retrieve the statusword : real hardware use I/O
instructions */
   statusword = priv->status;
   if(statusword && SNULL_RX_INTR)
        { 
          /* send it to snull_rx for handling arrived
packet */
           
snull_rx(dev,priv->rx_packetlen,priv->rx_packetdata);
        }   
   if(statusword && SNULL_TX_INTR)
        {
          /* transmission is over : free skb */
            priv->stats.tx_packets++;
            priv->stats.tx_bytes +=
priv->tx_packetlen;
            dev_kfree_skb(priv->skb);
        }
   /* unlock the device and we are done */
   spin_unlock(&priv->lock);
  return;
}
 
/* receiving a packet & send it to upper layers */
/* snull_rx is called after the hardware has received
packet  & it is already in comp memory */
void snull_rx(struct net_device *dev,int len,unsigned
char *buf)
{
  struct sk_buff *skb;
  struct snull_priv *priv = (struct snull_priv *)
dev->priv;
  printk("snull_rx is called\n");
  /* the packet has been reterived from the
transmission medium . Build an skb around it,
    so upper layer can handle it
  */
  skb = dev_alloc_skb(len+2);
  if(!skb)
     {
        printk("snull_rx : low on mem hence packet
dropped ");
        priv->stats.rx_dropped++;
        return;
     }
  memcpy(skb_put(skb,len),buf,len);
  /* write metadata ,and then pass to the receive
level */
  skb->dev = dev;
  skb->protocol = eth_type_trans(skb,dev);
  skb->ip_summed = CHECKSUM_UNNECESSARY; /* don't ch!
eck it */
  priv->stats.rx_packets++;
  priv->stats.rx_bytes += len;
  netif_rx(skb);
}  

/* the socket buffer passed to snull_tx
(hard_start_xmit) contains the physical
   packet as it should appear  on the media ,
compelete with the
   transmission-level headers. The interface doesn't
neet to modify the data
   being transmitted . skb->data points to the packet
being transmitted,
   and skb->len is its length, in octets.
*/
   
int  snull_tx(struct sk_buff *skb,struct net_device
*dev)
{
  int len;
  char *data;
  struct  snull_priv  *priv = (struct snull_priv *)
dev->priv;
  printk("snull_tx is called \n");
  len = skb->len < ETH_ZLEN ? ETH_ZLEN : skb->len;
  data = skb->data;  /* svae the timestamp */
  dev->trans_start  =  jiffies ;
  /* remember the skb, so we can free at interrup time
*/
  priv->skb = skb ;
  /* actual delivery  data that  is device specific */

  snull_hw_tx(data,len,dev);
  return 0; /* Our simple device cann't fail */
}
void snull_hw_tx(char *buf, int len, struct net_device
*dev)
{
  struct iphdr *ih;
  struct net_device *dest;
  struct snull_priv *priv;
  u32   *saddr, *daddr;
  printk("snull_hw_tx is called \n");
  /* I am paranoid ,Ain't I? */
  if(len < sizeof(struct ethhdr) + sizeof(struct
iphdr))
     { 
       printk("snull_hw_tx:Packet is too short compare
to size=%i(octets)\n",                                
                                            len);
       return;
     }
  
   /* Ethhdr is 14 bytes , but the kernel arranges for
iphdr to be aligned
      (i.e. ethhdr is unaligned 
   */
   ih = (struct iphdr *) (buf+sizeof(struct ethhdr));
    /* sir i think here i am  getting problem due to
pointer derefrence */
   saddr = &ih->saddr;
   daddr = &ih->daddr;
   /* change the third octet (class)*/
   ((u8 *)saddr)[2] ^= 1;
   ((u8 *)daddr)[2] ^= 1;
  
   /* Ok,now packet is ready for transmission : first
send a receive
      interrupt on the twin device , then send a
transmission-done
      to the transmitting device
   */
   dest = snull_devs + (dev==snull_devs ? 1 : 0);
   priv = (struct snull_priv *) dest->priv;
   priv->status = SNULL_RX_INTR;
   priv->rx_packetlen = len;
   priv->rx_packetdata = buf;
   snull_interrupt(0,dest,NULL);
  
   priv = (struct snull_priv *) dev->priv;
   priv->status = SNULL_TX_INTR;
   priv->tx_packetlen = len;
   priv->tx_packetdata = buf;
   if(lockup && ((priv->stats.tx_packets + 1) %
lockup) == 0)
      {
         /* Simulate a dropped transmit interrupt */
         netif_stop_queue(dev);
         printk("Simulate lockup at %ld ,txp %ld
\n",jiffies,(unsigned long) priv->stats.tx_packets);
      }
   else
      snull_interrupt(0,dev,NULL);
}
 
void snull_tx_timeout(struct net_device *dev)
{
  struct snull_priv *priv = (struct snull_priv *)
dev->priv;
  printk("snull_tx_timeout is called \n");
  printk("Transmission timeout at %ld, latency %ld
\n",
                              jiffies, jiffies -
dev->trans_start);
  priv->status = SNULL_TX_INTR;
  snull_interrupt(0,dev,NULL);
  priv->stats.tx_errors++;
  netif_wake_queue(dev);
  return;
} 
/* Snull cann't use ARP because driver change IP
addresses in packets 
   being transmitted , and ARP packets exchanges IP
addresses as well.
   snull_header method handle physical-layer headers
directly.
 
   If device driver wants to use the usual hardware
header without running
   ARP, then we need to override the default
dev->hard_header method (as
   soon in snull_header method. 
*/
 

int snull_header(struct sk_buff *skb, struct
net_device *dev,
                 unsigned short type, void * daddr,
void  *saddr,
                 unsigned int len)
{
  struct ethhdr *eth = ( struct ethhdr *)
skb_push(skb,ETH_HLEN);
  printk("snull_header is called \n");
  eth->h_proto = ETH_P_IP;
  memcpy(eth->h_source, saddr ? saddr :
dev->dev_addr,dev->addr_len);
  memcpy(eth->h_dest,   daddr ? daddr :
dev->dev_addr,dev->addr_len);
  eth->h_dest[ETH_ALEN-1] ^= 0x11;
  return (dev->hard_header_len);
}
 
int snull_rebuild_header(struct sk_buff *skb)
{
   struct ethhdr *eth = (struct ethhdr *) skb->data;
   struct net_device *dev = skb->dev;
  printk("snull_rebuild_header is called \n");
   memcpy(eth->h_source,dev->dev_addr,dev->addr_len);
   memcpy(eth->h_dest,dev->dev_addr,dev->addr_len);
   eth->h_dest[ETH_ALEN-1] ^= 0x01;
   return 0;
} 

    
 
   
 
 
struct net_device_stats *snull_stats(struct net_device
*dev)
{
  struct snull_priv *priv = (struct snull_priv *)
dev->priv;
  printk("snull_stats is called \n");
  return &priv->stats; 
} 

  
 
int snull_release(struct net_device *dev)
{
  printk("snull_release called\n");
  netif_stop_queue(dev);
  return 0;
}

int snull_init(struct net_device *dev)
{ 
  printk("snull_init called \n");
  ether_setup(dev);
  dev->open = snull_open;
  dev->stop = snull_release;
  dev->set_config = snull_config;
  dev->hard_start_xmit = snull_tx;
  dev->do_ioctl = snull_ioctl;
  dev->get_stats = snull_stats;   
  dev->rebuild_header = snull_rebuild_header;
  dev->hard_header = snull_header;
 
  #ifdef HAVE_TX_TIMEOUT
      dev->tx_timeout = snull_tx_timeout;
      dev->watchdog_timeo = timeout;
  #endif
 
  dev->flags |= IFF_NOARP;  // keep default flags
,just add NOARP
  dev->hard_header_cache = NULL; //disable caching  
  SET_MODULE_OWNER(dev);
  dev->priv = kmalloc(sizeof( struct
snull_priv),GFP_KERNEL);
  if(dev->priv==NULL)
          {
            printk("could not allocated memory for
statical info struct of dev = sn%i",(dev-snull_devs));

            return  -ENOMEM;
          }
  memset(dev->priv,0,sizeof(struct snull_priv));
  spin_lock_init(&((struct snull_priv
*)dev->priv)->lock); 
  return 0;
}
struct net_device snull_devs[2] = { 
                                     { init :
snull_init },
                                     { init :
snull_init },
                                  };
                          
int init_module(void)
{
 int i,result,devs_present=0;
 printk("init_module called\n");
 snull_eth = eth;
 if(!snull_eth)
    {
       strcpy(snull_devs[0].name,"sn0");
       strcpy(snull_devs[1].name,"sn1");
    }
 else
    {
       strcpy(snull_devs[0].name,"eth%d");
       strcpy(snull_devs[1].name,"eth%d");
    }
 for(i=0;i<2;i++)
    {
       if(result=register_netdev(snull_devs+i))
          printk("eroor=%i while registering device =
%s \n",
                                           
result,snull_devs[i].name);
       else
           devs_present++;
    }
 printk("no of registered devices = %i
\n",devs_present); 
 return 0;
}
void cleanup_module(void)
{
 int i;
 printk("cleanup_module");
 for(i=0;i<2;i++)
    {
        kfree(snull_devs[i].priv);  
        unregister_netdev(snull_devs+i);
     
    }
} 
**********************************************










		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - now with 250MB free storage. Learn more.
http://info.mail.yahoo.com/mail_250
