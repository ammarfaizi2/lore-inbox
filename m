Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWDZEwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWDZEwV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 00:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWDZEwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 00:52:20 -0400
Received: from [202.109.113.90] ([202.109.113.90]:28583 "EHLO
	dragon.linux-vs.org") by vger.kernel.org with ESMTP id S932362AbWDZEwU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 00:52:20 -0400
Message-ID: <1146027138.444efc82168e4@mail.linux-vs.org>
Date: Wed, 26 Apr 2006 12:52:18 +0800
From: dragonfly@linux-vs.org
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, marcelo.tosatti@cyclades.com, jiwang@ios.ac.cn
Subject: kernel-2.4.32 'drivers/net' bugs acknowledgement
MIME-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.2.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    Recently, I did a cursory check to the 'drivers/net' directory of
the official 2.4.32 kernel sources with the help of a validity check
tool i developed. The following are the bugs i think to be,
sincerely apply your acknowledgement. Hope it helpful to improve great
Linux. 

Best Regards,
Li Wang

Directory: drivers/net
1. File: 7990.c
   Type: Double Locking
   Function: lance_interrupt()
   Details:
   static void lance_interrupt (int irq, void *dev_id, struct pt_regs
*regs)
   {
	...
	spin_lock (&lp->devlock);  /* Line 411 */
	...
	spin_lock (&lp->devlock);  /* Line 419 */
	...
   }
2. File: aironet4500_core.c
   Type: Call may-block function in softirq context
   Function: awc_start_xmit()->awc_802_11_tx_find_path_and_post()
   Details:
   int awc_802_11_tx_find_path_and_post(struct net_device * dev, struct
sk_buff * skb)
   {
	...
	DOWN(&priv->tx_buff_semaphore);	/* Line 1591 */
	...
   }
3. File: appletalk/cops.c
   Type: As above
   Function: cops_timeout()->cops_jumpstart()->cops_reset(),
   cops_timeout()->cops_jumpstart()->cops_nodeid()
   Details:
   static void cops_reset(struct net_device *dev, int sleep)
   {
	...
	schedule();	/* Line 504 */
	...
   }
   static int cops_nodeid (struct net_device *dev, int nodeid)
   {
	...
	schedule();	/* Line 621 */
   	...
   }
4. File: de4x5.c   
   Type: Double locking
   Function: de4x5_interrupt()
   Details:
   static void de4x5_interrupt(int irq, void *dev_id, struct pt_regs
*regs)
   {
	...
 	spin_lock(&lp->lock);	/* Line 1640 */
        ...
	spin_lock_irqsave(&lp->lock, flags);	/* Line 1566,called by
de4x5_queue_pkt() */
	...
   }
5. File: declance.c
   Type: Unlock unlocked lock
   Function: lance_start_xmit()
   Details:
   static int lance_start_xmit(struct sk_buff *skb, struct net_device
*dev)
   {
	...
	spin_unlock_irq(&lp->lock);	/* Line 928 */
	...
   }	
6. File: ethertap.c
   Type: Call may-block function in softirq context
   Function: ethertap_rx()->ethertap_rx_skb()
   Details:
   static __inline__ int ethertap_rx_skb(struct sk_buff *skb, struct
net_device *dev)
   {
	...
	skb = skb_clone(skb, GFP_KERNEL);	/* Line 266 */
	...
   }
7. File: defxx.c
   Type: Call dev_kfree_skb() in hardware interrupt context
   Function:
dfx_interrupt()->dfx_int_common()->dfx_int_type_0_process()->dfx_xmt_flu
sh()
   Details:
   static void dfx_xmt_flush( DFX_board_t *bp )
   {
	...
	dev_kfree_skb(p_xmt_drv_descr->p_skb);	/* Line 3311 */
	...		
   }
8. File: ioc3-eth.c
   Type: Call may-block function in hardware interrupt context
   Function:
ioc3_interrupt()->ioc3_error()->ioc3_init()->ioc3_init_rings()->ioc3_all
oc_rings()
   Details:
   static void ioc3_alloc_rings(struct net_device *dev, struct
ioc3_private *ip,
		 struct ioc3 *ioc3)
   {
   	...
	ip->txr = (struct ioc3_etxd *)__get_free_pages(GFP_KERNEL, 2);	/* Line
1221 */
	...
   }
9. File: vlsi-ir.c
   Type: Call dev_kfree_skb() in hardware interrupt context
   Function: vlsi_interrupt()->vlsi_tx_interrupt()
   Details:
   static int vlsi_tx_interrupt(struct net_device *ndev)
   {
	...
	dev_kfree_skb(r->buf[r->tail].skb);	/* Line 693 */
	...
   }
10. File: ns83820.c
    Type: As above	
    Function:
ns83820_irq()->ns83820_do_isr()->ns83820_rx_kick()->rx_refill_atomic()
              ->ns83820_add_rx_skb()
    Details:
    static inline int ns83820_add_rx_skb(struct ns83820 *dev, struct
sk_buff *skb)
    {
 	...
	kfree_skb(skb);	/* Line 519 */
	...
    }
11. File: sb1000.c
    Type: As above
    Function: sb1000_interrupt()->sb1000_rx()
    Details:
    static inline int sb1000_rx(struct net_device *dev)
    {
	...
	dev_kfree_skb(skb);	/* Line 825 */
	...
    }
12. File: sgiseeq.c
    Type: Call may-block function in softirq context
    Function: timeout()->sgiseeq_reset()->init_seeq()->seeq_init_ring()
    Details:
    static int seeq_init_ring(struct net_device *dev)
    {
	...
	buffer = (unsigned long) kmalloc(PKT_BUF_SZ, GFP_KERNEL);	/* Line 184
*/
	...
    }
13. File: sk98lin/skge.c
    Type: Call dev_kfree_skb() in hardware interrupt context
    Function: SkGeIsr()->ReceiveIrq()
    Details:
    static void ReceiveIrq(
	SK_AC		*pAC,			/* pointer to adapter context */
	RX_PORT		*pRxPort,		/* pointer to receive port struct */
	SK_BOOL		SlowPathLock)	/* indicates if SlowPathLock is needed */
    {
	...
	DEV_KFREE_SKB(pMsg);	/* Line 2681 */
	...
	DEV_KFREE_SKB(pMsg);	/* Line 2730 */
	...
    }
14. File: wan/comx-hw-mixcom.c
    Type: As above
    Function: MIXCOM_interrupt()->mixcom_receive_frame(),
	      MIXCOM_interrupt()->hscx_fill_fifo(),
	      MIXCOM_interrupt()->mixcom_extended_interrupt()
    Details:
    static inline void mixcom_receive_frame(struct net_device *dev) 
    {
	...
	kfree_skb(hw->recving);	/* Line 340 */
	...
    }
    static inline void hscx_fill_fifo(struct net_device *dev)
    {
	...
 	kfree_skb(hw->sending);	/* Line 128 */
 	...
    }
    static inline void mixcom_extended_interrupt(struct net_device *dev)

    {
	...
	kfree_skb(hw->recving);	/* Line 358 */
	...
	kfree_skb(hw->sending);	/* Line 369 */
	...
	kfree_skb(hw->sending);	/* Line 404 */

    }
15. File: wan/lmc/lmc_main.c
    Type: As above
    Function: lmc_interrupt()->lmc_running_reset()->lmc_softreset()
    Details:
    static void lmc_softreset (lmc_softc_t * const sc) /*fold00*/
    {
	...
	dev_kfree_skb(sc->lmc_txq[i]);	/* Line 2196 */
	...
    }
16. File: wireless/airo.c
    Type: Call may-block function in hardware interrupt context
    Function:
airo_interrupt()->airo_send_event()->airo_read_mic()->PC4500_readrid()
    Details:
    static int PC4500_readrid(struct airo_info *ai, u16 rid, void *pBuf,
int len, int lock)
    {
	...
      	if (down_interruptible(&ai->sem))	/* Line 3219 */
	...
    }
    
     

   
	

