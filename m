Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262128AbVADViT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbVADViT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 16:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbVADVgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 16:36:21 -0500
Received: from mproxy.gmail.com ([216.239.56.244]:27455 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262130AbVADVcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:32:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=dv48eE19KhUx3UrYX2/dOr1ZvSluovcYyMLO5IMePu5WD2tcJQxPTb/miJrLtXVYItM+OHYzwGAgBZqwnlOz17oc10Q5FwnKQgetLtpKjPqGc32S1dOq3t2xsstFUev0LqKZe7Ulwf0fKOpc/WlgKs3Vq5FMiI9rlfwqRlD8V10=
Message-ID: <89245775050104133235a22b8b@mail.gmail.com>
Date: Tue, 4 Jan 2005 15:32:49 -0600
From: Jon Mason <jdmason@gmail.com>
Reply-To: Jon Mason <jdmason@gmail.com>
To: Richard Ems <richard.ems@mtg-marinetechnik.de>
Subject: Re: PROBLEM: Network hang: "eth0: Tx timed out (f0080), is buffer full?"
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
In-Reply-To: <41D2EF1F.2020400@mtg-marinetechnik.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_603_31327238.1104874369690"
References: <200412171100.16601.richard.ems@mtg-marinetechnik.de>
	 <41C6E2E1.8030801@mtg-marinetechnik.de>
	 <8924577504122009126c40c1fe@mail.gmail.com>
	 <41C713EF.8050003@mtg-marinetechnik.de>
	 <892457750412201231461415a1@mail.gmail.com>
	 <41C7F204.3030503@mtg-marinetechnik.de>
	 <89245775041221080238187402@mail.gmail.com>
	 <41C93E93.5070704@mtg-marinetechnik.de>
	 <892457750412220654918c785@mail.gmail.com>
	 <41D2EF1F.2020400@mtg-marinetechnik.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_603_31327238.1104874369690
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Richard,
Sorry for the long delay in responding.  I have found an error in the
patch I sent you, and I think I missed something.  The error was a
function defined twice.  The erro was lack of cleanup of the tx and rx
queues are the adapter reset.  The patch below (and attached) should
fix both of these errors.  Please apply it to the original driver.

Thanks,
Jon

--- dl2k.c,orig-save-2004.12.20 2004-12-21 09:43:19.000000000 -0600
+++ dl2k.c      2005-01-04 15:26:57.162033944 -0600
@@ -429,23 +429,16 @@ parse_eeprom (struct net_device *dev)
        return 0;
 }

-static int
-rio_open (struct net_device *dev)
+static void
+rio_up (struct net_device *dev)
 {
-       struct netdev_private *np = dev->priv;
+       struct netdev_private *np = netdev_priv(dev);
        long ioaddr = dev->base_addr;
        int i;
        u16 macctrl;

-       i = request_irq (dev->irq, &rio_interrupt, SA_SHIRQ, dev->name, dev);
-       if (i)
-               return i;
-
-       /* Reset all logic functions */
-       writew (GlobalReset | DMAReset | FIFOReset | NetworkReset | HostReset,
-               ioaddr + ASICCtrl + 2);
-       mdelay(10);
-
+       alloc_list (dev);
+
        /* DebugCtrl bit 4, 5, 9 must set */
        writel (readl (ioaddr + DebugCtrl) | 0x0230, ioaddr + DebugCtrl);

@@ -453,8 +446,6 @@ rio_open (struct net_device *dev)
        if (np->jumbo != 0)
                writew (MAX_JUMBO+14, ioaddr + MaxFrameSize);

-       alloc_list (dev);
-
        /* Get station address */
        for (i = 0; i < 6; i++)
                writeb (dev->dev_addr[i], ioaddr + StationAddr0 + i);
@@ -488,12 +479,6 @@ rio_open (struct net_device *dev)
                        ioaddr + MACCtrl);
        }

-       init_timer (&np->timer);
-       np->timer.expires = jiffies + 1*HZ;
-       np->timer.data = (unsigned long) dev;
-       np->timer.function = &rio_timer;
-       add_timer (&np->timer);
-
        /* Start Tx/Rx */
        writel (readl (ioaddr + MACCtrl) | StatsEnable | RxEnable | TxEnable,
                        ioaddr + MACCtrl);
