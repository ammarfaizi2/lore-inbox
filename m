Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268022AbRGZOvt>; Thu, 26 Jul 2001 10:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268020AbRGZOva>; Thu, 26 Jul 2001 10:51:30 -0400
Received: from finch-post-12.mail.demon.net ([194.217.242.41]:33034 "EHLO
	finch-post-12.mail.demon.net") by vger.kernel.org with ESMTP
	id <S268015AbRGZOv2>; Thu, 26 Jul 2001 10:51:28 -0400
Date: Thu, 26 Jul 2001 15:51:23 +0100
From: "Robert J.Dunlop" <rjd@xyzzy.clara.co.uk>
To: =?iso-8859-1?Q?Fran=E7ois_romieu?= <romieu@zoreil.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: FarSync T-Series tweak and question
Message-ID: <20010726155123.A5815@xyzzy.clara.co.uk>
In-Reply-To: <20010703182803.A13853@xyzzy.clara.co.uk> <20010704161845.A27070@zoreil.com> <20010709161947.B15379@xyzzy.clara.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010709161947.B15379@xyzzy.clara.co.uk>; from rjd@xyzzy.clara.co.uk on Mon, Jul 09, 2001 at 04:27:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

Having thought about it a while I've decided that I agree with
François romieu's comment.

> * error_1, error_2... error_n labels are ugly;

Should have done it earlier but I've now cleaned up my code.
Alan could you please apply the patch at the end of this mail.


Second I have a question.  We had a bit of debate about how best to code
the bumping and wrapping of an index into a circular buffer.

> > +        if ( ++port->txpos >= NUM_TX_BUFFER )
> > +                port->txpos = 0;
> > 
> > Why not:
> > port->txpos++;
> > foo = port->txpos%NUM_TX_BUFFER;
> I think mine is clearer but then I've always bumped and wrapped pointers and
> indexs that way. Another alternative would be:
>     port->txpos = ( port->txpos + 1 ) % NUM_TX_BUFFER;

Having taken the time that the % operation wouldn't be detrimental on other
processor architectures and having checked with a small test that the alternate
form produced tighter code on Intel I applied the change to my driver.  The
code that had shrunk in a small test got bigger (and slower?) in the driver :-(
I think what happened is that register usage changed and something else had
to be fetched from the stack.  I've decided for the moment not to adopt this
change on the grounds that if it ain't broke don't patch it.

Now the question. Is there a sensible way of coding this so that as the
compilers get better we give them the maximum number of clues as to what we
are actually trying to do?



--- linux/drivers/net/wan/farsync.c.orig	Wed Jul 25 07:42:28 2001
+++ linux/drivers/net/wan/farsync.c	Wed Jul 25 09:24:01 2001
@@ -1689,28 +1689,28 @@
                 printk_err ("Unable to get config I/O @ 0x%04X\n",
                                                 card->pci_conf );
                 err = -ENODEV;
-                goto error_1;
+                goto error_free_card;
         }
         if ( ! request_mem_region ( card->phys_mem, FST_MEMSIZE,"Shared RAM"))
         {
                 printk_err ("Unable to get main memory @ 0x%08X\n",
                                                 card->phys_mem );
                 err = -ENODEV;
-                goto error_2;
+                goto error_release_io;
         }
         if ( ! request_mem_region ( card->phys_ctlmem, 0x10,"Control memory"))
         {
                 printk_err ("Unable to get control memory @ 0x%08X\n",
                                                 card->phys_ctlmem );
                 err = -ENODEV;
-                goto error_3;
+                goto error_release_mem;
         }
 
         /* Try to enable the device */
         if (( err = pci_enable_device ( pdev )) != 0 )
         {
                 printk_err ("Failed to enable card. Err %d\n", -err );
-                goto error_4;
+                goto error_release_ctlmem;
         }
 
         /* Get virtual addresses of memory regions */
@@ -1718,13 +1718,13 @@
         {
                 printk_err ("Physical memory remap failed\n");
                 err = -ENODEV;
-                goto error_4;
+                goto error_release_ctlmem;
         }
         if (( card->ctlmem = ioremap ( card->phys_ctlmem, 0x10 )) == NULL )
         {
                 printk_err ("Control memory remap failed\n");
                 err = -ENODEV;
-                goto error_5;
+                goto error_unmap_mem;
         }
         dbg ( DBG_PCI,"kernel mem %p, ctlmem %p\n", card->mem, card->ctlmem);
 
@@ -1738,7 +1738,7 @@
 
                 printk_err ("Unable to register interrupt %d\n", card->irq );
                 err = -ENODEV;
-                goto error_6;
+                goto error_unmap_ctlmem;
         }
 
         /* Record driver data for later use */
@@ -1751,17 +1751,22 @@
 
 
                                         /* Failure. Release resources */
-error_6:
+error_unmap_ctlmem:
         iounmap ( card->ctlmem );
-error_5:
+
+error_unmap_mem:
         iounmap ( card->mem );
-error_4:
+
+error_release_ctlmem:
         release_mem_region ( card->phys_ctlmem, 0x10 );
-error_3:
+
+error_release_mem:
         release_mem_region ( card->phys_mem, FST_MEMSIZE );
-error_2:
+
+error_release_io:
         release_region ( card->pci_conf, 0x80 );
-error_1:
+
+error_free_card:
         kfree ( card );
         return err;
 }

-- 
        Bob Dunlop                      FarSite Communications
        rjd@xyzzy.clara.co.uk           bob.dunlop@farsite.co.uk
        www.xyzzy.clara.co.uk           www.farsite.co.uk
