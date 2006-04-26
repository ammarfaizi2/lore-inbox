Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWDZPeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWDZPeU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 11:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbWDZPeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 11:34:20 -0400
Received: from [202.109.113.90] ([202.109.113.90]:44731 "EHLO
	dragon.linux-vs.org") by vger.kernel.org with ESMTP id S964824AbWDZPeT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 11:34:19 -0400
Message-ID: <1146065657.444f92f90d613@mail.linux-vs.org>
Date: Wed, 26 Apr 2006 23:34:17 +0800
From: Li Wang <dragonfly@linux-vs.org>
To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, ak@suse.de,
       jiwang@ios.ac.cn
Subject: Kernel 2.6.16 'drivers/net' bugs?
MIME-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.2.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    I've reviewed the kernel 2.6.16. Hmm, some bugs have been fixed. But
still some left, the following are bugs i think to be. Sincerely apply
kernel hackers' acknowledgement.

Directory: drivers/net
1. File: appletalk/cops.c
   Type: Call schedule() when in_interrupt() == TRUE
   Function: cops_timeout()->cops_jumpstart()->cops_reset(),
   cops_timeout()->cops_jumpstart()->cops_nodeid()
   Details:
   static void cops_reset(struct net_device *dev, int sleep)
   {
	...
	schedule();	/* Line 515 */
	...
   }
   static int cops_nodeid (struct net_device *dev, int nodeid)
   {
	...
	schedule();	/* Line 632 */
   	...
	schedule();	/* Line 648 */
	...
	schedule();	/* Line 676 */
	...
   }
2. File: tulip/de4x5.c   
   Type: Double locking
   Function: de4x5_interrupt()
   Details:
   static void de4x5_interrupt(int irq, void *dev_id, struct pt_regs
*regs)
   {
	...
 	spin_lock(&lp->lock);	/* Line 1555 */
        ...
	spin_lock_irqsave(&lp->lock, flags);	/* Line 1480, called by
de4x5_queue_pkt() */
	...
   }
3. File: declance.c
   Type: Unlock unlocked lock
   Function: lance_start_xmit()
   Details:
   static int lance_start_xmit(struct sk_buff *skb, struct net_device
*dev)
   {
	...
	spin_unlock_irq(&lp->lock);	/* Line 920 */
	...
   }	
4. File: defxx.c
   Type: Call dev_kfree_skb() in hardware interrupt context
   Function:
dfx_interrupt()->dfx_int_common()->dfx_int_type_0_process()->dfx_xmt_flu
sh()
   Details:
   static void dfx_xmt_flush( DFX_board_t *bp )
   {
	...
	dev_kfree_skb(p_xmt_drv_descr->p_skb);	/* Line 3354 */
	...		
   }
5. File: gt96100eth.c
   Type: Call sleep() when holding spin lock
   Function: gt96100_tx_timeout()->reset_tx()->abort()
   Details:
   static void abort(struct net_device *dev, u32 abort_bits)
   {
	...
	spin_lock(&gp->lock);	/* Line 516 */
	...
	msleep_interruptible();	/* Line 189, called by gt96100_delay() */
	...
   }
6. File: ioc3-eth.c
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
954 */
	...
   }
7. File: ns83820.c
    Type: Call kfree_skb() in hardware interrupt context	
    Function:
ns83820_irq()->ns83820_do_isr()->ns83820_rx_kick()->rx_refill_atomic()
              ->ns83820_add_rx_skb()
    Details:
    static inline int ns83820_add_rx_skb(struct ns83820 *dev, struct
sk_buff *skb)
    {
 	...
	kfree_skb(skb);	/* Line 557 */
	...
    }
8. File: sb1000.c
    Type: Call dev_kfree_skb() in hardware interrupt context
    Function: sb1000_interrupt()->sb1000_rx()
    Details:
    static inline int sb1000_rx(struct net_device *dev)
    {
	...
	dev_kfree_skb(skb);	/* Line 793 */
	...
	dev_kfree_skb(skb);	/* Line 887 */
	...
    }
9. File: sgiseeq.c
    Type: Call may-block function in softirq context
    Function: timeout()->sgiseeq_reset()->init_seeq()->seeq_init_ring()
    Details:
    static int seeq_init_ring(struct net_device *dev)
    {
	...
	buffer = (unsigned long) kmalloc(PKT_BUF_SZ, GFP_KERNEL);	/* Line 182
*/
	...
	buffer = (unsigned long) kmalloc(PKT_BUF_SZ, GFP_KERNEL);	/* Line 196
*/
	...
    }
10. File: sk98lin/skge.c
    Type: Call dev_kfree_skb() in hardware interrupt context
    Function: SkGeIsr()->ReceiveIrq()
    Details:
    static void ReceiveIrq(
	SK_AC		*pAC,			/* pointer to adapter context */
	RX_PORT		*pRxPort,		/* pointer to receive port struct */
	SK_BOOL		SlowPathLock)	/* indicates if SlowPathLock is needed */
    {
	...
	DEV_KFREE_SKB(pMsg);	/* Line 2205 */
	...
	DEV_KFREE_SKB(pMsg);	/* Line 2254 */
	...
    }
11. File: wan/lmc/lmc_main.c
    Type: As above
    Function: lmc_interrupt()->lmc_running_reset()->lmc_softreset()
    Details:
    static void lmc_softreset (lmc_softc_t * const sc) /*fold00*/
    {
	...
	dev_kfree_skb(sc->lmc_txq[i]);	/* Line 1959 */
	...
    }   
	

Best Regards,
Li Wang
