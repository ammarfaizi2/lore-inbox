Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbTEUTrx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 15:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbTEUTrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 15:47:53 -0400
Received: from hoemail2.lucent.com ([192.11.226.163]:17148 "EHLO
	hoemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S262251AbTEUTrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 15:47:51 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16075.56045.77079.993521@gargle.gargle.HOWL>
Date: Wed, 21 May 2003 16:00:45 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: linux-kernel@vger.kernel.org
Subject: Cyclades Cyclom-Y ISA on 2.5.69
In-Reply-To: <16075.50697.683216.347529@napali.hpl.hp.com>
References: <16075.8557.309002.866895@napali.hpl.hp.com>
	<16075.50697.683216.347529@napali.hpl.hp.com>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

Has anyone else run into a problem compiling the Cyclades serial board
driver under 2.5.x when you have ISA defined as well?  I've done a
quick hack patch to make it compile.  I've been running 2.4.21-rc*
lately, so it's time I started to actually test this patch below and
see how it works.  

I read the file Documentation cli-sti-removal.txt and I think I've
done the right things here.

John
   John Stoffel - Senior Unix Systems Administrator - Lucent Technologies
	 stoffel@lucent.com - http://www.lucent.com - 978-399-0479



*** drivers/char/cyclades.c.org Wed May 21 11:45:48 2003
--- drivers/char/cyclades.c     Wed May 21 12:07:53 2003
***************
*** 872,877 ****
--- 872,878 ----
  static int cyz_issue_cmd(struct cyclades_card *, uclong, ucchar,
uclong);
  #ifdef CONFIG_ISA
  static unsigned detect_isa_irq (volatile ucchar *);
+ spinlock_t isa_card_lock;
  #endif /* CONFIG_ISA */
  
  static int cyclades_get_proc_info(char *, char **, off_t , int , int
  *, void *);
***************
*** 1056,1069 ****
      udelay(5000L);
  
      /* Enable the Tx interrupts on the CD1400 */
!     save_flags(flags); cli();
        cy_writeb((u_long)address + (CyCAR<<index), 0);
        cyy_issue_cmd(address, CyCHAN_CTL|CyENB_XMTR, index);
  
        cy_writeb((u_long)address + (CyCAR<<index), 0);
        cy_writeb((u_long)address + (CySRER<<index), 
                cy_readb(address + (CySRER<<index)) | CyTxRdy);
!     restore_flags(flags);
  
      /* Wait ... */
      udelay(5000L);
--- 1057,1070 ----
      udelay(5000L);
  
      /* Enable the Tx interrupts on the CD1400 */
!     spin_lock_irqsave(&isa_card_lock,flags);
        cy_writeb((u_long)address + (CyCAR<<index), 0);
        cyy_issue_cmd(address, CyCHAN_CTL|CyENB_XMTR, index);
  
        cy_writeb((u_long)address + (CyCAR<<index), 0);
        cy_writeb((u_long)address + (CySRER<<index), 
                cy_readb(address + (CySRER<<index)) | CyTxRdy);
!     spin_unlock_irqrestore(&isa_card_lock, flags);
  
      /* Wait ... */
      udelay(5000L);
***************
*** 5762,5768 ****
      }
  #endif /* CONFIG_CYZ_INTR */
  
!     save_flags(flags); cli();
  
      if ((e1 = tty_unregister_driver(&cy_serial_driver)))
              printk("cyc: failed to unregister Cyclades serial
              driver(%d)\n",
--- 5763,5769 ----
      }
  #endif /* CONFIG_CYZ_INTR */
  
!     spin_lock_irqsave(&isa_card_lock, flags);
  
      if ((e1 = tty_unregister_driver(&cy_serial_driver)))
              printk("cyc: failed to unregister Cyclades serial
              driver(%d)\n",
***************
*** 5771,5777 ****
              printk("cyc: failed to unregister Cyclades callout
              driver (%d)\n", 
                e2);
  
!     restore_flags(flags);
  
      for (i = 0; i < NR_CARDS; i++) {
          if (cy_card[i].base_addr != 0) {
--- 5772,5778 ----
              printk("cyc: failed to unregister Cyclades callout
          driver (%d)\n", 
                e2);
  
!     spin_unlock_irqrestore(&isa_card_lock, flags);
  
      for (i = 0; i < NR_CARDS; i++) {
          if (cy_card[i].base_addr != 0) {