@@ -505,10 +490,36 @@ rio_open (struct net_device *dev)
        macctrl |= (np->rx_flow) ? RxFlowControlEnable : 0;
        writew(macctrl, ioaddr + MACCtrl);

-       netif_start_queue (dev);
-
        /* Enable default interrupts */
        EnableInt ();
+}
+
+static int
+rio_open (struct net_device *dev)
+{
+       struct netdev_private *np = netdev_priv(dev);
+       long ioaddr = dev->base_addr;
+       int i;
+
+       i = request_irq (dev->irq, &rio_interrupt, SA_SHIRQ, dev->name, dev);
+       if (i)
+               return i;
+
+       /* Reset all logic functions */
+       writew (GlobalReset | DMAReset | FIFOReset | NetworkReset | HostReset,
+               ioaddr + ASICCtrl + 2);
+       mdelay(10);
+
+       rio_up (dev);
+
+       init_timer (&np->timer);
+       np->timer.expires = jiffies + 1*HZ;
+       np->timer.data = (unsigned long) dev;
+       np->timer.function = &rio_timer;
+       add_timer (&np->timer);
+
+       netif_start_queue (dev);
+
        return 0;
 }

@@ -562,9 +573,11 @@ static void
 rio_tx_timeout (struct net_device *dev)
 {
        long ioaddr = dev->base_addr;
+       struct netdev_private *np = dev->priv;

-       printk (KERN_INFO "%s: Tx timed out (%4.4x), is buffer full?\n",
-               dev->name, readl (ioaddr + TxStatus));
+       printk (KERN_INFO "%s: Tx timed out (%4.4x) %d %d %x %x\n",
+               dev->name, readl (ioaddr + TxStatus), np->cur_tx, np->cur_rx,
+               readl (ioaddr + MACCtrl), readw(ioaddr + IntEnable));
        rio_free_tx(dev, 0);
        dev->if_port = 0;
        dev->trans_start = jiffies;
@@ -1005,10 +1018,36 @@ rio_error (struct net_device *dev, int i
        /* PCI Error, a catastronphic error related to the bus interface
           occurs, set GlobalReset and HostReset to reset. */
        if (int_status & HostError) {
-               printk (KERN_ERR "%s: HostError! IntStatus %4.4x.\n",
-                       dev->name, int_status);
+               printk (KERN_ERR "%s: HostError! IntStatus %4.4x. %d
%d %x %x\n",
+                       dev->name, int_status, np->cur_tx, np->cur_rx,
+                       readl (ioaddr + MACCtrl), readw(ioaddr + IntEnable));
                writew (GlobalReset | HostReset, ioaddr + ASICCtrl + 2);
+
+               /* Free all the skbuffs in the queue. */
+               for (i = 0; i < RX_RING_SIZE; i++) {
+                       np->rx_ring[i].status = 0;
+                       np->rx_ring[i].fraginfo = 0;
+                       skb = np->rx_skbuff[i];
+                       if (skb) {
+                               pci_unmap_single (np->pdev,
np->rx_ring[i].fraginfo,
+                                                 skb->len, PCI_DMA_FROMDEVICE);
+                               dev_kfree_skb (skb);
+                               np->rx_skbuff[i] = NULL;
+                       }
+               }
+               for (i = 0; i < TX_RING_SIZE; i++) {
+                       skb = np->tx_skbuff[i];
+                       if (skb) {
+                               pci_unmap_single (np->pdev,
np->tx_ring[i].fraginfo,
+                                                 skb->len, PCI_DMA_TODEVICE);
+                               dev_kfree_skb (skb);
+                               np->tx_skbuff[i] = NULL;
+                       }
+               }
+
                mdelay (500);
+
+               rio_up(dev);
        }
 }

------=_Part_603_31327238.1104874369690
Content-Type: application/octet-stream; name="dl2k.patch3"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dl2k.patch3"

LS0tIGRsMmsuYyxvcmlnLXNhdmUtMjAwNC4xMi4yMAkyMDA0LTEyLTIxIDA5OjQzOjE5LjAwMDAw
MDAwMCAtMDYwMAorKysgZGwyay5jCTIwMDUtMDEtMDQgMTU6MjY6NTcuMTYyMDMzOTQ0IC0wNjAw
CkBAIC00MjksMjMgKzQyOSwxNiBAQCBwYXJzZV9lZXByb20gKHN0cnVjdCBuZXRfZGV2aWNlICpk
ZXYpCiAJcmV0dXJuIDA7CiB9CiAKLXN0YXRpYyBpbnQKLXJpb19vcGVuIChzdHJ1Y3QgbmV0X2Rl
dmljZSAqZGV2KQorc3RhdGljIHZvaWQKK3Jpb191cCAoc3RydWN0IG5ldF9kZXZpY2UgKmRldikK
IHsKLQlzdHJ1Y3QgbmV0ZGV2X3ByaXZhdGUgKm5wID0gZGV2LT5wcml2OworCXN0cnVjdCBuZXRk
ZXZfcHJpdmF0ZSAqbnAgPSBuZXRkZXZfcHJpdihkZXYpOwogCWxvbmcgaW9hZGRyID0gZGV2LT5i
YXNlX2FkZHI7CiAJaW50IGk7CiAJdTE2IG1hY2N0cmw7CiAJCi0JaSA9IHJlcXVlc3RfaXJxIChk
ZXYtPmlycSwgJnJpb19pbnRlcnJ1cHQsIFNBX1NISVJRLCBkZXYtPm5hbWUsIGRldik7Ci0JaWYg
KGkpCi0JCXJldHVybiBpOwotCQotCS8qIFJlc2V0IGFsbCBsb2dpYyBmdW5jdGlvbnMgKi8KLQl3
cml0ZXcgKEdsb2JhbFJlc2V0IHwgRE1BUmVzZXQgfCBGSUZPUmVzZXQgfCBOZXR3b3JrUmVzZXQg
fCBIb3N0UmVzZXQsCi0JCWlvYWRkciArIEFTSUNDdHJsICsgMik7Ci0JbWRlbGF5KDEwKTsKLQkK
KwlhbGxvY19saXN0IChkZXYpOworCiAJLyogRGVidWdDdHJsIGJpdCA0LCA1LCA5IG11c3Qgc2V0
ICovCiAJd3JpdGVsIChyZWFkbCAoaW9hZGRyICsgRGVidWdDdHJsKSB8IDB4MDIzMCwgaW9hZGRy
ICsgRGVidWdDdHJsKTsKIApAQCAtNDUzLDggKzQ0Niw2IEBAIHJpb19vcGVuIChzdHJ1Y3QgbmV0
X2RldmljZSAqZGV2KQogCWlmIChucC0+anVtYm8gIT0gMCkKIAkJd3JpdGV3IChNQVhfSlVNQk8r
MTQsIGlvYWRkciArIE1heEZyYW1lU2l6ZSk7CiAKLQlhbGxvY19saXN0IChkZXYpOwotCiAJLyog
R2V0IHN0YXRpb24gYWRkcmVzcyAqLwogCWZvciAoaSA9IDA7IGkgPCA2OyBpKyspCiAJCXdyaXRl
YiAoZGV2LT5kZXZfYWRkcltpXSwgaW9hZGRyICsgU3RhdGlvbkFkZHIwICsgaSk7CkBAIC00ODgs
MTIgKzQ3OSw2IEBAIHJpb19vcGVuIChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQogCQkJaW9hZGRy
ICsgTUFDQ3RybCk7CiAJfQogCi0JaW5pdF90aW1lciAoJm5wLT50aW1lcik7Ci0JbnAtPnRpbWVy
LmV4cGlyZXMgPSBqaWZmaWVzICsgMSpIWjsKLQlucC0+dGltZXIuZGF0YSA9ICh1bnNpZ25lZCBs
b25nKSBkZXY7Ci0JbnAtPnRpbWVyLmZ1bmN0aW9uID0gJnJpb190aW1lcjsKLQlhZGRfdGltZXIg
KCZucC0+dGltZXIpOwotCiAJLyogU3RhcnQgVHgvUnggKi8KIAl3cml0ZWwgKHJlYWRsIChpb2Fk
ZHIgKyBNQUNDdHJsKSB8IFN0YXRzRW5hYmxlIHwgUnhFbmFibGUgfCBUeEVuYWJsZSwgCiAJCQlp
b2FkZHIgKyBNQUNDdHJsKTsKQEAgLTUwNSwxMCArNDkwLDM2IEBAIHJpb19vcGVuIChzdHJ1Y3Qg
bmV0X2RldmljZSAqZGV2KQogCW1hY2N0cmwgfD0gKG5wLT5yeF9mbG93KSA/IFJ4Rmxvd0NvbnRy
b2xFbmFibGUgOiAwOwogCXdyaXRldyhtYWNjdHJsLAlpb2FkZHIgKyBNQUNDdHJsKTsKIAotCW5l
dGlmX3N0YXJ0X3F1ZXVlIChkZXYpOwotCQogCS8qIEVuYWJsZSBkZWZhdWx0IGludGVycnVwdHMg
Ki8KIAlFbmFibGVJbnQgKCk7Cit9CisKK3N0YXRpYyBpbnQKK3Jpb19vcGVuIChzdHJ1Y3QgbmV0
X2RldmljZSAqZGV2KQoreworCXN0cnVjdCBuZXRkZXZfcHJpdmF0ZSAqbnAgPSBuZXRkZXZfcHJp
dihkZXYpOworCWxvbmcgaW9hZGRyID0gZGV2LT5iYXNlX2FkZHI7CisJaW50IGk7CisJCisJaSA9
IHJlcXVlc3RfaXJxIChkZXYtPmlycSwgJnJpb19pbnRlcnJ1cHQsIFNBX1NISVJRLCBkZXYtPm5h
bWUsIGRldik7CisJaWYgKGkpCisJCXJldHVybiBpOworCQorCS8qIFJlc2V0IGFsbCBsb2dpYyBm
dW5jdGlvbnMgKi8KKwl3cml0ZXcgKEdsb2JhbFJlc2V0IHwgRE1BUmVzZXQgfCBGSUZPUmVzZXQg
fCBOZXR3b3JrUmVzZXQgfCBIb3N0UmVzZXQsCisJCWlvYWRkciArIEFTSUNDdHJsICsgMik7CisJ
bWRlbGF5KDEwKTsKKwkKKwlyaW9fdXAgKGRldik7CisJCisJaW5pdF90aW1lciAoJm5wLT50aW1l
cik7CisJbnAtPnRpbWVyLmV4cGlyZXMgPSBqaWZmaWVzICsgMSpIWjsKKwlucC0+dGltZXIuZGF0
YSA9ICh1bnNpZ25lZCBsb25nKSBkZXY7CisJbnAtPnRpbWVyLmZ1bmN0aW9uID0gJnJpb190aW1l
cjsKKwlhZGRfdGltZXIgKCZucC0+dGltZXIpOworCisJbmV0aWZfc3RhcnRfcXVldWUgKGRldik7
CisJCiAJcmV0dXJuIDA7CiB9CiAKQEAgLTU2Miw5ICs1NzMsMTEgQEAgc3RhdGljIHZvaWQKIHJp
b190eF90aW1lb3V0IChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQogewogCWxvbmcgaW9hZGRyID0g
ZGV2LT5iYXNlX2FkZHI7CisJc3RydWN0IG5ldGRldl9wcml2YXRlICpucCA9IGRldi0+cHJpdjsK
IAotCXByaW50ayAoS0VSTl9JTkZPICIlczogVHggdGltZWQgb3V0ICglNC40eCksIGlzIGJ1ZmZl
ciBmdWxsP1xuIiwKLQkJZGV2LT5uYW1lLCByZWFkbCAoaW9hZGRyICsgVHhTdGF0dXMpKTsKKwlw
cmludGsgKEtFUk5fSU5GTyAiJXM6IFR4IHRpbWVkIG91dCAoJTQuNHgpICVkICVkICV4ICV4XG4i
LAorCQlkZXYtPm5hbWUsIHJlYWRsIChpb2FkZHIgKyBUeFN0YXR1cyksIG5wLT5jdXJfdHgsIG5w
LT5jdXJfcngsCisJCXJlYWRsIChpb2FkZHIgKyBNQUNDdHJsKSwgcmVhZHcoaW9hZGRyICsgSW50
RW5hYmxlKSk7CiAJcmlvX2ZyZWVfdHgoZGV2LCAwKTsKIAlkZXYtPmlmX3BvcnQgPSAwOwogCWRl
di0+dHJhbnNfc3RhcnQgPSBqaWZmaWVzOwpAQCAtMTAwNSwxMCArMTAxOCwzNiBAQCByaW9fZXJy
b3IgKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIGludCBpCiAJLyogUENJIEVycm9yLCBhIGNhdGFz
dHJvbnBoaWMgZXJyb3IgcmVsYXRlZCB0byB0aGUgYnVzIGludGVyZmFjZSAKIAkgICBvY2N1cnMs
IHNldCBHbG9iYWxSZXNldCBhbmQgSG9zdFJlc2V0IHRvIHJlc2V0LiAqLwogCWlmIChpbnRfc3Rh
dHVzICYgSG9zdEVycm9yKSB7Ci0JCXByaW50ayAoS0VSTl9FUlIgIiVzOiBIb3N0RXJyb3IhIElu
dFN0YXR1cyAlNC40eC5cbiIsCi0JCQlkZXYtPm5hbWUsIGludF9zdGF0dXMpOworCQlwcmludGsg
KEtFUk5fRVJSICIlczogSG9zdEVycm9yISBJbnRTdGF0dXMgJTQuNHguICVkICVkICV4ICV4XG4i
LAorCQkJZGV2LT5uYW1lLCBpbnRfc3RhdHVzLCBucC0+Y3VyX3R4LCBucC0+Y3VyX3J4LAorCQkJ
cmVhZGwgKGlvYWRkciArIE1BQ0N0cmwpLCByZWFkdyhpb2FkZHIgKyBJbnRFbmFibGUpKTsKIAkJ
d3JpdGV3IChHbG9iYWxSZXNldCB8IEhvc3RSZXNldCwgaW9hZGRyICsgQVNJQ0N0cmwgKyAyKTsK
KwkJCisJCS8qIEZyZWUgYWxsIHRoZSBza2J1ZmZzIGluIHRoZSBxdWV1ZS4gKi8KKwkJZm9yIChp
ID0gMDsgaSA8IFJYX1JJTkdfU0laRTsgaSsrKSB7CisJCQlucC0+cnhfcmluZ1tpXS5zdGF0dXMg
PSAwOworCQkJbnAtPnJ4X3JpbmdbaV0uZnJhZ2luZm8gPSAwOworCQkJc2tiID0gbnAtPnJ4X3Nr
YnVmZltpXTsKKwkJCWlmIChza2IpIHsKKwkJCQlwY2lfdW5tYXBfc2luZ2xlIChucC0+cGRldiwg
bnAtPnJ4X3JpbmdbaV0uZnJhZ2luZm8sCisJCQkJCQkgIHNrYi0+bGVuLCBQQ0lfRE1BX0ZST01E
RVZJQ0UpOworCQkJCWRldl9rZnJlZV9za2IgKHNrYik7CisJCQkJbnAtPnJ4X3NrYnVmZltpXSA9
IE5VTEw7CisJCQl9CisJCX0KKwkJZm9yIChpID0gMDsgaSA8IFRYX1JJTkdfU0laRTsgaSsrKSB7
CisJCQlza2IgPSBucC0+dHhfc2tidWZmW2ldOworCQkJaWYgKHNrYikgeworCQkJCXBjaV91bm1h
cF9zaW5nbGUgKG5wLT5wZGV2LCBucC0+dHhfcmluZ1tpXS5mcmFnaW5mbywKKwkJCQkJCSAgc2ti
LT5sZW4sIFBDSV9ETUFfVE9ERVZJQ0UpOworCQkJCWRldl9rZnJlZV9za2IgKHNrYik7CisJCQkJ
bnAtPnR4X3NrYnVmZltpXSA9IE5VTEw7CisJCQl9CisJCX0KKwogCQltZGVsYXkgKDUwMCk7CisK
KwkJcmlvX3VwKGRldik7CiAJfQogfQogCg==
------=_Part_603_31327238.1104874369690--
